 
import editIcon from '../Assets/edit.svg'
 
const StudentCard = ({ title, logoSrc, bodyText, setmodal, setModalStudent }) => {

    const cardStyle = {
        backgroundColor: '#372E4C',
        borderRadius: '10px',
        padding: '20px',
        color: '#fff',

        width: '250px',
    };
    const btnClick = () => {
        setModalStudent();
        setmodal(1);
    };

    return (
        <div className="card" style={cardStyle}>
            <div id='CardTitle'>
                {logoSrc && <img src={logoSrc} alt="Logo" />}
                {title && <h2 className="ellipsis">{title}</h2>}
                <div className="spacer"></div>
                <div id='btn-bg'><button onClick={() => btnClick()} id='delbutton' ><img width={20} src={editIcon} /></button></div>

            </div>

            <div id='cardBody'>{bodyText && <p>{bodyText}</p>}</div>
        </div>
    );
};

export default StudentCard;