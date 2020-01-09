Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B909BC32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 07:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ACA206ED
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 07:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G13O2wR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgAIHQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:16:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jan 2020 02:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ALrNkB8wbgJQmnoKLqSqqTvqaRSOsyc5JM1ga9vJ0x8=; b=G13O2wR8wDX5Io0mYWt9eSLHB
        LtSGt+CaPPBp6ucYXx7Rgok9o/cb2NKna3MjDQAX0VD6UNuKKJR0qjra0n/F7OFqfB/hlwcwuUShF
        i8azgojIK13t+cDHIdIAQQSd2p4SEhdwA1+M6BWKZOMqblre9Tx9gnWasthrYzt9DfS87IY4HEFe4
        tHxr2jEu5/sdLNaQI7vwHIsImpGWR5/uj/fZKtzjH9MB5I2mC12bJQ09hTErvwntZOuTurQziki3C
        EWM2oEInmUNbOrTahbCB+qZPsYYZuOab8WFQQn7ydApBCuU5GOr3/pvaPk5Nkt0V2xrwVm8jzPbf4
        iMIBL31dA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipS3E-00005m-Ec; Thu, 09 Jan 2020 07:16:16 +0000
Date:   Wed, 8 Jan 2020 23:16:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200109071616.GA32217@infradead.org>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org>
 <20200109020341.GC9655@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109020341.GC9655@ming.t460p>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 09, 2020 at 10:03:41AM +0800, Ming Lei wrote:
> It has been addressed in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a

That is probably correct, but still highly suboptimal for most 32-bit
architectures where physical addresses are 32 bits wide.  To fix that
the proper phys_addr_t type should be used.
