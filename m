Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59471C433FE
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 11:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiDELuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351617AbiDELEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 07:04:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B81FE43AD
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 03:30:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fu5so5729669pjb.1
        for <linux-block@vger.kernel.org>; Tue, 05 Apr 2022 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=usRiKAzT3qrPf6y3eLeMLx4S2c8/Cp+tKib9umJYw4g=;
        b=HAX/4vUur7dDmKA87YjTzm62mZb8y1JLy4WTpJUzkJTP9mEkeALma99rhX8AHsrS6Q
         aq2FfY30Bkg1P/znx72dakUK0CQQWsmEB94+TN83VNf0NT5hcbw1HfFnoXpU5dc4I3xR
         9QeeM+epWjKGBph11iWIwKK1msw5nty6dp4YFWh4nh6FWUu9/Kphg3MVpQOn2C/trOWc
         YS2XYBmTBPE7hS//SPqxGu2woFsKzq56+pVIPns+pYGf0VE3OPN94JrJCRcJ4CRU4dbu
         EIyFuB1x+D3vhZCwAVxuZebtceBMOjkF66LYZLHptxWDEI+5lgwjqRs4fe7S2cJEBeQS
         GoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usRiKAzT3qrPf6y3eLeMLx4S2c8/Cp+tKib9umJYw4g=;
        b=wHD+kyPiT5CWMiBmtuEOyQbhhPR6bbO5dyCh1jPyl8L6u5wdxlOk55v+GHXnf6FtzB
         gU0JpgoLF4ki2Foh8+1uRmnUUfsyHxFzaShWmo/vJn8H4bU57xUcy+gHdAyCvPjq/gka
         s368wTqgaxj06CrTnisFwsd1ct0mOsBeLIE+f8e4zIl/FPnq50jTjsl1mcE3BS+26Jcl
         By/zj0IF53NZHonq6RAWud/EIEBji+GXX5cJ42O1g0uhXj/zOFCbdfn6ySTb60AmZ/kI
         qHuySoV1MQBKmJUP9+U+OBtOd0cVHCXgmrXXH9UcqutKX7nhguWUZMNWw7BfJIJ6Rp6i
         8nqQ==
X-Gm-Message-State: AOAM532KylAYxafe8nQyzZVLUv9OZu5GyB6oTh142nRPSjdufqIxKwlH
        ueI+y+p12+gwZ/SwJ7odRsE=
X-Google-Smtp-Source: ABdhPJzpsBGipfDj5+LPDmtCMQBqrzgOO9On2DXDgbT+QR4oIqoF0SJq0XBTxjuWuVZuw+wb7IUBpw==
X-Received: by 2002:a17:90b:1809:b0:1c7:28fb:bdd0 with SMTP id lw9-20020a17090b180900b001c728fbbdd0mr3182699pjb.231.1649154636931;
        Tue, 05 Apr 2022 03:30:36 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b001c709bca712sm2201801pjb.29.2022.04.05.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:30:36 -0700 (PDT)
Date:   Tue, 5 Apr 2022 19:30:30 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/2] virtio-blk: support polling I/O
Message-ID: <YkwaRqX/DlCOY3q9@localhost.localdomain>
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

It looks better. I will fix it.

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

Your if condition is better choice when we consider future use of read
queue. I will fix it too.

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
> Or even better add a cleanup patch to just remove the vbr argument to
> virtblk_unmap_data as it is not needed at all.

Thanks for the feedback. I will add cleanup patch in this series.

Ragards,
Suwan Kim
