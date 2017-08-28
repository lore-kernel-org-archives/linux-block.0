Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 07/10] nvme: track shared namespaces
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
Date: Mon, 28 Aug 2017 09:51:14 +0300
MIME-Version: 1.0
In-Reply-To: <20170823175815.3646-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 23/08/17 20:58, Christoph Hellwig wrote:
> Introduce a new struct nvme_ns_head [1] that holds information about
> an actual namespace, unlike struct nvme_ns, which only holds the
> per-controller namespace information.  For private namespaces there
> is a 1:1 relation of the two, but for shared namespaces this lets us
> discover all the paths to it.  For now only the identifiers are moved
> to the new structure, but most of the information in struct nvme_ns
> should eventually move over.
> 
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.

I haven't read the later patches yet, but what requires sleep in the
path selection?

> 
> [1] comments welcome if you have a better name for it, the current one is
>      horrible.  One idea would be to rename the current struct nvme_ns
>      to struct nvme_ns_link or similar and use the nvme_ns name for the
>      new structure.  But that would involve a lot of churn.

maybe nvme_ns_primary?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c     | 218 +++++++++++++++++++++++++++++++++++--------
>   drivers/nvme/host/lightnvm.c |  14 +--
>   drivers/nvme/host/nvme.h     |  26 +++++-
>   3 files changed, 208 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8884000dfbdd..abc5911a8a66 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -249,10 +249,28 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   }
>   EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
>   
> +static void nvme_destroy_ns_head(struct kref *ref)
> +{
> +	struct nvme_ns_head *head =
> +		container_of(ref, struct nvme_ns_head, ref);
> +
> +	list_del_init(&head->entry);
> +	cleanup_srcu_struct(&head->srcu);
> +	kfree(head);
> +}
> +
> +static void nvme_put_ns_head(struct nvme_ns_head *head)
> +{
> +	kref_put(&head->ref, nvme_destroy_ns_head);
> +}
> +
>   static void nvme_free_ns(struct kref *kref)
>   {
>   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>   
> +	if (ns->head)
> +		nvme_put_ns_head(ns->head);
> +
>   	if (ns->ndev)
>   		nvme_nvm_unregister(ns);
>   
> @@ -422,7 +440,7 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
>   {
>   	memset(cmnd, 0, sizeof(*cmnd));
>   	cmnd->common.opcode = nvme_cmd_flush;
> -	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
> +	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
>   }
>   
>   static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
> @@ -453,7 +471,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   
>   	memset(cmnd, 0, sizeof(*cmnd));
>   	cmnd->dsm.opcode = nvme_cmd_dsm;
> -	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
> +	cmnd->dsm.nsid = cpu_to_le32(ns->head->ns_id);
>   	cmnd->dsm.nr = cpu_to_le32(segments - 1);
>   	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
>   
> @@ -492,7 +510,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>   
>   	memset(cmnd, 0, sizeof(*cmnd));
>   	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
> -	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
> +	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
>   	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
>   	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
>   
> @@ -977,7 +995,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>   	memset(&c, 0, sizeof(c));
>   	c.rw.opcode = io.opcode;
>   	c.rw.flags = io.flags;
> -	c.rw.nsid = cpu_to_le32(ns->ns_id);
> +	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
>   	c.rw.slba = cpu_to_le64(io.slba);
>   	c.rw.length = cpu_to_le16(io.nblocks);
>   	c.rw.control = cpu_to_le16(io.control);
> @@ -1041,7 +1059,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>   	switch (cmd) {
>   	case NVME_IOCTL_ID:
>   		force_successful_syscall_return();
> -		return ns->ns_id;
> +		return ns->head->ns_id;
>   	case NVME_IOCTL_ADMIN_CMD:
>   		return nvme_user_cmd(ns->ctrl, NULL, (void __user *)arg);
>   	case NVME_IOCTL_IO_CMD:
> @@ -1248,7 +1266,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>   		return -ENODEV;
>   	}
>   
> -	id = nvme_identify_ns(ctrl, ns->ns_id);
> +	id = nvme_identify_ns(ctrl, ns->head->ns_id);
>   	if (!id)
>   		return -ENODEV;
>   
> @@ -1257,12 +1275,12 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>   		goto out;
>   	}
>   
> -	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
> -	if (!uuid_equal(&ns->uuid, &uuid) ||
> -	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
> -	    memcmp(&ns->eui, &eui64, sizeof(ns->eui))) {
> +	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, eui64, nguid, &uuid);
> +	if (!uuid_equal(&ns->head->uuid, &uuid) ||
> +	    memcmp(&ns->head->nguid, &nguid, sizeof(ns->head->nguid)) ||
> +	    memcmp(&ns->head->eui64, &eui64, sizeof(ns->head->eui64))) {
>   		dev_err(ctrl->device,
> -			"identifiers changed for nsid %d\n", ns->ns_id);
> +			"identifiers changed for nsid %d\n", ns->head->ns_id);
>   		ret = -ENODEV;
>   	}
>   
> @@ -1303,7 +1321,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.common.opcode = op;
> -	c.common.nsid = cpu_to_le32(ns->ns_id);
> +	c.common.nsid = cpu_to_le32(ns->head->ns_id);
>   	c.common.cdw10[0] = cpu_to_le32(cdw10);
>   
>   	return nvme_submit_sync_cmd(ns->queue, &c, data, 16);
> @@ -1812,6 +1830,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	if (!subsys)
>   		return -ENOMEM;
>   	INIT_LIST_HEAD(&subsys->ctrls);
> +	INIT_LIST_HEAD(&subsys->nsheads);
>   	kref_init(&subsys->ref);
>   	nvme_init_subnqn(subsys, ctrl, id);
>   	mutex_init(&subsys->lock);
> @@ -2132,14 +2151,14 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
>   	int serial_len = sizeof(ctrl->serial);
>   	int model_len = sizeof(ctrl->model);
>   
> -	if (!uuid_is_null(&ns->uuid))
> -		return sprintf(buf, "uuid.%pU\n", &ns->uuid);
> +	if (!uuid_is_null(&ns->head->uuid))
> +		return sprintf(buf, "uuid.%pU\n", &ns->head->uuid);
>   
> -	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
> -		return sprintf(buf, "eui.%16phN\n", ns->nguid);
> +	if (memchr_inv(ns->head->nguid, 0, sizeof(ns->head->nguid)))
> +		return sprintf(buf, "eui.%16phN\n", ns->head->nguid);
>   
> -	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
> -		return sprintf(buf, "eui.%8phN\n", ns->eui);
> +	if (memchr_inv(ns->head->eui64, 0, sizeof(ns->head->eui64)))
> +		return sprintf(buf, "eui.%8phN\n", ns->head->eui64);
>   
>   	while (serial_len > 0 && (ctrl->serial[serial_len - 1] == ' ' ||
>   				  ctrl->serial[serial_len - 1] == '\0'))
> @@ -2149,7 +2168,8 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
>   		model_len--;
>   
>   	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", ctrl->vid,
> -		serial_len, ctrl->serial, model_len, ctrl->model, ns->ns_id);
> +		serial_len, ctrl->serial, model_len, ctrl->model,
> +		ns->head->ns_id);
>   }
>   static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
>   
> @@ -2157,7 +2177,7 @@ static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
>   			  char *buf)
>   {
>   	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> -	return sprintf(buf, "%pU\n", ns->nguid);
> +	return sprintf(buf, "%pU\n", ns->head->nguid);
>   }
>   static DEVICE_ATTR(nguid, S_IRUGO, nguid_show, NULL);
>   
> @@ -2169,12 +2189,12 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>   	/* For backward compatibility expose the NGUID to userspace if
>   	 * we have no UUID set
>   	 */
> -	if (uuid_is_null(&ns->uuid)) {
> +	if (uuid_is_null(&ns->head->uuid)) {
>   		printk_ratelimited(KERN_WARNING
>   				   "No UUID available providing old NGUID\n");
> -		return sprintf(buf, "%pU\n", ns->nguid);
> +		return sprintf(buf, "%pU\n", ns->head->nguid);
>   	}
> -	return sprintf(buf, "%pU\n", &ns->uuid);
> +	return sprintf(buf, "%pU\n", &ns->head->uuid);
>   }
>   static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
>   
> @@ -2182,7 +2202,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
>   								char *buf)
>   {
>   	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> -	return sprintf(buf, "%8phd\n", ns->eui);
> +	return sprintf(buf, "%8phd\n", ns->head->eui64);
>   }
>   static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
>   
> @@ -2190,7 +2210,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
>   								char *buf)
>   {
>   	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> -	return sprintf(buf, "%d\n", ns->ns_id);
> +	return sprintf(buf, "%d\n", ns->head->ns_id);
>   }
>   static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
>   
> @@ -2210,16 +2230,16 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
>   	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>   
>   	if (a == &dev_attr_uuid.attr) {
> -		if (uuid_is_null(&ns->uuid) ||
> -		    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
> +		if (uuid_is_null(&ns->head->uuid) ||
> +		    !memchr_inv(ns->head->nguid, 0, sizeof(ns->head->nguid)))
>   			return 0;
>   	}
>   	if (a == &dev_attr_nguid.attr) {
> -		if (!memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
> +		if (!memchr_inv(ns->head->nguid, 0, sizeof(ns->head->nguid)))
>   			return 0;
>   	}
>   	if (a == &dev_attr_eui.attr) {
> -		if (!memchr_inv(ns->eui, 0, sizeof(ns->eui)))
> +		if (!memchr_inv(ns->head->eui64, 0, sizeof(ns->head->eui64)))
>   			return 0;
>   	}
>   	return a->mode;
> @@ -2357,12 +2377,122 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
>   	NULL,
>   };
>   
> +static struct nvme_ns_head *__nvme_find_ns_head(struct nvme_subsystem *subsys,
> +		unsigned nsid)
> +{
> +	struct nvme_ns_head *h;
> +
> +	lockdep_assert_held(&subsys->lock);
> +
> +	list_for_each_entry(h, &subsys->nsheads, entry) {
> +		if (h->ns_id == nsid && kref_get_unless_zero(&h->ref))
> +			return h;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int __nvme_check_ids(struct nvme_subsystem *subsys,
> +		struct nvme_ns_head *new)
> +{
> +	struct nvme_ns_head *h;
> +
> +	lockdep_assert_held(&subsys->lock);
> +
> +	list_for_each_entry(h, &subsys->nsheads, entry) {
> +		if ((!uuid_is_null(&new->uuid) &&
> +		     uuid_equal(&new->uuid, &h->uuid)) ||
> +		    (memchr_inv(new->nguid, 0, sizeof(new->nguid)) &&
> +		     memcmp(&new->nguid, &h->nguid, sizeof(new->nguid))) ||
> +		    (memchr_inv(new->eui64, 0, sizeof(new->eui64)) &&
> +		     memcmp(&new->eui64, &h->eui64, sizeof(new->eui64))))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> +		unsigned nsid, struct nvme_id_ns *id)
> +{
> +	struct nvme_ns_head *head;
> +	int ret = -ENOMEM;
> +
> +	head = kzalloc(sizeof(*head), GFP_KERNEL);
> +	if (!head)
> +		goto out;
> +
> +	INIT_LIST_HEAD(&head->list);
> +	head->ns_id = nsid;
> +	init_srcu_struct(&head->srcu);
> +	kref_init(&head->ref);
> +
> +	nvme_report_ns_ids(ctrl, nsid, id, head->eui64, head->nguid,
> +			&head->uuid);
> +
> +	ret = __nvme_check_ids(ctrl->subsys, head);
> +	if (ret) {
> +		dev_err(ctrl->device,
> +			"duplicate IDs for nsid %d\n", nsid);
> +		goto out_free_head;
> +	}
> +
> +	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
> +	return head;
> +out_free_head:
> +	cleanup_srcu_struct(&head->srcu);
> +	kfree(head);
> +out:
> +	return ERR_PTR(ret);
> +}
> +
> +static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
> +		struct nvme_id_ns *id)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +	bool is_shared = id->nmic & (1 << 0);
> +	struct nvme_ns_head *head = NULL;
> +	int ret = 0;
> +
> +	mutex_lock(&ctrl->subsys->lock);
> +	if (is_shared)
> +		head = __nvme_find_ns_head(ctrl->subsys, nsid);
> +	if (!head) {
> +		head = nvme_alloc_ns_head(ctrl, nsid, id);
> +		if (IS_ERR(head)) {
> +			ret = PTR_ERR(head);
> +			goto out_unlock;
> +		}
> +	} else {
> +		u8 eui64[8] = { 0 }, nguid[16] = { 0 };
> +		uuid_t uuid = uuid_null;
> +
> +		nvme_report_ns_ids(ctrl, nsid, id, eui64, nguid, &uuid);
> +		if (!uuid_equal(&head->uuid, &uuid) ||
> +		    memcmp(&head->nguid, &nguid, sizeof(head->nguid)) ||
> +		    memcmp(&head->eui64, &eui64, sizeof(head->eui64))) {

Suggestion, given that this matching pattern returns in several places
would it be better to move it to nvme_ns_match_id()?

>   
> +/*
> + * Anchor structure for namespaces.  There is one for each namespace in a
> + * NVMe subsystem that any of our controllers can see, and the namespace
> + * structure for each controller is chained of it.  For private namespaces
> + * there is a 1:1 relation to our namespace structures, that is ->list
> + * only ever has a single entry for private namespaces.
> + */
> +struct nvme_ns_head {
> +	struct list_head	list;

Maybe siblings is a better name than list,
and the nvme_ns list_head should be called
sibling_entry (or just sibling)?

> +	struct srcu_struct      srcu;
> +	unsigned		ns_id;
> +	u8			eui64[8];
> +	u8			nguid[16];
> +	uuid_t			uuid;
> +	struct list_head	entry;
> +	struct kref		ref;
> +};
> +
>   struct nvme_ns {
>   	struct list_head list;
>   
>   	struct nvme_ctrl *ctrl;
>   	struct request_queue *queue;
>   	struct gendisk *disk;
> +	struct list_head siblings;
>   	struct nvm_dev *ndev;
>   	struct kref kref;
> +	struct nvme_ns_head *head;
>   	int instance;
>   
> -	u8 eui[8];
> -	u8 nguid[16];
> -	uuid_t uuid;
> -
> -	unsigned ns_id;
>   	int lba_shift;
>   	u16 ms;
>   	u16 sgs;
> 

Overall this looks good.
