Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D1C433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 11:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED93D6144A
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 11:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhDULzx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 07:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhDULzx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 07:55:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0FAC06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 04:55:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1130037wmy.5
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuJmo3ogfk8Da5xpXp+I4sXWHDUApb7vIMQfsXCW/EY=;
        b=LV4SrwvIKk3EJFzdH15iyJlEeq7X+8coQ02J7utH7Zb4jLBv0R94v1Wbb858tHE6QL
         hnSwFAhs5YaM3S+tuq0LXlBayq6K5W4sBBK5tORK53XHwlEf9o6mvkSbk4CJI5rdyqv1
         xDV3xXFzYpPfq0lH8y447kP5NAiNHPWtL2QQz5kEp5+7E6GyjOA4P1dEpFOOOnntHx0K
         IUrRRV9HCQSbOEUXXPciLYn8wpDWZmnDK85bnLQMJ8uuQyHYM88OzeuIgpNN6Kzpf3n8
         sT7CkywFVv3vcpV/xrM1bnJjNfItjhu4vfoKAeR95UJpIMUZIS06DwYRa1OW6drHUf8d
         IPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuJmo3ogfk8Da5xpXp+I4sXWHDUApb7vIMQfsXCW/EY=;
        b=EWQPqUpDawkQhEKNDB1QTIc43fPKc2BSa/4nNkErhutF2+owiTKvy2ETJCS8bsZoPx
         2+oFPQt0vz81nR5givAAUwuGvnFDwiBRRPpCsivs7CAAkltMWNAeNNvdwxIqv1yCHmMO
         S8LGIUi3McHcuCCqPNpEtbIQxyvpZ5jAywMbO1ZCoobw0ADQUIqzN4S7R8tMa7u+w0RO
         e2duNLhIuOPGkJAzj+bRRCCs7v+CQ5/F88qPJdH4W713gqfU6OuemTdnpjLZAAu+64RR
         LhmddAZjOszVEFKCIQUUFaLQEoj4GMh/jmVFkanzbkfa4xqLJWbyegJWzXMYUO55WSW6
         8cAw==
X-Gm-Message-State: AOAM533i6EUPD/jaA19NcCHgwKWCp625ckzs0Tc/qGR4cLG3O90N93SZ
        Y8v4vBly+pFhi196POzAgkA=
X-Google-Smtp-Source: ABdhPJwm82/vW+8NfiXjeX9tWa8lSwMWXlVP5+iS+B+Ttm1MnTbJieH5Qz2woLC+U4nhZiGCy/H07g==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr9339956wmi.73.1619006119030;
        Wed, 21 Apr 2021 04:55:19 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.234.11])
        by smtp.gmail.com with ESMTPSA id j12sm2794179wro.29.2021.04.21.04.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 04:55:18 -0700 (PDT)
Subject: Re: [PATCH V6 0/3] block: add two statistic tables
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@ionos.com>
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
 <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk>
 <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
 <16182211-0e85-540d-1061-6411ec3351a5@kernel.dk>
 <CAMGffE=t85WAgpzHu5zaM+NAa4hrBYcUEOo=z2jNkkr9ZSc0bg@mail.gmail.com>
 <967e1953-6eb7-4a63-f5f4-91d99a6a7f5a@gmail.com>
 <CAMGffEnnhbPje7bB-W3jaMUF-JGBT0w0jCWeupsU8mwFFOHwSA@mail.gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <38b295a6-3260-a694-c8cf-1135c92b28d6@gmail.com>
Date:   Wed, 21 Apr 2021 12:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAMGffEnnhbPje7bB-W3jaMUF-JGBT0w0jCWeupsU8mwFFOHwSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/21 12:50 PM, Jinpu Wang wrote:
[snip]
>>> Hi Jens,
>>> The problem with using blktrace at production may cause a performance
>>> drop ~30%. while with the block stats here, we only see ~3% when
>>> enabled.
>>
>> It's probably was asked before, but let's refresh as the discussion
>> erupted again.
>>
>> I get your problem with blktrace(8), IIRC it definitely can deteriorate
>> performance if run constantly, but did you try to write a bpf program
>> that does smarter accumulation in the kernel? Like making bpf to collect
>> a latency table (right as in your patches do) and flushing it to the
>> disk periodically?
> Hi Pavel,
> 
> Thanks for the suggestion.
> 
> We did test with ebpf with kprobe in the past (~kernel 4.4/4.14), we
> saw 10% performance drop, that's the reason we develop this
> stats patches.
> 
> But I just did another test with bpftrace on k 5.10.30, I do not see
> performance lost.
> It must be ebpf is improving very much since then.
> 
> So to summarize, we can use bpftrace to do the drop in latest kernel,
> there is no need to have it build into the kernel.

Perfect, and I'm sure it will be even more convenient for you, for
instance to gather other stats or do it somehow differently

> Thanks!
> 
> the bpftrace I used during testing:
> root@x4-left:~# cat /usr/sbin/biolatency.bt
> #!/usr/bin/env bpftrace
> /*
>  * biolatency.bt Block I/O latency as a histogram.
>  * For Linux, uses bpftrace, eBPF.
>  *
>  * This is a bpftrace version of the bcc tool of the same name.
>  *
>  * Copyright 2018 Netflix, Inc.
>  * Licensed under the Apache License, Version 2.0 (the "License")
>  *
>  * 13-Sep-2018 Brendan Gregg Created this.
>  */
> 
> BEGIN
> {
> printf("Tracing block device I/O... Hit Ctrl-C to end.\n");
> }
> 
> kprobe:blk_account_io_start
> {
> @start[arg0] = nsecs;
> }
> 
> kprobe:blk_account_io_done
> /@start[arg0]/
> 
> {
> @usecs = hist((nsecs - @start[arg0]) / 1000);
> delete(@start[arg0]);
> }
> 
> 
> 
>>
>>
>>> We did a benchmark with rnbd.
>>>
>>> Fio config:
>>> [global]
>>> description=Emulation of Storage Server Access Pattern
>>> bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
>>> fadvise_hint=0
>>> rw=randrw:2
>>> direct=1
>>> random_distribution=zipf:1.2
>>> #size=1G
>>> time_based=1
>>> runtime=10
>>> ramp_time=1
>>> ioengine=libaio
>>> iodepth=128
>>> iodepth_batch_submit=128
>>> iodepth_batch_complete=128
>>> numjobs=1
>>> #gtod_reduce=1
>>> group_reporting
>>>
>>> [job1]
>>> filename=/dev/rnbd0
>>>
>>> blktrace command:
>>> # blktrace -a read -a write -d /dev/rnbd0
>>>
>>> read IOPS drops 35%, similar for write IOPS.
>>>
>>> RNBD-No-blktrace  RNBD-With-blktrace
>>>
>>>  102056.894311               -35.5%
>>>
>>> The tests are done with v5.4.30.
>>> Test hardware is
>>> root@x4-left:~/haris/sds-perf# uname -a
>>> Linux x4-left 5.10.30-pserver
>>> #5.10.30-1+feature+linux+5.10.y+20210414.1233+e3dd267~deb10 SMP
>>> x86_64 GNU/Linux
>>> root@x4-left:~/haris/sds-perf# lscpu
>>> Architecture:        x86_64
>>> CPU op-mode(s):      32-bit, 64-bit
>>> Byte Order:          Little Endian
>>> Address sizes:       46 bits physical, 48 bits virtual
>>> CPU(s):              40
>>> On-line CPU(s) list: 0-39
>>> Thread(s) per core:  2
>>> Core(s) per socket:  10
>>> Socket(s):           2
>>> NUMA node(s):        2
>>> Vendor ID:           GenuineIntel
>>> CPU family:          6
>>> Model:               85
>>> Model name:          Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz
>>> Stepping:            4
>>> CPU MHz:             800.571
>>> CPU max MHz:         3000.0000
>>> CPU min MHz:         800.0000
>>> BogoMIPS:            4400.00
>>> Virtualization:      VT-x
>>> L1d cache:           32K
>>> L1i cache:           32K
>>> L2 cache:            1024K
>>> L3 cache:            14080K
>>> NUMA node0 CPU(s):   0-9,20-29
>>> NUMA node1 CPU(s):   10-19,30-39
>>> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
>>> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
>>> syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
>>> rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
>>> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
>>> pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
>>> xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
>>> cdp_l3 invpcid_single intel_ppin mba ibrs ibpb stibp tpr_shadow vnmi
>>> flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep
>>> bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap
>>> clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec
>>> xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
>>> dtherm ida arat pln pts pku ospke
>>> root@x4-left:~/haris/sds-perf# ibstat
>>> CA 'mlx5_0'
>>> CA type: MT4115
>>> Number of ports: 1
>>> Firmware version: 12.26.4012
>>> Hardware version: 0
>>> Node GUID: 0xec0d9a0300c5fffc
>>> System image GUID: 0xec0d9a0300c5fffc
>>> Port 1:
>>> State: Active
>>> Physical state: LinkUp
>>> Rate: 100
>>> Base lid: 3
>>> LMC: 0
>>> SM lid: 3
>>> Capability mask: 0x2651e84a
>>> Port GUID: 0xec0d9a0300c5fffc
>>> Link layer: InfiniBand
>>> CA 'mlx5_1'
>>> CA type: MT4115
>>> Number of ports: 1
>>> Firmware version: 12.26.4012
>>> Hardware version: 0
>>> Node GUID: 0xec0d9a0300c5fffd
>>> System image GUID: 0xec0d9a0300c5fffc
>>> Port 1:
>>> State: Active
>>> Physical state: LinkUp
>>> Rate: 100
>>> Base lid: 1
>>> LMC: 0
>>> SM lid: 1
>>> Capability mask: 0x2651e84a
>>> Port GUID: 0xec0d9a0300c5fffd
>>> Link layer: InfiniBand
>>>
>>> Thanks!

-- 
Pavel Begunkov
