Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3496FC4321E
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 20:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiDET7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449579AbiDEPuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 11:50:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401056C01
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 07:35:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c23so11110768plo.0
        for <linux-block@vger.kernel.org>; Tue, 05 Apr 2022 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1XO7lnPB/LA5in3rTfbTME8v5xLGtJ4KRhZSZNsXnY=;
        b=c+g1oisbGJ1/N0TGmKf3JvD+SdQ/KzFFxh6EDnioo8Be+lSIiB4XUpuuS+clL3cT9r
         y0lMemsn7UGEB7je9AFQMZ5oW8DhupzPFZKZ4MYSyF/6H1yrm5E+tmHP8WpoWw/Pg6Ns
         vKVMI3cfwax7+cur4mbVkORSwp+CUgN2dg01DNjLc8oHcw8876xSVDJZIHi50L2+7tlj
         w2XvGKqkxCIrgxVHBySfX/HbGnmLTMnrPFkwTXt53GK2hKZ5RHxtTo+K2IfuRpbyTKJB
         g0fFKUTh7D8JgX7S5/xvFmQSMzs4b7QXdae4QC8nJdZfJu/QL5K2Kkc0jAoMGb3pohTE
         fu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1XO7lnPB/LA5in3rTfbTME8v5xLGtJ4KRhZSZNsXnY=;
        b=qDcYg+hn9ZW53pCofE8mkWyDMxLj8ZYvzbU5hiBLzTUhGYKqQdV3WyUq8Jv2tsu+Wd
         NAPbPFYfJJFNZazpyRo95zARlBAVQJvob42Y6ia3NuCGyPTfYeCGha0Mk1myUXjzBLxg
         23NdR9qmIMOxDnooiNb49Yzgdl18JtpJtCjN1SbVvYGHW02mPGRPqNKON7NFY2nsfbbG
         BaNpoSStngMsmHDvu2WxxnVfMfAOu+R4/8dbajyJiuHnTglLMXy1vv2Z2Bf6YwOgVa3d
         Y2ihSUd4wPN89YT35ss8A3Xxa8rIX8zWIbRkuE9YrkuWidqfUyWrJ/JvNf1S1mBJbhVh
         nfKA==
X-Gm-Message-State: AOAM532+Hc9Yx7yZ6AnLYHE8RXqLGXJ8nWsnSLM4goy7kO0Lobi4f8zC
        gWuiuHDPUMbPmhioE33zIwM=
X-Google-Smtp-Source: ABdhPJx7jw6DmUGeLLcqbVa8sN4KZ6uMDQCT5t9FIZqcLtAh3/HbPhklIVwuSYF8uHRXJOVAzd83kQ==
X-Received: by 2002:a17:902:cec9:b0:156:8e7a:bf4e with SMTP id d9-20020a170902cec900b001568e7abf4emr3809803plg.62.1649169310840;
        Tue, 05 Apr 2022 07:35:10 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm2585799pjn.34.2022.04.05.07.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 07:35:09 -0700 (PDT)
Date:   Tue, 5 Apr 2022 23:35:03 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/2] virtio-blk: support polling I/O
Message-ID: <YkxTl98nwQhAyteD@localhost.localdomain>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-2-suwan.kim027@gmail.com>
 <YkwDHGutRLN51hbd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkwDHGutRLN51hbd@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 05, 2022 at 01:51:40AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 02:31:21PM +0900, Suwan Kim wrote:
> > This patch supports polling I/O via virtio-blk driver. Polling
> > feature is enabled by module parameter "num_poll_queues" and it
> > sets dedicated polling queues for virtio-blk. This patch improves
> > the polling I/O throughput and latency.
> > 
> > The virtio-blk driver doesn't not have a poll function and a poll
> > queue and it has been operating in interrupt driven method even if
> > the polling function is called in the upper layer.
> > 
> > virtio-blk polling is implemented upon 'batched completion' of block
> > layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> > and later, virtblk_complete_batch() calls unmap function and ends
> > the requests in batch.
> > 
> > virtio-blk reads the number of poll queues from module parameter
> > "num_poll_queues". If VM sets queue parameter as below,
> > ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> > It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> > as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> > queues, the poll queues have no callback function.
> > 
> > Regarding HW-SW queue mapping, the default queue mapping uses the
> > existing method that condsiders MSI irq vector. But the poll queue
> > doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> > 
> > For verifying the improvement, I did Fio polling I/O performance test
> > with io_uring engine with the options below.
> > (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> > I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> > queues for VM.
> > 
> > As a result, IOPS and average latency improved about 10%.
> > 
> > Test result:
> > 
> > - Fio io_uring poll without virtio-blk poll support
> > 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> > 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> > 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> > 
> > - Fio io_uring poll with virtio-blk poll support
> > 	-- numjobs=1 : IOPS = 385K, avg latency = 165.94us
> > 	-- numjobs=2 : IOPS = 408K, avg latency = 313.28us
> > 	-- numjobs=4 : IOPS = 424K, avg latency = 613.05us
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >  drivers/block/virtio_blk.c | 112 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 108 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 8c415be86732..712579dcd3cc 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
> >  		 "0 for no limit. "
> >  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
> >  
> > +static unsigned int poll_queues;
> > +module_param(poll_queues, uint, 0644);
> > +MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/O");
> > +
> >  static int major;
> >  static DEFINE_IDA(vd_index_ida);
> >  
> > @@ -81,6 +85,7 @@ struct virtio_blk {
> >  
> >  	/* num of vqs */
> >  	int num_vqs;
> > +	int io_queues[HCTX_MAX_TYPES];
> >  	struct virtio_blk_vq *vqs;
> >  };
> >  
> > @@ -548,6 +553,7 @@ static int init_vq(struct virtio_blk *vblk)
> >  	const char **names;
> >  	struct virtqueue **vqs;
> >  	unsigned short num_vqs;
> > +	unsigned int num_poll_vqs;
> >  	struct virtio_device *vdev = vblk->vdev;
> >  	struct irq_affinity desc = { 0, };
> >  
> > @@ -556,6 +562,7 @@ static int init_vq(struct virtio_blk *vblk)
> >  				   &num_vqs);
> >  	if (err)
> >  		num_vqs = 1;
> > +
> >  	if (!err && !num_vqs) {
> >  		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
> >  		return -EINVAL;
> > @@ -565,6 +572,18 @@ static int init_vq(struct virtio_blk *vblk)
> >  			min_not_zero(num_request_queues, nr_cpu_ids),
> >  			num_vqs);
> >  
> > +	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
> > +
> > +	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
> > +	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
> > +	vblk->io_queues[HCTX_TYPE_READ] = 0;
> > +	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
> > +
> > +	dev_info(&vdev->dev, "%d/%d/%d default/read/poll queues\n",
> > +				vblk->io_queues[HCTX_TYPE_DEFAULT],
> > +				vblk->io_queues[HCTX_TYPE_READ],
> > +				vblk->io_queues[HCTX_TYPE_POLL]);
> > +
> >  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
> >  	if (!vblk->vqs)
> >  		return -ENOMEM;
> > @@ -578,8 +597,13 @@ static int init_vq(struct virtio_blk *vblk)
> >  	}
> >  
> >  	for (i = 0; i < num_vqs; i++) {
> > +		if (i < num_vqs - num_poll_vqs) {
> > +			callbacks[i] = virtblk_done;
> > +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> > +		} else {
> > +			callbacks[i] = NULL;
> > +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> > +		}
> >  		names[i] = vblk->vqs[i].name;
> 
> This would look a little cleaner with two loops:
> 
>  	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
> 		callbacks[i] = virtblk_done;
> 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
>  		names[i] = vblk->vqs[i].name;
> 	}
>  	for (; i < num_vqs; i++) {
> 		callbacks[i] = NULL;
> 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> 		names[i] = vblk->vqs[i].name;
> 	}
> 
> > +
> > +		if (map->nr_queues == 0)
> > +			continue;
> > +
> > +		/*
> > +		 * Regular queues have interrupts and hence CPU affinity is
> > +		 * defined by the core virtio code, but polling queues have
> > +		 * no interrupts so we let the block layer assign CPU affinity.
> > +		 */
> > +		if (i == HCTX_TYPE_DEFAULT)
> 
> I'd check for
> 		i != HCTX_TYPE_POLL
> 
> here instead to make the check a little more explicit and future proof
> for the potential addition of read queues (which would be a Linux only
> change without hypervisor or spec changes).  In fact you might as well
> add that support now as doing it is completely trivial once a driver
> supports multiple map types.
> 
> > +static void virtblk_complete_batch(struct io_comp_batch *iob)
> > +{
> > +	struct request *req;
> > +	struct virtblk_req *vbr;
> > +
> > +	rq_list_for_each(&iob->req_list, req) {
> > +		vbr = blk_mq_rq_to_pdu(req);
> > +		virtblk_unmap_data(req, vbr);
> > +		virtblk_cleanup_cmd(req);
> 
> vbr is only used ones, so why not just:
> 
> 		virtblk_unmap_data(req, blk_mq_rq_to_pdu);
> ?
> 
> Or even better add a cleanup patch to just remove the vbr argument to
> virtblk_unmap_data as it is not needed at all.

I replied that I will add cleanup path but after thinking about it
again, it seems better not to remove the argument because
blk_mq_rq_to_pdu() needs type casting anyway.

So I will fix it to "virtblk_unmap_data(req, blk_mq_rq_to_pdu);"
as you mentioned.

Regards,
Suwan Kim
