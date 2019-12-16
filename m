Return-Path: <SRS0=l7do=2G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A968C43603
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 10:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C4020725
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 10:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RxHjRGXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLPKBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:01:46 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:21745 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLPKBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Dec 2019 05:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576490505; x=1608026505;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=LtdCtzcshD6qXVmdgBHlLj8wpUXd5CRe7nngX+q2rNE=;
  b=RxHjRGXGcitU7zINvYSunUxuDMaDnNqXl2tAbj98wo9b/4uh+OEMvpqR
   NGML8rpEW84jk8G4EUfxBzdVYVdgnyeeg+i7vO7CXn9TdLCPZC11LOYyv
   CZUWOqCLHxO7Gcm19CsRCrE/9+KzqUMkdMDKXQWzhdZy30xFySaeVDpgt
   w=;
IronPort-SDR: +nhKU2Tl8MS+eqoV/mR0K7/tezXU9G9id8VSRKkd7HdhYB1SCvtQW6h/4TOmb27zuQKsgd/HFA
 GWz4PZC1oE7w==
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="7785002"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Dec 2019 10:01:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id EE82FA1DDE;
        Mon, 16 Dec 2019 10:01:41 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 10:01:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 10:01:07 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <sjpark@amazon.com>,
        <konrad.wilk@oracle.com>, <pdurrant@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <sj38.park@gmail.com>
Subject: Re: Re: [Xen-devel] [PATCH v9 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Mon, 16 Dec 2019 11:00:52 +0100
Message-ID: <20191216100052.27361-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20191216093755.GJ11756@Air-de-Roger>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 16 Dec 2019 10:37:55 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> On Fri, Dec 13, 2019 at 03:35:44PM +0000, SeongJae Park wrote:
> > Each `blkif` has a free pages pool for the grant mapping.  The size of
> > the pool starts from zero and is increased on demand while processing
> > the I/O requests.  If current I/O requests handling is finished or 100
> > milliseconds has passed since last I/O requests handling, it checks and
> > shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> > 
> > Therefore, host administrators can cause memory pressure in blkback by
> > attaching a large number of block devices and inducing I/O.  Such
> > problematic situations can be avoided by limiting the maximum number of
> > devices that can be attached, but finding the optimal limit is not so
> > easy.  Improper set of the limit can results in memory pressure or a
> > resource underutilization.  This commit avoids such problematic
> > situations by squeezing the pools (returns every free page in the pool
> > to the system) for a while (users can set this duration via a module
> > parameter) if memory pressure is detected.
> > 
> > Discussions
> > ===========
> > 
> > The `blkback`'s original shrinking mechanism returns only pages in the
> > pool which are not currently be used by `blkback` to the system.  In
> > other words, the pages that are not mapped with granted pages.  Because
> > this commit is changing only the shrink limit but still uses the same
> > freeing mechanism it does not touch pages which are currently mapping
> > grants.
> > 
> > Once memory pressure is detected, this commit keeps the squeezing limit
> > for a user-specified time duration.  The duration should be neither too
> > long nor too short.  If it is too long, the squeezing incurring overhead
> > can reduce the I/O performance.  If it is too short, `blkback` will not
> > free enough pages to reduce the memory pressure.  This commit sets the
> > value as `10 milliseconds` by default because it is a short time in
> > terms of I/O while it is a long time in terms of memory operations.
> > Also, as the original shrinking mechanism works for at least every 100
> > milliseconds, this could be a somewhat reasonable choice.  I also tested
> > other durations (refer to the below section for more details) and
> > confirmed that 10 milliseconds is the one that works best with the test.
> > That said, the proper duration depends on actual configurations and
> > workloads.  That's why this commit allows users to set the duration as a
> > module parameter.
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
> > 
> > In short, even worst case squeezing on ramdisk based fast block device
> > makes no visible performance degradation.  Please note that this is just
> > a very simple and minimal test.  On systems using super-fast block
> > devices and a special I/O workload, the results might be different.  If
> > you have any doubt, test on your machine with your workload to find the
> > optimal squeezing duration for you.
> > 
> > [1] https://aws.amazon.com/ebs/
> > [2] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html

I forgot to update this section.  It contains two evaluation results which has
no big difference and also describes one test in wrong way (it induced direct
IO to the ramdisk).  For example, I would like to update this section as below:

    Performance Overhead Test
    =========================
    
    This commit could incur I/O performance degradation under severe memory
    pressure because the squeezing will require more page allocations per
    I/O.  To show the overhead, I artificially made a worst-case squeezing
    situation and measured the I/O performance of a `blkfront` running
    guest.
    
    For the artificial squeezing, I set the `blkback.max_buffer_pages` using
    the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  In this
    test, I set the value to `1024` and `0`.  The `1024` is the default
    value.  Setting the value as `0` is same to a situation doing the
    squeezing always (worst-case).
    
    If the underlying block device is slow enough, the squeezing overhead could
    be hidden.  For the reason, I use a fast block device, namely the rbd[1]:
    
        # xl block-attach guest phy:/dev/ram0 xvdb w
    
    For the I/O performance measurement, I run a simple `dd` command 5 times
    directly to the device as below and collect the 'MB/s' results.
    
        $ for i in {1..5}; do dd if=/dev/zero of=/dev/xvdb \
                                 bs=4k count=$((256*512)); sync; done
    
    The results are as below.  'max_pgs' represents the value of the
    `blkback.max_buffer_pages` parameter.
    
        max_pgs   Min       Max       Median     Avg    Stddev
        0         417       423       420        419.4  2.5099801
        1024      414       425       416        417.8  4.4384682
        No difference proven at 95.0% confidence
    
    In short, even worst case squeezing on ramdisk based fast block device
    makes no visible performance degradation.  Please note that this is just a
    very simple and minimal test.  On systems using super-fast block devices
    and a special I/O workload, the results might be different.  If you have
    any doubt, test on your machine with your workload to find the optimal
    squeezing duration for you.
    
    [1] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html

> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Appreciate for your reviews.  You made this patch much better!


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
