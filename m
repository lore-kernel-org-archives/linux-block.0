Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C74DC28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 14:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7716120836
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 14:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5MUZQuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgEFOmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 10:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgEFOmw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 May 2020 10:42:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C678C061A0F
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9nDYZVwSxSRpeC1wdsh5D1kQnUR+aLyr8r0T28AhYKs=; b=V5MUZQuUsHBMc4Dmw0Wi/KDPIN
        7rBJcCKdWoFlauu8F+m9YkCoUuurK41rAzvBFbTcCQr+HkjzKneOS/PKnhy3hWl7BzvMyaAKjaEez
        Zympq5BGOIqQam5LrMWyNxbQ2zq2WXmGPpRi02GuhEKsrXgICql7oseE3zd0vb89aI0FeOf95xHsx
        LQCG/s+RtXyoPWANVNILRlKgTB5AuwGuy45ls1MzrTteWSpqrksgFUm300CoqBM6Z264yynuLLYLD
        eZhD5kWYMY0xuIiFtdBM+2RLkP+AQE1ECHqPdWQIDQdsAu/9E4sM5ni2lCq0Wltwx9R4gZSczmeNZ
        +SAOmXdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWLG7-00020t-Uu; Wed, 06 May 2020 14:42:51 +0000
Date:   Wed, 6 May 2020 07:42:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix blkparse and iowatcher for kernels >= 4.14
Message-ID: <20200506144251.GA7564@infradead.org>
References: <20200506133933.4773-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506133933.4773-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 06, 2020 at 03:39:30PM +0200, Jan Kara wrote:
> I was investigating a performance issue with BFQ IO scheduler and I was
> pondering why I'm not seeing informational messages from BFQ. After quite
> some debugging I have found out that commit 35fe6d763229 "block: use
> standard blktrace API to output cgroup info for debug notes" broke standard
> blktrace API - namely the informational messages logged by bfq_log_bfqq()
> are no longer displayed by blkparse(8) tool. This is because these messages
> have now __BLK_TA_CGROUP bit set and that breaks flags checking in
> blkparse(1) and iowatcher(1). This series fixes both tools to be able to
> cope with events with __BLK_TA_CGROUP flag set.

I'd much rather revert a kernel change that breaks frequently used
userspace.
