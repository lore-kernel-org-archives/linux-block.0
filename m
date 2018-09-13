Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH V3 06/17] SCSI: pass 'scsi_device' instance from 'scsi_request'
Date: Thu, 13 Sep 2018 20:15:35 +0800
Message-Id: <20180913121546.5710-7-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch prepares for introducing SCSI per-host admin queue, which
is only used for queuing admin requests, which are now submitted via
__scsi_execute().

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c     | 2 ++
 include/scsi/scsi_request.h | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6fb8fd3ccc2c..2800dfae19cd 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -279,6 +279,8 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	rq->cmd_len = COMMAND_SIZE(cmd[0]);
 	memcpy(rq->cmd, cmd, rq->cmd_len);
 	rq->retries = retries;
+	rq->sdev = sdev;	/* only valid in submit path */
+
 	req->timeout = timeout;
 	req->cmd_flags |= flags;
 	req->rq_flags |= rq_flags | RQF_QUIET;
diff --git a/include/scsi/scsi_request.h b/include/scsi/scsi_request.h
index b06f28c74908..0de6901b48ab 100644
--- a/include/scsi/scsi_request.h
+++ b/include/scsi/scsi_request.h
@@ -14,7 +14,10 @@ struct scsi_request {
 	unsigned int	sense_len;
 	unsigned int	resid_len;	/* residual count */
 	int		retries;
-	void		*sense;
+	union {
+		void		*sense;
+		struct scsi_device *sdev;
+	};
 };
 
 static inline struct scsi_request *scsi_req(struct request *rq)
-- 
2.9.5
