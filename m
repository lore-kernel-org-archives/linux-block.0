Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BB1C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C144520774
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWAp0eVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgFHQm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgFHQm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 12:42:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA9DC08C5C2;
        Mon,  8 Jun 2020 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DRRAq81V5Jd47SWIu2YH0vKG19isDDXhAsvjOLVV/U8=; b=rWAp0eVZ7yupBOLKGXGZYoxwzY
        KXi0EbCKQwia/vRYAgT948E/ltRfPuWkZSAy2co+VmkC/IxxaybOKN73/TY3sEBDlmSPet8o19yuP
        voc5jwmkPnads1yvovxRKf2aQ3sesSyLWguzlAu9J/0O+Hd+rb6KA008tgg9JvZ8LsY4NtfsHSg1+
        Uv73WN3EekQqPoVw6s8nB+VtrDcTV87RpquFKSaqrH+G9KE2nj4yJzYh6NIcNgbWmYCIGiWtOnMYU
        AtFlxB+91pKF2glliIQa+XUahiaF5g+F1Sdx3xHtFnlk5rBGZo9s/OLef/qLgz1mM38noSEVurahF
        PYnPFALQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiKrO-0003K1-5A; Mon, 08 Jun 2020 16:42:54 +0000
Date:   Mon, 8 Jun 2020 09:42:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: blk-softirq vs smp_call_function_single_async()
Message-ID: <20200608164254.GA2431@infradead.org>
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
 <20200608154557.GA26611@infradead.org>
 <20200608155833.GC2531@hirez.programming.kicks-ass.net>
 <20200608163342.GA5155@infradead.org>
 <20200608164009.GD2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608164009.GD2531@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 06:40:09PM +0200, Peter Zijlstra wrote:
> There isn't one, it was meant to be used with static allocations.
> 
> Frederic proposed changing all these to irq_work, and I think I'll go do
> that. First dinner though.

The irq_work API looks reasonable.  What are the tradeoffs for
smp_call_single_async vs irq_work?
