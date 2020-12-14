Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F2C4361B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 16:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E521534
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 16:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439874AbgLNQ21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:28:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439697AbgLNQ2W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 11:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607963214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bgu5oUmviCE7krtx2hLwhZvOZ7S3CVoweAA9rCSIXM=;
        b=PpAc71rOrc06uIOko2oxPAdkjD2Wohj00/2kn3D5e3aDfbiWFXnVyhAgeBTLZBvT8WZsFd
        aMrBC13LAYG9iQP0GYY7SAFgozoMiq2j/otAQolNyoycCfVJC77Hl1c81xYwarQrdLG4ld
        +cCEESu99JrbszH5ARqcW0VyYRMBxBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-AJFvYHPqMs65Yq98KNISGw-1; Mon, 14 Dec 2020 11:26:50 -0500
X-MC-Unique: AJFvYHPqMs65Yq98KNISGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60A261014E79;
        Mon, 14 Dec 2020 16:26:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECEA87DDF8;
        Mon, 14 Dec 2020 16:26:31 +0000 (UTC)
Date:   Mon, 14 Dec 2020 11:26:31 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: Linux 5.10
Message-ID: <20201214162631.GA2290@redhat.com>
References: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
 <20201214053147.GA24093@codemonkey.org.uk>
 <X9b9ujh5T6U5+aBY@kroah.com>
 <20201214160247.GA2090@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214160247.GA2090@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 14 2020 at 11:02am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, Dec 14 2020 at 12:52am -0500,
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Dec 14, 2020 at 12:31:47AM -0500, Dave Jones wrote:
> > > On Sun, Dec 13, 2020 at 03:03:29PM -0800, Linus Torvalds wrote:
> > >  > Ok, here it is - 5.10 is tagged and pushed out.
> > >  > 
> > >  > I pretty much always wish that the last week was even calmer than it
> > >  > was, and that's true here too. There's a fair amount of fixes in here,
> > >  > including a few last-minute reverts for things that didn't get fixed,
> > >  > but nothing makes me go "we need another week".
> > > 
> > > ...
> > > 
> > >  > Mike Snitzer (1):
> > >  >       md: change mddev 'chunk_sectors' from int to unsigned
> > > 
> > > Seems to be broken.  This breaks mounting my raid6 partition:
> > > 
> > > [   87.290698] attempt to access beyond end of device
> > >                md0: rw=4096, want=13996467328, limit=6261202944
> > > [   87.293371] attempt to access beyond end of device
> > >                md0: rw=4096, want=13998564480, limit=6261202944
> > > [   87.296045] BTRFS warning (device md0): couldn't read tree root
> > > [   87.300056] BTRFS error (device md0): open_ctree failed
> > > 
> > > Reverting it goes back to the -rc7 behaviour where it mounts fine.
> > 
> > If the developer/maintainer(s) agree, I can revert this and push out a
> > 5.10.1, just let me know.
> 
> Yes, these should be reverted from 5.10 via 5.10.1:
> 
> e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10
> f075cfb1dc59 md: change mddev 'chunk_sectors' from int to unsigned

Sorry, f075cfb1dc59 was my local commit id, the corresponding upstream
commit as staged by Jens is:

6ffeb1c3f82 md: change mddev 'chunk_sectors' from int to unsigned

So please revert:
6ffeb1c3f822 md: change mddev 'chunk_sectors' from int to unsigned
and then revert:
e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10

Thanks,
Mike

