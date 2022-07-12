Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2D8C43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 05:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGLFNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGLFNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 01:13:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4731226;
        Mon, 11 Jul 2022 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ega+Z9B/4Yexu++aBsELz0a6/2VIgxnLFmauVgfSpZU=; b=wxVoxPxw3IyK+C8HHBMt2jepI4
        TSBxQB+MTtSoxQDrUn24D94dNsXzN6zLMu8dlxphvBFdxicbMCDD7y7ZflkcrON9bvhjU++Vjby5X
        kN1IOFbMpX50qJ8ONftqHyoT5LIsYW/rHUhxDHbf39gg7gWJ4bfg5MYEaxTx+fyvklOxTedIWs/aG
        sC0vtIT0WcLbTIpQiIiHaaKMvEMhMwBrzHIYP3ciufq+vArc99ai1HMi/CvMl9tETI2RQgoOxwTcS
        Q1GIitEq/PrgMdEm7BS3KVEfpi1ElDAtSQ/FkZdHv1CiK7RipSLjfi54m89AlLy9v6W3OBCc0rJ6m
        nQKjLX0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB8D1-007iTg-H9; Tue, 12 Jul 2022 05:13:19 +0000
Date:   Mon, 11 Jul 2022 22:13:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Use try_cmpxchg some more
Message-ID: <Ys0C72unFFlsWomq@infradead.org>
References: <20220711153301.2388-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711153301.2388-1-ubizjak@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 11, 2022 at 05:33:01PM +0200, Uros Bizjak wrote:
> Use try_cmpxchg family of functions instead of cmpxchg (*ptr, old, new) == old.
> x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
> compare after cmpxchg (and related move instruction in front of cmpxchg).
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails, enabling further code simplifications.
> 
> No functional change intended.

You might want to split this into a patch per caller as it might
attact different reviewers.

> +	do {
> +	} while (old && !atomic_try_cmpxchg(&blkg->use_delay, &old, old - 1));

It might just be me, but for loops with an empty body this do { } while
construct looks odd.  Why not:

	while (old && !atomic_try_cmpxchg(&blkg->use_delay, &old, old - 1))
		;

?

The the use of the atomic on ->use_delay looks really whacky to start
with.  To me it sounds like it really wants to use a proper lock
instead of all this magic.

>  	else
>  		return;
>  
> -	old = atomic_cmpxchg(&iolat->scale_cookie, our_cookie, cur_cookie);
> -
> -	/* Somebody beat us to the punch, just bail. */
> -	if (old != our_cookie)
> +	if (!atomic_try_cmpxchg(&iolat->scale_cookie, &our_cookie, cur_cookie)) {
> +		/* Somebody beat us to the punch, just bail. */
>  		return;
> +	}


	/* If somebody beat us to the punch, just bail. */
	if (!atomic_try_cmpxchg(&iolat->scale_cookie, &our_cookie, cur_cookie))
		return;

