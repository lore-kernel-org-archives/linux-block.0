Return-Path: <yyt168@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170918231453.27128-10-hch@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170918231453.27128-10-hch@lst.de>
From: Tony Yang <yyt168@gmail.com>
Date: Wed, 20 Sep 2017 08:18:41 +0800
Message-ID: <CADL4p-pcUCoibEWxfFeLHoYhsM3nuSedoe2QTK-ahys+1+TXbg@mail.gmail.com>
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi , Christoph

     I use the above code to recompile the kernel. The following error
occurred. I can't find the blk_steal_bios function. What's the reason
for that? Hope to get your help, thank you


[root@scst1 nvme-nvme-4.13]# make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     scripts/mod/devicetable-offsets.h
  CHK     include/generated/compile.h
  CC [M]  drivers/nvme/host/core.o
drivers/nvme/host/core.c: In function 'nvme_failover_req':
drivers/nvme/host/core.c:115:2: error: implicit declaration of
function 'blk_steal_bios' [-Werror=implicit-function-declaration]
  blk_steal_bios(&ns->head->requeue_list, req);
  ^
In file included from drivers/nvme/host/core.c:32:0:
drivers/nvme/host/core.c: In function 'nvme_req_needs_failover':
drivers/nvme/host/nvme.h:100:25: error: 'REQ_DRV' undeclared (first
use in this function)
 #define REQ_NVME_MPATH  REQ_DRV
                         ^
drivers/nvme/host/core.c:151:25: note: in expansion of macro 'REQ_NVME_MPATH'
  if (!(req->cmd_flags & REQ_NVME_MPATH))
                         ^
drivers/nvme/host/nvme.h:100:25: note: each undeclared identifier is
reported only once for each function it appears in
 #define REQ_NVME_MPATH  REQ_DRV
                         ^
drivers/nvme/host/core.c:151:25: note: in expansion of macro 'REQ_NVME_MPATH'
  if (!(req->cmd_flags & REQ_NVME_MPATH))
                         ^
In file included from ./include/linux/byteorder/little_endian.h:4:0,
                 from ./arch/x86/include/uapi/asm/byteorder.h:4,
                 from ./include/asm-generic/bitops/le.h:5,
                 from ./arch/x86/include/asm/bitops.h:517,
                 from ./include/linux/bitops.h:36,
                 from ./include/linux/kernel.h:10,
                 from ./arch/x86/include/asm/percpu.h:44,
                 from ./arch/x86/include/asm/current.h:5,
                 from ./include/linux/sched.h:11,
                 from ./include/linux/blkdev.h:4,
                 from drivers/nvme/host/core.c:15:
drivers/nvme/host/core.c: In function 'nvme_toggle_streams':
drivers/nvme/host/core.c:433:33: error: 'NVME_NSID_ALL' undeclared
(first use in this function)
  c.directive.nsid = cpu_to_le32(NVME_NSID_ALL);
                                 ^
./include/uapi/linux/byteorder/little_endian.h:32:51: note: in
definition of macro '__cpu_to_le32'
 #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                   ^
drivers/nvme/host/core.c:433:21: note: in expansion of macro 'cpu_to_le32'
  c.directive.nsid = cpu_to_le32(NVME_NSID_ALL);
                     ^
drivers/nvme/host/core.c: In function 'nvme_configure_directives':
drivers/nvme/host/core.c:483:41: error: 'NVME_NSID_ALL' undeclared
(first use in this function)
  ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
                                         ^
drivers/nvme/host/core.c: In function 'nvme_submit_user_cmd':
drivers/nvme/host/core.c:770:6: error: 'struct bio' has no member
named 'bi_disk'
   bio->bi_disk = disk;
      ^
drivers/nvme/host/core.c: In function 'nvme_enable_ctrl':
drivers/nvme/host/core.c:1598:23: error: 'NVME_CC_AMS_RR' undeclared
(first use in this function)
  ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
                       ^
drivers/nvme/host/core.c: In function 'nvme_configure_timestamp':
drivers/nvme/host/core.c:1665:21: error: 'NVME_CTRL_ONCS_TIMESTAMP'
undeclared (first use in this function)
  if (!(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
                     ^
drivers/nvme/host/core.c:1669:32: error: 'NVME_FEAT_TIMESTAMP'
undeclared (first use in this function)
  ret = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP, 0, &ts, sizeof(ts),
                                ^
In file included from ./include/linux/byteorder/little_endian.h:4:0,
                 from ./arch/x86/include/uapi/asm/byteorder.h:4,
                 from ./include/asm-generic/bitops/le.h:5,
                 from ./arch/x86/include/asm/bitops.h:517,
                 from ./include/linux/bitops.h:36,
                 from ./include/linux/kernel.h:10,
                 from ./arch/x86/include/asm/percpu.h:44,
                 from ./arch/x86/include/asm/current.h:5,
                 from ./include/linux/sched.h:11,
                 from ./include/linux/blkdev.h:4,
                 from drivers/nvme/host/core.c:15:
drivers/nvme/host/core.c: In function 'nvme_init_identify':
drivers/nvme/host/core.c:2116:33: error: 'struct nvme_id_ctrl' has no
member named 'hmminds'
   ctrl->hmminds = le32_to_cpu(id->hmminds);
                                 ^
./include/uapi/linux/byteorder/little_endian.h:33:51: note: in
definition of macro '__le32_to_cpu'
 #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                   ^
drivers/nvme/host/core.c:2116:19: note: in expansion of macro 'le32_to_cpu'
   ctrl->hmminds = le32_to_cpu(id->hmminds);
                   ^
drivers/nvme/host/core.c:2117:32: error: 'struct nvme_id_ctrl' has no
member named 'hmmaxd'
   ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
                                ^
./include/uapi/linux/byteorder/little_endian.h:35:51: note: in
definition of macro '__le16_to_cpu'
 #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                   ^
drivers/nvme/host/core.c:2117:18: note: in expansion of macro 'le16_to_cpu'
   ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
                  ^
drivers/nvme/host/core.c: In function 'nvme_make_request':
drivers/nvme/host/core.c:2535:6: error: 'struct bio' has no member
named 'bi_disk'
   bio->bi_disk = ns->disk;
      ^
In file included from drivers/nvme/host/core.c:32:0:
drivers/nvme/host/nvme.h:100:25: error: 'REQ_DRV' undeclared (first
use in this function)
 #define REQ_NVME_MPATH  REQ_DRV
                         ^
drivers/nvme/host/core.c:2536:18: note: in expansion of macro 'REQ_NVME_MPATH'
   bio->bi_opf |= REQ_NVME_MPATH;
                  ^
drivers/nvme/host/core.c:2537:3: error: implicit declaration of
function 'direct_make_request' [-Werror=implicit-function-declaration]
   ret = direct_make_request(bio);
   ^
drivers/nvme/host/core.c: In function 'nvme_requeue_work':
drivers/nvme/host/core.c:2577:6: error: 'struct bio' has no member
named 'bi_disk'
   bio->bi_disk = head->disk;
      ^
drivers/nvme/host/core.c: In function 'nvme_ctrl_pp_status':
drivers/nvme/host/core.c:3078:58: error: 'NVME_CSTS_PP' undeclared
(first use in this function)
  return ((ctrl->ctrl_config & NVME_CC_ENABLE) && (csts & NVME_CSTS_PP));
                                                          ^
drivers/nvme/host/core.c: In function 'nvme_get_fw_slot_info':
drivers/nvme/host/core.c:3086:23: error: dereferencing pointer to
incomplete type
  log = kmalloc(sizeof(*log), GFP_KERNEL);
                       ^
In file included from ./include/linux/byteorder/little_endian.h:4:0,
                 from ./arch/x86/include/uapi/asm/byteorder.h:4,
                 from ./include/asm-generic/bitops/le.h:5,
                 from ./arch/x86/include/asm/bitops.h:517,
                 from ./include/linux/bitops.h:36,
                 from ./include/linux/kernel.h:10,
                 from ./arch/x86/include/asm/percpu.h:44,
                 from ./arch/x86/include/asm/current.h:5,
                 from ./include/linux/sched.h:11,
                 from ./include/linux/blkdev.h:4,
                 from drivers/nvme/host/core.c:15:
drivers/nvme/host/core.c:3091:30: error: 'NVME_NSID_ALL' undeclared
(first use in this function)
  c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
                              ^
./include/uapi/linux/byteorder/little_endian.h:32:51: note: in
definition of macro '__cpu_to_le32'
 #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                   ^
drivers/nvme/host/core.c:3091:18: note: in expansion of macro 'cpu_to_le32'
  c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
                  ^
drivers/nvme/host/core.c:3092:65: error: dereferencing pointer to
incomplete type
  c.common.cdw10[0] = nvme_get_log_dw10(NVME_LOG_FW_SLOT, sizeof(*log));
                                                                 ^
drivers/nvme/host/core.c:3094:59: error: dereferencing pointer to
incomplete type
  if (!nvme_submit_sync_cmd(ctrl->admin_q, &c, log, sizeof(*log)))
                                                           ^
drivers/nvme/host/core.c: In function 'nvme_complete_async_event':
drivers/nvme/host/core.c:3159:7: error:
'NVME_AER_NOTICE_FW_ACT_STARTING' undeclared (first use in this
function)
  case NVME_AER_NOTICE_FW_ACT_STARTING:
       ^
drivers/nvme/host/core.c: In function 'nvme_ctrl_pp_status':
drivers/nvme/host/core.c:3079:1: warning: control reaches end of
non-void function [-Wreturn-type]
 }
 ^
cc1: some warnings being treated as errors
make[3]: *** [drivers/nvme/host/core.o] Error 1
make[2]: *** [drivers/nvme/host] Error 2
make[1]: *** [drivers/nvme] Error 2
make: *** [drivers] Error 2
[root@scst1 nvme-nvme-4.13]#

2017-09-19 7:14 GMT+08:00 Christoph Hellwig <hch@lst.de>:
> This patch adds initial multipath support to the nvme driver.  For each
> namespace we create a new block device node, which can be used to access
> that namespace through any of the controllers that refer to it.
>
> Currently we will always send I/O to the first available path, this will
> be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
> ratified and implemented, at which point we will look at the ANA state
> for each namespace.  Another possibility that was prototyped is to
> use the path that is closes to the submitting NUMA code, which will be
> mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
> or I/O service time path selectors, as those are not scalable with
> the performance rates provided by NVMe.
>
> The multipath device will go away once all paths to it disappear,
> any delay to keep it alive needs to be implemented at the controller
> level.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 264 ++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/nvme/host/nvme.h |  11 ++
>  2 files changed, 259 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3e8405fd57a9..5449c83a9dc3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -77,6 +77,8 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
>  static LIST_HEAD(nvme_ctrl_list);
>  static DEFINE_SPINLOCK(dev_list_lock);
>
> +static DEFINE_IDA(nvme_disk_ida);
> +
>  static struct class *nvme_class;
>
>  static __le32 nvme_get_log_dw10(u8 lid, size_t size)
> @@ -104,6 +106,19 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
>         return ret;
>  }
>
> +static void nvme_failover_req(struct request *req)
> +{
> +       struct nvme_ns *ns = req->q->queuedata;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +       blk_steal_bios(&ns->head->requeue_list, req);
> +       spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +
> +       nvme_reset_ctrl(ns->ctrl);
> +       kblockd_schedule_work(&ns->head->requeue_work);
> +}
> +
>  static blk_status_t nvme_error_status(struct request *req)
>  {
>         switch (nvme_req(req)->status & 0x7ff) {
> @@ -131,6 +146,53 @@ static blk_status_t nvme_error_status(struct request *req)
>         }
>  }
>
> +static bool nvme_req_needs_failover(struct request *req)
> +{
> +       if (!(req->cmd_flags & REQ_NVME_MPATH))
> +               return false;
> +
> +       switch (nvme_req(req)->status & 0x7ff) {
> +       /*
> +        * Generic command status:
> +        */
> +       case NVME_SC_INVALID_OPCODE:
> +       case NVME_SC_INVALID_FIELD:
> +       case NVME_SC_INVALID_NS:
> +       case NVME_SC_LBA_RANGE:
> +       case NVME_SC_CAP_EXCEEDED:
> +       case NVME_SC_RESERVATION_CONFLICT:
> +               return false;
> +
> +       /*
> +        * I/O command set specific error.  Unfortunately these values are
> +        * reused for fabrics commands, but those should never get here.
> +        */
> +       case NVME_SC_BAD_ATTRIBUTES:
> +       case NVME_SC_INVALID_PI:
> +       case NVME_SC_READ_ONLY:
> +       case NVME_SC_ONCS_NOT_SUPPORTED:
> +               WARN_ON_ONCE(nvme_req(req)->cmd->common.opcode ==
> +                       nvme_fabrics_command);
> +               return false;
> +
> +       /*
> +        * Media and Data Integrity Errors:
> +        */
> +       case NVME_SC_WRITE_FAULT:
> +       case NVME_SC_READ_ERROR:
> +       case NVME_SC_GUARD_CHECK:
> +       case NVME_SC_APPTAG_CHECK:
> +       case NVME_SC_REFTAG_CHECK:
> +       case NVME_SC_COMPARE_FAILED:
> +       case NVME_SC_ACCESS_DENIED:
> +       case NVME_SC_UNWRITTEN_BLOCK:
> +               return false;
> +       }
> +
> +       /* Everything else could be a path failure, so should be retried */
> +       return true;
> +}
> +
>  static inline bool nvme_req_needs_retry(struct request *req)
>  {
>         if (blk_noretry_request(req))
> @@ -145,6 +207,11 @@ static inline bool nvme_req_needs_retry(struct request *req)
>  void nvme_complete_rq(struct request *req)
>  {
>         if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
> +               if (nvme_req_needs_failover(req)) {
> +                       nvme_failover_req(req);
> +                       return;
> +               }
> +
>                 nvme_req(req)->retries++;
>                 blk_mq_requeue_request(req, true);
>                 return;
> @@ -173,6 +240,18 @@ void nvme_cancel_request(struct request *req, void *data, bool reserved)
>  }
>  EXPORT_SYMBOL_GPL(nvme_cancel_request);
>
> +static void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
> +{
> +       struct nvme_ns *ns;
> +
> +       mutex_lock(&ctrl->namespaces_mutex);
> +       list_for_each_entry(ns, &ctrl->namespaces, list) {
> +               if (ns->head)
> +                       kblockd_schedule_work(&ns->head->requeue_work);
> +       }
> +       mutex_unlock(&ctrl->namespaces_mutex);
> +}
> +
>  bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>                 enum nvme_ctrl_state new_state)
>  {
> @@ -240,9 +319,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>
>         if (changed)
>                 ctrl->state = new_state;
> -
>         spin_unlock_irqrestore(&ctrl->lock, flags);
>
> +       if (changed && ctrl->state == NVME_CTRL_LIVE)
> +               nvme_kick_requeue_lists(ctrl);
>         return changed;
>  }
>  EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
> @@ -252,6 +332,15 @@ static void nvme_destroy_ns_head(struct kref *ref)
>         struct nvme_ns_head *head =
>                 container_of(ref, struct nvme_ns_head, ref);
>
> +       del_gendisk(head->disk);
> +       blk_set_queue_dying(head->disk->queue);
> +       /* make sure all pending bios are cleaned up */
> +       kblockd_schedule_work(&head->requeue_work);
> +       flush_work(&head->requeue_work);
> +       blk_cleanup_queue(head->disk->queue);
> +       put_disk(head->disk);
> +       ida_simple_remove(&nvme_disk_ida, head->instance);
> +
>         list_del_init(&head->entry);
>         cleanup_srcu_struct(&head->srcu);
>         kfree(head);
> @@ -1123,8 +1212,10 @@ static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
>         if (blk_get_integrity(disk) &&
>             (ns->pi_type != pi_type || ns->ms != old_ms ||
>              bs != queue_logical_block_size(disk->queue) ||
> -            (ns->ms && ns->ext)))
> +            (ns->ms && ns->ext))) {
>                 blk_integrity_unregister(disk);
> +               blk_integrity_unregister(ns->head->disk);
> +       }
>
>         ns->pi_type = pi_type;
>  }
> @@ -1152,7 +1243,9 @@ static void nvme_init_integrity(struct nvme_ns *ns)
>         }
>         integrity.tuple_size = ns->ms;
>         blk_integrity_register(ns->disk, &integrity);
> +       blk_integrity_register(ns->head->disk, &integrity);
>         blk_queue_max_integrity_segments(ns->queue, 1);
> +       blk_queue_max_integrity_segments(ns->head->disk->queue, 1);
>  }
>  #else
>  static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
> @@ -1170,7 +1263,7 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
>         blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
>  }
>
> -static void nvme_config_discard(struct nvme_ns *ns)
> +static void nvme_config_discard(struct nvme_ns *ns, struct request_queue *queue)
>  {
>         struct nvme_ctrl *ctrl = ns->ctrl;
>         u32 logical_block_size = queue_logical_block_size(ns->queue);
> @@ -1181,18 +1274,18 @@ static void nvme_config_discard(struct nvme_ns *ns)
>         if (ctrl->nr_streams && ns->sws && ns->sgs) {
>                 unsigned int sz = logical_block_size * ns->sws * ns->sgs;
>
> -               ns->queue->limits.discard_alignment = sz;
> -               ns->queue->limits.discard_granularity = sz;
> +               queue->limits.discard_alignment = sz;
> +               queue->limits.discard_granularity = sz;
>         } else {
>                 ns->queue->limits.discard_alignment = logical_block_size;
>                 ns->queue->limits.discard_granularity = logical_block_size;
>         }
> -       blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
> -       blk_queue_max_discard_segments(ns->queue, NVME_DSM_MAX_RANGES);
> -       queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
> +       blk_queue_max_discard_sectors(queue, UINT_MAX);
> +       blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
> +       queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, queue);
>
>         if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
> -               blk_queue_max_write_zeroes_sectors(ns->queue, UINT_MAX);
> +               blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
>  }
>
>  static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
> @@ -1249,17 +1342,25 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>         if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
>                 nvme_prep_integrity(disk, id, bs);
>         blk_queue_logical_block_size(ns->queue, bs);
> +       blk_queue_logical_block_size(ns->head->disk->queue, bs);
>         if (ns->noiob)
>                 nvme_set_chunk_size(ns);
>         if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
>                 nvme_init_integrity(ns);
> -       if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
> +       if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk)) {
>                 set_capacity(disk, 0);
> -       else
> +               if (ns->head)
> +                       set_capacity(ns->head->disk, 0);
> +       } else {
>                 set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
> +               if (ns->head)
> +                       set_capacity(ns->head->disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
> +       }
>
> -       if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
> -               nvme_config_discard(ns);
> +       if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
> +               nvme_config_discard(ns, ns->queue);
> +               nvme_config_discard(ns, ns->head->disk->queue);
> +       }
>         blk_mq_unfreeze_queue(disk->queue);
>  }
>
> @@ -2404,6 +2505,80 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
>         NULL,
>  };
>
> +static struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
> +{
> +       struct nvme_ns *ns;
> +
> +       list_for_each_entry_rcu(ns, &head->list, siblings) {
> +               if (ns->ctrl->state == NVME_CTRL_LIVE) {
> +                       rcu_assign_pointer(head->current_path, ns);
> +                       return ns;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static blk_qc_t nvme_make_request(struct request_queue *q, struct bio *bio)
> +{
> +       struct nvme_ns_head *head = q->queuedata;
> +       struct device *dev = disk_to_dev(head->disk);
> +       struct nvme_ns *ns;
> +       blk_qc_t ret = BLK_QC_T_NONE;
> +       int srcu_idx;
> +
> +       srcu_idx = srcu_read_lock(&head->srcu);
> +       ns = srcu_dereference(head->current_path, &head->srcu);
> +       if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
> +               ns = nvme_find_path(head);
> +       if (likely(ns)) {
> +               bio->bi_disk = ns->disk;
> +               bio->bi_opf |= REQ_NVME_MPATH;
> +               ret = direct_make_request(bio);
> +       } else if (!list_empty_careful(&head->list)) {
> +               dev_warn_ratelimited(dev, "no path available - requeing I/O\n");
> +
> +               spin_lock_irq(&head->requeue_lock);
> +               bio_list_add(&head->requeue_list, bio);
> +               spin_unlock_irq(&head->requeue_lock);
> +       } else {
> +               dev_warn_ratelimited(dev, "no path - failing I/O\n");
> +
> +               bio->bi_status = BLK_STS_IOERR;
> +               bio_endio(bio);
> +       }
> +
> +       srcu_read_unlock(&head->srcu, srcu_idx);
> +       return ret;
> +}
> +
> +static const struct block_device_operations nvme_subsys_ops = {
> +       .owner          = THIS_MODULE,
> +};
> +
> +static void nvme_requeue_work(struct work_struct *work)
> +{
> +       struct nvme_ns_head *head =
> +               container_of(work, struct nvme_ns_head, requeue_work);
> +       struct bio *bio, *next;
> +
> +       spin_lock_irq(&head->requeue_lock);
> +       next = bio_list_get(&head->requeue_list);
> +       spin_unlock_irq(&head->requeue_lock);
> +
> +       while ((bio = next) != NULL) {
> +               next = bio->bi_next;
> +               bio->bi_next = NULL;
> +
> +               /*
> +                * Reset disk to the mpath node and resubmit to select a new
> +                * path.
> +                */
> +               bio->bi_disk = head->disk;
> +               direct_make_request(bio);
> +       }
> +}
> +
>  static struct nvme_ns_head *__nvme_find_ns_head(struct nvme_subsystem *subsys,
>                 unsigned nsid)
>  {
> @@ -2439,6 +2614,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>                 unsigned nsid, struct nvme_id_ns *id)
>  {
>         struct nvme_ns_head *head;
> +       struct request_queue *q;
>         int ret = -ENOMEM;
>
>         head = kzalloc(sizeof(*head), GFP_KERNEL);
> @@ -2447,6 +2623,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>
>         INIT_LIST_HEAD(&head->list);
>         head->ns_id = nsid;
> +       bio_list_init(&head->requeue_list);
> +       spin_lock_init(&head->requeue_lock);
> +       INIT_WORK(&head->requeue_work, nvme_requeue_work);
>         init_srcu_struct(&head->srcu);
>         kref_init(&head->ref);
>
> @@ -2459,8 +2638,37 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>                 goto out_free_head;
>         }
>
> +       ret = -ENOMEM;
> +       q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
> +       if (!q)
> +               goto out_free_head;
> +       q->queuedata = head;
> +       blk_queue_make_request(q, nvme_make_request);
> +       queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
> +       /* set to a default value for 512 until disk is validated */
> +       blk_queue_logical_block_size(q, 512);
> +       nvme_set_queue_limits(ctrl, q);
> +
> +       head->instance = ida_simple_get(&nvme_disk_ida, 1, 0, GFP_KERNEL);
> +       if (head->instance < 0)
> +               goto out_cleanup_queue;
> +
> +       head->disk = alloc_disk(0);
> +       if (!head->disk)
> +               goto out_ida_remove;
> +       head->disk->fops = &nvme_subsys_ops;
> +       head->disk->private_data = head;
> +       head->disk->queue = q;
> +       head->disk->flags = GENHD_FL_EXT_DEVT;
> +       sprintf(head->disk->disk_name, "nvme/ns%d", head->instance);
> +
>         list_add_tail(&head->entry, &ctrl->subsys->nsheads);
>         return head;
> +
> +out_ida_remove:
> +       ida_simple_remove(&nvme_disk_ida, head->instance);
> +out_cleanup_queue:
> +       blk_cleanup_queue(q);
>  out_free_head:
>         cleanup_srcu_struct(&head->srcu);
>         kfree(head);
> @@ -2469,7 +2677,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  }
>
>  static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
> -               struct nvme_id_ns *id)
> +               struct nvme_id_ns *id, bool *new)
>  {
>         struct nvme_ctrl *ctrl = ns->ctrl;
>         bool is_shared = id->nmic & (1 << 0);
> @@ -2485,6 +2693,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>                         ret = PTR_ERR(head);
>                         goto out_unlock;
>                 }
> +
> +               *new = true;
>         } else {
>                 struct nvme_ns_ids ids;
>
> @@ -2496,6 +2706,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>                         ret = -EINVAL;
>                         goto out_unlock;
>                 }
> +
> +               *new = false;
>         }
>
>         list_add_tail(&ns->siblings, &head->list);
> @@ -2565,6 +2777,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>         struct nvme_id_ns *id;
>         char disk_name[DISK_NAME_LEN];
>         int node = dev_to_node(ctrl->dev);
> +       bool new = true;
>
>         ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>         if (!ns)
> @@ -2597,7 +2810,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>         if (id->ncap == 0)
>                 goto out_free_id;
>
> -       if (nvme_init_ns_head(ns, nsid, id))
> +       if (nvme_init_ns_head(ns, nsid, id, &new))
>                 goto out_free_id;
>
>         if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
> @@ -2636,6 +2849,19 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>         if (ns->ndev && nvme_nvm_register_sysfs(ns))
>                 pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
>                         ns->disk->disk_name);
> +
> +       if (new)
> +               add_disk(ns->head->disk);
> +
> +       if (sysfs_create_link(&disk_to_dev(ns->disk)->kobj,
> +                       &disk_to_dev(ns->head->disk)->kobj, "mpath"))
> +               pr_warn("%s: failed to create sysfs link to mpath device\n",
> +                       ns->disk->disk_name);
> +       if (sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
> +                       &disk_to_dev(ns->disk)->kobj, ns->disk->disk_name))
> +               pr_warn("%s: failed to create sysfs link from mpath device\n",
> +                       ns->disk->disk_name);
> +
>         return;
>   out_unlink_ns:
>         mutex_lock(&ctrl->subsys->lock);
> @@ -2663,6 +2889,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>                         blk_integrity_unregister(ns->disk);
>                 sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
>                                         &nvme_ns_attr_group);
> +               sysfs_remove_link(&disk_to_dev(ns->disk)->kobj, "mpath");
> +               sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
> +                               ns->disk->disk_name);
>                 if (ns->ndev)
>                         nvme_nvm_unregister_sysfs(ns);
>                 del_gendisk(ns->disk);
> @@ -2670,8 +2899,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>         }
>
>         mutex_lock(&ns->ctrl->subsys->lock);
> -       if (head)
> +       if (head) {
> +               rcu_assign_pointer(head->current_path, NULL);
>                 list_del_rcu(&ns->siblings);
> +       }
>         mutex_unlock(&ns->ctrl->subsys->lock);
>
>         mutex_lock(&ns->ctrl->namespaces_mutex);
> @@ -3222,6 +3453,7 @@ int __init nvme_core_init(void)
>
>  void nvme_core_exit(void)
>  {
> +       ida_destroy(&nvme_disk_ida);
>         class_destroy(nvme_class);
>         __unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
>         destroy_workqueue(nvme_wq);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a724d2597c4c..2062e62c9769 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -94,6 +94,11 @@ struct nvme_request {
>         u16                     status;
>  };
>
> +/*
> + * Mark a bio as coming in through the mpath node.
> + */
> +#define REQ_NVME_MPATH         REQ_DRV
> +
>  enum {
>         NVME_REQ_CANCELLED              = (1 << 0),
>  };
> @@ -225,12 +230,18 @@ struct nvme_ns_ids {
>   * only ever has a single entry for private namespaces.
>   */
>  struct nvme_ns_head {
> +       struct nvme_ns __rcu    *current_path;
> +       struct gendisk          *disk;
>         struct list_head        list;
>         struct srcu_struct      srcu;
> +       struct bio_list         requeue_list;
> +       spinlock_t              requeue_lock;
> +       struct work_struct      requeue_work;
>         unsigned                ns_id;
>         struct nvme_ns_ids      ids;
>         struct list_head        entry;
>         struct kref             ref;
> +       int                     instance;
>  };
>
>  struct nvme_ns {
> --
> 2.14.1
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
