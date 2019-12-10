Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D7C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB5620663
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfLJGYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:24:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:33252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfLJGYc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 01:24:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5E6BAC82;
        Tue, 10 Dec 2019 06:24:29 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] xen/blkback: Squeeze page pools if a memory
 pressure is detected
To:     SeongJae Park <sjpark@amazon.com>
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, roger.pau@citrix.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, SeongJae Park <sjpark@amazon.de>
References: <20191209194305.20828-1-sjpark@amazon.com>
 <20191209194305.20828-3-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c5e4d67b-42b2-053f-6eb7-5a4bea75b9b5@suse.com>
Date:   Tue, 10 Dec 2019 07:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209194305.20828-3-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.12.19 20:43, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Each `blkif` has a free pages pool for the grant mapping.  The size of
> the pool starts from zero and be increased on demand while processing
> the I/O requests.  If current I/O requests handling is finished or 100
> milliseconds has passed since last I/O requests handling, it checks and
> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> 
> Therefore, `blkfront` running guests can cause a memory pressure in the
> `blkback` running guest by attaching a large number of block devices and
> inducing I/O.  System administrators can avoid such problematic
> situations by limiting the maximum number of devices each guest can
> attach.  However, finding the optimal limit is not so easy.  Improper
> set of the limit can results in the memory pressure or a resource
> underutilization.  This commit avoids such problematic situations by
> squeezing the pools (returns every free page in the pool to the system)
> for a while (users can set this duration via a module parameter) if a
> memory pressure is detected.
> 
> Discussions
> ===========
> 
> The `blkback`'s original shrinking mechanism returns only pages in the
> pool, which are not currently be used by `blkback`, to the system.  In
> other words, the pages are not mapped with foreign pages.  Because this
> commit is changing only the shrink limit but uses the mechanism as is,
> this commit does not introduce improper mappings related security
> issues.
> 
> Once a memory pressure is detected, this commit keeps the squeezing
> limit for a user-specified time duration.  The duration should be
> neither too long nor too short.  If it is too long, the squeezing
> incurring overhead can reduce the I/O performance.  If it is too short,
> `blkback` will not free enough pages to reduce the memory pressure.
> This commit sets the value as `10 milliseconds` by default because it is
> a short time in terms of I/O while it is a long time in terms of memory
> operations.  Also, as the original shrinking mechanism works for at
> least every 100 milliseconds, this could be a somewhat reasonable
> choice.  I also tested other durations (refer to the below section for
> more details) and confirmed that 10 milliseconds is the one that works
> best with the test.  That said, the proper duration depends on actual
> configurations and workloads.  That's why this commit is allowing users
> to set it as their optimal value via the module parameter.
> 
> Memory Pressure Test
> ====================
> 
> To show how this commit fixes the memory pressure situation well, I
> configured a test environment on a xen-running virtualization system.
> On the `blkfront` running guest instances, I attach a large number of
> network-backed volume devices and induce I/O to those.  Meanwhile, I
> measure the number of pages that swapped in and out on the `blkback`
> running guest.  The test ran twice, once for the `blkback` before this
> commit and once for that after this commit.  As shown below, this commit
> has dramatically reduced the memory pressure:
> 
>                  pswpin  pswpout
>      before      76,672  185,799
>      after          212    3,325
> 
> Optimal Aggressive Shrinking Duration
> -------------------------------------
> 
> To find a best squeezing duration, I repeated the test with three
> different durations (1ms, 10ms, and 100ms).  The results are as below:
> 
>      duration    pswpin  pswpout
>      1           852     6,424
>      10          212     3,325
>      100         203     3,340
> 
> As expected, the memory pressure has decreased as the duration is
> increased, but the reduction stopped from the `10ms`.  Based on this
> results, I chose the default duration as 10ms.
> 
> Performance Overhead Test
> =========================
> 
> This commit could incur I/O performance degradation under severe memory
> pressure because the squeezing will require more page allocations per
> I/O.  To show the overhead, I artificially made a worst-case squeezing
> situation and measured the I/O performance of a `blkfront` running
> guest.
> 
> For the artificial squeezing, I set the `blkback.max_buffer_pages` using
> the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
> the value to `1024` and `0`.  The `1024` is the default value.  Setting
> the value as `0` is same to a situation doing the squeezing always
> (worst-case).
> 
> For the I/O performance measurement, I use a simple `dd` command.
> 
> Default Performance
> -------------------
> 
>      [dom0]# echo 1024 > /sys/module/xen_blkback/parameters/max_buffer_pages
>      [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.8827 s, 38.7 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.8781 s, 38.7 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.8737 s, 38.7 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.8702 s, 38.7 MB/s
> 
> Worst-case Performance
> ----------------------
> 
>      [dom0]# echo 0 > /sys/module/xen_blkback/parameters/max_buffer_pages
>      [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.878 s, 38.7 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.8746 s, 38.7 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.8786 s, 38.7 MB/s
>      131072+0 records in
>      131072+0 records out
>      536870912 bytes (537 MB) copied, 13.8749 s, 38.7 MB/s
> 
> In short, even worst case squeezing makes no visible performance
> degradation.  I think this is due to the slow speed of the I/O.  In
> other words, the additional page allocation overhead is hidden under the
> much slower I/O latency.
> 
> Nevertheless, pleaset note that this is just a very simple and minimal
> test.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Juergen Gross <jgross@suse.com>

When dropping the domid parameter you can keep the Reviewed-by, of
course.


Juergen
