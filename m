Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AE5C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E3C21734
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 17:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hk+zrhQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWR2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:28:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727590AbgAWR2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 12:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579800508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOo86XYx2XlckK7VO6n+fr3sTCswBT7TBWfyx1cJOOc=;
        b=hk+zrhQ8r8Fy2HN1nhx6DnJ8o+yoXQRn1tAkzCUh/FGH+OIq4VZMfsB0WQVylSzgcfw2gY
        loS1PAT+UsXyDE04RYosBZ10kRAwQUrmD5lg2Qjn9Vh71lkre9hzXJ+p7ecEZTKT3XiyFA
        BtCvlZ6zYswFzYAJhTLk0tJdZ42ztbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-e2SK6Eb_PMGXILK14ERXWA-1; Thu, 23 Jan 2020 12:28:21 -0500
X-MC-Unique: e2SK6Eb_PMGXILK14ERXWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46061137858;
        Thu, 23 Jan 2020 17:28:19 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C8058CCEC;
        Thu, 23 Jan 2020 17:28:17 +0000 (UTC)
Date:   Thu, 23 Jan 2020 12:28:16 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Stefan Bader <stefan.bader@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Tyler Hicks <tyler.hicks@canonical.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
Message-ID: <20200123172816.GA31063@redhat.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
 <20200123103541.GA28102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123103541.GA28102@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 23 2020 at  5:35am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Jan 23 2020 at  4:17am -0500,
> Stefan Bader <stefan.bader@canonical.com> wrote:
> 
> > When device-mapper adapted for multi-queue functionality, they
> > also re-organized the way the make-request function was set.
> > Before, this happened when the device-mapper logical device was
> > created. Now it is done once the mapping table gets loaded the
> > first time (this also decides whether the block device is request
> > or bio based).
> > 
> > However in generic_make_request(), the request function gets used
> > without further checks and this happens if one tries to mount such
> > a partially set up device.
> > 
> > This can easily be reproduced with the following steps:
> >  - dmsetup create -n test
> >  - mount /dev/dm-<#> /mnt
> > 
> > This maybe is something which also should be fixed up in device-
> > mapper.
> 
> I'll look closer at other options.
> 
> > But given there is already a check for an unset queue
> > pointer and potentially there could be other drivers which do or
> > might do the same, it sounds like a good move to add another check
> > to generic_make_request_checks() and to bail out if the request
> > function has not been set, yet.
> > 
> > BugLink: https://bugs.launchpad.net/bugs/1860231
> 
> >From that bug;
> "The currently proposed fix introduces no chance of stability
> regressions. There is a chance of a very small performance regression
> since an additional pointer comparison is performed on each block layer
> request but this is unlikely to be noticeable."
> 
> This captures my immediate concern: slowing down everyone for this DM
> edge-case isn't desirable.

SO I had a look and there isn't anything easier than adding the proposed
NULL check in generic_make_request_checks().  Given the many
conditionals in that  function.. what's one more? ;)

I looked at marking the queue frozen to prevent IO via
blk_queue_enter()'s existing cheeck -- but that quickly felt like an
abuse, especially in that there isn't a queue unfreeze for bio-based.

Jens, I'll defer to you to judge this patch further.  If you're OK with
it: cool.  If not, I'm open to suggestions for how to proceed.  

