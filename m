Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86DEC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F21860ED5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 09:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhKDJMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhKDJMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 05:12:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C295C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKTFibwtIVJft1LWPPuvBoMzqjQuCW6NbY14VOrbNHI=; b=z8A419qqTZTRrxlZfCsr+FsmTD
        t6AV1R0/KbpxvV1TuE86oYM/GENw0dNvtcM6iCiiVKfASwHlJ3mWmovh5r5xrqweq4ApzGhpZP9AB
        7rBvg8r4fMSma/nScBpYUtC2r2ppP4e0zmNIkxtqfBGqyicdoxrNffNHlbzrB3T1QBHp4tdwcvx5g
        bM7Lphxkwl4axWU1BwMeOzenzRtgpzFaYUuyvJsMGS7SbMV5Uqfby4JUEPzBqoHruxk5SVVOEm04R
        kZMqysS4NNQN1Mgsc1WwkqnFukeWWla6cbdH3b3rhGc3MKUVN5ZsSCx3O0L8p7jjlbxsmyox1yTA6
        IwMPu/Ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYl8-008QJx-Ni; Thu, 04 Nov 2021 09:10:10 +0000
Date:   Thu, 4 Nov 2021 02:10:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YYOjcuEExwJN1eiw@infradead.org>
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103183222.180268-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 03, 2021 at 12:32:21PM -0600, Jens Axboe wrote:
> Retain the old logic for the fops based submit, but for our internal
> blk_mq_submit_bio(), move the queue entering logic into the core
> function itself.

Can you explain the why?  I guess you want to skip the extra reference
for the cached requests now that they already have one.  But please
state that, and explain why it is a fix, as to me it just seems like
another little optimization.

> We need to be a bit careful if going into the scheduler, as a scheduler
> or queue mappings can arbitrarily change before we have entered the queue.
> Have the bio scheduler mapping do that separately, it's a very cheap
> operation compared to actually doing merging locking and lookups.

So just don't do the merges for cache requets and side step this
extra bio_queue_enter for that case?

> -	if (unlikely(bio_queue_enter(bio) != 0))
> -		return;
> -
>  	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
> -		goto queue_exit;
> +		return;

This is broken, we really ant the submit checks under freeze
protection to make sure the parameters can't be changed underneath
us.

> +static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
> +{
> +	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
> +		return false;
> +	return true;
> +}

This looks weird, as blk_try_enter_queue is already called by
bio_queue_enter.

>  	} else {
>  		struct blk_mq_alloc_data data = {
>  			.q		= q,
> @@ -2528,6 +2534,11 @@ void blk_mq_submit_bio(struct bio *bio)
>  			.cmd_flags	= bio->bi_opf,
>  		};
>  
> +		if (unlikely(!blk_mq_queue_enter(q, bio)))
> +			return;
> +
> +		rq_qos_throttle(q, bio);
> +

At some point the code in this !cached branch really needs to move
into a helper..
