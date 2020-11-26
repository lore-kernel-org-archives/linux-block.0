Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE87C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75DE21734
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcUWVrv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKZC7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729679AbgKZC7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606359541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1O3biWysUvvAR2mvflPSVw+B4WljGNc5/mukonHUSoQ=;
        b=GcUWVrv/LffGv4SDGsoQhDCfJkfrO3g3T7/n/yxxWqY527jHnCyV0fkWRcf9hIs/tZqr5y
        E4cAbJoqKd3JnWYVR1EFe1F+eFx4L8bRUJxOq9w9y5MgETPmgceF0zhZddMOMFS1BtX6BI
        WAnWRGOiwBvnlL8yLf22QyYcHU/XtCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-4dtTisQFMSC-CWRxXz24Kg-1; Wed, 25 Nov 2020 21:58:59 -0500
X-MC-Unique: 4dtTisQFMSC-CWRxXz24Kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 795441074640;
        Thu, 26 Nov 2020 02:58:58 +0000 (UTC)
Received: from T590 (ovpn-13-94.pek2.redhat.com [10.72.13.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27CA119C46;
        Thu, 26 Nov 2020 02:58:51 +0000 (UTC)
Date:   Thu, 26 Nov 2020 10:58:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, hch@infradead.org
Subject: Re: [PATCH v8] block: disable iopoll for split bio
Message-ID: <20201126025847.GB42718@T590>
References: <20201126022837.15545-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126022837.15545-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 10:28:37AM +0800, Jeffle Xu wrote:
> iopoll is initially for small size, latency sensitive IO. It doesn't
> work well for big IO, especially when it needs to be split to multiple
> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
> indeed the cookie of the last split bio. The completion of *this* last
> split bio done by iopoll doesn't mean the whole original bio has
> completed. Callers of iopoll still need to wait for completion of other
> split bios.
> 
> Besides bio splitting may cause more trouble for iopoll which isn't
> supposed to be used in case of big IO.
> 
> iopoll for split bio may cause potential race if CPU migration happens
> during bio submission. Since the returned cookie is that of the last
> split bio, polling on the corresponding hardware queue doesn't help
> complete other split bios, if these split bios are enqueued into
> different hardware queues. Since interrupts are disabled for polling
> queues, the completion of these other split bios depends on timeout
> mechanism, thus causing a potential hang.
> 
> iopoll for split bio may also cause hang for sync polling. Currently
> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
> in direct IO routine. These routines will submit bio without REQ_NOWAIT
> flag set, and then start sync polling in current process context. The
> process may hang in blk_mq_get_tag() if the submitted bio has to be
> split into multiple bios and can rapidly exhaust the queue depth. The
> process are waiting for the completion of the previously allocated
> requests, which should be reaped by the following polling, and thus
> causing a deadlock.
> 
> To avoid these subtle trouble described above, just disable iopoll for
> split bio and return BLK_QC_T_NONE in this case. The side effect is that
> non-HIPRI IO also returns BLK_QC_T_NONE now. It should be acceptable
> since the returned cookie is never used for non-HIPRI IO.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  block/blk-merge.c | 8 ++++++++
>  block/blk-mq.c    | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcf5e4580603..8a2f1fb7bb16 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,6 +279,14 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	return NULL;
>  split:
>  	*segs = nsegs;
> +
> +	/*
> +	 * Bio splitting may cause subtle trouble such as hang when doing sync
> +	 * iopoll in direct IO routine. Given performance gain of iopoll for
> +	 * big IO can be trival, disable iopoll when split needed.
> +	 */
> +	bio->bi_opf &= ~REQ_HIPRI;
> +
>  	return bio_split(bio, sectors, GFP_NOIO, bs);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..580fd570be23 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2157,6 +2157,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	unsigned int nr_segs;
>  	blk_qc_t cookie;
>  	blk_status_t ret;
> +	bool hipri;
>  
>  	blk_queue_bounce(q, &bio);
>  	__blk_queue_split(&bio, &nr_segs);
> @@ -2173,6 +2174,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  
>  	rq_qos_throttle(q, bio);
>  
> +	hipri = bio->bi_opf & REQ_HIPRI;
> +
>  	data.cmd_flags = bio->bi_opf;
>  	rq = __blk_mq_alloc_request(&data);
>  	if (unlikely(!rq)) {
> @@ -2265,7 +2268,9 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
>  
> +	cookie = hipri ? cookie : BLK_QC_T_NONE;
>  	return cookie;
> +
>  queue_exit:
>  	blk_queue_exit(q);
>  	return BLK_QC_T_NONE;
> -- 
> 2.27.0
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

