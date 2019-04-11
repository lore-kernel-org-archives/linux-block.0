Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F897C10F14
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 11:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77905217D4
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 11:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDKLbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:31:15 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:57248 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbfDKLbP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 07:31:15 -0400
X-Greylist: delayed 1544 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 07:31:12 EDT
Received: from dread.disaster.area (pa49-195-160-97.pa.nsw.optusnet.com.au [49.195.160.97])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 35DF13DC1D9;
        Thu, 11 Apr 2019 21:05:26 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hEXWG-0003x5-Hg; Thu, 11 Apr 2019 21:05:24 +1000
Date:   Thu, 11 Apr 2019 21:05:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chris Mason <clm@fb.com>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] io_uring: add support for barrier fsync
Message-ID: <20190411110524.GC1695@dread.disaster.area>
References: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
 <20190409181742.GA24925@infradead.org>
 <5f8d9644-9e8f-c9d2-611e-4b144c62539c@kernel.dk>
 <5BF7FDDE-212E-4F9A-9B50-26BDA99E952A@fb.com>
 <a7f00629-f822-7271-7a4e-ad3b802752e4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f00629-f822-7271-7a4e-ad3b802752e4@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=EHa8gIBQe3daEtuMEU8ptg==:117 a=EHa8gIBQe3daEtuMEU8ptg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=oexKYjalfGEA:10
        a=7-415B0cAAAA:8 a=pfLjWx1H_2b0F3daOCcA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 09, 2019 at 12:46:15PM -0600, Jens Axboe wrote:
> On 4/9/19 12:42 PM, Chris Mason wrote:
> > On 9 Apr 2019, at 14:23, Jens Axboe wrote:
> > 
> >> On 4/9/19 12:17 PM, Christoph Hellwig wrote:
> >>> On Tue, Apr 09, 2019 at 10:27:43AM -0600, Jens Axboe wrote:
> >>>> It's a quite common use case to issue a bunch of writes, then an 
> >>>> fsync
> >>>> or fdatasync when they complete. Since io_uring doesn't guarantee 
> >>>> any
> >>>> type of ordering, the application must track issued writes and wait
> >>>> with the fsync issue until they have completed.
> >>>>
> >>>> Add an IORING_FSYNC_BARRIER flag that helps with this so the 
> >>>> application
> >>>> doesn't have to do this manually. If this flag is set for the fsync
> >>>> request, we won't issue it until pending IO has already completed.
> >>>
> >>> I think we need a much more detailed explanation of the semantics,
> >>> preferably in man page format.
> >>>
> >>> Barrier at least in Linux traditionally means all previously 
> >>> submitted
> >>> requests have finished and no new ones are started until the
> >>> barrier request finishes, which is very heavy handed.  Is that what
> >>> this is supposed to do?  If not what are the exact guarantees vs
> >>> ordering and or barrier semantics?
> >>
> >> The patch description isn't that great, and maybe the naming isn't 
> >> that
> >> intuitive either. The way it's implemented, the fsync will NOT be 
> >> issued
> >> until previously issued IOs have completed. That means both reads and
> >> writes, since there's no way to wait for just one.  In terms of
> >> semantics, any previously submitted writes will have completed before
> >> this fsync is issued. The barrier fsync has no ordering wrt future
> >> writes, no ordering is implied there. Hence:
> >>
> >> W1, W2, W3, FSYNC_W_BARRIER, W4, W5
> >>
> >> W1..3 will have been completed by the hardware side before we start
> >> FSYNC_W_BARRIER. We don't wait with issuing W4..5 until after the 
> >> fsync
> >> completes, no ordering is provided there.
> > 
> > Looking at the patch, why is fsync special?  Seems like you could add 
> > this ordering bit to any write?
> 
> It's really not, the exact same technique could be used on any type of
> command to imply ordering. My initial idea was to have an explicit
> barrier/ordering command, but I didn't think that separating it from an
> actual command would be needed/useful.
> 
> > While you're here, do you want to add a way to FUA/cache flush?  
> > Basically the rest of what user land would need to make their own 
> > write-back-cache-safe implementation.
> 
> FUA would be a WRITEV/WRITE_FIXED flag, that should be trivially doable.

We already have plumbing to make pwritev2 and AIO issue FUA writes
via the RWF_DSYNC flag through the fs/iomap.c direct IO path. FUA is
only valid if the file does not have dirty metadata (e.g. because of
block allocation) and that requires the filesystem block mapping to
tell the IO path if FUA can be used. Otherwise a journal flush is
also required to make the data stable and there's no point in doing
a FUA write for the data in that case...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
