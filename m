Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0634DC433E0
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 06:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF764206E9
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 06:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vYqLWnKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGGG7J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGGG7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jul 2020 02:59:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834EC061755
        for <linux-block@vger.kernel.org>; Mon,  6 Jul 2020 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sn6owS6IktH7Ha8Kn+nWEcaAdqhHjyd+PySOwpvD6Xs=; b=vYqLWnKQ57+P0UbObapAxUu0z+
        vpILQSa+yDvAKUizFguSYeEaGrjCHmmnfgmPvq7USfnpsrk0veZaYmaQg3U2+hG7iPADbhX4uiNlG
        T50otXeKPJEkeTumcbQQhTSPQWt9pNQwh7k3wORuVG4izHuS9vm7gAx4zTuiSZ3w3BUVkKrdbrYxw
        lRBzTs1DCsS4DwEXzptWHmp1Uy8qJn4YMllzqrhPMGmUTzlLHjGregqfc0/xaOu0m6i13n6gjooP4
        k+ehCPgn39iH/pfQaDkKm80FKaOaGacWcpof9xut29vztwfd4i0XT7eXQ3yKdYhlQTmNBR6ksT4+i
        6J+PXvRQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jshZ9-0006F0-Ot; Tue, 07 Jul 2020 06:58:55 +0000
Date:   Tue, 7 Jul 2020 07:58:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200707065855.GA23827@infradead.org>
References: <20200706144111.3260859-1-ming.lei@redhat.com>
 <841c8170-f082-814a-70cc-b0e3e8b5be54@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841c8170-f082-814a-70cc-b0e3e8b5be54@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 07, 2020 at 07:37:41AM +0100, John Garry wrote:
> On 06/07/2020 15:41, Ming Lei wrote:
> > -	hctx = flush_rq->mq_hctx;
> >   	if (!q->elevator) {
> 
> Is there a specific reason we do:
> 
> if (!a)
> 	do x
> else
> 	do y
> 
> as opposed to:
> 
> if (a)
> 	do y
> else
> 	do x

I much prefer the latter.
