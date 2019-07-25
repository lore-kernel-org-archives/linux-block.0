Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E867C76194
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 06:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA6F2190F
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 06:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGYGdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:33:33 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:54618 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYGdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 02:33:33 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0672425BE27;
        Thu, 25 Jul 2019 16:33:31 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 0939CE2209B; Thu, 25 Jul 2019 08:33:29 +0200 (CEST)
Date:   Thu, 25 Jul 2019 08:33:28 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org, axboe@kernel.dk,
        wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 2/5] iommu/dma: Add a new dma_map_ops of
 get_merge_boundary()
Message-ID: <20190725063328.ua5fu6dqig2a4rrf@verge.net.au>
References: <1563859608-19456-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1563859608-19456-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <ae95cc2e-38b4-0ed9-744a-67f03f220a3f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae95cc2e-38b4-0ed9-744a-67f03f220a3f@cogentembedded.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 11:17:19AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 23.07.2019 8:26, Yoshihiro Shimoda wrote:
> 
> > This patch adds a new dma_map_ops of get_merge_boundary() to
> > expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Sergei's comment notwithstanding,

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> > ---
> >   drivers/iommu/dma-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index a7f9c3e..f3e5f2b 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >   	return ret;
> >   }
> > +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +
> > +	if (domain->type != IOMMU_DOMAIN_DMA)
> > +		return 0;	/* can't merge */
> > +
> > +	return (1 << __ffs(domain->pgsize_bitmap)) - 1;
> 
>    Not 1UL?
> 
> > +}
> > +
> >   static const struct dma_map_ops iommu_dma_ops = {
> >   	.alloc			= iommu_dma_alloc,
> >   	.free			= iommu_dma_free,
> [...]
> 
> MBR, Sergei
> 
