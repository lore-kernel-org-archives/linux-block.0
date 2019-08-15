Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA1C31E40
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E782063F
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 07:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfHOHaT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:30:19 -0400
Received: from verein.lst.de ([213.95.11.211]:44372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfHOHaT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 03:30:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88C3F68AFE; Thu, 15 Aug 2019 09:30:14 +0200 (CEST)
Date:   Thu, 15 Aug 2019 09:30:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org, axboe@kernel.dk,
        wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 0/5] treewide: improve R-Car SDHI performance
Message-ID: <20190815073014.GA24301@lst.de>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So, what are we going to do with this series?  As said before I'd
volunteer to pick this up through the dma-mapping tree, but I'd like
to see ACKs from the other maintainers as well.
