Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DFFC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BB861157
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhKDSmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDSmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:42:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89CC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INT3Chhv9Oq2rjIQ9plJk6HqHF3/xW7HluoqHeJLw7M=; b=zilLnogOABE23gjfGnt8VmSK5S
        Cg6QzgpZGN+0m3Vj/XNYHecql5cs/fReE6veeapqXjlE1GKoVBMCrTMBOP1HMbmC6SF6m36DBlVBh
        5GnT5HXGDj+Y2276/4Y4DVuO1XuGczvYnWon78Y32AynE3VL4I5kNBO1LXvj9FRmd8oX12e1pxut6
        IpT6Nk3xsrFgYYjn9DykTBsK1XLQMIVPjUZTYYaWUlR40uf1ptNOaebhKQ0ladQ05+v4ZzTJYnaJ9
        JtHOuo5M8OghowIKzjJXO1d0LkgCTxhwvHFrMxQvaeF2EGZamjJJVIfEla451nCQCJBDJIQlOtos5
        kB5/8Cww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mihe6-009o0H-SW; Thu, 04 Nov 2021 18:39:30 +0000
Date:   Thu, 4 Nov 2021 11:39:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YYQo4ougXZvgv11X@infradead.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk>
 <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 12:37:25PM -0600, Jens Axboe wrote:
> On 11/4/21 12:36 PM, Christoph Hellwig wrote:
> >> +static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
> >> +{
> >> +	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
> >> +		return false;
> >> +	return true;
> >> +}
> > 
> > Didn't we just agree on splitting bio_queue_enter into an inline helper
> > and an out of line slowpath instead?
> 
> See cover letter, and I also added to the commit message of this one. I do
> think this approach is better, as bio_queue_enter() itself is just slow
> path and there's no point polluting the code with 90% of what's in there.
> 
> Hence I kept it as-is.

Well, let me reword this then:  why do you think the above is
blk-mq secific and should not be used by every other caller of
bio_queue_enter as well?  In other words, why not rename
bio_queue_enter __bio_queue_enter and make the above the public
bio_queue_enter interface then?
