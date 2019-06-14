Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B3BC31E4C
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 07:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A822073F
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 07:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfFNHW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:22:58 -0400
Received: from verein.lst.de ([213.95.11.211]:44754 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFNHW6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 03:22:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2F2DD68B02; Fri, 14 Jun 2019 09:22:29 +0200 (CEST)
Date:   Fri, 14 Jun 2019 09:22:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     joro@8bytes.org, axboe@kernel.dk, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, hch@lst.de,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/5] block: add a helper function to merge the
 segments by an IOMMU
Message-ID: <20190614072228.GC8420@lst.de>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm a little worried about this directly calling into the iommu
API instead of going through the DMA mapping code.  We still have
plenty of iommus not using the iommu layer for DMA mapping.  But at
least this code is in the block layer and not the driver, so maybe
we can live with it.
