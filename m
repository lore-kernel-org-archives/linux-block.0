Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D721FC433B4
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 13:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39556112F
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 13:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhEENOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhEENOB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 09:14:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD62C061574
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 06:13:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id zg3so2756183ejb.8
        for <linux-block@vger.kernel.org>; Wed, 05 May 2021 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+IkY03O1tCDBrnoceKYgTQstyftcSBuA9JqV8hHZDA=;
        b=hLzO/g53F7U6HizRhuT+cOaKCTx+onWhsMM2BaAl5HhgIRHtJjS9aWO+C/nr6ZUUze
         c1uZgJh7TnAYM6DcyB5Mtgaka5vsVFv40MjNd+5Nybdk9WuRy7yDrXnnYCsxqNaqQA7h
         V5fSEoIGLp5BFpUkMdSyj/USyc7Fq7/YU34TNa9o48hq0KZECQllsRQHvRQJbtJGoZ+i
         bpmytYvjwVlQp3fjGooyjEA6rYwy6Z0g5MxUwIvD2xyVuc+HHFFMpu78FIeJ2hG8y/QF
         gxh9nh99NgquOESYR5ImVdGvepCN+MEV8pBnAIPz+vNGvOE2T59EjMWjcOJH+KTgjx/j
         5OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+IkY03O1tCDBrnoceKYgTQstyftcSBuA9JqV8hHZDA=;
        b=A8ESs5Rx/YTHKF+sTxqs1JZkLJbYHoFYiktSInWLbe3WqY6U93ziKt4gIOCQDt5kN7
         PqweqfTrWksBlAoqZngXB6BJUf1l6nr7rXf9BgBWZo8cZSG0yQr+Cwfy9jBS8a/OLSJR
         6NIzy05VbzF3x/zt8OZIV5VNB3e7bx2qWQQ1i1wjQ2AhnUBXpl1cxjngYf/gSrd4UaTv
         qN0dv4jBcpSNxrYvhmF2x77E9tqGgusCD/sVWtq4QpEWtX9sWk5SfWRg5E/fEj1FypOQ
         wh3Dns0GAay3DjDUDdJxoezKiBr4ywopXQ+RqZv1wFI5G7fA/Phn6HGGvP5abqRkhw0m
         9Bfw==
X-Gm-Message-State: AOAM530OQDUdiAdNmtX/xwjPEOpFd/+ZlRDrQS3Wj7pmPz9EW3U876MM
        LnYzzHIaEv8A9MrzwfIKwGx2VGpK4LWeP9FAqX4hqw==
X-Google-Smtp-Source: ABdhPJwhYXnPDup0JFghcWOHtFGuOsakWz+G7y1yUhu3aHlaCvwRrfJ47WcmaOKn9OV7RG8DtE/9DBFSemJELR0MuHM=
X-Received: by 2002:a17:906:4001:: with SMTP id v1mr4493166ejj.5.1620220383391;
 Wed, 05 May 2021 06:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210428061359.206794-1-gi-oh.kim@ionos.com> <20210428061359.206794-5-gi-oh.kim@ionos.com>
 <BYAPR04MB496504E1348ABFEE30FFC0C186409@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CAJX1YtbJXWL7du8+6QzMisQhF72zRfMx92G2_LiLd3Nj6JSUYg@mail.gmail.com> <CAJX1YtZqe8h5vPbX0h-aVea7Oa08dmz9gMsasD-_JQ743phkag@mail.gmail.com>
In-Reply-To: <CAJX1YtZqe8h5vPbX0h-aVea7Oa08dmz9gMsasD-_JQ743phkag@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 5 May 2021 15:12:27 +0200
Message-ID: <CAJX1YtYLTm9cbNVUfnUTtRdUgmUmB1CPgUx0fg6BSKneLz4QyA@mail.gmail.com>
Subject: Re: [PATCH for-next 4/4] block/rnbd: Remove all likely and unlikely
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 4, 2021 at 3:04 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> On Thu, Apr 29, 2021 at 9:14 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > On Wed, Apr 28, 2021 at 8:33 PM Chaitanya Kulkarni
> > <Chaitanya.Kulkarni@wdc.com> wrote:
> > >
> > > On 4/27/21 23:14, Gioh Kim wrote:
> > > > The IO performance test with fio after removing the likely and
> > > > unlikely macros in all if-statement shows no performance drop.
> > > > They do not help for the performance of rnbd.
> > > >
> > > > The fio test did random read on 32 rnbd devices and 64 processes.
> > > > Test environment:
> > > > - AMD Opteron(tm) Processor 6386 SE
> > > > - 125G memory
> > > > - kernel version: 5.4.86
> > >
> > > why 5.4 and not linux-block/for-next ?
> >
> > We have done porting only 5.4 for the server machine yet.
> >
> > >
> > > > - gcc version: gcc (Debian 8.3.0-6) 8.3.0
> > > > - Infiniband controller: InfiniBand: Mellanox Technologies MT26428
> > > > [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> > > >
> > > > before
> > > > read: IOPS=549k, BW=2146MiB/s
> > > > read: IOPS=544k, BW=2125MiB/s
> > > > read: IOPS=553k, BW=2158MiB/s
> > > > read: IOPS=535k, BW=2089MiB/s
> > > > read: IOPS=543k, BW=2122MiB/s
> > > > read: IOPS=552k, BW=2154MiB/s
> > > > average: IOPS=546k, BW=2132MiB/s
> > > >
> > > > after
> > > > read: IOPS=556k, BW=2172MiB/s
> > > > read: IOPS=561k, BW=2191MiB/s
> > > > read: IOPS=552k, BW=2156MiB/s
> > > > read: IOPS=551k, BW=2154MiB/s
> > > > read: IOPS=562k, BW=2194MiB/s
> > > > -----------
> > > > average: IOPS=556k, BW=2173MiB/s
> > > >
> > > > The IOPS and bandwidth got better slightly after removing
> > > > likely/unlikely. (IOPS= +1.8% BW= +1.9%) But we cannot make sure
> > > > that removing the likely/unlikely help the performance because it
> > > > depends on various situations. We only make sure that removing the
> > > > likely/unlikely does not drop the performance.
> > >
> > > Did you get a chance to collect perf numbers to see which functions are
> > > getting faster ?
>
> Hi Chaitanya,
>
> I ran the perf tool to find out which functions are getting faster.
> But I was not able to find it.
> Could you please suggest a tool or anything to check it out?
>
> For your information, below is what I got with 'perf record fio
> <options:8-device, 64-job, 60-second>'
> The result before/after removing likely/unlikely looks the same.
>
>      4.15%  fio      [kernel.kallsyms]    [k] _raw_spin_lock_irqsave
>      3.19%  fio      [kernel.kallsyms]    [k] x86_pmu_disable_all
>      2.98%  fio      [rnbd_client]        [k] rnbd_put_permit
>      2.77%  fio      [kernel.kallsyms]    [k] find_first_zero_bit
>      2.49%  fio      [kernel.kallsyms]    [k] __x86_indirect_thunk_rax
>      2.21%  fio      [kernel.kallsyms]    [k] psi_task_change
>      2.00%  fio      [kernel.kallsyms]    [k] gup_pgd_range
>      1.83%  fio      fio                  [.] 0x0000000000029048
>      1.78%  fio      [rnbd_client]        [k] rnbd_get_permit
>      1.78%  fio      fio                  [.] axmap_isset
>      1.63%  fio      [kernel.kallsyms]    [k] _raw_spin_lock
>      1.58%  fio      fio                  [.] fio_gettime
>      1.53%  fio      [rtrs_client]        [k] __rtrs_get_permit
>      1.51%  fio      [rnbd_client]        [k] rnbd_queue_rq
>      1.51%  fio      [rtrs_client]        [k] rtrs_clt_put_permit
>      1.47%  fio      [kernel.kallsyms]    [k] try_to_wake_up
>      1.31%  fio      [kernel.kallsyms]    [k] kmem_cache_alloc
>      1.22%  fio      libc-2.28.so         [.] 0x00000000000a2547
>      1.17%  fio      [mlx4_ib]            [k] _mlx4_ib_post_send
>      1.14%  fio      [kernel.kallsyms]    [k] blkdev_direct_IO
>      1.14%  fio      [kernel.kallsyms]    [k] read_tsc
>      1.02%  fio      [rtrs_client]        [k] rtrs_clt_read_req
>      0.92%  fio      [rtrs_client]        [k] get_next_path_min_inflight
>      0.92%  fio      [kernel.kallsyms]    [k] sched_clock
>      0.91%  fio      [kernel.kallsyms]    [k] blk_mq_get_request
>      0.87%  fio      [kernel.kallsyms]    [k] x86_pmu_enable_all
>      0.87%  fio      [kernel.kallsyms]    [k] __sched_text_start
>      0.84%  fio      [kernel.kallsyms]    [k] insert_work
>      0.82%  fio      [kernel.kallsyms]    [k] copy_user_generic_string
>      0.80%  fio      [kernel.kallsyms]    [k] blk_attempt_plug_merge
>      0.73%  fio      [rtrs_client]        [k] rtrs_clt_update_all_stats
>

Hi Chaitanya,

I think likely/unlikely macros are related to cache and branch prediction.
So I checked cache and branch misses with perf tool.

The result are same before/after removing likely/unlikely
- cache misses: after 5,452%, before 5,443%
- branch misses: after 2.08%, before 2.09%

I would appreciate it if you would suggest something else for me to check.

Below is the raw data that I got from the perf tool.

after removing likely:
 Performance counter stats for 'fio --direct=1 --rw=randread
--time_based=1 --group_reporting --ioengine=libaio --iodepth=128
--name=fiotest --fadvise_hint=0 --iodepth_batch_submit=128
--iodepth_batch_complete=128 --invalidate=0 --runtime=180 --numjobs=64
--filename=/dev/rnbd0 --filename=/dev/rnbd1 --filename=/dev/rnbd2
--filename=/dev/rnbd3 --filename=/dev/rnbd4 --filename=/dev/rnbd5
--filename=/dev/rnbd6 --filename=/dev/rnbd7 --filename=/dev/rnbd8
--filename=/dev/rnbd9 --filename=/dev/rnbd10 --filename=/dev/rnbd11
--filename=/dev/rnbd12 --filename=/dev/rnbd13 --filename=/dev/rnbd14
--filename=/dev/rnbd15 --filename=/dev/rnbd16 --filename=/dev/rnbd17
--filename=/dev/rnbd18 --filename=/dev/rnbd19 --filename=/dev/rnbd20
--filename=/dev/rnbd21 --filename=/dev/rnbd22 --filename=/dev/rnbd23
--filename=/dev/rnbd24 --filename=/dev/rnbd25 --filename=/dev/rnbd26
--filename=/dev/rnbd27 --filename=/dev/rnbd28 --filename=/dev/rnbd29
--filename=/dev/rnbd30 --filename=/dev/rnbd31':

      1.834.487,82 msec task-clock                #    9,986 CPUs
utilized
 3.128.339.845.336      cycles                    #    1,705 GHz
               (66,53%)
 1.110.316.024.909      instructions              #    0,35  insn per
cycle           (83,27%)
    76.626.760.535      cache-references          #   41,770 M/sec
               (83,26%)
     4.177.366.104      cache-misses              #    5,452 % of all
cache refs      (50,21%)
   224.055.600.184      branches                  #  122,135 M/sec
               (66,85%)
     4.669.404.288      branch-misses             #    2,08% of all
branches          (83,38%)

     183,707988693 seconds time elapsed
     185,630125000 seconds user
    1590,286666000 seconds sys

before removing:
 Performance counter stats for 'fio --direct=1 --rw=randread
--time_based=1 --group_reporting --ioengine=libaio --iodepth=128
--name=fiotest --fadvise_hint=0 --iodepth_batch_submit=128
--iodepth_batch_complete=128 --invalidate=0 --runtime=180 --numjobs=64
--filename=/dev/rnbd0 --filename=/dev/rnbd1 --filename=/dev/rnbd2
--filename=/dev/rnbd3 --filename=/dev/rnbd4 --filename=/dev/rnbd5
--filename=/dev/rnbd6 --filename=/dev/rnbd7 --filename=/dev/rnbd8
--filename=/dev/rnbd9 --filename=/dev/rnbd10 --filename=/dev/rnbd11
--filename=/dev/rnbd12 --filename=/dev/rnbd13 --filename=/dev/rnbd14
--filename=/dev/rnbd15 --filename=/dev/rnbd16 --filename=/dev/rnbd17
--filename=/dev/rnbd18 --filename=/dev/rnbd19 --filename=/dev/rnbd20
--filename=/dev/rnbd21 --filename=/dev/rnbd22 --filename=/dev/rnbd23
--filename=/dev/rnbd24 --filename=/dev/rnbd25 --filename=/dev/rnbd26
--filename=/dev/rnbd27 --filename=/dev/rnbd28 --filename=/dev/rnbd29
--filename=/dev/rnbd30 --filename=/dev/rnbd31':

      1.841.874,78 msec task-clock                #   10,039 CPUs
utilized
 3.157.131.978.349      cycles                    #    1,714 GHz
               (66,48%)
 1.115.369.402.018      instructions              #    0,35  insn per
cycle           (83,27%)
    77.060.091.803      cache-references          #   41,838 M/sec
               (83,39%)
     4.194.110.754      cache-misses              #    5,443 % of all
cache refs      (50,13%)
   225.304.135.864      branches                  #  122,323 M/sec
               (66,83%)
     4.716.162.562      branch-misses             #    2,09% of all
branches          (83,42%)

     183,476417386 seconds time elapsed
     185,356439000 seconds user
    1596,787284000 seconds sys



>
> >
> > I knew somebody would ask for it ;-)
> > No, I didn't because I have been occupied with another task.
> > But I will check it soon in a few weeks.
> >
> > Thank you for the review.
> >
> > >
> > >
