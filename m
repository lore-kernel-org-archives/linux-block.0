Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308FCC49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C80620CC7
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 10:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfIKKgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:36:44 -0400
Received: from verein.lst.de ([213.95.11.211]:38113 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfIKKgo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 06:36:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E40268B02; Wed, 11 Sep 2019 12:36:39 +0200 (CEST)
Date:   Wed, 11 Sep 2019 12:36:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: Respect the device's maximum segment size
Message-ID: <20190911103639.GA28124@lst.de>
References: <20190909125658.30559-1-thierry.reding@gmail.com> <20190909125658.30559-2-thierry.reding@gmail.com> <20190909161331.GA19650@lst.de> <20190909191911.GC23804@mithrandir> <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com> <20190910061348.GA30982@lst.de> <20190910073739.GB12537@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910073739.GB12537@ulmo>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 10, 2019 at 09:37:39AM +0200, Thierry Reding wrote:
> > > After that, all mmc controllers disable the feature as default, and if a mmc
> > > controller has such capable, the host driver should set the flag.
> > 
> > That sounds sensible to me.  Alternatively we'd have to limit
> > max_sectors to 16-bit values for sdhci if using an iommu that can
> > merge.
> 
> Isn't that effectively what dma_set_max_seg_size() is supposed to be
> doing? That tells the DMA API what the maximum size of a segment can
> be for the given device, right? If we make sure never to exceed that
> when compacting the SG, the SG that we get back should map just fine
> into the descriptors that SDHCI supports.

dma_set_max_seg_size() does indeed instruct the iommu drivers about
the merging capabilities (btw, swiotlb should be able to implement
this kind of merging as well, but that is a different discussion).

But the problem is that you don't just change the dma_set_max_seg_size,
but also the block layer max segment size setting, which is used for
block layer merges.  And we don't have the accounting for the first and
last segment in a request (those that are being merged to), so if you
enable the virt_boundary segments can grow to a size only limited by the
maximum request size.  We could add that accounting with a bit of
work, it's just that for devices that typicall use the virt boundary
there is no point (their actually segment is a page and not related
to the Linux "segment").
