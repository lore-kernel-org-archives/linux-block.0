Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ACFC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70E92082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70E92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeK1M2l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeK1M2l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 07:28:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5C513084031;
        Wed, 28 Nov 2018 01:28:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A54D56012B;
        Wed, 28 Nov 2018 01:28:44 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:28:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     tom.leiming@gmail.com, axboe@kernel.dk,
        Gwendal Grignou <gwendal@chromium.org>, asavery@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
Message-ID: <20181128012837.GC11128@ming.t460p>
References: <20181030230624.61834-1-evgreen@chromium.org>
 <20181030230624.61834-3-evgreen@chromium.org>
 <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com>
 <CACVXFVN63UDefvBnYTQ==tWwYqGJbCS_HK==-1jVa5sVc=-Upw@mail.gmail.com>
 <CAE=gft55MVc7JGJw427VByihrgw1yYDFYCxuqUOh4xm5P4ZoAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft55MVc7JGJw427VByihrgw1yYDFYCxuqUOh4xm5P4ZoAA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 28 Nov 2018 01:28:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 03:34:04PM -0800, Evan Green wrote:
> Hi Ming,
> 
> On Mon, Nov 26, 2018 at 6:55 PM Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 2:55 AM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > On Tue, Oct 30, 2018 at 4:06 PM Evan Green <evgreen@chromium.org> wrote:
> > > >
> > > > If the backing device for a loop device is a block device,
> >
> > This shouldn't be a very common use case wrt. loop.
> 
> Yeah, I'm starting to gather that. Or maybe I'm just the first one to
> mention it on the kernel lists ;) We've used this in our Chrome OS
> installer, I believe for many years. Gwendal piped in with a few
> reasons we do it this way on the cover letter, but in general I think
> it allows us to have a unified set of functions to install to a file,
> disk, or prepare an image that may have a different block size than
> those on the running system.

OK, got it, it makes sense.

> 
> >
> > > > then mirror the discard properties of the underlying block
> > > > device into the loop device. While in there, differentiate
> > > > between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> > > > different for block devices, but which the loop device had
> > > > just been lumping together.
> > > >
> > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > >
> > > Any thoughts on this patch? This fixes issues for us when using a loop
> > > device backed by a block device, where we see many logs like:
> > >
> > > [  372.767286] print_req_error: I/O error, dev loop5, sector 88125696
> >
> > Seems not see any explanation about this IO error and the fix in your patch.
> > Could you describe it a bit more?
> 
> Sure, I probably should have included more context with the series.
> 
> The loop device always reports that it supports discard, by setting up
> the max_discard_sectors and max_write_zeroes_sectors in the blk queue.
> When the loop device gets a discard or write-zeroes request, it turns
> around and calls fallocate on the underlying device with the
> PUNCH_HOLE flag. This makes sense when you're backed by a file and
> hoping to just deallocate the space, but may fail when you're backed
> by a block device that doesn't support discard, or doesn't write
> zeroes to discarded sectors. Weirdly, lo_discard already had some code
> for preserving EOPNOTSUPP, but then later the error is smashed into
> EIO. Patch 1 pipes out EOPNOTSUPP properly, so it doesn't get squashed
> into EIO.
> 
> Patch 2 reflects the discard characteristics of the underlying device
> into the loop device. That way, if you're backed by a file or a block
> device that does support discard, everything works great, and user
> mode can even see and use the correct discard and write zero
> granularities. If you're backed by a block device that does not
> support discard, this is exposed to user mode, which then usually
> avoids calling fallocate, and doesn't feel betrayed that their
> requests are unexpectedly failing.

Thanks for your detailed explanation, and I think we need to fix it.

Thanks,
Ming
