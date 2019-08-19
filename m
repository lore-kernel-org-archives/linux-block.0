Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F034C3A5A2
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 12:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09AD2086C
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 12:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfHSMpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:45:38 -0400
Received: from 8bytes.org ([81.169.241.247]:50242 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfHSMph (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 08:45:37 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7A64E309; Mon, 19 Aug 2019 14:45:35 +0200 (CEST)
Date:   Mon, 19 Aug 2019 14:45:35 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, axboe@kernel.dk,
        wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 2/5] iommu/dma: Add a new dma_map_ops of
 get_merge_boundary()
Message-ID: <20190819124535.GB30332@8bytes.org>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 26, 2019 at 05:31:13PM +0900, Yoshihiro Shimoda wrote:
> This patch adds a new dma_map_ops of get_merge_boundary() to
> expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Joerg Roedel <jroedel@suse.de>
