Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0329C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C4920656
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfAONh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:37:56 -0500
Received: from verein.lst.de ([213.95.11.211]:53107 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfAONhz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 08:37:55 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0B4CD67358; Tue, 15 Jan 2019 14:37:54 +0100 (CET)
Date:   Tue, 15 Jan 2019 14:37:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 2/3] dma: Introduce dma_max_mapping_size()
Message-ID: <20190115133754.GB29225@lst.de>
References: <20190115132257.6426-1-joro@8bytes.org> <20190115132257.6426-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115132257.6426-3-joro@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +size_t dma_direct_max_mapping_size(struct device *dev)
> +{
> +	/*
> +	 * Return the minimum of the direct DMA limit and the SWIOTLB limit.
> +	 * Since direct DMA has no limit, it is fine to just return the SWIOTLB
> +	 * limit.
> +	 */
> +	return swiotlb_max_mapping_size(dev);

Well, if we don't actually use the swiotlb buffers despite it being
compiled in or even allocated we don't need the limit.
