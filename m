Return-Path: <bblock@linux.vnet.ibm.com>
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Benjamin Block <bblock@linux.vnet.ibm.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Steffen Maier <maier@linux.vnet.ibm.com>, open-iscsi@googlegroups.com
Subject: [RFC PATCH 2/6] bsg: assign sense_len instead of fixed SCSI_SENSE_BUFFERSIZE
Date: Wed,  9 Aug 2017 16:11:16 +0200
In-Reply-To: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
Message-Id: <2dd8381929af2037a6eec3086256f54f55c01e78.1502120928.git.bblock@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

We do set rq->sense_len when we assigne the reply-buffer in
blk_fill_sgv4_hdr_rq(). No point in possibly deviating from this value
later on.

bsg-lib.h specifies:
    unsigned int reply_len;
    /*
     * On entry : reply_len indicates the buffer size allocated for
     * the reply.
     *
     * ...
     */

Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 block/bsg-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index c4513b23f57a..c7c2c6bbb5ae 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -147,8 +147,8 @@ static int bsg_create_job(struct device *dev, struct request *req)
 	job->request = rq->cmd;
 	job->request_len = rq->cmd_len;
 	job->reply = rq->sense;
-	job->reply_len = SCSI_SENSE_BUFFERSIZE;	/* Size of sense buffer
-						 * allocated */
+	job->reply_len = rq->sense_len;
+
 	if (req->bio) {
 		ret = bsg_map_buffer(&job->request_payload, req);
 		if (ret)
-- 
2.12.2
