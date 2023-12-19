import Students from "./Components/StudentView";
import Issues from "./Components/IssuesView";
import Tables from "./Components/TablesView";
import studentIcon from './Assets/student.svg'
import tableIcon from './Assets/table.svg'
import issueIcon from './Assets/issue.svg'
import warningIcon from './Assets/warning.svg'
import logoutIcon from './Assets/logout.svg'
import { useEffect, useState } from 'react'
import axios from 'axios'
import './AdminPage.css';
 
function AdminPage() {
  const [menu, setMenu] = useState(0);
  const [modalOn, setModalOn] = useState(0);
  const [warningOn, setWarningOn] = useState(0);
  const [warningText, setWarningText] = useState("");
  const [modalStudent, setModalStudent] = useState({});
  const [update, setUpdate] = useState(true);
  const [loadingStudentData, setLoadingStudentData] = useState(true);
  const [warningTimeout, setWarningTimeout] = useState(null);
 const [delModal, setDelModal] = useState(0);
 const [addModal, setAddModal] = useState(0);


 const insertStudent = async()=>{
  function isStringEmpty(input) {
    return !input || input.trim() === '';
  }
  if (isStringEmpty(modalStudent.Fname) || isStringEmpty(modalStudent.Lname)) {

    handleNewWarning("A student cannot have a blank name!")


    return;
  }
  function isStringOnlyAlphabetic(input) {
    return /^[a-zA-Z]+$/.test(input);
  }
  if (!isStringOnlyAlphabetic(modalStudent.Fname) || !isStringOnlyAlphabetic(modalStudent.Lname)) {


    handleNewWarning("Name should contain only alphabetic characters!")

    return;
  }
  try {
    await axios.post('http://localhost:3000/api/insert-student', { fname: modalStudent.Fname, lname: modalStudent.Lname })
  }
  catch (error) {
    console.error('Error inserting data:', error);
    handleNewWarning("Inserting Student Failed!")
  }
  setAddModal(0);
  setUpdate(!update)
 }
  useEffect(() => {
    let timer;
    if (warningOn === 1) {
      timer = setTimeout(() => {
        setWarningOn(0);  
        setWarningText('');
      }, 5000);
    }

    return () => {
      if (timer) {
        clearTimeout(timer);
      }
    };
  }, [warningText]);


  const handleNewWarning = (text) => {
    setWarningText(text);


    if (warningTimeout) {
      clearTimeout(warningTimeout);
    }

 
    setWarningOn(1);
  };
  const handleSave = async () => {
    function isStringEmpty(input) {
      return !input || input.trim() === '';
    }
    if (isStringEmpty(modalStudent.Fname) || isStringEmpty(modalStudent.Lname)) {

      handleNewWarning("A student cannot have a blank name!")


      return;
    }
    function isStringOnlyAlphabetic(input) {
      return /^[a-zA-Z]+$/.test(input);
    }
    if (!isStringOnlyAlphabetic(modalStudent.Fname) || !isStringOnlyAlphabetic(modalStudent.Lname)) {


      handleNewWarning("Name should contain only alphabetic characters!")

      return;
    }
    try {
      const response = await axios.put('http://localhost:3000/api/update-student', { fname: modalStudent.Fname, lname: modalStudent.Lname, student_id: modalStudent.Student_id })
    }
    catch (error) {
      console.error('Error Updating data:', error);
      handleNewWarning("Updating data Failed!")


    }
    setModalOn(0);
    setUpdate(!update)
  };
  // 0 -> students
  // 1 -> issues
  // 2 -> tables
 const handleDel = async()=>{
  try {
    const response = await axios.delete('http://localhost:3000/api/delete-student', {
      data: { student_id: modalStudent.Student_id } 
    });
  
  } catch (error) {
    console.error('Error Deleting data:', error);
    handleNewWarning("Deleting Student Failed!");
  }
  setDelModal(0);
  setUpdate(!update)
 }
  return (
    <>
      <img style={{ display: "none" }} src={warningIcon} />
      {delModal == 1 ?
        <div id="Modal">
          <div className="modal-content">
            <div id='modal-title'>
              <h2 id='Modaltexttitle'>Are you sure you want to remove this student ?</h2>
              <span className="close" onClick={() => setDelModal(0)}>&times;</span>
            </div>
            <div id="delNameCenter">{modalStudent.Fname} {modalStudent.Lname}</div>
            <div id='savebtn'>
              <button className='btn' onClick={() => handleDel()}>Yes</button>
            </div>
          </div>
        </div> : <></>}
      {warningOn == 1 ? <div key={warningText} id='warning'>
        <div id='lineDiv'>
          <div id='warningContent'>
            <div id='errTitle'>
              <img src={warningIcon} />
              <p id='errText'>Error : {warningText}  </p>
            </div>
            <div className="spacer"></div>
            <span id="warningClose" onClick={() => {
              setWarningOn(0);
              setWarningText('');
            }} >&times;</span>

          </div>
          <div className="spacer"></div>
          <hr id='errLine'></hr>
        </div>
      </div> : <></>}
      {modalOn == 1 ?
        <div id="Modal">
          <div className="modal-content">
            <div id='modal-title'>
              <h2 id='Modaltexttitle'>Edit Student</h2>
              <span className="close" onClick={() => setModalOn(0)}>&times;</span>
            </div>
            <div className='duo'>
              <label>First Name:  </label>
              <input
                type="text"
                name="Fname"
                value={modalStudent.Fname}
                className='input-class'
                onChange={(event) => { setModalStudent({ ...modalStudent, Fname: event.target.value }); }}
              />
            </div>
            <div className='duo'>
              <label >Last Name: </label>
              <input
                type="text"
                name="Lname"
                value={modalStudent.Lname}
                className='input-class'
                onChange={(event) => setModalStudent({ ...modalStudent, Lname: event.target.value })}
              />
            </div>
            <div id='savebtn'>
              <button className='btn' onClick={() => handleSave()}>Save Changes</button>
            </div>
          </div>
        </div> : <></>}

        {addModal == 1 ?
        <div id="Modal">
          <div className="modal-content">
            <div id='modal-title'>
              <h2 id='Modaltexttitle'>Add Student</h2>
              <span className="close" onClick={() => setAddModal(0)}>&times;</span>
            </div>
            <div className='duo'>
              <label>First Name:  </label>
              <input
                type="text"
                name="Fname"
                value={modalStudent.Fname}
                className='input-class'
                onChange={(event) => { setModalStudent({ ...modalStudent, Fname: event.target.value }); }}
              />
            </div>
            <div className='duo'>
              <label >Last Name: </label>
              <input
                type="text"
                name="Lname"
                value={modalStudent.Lname}
                className='input-class'
                onChange={(event) => setModalStudent({ ...modalStudent, Lname: event.target.value })}
              />
            </div>
            <div id='savebtn'>
              <button className='btn' onClick={() => insertStudent()}>Save Student</button>
            </div>
          </div>
        </div> : <></>}
      {/*  Main container -> 2 cols -> side, main */}
      <div className="container">
        {/* Sidebar */}
        <aside className='sidebar'>
          <div id='SidebarTitle'>
            <h2>Unilink<br />Admin Dashboard</h2>
          </div>
          <hr id='line'></hr>
          <div className={menu == 0 ? "SidebarContent HighlightedMenu" : "SidebarContent"} onClick={() => setMenu(0)}>
            <img width="20" height="24" src={studentIcon}></img>
            <h4>Students</h4>
          </div>
          <div className={menu == 1 ? "SidebarContent HighlightedMenu" : "SidebarContent"} onClick={() => setMenu(1)}>
            <img width="20" height="24" src={issueIcon}></img>
            <h4>Student Issues</h4>
          </div>
          <div className={menu == 2 ? "SidebarContent HighlightedMenu" : "SidebarContent"} onClick={() => setMenu(2)}>
            <img width="20" height="24" src={tableIcon}></img>
            <h4>Tables</h4>
          </div>
          <div className="spacer"></div>
          <div className='logout' onClick={() => setMenu(2)}>
            <img width="20" height="24" src={logoutIcon}></img>
            <h4>Log out</h4>
          </div>
        </aside>
        {/* Main content */}
        <main className="main-content">
          {menu == 0 ?
            <Students setAddModal={setAddModal} setDelModal={setDelModal} loadingStudentData={loadingStudentData} setLoadingStudentData={setLoadingStudentData} setWarningOn={setWarningOn} setWarningText={setWarningText} setmodal={setModalOn} setModalStudent={setModalStudent} update={update}></Students> : <></>
          }
          {menu == 1 ?
            <Issues></Issues> : <></>
          }
          {menu == 2 ?
            <Tables></Tables> : <></>
          }
        </main>
      </div>
    </>
  );
}
export default AdminPage;