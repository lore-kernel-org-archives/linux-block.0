Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92977C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616172081C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 13:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616172081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeLENls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:41:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbeLENls (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 08:41:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA8DD308ED4E;
        Wed,  5 Dec 2018 13:41:47 +0000 (UTC)
Received: from redhat.com (ovpn-122-208.rdu2.redhat.com [10.10.122.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9851A19741;
        Wed,  5 Dec 2018 13:41:43 +0000 (UTC)
Date:   Wed, 5 Dec 2018 08:41:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Liu, Changpeng" <changpeng.liu@intel.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v9] virtio_blk: add discard and write zeroes support
Message-ID: <20181205084049-mutt-send-email-mst@kernel.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181101224035.215548-1-dverkamp@chromium.org>
 <20181102041751.GA13688@stefanha-x1.localdomain>
 <FF7FC980937D6342B9D289F5F3C7C2625B7817C5@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B7817C5@SHSMSX103.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Dec 2018 13:41:47 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, Dec 05, 2018 at 09:46:16AM +0000, Liu, Changpeng wrote:
> What's the status of this patch ? anybody pulled it for the branch ?

I will merge it for next.

> 
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Friday, November 2, 2018 12:18 PM
> > To: Daniel Verkamp <dverkamp@chromium.org>
> > Cc: virtualization@lists.linux-foundation.org; linux-block@vger.kernel.org;
> > Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> > Jens Axboe <axboe@kernel.dk>; Paolo Bonzini <pbonzini@redhat.com>;
> > Christoph Hellwig <hch@infradead.org>; Liu, Changpeng
> > <changpeng.liu@intel.com>
> > Subject: Re: [PATCH v9] virtio_blk: add discard and write zeroes support
> > 
> > On Thu, Nov 01, 2018 at 03:40:35PM -0700, Daniel Verkamp wrote:
> > > From: Changpeng Liu <changpeng.liu@intel.com>
> > >
> > > In commit 88c85538, "virtio-blk: add discard and write zeroes features
> > > to specification" (https://github.com/oasis-tcs/virtio-spec), the virtio
> > > block specification has been extended to add VIRTIO_BLK_T_DISCARD and
> > > VIRTIO_BLK_T_WRITE_ZEROES commands.  This patch enables support for
> > > discard and write zeroes in the virtio-blk driver when the device
> > > advertises the corresponding features, VIRTIO_BLK_F_DISCARD and
> > > VIRTIO_BLK_F_WRITE_ZEROES.
> > >
> > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > > ---
> > > dverkamp: I've picked up this patch and made a few minor changes (as
> > > listed below); most notably, I changed the kmalloc back to GFP_ATOMIC,
> > > since it can be called from a context where sleeping is not allowed.
> > > To prevent large allocations, I've also clamped the maximum number of
> > > discard segments to 256; this results in a 4K allocation and should be
> > > plenty of descriptors for most use cases.
> > >
> > > I also removed most of the description from the commit message, since it
> > > was duplicating the comments from virtio_blk.h and quoting parts of the
> > > spec without adding any extra information.  I have tested this iteration
> > > of the patch using crosvm with modifications to enable the new features:
> > > https://chromium.googlesource.com/chromiumos/platform/crosvm/
> > >
> > > v9 fixes a number of review issues; I didn't attempt to optimize the
> > > single-element write zeroes case, so it still does an allocation per
> > > request (I did not see any easy place to put the payload that would
> > > avoid the allocation).
> > >
> > > CHANGELOG:
> > > v9: [dverkamp] fix LE types in discard struct; cleanups from Ming Lei
> > > v8: [dverkamp] replace shifts by 9 with SECTOR_SHIFT constant
> > > v7: [dverkamp] use GFP_ATOMIC for allocation that may not sleep; clarify
> > > descriptor flags field; comment wording cleanups.
> > > v6: don't set T_OUT bit to discard and write zeroes commands.
> > > v5: use new block layer API: blk_queue_flag_set.
> > > v4: several optimizations based on MST's comments, remove bit field
> > > usage for command descriptor.
> > > v3: define the virtio-blk protocol to add discard and write zeroes
> > > support, first version implementation based on proposed specification.
> > > v2: add write zeroes command support.
> > > v1: initial proposal implementation for discard command.
> > > ---
> > >  drivers/block/virtio_blk.c      | 83 ++++++++++++++++++++++++++++++++-
> > >  include/uapi/linux/virtio_blk.h | 54 +++++++++++++++++++++
> > >  2 files changed, 135 insertions(+), 2 deletions(-)
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
