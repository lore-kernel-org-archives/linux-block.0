Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C5DC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BF661186
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhKDRd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhKDRd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:33:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2637C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5P41pKz/ze1ouoxPlMNANYaHsaLG+fY56l9WAG65Gss=; b=bjTzsvwZ26KnlNS9tSbbYPGP70
        8dDQDvZbagrOSoAyVdL/AlGmjg6wi/iCLAVvrF42AKyGkYoF7IcNBXtjIERMtMhDu/7X+z6vtFMKW
        MTmVek1/WDtickg1OnS0ZLsHSawnSVWgGg2sh+gIVaYUGrm00u/jMHD+NDDCqAXkYsQaTXuK0cDMt
        WUsNfMJ4YpgfuiR461C7Ou/t8oGqSHGlrsDtDklsmdwt5HOi1i1XY9KZlB8ffnjKE+X2R5lcS8izH
        l77NVbId1DjfCqOu4aJLIJE3DmdDIfO/15CvXrnIGe0T8/lzGZsjw5SaQdXXu7ml/rovsMX9ErKO7
        0LGVQEGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migZc-009fiW-Gv; Thu, 04 Nov 2021 17:30:48 +0000
Date:   Thu, 4 Nov 2021 10:30:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YYQYyEljsvANMP3q@infradead.org>
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-4-axboe@kernel.dk>
 <YYOjcuEExwJN1eiw@infradead.org>
 <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 05:41:35AM -0600, Jens Axboe wrote:
> >>  	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
> >> -		goto queue_exit;
> >> +		return;
> > 
> > This is broken, we really ant the submit checks under freeze
> > protection to make sure the parameters can't be changed underneath
> > us.
> 
> Which parameters are you worried about in submit_bio_checks()? I don't
> immediately see anything that would make me worry about it.

Mostly checks if certain operations are supported or not, as
revalidation could clear those.

> > This looks weird, as blk_try_enter_queue is already called by
> > bio_queue_enter.
> 
> It's just for avoiding a pointless call into bio_queue_enter(), which
> isn't needed it blk_try_enter_queue() is successful. The latter is short
> and small and can be inlined, while bio_queue_enter() is a lot bigger.

If this is so impotant let's operated with an inlined bio_queue_enter
that calls out of line into slow path instead of open coding it
like this.

> >>  	} else {
> >>  		struct blk_mq_alloc_data data = {
> >>  			.q		= q,
> >> @@ -2528,6 +2534,11 @@ void blk_mq_submit_bio(struct bio *bio)
> >>  			.cmd_flags	= bio->bi_opf,
> >>  		};
> >>  
> >> +		if (unlikely(!blk_mq_queue_enter(q, bio)))
> >> +			return;
> >> +
> >> +		rq_qos_throttle(q, bio);
> >> +
> > 
> > At some point the code in this !cached branch really needs to move
> > into a helper..
> 
> Like in the next patch?

No, I mean the !cached case which is a lot more convoluted.
