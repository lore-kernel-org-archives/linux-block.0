Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37591C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 13:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A2922527
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 13:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnyQZB7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfLLNj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:39:26 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34246 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfLLNj0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 08:39:26 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so1064536pjs.1;
        Thu, 12 Dec 2019 05:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=QNw0wSWDYS412iIOnCOz7lWytbJcyDm/vPYrMQVOY+A=;
        b=FnyQZB7UWH46xGYqGMV5DUcLuL6Ol1mWnsGPDy25hN5Mri4MN/ra4/9CWOVb8JXBpI
         etGFS/zfKLK68ZdLPGm/tvIjF3d8jwcd37wvdFxvp/lQ26RmjhDPgVEcCa1Wflel9t8l
         5Opyw3U0AwWA+n1+wmYfwei13rzoPugI+Qvuj3ocQC/NIfC3B815a2F56diUdOVfSVfM
         NzP54NetrBeBLCtq9PpJhYfZhKsWuxrrsxvoLfSUe94Y2T19JofEuq3ICq+9eXzUDgt3
         i1SJ6s06COLOR1uZCjq949tGhC2LMq2blK9OpJt5SCux0YvGDc+0KOGSqeg7DNZFmIZw
         7wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=QNw0wSWDYS412iIOnCOz7lWytbJcyDm/vPYrMQVOY+A=;
        b=t24aQm4zrCet8f9CoY4xX1L3p4PNYJ9mJxerCNq8S+UnEvy4twOzLwditcAImn4fdG
         FofEtU6SvKDUp7XU3VhDB8ZRIKzBf4l88o88ucJBtylNUtE3VLJtXRiwuYouD45nHNGa
         N5TyRJrEkW+rbnZmPdySJMrpMTqUEjvFpn6Iif8YBPqi/0/ZOhBwrf2dqw2aCfvMXAQS
         WnPlzbritDsNA/OnPY9CEeNL6Cc39ypBBoGiYRf5QkKKgPa+Q+PTax8vrihQIDHXX4GW
         FN3QJFmNDMknuyA3plxgTxA8LEWsJxfLCnkJQKgcSR14WtU6oXaIa+F41OF0qVx0wB1o
         Q9/g==
X-Gm-Message-State: APjAAAXyvDkbicYRkf6zek5Q2YfYb11peYHPuq8/gstS1zb4Z1heyNHF
        PpLhnZQRrHd18cZkINtnZuE=
X-Google-Smtp-Source: APXvYqy82OmHGVipwaG188UZTJQex0ku+UVSDGWNX0YY52TMxE6wMI4E5e0QBWEx9qFc9D4D4yU8fg==
X-Received: by 2002:a17:90a:808c:: with SMTP id c12mr9689023pjn.105.1576157964900;
        Thu, 12 Dec 2019 05:39:24 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id m3sm6883598pgp.32.2019.12.12.05.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 05:39:24 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     jgross@suse.com, axboe@kernel.dk, sjpark@amazon.com,
        konrad.wilk@oracle.com, pdurrant@amazon.com,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Thu, 12 Dec 2019 14:39:05 +0100
Message-Id: <20191212133905.462-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <20191212114247.GB11756@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 12 Dec 2019 12:42:47 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> 
> Please make sure you Cc me in blkback related patches.

Sorry for forgotting you!  I will never forget again.

> 
> On Wed, Dec 11, 2019 at 06:10:15PM +0000, SeongJae Park wrote:
> > Each `blkif` has a free pages pool for the grant mapping.  The size of
> > the pool starts from zero and be increased on demand while processing
>                                 ^ is
> > the I/O requests.  If current I/O requests handling is finished or 100
> > milliseconds has passed since last I/O requests handling, it checks and
> > shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> > 
> > Therefore, host administrators can cause memory pressure in blkback by
> > attaching a large number of block devices and inducing I/O.  Such
> > problematic situations can be avoided by limiting the maximum number of
> > devices that can be attached, but finding the optimal limit is not so
> > easy.  Improper set of the limit can results in the memory pressure or a
>                                                   ^ s/the//
> > resource underutilization.  This commit avoids such problematic
> > situations by squeezing the pools (returns every free page in the pool
> > to the system) for a while (users can set this duration via a module
> > parameter) if a memory pressure is detected.
>                 ^ s/a//
> > 
> > Discussions
> > ===========
> > 
> > The `blkback`'s original shrinking mechanism returns only pages in the
> > pool, which are not currently be used by `blkback`, to the system.  In
> 
> I think you can remove both comas in the above sentence.
> 
> > other words, the pages that are not mapped with granted pages.  Because
> > this commit is changing only the shrink limit but still uses the same
> > freeing mechanism it does not touch pages which are currently mapping
> > grants.
> > 
> > Once a memory pressure is detected, this commit keeps the squeezing
>        ^ s/a//

Thank you for corrections, will apply!

> > limit for a user-specified time duration.  The duration should be
> > neither too long nor too short.  If it is too long, the squeezing
> > incurring overhead can reduce the I/O performance.  If it is too short,
> > `blkback` will not free enough pages to reduce the memory pressure.
> > This commit sets the value as `10 milliseconds` by default because it is
> > a short time in terms of I/O while it is a long time in terms of memory
> > operations.  Also, as the original shrinking mechanism works for at
> > least every 100 milliseconds, this could be a somewhat reasonable
> > choice.  I also tested other durations (refer to the below section for
> > more details) and confirmed that 10 milliseconds is the one that works
> > best with the test.  That said, the proper duration depends on actual
> > configurations and workloads.  That's why this commit allows users to
> > set the duration as a module parameter.
> > 
> > Memory Pressure Test
> > ====================
> > 
> > To show how this commit fixes the memory pressure situation well, I
> > configured a test environment on a xen-running virtualization system.
> > On the `blkfront` running guest instances, I attach a large number of
> > network-backed volume devices and induce I/O to those.  Meanwhile, I
> > measure the number of pages that swapped in (pswpin) and out (pswpout)
> > on the `blkback` running guest.  The test ran twice, once for the
> > `blkback` before this commit and once for that after this commit.  As
> > shown below, this commit has dramatically reduced the memory pressure:
> > 
> >                 pswpin  pswpout
> >     before      76,672  185,799
> >     after          212    3,325
> > 
> > Optimal Aggressive Shrinking Duration
> > -------------------------------------
> > 
> > To find a best squeezing duration, I repeated the test with three
> > different durations (1ms, 10ms, and 100ms).  The results are as below:
> > 
> >     duration    pswpin  pswpout
> >     1           852     6,424
> >     10          212     3,325
> >     100         203     3,340
> > 
> > As expected, the memory pressure has decreased as the duration is
> > increased, but the reduction stopped from the `10ms`.  Based on this
> > results, I chose the default duration as 10ms.
> > 
> > Performance Overhead Test
> > =========================
> > 
> > This commit could incur I/O performance degradation under severe memory
> > pressure because the squeezing will require more page allocations per
> > I/O.  To show the overhead, I artificially made a worst-case squeezing
> > situation and measured the I/O performance of a `blkfront` running
> > guest.
> > 
> > For the artificial squeezing, I set the `blkback.max_buffer_pages` using
> > the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  In this
> > test, I set the value to `1024` and `0`.  The `1024` is the default
> > value.  Setting the value as `0` is same to a situation doing the
> > squeezing always (worst-case).
> > 
> > For the I/O performance measurement, I run a simple `dd` command 5 times
> > as below and collect the 'MB/s' results.
> > 
> >     $ for i in {1..5}; do dd if=/dev/zero of=file \
> >                              bs=4k count=$((256*512)); sync; done
> 
> I think it would be better if you could skip the filesystem overhead
> by writing directly to a block device, ie:
> 
> Attach a null_blk based block device to the guest (on dom0):
> # xl block-attach guest phy:/dev/null_blk0 xvdb w
> 
> Run a workload against the device (inside the guest):
> # fio --filename=/dev/xvdb --direct=1 --rw=randrw --bs=4k --ioengine=libaio \
>       --iodepth=64 --runtime=120 --numjobs=4 --time_based --group_reporting \
>       --name=throughput-test-job --eta-newline=1
> 
> You should run this on a multi-vcpu guest so that multiple queues are
> used, and adjust the numjobs to (at least) match the number of queues.

I forgot to update the `dd` command.  I used the command for the slow block
device test, but directly induced the I/O towards the block device for the fast
block device test as below:

    # xl block-attach guest phy:/dev/ram0 xvdb w
 
    $ for i in {1..5}; do dd if=/dev/zero of=file \
                             bs=4k count=$((256*512)); sync; done

Nevertheless, I agree that you suggested test will provide much more accurate.
As stated before, my test is only designed for a minimal proof-of-concept.

> 
> 
> > 
> > If the underlying block device is slow enough, the squeezing overhead
> > could be hidden.  For the reason, I do this test for both a slow block
> > device and a fast block device.  I use a popular cloud block storage
> > service, ebs[1] as a slow device and the ramdisk block device[2] for the
> > fast device.
> > 
> > The results are as below.  'max_pgs' represents the value of the
> > `blkback.max_buffer_pages` parameter.
> > 
> > On the slow block device
> > ------------------------
> > 
> >     max_pgs   Min       Max       Median     Avg    Stddev
> >     0         38.7      45.8      38.7       40.12  3.1752165
> >     1024      38.7      45.8      38.7       40.12  3.1752165
> >     No difference proven at 95.0% confidence
> > 
> > On the fast block device
> > ------------------------
> > 
> >     max_pgs   Min       Max       Median     Avg    Stddev
> >     0         417       423       420        419.4  2.5099801
> >     1024      414       425       416        417.8  4.4384682
> >     No difference proven at 95.0% confidence
> 
> This is intriguing, as it seems to prove that the usage of a cache of
> free pages is irrelevant performance wise.
> 
> The pool of free pages was introduced long ago, and it's possible that
> recent improvements to the balloon driver had made such pool useless,
> at which point it could be removed instead of worked around.

I guess the grant page allocation overhead in this test scenario is really
small.  In an absence of memory pressure, fragmentation, and NUMA imbalance,
the latency of the page allocation ('get_page()') is very short, as it will
success in the fast path.

Few years ago, I once measured the page allocation latency on my machine.
Roughly speaking, it was about 1us in best case, 100us in worst case, and 5us
in average.  Please keep in mind that the measurement was not designed and
performed in serious way.  Thus the results could have profile overhead in it,
though.  While keeping that in mind, let's simply believe the number and ignore
the latency of the block layer, blkback itself (including the grant
mapping), and anything else including context switch, cache miss, but the
allocation.  In other words, suppose that the grant page allocation is only one
source of the overhead.  It will be able to achieve 1 million IOPS (4KB *
1MIOPS = 4 GB/s) in the best case, 200 thousand IOPS (800 MB/s) in average, and
10 thousand IOPS (40 MB/s) in worst case.  Based on this coarse calculation, I
think the test results is reasonable.

This also means that the effect of the blkback's free pages pool might be
visible under page allocation fast path failure situation.  Nevertheless, it
would be also hard to measure that in micro level unless the measurement is
well designed and controlled.

> 
> Do you think you could perform some more tests (as pointed out above
> against the block device to skip the fs overhead) and report back the
> results?

To be honest, I'm not sure whether additional tests are really necessary,
because I think the `dd` test and the results explanation already makes some
sense and provide the minimal proof of the concept.  Also, this change is a
fallback for the memory pressure situation, which is an error path in some
point of view.  Such errorneous situation might not happen frequently and if
the situation is not solved in short time, something much worse (e.g., OOM kill
of the user space xen control processes) than temporal I/O performance
degradation could happen.  Thus, I'm not sure whether such detailed performance
measurement is necessary for this rare error handling change.  The comment of
'xen_blkbk_unmap()' also says, "This could accumulate ops up to the batch size
to reduce the number of hypercalls, but since this is only used in error paths
there's no real need.".

That said, if you still want me to do the test, I will gladly do it.  Note that
since I'm now traveling US without the power cable of my now discharged laptop
which is the only way to connect to my test environments in my office, I would
not be able to do the additional test quickly.  I assume I could do the test
and give you the result within a couple of week.  If you want me to post next
version with minor changes such as commit message update meanwhile, please just
let me know.  Again, if you want it, I will gladly do it :)

> 
> > 
> > In short, even worst case squeezing on ramdisk based fast block device
> > makes no visible performance degradation.  Please note that this is just
> > a very simple and minimal test.  On systems using super-fast block
> > devices and a special I/O workload, the results might be different.  If
> > you have any doubt, test on your machine for your workload to find the
> > optimal squeezing duration for you.
> > 
> > [1] https://aws.amazon.com/ebs/
> > [2] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html
> > 
> > Reviewed-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  drivers/block/xen-blkback/blkback.c | 22 ++++++++++++++++++++--
> >  drivers/block/xen-blkback/common.h  |  1 +
> >  drivers/block/xen-blkback/xenbus.c  |  3 ++-
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> > index fd1e19f1a49f..98823d150905 100644
> > --- a/drivers/block/xen-blkback/blkback.c
> > +++ b/drivers/block/xen-blkback/blkback.c
> > @@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
> >  		HZ * xen_blkif_pgrant_timeout);
> >  }
> >  
> > +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> > +static unsigned int buffer_squeeze_duration_ms = 10;
> > +module_param_named(buffer_squeeze_duration_ms,
> > +		buffer_squeeze_duration_ms, int, 0644);
> > +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> > +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> 
> You should add a description about this parameter to
> Documentation/ABI/testing/sysfs-driver-xen-blkback

Good point, I will.


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
