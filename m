Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56BC63777
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1F420857
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IY3x6KBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgLACNp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgLACNo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 21:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606788737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EvGaQfsSiCtvkzbwe6zDba0A7IFauTMiCw45bNp+3Zs=;
        b=IY3x6KBFSbe76nGD7ePx62CvnZwxquCDnS+hoW5JV5cUWJCST01amf91x1PQ3a71sXdOU0
        VqkXVJm58UzgVkYZmxNWxtzcA+BWLxwBK5uoSN9I0OyfhF7WWFtGbYQb+gQSEGMJs225Q+
        VFfVMRKRgONuGlt46RI1m6ENKVsMr/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-xdbNNJ7POXqH2Bx03mwcDw-1; Mon, 30 Nov 2020 21:12:15 -0500
X-MC-Unique: xdbNNJ7POXqH2Bx03mwcDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CD071005D52;
        Tue,  1 Dec 2020 02:12:14 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1F0919C48;
        Tue,  1 Dec 2020 02:12:07 +0000 (UTC)
Date:   Mon, 30 Nov 2020 21:12:06 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     John Dorminy <jdorminy@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Bruce Johnston <bjohnsto@redhat.com>
Subject: Re: block: revert to using min_not_zero() when stacking chunk_sectors
Message-ID: <20201201021206.GB13735@redhat.com>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <CAMeeMh8fb2JEBmuSuTP8ys6Xr+GpFqcUr5Py73W4wCQb1MCuAw@mail.gmail.com>
 <20201130232417.GA12865@redhat.com>
 <CAMeeMh9Ykqhc75VCSgLoj+hMpqBaV2uY7XvXUP1-FQdQLF49Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh9Ykqhc75VCSgLoj+hMpqBaV2uY7XvXUP1-FQdQLF49Ew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 30 2020 at  7:21pm -0500,
John Dorminy <jdorminy@redhat.com> wrote:

> > If you're going to cherry pick a portion of a commit header please
> > reference the commit id and use quotes or indentation to make it clear
> > what is being referenced, etc.
> Apologies.
> 
> > Quite the tangent just to setup an a toy example of say: thinp with 256K
> > blocksize/chunk_sectors ontop of a RAID6 with a chunk_sectors of 128K
> > and stripesize of 1280K.
> 
> I screwed up my math ... many apologies :/
> 
> Consider a thinp of chunk_sectors 512K atop a RAID6 with chunk_sectors 1280K.
> (Previously, this RAID6 would be disallowed because chunk_sectors
> could only be a power of 2, but 07d098e6bba removed this constraint.)

Think you have your example messed up still.  RAID 10+2 with 128K
chunk_sectors, 1280K full stripe (io_opt). Then thinp stacked ontop of
it with chunk_sectors of 1280K was usecase that wasn't supported before.

So stacked chunk_sectors = min_not_zero(128K, 1280K) = 128K

> -With lcm_not_zero(), a full-device IO would be split into 2560K IOs,
> which obviously spans both 512K and 1280K chunk boundaries.

Sure, think we both agree lcm_not_zero() shouldn't be used.

> -With min_not_zero(), a full-device IO would be split into 512K IOs,
> some of which would span 1280k chunk boundaries. For instance, one IO
> would span from offset 1024K to 1536K.

RAID6 with chunk_sectors of 1280K is pretty insane...
And yet you're saying full device IO is 1280K...
So something still isn't adding up.

Anyway, if we run with your example of chunk_sectors (512K, 1280K), yes
there is serious potential for IO to span the RAID6 layer's chunk_sector
boundary.

> -With the hypothetical gcd_not_zero(), a full-device IO would be split
> into 256K IOs, which span neither 512K nor 1280K chunk boundaries.

Yeap, I see.

> > To be clear, you are _not_ saying using lcm_not_zero() is correct.
> > You're saying that simply reverting block core back to using
> > min_not_zero() may not be as good as using gcd().
> 
> Assuming my understanding of chunk_sectors is correct -- which as per
> blk-settings.c seems to be "a driver will not receive a bio that spans
> a chunk_sector boundary, except in single-page cases" -- I believe
> using lcm_not_zero() and min_not_zero() can both violate this
> requirement. The current lcm_not_zero() is not correct, but also
> reverting block core back to using min_not_zero() leaves edge cases as
> above.

But your chunk_sectors (512K, 1280K) example is a misconfigured IO
stack.  Really not sure it worth being concerned about it.

> I believe gcd provides the requirement, but min_not_zero() +
> disallowing non-power-of-2 chunk_sectors also provides the
> requirement.

Kind of on the fence on this... think I'd like to get Martin's take.

Using gcd() instead of min_not_zero() to stack chunk_sectors isn't a big
deal; given the nature of chunk_sectors coupled with it being able to be
a non-power-of-2 _does_ add a new wrinkle.

So you had a valid point all along, just that you made me work pretty
hard to understand you.

> > > But it's possible I'm misunderstanding the purpose of chunk_sectors,
> > > or there should be a check that the one of the two devices' chunk
> > > sizes divides the other.
> >
> > Seriously not amused by your response, I now have to do damage control
> > because you have a concern that you really weren't able to communicate
> > very effectively.
> 
> Apologies.

Eh, I need to build my pain threshold back up.. been away from it all
for more than a week.. ;)

Mike

