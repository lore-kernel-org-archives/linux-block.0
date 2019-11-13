Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD6C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 07:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2573521D7F
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 07:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gKpHJbkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfKMHTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:19:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMHTY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 02:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qblZPMi7bp82k+FzJXnBEtzEKoETXaSzV1LL9zGjI08=; b=gKpHJbkJ5Hy/aFiu/MkjC9EAo
        TluURmrkQB8RGTuI+559IXx6pS/6uv8CyHvu7XGavq0pspc542IXDSQCpHGENKzn/LCGYCf04lKt6
        IeU6MwOBGMQtIcoCUw3+Wf8I/jJIrUQ8B6Hrq/ypgwxPv04aBtlOGeqVP/ZVtpRXGaE58DXv1Un50
        CI6NZbSaaLY8pqTYqU6s/y0NFT17BbbSzDURJ/u19X11jstVTETOBn4LTp2kFLs0LOmkXNyezlkDw
        myKN5X0KdjNVhdVp167PyXVHmsG++1diP1xanhzntOUrIeXU3zxZTupXpHhZAVZpXpwBGnnwVr2I1
        G5dQluoFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUmvz-0008Nz-Fr; Wed, 13 Nov 2019 07:19:23 +0000
Date:   Tue, 12 Nov 2019 23:19:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Coly Li <colyli@suse.de>
Cc:     axboe@kernel.dk, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 00/10] bcache patches for Linux v5.5
Message-ID: <20191113071923.GB17875@infradead.org>
References: <20191113053346.63536-1-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113053346.63536-1-colyli@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 13, 2019 at 01:33:36PM +0800, Coly Li wrote:
> Hi Jens,
> 
> This is the patches for Linux v5.5. The patches have been testing for
> a while during my current development, they are ready to be merged.
> 
> There are still other patches under testing, I will submit to you in
> later runs if I feel they are solid enough in my testing.

This seems to be missing my patches for the makefile cleanup and export
removal that you acked a while ago.
