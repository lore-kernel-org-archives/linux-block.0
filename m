Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85630C33C9E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 01:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFEF20848
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 01:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEG0V6RT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAHB7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:59:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgAHB7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 20:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578448778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjLwLmpSUbg8u0AztC/Qpmmv1mRzMlVQIb/3GK56guo=;
        b=IEG0V6RTjdwgl7ZUrdFxmxpGScBrAHO4ptp83xb7jD7K/GFNTSYBwlvtNxSjlcu61TgjmJ
        o6CjrZQEUXDVxpuq+xLvZ/U8XOnXMCzLmhnWtx/00jsxRhlf1oifJFUGoWAE22a4CZrDxQ
        jeHNvaVQhuANXOov9OhEauaypRIw2rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-cnd4LJBYMxmd5ueqmLhsgQ-1; Tue, 07 Jan 2020 20:59:26 -0500
X-MC-Unique: cnd4LJBYMxmd5ueqmLhsgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7970B801E76;
        Wed,  8 Jan 2020 01:59:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 554A260CD1;
        Wed,  8 Jan 2020 01:59:19 +0000 (UTC)
Date:   Wed, 8 Jan 2020 09:59:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200108015915.GA28075@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200107124708.GA20285@roeck-us.net>
 <20200107152339.GA23622@ming.t460p>
 <20200107181145.GA22076@roeck-us.net>
 <20200107223035.GA7505@ming.t460p>
 <25ce5140-ee29-c32c-7f5e-b8c6da5c7e90@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ce5140-ee29-c32c-7f5e-b8c6da5c7e90@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 03:32:58PM -0700, Jens Axboe wrote:
> On 1/7/20 3:30 PM, Ming Lei wrote:
> > On Tue, Jan 07, 2020 at 10:11:45AM -0800, Guenter Roeck wrote:
> >> On Tue, Jan 07, 2020 at 11:23:39PM +0800, Ming Lei wrote:
> >>> On Tue, Jan 07, 2020 at 04:47:08AM -0800, Guenter Roeck wrote:
> >>>> Hi,
> >>>>
> >>>> On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
> >>>>> There are two issues in get_max_segment_size():
> >>>>>
> >>>>> 1) the default segment boudary mask is bypassed, and some devices still
> >>>>> require segment to not cross the default 4G boundary
> >>>>>
> >>>>> 2) the segment start address isn't taken into account when checking
> >>>>> segment boundary limit
> >>>>>
> >>>>> Fixes the two issues.
> >>>>>
> >>>>> Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> >>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>
> >>>> This patch, pushed into mainline as "block: fix splitting segments on
> >>>> boundary masks", results in the following crash when booting 'versatilepb'
> >>>> in qemu from disk. Bisect log is attached. Detailed log is at
> >>>> https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio
> >>>>
> >>>> Guenter
> >>>>
> >>>> ---
> >>>> Crash:
> >>>>
> >>>> kernel BUG at block/bio.c:1885!
> >>>> Internal error: Oops - BUG: 0 [#1] ARM
> >>>
> >>> Please apply the following debug patch, and post the log.
> >>>
> >>
> >> Here you are:
> >>
> >> max_sectors 2560 max_segs 96 max_seg_size 65536 mask ffffffff
> >> c738da80: 8c80/0 2416 28672, 0
> >>          total sectors 56
> >>
> >> (I replaced %p with %px).
> >>
> > 
> > Please try the following patch and see if it makes a difference.
> > If not, replace trace_printk with printk in previous debug patch,
> > and apply the debug patch only & post the log.
> 
> If it is a 32-bit issue, then we should use a 64-bit type to make
> this nicer than ULL. But it seems reasonable that it could be!

oops, just saw this email after sending out the patch.

Do you need V2 to change ULL to u64?

Thanks,
Ming

