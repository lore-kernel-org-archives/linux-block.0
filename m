Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D564EC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980F720869
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfA2RNg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:13:36 -0500
Received: from verein.lst.de ([213.95.11.211]:47386 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfA2RNg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 12:13:36 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EEC9F68CEC; Tue, 29 Jan 2019 18:13:34 +0100 (CET)
Date:   Tue, 29 Jan 2019 18:13:34 +0100
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
Subject: Re: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Message-ID: <20190129171334.GD15195@lst.de>
References: <20190129084342.26030-1-joro@8bytes.org> <20190129084342.26030-5-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129084342.26030-5-joro@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 09:43:41AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This function returns the maximum segment size for a single
> dma transaction of a virtio device. The possible limit comes
> from the SWIOTLB implementation in the Linux kernel, that
> has an upper limit of (currently) 256kb of contiguous
> memory it can map. Other DMA-API implementations might also
> have limits.
> 
> Use the new dma_max_mapping_size() function to determine the
> maximum mapping size when DMA-API is in use for virtio.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
