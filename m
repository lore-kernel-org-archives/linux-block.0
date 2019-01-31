Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8757C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4275218AF
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 14:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfAaOh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:37:26 -0500
Received: from verein.lst.de ([213.95.11.211]:57918 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbfAaOhZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 09:37:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DEC2868C8E; Thu, 31 Jan 2019 15:37:23 +0100 (CET)
Date:   Thu, 31 Jan 2019 15:37:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH] dma: Uninline dma_max_mapping_size()
Message-ID: <20190131143723.GA32329@lst.de>
References: <20190130164007.26497-1-joro@8bytes.org> <20190130164007.26497-4-joro@8bytes.org> <20190131104129.GA9241@lst.de> <20190131130127.GP32526@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131130127.GP32526@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 02:01:27PM +0100, Joerg Roedel wrote:
> On Thu, Jan 31, 2019 at 11:41:29AM +0100, Christoph Hellwig wrote:
> > Sorry for not noticing last time, but since 5.0 we keep all non-fast
> > path DMA mapping interfaces out of line, so this should move to
> > kernel/dma/mapping.c.
> 
> Okay, attached patch does that. It applies on-top of this patch-set.
> 
> Michael, feel free to either apply this on-top of the patch-set or merge
> the diff into patch 3, whatever you prefer.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I'd prefer it to be squashed if possible.
