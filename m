Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F15C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8D20856
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfA1RTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:19:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732138AbfA1RTF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 12:19:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A3BFC059B6D;
        Mon, 28 Jan 2019 17:19:04 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1C4225DEB4;
        Mon, 28 Jan 2019 17:19:03 +0000 (UTC)
Date:   Mon, 28 Jan 2019 12:19:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Message-ID: <20190128121749-mutt-send-email-mst@kernel.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-3-joro@8bytes.org>
 <20190123212755.GA9032@lst.de>
 <20190124082923.GI32526@8bytes.org>
 <20190124084107.GA19441@lst.de>
 <20190124150000.GN32526@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124150000.GN32526@8bytes.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 28 Jan 2019 17:19:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 04:00:00PM +0100, Joerg Roedel wrote:
> On Thu, Jan 24, 2019 at 09:41:07AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 24, 2019 at 09:29:23AM +0100, Joerg Roedel wrote:
> > > > As I've just introduced and fixed a bug in this area in the current
> > > > cycle - I don't think no_iotlb_memory is what your want (and maybe
> > > > not useful at all): if the arch valls swiotlb_exit after previously
> > > > initializing a buffer it won't be set.  You probably want to check
> > > > for non-zero io_tlb_start and/or io_tlb_end.
> > > 
> > > Okay, but that requires that I also set io_tlb_start and friends back to
> > > zero in the failure path of swiotlb_init(). Otherwise it could be left
> > > non-zero in case swiotlb_init_with_tbl() returns an error.
> > 
> > Indeed, and we'll need to do that anyway as otherwise the dma mapping
> > path might cause problems similar to the one when swiotlb_exit is
> > called that I fixed.
> 
> Turns out the the error path in swiotlb_init() is redundant because it
> will never be executed. If the function returns it will always return 0
> because in case of failure it will just panic (through memblock_alloc).
> 
> I'll clean that up in a separate patch-set. There are more users of that
> function and all of them panic when the function fails.
> 
> 
> 	Joerg

OK so are you going to post a new version then? Time's running out for 5.0.
This isn't a regression so maybe we should just defer it all to 5.1.

-- 
MST
