Return-Path: <BATV+3de936c6eedb3fd3a39f+5557+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/6] fnic: fix fnic_scsi_host_{start,end}_tag
Date: Sat, 10 Nov 2018 09:30:44 +0100
Message-Id: <20181110083049.17475-2-hch@lst.de>
In-Reply-To: <20181110083049.17475-1-hch@lst.de>
References: <20181110083049.17475-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

They way these functions abuse ->special to try to store the dummy
request looks completely broken, given that it actually stores the
original scsi command.

Instead switch to ->host_scribble and store the actual dummy command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/fnic/fnic_scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 96acfcecd540..cafbcfb85bfa 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2274,7 +2274,7 @@ fnic_scsi_host_start_tag(struct fnic *fnic, struct scsi_cmnd *sc)
 		return SCSI_NO_TAG;
 
 	sc->tag = sc->request->tag = dummy->tag;
-	sc->request->special = sc;
+	sc->host_scribble = (unsigned char *)dummy;
 
 	return dummy->tag;
 }
@@ -2286,7 +2286,7 @@ fnic_scsi_host_start_tag(struct fnic *fnic, struct scsi_cmnd *sc)
 static inline void
 fnic_scsi_host_end_tag(struct fnic *fnic, struct scsi_cmnd *sc)
 {
-	struct request *dummy = sc->request->special;
+	struct request *dummy = (struct request *)sc->host_scribble;
 
 	blk_mq_free_request(dummy);
 }
-- 
2.19.1
