Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2616EC43612
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AFF2082F
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbfAPOKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:10:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733044AbfAPOKr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 09:10:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F187EAF31;
        Wed, 16 Jan 2019 14:10:45 +0000 (UTC)
Date:   Wed, 16 Jan 2019 15:10:43 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 3/3] virtio-blk: Consider dma_max_mapping_size() for
 maximum segment size
Message-ID: <20190116141043.qbsdbdt72akxpdtj@suse.de>
References: <20190115132257.6426-1-joro@8bytes.org>
 <20190115132257.6426-4-joro@8bytes.org>
 <20190116090355-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116090355-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 09:05:40AM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 15, 2019 at 02:22:57PM +0100, Joerg Roedel wrote:
> > +	max_size = dma_max_mapping_size(&vdev->dev);
> > +
> 
> 
> Should this be limited to ACCESS_PLATFORM?
> 
> I see no reason to limit this without as guest can
> access any memory.

Actually, yes. This should be inside a use_dma_api check. I had it in
v1, but it went away without the vring layer for propagating the limit.
I'll add that again.

Thanks,

	Joerg
