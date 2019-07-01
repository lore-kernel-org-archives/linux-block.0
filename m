Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25254C06510
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092FB213F2
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 08:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfGAIc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:32:57 -0400
Received: from verein.lst.de ([213.95.11.211]:59567 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfGAIc5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 04:32:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D56768B20; Mon,  1 Jul 2019 10:32:54 +0200 (CEST)
Date:   Mon, 1 Jul 2019 10:32:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org, axboe@kernel.dk,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, wsa+renesas@sang-engineering.com,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH v7 0/5] treewide: improve R-Car SDHI performance
Message-ID: <20190701083253.GA22719@lst.de>
References: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any comments from the block, iommu and mmc maintainers?  I'd be happy
to queue this up in the dma-mapping tree, but I'll need some ACKs
for that fast.  Alternatively I can just queue up the DMA API bits,
leaving the rest for the next merge window, but would drag things
out far too long IMHO.
