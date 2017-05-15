Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42005 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751370AbdEOHoP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2017 03:44:15 -0400
Subject: Re: Announcing blktests
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
References: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <a321ac00-aa4d-a42d-28dd-ebf37a248a1a@suse.de>
Date: Mon, 15 May 2017 09:44:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/12/2017 08:49 PM, Omar Sandoval wrote:
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
> 
> Jens and I wrote up an initial set of tests, but there are a lot more we
> can still write. I'm also happy to take feature requests, just email me
> or open an issue on the GitHub repo.

\o/

You're my hero :-).

Do you only accept github pull requests or do you accept patches via
linux-block as well?

As a side note, I'm currently working on a partition table fuzzer to
stress block/partitions/*.c a bit. I think this could be included into
your framework as well (it's only one .c file currently with no external
dependencies).

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
