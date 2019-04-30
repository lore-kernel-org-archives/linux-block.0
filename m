Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B4C46470
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 08:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94060216FD
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 08:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCxU9UKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfD3IWC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:22:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3IWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 04:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8DM06XtW1FFvD8grPjtHoQFBokiKn/DiGXyZQZQ/fSA=; b=OCxU9UKMhrzSRxfs1nNcuZD00
        g2YUxi2+0w8VH36pCz/hU49ND1rAV5JPO3oWb4v0D0w25K33Z3lAmgV4TW6YEbn7b5WhIQocO/9sx
        4/Z+63HVgMF50vKrZ6Su49hQ6ZnPNuFnE8IVdiCviWHJ0uabylm7wlLn/hnY9ltlMUuAFDA3ZlJdH
        a60OOP071vHOPRHOoM+YDpMPUvlt1HdAHLHOgzIKZJ4xYni19bFoITocYVAq7ZsNk02DB3XY35Aod
        D/8VamynNxLHKK3ukLVgwXdfJlu+8WsT37ktzeWt7zSVsvLyYcD1FCMoiy2XIRGvGqToqxrRtPmow
        Cqr8ffS7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLO1Z-0007yk-J0; Tue, 30 Apr 2019 08:22:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 504AE29D2D6D6; Tue, 30 Apr 2019 10:21:58 +0200 (CEST)
Date:   Tue, 30 Apr 2019 10:21:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/5] bio: fix improper use of smp_mb__before_atomic()
Message-ID: <20190430082158.GA2677@hirez.programming.kicks-ass.net>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-3-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556568902-12464-3-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 29, 2019 at 10:14:58PM +0200, Andrea Parri wrote:
> This barrier only applies to the read-modify-write operations; in
> particular, it does not apply to the atomic_set() primitive.
> 
> Replace the barrier with an smp_mb().

> @@ -224,7 +224,7 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
>  {
>  	if (count != 1) {
>  		bio->bi_flags |= (1 << BIO_REFFED);
> -		smp_mb__before_atomic();

Maybe also add:

		/*
		 * XXX the comment that explain this barrier goes here
		 */
> +		smp_mb();
>  	}
>  	atomic_set(&bio->__bi_cnt, count);
>  }
