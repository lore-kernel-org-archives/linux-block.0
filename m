Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC524C33CB6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 11:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB772082F
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 11:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R0A/1i+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAQLTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:19:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46043 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgAQLTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 06:19:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so22211667otp.12
        for <linux-block@vger.kernel.org>; Fri, 17 Jan 2020 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQxxyGSFSmQnS/mGTdsqcD/Us0GzWzhyy1cu7KTtsYA=;
        b=R0A/1i+D28EejA5QRl8m5OtT27aeCGfZx7L1T2bXFChd37ZkZTQgOl4LFjJPeAq/r7
         qjRaVSr7DQAdUNFnFFVqGqWtCQ0bIHg3fv5vGhJi5M6RLgo/JmcwZnNbWZVxHuk+0kXb
         tpHczsbQOU+poGMvbY7QRYpelQ8MttGExHoEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQxxyGSFSmQnS/mGTdsqcD/Us0GzWzhyy1cu7KTtsYA=;
        b=lT1sW9S0wxbzFxDc/iIPbWR4oHpvrBLRBKYtl5vl5L25L3A7ykOjcIHoevCuLq3wkU
         PQI2jCLbVqPS2hjhelcUYd1qwoA49RQ3NZBIh6iPhD63jKuRqWhVeQ3O9kLBcsS2LUv3
         Agnw3ofQ9WCrDlzQtUNdM68bUsxTm3Y9iEYshytkDB1y4xM3plRTOexNHYcuI49JdL/k
         uyssTXar7ccpchiJPkA0WUpk9eDON1xrqPOd/eBPIinpfTSEDyKy2x59G9h6HsqBxCdm
         VEnK6chf5QQUzl30ukJ84GSSTxcxkNZ5K4Ni7Wzz1KW7pV2uefo1Z21bSvH1jlk0MIWI
         zeuQ==
X-Gm-Message-State: APjAAAVcUu11O4hGNfOhS6nW0Ixf7JlT067fymZ7ENDBn/ZrpMhlca8w
        N+gy1ChXEZxAL2KIlq4zxo1fh5zPxag0ie4OgVl/hg==
X-Google-Smtp-Source: APXvYqxM+KCkAnH27cztpzIzqLN3BIBi0tEZvtJpPj4N9K+GEb5i8IxCmVpZI6hjl5mbXLx8xixzMoq0wi1AXxGXSLQ=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr5826050otk.23.1579259941034;
 Fri, 17 Jan 2020 03:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20191202153914.84722-1-hare@suse.de> <20191202153914.84722-10-hare@suse.de>
 <CAL2rwxqjiRTuZ0ntfaHHzG7z-VmxRQCXYyxZeX9eDMrmX+dbGg@mail.gmail.com>
 <efe9c1e7-fa10-3bae-eacd-58d43295d6da@suse.de> <CAL2rwxotoWakFS4DPe85hZ4VAgd_zw8pL+B5ckHR9NwEf+-L=g@mail.gmail.com>
 <11034edd-732a-3dd5-0bdc-891b9de05e56@huawei.com>
In-Reply-To: <11034edd-732a-3dd5-0bdc-891b9de05e56@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 17 Jan 2020 16:48:34 +0530
Message-ID: <CAL2rwxpLY1xfbiW4CZ6nWF7W8_zLWS+a+W6XC6emcVm96XetNw@mail.gmail.com>
Subject: Re: [PATCH 09/11] megaraid_sas: switch fusion adapters to MQ
To:     John Garry <john.garry@huawei.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 13, 2020 at 11:12 PM John Garry <john.garry@huawei.com> wrote:
>
> On 10/01/2020 04:00, Sumit Saxena wrote:
> > On Mon, Dec 9, 2019 at 4:32 PM Hannes Reinecke <hare@suse.de> wrote:
> >>
> >> On 12/9/19 11:10 AM, Sumit Saxena wrote:
> >>> On Mon, Dec 2, 2019 at 9:09 PM Hannes Reinecke <hare@suse.de> wrote:
> >>>>
> >>>> Fusion adapters can steer completions to individual queues, and
> >>>> we now have support for shared host-wide tags.
> >>>> So we can enable multiqueue support for fusion adapters and
> >>>> drop the hand-crafted interrupt affinity settings.
> >>>
> >>> Hi Hannes,
> >>>
> >>> Ming Lei also proposed similar changes in megaraid_sas driver some
> >>> time back and it had resulted in performance drop-
> >>> https://patchwork.kernel.org/patch/10969511/
> >>>
> >>> So, we will do some performance tests with this patch and update you.
> >>> Thank you.
> >>
> >> I'm aware of the results of Ming Leis work, but I do hope this patchset
> >> performs better.
> >>
> >> And when you do performance measurements, can you please run with both,
> >> 'none' I/O scheduler and 'mq-deadline' I/O scheduler?
> >> I've measured quite a performance improvements when using mq-deadline,
> >> up to the point where I've gotten on-par performance with the original,
> >> non-mq, implementation.
> >> (As a data point, on my setup I've measured about 270k IOPS and 1092
> >> MB/s througput, running on just 2 SSDs).
> >>asas_build_ldio_fusion
> >> But thanks for doing a performance test here.
> >
> > Hi Hannes,
> >
> > Sorry for the delay in replying, I observed a few issues with this patchset:
> >
> > 1. "blk_mq_unique_tag_to_hwq(tag)" does not return MSI-x vector to
> > which IO submitter CPU is affined with. Due to this IO submission and
> > completion CPUs are different which causes performance drop for low
> > latency workloads.
>
> Hi Sumit,
>
> So the new code has:
>
> megasas_build_ldio_fusion()
> {
>
> cmd->request_desc->SCSIIO.MSIxIndex =
> blk_mq_unique_tag_to_hwq(tag);
>
> }
>
> So the value here is hw queue index from blk-mq point of view, and not
> megaraid_sas msix index, as you alluded to.
Yes John, value filled in "cmd->request_desc->SCSIIO.MSIxIndex" is HW
queue index.

>
> So we get 80 msix, 8 are reserved for low_latency_index_start (that's
> how it seems to me), and we report other 72 as #hw queues = 72 to SCSI
> midlayer.
>
> So I think that this should be:
>
> cmd->request_desc->SCSIIO.MSIxIndex =
> blk_mq_unique_tag_to_hwq(tag) + low_latency_index_start;
Agreed, this should return correct HW queue index.
>
>
> >
> > lspcu:
> >
> > # lscpu
> > Architecture:          x86_64
> > CPU op-mode(s):        32-bit, 64-bit
> > Byte Order:            Little Endian
> > CPU(s):                72
> > On-line CPU(s) list:   0-71
> > Thread(s) per core:    2
> > Core(s) per socket:    18
> > Socket(s):             2
> > NUMA node(s):          2
> > Vendor ID:             GenuineIntel
> > CPU family:            6
> > Model:                 85
> > Model name:            Intel(R) Xeon(R) Gold 6150 CPU @ 2.70GHz
> > Stepping:              4
> > CPU MHz:               3204.246
> > CPU max MHz:           3700.0000
> > CPU min MHz:           1200.0000
> > BogoMIPS:              5400.00
> > Virtualization:        VT-x
> > L1d cache:             32K
> > L1i cache:             32K
> > L2 cache:              1024K
> > L3 cache:              25344K
> > NUMA node0 CPU(s):     0-17,36-53
> > NUMA node1 CPU(s):     18-35,54-71
> > Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
> > mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
> > tm pbe s
> > yscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
> > rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> > dtes64 monitor
> > ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1
> > sse4_2 x2apic movbe popcnt tsc_deadline_timer xsave avx f16c rdrand
> > lahf_lm abm
> > 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 invpcid_single intel_ppin
> > mba tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust
> > bmi1 hle
> > avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed
> > adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt
> > xsavec
> > xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_lo
> >
> >
>
> [snip]
>
> > 4. This patch removes below code from driver so what this piece of
> > code does is broken-
> >
> >
> > -                               if (instance->adapter_type >= INVADER_SERIES &&
> > -                                   !instance->msix_combined) {
> > -                                       instance->msix_load_balance = true;
> > -                                       instance->smp_affinity_enable = false;
> > -                               }
>
> Does this code need to be re-added? Would this have affected your test?
This code did not affect my test but has to be re-added for affected hardware.
There are few megaraid_sas adapters for which "instance->msix_combined"
would be "0" and we need this code for those adapters.

Thanks,
Sumit
>
> Thanks,
> John
