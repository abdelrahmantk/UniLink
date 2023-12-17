 
import editIcon from '../Assets/edit.svg'
import deleteIcon from '../Assets/delete.svg'
const StudentCard = ({ title, logoSrc, bodyText, setmodal, setModalStudent,setDelModal }) => {

    const cardStyle = {
        backgroundColor: '#372E4C',
        borderRadius: '10px',
        padding: '20px',
        color: '#fff',
 
    };
    const btnClick = () => {
        setModalStudent();
        setmodal(1);
    };
    const btnClick2 = () => {
        setModalStudent();
        setDelModal(1);
        console.log('s')
    };

    return (
        <div className="card" style={cardStyle}>
            <div id='CardTitle'>
                {logoSrc && <img src={logoSrc} alt="Logo" />}
                {title && <h2 className="ellipsis">{title}</h2>}
                <div className="spacer"></div>
                <div id='btn-bg'><button onClick={() => btnClick()} id='delbutton' ><img width={20} src={editIcon} /></button></div>
                <div id='btn-bg'><button onClick={() => btnClick2()} id='delbutton' ><img width={20} src={deleteIcon} /></button></div>
            </div>

            <div id='cardBody'>{bodyText && <p>{bodyText}</p>}</div>
        </div>
    );
};

export default StudentCard;