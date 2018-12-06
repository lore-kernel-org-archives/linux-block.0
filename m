Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CCC04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCBE21479
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 09:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="A87TJKc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCBE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeLFJEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:04:40 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34077 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFJEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 04:04:40 -0500
Received: by mail-pg1-f176.google.com with SMTP id 17so10370543pgg.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 01:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oXJkJdNxAo+zPPTm9819wlxAf70NcUz4vHcSM97XBRI=;
        b=A87TJKc/lhn61QkyxpX6Ejb82DdV7VVucFXrIfsqVifomhgas96RTmClw5l3oCtd6D
         d3EN75a+ZDCVWLPzZIuYfjk5dN2BqiRNviMc0QTe7/fe8alvWRz77y35lQfplXydzsSS
         bIX2x09Ify3JlSeLGDnNr5D6iDutqxFvboH711+cBBCL7aRXYklkmicVn2RugtaZlbcr
         UjchbxC9neihEPv/cViUyIX0iNkes0pW7thMbFe1uu94eM7LLS8scTOjEGKP4s0kUMI8
         f9hWhoWgHHhpJX/2J0aApiJv6qr0aDsJ/Z3JDKaeZSUE2mdH+v5HZ6qrZSUmQg6r78+P
         e20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oXJkJdNxAo+zPPTm9819wlxAf70NcUz4vHcSM97XBRI=;
        b=XD9U47nSvHt03HVEKE7OBbF5tX6K6kGH1SqGlLdfdUllKTXnb/6jOb8G+SHW4t7O05
         UAvSuGJroXPnd+rfgUetjFmbSm+eVhHzaFUUQEg/HOAqTSiwsRAvBgr25/u6+E9cifRE
         qAX1ryN/74vpUjLHP+Id0ypSW2D66z03hxKbwkWPUaHzVOXPT+5DpNOgvCOSP6PS+OJ0
         PD2joF4L/CVpTGPl5v3X2QnWaYfCZ820I0If4r7v3wluifYiYgGkxsX4bP9ntp0N8ztD
         SgxCvUYkXRjlF2bfLNiYl00R1LW2u1bUmAkelRW4iNrRZPfqlFUv46IPUKh9UwsaR1MY
         aL/Q==
X-Gm-Message-State: AA+aEWYABXKRoFm6Rr2CRRpIKYcbU+fGVN8uf2XEfUM5pJkgU+KHiYxw
        AgGMFpj4WrZwo+5vDYn93047cQ==
X-Google-Smtp-Source: AFSGD/Un89UnJT46s+McIlrucqLCP87t82n1jjtdMMeHK02MUv4a7VM+ixxHI+eYGfrCiSpRCcFsYQ==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr23601595pgk.190.1544087078972;
        Thu, 06 Dec 2018 01:04:38 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id h15sm29876907pgl.43.2018.12.06.01.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 01:04:38 -0800 (PST)
Date:   Thu, 6 Dec 2018 01:04:36 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: Re: [PATCH 0/2][V2] io.latency test for blktests
Message-ID: <20181206090436.GF11220@vader>
References: <20181205153404.26634-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205153404.26634-1-josef@toxicpanda.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05, 2018 at 10:34:02AM -0500, Josef Bacik wrote:
> v1->v2:
> - dropped my python library, TIL about jq.
> - fixed the spelling mistakes in the test.
> 
> -- Original message --
> 
> This patchset is to add a test to verify io.latency is working properly, and to
> add all the supporting code to run that test.
> 
> First is the cgroup2 infrastructure which is fairly straightforward.  Just
> verifies we have cgroup2, and gives us the helpers to check and make sure we
> have the right controllers in place for the test.
> 
> The second patch brings over some python scripts I put in xfstests for parsing
> the fio json output.  I looked at the existing fio performance stuff in
> blktests, but we only capture bw stuff, which is wonky with this particular test
> because once the fast group is finished the slow group is allowed to go as fast
> as it wants.  So I needed this to pull out actual jobtime spent.  This will give
> us flexibility to pull out other fio performance data in the future.
> 
> The final patch is the test itself.  It simply runs a job by itself to get a
> baseline view of the disk performance.  Then it creates 2 cgroups, one fast and
> one slow, and runs the same job simultaneously in both groups.  The result
> should be that the fast group takes just slightly longer time than the baseline
> (I use a 15% threshold to be safe), and that the slow one takes considerably
> longer.  Thanks,

I cleaned up a ton of shellcheck warnings (from `make check`) and pushed
to https://github.com/osandov/blktests/tree/josef. On I tested with QEMU
on Jens' for-next branch. With an emulated NVMe device, it failed with
"Too much of a performance drop for the protected workload". On
virtio-blk, I hit this:

[ 1843.056452] INFO: task fio:20750 blocked for more than 120 seconds.
[ 1843.057495]       Not tainted 4.20.0-rc5-00251-g90efb26fa9a4 #19
[ 1843.058487] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1843.059769] fio             D    0 20750  20747 0x00000080
[ 1843.060688] Call Trace:
[ 1843.061123]  ? __schedule+0x286/0x870
[ 1843.061735]  ? blkcg_iolatency_done_bio+0x680/0x680
[ 1843.062574]  ? blkcg_iolatency_cleanup+0x60/0x60
[ 1843.063347]  schedule+0x32/0x80
[ 1843.063874]  io_schedule+0x12/0x40
[ 1843.064449]  rq_qos_wait+0x9a/0x120
[ 1843.065007]  ? karma_partition+0x210/0x210
[ 1843.065661]  ? blkcg_iolatency_done_bio+0x680/0x680
[ 1843.066435]  blkcg_iolatency_throttle+0x185/0x360
[ 1843.067196]  __rq_qos_throttle+0x23/0x30
[ 1843.067958]  blk_mq_make_request+0x101/0x5c0
[ 1843.068637]  generic_make_request+0x1b3/0x3c0
[ 1843.069329]  submit_bio+0x45/0x140
[ 1843.069876]  blkdev_direct_IO+0x3db/0x440
[ 1843.070527]  ? aio_complete+0x2f0/0x2f0
[ 1843.071146]  generic_file_direct_write+0x96/0x160
[ 1843.071880]  __generic_file_write_iter+0xb3/0x1c0
[ 1843.072599]  ? blk_mq_dispatch_rq_list+0x3aa/0x550
[ 1843.073340]  blkdev_write_iter+0xa0/0x120
[ 1843.073960]  ? __fget+0x6e/0xa0
[ 1843.074452]  aio_write+0x11f/0x1d0
[ 1843.074979]  ? __blk_mq_run_hw_queue+0x6f/0xe0
[ 1843.075658]  ? __check_object_size+0xa0/0x189
[ 1843.076345]  ? preempt_count_add+0x5a/0xb0
[ 1843.077086]  ? aio_read_events+0x259/0x380
[ 1843.077819]  ? kmem_cache_alloc+0x16e/0x1c0
[ 1843.078427]  io_submit_one+0x4a8/0x790
[ 1843.078975]  ? read_events+0x76/0x150
[ 1843.079510]  __se_sys_io_submit+0x98/0x1a0
[ 1843.080116]  ? syscall_trace_enter+0x1d3/0x2d0
[ 1843.080785]  do_syscall_64+0x55/0x160
[ 1843.081404]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1843.082210] RIP: 0033:0x7f6e571fc4ed
[ 1843.082763] Code: Bad RIP value.
[ 1843.083268] RSP: 002b:00007ffc212b76f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
[ 1843.084445] RAX: ffffffffffffffda RBX: 00007f6e4c876870 RCX: 00007f6e571fc4ed
[ 1843.085545] RDX: 0000557c4bc11208 RSI: 0000000000000001 RDI: 00007f6e4c85e000
[ 1843.086251] RBP: 00007f6e4c85e000 R08: 0000557c4bc2b130 R09: 00000000000002f8
[ 1843.087308] R10: 0000557c4bbf4470 R11: 0000000000000246 R12: 0000000000000001
[ 1843.088310] R13: 0000000000000000 R14: 0000557c4bc11208 R15: 00007f6e2b17f070
