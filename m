Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:30:10 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 08/10] Multipath make request, retry and cancel IO.
Message-ID: <20170912043010.c6vyupdwpv7wihrl@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Implementation of Multipath nvme_mpath_make_request function registered as part blk_queue_make_request. IO in this function is redirected to active namespace for given multipath controller as far as the active namespace is not in removal state or failover is not in progress. If either failover is in progress we queue the IO into multipath head device congestion queue as part of IO failure. IO will be retried as many times for resubmission as far as it is not exceeding nvme_max_retries count. Resubmission of IO also looks for varios conditions like head or child namespace removal, failover in progress, cleanup done flag which reset after disconnection of device causing failover through disconnect command. Cancelling of IO is called as part of disconnect command to cleanup any IO left over in multipath head device congestion queue.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/core.c | 430 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 428 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb2c90f..4043c00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1168,6 +1168,434 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
+static struct nvme_ns *nvme_get_active_ns_for_mpath_ns(struct nvme_ns *mpath_ns)
+{
+	struct nvme_ns *ns = NULL, *next;
+
+	/*Only get active Namespace if given Namespace is head or parent
+	 of Multipath group otherwise just return the same namespace.*/
+	if (test_bit(NVME_NS_ROOT, &mpath_ns->flags)) {
+		mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+		list_for_each_entry_safe(ns, next, &mpath_ns->ctrl->namespaces, mpathlist) {
+			if (ns->active) {
+				mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+				return ns;
+			}
+		}
+		mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+
+		/* did not find active */
+		ns = NULL;
+		pr_debug(" No active ns found for mpath ns mpnvme%dn%d\n", mpath_ns->ctrl->instance, mpath_ns->instance);
+		return ns;
+	}
+	return mpath_ns;
+}
+
+static struct nvme_ns *nvme_get_ns_for_mpath_ns(struct nvme_ns *mpath_ns)
+{
+	struct nvme_ns *ns = NULL, *next;
+	if (test_bit(NVME_NS_ROOT, &mpath_ns->flags)) {
+		mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+		list_for_each_entry_safe(ns, next, &mpath_ns->ctrl->namespaces, mpathlist) {
+			if (ns) {
+				mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+				return ns;
+			}
+		}
+		mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+		pr_debug(" No sibling device found for mpath mpnvme%dn%d\n", mpath_ns->ctrl->instance, mpath_ns->instance);
+	}
+	return mpath_ns;
+}
+
+/*
+ * Returns non-zero value if operation is write, zero otherwise.
+ */
+static inline int nvme_mpath_bio_is_write(struct bio *bio)
+{
+
+	return op_is_write(bio_op(bio)) ? 1 : 0;
+
+}
+
+/*
+ * Starts the io accounting for given io request. Again, code from stand alone
+ * volume io accounting can not be shared since it operates on struct request.
+ */
+static void nvme_mpath_blk_account_io_start(struct bio *bio,
+		struct nvme_ns *mpath_ns, struct nvme_mpath_priv *priv)
+{
+	int rw;
+	int cpu;
+	struct hd_struct *part;
+
+	rw = nvme_mpath_bio_is_write(bio);
+	cpu = part_stat_lock();
+
+	part = disk_map_sector_rcu(mpath_ns->disk, priv->bi_sector);
+	part_round_stats(cpu, part);
+	part_inc_in_flight(part, rw);
+
+	part_stat_unlock();
+	priv->part = part;
+}
+
+/*
+ * Stats accounting for IO requests on multipath volume.
+ * Same code for stand-alone volume can not be reused since it works on
+ * struct request. Multipath volume does not maintain its own request,
+ * rather it simply redirects IO requests to the active volume.
+ */
+static void nvme_mpath_blk_account_io_done(struct bio *bio,
+					   struct nvme_ns *mpath_ns,
+					   struct nvme_mpath_priv *priv)
+{
+	int rw;
+	int cpu;
+	struct hd_struct *part;
+	unsigned long flags;
+	unsigned long duration;
+
+	spin_lock_irqsave(mpath_ns->queue->queue_lock, flags);
+
+	duration = jiffies - priv->start_time;
+	cpu = part_stat_lock();
+
+	rw = nvme_mpath_bio_is_write(bio);
+	cpu  = part_stat_lock();
+	part = priv->part;
+
+	part_stat_inc(cpu, part, ios[rw]);
+	part_stat_add(cpu, part, ticks[rw], duration);
+	part_round_stats(cpu, part);
+	part_stat_add(cpu, part, sectors[rw], priv->nr_bytes >> 9);
+	part_dec_in_flight(part, rw);
+	part_stat_unlock();
+
+	spin_unlock_irqrestore(mpath_ns->queue->queue_lock, flags);
+}
+
+static void nvme_mpath_cancel_ios(struct nvme_ns *mpath_ns)
+{
+	struct nvme_mpath_priv *priv;
+	struct bio *bio;
+	struct bio_list bios;
+	unsigned long flags;
+
+	mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+	spin_lock_irqsave(&mpath_ns->ctrl->lock, flags);
+	if (bio_list_empty(&mpath_ns->fq_cong)) {
+		spin_unlock_irqrestore(&mpath_ns->ctrl->lock, flags);
+		goto biolist_empty;
+	}
+
+	bio_list_init(&bios);
+	bio_list_merge(&bios, &mpath_ns->fq_cong);
+
+	bio_list_init(&mpath_ns->fq_cong);
+	remove_wait_queue(&mpath_ns->fq_full, &mpath_ns->fq_cong_wait);
+	spin_unlock_irqrestore(&mpath_ns->ctrl->lock, flags);
+
+	while (bio_list_peek(&bios)) {
+		bio = bio_list_pop(&bios);
+		priv = bio->bi_private;
+		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_bdev = priv->bi_bdev;
+		bio->bi_end_io = priv->bi_end_io;
+		bio->bi_private = priv->bi_private;
+		nvme_mpath_blk_account_io_done(bio, mpath_ns, priv);
+		bio_endio(bio);
+		mempool_free(priv, mpath_ns->ctrl->mpath_req_pool);
+	}
+biolist_empty:
+	mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+}
+
+static void nvme_mpath_flush_io_work(struct work_struct *work)
+{
+	struct nvme_ctrl *mpath_ctrl = container_of(to_delayed_work(work),
+		 struct nvme_ctrl, cu_work);
+	struct nvme_ns *mpath_ns = NULL;
+	struct nvme_ns *next;
+
+	list_for_each_entry_safe(mpath_ns, next, &mpath_ctrl->mpath_namespace, list) {
+		if (mpath_ns)
+			break;
+	}
+
+	if (!mpath_ns) {
+		dev_err(mpath_ctrl->device, "No Multipath namespace found.\n");
+		return;
+	}
+
+	if (test_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags))
+		goto exit;
+
+	if (test_bit(NVME_NS_ROOT, &mpath_ns->flags)) {
+		nvme_mpath_cancel_ios(mpath_ns);
+	}
+
+	return;
+ exit:
+	schedule_delayed_work(&mpath_ctrl->cu_work, nvme_io_timeout*HZ);
+}
+
+
+
+static void nvme_mpath_resubmit_bios(struct nvme_ns *mpath_ns)
+{
+	struct nvme_mpath_priv *priv;
+	struct nvme_ns *ns = NULL, *next;
+	struct bio *bio;
+	struct bio_vec *bvec;
+	struct bio_list bios;
+	unsigned long flags;
+	struct blk_plug plug;
+
+	/*
+	 *Get active namespace before resending the IO
+	 */
+
+	mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+	if (test_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags)) {
+		goto namespaces_mutex_unlock;
+	}
+	
+	if (list_empty(&mpath_ns->ctrl->namespaces)) {
+		goto namespaces_mutex_unlock;
+	}
+
+	list_for_each_entry_safe(ns, next, &mpath_ns->ctrl->namespaces, mpathlist) {
+		if (ns->active && test_bit(NVME_NS_MULTIPATH, &ns->flags))
+			break;
+	}
+
+	if (!ns) {
+		goto namespaces_mutex_unlock;
+	}
+
+	if (test_bit(NVME_NS_REMOVING, &ns->flags)) {
+		goto namespaces_mutex_unlock;
+	}
+
+	/*In case of disconnect we wait for cleanup to complete
+	 *for disconnecting device 
+	 */
+	if (!mpath_ns->ctrl->cleanup_done) {
+		goto namespaces_mutex_unlock;
+	}
+
+	if (test_bit(NVME_NS_REMOVING, &mpath_ns->flags)) {
+		goto namespaces_mutex_unlock;
+	}
+
+	spin_lock_irqsave(&mpath_ns->ctrl->lock, flags);
+	if (bio_list_empty(&mpath_ns->fq_cong)) {
+		spin_unlock_irqrestore(&mpath_ns->ctrl->lock, flags);
+		goto namespaces_mutex_unlock;
+	}
+
+	bio_list_init(&bios);
+	bio_list_merge(&bios, &mpath_ns->fq_cong);
+
+	bio_list_init(&mpath_ns->fq_cong);
+	remove_wait_queue(&mpath_ns->fq_full, &mpath_ns->fq_cong_wait);
+	spin_unlock_irqrestore(&mpath_ns->ctrl->lock, flags);
+
+	blk_start_plug(&plug);
+
+	while (bio_list_peek(&bios)) {
+		bio = bio_list_pop(&bios);
+		priv = bio->bi_private;
+		bvec = &priv->bio->bi_io_vec[0];
+		priv->ns = ns;
+		bio->bi_bdev = ns->bdev;
+		bvec = &bio->bi_io_vec[0];
+		bio->bi_status = 0;
+		bio->bi_flags = priv->bi_flags;
+		bio->bi_iter.bi_idx = 0;
+		bio->bi_iter.bi_bvec_done = 0;
+		bio->bi_iter.bi_sector = priv->bi_sector;
+		bio->bi_iter.bi_size = priv->nr_bytes;
+		bio->bi_vcnt = priv->bi_vcnt;
+		bio->bi_phys_segments = priv->bi_phys_segments;
+		bio->bi_seg_front_size = 0;
+		bio->bi_seg_back_size = 0;
+		atomic_set(&bio->__bi_remaining, 1);
+		generic_make_request(bio);
+	}
+	blk_finish_plug(&plug);
+
+namespaces_mutex_unlock:
+	mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+}
+
+/*This logic get executed during IO errors on head or parent Multipath device.*/
+static int nvme_mpath_kthread(void *data)
+{
+	struct nvme_ns *mpath_ns, *next;
+	struct nvme_ctrl *mpath_ctrl, *next_ctrl;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		list_for_each_entry_safe(mpath_ctrl, next_ctrl, &nvme_mpath_ctrl_list, node) {
+			list_for_each_entry_safe(mpath_ns, next, &mpath_ctrl->mpath_namespace, list) {
+				if (!mpath_ns)
+					continue;
+				rcu_read_lock();
+				if (waitqueue_active(&mpath_ns->fq_full))
+					nvme_mpath_resubmit_bios(mpath_ns);
+				rcu_read_unlock();
+			}
+		}
+		schedule_timeout(round_jiffies_relative(HZ));
+	}
+	return 0;
+}
+
+
+static bool nvme_mpath_retry_bio(struct bio *bio)
+{
+	unsigned long flags;
+
+	struct nvme_mpath_priv *priv = bio->bi_private;
+	struct nvme_ns *mpath_ns = priv->mpath_ns;
+
+	spin_lock_irqsave(&mpath_ns->ctrl->lock, flags);
+	if (!waitqueue_active(&mpath_ns->fq_full))
+		add_wait_queue(&mpath_ns->fq_full, &mpath_ns->fq_cong_wait);
+
+	bio_list_add(&mpath_ns->fq_cong, bio);
+
+	spin_unlock_irqrestore(&mpath_ns->ctrl->lock, flags);
+	return true;
+}
+
+static inline int nvme_mpath_bio_has_error(struct bio *bio)
+{
+	return ((bio->bi_status != 0) ? 1:0);
+}
+
+
+static void nvme_mpath_endio(struct bio *bio)
+{
+	int ret;
+	struct nvme_ns *mpath_ns;
+	struct nvme_mpath_priv *priv;
+
+	priv = bio->bi_private;
+	mpath_ns = priv->mpath_ns;
+
+	ret = nvme_mpath_bio_has_error(bio);
+	if (ret) {
+		if (!test_bit(NVME_NS_REMOVING, &mpath_ns->flags)) {
+			if (priv->nr_retries > 0) {
+				priv->nr_retries--;
+				ret = nvme_mpath_retry_bio(bio);
+				if (ret)
+					return;
+			}
+		}
+	} else {
+		nvme_mpath_blk_account_io_done(bio, mpath_ns, priv);
+	}
+
+	mpath_ns =  priv->mpath_ns;
+	bio->bi_bdev = priv->bi_bdev;
+	bio->bi_end_io = priv->bi_end_io;
+	bio->bi_private = priv->bi_private;
+	bio_endio(bio);
+
+	mempool_free(priv, mpath_ns->ctrl->mpath_req_pool);
+}
+
+static void nvme_mpath_priv_bio(struct nvme_mpath_priv *priv, struct bio *bio,
+struct nvme_ns *ns, struct nvme_ns *mpath_ns)
+{
+	priv->bi_bdev = bio->bi_bdev;
+	priv->bi_end_io = bio->bi_end_io;
+	priv->bi_private = bio->bi_private;
+	priv->bi_flags = bio->bi_flags;
+	priv->bi_sector = bio->bi_iter.bi_sector;
+	priv->nr_bytes = bio->bi_iter.bi_size;
+	priv->bio = bio;
+	priv->bi_vcnt = bio->bi_vcnt;
+	priv->bi_phys_segments = bio->bi_phys_segments;
+	priv->bvec = &bio->bi_io_vec[0];
+	/*Count for two connections, so twice the retry logic.*/
+	priv->nr_retries = nvme_max_retries;
+	priv->start_time = jiffies;
+	priv->ns = ns;
+	priv->mpath_ns = mpath_ns;
+	bio->bi_opf |= REQ_FAILFAST_TRANSPORT;
+	bio->bi_private = priv;
+	bio->bi_end_io = nvme_mpath_endio;
+	bio->bi_bdev = ns->bdev;
+}
+
+static blk_qc_t nvme_mpath_make_request(struct request_queue *q, struct bio *bio)
+
+{
+	struct nvme_mpath_priv *priv = NULL;
+	struct nvme_ns *ns = NULL;
+	struct nvme_ns *mpath_ns = q->queuedata;
+
+	if (test_bit(NVME_NS_REMOVING, &mpath_ns->flags)) {
+		goto out_exit_mpath_request;
+	}
+
+	priv = mempool_alloc(mpath_ns->ctrl->mpath_req_pool, GFP_ATOMIC);
+	if (unlikely(!priv)) {
+		dev_err(mpath_ns->ctrl->device, "failed allocating mpath priv request\n");
+		goto out_exit_mpath_request;
+	}
+
+mpath_retry:
+	mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+
+	list_for_each_entry(ns, &mpath_ns->ctrl->namespaces, mpathlist) {
+		if (test_bit(NVME_NS_REMOVING, &ns->flags)) {
+			continue;
+		}
+
+		if (test_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags)) {
+			break;
+		}
+
+		if (ns->active) {
+			if (ns->mpath_ctrl != mpath_ns->ctrl) {
+				mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+				dev_err(mpath_ns->ctrl->device, "Incorrect namespace parent child combination.\n");
+				goto mpath_retry;
+			}
+			nvme_mpath_priv_bio(priv, bio, ns, mpath_ns);
+			nvme_mpath_blk_account_io_start(bio, mpath_ns, priv);
+			generic_make_request(bio);
+			mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+			goto out_mpath_return;
+		}
+	}
+
+	list_for_each_entry(ns, &mpath_ns->ctrl->namespaces, mpathlist) {
+		if (!ns->active) {
+			nvme_mpath_priv_bio(priv, bio, ns, mpath_ns);
+			nvme_mpath_blk_account_io_start(bio, mpath_ns, priv);
+			mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+			goto out_exit_mpath_request;
+		}
+	}
+
+	mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+
+ out_exit_mpath_request:
+	bio->bi_status = BLK_STS_IOERR;
+	bio_endio(bio);
+
+ out_mpath_return:
+	return BLK_QC_T_NONE;
+}
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -2767,8 +3195,6 @@ void nvme_trigger_failover(struct nvme_ctrl *ctrl)
 			test_and_clear_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags);
 		}
 
-		if (!test_bit(NVME_NS_FO_IN_PROGRESS, &mpath_ns->flags)) {
-		}
 		mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
 	}
 }
-- 
2.9.3
