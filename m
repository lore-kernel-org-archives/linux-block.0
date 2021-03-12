Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC9FC433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743B664F86
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhCLT74 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 14:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbhCLT7t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 14:59:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E123C061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 11:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z/WVDPyoiYx+3v4MoI6hQ+ccpVUKQN/8sNngspuqCn4=; b=s+c/9ngZmGFynR3M9SEFQGA7T9
        ELHfC718T0Gb3pShqor0e7nFsS8P+xKN8mm/tukmPnT8wpadXRN8dJoICuNgqZuj0UBUmtRQAo/bJ
        IaJoB/P3+/eBywJaGoPW36SOkDqT3dlZxSzXMk18dH2TMxT9Wu6Ss58wwCgM+Bmizdh9KSUHtDABT
        /+eEMdK/OZr4gajPEew5vYIeUUXD3/moByeLkuJjbHAg7BF6i8nix0P4psAr9JzvxwTOceh/jBS3C
        ZbzutXQ0uRqC2V4zz9aGw8e2p5QVq2+Q83p9ctFik58rZ9OBj0UVcI1y5IZOBiCEDPn2+5Z2JkzQa
        SgSCZWoA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKnwa-00Bbj1-5F; Fri, 12 Mar 2021 19:59:35 +0000
Date:   Fri, 12 Mar 2021 19:59:32 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 5.12
Message-ID: <20210312195932.GA2766489@infradead.org>
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
> > The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
> > 
> >   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
> 
> Pulled, thanks.

I just sent you another one liner fixup on top of this directly.
