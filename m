Return-Path: <BATV+df5a2477ff0fa86e9985+5386+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 09/14] libiscsi: don't try to bypass SCSI EH
Date: Wed, 23 May 2018 14:19:36 +0200
Message-Id: <20180523121941.8632-10-hch@lst.de>
In-Reply-To: <20180523121941.8632-1-hch@lst.de>
References: <20180523121941.8632-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

libiscsi is the only SCSI code that return BLK_EH_HANDLED, thus trying to
bypass the normal SCSI EH code.  We are going to remove this return value
at the block layer, and at least from a quick look it doesn't look too
harmful to try to send an abort for these cases, especially as the first
one should not actually be possible.  If this doesn't work out iscsi
will probably need its own eh_strategy_handler instead to just do the
right thing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/libiscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index eee43ba83a60..71bdc0b52cf9 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1982,7 +1982,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 		 * Raced with completion. Blk layer has taken ownership
 		 * so let timeout code complete it now.
 		 */
-		rc = BLK_EH_HANDLED;
+		rc = BLK_EH_DONE;
 		goto done;
 	}
 
@@ -1997,7 +1997,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
 		if (unlikely(system_state != SYSTEM_RUNNING)) {
 			sc->result = DID_NO_CONNECT << 16;
 			ISCSI_DBG_EH(session, "sc on shutdown, handled\n");
-			rc = BLK_EH_HANDLED;
+			rc = BLK_EH_DONE;
 			goto done;
 		}
 		/*
-- 
2.17.0
