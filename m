Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD7C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D50F206B7
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfANUTh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:19:37 -0500
Received: from verein.lst.de ([213.95.11.211]:48694 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfANUTh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 15:19:37 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 296D968D93; Mon, 14 Jan 2019 21:19:35 +0100 (CET)
Date:   Mon, 14 Jan 2019 21:19:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190114201935.GA10781@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org> <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com> <20190111091502.GC5825@8bytes.org> <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com> <20190114095002.GA29874@lst.de> <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com> <20190114131114-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114131114-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 01:20:45PM -0500, Michael S. Tsirkin wrote:
> I don't think so - the issue is really that DMA API does not yet handle
> the SEV case 100% correctly. I suspect passthrough devices would have
> the same issue.

The DMA API handles the SEV case perfectly.  Its just that virtio_blk
supports huge segments that virtio does not generally support, but that
is not related to SEV in any way.

> In fact whoever sets IOMMU_PLATFORM is completely unaffected by
> Christoph's pet peeve.

No, the above happens only when we set IOMMU_PLATFORM.

> Christoph is saying that !IOMMU_PLATFORM devices should hide the
> compatibility code in a special per-device DMA API implementation.
> Which would be fine especially if we can manage not to introduce a bunch
> of indirect calls all over the place and hurt performance.  It's just
> that the benefit is unlikely to be big (e.g. we can't also get rid of
> the virtio specific memory barriers) so no one was motivated enough to
> work on it.

No.  The problem is that we still haven't fully specified what
IOMMU_PLATFORM and !IOMMU_PLATFORM actually mean.  Your
"ACCESS_PLATFORM/ORDER_PLATFORM" commit in the virtio-spec repo
improves it a little bit, but it is still far from enough.

As a start VIRTIO_F_ORDER_PLATFORM and VIRTIO_F_ACCESS_PLATFORM
absolutely MUST be set for hardware implementations.  Otherwise said
hardware has no chance of working on anything but the most x86-like
systems.

Second software implementations SHOULD set VIRTIO_F_ACCESS_PLATFORM,
because otherwise we can't add proper handling for things like SEV or
the IBM "secure hypervisor" thing.

Last but not least a lot of wording outside the area describing these
flags really needs some major updates in terms of DMA access.
