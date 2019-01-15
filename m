Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C955AC43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C4B20866
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfAONJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:09:25 -0500
Received: from verein.lst.de ([213.95.11.211]:52950 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbfAONJZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 08:09:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E3EB767358; Tue, 15 Jan 2019 14:09:22 +0100 (CET)
Date:   Tue, 15 Jan 2019 14:09:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190115130922.GB28364@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org> <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com> <20190111091502.GC5825@8bytes.org> <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com> <20190114095002.GA29874@lst.de> <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com> <20190114131114-mutt-send-email-mst@kernel.org> <20190114201935.GA10781@lst.de> <20190114153004-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114153004-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 03:48:47PM -0500, Michael S. Tsirkin wrote:
> I think you are exaggerating a little here.  Limited access with e.g.
> need to flush caches is common on lower end but less common on higher
> end systems used for virtualization.  As you point out that changes with
> e.g. SEV but then SEV is a pretty niche thing so far.
> 
> So I would make that a SHOULD probably.

The problem is that without using DMA ops you can't just plug the device
into a random system, which is a total no-go for periphals.

And cache flushing is not that uncommmon, e.g. every sparc systems
needs it, many arm/arm64 ones, some power ones, lots of mips ones, etc.

But cache flushing is just one side of it - lots of systems have either
mandatory or option IOMMUs, and without the platform access flag that
doesn't work.  As does that case where you have a DMA offset, which
is extremly common on arm and power systems.  So you might find a few
non-x86 systems you can plug it in and it'll just work, but it won't
be all that many.  And even on x86 your device will be completely broken
if the users dares to use an IOMMU.

> > flags really needs some major updates in terms of DMA access.
> 
> Thanks for the reminder. Yes generally spec tends to still say e.g.
> "physical address" where it really means a "DMA address" in Linux terms.
> Whether changing that will make things much clearer I'm not sure. E.g.
> hardware designers don't much care I guess.

At least say bus address - as said above the CPU and bus concepts of
physicall addresses are different in many systems.  Including x86
when you use IOMMUs.
