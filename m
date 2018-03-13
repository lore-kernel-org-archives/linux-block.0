Return-Path: <BATV+1231baeb55c0b05cfb44+5315+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 1/3] bsg-lib: introduce a timeout field in struct bsg_job
Date: Tue, 13 Mar 2018 17:28:39 +0100
Message-Id: <20180313162841.9030-2-hch@lst.de>
In-Reply-To: <20180313162841.9030-1-hch@lst.de>
References: <20180313162841.9030-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The zfcp driver wants to know the timeout for a bsg job, so add a field
to struct bsg_job for it in preparation of not exposing the request
to the bsg-lib users.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bsg-lib.c             | 1 +
 drivers/s390/scsi/zfcp_fc.c | 4 ++--
 include/linux/bsg-lib.h     | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index b4fe1a48f111..fb509779a090 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -132,6 +132,7 @@ static int bsg_prepare_job(struct device *dev, struct request *req)
 	struct bsg_job *job = blk_mq_rq_to_pdu(req);
 	int ret;
 
+	job->timeout = req->timeout;
 	job->request = rq->cmd;
 	job->request_len = rq->cmd_len;
 
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index ca218c82321f..6162cf57a20a 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -961,7 +961,7 @@ static int zfcp_fc_exec_els_job(struct bsg_job *job,
 		d_id = ntoh24(bsg_request->rqst_data.h_els.port_id);
 
 	els->handler = zfcp_fc_ct_els_job_handler;
-	return zfcp_fsf_send_els(adapter, d_id, els, job->req->timeout / HZ);
+	return zfcp_fsf_send_els(adapter, d_id, els, job->timeout / HZ);
 }
 
 static int zfcp_fc_exec_ct_job(struct bsg_job *job,
@@ -980,7 +980,7 @@ static int zfcp_fc_exec_ct_job(struct bsg_job *job,
 		return ret;
 
 	ct->handler = zfcp_fc_ct_job_handler;
-	ret = zfcp_fsf_send_ct(wka_port, ct, NULL, job->req->timeout / HZ);
+	ret = zfcp_fsf_send_ct(wka_port, ct, NULL, job->timeout / HZ);
 	if (ret)
 		zfcp_fc_wka_port_put(wka_port);
 
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index b1be0233ce35..402223c95ce1 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -44,6 +44,8 @@ struct bsg_job {
 
 	struct kref kref;
 
+	unsigned int timeout;
+
 	/* Transport/driver specific request/reply structs */
 	void *request;
 	void *reply;
-- 
2.14.2
