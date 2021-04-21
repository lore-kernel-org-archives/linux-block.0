Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1299CC433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5254613F5
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 11:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhDULvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbhDULvE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 07:51:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD0C06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 04:50:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w23so47277970ejb.9
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cy1PIXS3bYPCxk8Vi6D4m4cgYcws19GuLUD9W0LG2AY=;
        b=OkIq0LRKEPD1cbWe2XzpAHtqYjXppRpuGopg/TPeCrMBvH57OVQ5V7nq/N3WijxlHa
         gcM5UAy9BTKFFY4ysAcDUNsMo0oJy6vNCUtThvS4k2cNUHIsqWwQCJv9762mifIBnOGD
         qkaDzYpQy12lmbYlmEKKhSP65VK0vmopppZw0a0mSToEkayhJm6CZKC2QZgv8FDq2btL
         5RWyFBN83m4BHqW/Xb6VAp7oIhI5wdAHmrpnI2HCySJFSbXcpSv1ahU8Om8iGVRzLJH6
         +3IMLOJ3/uFyAjMNPgiu7xwn04XayOqmvNYvNXbTfA+2/y4a9kBY3UCYiAw8xWiBnYhq
         ehJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cy1PIXS3bYPCxk8Vi6D4m4cgYcws19GuLUD9W0LG2AY=;
        b=sPwBUolyn9zi4UlWR626YFaWBw2p7snBu15FhGBslcA3YcmmIPUjZd/9tVTxwezpmm
         UUU0NnoS1NE/W+HZ7FjpldHPd7BCOQ82SCVtdqaWQ8mZO5lorsZbqEOTCl39JkR/lXO4
         1bi7Ox/+AB68vSrb9iMPIzaI+EFJ0qGN+Pt1GAZKoiVJwFEgvxKXVD3nuuHNmZrX3GZ2
         XhrZN/WtDsCbAtfMpIEhPgR5IndfGDml1hdowy764CJlBA1SuSuFCVvuGnqG0oRCqKqe
         vjkYyICbWezyOstE2biGnyiF2363kVhFHe34DRIwldkffSygs1PlTzqLM48R9EPqto8O
         Keag==
X-Gm-Message-State: AOAM533cvFHeqemp8WZtUDP/mNAVPCOYeKmuFA510DcmvawoJB+tHOW/
        Uv7+efQwIeg10AoT8FCZqoIgHwTmZ4y5MCSfMFgJ8kkVD1cT7w==
X-Google-Smtp-Source: ABdhPJw0dNB9xshopPT9epWBNZnsjYPeYGA8MXTIMi/i7F0/SJcE6MPRJvUF9/Z6uKRGrW5v3RsZimDqWTn2IwPi1MQ=
X-Received: by 2002:a17:906:fb81:: with SMTP id lr1mr30843285ejb.62.1619005830191;
 Wed, 21 Apr 2021 04:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
 <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk> <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
 <16182211-0e85-540d-1061-6411ec3351a5@kernel.dk> <CAMGffE=t85WAgpzHu5zaM+NAa4hrBYcUEOo=z2jNkkr9ZSc0bg@mail.gmail.com>
 <967e1953-6eb7-4a63-f5f4-91d99a6a7f5a@gmail.com>
In-Reply-To: <967e1953-6eb7-4a63-f5f4-91d99a6a7f5a@gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 21 Apr 2021 13:50:19 +0200
Message-ID: <CAMGffEnnhbPje7bB-W3jaMUF-JGBT0w0jCWeupsU8mwFFOHwSA@mail.gmail.com>
Subject: Re: [PATCH V6 0/3] block: add two statistic tables
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 21, 2021 at 12:20 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> On 4/21/21 8:49 AM, Jinpu Wang wrote:
> > On Mon, Apr 19, 2021 at 7:57 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 4/11/21 11:35 PM, Jinpu Wang wrote:
> >>> On Fri, Apr 9, 2021 at 11:03 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 4/9/21 10:03 AM, Md Haris Iqbal wrote:
> >>>>> Hi Jens,
> >>>>>
> >>>>> This version fixes the long lines in the code as per Christoph's comment.
> >>>>
> >>>> I'd really like to see some solid justification for the addition,
> >>>> though. I clicked the v1 link and it's got details on what you get out
> >>>> of it, but not really the 'why' of reasoning for the feature. I mean,
> >>>> you could feasibly have a blktrace based userspace solution. Just
> >>>> wondering if that has been tried, I know that's what we do at Facebook
> >>>> for example.
> >>>>
> >>> Hi Jens,
> >>>
> >>> Thanks for the reply.
> >>> For the use case of the additional stats, as a cloud provider, we
> >>> often need to handle report from the customers regarding
> >>> performance problem in a period of time in the past, so it's not
> >>> feasible for us to run blktrace, customer workload could change from
> >>> time to time, with the additional stats, we gather through all metrics
> >>> using Prometheus, we can navigate to the period of time interested,
> >>> to check if the performance matches the SLA, it also helps us to find
> >>> the user IO pattern,  we can more easily reproduce.
> >>
> >> My suggestion isn't to run just blktrace all the time, rather collect
> >> the tracing info from there and store them away. Then you can go back
> >> in time and see what is going on. Hence my questioning on adding this
> >> new stat tracking, when it's already readily available to be consumed
> >> by a small daemon that can continually track it in userspace.
> >>
> >> --
> >> Jens Axboe
> >>
> > Hi Jens,
> > The problem with using blktrace at production may cause a performance
> > drop ~30%. while with the block stats here, we only see ~3% when
> > enabled.
>
> It's probably was asked before, but let's refresh as the discussion
> erupted again.
>
> I get your problem with blktrace(8), IIRC it definitely can deteriorate
> performance if run constantly, but did you try to write a bpf program
> that does smarter accumulation in the kernel? Like making bpf to collect
> a latency table (right as in your patches do) and flushing it to the
> disk periodically?
Hi Pavel,

Thanks for the suggestion.

We did test with ebpf with kprobe in the past (~kernel 4.4/4.14), we
saw 10% performance drop, that's the reason we develop this
stats patches.

But I just did another test with bpftrace on k 5.10.30, I do not see
performance lost.
It must be ebpf is improving very much since then.

So to summarize, we can use bpftrace to do the drop in latest kernel,
there is no need to have it build into the kernel.

Thanks!

the bpftrace I used during testing:
root@x4-left:~# cat /usr/sbin/biolatency.bt
#!/usr/bin/env bpftrace
/*
 * biolatency.bt Block I/O latency as a histogram.
 * For Linux, uses bpftrace, eBPF.
 *
 * This is a bpftrace version of the bcc tool of the same name.
 *
 * Copyright 2018 Netflix, Inc.
 * Licensed under the Apache License, Version 2.0 (the "License")
 *
 * 13-Sep-2018 Brendan Gregg Created this.
 */

BEGIN
{
printf("Tracing block device I/O... Hit Ctrl-C to end.\n");
}

kprobe:blk_account_io_start
{
@start[arg0] = nsecs;
}

kprobe:blk_account_io_done
/@start[arg0]/

{
@usecs = hist((nsecs - @start[arg0]) / 1000);
delete(@start[arg0]);
}



>
>
> > We did a benchmark with rnbd.
> >
> > Fio config:
> > [global]
> > description=Emulation of Storage Server Access Pattern
> > bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
> > fadvise_hint=0
> > rw=randrw:2
> > direct=1
> > random_distribution=zipf:1.2
> > #size=1G
> > time_based=1
> > runtime=10
> > ramp_time=1
> > ioengine=libaio
> > iodepth=128
> > iodepth_batch_submit=128
> > iodepth_batch_complete=128
> > numjobs=1
> > #gtod_reduce=1
> > group_reporting
> >
> > [job1]
> > filename=/dev/rnbd0
> >
> > blktrace command:
> > # blktrace -a read -a write -d /dev/rnbd0
> >
> > read IOPS drops 35%, similar for write IOPS.
> >
> > RNBD-No-blktrace  RNBD-With-blktrace
> >
> >  102056.894311               -35.5%
> >
> > The tests are done with v5.4.30.
> > Test hardware is
> > root@x4-left:~/haris/sds-perf# uname -a
> > Linux x4-left 5.10.30-pserver
> > #5.10.30-1+feature+linux+5.10.y+20210414.1233+e3dd267~deb10 SMP
> > x86_64 GNU/Linux
> > root@x4-left:~/haris/sds-perf# lscpu
> > Architecture:        x86_64
> > CPU op-mode(s):      32-bit, 64-bit
> > Byte Order:          Little Endian
> > Address sizes:       46 bits physical, 48 bits virtual
> > CPU(s):              40
> > On-line CPU(s) list: 0-39
> > Thread(s) per core:  2
> > Core(s) per socket:  10
> > Socket(s):           2
> > NUMA node(s):        2
> > Vendor ID:           GenuineIntel
> > CPU family:          6
> > Model:               85
> > Model name:          Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz
> > Stepping:            4
> > CPU MHz:             800.571
> > CPU max MHz:         3000.0000
> > CPU min MHz:         800.0000
> > BogoMIPS:            4400.00
> > Virtualization:      VT-x
> > L1d cache:           32K
> > L1i cache:           32K
> > L2 cache:            1024K
> > L3 cache:            14080K
> > NUMA node0 CPU(s):   0-9,20-29
> > NUMA node1 CPU(s):   10-19,30-39
> > Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> > pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> > syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
> > rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> > dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
> > pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
> > xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
> > cdp_l3 invpcid_single intel_ppin mba ibrs ibpb stibp tpr_shadow vnmi
> > flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep
> > bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap
> > clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec
> > xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
> > dtherm ida arat pln pts pku ospke
> > root@x4-left:~/haris/sds-perf# ibstat
> > CA 'mlx5_0'
> > CA type: MT4115
> > Number of ports: 1
> > Firmware version: 12.26.4012
> > Hardware version: 0
> > Node GUID: 0xec0d9a0300c5fffc
> > System image GUID: 0xec0d9a0300c5fffc
> > Port 1:
> > State: Active
> > Physical state: LinkUp
> > Rate: 100
> > Base lid: 3
> > LMC: 0
> > SM lid: 3
> > Capability mask: 0x2651e84a
> > Port GUID: 0xec0d9a0300c5fffc
> > Link layer: InfiniBand
> > CA 'mlx5_1'
> > CA type: MT4115
> > Number of ports: 1
> > Firmware version: 12.26.4012
> > Hardware version: 0
> > Node GUID: 0xec0d9a0300c5fffd
> > System image GUID: 0xec0d9a0300c5fffc
> > Port 1:
> > State: Active
> > Physical state: LinkUp
> > Rate: 100
> > Base lid: 1
> > LMC: 0
> > SM lid: 1
> > Capability mask: 0x2651e84a
> > Port GUID: 0xec0d9a0300c5fffd
> > Link layer: InfiniBand
> >
> > Thanks!
> >
>
> --
> Pavel Begunkov
