Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
Message-ID: <7999c62e-6ae2-a9ec-0734-9d35720eaac2@kernel.dk>
Date: Fri, 16 Jun 2017 13:56:15 -0600
MIME-Version: 1.0
In-Reply-To: <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 01:41 PM, Jens Axboe wrote:
>> .. and instead pass control and dsmgmt to nvme_get_write_stream by
>> reference to isolate the functionality there.  And move the
>> nvme_configure_streams call into it as well.
> 
> OK, I can make those two changes, fine with me.

See below, don't want to spam with a new version. Outside of this, are
we in agreeing on that it looks OK now from an interface point of view?
Do we want the enum rw_hint more polished and split up? Right now it's
carried through untouched. I'd rather put that in the flags in the
bio/request for two reasons:

1) We have room for the 4 bits. We can always move it to separate
   members if we have to for more hints. I'm always reluctant to add to
   either struct, as adding is much easier than removing.

2) If it's in the flags, we get it automatically all the way through the
   stack. If it's separate members, we have to touch a bunch of places
   to propagate it from bio to request, or from bio to bio when we clone
   and split.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 48a5acea5105..d5105eb9dc49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -422,16 +422,19 @@ static int nvme_streams_deallocate(struct nvme_ns *ns)
 
 static void nvme_write_hint_work(struct work_struct *work)
 {
-	struct nvme_ns *ns = container_of(work, struct nvme_ns, write_hint_work);
 	int ret, nr_streams;
+	struct nvme_ns *ns;
 
+	ns = container_of(work, struct nvme_ns, write_hint_work);
 	if (ns->nr_streams)
 		return;
 
-	nr_streams = streams_per_ns;
-	if (nr_streams > ns->ctrl->nssa)
-		nr_streams = ns->ctrl->nssa;
-
+	/*
+	 * For now, always ask for 'streams_per_ns' number of streams. It's
+	 * possible that we will then run out of streams if we have many
+	 * name spaces. Different policies could be implemented.
+	 */
+	nr_streams = min_t(unsigned int, streams_per_ns, ns->ctrl->nssa);
 	ret = nvme_streams_allocate(ns, nr_streams);
 	if (ret <= 0)
 		goto err;
@@ -457,30 +460,41 @@ static void nvme_configure_streams(struct nvme_ns *ns)
 	schedule_work(&ns->write_hint_work);
 }
 
-static enum rw_hint nvme_get_write_stream(struct nvme_ns *ns,
-					   struct request *req)
+/*
+ * Check if 'req' has a write hint associated with it. If it does, assign
+ * a valid namespace stream to the write. If we haven't setup streams yet,
+ * kick off configuration and ignore the hints until that has completed.
+ */
+static void nvme_assign_write_stream(struct nvme_ns *ns, struct request *req,
+				     u16 *control, u32 *dsmgmt)
 {
-	enum rw_hint streamid = req->cmd_flags & REQ_WRITE_LIFE_MASK;
+	enum rw_hint streamid;
+
+	streamid = (req->cmd_flags & REQ_WRITE_LIFE_MASK)
+			>> __REQ_WRITE_HINT_SHIFT;
+	if (streamid == WRITE_LIFE_NONE)
+		return;
+
+	if (!ns->nr_streams) {
+		nvme_configure_streams(ns);
+		return;
+	}
 
-	if (req_op(req) != REQ_OP_WRITE ||
-	    !(ns->ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
-		return WRITE_LIFE_NONE;
+	/* for now just round-robin, do something more clever later */
+	if (streamid > ns->nr_streams)
+		streamid = (streamid % ns->nr_streams) + 1;
 
-	streamid = req->cmd_flags & REQ_WRITE_LIFE_MASK;
 	if (streamid < ARRAY_SIZE(req->q->write_hints))
 		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
 
-	if (streamid <= ns->nr_streams)
-		return streamid;
-
-	/* for now just round-robin, do something more clever later */
-	return (streamid % ns->nr_streams) + 1;
+	*control |= NVME_RW_DTYPE_STREAMS;
+	*dsmgmt |= streamid << 16;
 }
 
 static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
-	enum rw_hint stream;
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -498,19 +512,9 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
-	/*
-	 * If we support streams and this request is a write with a valid
-	 * hint, then flag it as such. If we haven't allocated streams on
-	 * this ns before, do so lazily.
-	 */
-	stream = nvme_get_write_stream(ns, req);
-	if (stream != WRITE_LIFE_NONE) {
-		if (ns->nr_streams) {
-			control |= NVME_RW_DTYPE_STREAMS;
-			dsmgmt |= (stream << 16);
-		} else
-			nvme_configure_streams(ns);
-	}
+	if (req_op(req) == REQ_OP_WRITE &&
+	    (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
+		nvme_assign_write_stream(ns, req, &control, &dsmgmt);
 
 	if (ns->ms) {
 		switch (ns->pi_type) {

-- 
Jens Axboe
