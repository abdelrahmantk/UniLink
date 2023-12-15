import React, { useState } from 'react';

const Modal = ({ student, onClose, onSave }) => {
  const [editedStudent, setEditedStudent] = useState({ ...student });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setEditedStudent((prevStudent) => ({
      ...prevStudent,
      [name]: value,
    }));
  };

  const handleSave = () => {
    onSave(editedStudent);
  };

  return (
    <div className="modal">
      <div className="modal-content">
        <span className="close" onClick={onClose}>&times;</span>
        <h2>Edit Student</h2>
        <div>
          <label>First Name:</label>
          <input
            type="text"
            name="Fname"
            value={editedStudent.Fname}
            onChange={handleInputChange}
          />
        </div>
        <div>
          <label>Last Name:</label>
          <input
            type="text"
            name="Lname"
            value={editedStudent.Lname}
            onChange={handleInputChange}
          />
        </div>
        <div>
          <label>GPA:</label>
          <input
            type="number"
            step="0.1"
            name="GPA"
            value={editedStudent.GPA}
            onChange={handleInputChange}
          />
        </div>
        <div>
          <label>Credits:</label>
          <input
            type="number"
            name="Credits"
            value={editedStudent.Credits}
            onChange={handleInputChange}
          />
        </div>
        <div>
          <button onClick={handleSave}>Save Changes</button>
          <button onClick={onClose}>Close</button>
        </div>
      </div>
    </div>
  );
};

export default Modal;
