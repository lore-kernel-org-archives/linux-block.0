Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE60C433FE
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 11:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiDELuM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379542AbiDELlQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 07:41:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0A1A066
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 03:56:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q142so8951111pgq.9
        for <linux-block@vger.kernel.org>; Tue, 05 Apr 2022 03:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o+4l0WQzZhVP7dWuHWG3iG/t73kyjNvPzl6DFGifncU=;
        b=PStqchz+ozAOkNVBxVNehht4SvtjxVbCpPXvFD3+aDC0ZwhnFqeSw+4VHGevcE6wy3
         8eQbzPESGZN6gzEiwqDoSM85VVVGn9l4o2MegeJYy1b9X33XMTVLQmu789lGUagYzqoA
         RdO78Ub8cUJl7cNrKb4NYsS/UvbQZ1xD6viGO83UTb5FFODp0Ba9gDTVXESjgjrcyv4+
         9sU896VNw8Z7rokwuICS2ehQe5fQf88HgOCemGwgHf2bs0i8kTltgumuKmwB3aiGQJ4+
         btWkbi3hIMSfEYE2FJkLRYiqEZUj0FVZFtSjc/WOTm3KN4Y9ARC6mnrISnxJSX/bEo1Y
         drQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+4l0WQzZhVP7dWuHWG3iG/t73kyjNvPzl6DFGifncU=;
        b=pysOk9lzOlvkm6Dd6ZNEpcB0MdtdTqjWuomXS8DgXgkCkT9xfAdKPb17FaVG5LcrlI
         sK5B+G7b3CuIQF27CEwUNjFdrBBNKSgv/6+vJGXTURTsonsOihG+1Kc82XsE+alD1w+b
         Imm7w0woSalpL72yfEHQ1RBwaWWvo1abySnh5WAdGWaYqaD+0L7lYSMlu2p1hQjsact1
         K9LZEamF4scFkhQssVbsTJHmsv2g9Sc0lgqHmios1y5Yfb6r/oIPU9Hm2TVt4SaG1k7S
         d3vd5DMFqc48FodVodnnSTFZIEJSJeCB2oj7mzeH35N+Birt8BNAR4cUBIY04AUbw08N
         CMQw==
X-Gm-Message-State: AOAM5325vVuDXaLkE33wBtY4l/w9fgRNPL+/uVYKPKm7q5sUz2KZQuc1
        kS9y76djP2rTVBDFv8E1UVg=
X-Google-Smtp-Source: ABdhPJyulcEm82riOsioUPBq9xCB1IuvFcMTydA+WMJCqKdKPkoeVjJFj+BXpqcI9GWTqtPm8D5dxg==
X-Received: by 2002:a63:6446:0:b0:382:6aff:7bff with SMTP id y67-20020a636446000000b003826aff7bffmr2431387pgb.318.1649156210148;
        Tue, 05 Apr 2022 03:56:50 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a0002a900b004fde4893cf8sm10733400pfs.200.2022.04.05.03.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:56:49 -0700 (PDT)
Date:   Tue, 5 Apr 2022 19:56:42 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkwgavAmpjTNFkm2@localhost.localdomain>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-3-suwan.kim027@gmail.com>
 <YkwEYoeVSemLhivF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkwEYoeVSemLhivF@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 05, 2022 at 01:57:06AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 02:31:22PM +0900, Suwan Kim wrote:
> > This patch supports mq_ops->queue_rqs() hook. It has an advantage of
> > batch submission to virtio-blk driver. It also helps polling I/O because
> > polling uses batched completion of block layer. Batch submission in
> > queue_rqs() can boost polling performance.
> > 
> > In queue_rqs(), it iterates plug->mq_list, collects requests that
> > belong to same HW queue until it encounters a request from other
> > HW queue or sees the end of the list.
> > Then, virtio-blk adds requests into virtqueue and kicks virtqueue
> > to submit requests.
> > 
> > If there is an error, it inserts error request to requeue_list and
> > passes it to ordinary block layer path.
> > 
> > For verification, I did fio test.
> > (io_uring, randread, direct=1, bs=4K, iodepth=64 numjobs=N)
> > I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
> > It shows about 2% improvement.
> > 
> >                                  |   numjobs=2   |   numjobs=4
> >       -----------------------------------------------------------
> >         fio without queue_rqs()  |   291K IOPS   |   238K IOPS
> >       -----------------------------------------------------------
> >         fio with queue_rqs()     |   295K IOPS   |   243K IOPS
> > 
> > For polling I/O performance, I also did fio test as below.
> > (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=4)
> > I set 4 vcpu and 2 poll queues for VM.
> > It shows about 2% improvement in polling I/O.
> > 
> >                                       |   IOPS   |  avg latency
> >       -----------------------------------------------------------
> >         fio poll without queue_rqs()  |   424K   |   613.05 usec
> >       -----------------------------------------------------------
> >         fio poll with queue_rqs()     |   435K   |   601.01 usec
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >  drivers/block/virtio_blk.c | 110 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 99 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 712579dcd3cc..a091034bc551 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -92,6 +92,7 @@ struct virtio_blk {
> >  struct virtblk_req {
> >  	struct virtio_blk_outhdr out_hdr;
> >  	u8 status;
> > +	int sg_num;
> >  	struct sg_table sg_table;
> >  	struct scatterlist sg[];
> >  };
> > @@ -311,18 +312,13 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >  		virtqueue_notify(vq->vq);
> >  }
> >  
> > -static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > -			   const struct blk_mq_queue_data *bd)
> > +static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
> > +					struct virtio_blk *vblk,
> > +					struct request *req,
> > +					struct virtblk_req *vbr)
> >  {
> > -	struct virtio_blk *vblk = hctx->queue->queuedata;
> > -	struct request *req = bd->rq;
> > -	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> > -	unsigned long flags;
> > -	int num;
> > -	int qid = hctx->queue_num;
> > -	bool notify = false;
> >  	blk_status_t status;
> > -	int err;
> > +	int num;
> >  
> >  	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> >  	if (unlikely(status))
> > @@ -335,9 +331,30 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  		virtblk_cleanup_cmd(req);
> >  		return BLK_STS_RESOURCE;
> >  	}
> > +	vbr->sg_num = num;
> 
> This can go into the nents field of vbr->sg_table.
> 
> > +	int err;
> > +
> > +	status = virtblk_prep_rq(hctx, vblk, req, vbr);
> > +	if (unlikely(status))
> > +		return status;
> >  
> >  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
> > +	err = virtblk_add_req(vblk->vqs[qid].vq, vbr,
> > +				vbr->sg_table.sgl, vbr->sg_num);
> 
> And while we're at it - virtblk_add_req can lose the data_sg and
> have_data arguments as they can be derived from vbr.

Ok. I will remove vbr->sg_num and save it to vbr->sg_table.nents.

Regards,
Suwan Kim
