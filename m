Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35578 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758811AbdEOMOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2017 08:14:09 -0400
Received: by mail-qt0-f182.google.com with SMTP id v27so71676965qtg.2
        for <linux-block@vger.kernel.org>; Mon, 15 May 2017 05:14:08 -0700 (PDT)
From: Dmitry Monakhov <dmonlist@gmail.com>
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Re: Announcing blktests
In-Reply-To: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
References: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
Date: Mon, 15 May 2017 15:13:52 +0300
Message-ID: <87h90m71xb.fsf@dmlp.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Omar Sandoval <osandov@osandov.com> writes:

> Hi, everyone,
>
> At LSF/MM, we talked about the need for somewhere to dump tests for the
> block layer/storage stack. I've put together a test suite inspired by
> xfstests here: https://github.com/osandov/blktests.
>
> I started out with the opinion that we should reuse xfstests for this,
> but it became clear that the requirements for testing block devices are
> slightly different, and it diverged significantly from there. In
> particular, blktests supports:
>
> - Per-device tests. You can configure a list of test devices and the
>   per-device tests will run on each one (currently in serial, we can
>   support parallel runs in the future if needed).
> - No-device tests. Some tests don't need to run on real hardware, and we
>   can just set up a null-blk or scsi-debug device.
> - Performance numbers. In addition to the output comparison pass/fail
>   that xfstests supports, blktests can also report arbitrary test
>   metrics which don't affect whether the test passes but can be useful
>   for spotting regressions.
Cool. Thank you.
It would be nice to have hermetic kvm environment similar to
xfstests-bld [1] . I'm a volunteer to do that.

Also I'm interested in adding my t10-dif csum tests.
Is this ok to add it to separate ./tests/t10-dif group ?

Side observations:
Observation #1
I've run this on fresh fedora kernel and it hit panic on the very first tests,
which is very good sign for regression test framework.
Observation #2
It is appeared that git tree was corrupted after crash  :) Defenitely fsync is missed
somewhere in git-core, I've straced it and found 'git clone' does only
two fsync for tmp-pack-xxx files. It seems git's crash consistency is horrably broken.
>
> Jens and I wrote up an initial set of tests, but there are a lot more we
> can still write. I'm also happy to take feature requests, just email me
> or open an issue on the GitHub repo.
>
> Thanks,
> Omar

Footnotes: 
[1]  https://github.com/tytso/xfstests-bld
