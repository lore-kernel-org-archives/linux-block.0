Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B1CC433F5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jan 2022 02:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiAFClg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 21:41:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231967AbiAFClg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jan 2022 21:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641436895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27mfixNH5Fceen+RQ8Te4w1ftnjUijse05g0jdU93XM=;
        b=YzZawW/K0c1G9R3eATT91Z9FwUBD1qa0DULfgjhyP3ygcZwu8fgOwhORAY4TdudQvAMQ5m
        H14YpAOwvRAoDQ+twnZJ4HW1XXR29yHIVbsu6FS+4ocku01FS2K0K3D+zsFWvOa/XdXTlR
        l19cMWi+L9ERz9h0DN6RVGEQaOoAtjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-Z1vb-L1ZNgKqq4txlptiIw-1; Wed, 05 Jan 2022 21:41:34 -0500
X-MC-Unique: Z1vb-L1ZNgKqq4txlptiIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E052B81CCB7;
        Thu,  6 Jan 2022 02:41:32 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 565C01037F3E;
        Thu,  6 Jan 2022 02:41:18 +0000 (UTC)
Date:   Thu, 6 Jan 2022 10:41:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, lining2020x@163.com,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH] block: throttle: charge io re-submission for iops limit
Message-ID: <YdZWyRpbi4HdHAZa@T590>
References: <20211230034513.131619-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230034513.131619-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 30, 2021 at 11:45:13AM +0800, Ming Lei wrote:
> Commit 111be8839817 ("block-throttle: avoid double charge") marks bio as
> BIO_THROTTLED unconditionally if __blk_throtl_bio() is called on this bio,
> then this bio won't be called into __blk_throtl_bio() any more. This way
> is to avoid double charge in case of bio splitting. It is reasonable for
> read/write throughput limit, but not reasonable for IOPS limit because
> block layer provides io accounting against split bio.
> 
> Chunguang Xu has already observed this issue and fixed it in commit
> 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios").
> However, that patch only covers bio splitting in __blk_queue_split(), and
> we have other kind of bio splitting, such as bio_split() & submit_bio_noacct()
> and other ways.
> 
> This patch tries to fix the issue in one generic way, by always charge
> the bio for iops limit in blk_throtl_bio() in case that BIO_THROTTLED
> is set. This way is reasonable: re-submission & fast-cloned bio is charged
> if it is submitted to same disk/queue, and BIO_THROTTLED will be cleared
> if bio->bi_bdev is changed.
> 
> Reported-by: lining2020x@163.com
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Chunguang Xu <brookxu@tencent.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-merge.c    | 2 --
>  block/blk-throttle.c | 2 +-
>  block/blk-throttle.h | 8 +++++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 4de34a332c9f..f5255991b773 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -368,8 +368,6 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>  		trace_block_split(split, (*bio)->bi_iter.bi_sector);
>  		submit_bio_noacct(*bio);
>  		*bio = split;
> -
> -		blk_throtl_charge_bio_split(*bio);
>  	}
>  }
>  
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7c462c006b26..ea532c178385 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2043,7 +2043,7 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
>  }
>  #endif
>  
> -void blk_throtl_charge_bio_split(struct bio *bio)
> +void blk_throtl_charge_for_iops_limit(struct bio *bio)
>  {
>  	struct blkcg_gq *blkg = bio->bi_blkg;
>  	struct throtl_grp *parent = blkg_to_tg(blkg);
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 175f03abd9e4..954b9cac19b7 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -158,20 +158,22 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
>  static inline int blk_throtl_init(struct request_queue *q) { return 0; }
>  static inline void blk_throtl_exit(struct request_queue *q) { }
>  static inline void blk_throtl_register_queue(struct request_queue *q) { }
> -static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
> +static inline void blk_throtl_charge_for_iops_limit(struct bio *bio) { }
>  static inline bool blk_throtl_bio(struct bio *bio) { return false; }
>  #else /* CONFIG_BLK_DEV_THROTTLING */
>  int blk_throtl_init(struct request_queue *q);
>  void blk_throtl_exit(struct request_queue *q);
>  void blk_throtl_register_queue(struct request_queue *q);
> -void blk_throtl_charge_bio_split(struct bio *bio);
> +void blk_throtl_charge_for_iops_limit(struct bio *bio);
>  bool __blk_throtl_bio(struct bio *bio);
>  static inline bool blk_throtl_bio(struct bio *bio)
>  {
>  	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>  
> -	if (bio_flagged(bio, BIO_THROTTLED))
> +	if (bio_flagged(bio, BIO_THROTTLED)) {
> +		blk_throtl_charge_for_iops_limit(bio);

This way may cause double charge since the bio's iops limit
charge can be done via blk_throtl_dispatch_work_fn() too.

Will post another version for fix this issue.

Thanks,
Ming

