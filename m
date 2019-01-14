Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE0C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D6C20659
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 18:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfANSUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:20:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfANSUs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 13:20:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA04C9FDCC;
        Mon, 14 Jan 2019 18:20:47 +0000 (UTC)
Received: from redhat.com (ovpn-124-229.rdu2.redhat.com [10.10.124.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB42219744;
        Mon, 14 Jan 2019 18:20:45 +0000 (UTC)
Date:   Mon, 14 Jan 2019 13:20:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190114131114-mutt-send-email-mst@kernel.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
 <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
 <20190114095002.GA29874@lst.de>
 <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 14 Jan 2019 18:20:48 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 08:41:37PM +0800, Jason Wang wrote:
> 
> On 2019/1/14 下午5:50, Christoph Hellwig wrote:
> > On Mon, Jan 14, 2019 at 05:41:56PM +0800, Jason Wang wrote:
> > > On 2019/1/11 下午5:15, Joerg Roedel wrote:
> > > > On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
> > > > > Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
> > > > > all virtio devices under AMD-SEV guests?
> > > > Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
> > > > aperture, because that memory is not encrypted. The guest bounces the
> > > > data then to its encrypted memory.
> > > > 
> > > > Regards,
> > > > 
> > > > 	Joerg
> > > 
> > > Thanks, have you tested vhost-net in this case. I suspect it may not work
> > Which brings me back to my pet pevee that we need to take actions
> > that virtio uses the proper dma mapping API by default with quirks
> > for legacy cases.  The magic bypass it uses is just causing problems
> > over problems.
> 
> 
> Yes, I fully agree with you. This is probably an exact example of such
> problem.
> 
> Thanks

I don't think so - the issue is really that DMA API does not yet handle
the SEV case 100% correctly. I suspect passthrough devices would have
the same issue.

In fact whoever sets IOMMU_PLATFORM is completely unaffected by
Christoph's pet peeve.

Christoph is saying that !IOMMU_PLATFORM devices should hide the
compatibility code in a special per-device DMA API implementation.
Which would be fine especially if we can manage not to introduce a bunch
of indirect calls all over the place and hurt performance.  It's just
that the benefit is unlikely to be big (e.g. we can't also get rid of
the virtio specific memory barriers) so no one was motivated enough to
work on it.

-- 
MST
