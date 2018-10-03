Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Mike Christie <mchristi@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH] block: Finish renaming REQ_DISCARD into REQ_OP_DISCARD
Date: Wed,  3 Oct 2018 13:56:25 -0700
Message-Id: <20181003205625.27554-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@wdc.com>

Some time ago REQ_DISCARD was renamed into REQ_OP_DISCARD. Some comments
and documentation files were not updated however. Update these comments
and documentation files. See also commit 4e1b2d52a80d ("block, fs,
drivers: remove REQ_OP compat defs and related code").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 Documentation/blockdev/zram.txt            | 2 +-
 Documentation/device-mapper/log-writes.txt | 2 +-
 drivers/block/drbd/drbd_int.h              | 2 +-
 drivers/block/drbd/drbd_main.c             | 2 +-
 drivers/block/drbd/drbd_protocol.h         | 4 ++--
 drivers/block/drbd/drbd_req.c              | 2 +-
 drivers/block/drbd/drbd_worker.c           | 2 +-
 drivers/target/target_core_spc.c           | 6 +++---
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 875b2b56b87f..3c1b5ab54bc0 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -190,7 +190,7 @@ whitespace:
  notify_free      Depending on device usage scenario it may account
                   a) the number of pages freed because of swap slot free
                   notifications or b) the number of pages freed because of
-                  REQ_DISCARD requests sent by bio. The former ones are
+                  REQ_OP_DISCARD requests sent by bio. The former ones are
                   sent to a swap block device when a swap slot is freed,
                   which implies that this disk is being used as a swap disk.
                   The latter ones are sent by filesystem mounted with
diff --git a/Documentation/device-mapper/log-writes.txt b/Documentation/device-mapper/log-writes.txt
index f4ebcbaf50f3..b638d124be6a 100644
--- a/Documentation/device-mapper/log-writes.txt
+++ b/Documentation/device-mapper/log-writes.txt
@@ -38,7 +38,7 @@ inconsistent file system.
 Any REQ_FUA requests bypass this flushing mechanism and are logged as soon as
 they complete as those requests will obviously bypass the device cache.
 
-Any REQ_DISCARD requests are treated like WRITE requests.  Otherwise we would
+Any REQ_OP_DISCARD requests are treated like WRITE requests.  Otherwise we would
 have all the DISCARD requests, and then the WRITE requests and then the FLUSH
 request.  Consider the following example:
 
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 8a4c1328e6f9..1e47db57b9d2 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -429,7 +429,7 @@ enum {
 	__EE_CALL_AL_COMPLETE_IO,
 	__EE_MAY_SET_IN_SYNC,
 
-	/* is this a TRIM aka REQ_DISCARD? */
+	/* is this a TRIM aka REQ_OP_DISCARD? */
 	__EE_IS_TRIM,
 
 	/* In case a barrier failed,
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 15a9ffce9012..55fd104f1ed4 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1673,7 +1673,7 @@ static u32 bio_flags_to_wire(struct drbd_connection *connection,
 		return bio->bi_opf & REQ_SYNC ? DP_RW_SYNC : 0;
 }
 
-/* Used to send write or TRIM aka REQ_DISCARD requests
+/* Used to send write or TRIM aka REQ_OP_DISCARD requests
  * R_PRIMARY -> Peer	(P_DATA, P_TRIM)
  */
 int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *req)
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index c3081f93051c..48dabbb21e11 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -57,7 +57,7 @@ enum drbd_packet {
 	P_PROTOCOL_UPDATE     = 0x2d, /* data sock: is used in established connections */
         /* 0x2e to 0x30 reserved, used in drbd 9 */
 
-	/* REQ_DISCARD. We used "discard" in different contexts before,
+	/* REQ_OP_DISCARD. We used "discard" in different contexts before,
 	 * which is why I chose TRIM here, to disambiguate. */
 	P_TRIM                = 0x31,
 
@@ -126,7 +126,7 @@ struct p_header100 {
 #define DP_UNPLUG             8 /* not used anymore   */
 #define DP_FUA               16 /* equals REQ_FUA     */
 #define DP_FLUSH             32 /* equals REQ_PREFLUSH   */
-#define DP_DISCARD           64 /* equals REQ_DISCARD */
+#define DP_DISCARD           64 /* equals REQ_OP_DISCARD */
 #define DP_SEND_RECEIVE_ACK 128 /* This is a proto B write request */
 #define DP_SEND_WRITE_ACK   256 /* This is a proto C write request */
 #define DP_WSAME            512 /* equiv. REQ_WRITE_SAME */
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 19cac36e9737..1c4da17e902e 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -650,7 +650,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 	case DISCARD_COMPLETED_NOTSUPP:
 	case DISCARD_COMPLETED_WITH_ERROR:
 		/* I'd rather not detach from local disk just because it
-		 * failed a REQ_DISCARD. */
+		 * failed a REQ_OP_DISCARD. */
 		mod_rq_state(req, m, RQ_LOCAL_PENDING, RQ_LOCAL_COMPLETED);
 		break;
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index c7ef48efe871..99255d0c9e2f 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -152,7 +152,7 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 
 	do_wake = list_empty(block_id == ID_SYNCER ? &device->sync_ee : &device->active_ee);
 
-	/* FIXME do we want to detach for failed REQ_DISCARD?
+	/* FIXME do we want to detach for failed REQ_OP_DISCARD?
 	 * ((peer_req->flags & (EE_WAS_ERROR|EE_IS_TRIM)) == EE_WAS_ERROR) */
 	if (peer_req->flags & EE_WAS_ERROR)
 		__drbd_chk_io_error(device, DRBD_WRITE_ERROR);
diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index cb0461a10808..f459118bc11b 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -636,9 +636,9 @@ spc_emulate_evpd_b2(struct se_cmd *cmd, unsigned char *buf)
 
 	/*
 	 * The unmap_zeroes_data set means that the underlying device supports
-	 * REQ_DISCARD and has the discard_zeroes_data bit set. This satisfies
-	 * the SBC requirements for LBPRZ, meaning that a subsequent read
-	 * will return zeroes after an UNMAP or WRITE SAME (16) to an LBA
+	 * REQ_OP_DISCARD and has the discard_zeroes_data bit set. This
+	 * satisfies the SBC requirements for LBPRZ, meaning that a subsequent
+	 * read will return zeroes after an UNMAP or WRITE SAME (16) to an LBA
 	 * See sbc4r36 6.6.4.
 	 */
 	if (((dev->dev_attrib.emulate_tpu != 0) ||
-- 
2.19.0.605.g01d371f741-goog
