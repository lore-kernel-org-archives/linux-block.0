Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05683C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63172082E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfA1ROg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfA1ROg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 12:14:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3D3658E5B;
        Mon, 28 Jan 2019 17:14:35 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id CDEC660BEC;
        Mon, 28 Jan 2019 17:14:33 +0000 (UTC)
Date:   Mon, 28 Jan 2019 12:14:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Message-ID: <20190128121407-mutt-send-email-mst@kernel.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-6-joro@8bytes.org>
 <20190123213139.GD9032@lst.de>
 <20190124084011.GJ32526@8bytes.org>
 <20190124084221.GB19441@lst.de>
 <20190124095150.GL32526@8bytes.org>
 <20190128080526.GA3874@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128080526.GA3874@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 28 Jan 2019 17:14:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 09:05:26AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 24, 2019 at 10:51:51AM +0100, Joerg Roedel wrote:
> > On Thu, Jan 24, 2019 at 09:42:21AM +0100, Christoph Hellwig wrote:
> > > Yes.  But more importantly it would fix the limit for all other block
> > > drivers that set large segment sizes when running over swiotlb.
> > 
> > True, so it would be something like the diff below? I havn't worked on
> > the block layer, so I don't know if that needs additional checks for
> > ->dev or anything.
> 
> Looks sensible.  Maybe for now we'll just do the virtio-blk case
> that triggered it, and we'll do something like this patch for the
> next merge window.  We'll also need to apply the same magic to the
> DMA boundary.

So do I get an ack for this patch then?

-- 
MST
