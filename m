Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34711 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdEORaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2017 13:30:39 -0400
Received: by mail-pf0-f169.google.com with SMTP id 9so26602916pfj.1
        for <linux-block@vger.kernel.org>; Mon, 15 May 2017 10:30:39 -0700 (PDT)
Date: Mon, 15 May 2017 10:30:36 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: Announcing blktests
Message-ID: <20170515173036.GA18764@vader.DHCP.thefacebook.com>
References: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
 <a321ac00-aa4d-a42d-28dd-ebf37a248a1a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a321ac00-aa4d-a42d-28dd-ebf37a248a1a@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 15, 2017 at 09:44:13AM +0200, Johannes Thumshirn wrote:
> On 05/12/2017 08:49 PM, Omar Sandoval wrote:
> > Hi, everyone,
> > 
> > At LSF/MM, we talked about the need for somewhere to dump tests for the
> > block layer/storage stack. I've put together a test suite inspired by
> > xfstests here: https://github.com/osandov/blktests.
> > 
> > I started out with the opinion that we should reuse xfstests for this,
> > but it became clear that the requirements for testing block devices are
> > slightly different, and it diverged significantly from there. In
> > particular, blktests supports:
> > 
> > - Per-device tests. You can configure a list of test devices and the
> >   per-device tests will run on each one (currently in serial, we can
> >   support parallel runs in the future if needed).
> > - No-device tests. Some tests don't need to run on real hardware, and we
> >   can just set up a null-blk or scsi-debug device.
> > - Performance numbers. In addition to the output comparison pass/fail
> >   that xfstests supports, blktests can also report arbitrary test
> >   metrics which don't affect whether the test passes but can be useful
> >   for spotting regressions.
> > 
> > Jens and I wrote up an initial set of tests, but there are a lot more we
> > can still write. I'm also happy to take feature requests, just email me
> > or open an issue on the GitHub repo.
> 
> \o/
> 
> You're my hero :-).
> 
> Do you only accept github pull requests or do you accept patches via
> linux-block as well?

Patches are fine, just format them with `git format-patch
--subject-prefix="PATCH blktests"` so I don't lose them.

> As a side note, I'm currently working on a partition table fuzzer to
> stress block/partitions/*.c a bit. I think this could be included into
> your framework as well (it's only one .c file currently with no external
> dependencies).

Yup, that sounds like a good fit. Currently we don't have any programs
to build, but it'd be easy to add a src/ directory and do what xfstests
does.

Thanks!
