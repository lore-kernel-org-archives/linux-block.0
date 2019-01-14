Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709AC43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E1A20656
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfANUsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:48:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfANUsu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 15:48:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C550AC02938F;
        Mon, 14 Jan 2019 20:48:49 +0000 (UTC)
Received: from redhat.com (ovpn-124-229.rdu2.redhat.com [10.10.124.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id 047015D73F;
        Mon, 14 Jan 2019 20:48:47 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:48:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Wang <jasowang@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190114153004-mutt-send-email-mst@kernel.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
 <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
 <20190114095002.GA29874@lst.de>
 <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
 <20190114131114-mutt-send-email-mst@kernel.org>
 <20190114201935.GA10781@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114201935.GA10781@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 14 Jan 2019 20:48:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 09:19:35PM +0100, Christoph Hellwig wrote:
> > Christoph is saying that !IOMMU_PLATFORM devices should hide the
> > compatibility code in a special per-device DMA API implementation.
> > Which would be fine especially if we can manage not to introduce a bunch
> > of indirect calls all over the place and hurt performance.  It's just
> > that the benefit is unlikely to be big (e.g. we can't also get rid of
> > the virtio specific memory barriers) so no one was motivated enough to
> > work on it.
> 
> No.  

Oh ok then.

> The problem is that we still haven't fully specified what
> IOMMU_PLATFORM and !IOMMU_PLATFORM actually mean.  Your
> "ACCESS_PLATFORM/ORDER_PLATFORM" commit in the virtio-spec repo
> improves it a little bit, but it is still far from enough.
> 
> As a start VIRTIO_F_ORDER_PLATFORM and VIRTIO_F_ACCESS_PLATFORM
> absolutely MUST be set for hardware implementations.  Otherwise said
> hardware has no chance of working on anything but the most x86-like
> systems.

I think you are exaggerating a little here.  Limited access with e.g.
need to flush caches is common on lower end but less common on higher
end systems used for virtualization.  As you point out that changes with
e.g. SEV but then SEV is a pretty niche thing so far.

So I would make that a SHOULD probably.

> Second software implementations SHOULD set VIRTIO_F_ACCESS_PLATFORM,
> because otherwise we can't add proper handling for things like SEV or
> the IBM "secure hypervisor" thing.

Yes. If host does not have access to all of memory it SHOULD set
VIRTIO_F_ACCESS_PLATFORM.

It seems rather straight-forward to add conformance clauses
for this, thanks for reminding me.


> Last but not least a lot of wording outside the area describing these
> flags really needs some major updates in terms of DMA access.

Thanks for the reminder. Yes generally spec tends to still say e.g.
"physical address" where it really means a "DMA address" in Linux terms.
Whether changing that will make things much clearer I'm not sure. E.g.
hardware designers don't much care I guess.

If you want to list the most problematic cases, e.g. in a github issue,
we might get to clarifying them sooner.

Thanks!

-- 
MST
