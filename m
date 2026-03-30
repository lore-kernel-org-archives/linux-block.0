Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3319C546
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837445; cv=none; b=H502s8O5+Sbg2HMTf0qbS5TJfCQLN+mN/WFbfZgQ6GWQ2XohteTTtsHLK4qpKsNUSsfLKGz5Lf35MPAueYrerRF2yhOU0fZl8Ua/QAxL8KdXMs5X5k/kO2u0Ued2SGIUkNo+u5nY+xQPR0OQ3UVbAh0jQ1H5rHDvqyHddnJgre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837445; c=relaxed/simple;
	bh=v4sgZ+v/+e3HN0H4/Zo7HV8wnFpnJQV0JXvuJcgrfAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INiOVMwAtgLLGt2R3ko3BGLZA1Is06DxPREePubJ2Lb8Na6tw8U0nxH3wa74OCP1h+nH2DKgtrTZehBJ1HRI06S2SFk5OlV1mk6zNFcbr79NA/7AA1TUU8kwr1DAbIARo/wlIza2HE21VxA2RenN7fwbNfVkB6BG8hlZME3daPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVJatYg3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVJatYg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774837443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnvivTus6JIrHbSWvEQYMyY/rwWFDb3mZzzucQ2w4FY=;
	b=WVJatYg364N2uiz7IJPh0OTtCgiqtk8CFHRdOpScIZ2RnWlqV7O7KFYs889zCYxsJrOLdt
	OFjqCcvEpqzQ56X6B0C83u7QcktuzMELo/Ju86ZG0MpnKE9lvKVyOwokyLHbMUYutrFJev
	XJQZE1aQVlBnJY9AJCxrnjn0251s2cw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-1SDvaFHNOXKI-O4YYwGwZA-1; Sun,
 29 Mar 2026 22:24:01 -0400
X-MC-Unique: 1SDvaFHNOXKI-O4YYwGwZA-1
X-Mimecast-MFC-AGG-ID: 1SDvaFHNOXKI-O4YYwGwZA_1774837439
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E7EC180047F;
	Mon, 30 Mar 2026 02:23:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A2C31955D84;
	Mon, 30 Mar 2026 02:23:49 +0000 (UTC)
Date: Mon, 30 Mar 2026 10:23:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, Kees Cook <kees@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 5/6] null_blk: Support configuring the maximum DMA
 segment size
Message-ID: <acnesO__-9NRkpgY@fedora>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-6-bvanassche@acm.org>
 <c084beea-6c42-41f3-8f85-bf477ab0d893@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c084beea-6c42-41f3-8f85-bf477ab0d893@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Mar 29, 2026 at 06:00:31PM +0530, Nilay Shroff wrote:
> On 3/28/26 2:43 AM, Bart Van Assche wrote:
> > Add support for configuring the maximum DMA segment size. The maximum DMA
> > segment size may be set to a value smaller than the virtual memory page
> > size. Reject invalid max_segment_size values.
> > 
> > Since rq_for_each_segment() may yield bvecs larger than the maximum DMA
> > segment size, add code in the rq_for_each_segment() loop that restricts
> > the bvec length to the maximum DMA segment size.
> > 
> > Cc: Christoph Hellwig<hch@lst.de>
> > Cc: Ming Lei<ming.lei@redhat.com>
> > Cc: Damien Le Moal<damien.lemoal@opensource.wdc.com>
> > Cc: Chaitanya Kulkarni<kch@nvidia.com>
> > Signed-off-by: Bart Van Assche<bvanassche@acm.org>
> > ---
> >   drivers/block/null_blk/main.c     | 43 +++++++++++++++++++++++++++++++
> >   drivers/block/null_blk/null_blk.h |  1 +
> >   2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> > index f8c0fd57e041..d5fbbc5d63ed 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -169,6 +169,32 @@ static int g_max_sectors;
> >   module_param_named(max_sectors, g_max_sectors, int, 0444);
> >   MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
> > +static unsigned int g_max_segment_size = BLK_MAX_SEGMENT_SIZE;
> > +
> > +static int nullb_set_max_segment_size(const char *val,
> > +				      const struct kernel_param *kp)
> > +{
> > +	int res;
> > +
> > +	res = kstrtouint(val, 0, &g_max_segment_size);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	if (g_max_segment_size < BLK_MIN_SEGMENT_SIZE)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct kernel_param_ops max_segment_size_ops = {
> > +	.set = nullb_set_max_segment_size,
> > +	.get = param_get_uint,
> > +};
> > +
> > +module_param_cb(max_segment_size, &max_segment_size_ops, &g_max_segment_size,
> > +		0444);
> > +MODULE_PARM_DESC(max_segment_size, "Maximum size of a DMA segment in bytes");
> > +
> >   static unsigned int nr_devices = 1;
> >   module_param(nr_devices, uint, 0444);
> >   MODULE_PARM_DESC(nr_devices, "Number of devices to register");
> > @@ -442,6 +468,14 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
> >   	return ret;
> >   }
> > +static int nullb_apply_max_segment_size(struct nullb_device *dev,
> > +					unsigned int max_segment_size)
> > +{
> > +	if (max_segment_size < BLK_MIN_SEGMENT_SIZE)
> > +		return -EINVAL;
> > +	return 0;
> > +}
> > +
> >   NULLB_DEVICE_ATTR(size, ulong, NULL);
> >   NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
> >   NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
> > @@ -450,6 +484,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
> >   NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
> >   NULLB_DEVICE_ATTR(blocksize, uint, NULL);
> >   NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
> > +NULLB_DEVICE_ATTR(max_segment_size, uint, nullb_apply_max_segment_size);
> >   NULLB_DEVICE_ATTR(irqmode, uint, NULL);
> >   NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
> >   NULLB_DEVICE_ATTR(index, uint, NULL);
> > @@ -608,6 +643,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
> >   	&nullb_device_attr_index,
> >   	&nullb_device_attr_irqmode,
> >   	&nullb_device_attr_max_sectors,
> > +	&nullb_device_attr_max_segment_size,
> >   	&nullb_device_attr_mbps,
> >   	&nullb_device_attr_memory_backed,
> >   	&nullb_device_attr_no_sched,
> > @@ -805,6 +841,7 @@ static struct nullb_device *null_alloc_dev(void)
> >   	dev->queue_mode = g_queue_mode;
> >   	dev->blocksize = g_bs;
> >   	dev->max_sectors = g_max_sectors;
> > +	dev->max_segment_size = g_max_segment_size;
> >   	dev->irqmode = g_irqmode;
> >   	dev->hw_queue_depth = g_hw_queue_depth;
> >   	dev->blocking = g_blocking;
> > @@ -1248,6 +1285,9 @@ static blk_status_t null_transfer(struct nullb *nullb, struct page *page,
> >   	unsigned int valid_len = len;
> >   	void *p;
> > +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
> > +		  dev->max_segment_size);
> > +
> >   	p = kmap_local_page(page) + off;
> >   	if (!is_write) {
> >   		if (dev->zoned) {
> > @@ -1295,6 +1335,8 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
> >   	spin_lock_irq(&nullb->lock);
> >   	rq_for_each_segment(bvec, rq, iter) {
> >   		len = bvec.bv_len;
> > +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> > +		bvec.bv_len = len;
> >   		if (transferred_bytes + len > max_bytes)
> >   			len = max_bytes - transferred_bytes;
> >   		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
> 
> 
> IMO, since max_segment_size is now configurable, should we consider using
> blk_rq_map_sg() instead of rq_for_each_segment()?

blk_rq_map_sg() requires to allocate sgl, actually it can be done in
request sg iterator way:

	blk_rq_map_iter_init();
	while (blk_map_iter_next(rq, &iter, &vec)) {
		consume each segment;
	}

Just the two helpers needs to be exported.


thanks,
Ming

