Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32980 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754546AbdEORfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2017 13:35:51 -0400
Received: by mail-pg0-f50.google.com with SMTP id u187so63346788pgb.0
        for <linux-block@vger.kernel.org>; Mon, 15 May 2017 10:35:51 -0700 (PDT)
Date: Mon, 15 May 2017 10:35:48 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Dmitry Monakhov <dmonlist@gmail.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: Announcing blktests
Message-ID: <20170515173548.GB18764@vader.DHCP.thefacebook.com>
References: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
 <87h90m71xb.fsf@dmlp.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h90m71xb.fsf@dmlp.sw.ru>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 15, 2017 at 03:13:52PM +0300, Dmitry Monakhov wrote:
> Omar Sandoval <osandov@osandov.com> writes:
> 
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
> Cool. Thank you.
> It would be nice to have hermetic kvm environment similar to
> xfstests-bld [1] . I'm a volunteer to do that.

Fine with me. Currently I think the only things we shell out to besides
basic coreutils and util-linux stuff are fio and parted.

> Also I'm interested in adding my t10-dif csum tests.
> Is this ok to add it to separate ./tests/t10-dif group ?

Yeah, I think that'd make sense as its own group.

> Side observations:
> Observation #1
> I've run this on fresh fedora kernel and it hit panic on the very first tests,
> which is very good sign for regression test framework.

Awesome! Any idea which test it was? There is a marker in dmesg before
each test is run.

Thanks!
