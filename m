Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABACAC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718EE214C1
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718EE214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeLEJqV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:46:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:6946 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeLEJqU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 04:46:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 01:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="281086767"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2018 01:46:19 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 5 Dec 2018 01:46:19 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 5 Dec 2018 01:46:18 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.59]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.203]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 17:46:17 +0800
From:   "Liu, Changpeng" <changpeng.liu@intel.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH v9] virtio_blk: add discard and write zeroes support
Thread-Topic: [PATCH v9] virtio_blk: add discard and write zeroes support
Thread-Index: AQHUcjQQNCYajLkQD0OZ0ggqkzfaiaU7W4WAgDS+ULA=
Date:   Wed, 5 Dec 2018 09:46:16 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B7817C5@SHSMSX103.ccr.corp.intel.com>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181101224035.215548-1-dverkamp@chromium.org>
 <20181102041751.GA13688@stefanha-x1.localdomain>
In-Reply-To: <20181102041751.GA13688@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOThlY2NiZDQtMDUyNC00NDhmLWE2Y2UtZTYwMjZmMmQ5OGVmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUU5PZUtUdTVnUFhKSmVtN1wvdmk2UUZPRnhoUmF2K3Z1dkRsODZPNUgyQWZ3YXJGNVlkQnZDQ3h1ZnhMWUxPQjcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

What's the status of this patch ? anybody pulled it for the branch ?

> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Friday, November 2, 2018 12:18 PM
> To: Daniel Verkamp <dverkamp@chromium.org>
> Cc: virtualization@lists.linux-foundation.org; linux-block@vger.kernel.org;
> Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> Jens Axboe <axboe@kernel.dk>; Paolo Bonzini <pbonzini@redhat.com>;
> Christoph Hellwig <hch@infradead.org>; Liu, Changpeng
> <changpeng.liu@intel.com>
> Subject: Re: [PATCH v9] virtio_blk: add discard and write zeroes support
> 
> On Thu, Nov 01, 2018 at 03:40:35PM -0700, Daniel Verkamp wrote:
> > From: Changpeng Liu <changpeng.liu@intel.com>
> >
> > In commit 88c85538, "virtio-blk: add discard and write zeroes features
> > to specification" (https://github.com/oasis-tcs/virtio-spec), the virtio
> > block specification has been extended to add VIRTIO_BLK_T_DISCARD and
> > VIRTIO_BLK_T_WRITE_ZEROES commands.  This patch enables support for
> > discard and write zeroes in the virtio-blk driver when the device
> > advertises the corresponding features, VIRTIO_BLK_F_DISCARD and
> > VIRTIO_BLK_F_WRITE_ZEROES.
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > ---
> > dverkamp: I've picked up this patch and made a few minor changes (as
> > listed below); most notably, I changed the kmalloc back to GFP_ATOMIC,
> > since it can be called from a context where sleeping is not allowed.
> > To prevent large allocations, I've also clamped the maximum number of
> > discard segments to 256; this results in a 4K allocation and should be
> > plenty of descriptors for most use cases.
> >
> > I also removed most of the description from the commit message, since it
> > was duplicating the comments from virtio_blk.h and quoting parts of the
> > spec without adding any extra information.  I have tested this iteration
> > of the patch using crosvm with modifications to enable the new features:
> > https://chromium.googlesource.com/chromiumos/platform/crosvm/
> >
> > v9 fixes a number of review issues; I didn't attempt to optimize the
> > single-element write zeroes case, so it still does an allocation per
> > request (I did not see any easy place to put the payload that would
> > avoid the allocation).
> >
> > CHANGELOG:
> > v9: [dverkamp] fix LE types in discard struct; cleanups from Ming Lei
> > v8: [dverkamp] replace shifts by 9 with SECTOR_SHIFT constant
> > v7: [dverkamp] use GFP_ATOMIC for allocation that may not sleep; clarify
> > descriptor flags field; comment wording cleanups.
> > v6: don't set T_OUT bit to discard and write zeroes commands.
> > v5: use new block layer API: blk_queue_flag_set.
> > v4: several optimizations based on MST's comments, remove bit field
> > usage for command descriptor.
> > v3: define the virtio-blk protocol to add discard and write zeroes
> > support, first version implementation based on proposed specification.
> > v2: add write zeroes command support.
> > v1: initial proposal implementation for discard command.
> > ---
> >  drivers/block/virtio_blk.c      | 83 ++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/virtio_blk.h | 54 +++++++++++++++++++++
> >  2 files changed, 135 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
