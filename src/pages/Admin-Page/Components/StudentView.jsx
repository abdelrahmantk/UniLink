import studentIcon from '../Assets/student.svg'
import { useEffect, useState } from 'react'
import axios from 'axios'
import StudentCard from './StudentCards'
const Students = ({ loadingStudentData, setLoadingStudentData, setmodal, setModalStudent, update, setWarningOn, setWarningText }) => {
    const [data, setData] = useState([])
    const [searchInput, setSearchInput] = useState('');
    const [filteredStudents, setFilteredStudents] = useState([]);


    useEffect(() => {
        const fetchData = async () => {
            try {
                setLoadingStudentData(true);
                const response = await axios.get('http://localhost:3000/api/get-students', {
                    headers: {
                        'Access-Control-Allow-Origin': '*',

                    }

                });

                setData(response.data);
                setFilteredStudents(response.data);
                setLoadingStudentData(false);
            } catch (error) {
                setWarningOn(0)
                setWarningOn(1)
                setWarningText("Error Fetching data!");
                console.error('Error fetching data:', error);
                setLoadingStudentData(false);
            }
        };

        fetchData();
    }, [update]);
    const handleSearch = (searchValue) => {
        setSearchInput(searchValue);
        const filtered = data.filter((student) => {
            const fullName = `${student.Fname} ${student.Lname}`;
            return fullName.toLowerCase().includes(searchValue.toLowerCase());
        });
        setFilteredStudents(filtered);
    };
    const [loadingText, setLoadingText] = useState('Loading Data');

    useEffect(() => {
        let dotCount = 0;
        const interval = setInterval(() => {
            dotCount = (dotCount + 1) % 4;
            setLoadingText('Loading Data' + '.'.repeat(dotCount));
        }, 500);

        return () => clearInterval(interval);
    }, []);
    return (
        <>

            <div id='MainTitle'>
                <h5 id='PurpleText'>Table view</h5>
                <div id='WhiteTitle'><h2 id='BiggerTextInWhite' >Students&nbsp;</h2><h5 id='SmallerTextInWhite'>(Admin View)</h5></div>
                <hr id='MainLine'></hr>

            </div>
            <input type="text"
                className="custom-textbox"
                placeholder="Search for a student..."
                value={searchInput}
                onChange={(e) => handleSearch(e.target.value)} />
            {loadingStudentData ?
                <div id='loadingHolder'><p id='loading'>{loadingText}</p></div> :
                <div className="grid-container">
                    <div className="grid">
                        {filteredStudents.map((student, index) => (
                            <StudentCard
                                setmodal={setmodal}
                                setModalStudent={() => setModalStudent(student)}
                                key={index}
                                title={`${student.Fname} ${student.Lname}`}
                                logoSrc={studentIcon}
                                bodyText={`Student ID: ${student.Student_id}\nGPA: ${student.GPA}\nCredits: ${student.Credits}`}
                            />
                        ))}
                    </div>
                </div>
            }

        </>
    )
}
export default Students