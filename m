Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC748C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 12:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiCGM2s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242429AbiCGM2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 07:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F8508119F
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 04:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646656029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaixLK51c3Byz8g2tt5yJA0N9WX2ZJDIdMda8nR7RQI=;
        b=TAEn3szSGD/qSCCOjCRdL4EnB5CsZ1NihFcjdhwZsfYkmcAAGKLJY77zSPzla+NpWr7jZ3
        4W+KafTlDILqW1cx9vfJNjCNjM0t+eSoQqd2KgW3Ywif9WRcdy4tEKxiLKu4XX9YS+wKl0
        25dnM9RmF3JoaNhKq7huw/PdUDwDseU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-Elf8ImbbP_2iVwoa-z5nCw-1; Mon, 07 Mar 2022 07:27:08 -0500
X-MC-Unique: Elf8ImbbP_2iVwoa-z5nCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4BF9FC80;
        Mon,  7 Mar 2022 12:27:06 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88B9C83080;
        Mon,  7 Mar 2022 12:26:56 +0000 (UTC)
Date:   Mon, 7 Mar 2022 20:26:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] blktests block/005: KASAN uaf at bio merge
Message-ID: <YiX6B6uKsMQ0erbj@T590>
References: <20220307112655.5ewkvhz5d3avglnd@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307112655.5ewkvhz5d3avglnd@shindev>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 11:26:56AM +0000, Shinichiro Kawasaki wrote:
> I observed blktests block/005 failure by KASAN use-after-free. The test case
> repeats IO scheduler switch during fio workload. According to the kernel
> message, it looks like bio submit path is running while IO scheduler is invalid,
> and kyber_bio_merge accessed the invalid IO scheduler data.
> 
> The failure was observed with v5.17-rc1, and still observed with v5.17-rc7.
> It was observed with QEMU NVME emulation device with ZNS zoned device
> emulation. So far, it is not observed with other devices. To recreate the
> failure, need to repeat the test case. In the worst case, 500 times repetition
> is required.
> 
> I bisected and found the commit 9d497e2941c3 ("block: don't protect
> submit_bio_checks by q_usage_counter") triggers it. The commit moves calls of
> 3 functions: submit_bio_checks, blk_mq_attempt_bio_merge and rq_qos_throttle.
> I suspected that the move of blk_mq_attempt_bio_merge is the cause, and tried
> to revert only that part. But it caused linux system boot hang related to
> rq_qos_throttle. Then I created another patch which reverts moves of both
> blk_mq_attempt_bio_merge and rq_qos_throttle calls [2]. With this patch, the
> KASAN uaf disappeared. Based on this observation, I think the failure cause is
> the move of blk_mq_attempt_bio_merge out of guard by bio_queue_enter.
> 
> I'm not sure if the fix by the patch [2] is good enough. With that fix, the
> blk_mq_attempt_bio_merge call in blk_mq_get_new_requests is guarded with
> bio_queue_enter, but the blk_mq_attempt_bio_merge call in
> blk_mq_get_cached_request may not be well guarded. Comments for fix approach
> will be appreciated.
> 
> 
> [1]
> 
> [  335.931534] run blktests block/005 at 2022-03-07 10:15:29
> [  336.285062] general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN PTI
> [  336.291190] KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
> [  336.297513] CPU: 0 PID: 1864 Comm: fio Not tainted 5.16.0-rc3+ #15
> [  336.302034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
> [  336.309636] RIP: 0010:kyber_bio_merge+0x121/0x320

I can understand the issue, since both bio merge and rq_qos_throttle()
requires to get one .q_usage_counter, otherwise switching elevator
or changing rq qos may cause such issue.

> 
> [2]
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d69ca91fbc8b..59c66b9e8a44 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2718,7 +2718,8 @@ static bool blk_mq_attempt_bio_merge(struct request_queue *q,
>  
>  static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  					       struct blk_plug *plug,
> -					       struct bio *bio)
> +					       struct bio *bio,
> +					       unsigned int nsegs)
>  {
>  	struct blk_mq_alloc_data data = {
>  		.q		= q,
> @@ -2730,6 +2731,11 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	if (unlikely(bio_queue_enter(bio)))
>  		return NULL;
>  
> +	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
> +		goto queue_exit;
> +
> +	rq_qos_throttle(q, bio);
> +
>  	if (plug) {
>  		data.nr_tags = plug->nr_ios;
>  		plug->nr_ios = 1;
> @@ -2742,12 +2748,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	rq_qos_cleanup(q, bio);
>  	if (bio->bi_opf & REQ_NOWAIT)
>  		bio_wouldblock_error(bio);
> +queue_exit:
>  	blk_queue_exit(q);
>  	return NULL;
>  }
>  
>  static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
> -		struct blk_plug *plug, struct bio *bio)
> +		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
>  {
>  	struct request *rq;
>  
> @@ -2757,14 +2764,20 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>  	if (!rq || rq->q != q)
>  		return NULL;
>  
> -	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
> +	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
> +		*bio = NULL;
> +		return NULL;
> +	}
> +
> +	if (blk_mq_get_hctx_type((*bio)->bi_opf) != rq->mq_hctx->type)
>  		return NULL;
> -	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
> +	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
>  		return NULL;
>  
> -	rq->cmd_flags = bio->bi_opf;
> +	rq->cmd_flags = (*bio)->bi_opf;
>  	plug->cached_rq = rq_list_next(rq);
>  	INIT_LIST_HEAD(&rq->queuelist);
> +	rq_qos_throttle(q, *bio);

rq_qos_throttle() can be put above together with blk_mq_attempt_bio_merge().

>  	return rq;
>  }
>  
> @@ -2800,14 +2813,11 @@ void blk_mq_submit_bio(struct bio *bio)
>  	if (!bio_integrity_prep(bio))
>  		return;
>  
> -	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
> -		return;
> -
> -	rq_qos_throttle(q, bio);
> -
> -	rq = blk_mq_get_cached_request(q, plug, bio);
> +	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
>  	if (!rq) {
> -		rq = blk_mq_get_new_requests(q, plug, bio);
> +		if (!bio)
> +			return;
> +		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
>  		if (unlikely(!rq))
>  			return;
>  	}

Otherwise, the patch looks fine, can you post the formal version?

Thanks,
Ming

