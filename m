Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E52C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEED9221E9
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgLBI4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgLBI4T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 03:56:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C2C0613CF
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uWpGyG4uI1IyljySwOiZDAbadE+N9TpiAEV5DiREgh4=; b=Tww4URfaJNptxmZfTX4rHfaXGn
        LrfagsHW9G4a9i6dXgpz5rhtk7tKS8ZJJ+gbyO2OJ2pjXJ1J0J6rOQpsaKTYaaIzMuAR4gmHvo9/y
        H86klH97PYdSvKD0yi0xoh6XoJ1ARSukv+yEJBKrCKo7r+AkJPD2K70MveJkrLV5uwBDbNC3KSwfy
        TOcajg7ljVJnSqSZEU+YjPaYjN/e5gCbMAFS9dllS+n0lUoIS5y09nMSuvo5WyqsAuE8pYzOqDT3K
        aI9kSgPolCiHy5Gdx/3evj+RK6Sv3XThsa64WhULAOdbYK5g2tzTJvztxPRFtGGEJgdUhs2jKaDbv
        e22mO7Tg==;
Received: from [2001:4bb8:184:6389:740f:6f27:77ba:2250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNvB-0007wg-EY; Wed, 02 Dec 2020 08:55:33 +0000
Date:   Wed, 2 Dec 2020 09:55:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com
Subject: Re: [PATCH V4 1/9] block: allow bvec for zone append get pages
Message-ID: <20201202085531.GA2050258@infradead.org>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 10:22:19PM -0800, Chaitanya Kulkarni wrote:
> Remove the bvec check in the bio_iov_iter_get_pages() for
> REQ_OP_ZONE_APPEND so that we can reuse the code and build iter from
> bvec.

We should do the same optimization for bvec pages that the normal path
does.  That being said using bio_iov_iter_get_pages in nvmet does not
	make any sense to me whatsover.
