Return-Path: <beanhuo@micron.com>
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Steven Rostedt <rostedt@goodmis.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "Bart.VanAssche@sandisk.com"
	<Bart.VanAssche@sandisk.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "rajatja@google.com" <rajatja@google.com>
Subject: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Date: Mon, 16 Apr 2018 14:31:49 +0000
Message-ID: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Print the request tag along with other information
while tracing a command.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 include/trace/events/scsi.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index f624969..a4ada90 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -210,6 +210,7 @@ TRACE_EVENT(scsi_dispatch_cmd_start,
 		__field( unsigned int,	lun	)
 		__field( unsigned int,	opcode	)
 		__field( unsigned int,	cmd_len )
+		__field( int,		tag )
 		__field( unsigned int,	data_sglen )
 		__field( unsigned int,	prot_sglen )
 		__field( unsigned char,	prot_op )
@@ -223,6 +224,7 @@ TRACE_EVENT(scsi_dispatch_cmd_start,
 		__entry->lun		=3D cmd->device->lun;
 		__entry->opcode		=3D cmd->cmnd[0];
 		__entry->cmd_len	=3D cmd->cmd_len;
+		__entry->tag		=3D cmd->request->tag;
 		__entry->data_sglen	=3D scsi_sg_count(cmd);
 		__entry->prot_sglen	=3D scsi_prot_sg_count(cmd);
 		__entry->prot_op	=3D scsi_get_prot_op(cmd);
@@ -230,10 +232,10 @@ TRACE_EVENT(scsi_dispatch_cmd_start,
 	),
=20
 	TP_printk("host_no=3D%u channel=3D%u id=3D%u lun=3D%u data_sgl=3D%u prot_=
sgl=3D%u" \
-		  " prot_op=3D%s cmnd=3D(%s %s raw=3D%s)",
+		  " prot_op=3D%s tag=3D%d cmnd=3D(%s %s raw=3D%s)",
 		  __entry->host_no, __entry->channel, __entry->id,
 		  __entry->lun, __entry->data_sglen, __entry->prot_sglen,
-		  show_prot_op_name(__entry->prot_op),
+		  show_prot_op_name(__entry->prot_op), __entry->tag,
 		  show_opcode_name(__entry->opcode),
 		  __parse_cdb(__get_dynamic_array(cmnd), __entry->cmd_len),
 		  __print_hex(__get_dynamic_array(cmnd), __entry->cmd_len))
@@ -253,6 +255,7 @@ TRACE_EVENT(scsi_dispatch_cmd_error,
 		__field( int,		rtn	)
 		__field( unsigned int,	opcode	)
 		__field( unsigned int,	cmd_len )
+		__field( int,		tag )
 		__field( unsigned int,	data_sglen )
 		__field( unsigned int,	prot_sglen )
 		__field( unsigned char,	prot_op )
@@ -267,6 +270,7 @@ TRACE_EVENT(scsi_dispatch_cmd_error,
 		__entry->rtn		=3D rtn;
 		__entry->opcode		=3D cmd->cmnd[0];
 		__entry->cmd_len	=3D cmd->cmd_len;
+		__entry->tag		=3D cmd->request->tag;
 		__entry->data_sglen	=3D scsi_sg_count(cmd);
 		__entry->prot_sglen	=3D scsi_prot_sg_count(cmd);
 		__entry->prot_op	=3D scsi_get_prot_op(cmd);
@@ -274,10 +278,10 @@ TRACE_EVENT(scsi_dispatch_cmd_error,
 	),
=20
 	TP_printk("host_no=3D%u channel=3D%u id=3D%u lun=3D%u data_sgl=3D%u prot_=
sgl=3D%u" \
-		  " prot_op=3D%s cmnd=3D(%s %s raw=3D%s) rtn=3D%d",
+		  " prot_op=3D%s tag=3D%d cmnd=3D(%s %s raw=3D%s) rtn=3D%d",
 		  __entry->host_no, __entry->channel, __entry->id,
 		  __entry->lun, __entry->data_sglen, __entry->prot_sglen,
-		  show_prot_op_name(__entry->prot_op),
+		  show_prot_op_name(__entry->prot_op), __entry->tag,
 		  show_opcode_name(__entry->opcode),
 		  __parse_cdb(__get_dynamic_array(cmnd), __entry->cmd_len),
 		  __print_hex(__get_dynamic_array(cmnd), __entry->cmd_len),
@@ -298,6 +302,7 @@ DECLARE_EVENT_CLASS(scsi_cmd_done_timeout_template,
 		__field( int,		result	)
 		__field( unsigned int,	opcode	)
 		__field( unsigned int,	cmd_len )
+		__field( int,		tag )
 		__field( unsigned int,	data_sglen )
 		__field( unsigned int,	prot_sglen )
 		__field( unsigned char,	prot_op )
@@ -312,6 +317,7 @@ DECLARE_EVENT_CLASS(scsi_cmd_done_timeout_template,
 		__entry->result		=3D cmd->result;
 		__entry->opcode		=3D cmd->cmnd[0];
 		__entry->cmd_len	=3D cmd->cmd_len;
+		__entry->tag		=3D cmd->request->tag;
 		__entry->data_sglen	=3D scsi_sg_count(cmd);
 		__entry->prot_sglen	=3D scsi_prot_sg_count(cmd);
 		__entry->prot_op	=3D scsi_get_prot_op(cmd);
@@ -319,11 +325,11 @@ DECLARE_EVENT_CLASS(scsi_cmd_done_timeout_template,
 	),
=20
 	TP_printk("host_no=3D%u channel=3D%u id=3D%u lun=3D%u data_sgl=3D%u " \
-		  "prot_sgl=3D%u prot_op=3D%s cmnd=3D(%s %s raw=3D%s) result=3D(driver=
=3D" \
-		  "%s host=3D%s message=3D%s status=3D%s)",
+		  "prot_sgl=3D%u prot_op=3D%s tag=3D%d cmnd=3D(%s %s raw=3D%s) " \
+		  "result=3D(driver=3D%s host=3D%s message=3D%s status=3D%s)",
 		  __entry->host_no, __entry->channel, __entry->id,
 		  __entry->lun, __entry->data_sglen, __entry->prot_sglen,
-		  show_prot_op_name(__entry->prot_op),
+		  show_prot_op_name(__entry->prot_op), __entry->tag,
 		  show_opcode_name(__entry->opcode),
 		  __parse_cdb(__get_dynamic_array(cmnd), __entry->cmd_len),
 		  __print_hex(__get_dynamic_array(cmnd), __entry->cmd_len),
--=20
2.7.4
