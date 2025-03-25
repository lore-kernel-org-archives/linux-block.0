Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DE1F4E4B
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916084; cv=none; b=as5ma7TGxJeJihBPcpjqr0FF5AGdcFrtyCOuHxcG6r47Yemruia9djPVY5cD1X0hC3Rx7k6FR9tavLjb2DqjGGdHJ3nlbwa5pf18+t1WTl2/rilcMJOt9munbaM8mI4EaaKawjSEHMUPbt9QgbuKEaVWW18q2b14HQgEPb++/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916084; c=relaxed/simple;
	bh=8xNTbpTxJyYg2XZgY0LljqGVUgyGlof4RGG0JzYRJZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhgxM4YJEJWRKCP8XfXrCJYIWrtuxXOBua4Io4IzQ8IXtvNkId8ycZy15wln5zoScloQXZe9XE4tNjvBb8vxfLfsOXhSCD5x6Owupa4NTK4h6MIeazgyh5Rw3MFsev0WDM9cEQ9DY6ixRSP9BRxuz43xrli/AruYkjt2xuYhhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWGdpBo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWGdpBo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742916081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqX3+iVgE0PoGLXMopxUc0Cv31Mwe1StyDlAHYVPFv0=;
	b=NWGdpBo7HL3djSy04/wOgRfG4OovQ0jmyLC3ogFE+A5V1GYDc+5ObrO3kTrLMrcPot4FlP
	5/PfUCWaPGilTK/wGm/tfWF/cgCErAQ29NQFlHNcmZCU+BIAHW0Fz5P7VXN9yYtVW3mhmQ
	8MpIO0GSac7PQtKJA9TI04/1PGLPzMI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-BIRrtC_JMyqPbRKJfxql1Q-1; Tue,
 25 Mar 2025 11:21:17 -0400
X-MC-Unique: BIRrtC_JMyqPbRKJfxql1Q-1
X-Mimecast-MFC-AGG-ID: BIRrtC_JMyqPbRKJfxql1Q_1742916076
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9BFB196D2D3;
	Tue, 25 Mar 2025 15:21:15 +0000 (UTC)
Received: from [10.22.88.188] (unknown [10.22.88.188])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 240C2180B48D;
	Tue, 25 Mar 2025 15:21:12 +0000 (UTC)
Message-ID: <07aae606-ce16-4d6b-8d93-cdefd2f430ff@redhat.com>
Date: Tue, 25 Mar 2025 11:21:12 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of the
 multipath head node
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
 axboe@kernel.dk, gjoyce@ibm.com, jmeneghi@redhat.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-2-nilay@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250321063901.747605-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Thanks for the patch Nilay!

I've rebased this patch onto my changes at:

https://lore.kernel.org/linux-nvme/20250322232848.225140-1-jmeneghi@redhat.com/T/

This patch applies and clean compiles w/no problems.

I will test this out after LSF/MM with my fabrics testbed and get back to you.

linux(nilay_mp) > git log --oneline -5
0834c24969a1 (HEAD -> nilay_mp) nvme-multipath: introduce delayed removal of the multipath head node
f9ca6ae944e4 (johnm/config_ana5, config_ana5) nvme: update the multipath warning in nvme_init_ns_head
79feb9e51d89 nvme-multipath: add the NVME_MULTIPATH_PARAM config option
7e2928cacd71 nvme-multipath: change the NVME_MULTIPATH config option
64ea88e3afa8 (tag: nvme-6.15-2025-03-20, nvme/nvme-6.15, nvme-6.15) nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi)

/John

On 3/21/25 2:37 AM, Nilay Shroff wrote:
> Currently, the multipath head node of a PCIe NVMe disk is removed
> immediately as soon as all paths of the disk are removed. However,
> this can cause issues in scenarios where:
> 
> - The disk hot-removal followed by re-addition.
> - Transient PCIe link failures that trigger re-enumeration,
>    temporarily removing and then restoring the disk.
> 
> In these cases, removing the head node prematurely may lead to a head
> disk node name change upon re-addition, requiring applications to
> reopen their handles if they were performing I/O during the failure.
> 
> To address this, introduce a delayed removal mechanism of head disk
> node. During transient failure, instead of immediate removal of head
> disk node, the system waits for a configurable timeout, allowing the
> disk to recover. Additionally, please note that the head disk node is
> now always created for all types of NVMe disks (single-ported or multi-
> ported), unless the multipath module parameter is explicitly set to
> false or CONFIG_NVME_MULTIPATH is disabled.
> 
> During transient disk failure, if application sends any IO then we
> queue it instead of failing such IO immediately. If the disk comes back
> online within the timeout, the queued IOs are resubmitted to the disk
> ensuring seamless operation. In case disk couldn't recover from the
> failure then queued IOs are failed to its completion and application
> receives the error.
> 
> So this way, if disk comes back online within the configured period,
> the head node remains unchanged, ensuring uninterrupted workloads
> without requiring applications to reopen device handles.
> 
> A new sysfs attribute, named "delayed_shutdown_sec" is added for user
> who wish to configure time for the delayed removal of head disk node.
> The default value of this attribute is set to 0 seconds ensuring no
> behavior change unless explicitly configured.
> 
> Link: https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
> Link: https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> [nilay: reworked based on the original idea/POC from Christoph and Keith]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  18 +++---
>   drivers/nvme/host/multipath.c | 118 +++++++++++++++++++++++++++++-----
>   drivers/nvme/host/nvme.h      |   4 ++
>   drivers/nvme/host/sysfs.c     |  13 ++++
>   4 files changed, 127 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 870314c52107..e798809a8325 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3562,7 +3562,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>   		 */
>   		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
>   			continue;
> -		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
> +		if (nvme_tryget_ns_head(h))
>   			return h;
>   	}
>   
> @@ -3690,6 +3690,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>   	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>   	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>   	kref_init(&head->ref);
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		set_bit(NVME_NSHEAD_FABRICS, &head->flags);
> +#endif
>   
>   	if (head->ids.csi) {
>   		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
> @@ -3806,7 +3810,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		}
>   	} else {
>   		ret = -EINVAL;
> -		if (!info->is_shared || !head->shared) {
> +		if ((!info->is_shared || !head->shared) &&
> +		    !list_empty(&head->list)) {
>   			dev_err(ctrl->device,
>   				"Duplicate unshared namespace %d\n",
>   				info->nsid);
> @@ -3988,8 +3993,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   
>   static void nvme_ns_remove(struct nvme_ns *ns)
>   {
> -	bool last_path = false;
> -
>   	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>   		return;
>   
> @@ -4009,10 +4012,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list)) {
> -		list_del_init(&ns->head->entry);
> -		last_path = true;
> -	}
>   	mutex_unlock(&ns->ctrl->subsys->lock);
>   
>   	/* guarantee not available in head->list */
> @@ -4030,8 +4029,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	mutex_unlock(&ns->ctrl->namespaces_lock);
>   	synchronize_srcu(&ns->ctrl->srcu);
>   
> -	if (last_path)
> -		nvme_mpath_shutdown_disk(ns->head);
> +	nvme_mpath_shutdown_disk(ns->head);
>   	nvme_put_ns(ns);
>   }
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 6b12ca80aa27..0f54889bd483 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -421,7 +421,6 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   		return nvme_numa_path(head);
>   	}
>   }
> -
>   static bool nvme_available_path(struct nvme_ns_head *head)
>   {
>   	struct nvme_ns *ns;
> @@ -429,6 +428,16 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>   		return NULL;
>   
> +	/*
> +	 * For non-fabric controllers we support delayed removal of head disk
> +	 * node. If we reached up to here then it means that head disk is still
> +	 * alive and so we assume here that even if there's no path available
> +	 * maybe due to the transient link failure, we could queue up the IO
> +	 * and later when path becomes ready we re-submit queued IO.
> +	 */
> +	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
> +		return true;
> +
>   	list_for_each_entry_srcu(ns, &head->list, siblings,
>   				 srcu_read_lock_held(&head->srcu)) {
>   		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
> @@ -444,7 +453,6 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   	}
>   	return false;
>   }
> -
>   static void nvme_ns_head_submit_bio(struct bio *bio)
>   {
>   	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
> @@ -617,6 +625,40 @@ static void nvme_requeue_work(struct work_struct *work)
>   	}
>   }
>   
> +static void nvme_remove_head(struct nvme_ns_head *head)
> +{
> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +		/*
> +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +		 * to allow multipath to fail all I/O.
> +		 */
> +		kblockd_schedule_work(&head->requeue_work);
> +
> +		nvme_cdev_del(&head->cdev, &head->cdev_device);
> +		synchronize_srcu(&head->srcu);
> +		del_gendisk(head->disk);
> +		nvme_put_ns_head(head);
> +	}
> +}
> +
> +static void nvme_remove_head_work(struct work_struct *work)
> +{
> +	struct nvme_ns_head *head = container_of(to_delayed_work(work),
> +			struct nvme_ns_head, remove_work);
> +	bool shutdown = false;
> +
> +	mutex_lock(&head->subsys->lock);
> +	if (list_empty(&head->list)) {
> +		list_del_init(&head->entry);
> +		shutdown = true;
> +	}
> +	mutex_unlock(&head->subsys->lock);
> +	if (shutdown)
> +		nvme_remove_head(head);
> +
> +	module_put(THIS_MODULE);
> +}
> +
>   int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   {
>   	struct queue_limits lim;
> @@ -626,14 +668,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	spin_lock_init(&head->requeue_lock);
>   	INIT_WORK(&head->requeue_work, nvme_requeue_work);
>   	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
> +	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
> +	head->delayed_shutdown_sec = 0;
>   
>   	/*
> -	 * Add a multipath node if the subsystems supports multiple controllers.
> -	 * We also do this for private namespaces as the namespace sharing flag
> -	 * could change after a rescan.
> +	 * A head disk node is always created for all types of NVMe disks
> +	 * (single-ported and multi-ported), unless the multipath module
> +	 * parameter is explicitly set to false.
>   	 */
> -	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
> -	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
> +	if (!multipath)
>   		return 0;
>   
>   	blk_set_stacking_limits(&lim);
> @@ -659,6 +702,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
>   	sprintf(head->disk->disk_name, "nvme%dn%d",
>   			ctrl->subsys->instance, head->instance);
> +	nvme_tryget_ns_head(head);
>   	return 0;
>   }
>   
> @@ -1015,6 +1059,40 @@ static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr
>   }
>   DEVICE_ATTR_RO(numa_nodes);
>   
> +static ssize_t delayed_shutdown_sec_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +	int ret;
> +
> +	mutex_lock(&head->subsys->lock);
> +	ret = sysfs_emit(buf, "%u\n", head->delayed_shutdown_sec);
> +	mutex_unlock(&head->subsys->lock);
> +	return ret;
> +}
> +
> +static ssize_t delayed_shutdown_sec_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +	unsigned int sec;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &sec);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&head->subsys->lock);
> +	head->delayed_shutdown_sec = sec;
> +	mutex_unlock(&head->subsys->lock);
> +
> +	return count;
> +}
> +
> +DEVICE_ATTR_RW(delayed_shutdown_sec);
> +
>   static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>   		struct nvme_ana_group_desc *desc, void *data)
>   {
> @@ -1138,18 +1216,26 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
>   
>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>   {
> -	if (!head->disk)
> -		return;
> -	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> -		nvme_cdev_del(&head->cdev, &head->cdev_device);
> +	mutex_lock(&head->subsys->lock);
> +
> +	if (!list_empty(&head->list) || !head->disk)
> +		goto out;
> +
> +	if (head->delayed_shutdown_sec) {
>   		/*
> -		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> -		 * to allow multipath to fail all I/O.
> +		 * Ensure that no one could remove this module while the head
> +		 * remove work is pending.
>   		 */
> -		synchronize_srcu(&head->srcu);
> -		kblockd_schedule_work(&head->requeue_work);
> -		del_gendisk(head->disk);
> +		if (!try_module_get(THIS_MODULE))
> +			goto out;
> +		queue_delayed_work(nvme_wq, &head->remove_work,
> +				head->delayed_shutdown_sec * HZ);
> +	} else {
> +		list_del_init(&head->entry);
> +		nvme_remove_head(head);
>   	}
> +out:
> +	mutex_unlock(&head->subsys->lock);
>   }
>   
>   void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 51e078642127..4375357b8cd7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -503,7 +503,10 @@ struct nvme_ns_head {
>   	struct work_struct	partition_scan_work;
>   	struct mutex		lock;
>   	unsigned long		flags;
> +	struct delayed_work	remove_work;
> +	unsigned int		delayed_shutdown_sec;
>   #define NVME_NSHEAD_DISK_LIVE	0
> +#define NVME_NSHEAD_FABRICS	1
>   	struct nvme_ns __rcu	*current_path[];
>   #endif
>   };
> @@ -986,6 +989,7 @@ extern struct device_attribute dev_attr_ana_grpid;
>   extern struct device_attribute dev_attr_ana_state;
>   extern struct device_attribute dev_attr_queue_depth;
>   extern struct device_attribute dev_attr_numa_nodes;
> +extern struct device_attribute dev_attr_delayed_shutdown_sec;
>   extern struct device_attribute subsys_attr_iopolicy;
>   
>   static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 6d31226f7a4f..170897349093 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -260,6 +260,7 @@ static struct attribute *nvme_ns_attrs[] = {
>   	&dev_attr_ana_state.attr,
>   	&dev_attr_queue_depth.attr,
>   	&dev_attr_numa_nodes.attr,
> +	&dev_attr_delayed_shutdown_sec.attr,
>   #endif
>   	&dev_attr_io_passthru_err_log_enabled.attr,
>   	NULL,
> @@ -296,6 +297,18 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
>   		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
>   			return 0;
>   	}
> +	if (a == &dev_attr_delayed_shutdown_sec.attr) {
> +		struct nvme_ns_head *head = dev_to_ns_head(dev);
> +		struct gendisk *disk = dev_to_disk(dev);
> +
> +		/*
> +		 * This attribute is only valid for head node and non-fabric
> +		 * controllers.
> +		 */
> +		if (!nvme_disk_is_ns_head(disk) ||
> +				test_bit(NVME_NSHEAD_FABRICS, &head->flags))
> +			return 0;
> +	}
>   #endif
>   	return a->mode;
>   }

