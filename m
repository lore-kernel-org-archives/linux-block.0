Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB82C25B41
	for <linux-block@archiver.kernel.org>; Mon, 23 Oct 2023 03:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjJWDpU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Oct 2023 23:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWDpU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Oct 2023 23:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6820E9
        for <linux-block@vger.kernel.org>; Sun, 22 Oct 2023 20:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698032673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbZ1Kk1eXLpdv77E2GlwjvMwfOkEQvpoqAikmNk6vSI=;
        b=eUrEMTASa+PYt+Xo28Qo2NwiqY4Bbg2VAvNzxNlBArLBkkNPhTEgH+zNX1iFksJxTJEizC
        aZ/36lKHj39sZFr+v8dsu7V3Y7Ntjf6Dstai2HW//9XE/1fDCkSXW1VMdDT3TJdGRy5Njw
        G3USXlDzPowkPs0GHortScfh4PJ8bbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-N-s4wJt0Peij_DIKiZKeVQ-1; Sun, 22 Oct 2023 23:44:20 -0400
X-MC-Unique: N-s4wJt0Peij_DIKiZKeVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 771E286803F;
        Mon, 23 Oct 2023 03:44:19 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F8791121320;
        Mon, 23 Oct 2023 03:44:12 +0000 (UTC)
Date:   Mon, 23 Oct 2023 11:44:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>, ming.lei@redhat.com
Subject: Re: [PATCH] block: Improve shared tag set performance
Message-ID: <ZTXsCGhGMk5w6qyi@fedora>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
 <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org>
 <ZTKqAzSPNcBp4db0@kbusch-mbp>
 <f2728de6-ff3c-4693-b51f-58c3d46d0fbf@acm.org>
 <ZTK0NcqB4lIQ_zHQ@kbusch-mbp>
 <dbdc6dbe-5e2a-4414-bea6-1d2160ffdfdd@acm.org>
 <ZTMp3zwaKKQPKmqS@fedora>
 <c768b829-8c86-4574-a1ec-fcc0bf60e270@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c768b829-8c86-4574-a1ec-fcc0bf60e270@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 21, 2023 at 09:13:38AM -0700, Bart Van Assche wrote:
> On 10/20/23 18:31, Ming Lei wrote:
> > If two LUNs are attached to same host, one is slow, and another is fast,
> > and the slow LUN can slow down the fast LUN easily without this fairness
> > algorithm.
> > 
> > Your motivation is that "One of these logical units (WLUN) is used
> > to submit control commands, e.g. START STOP UNIT. If any request is
> > submitted to the WLUN, the queue depth is reduced from 31 to 15 or
> > lower for data LUNs." I guess one simple fix is to not account queues
> > of this non-IO LUN as active queues?
> 
> Hi Ming,
> 
> For fast storage devices (e.g. UFS) any time spent in an algorithm for
> fair sharing will reduce IOPS. If there are big differences in the
> request processing latency between different request queues then fair
> sharing is beneficial. Whether or not the fair sharing algorithm is
> improved, how about making it easy to disable fair sharing, e.g. with
> something like the untested patch below? I think that will work better
> than ignoring fair sharing per LUN. UFS devices support multiple logical
> units and with the current fair sharing approach it takes long until
> tags are taken away from an inactive LUN (request queue timeout).
> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index f75a9ecfebde..b06b161d06de 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -416,7 +416,8 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx
> *hctx,
>  {
>  	unsigned int depth, users;
> 
> -	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
> +	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) ||
> +	    hctx->queue->disable_fair_sharing)

Maybe you can propagate this flag into hctx->flags, then
hctx->queue->disable_fair_sharing can be avoided in fast path.

>  		return true;
> 
>  	/*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index eef450f25982..63b04cf65887 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -523,6 +523,7 @@ struct request_queue {
>  	struct mutex		debugfs_mutex;
> 
>  	bool			mq_sysfs_init_done;
> +	bool			disable_fair_sharing;

You also need to bypass blk_mq_tag_busy() & blk_mq_tag_idle()
in case of disable_fair_sharing which should only be set for
non-IO queues, such as UFS WLUN, and maybe nvme connection queues.


Thanks, 
Ming

