Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6BC433ED
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 13:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671A1613B4
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 13:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhEDNGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 09:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhEDNGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 09:06:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF3C061574
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 06:05:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n25so10337204edr.5
        for <linux-block@vger.kernel.org>; Tue, 04 May 2021 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUkUGfV48gAPZBxjeovhKLHtKCViIY2cnDQcaBDAdxc=;
        b=Ovgrwn9dsCjzMdQFByLKr6G8djMtyOED3tdo/eBkZrmZwuauPnwViSSMWbKyx7DvUK
         ybUJOCcB297sziaQlMPiciXJwT7pRbuBM9myzPX/ByLgq8vRBaSPwMd5zQXdi7PCCJJc
         8Cbex+H2qAEk4XUkYXDQWzomW3upnT/EGK5/LgFRWyIzTE2zHDyAECRl0d9/yb5vDegm
         oJPK+DVQoIHgfNlZ8FDB3Eq+LIQqx2eNhODbUP92aC3MhujYsb3ntsubonJUvbkYL4xr
         6NxZ0Bev7K0lH882vbw0DZ0NFCByG/eEl6JjtzAgI1dXQjYeioVsIP97aIOZ/jZC6/yq
         6cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUkUGfV48gAPZBxjeovhKLHtKCViIY2cnDQcaBDAdxc=;
        b=feHsH0kah+wIl5xxPTiR24XSw0BA7vG3wzuDg74qvyOlhul6ib+OLbt5sZ0PPp0K5t
         PpQ5FP2CWjH8gu5b8w6tpJPFkfo9+lmlSX09zhRAkenwvw0PAP9JxaUIC8lCHc5jky+l
         oyyZI0dcIM7CrsBlfmHbd5mHVKqpnYRWARlhrAnlOcsSKsmkSvtAGFhNYze4dj82Dik2
         bsGlOsCThk8Im1hc9dDmWGx3/VtJ+1sjECGY7/OUfsy+txoVFTN6xdl9plsZQhR4djSo
         CCcGx4r1Jbx2jH9s7EnoxeAyXqk/pEiCenKhwYeNsCU4gBIYQchWYQz7Oo5EdPfjTanO
         U/Fw==
X-Gm-Message-State: AOAM532yjJxPoQM3/2YykgoFbaRJiywRhyrKPdmGVzHTvXA5LYYPVzbW
        upLFZOKWRatxmM2whjtJj2vOcebIRjjSShuYVPG5T7y0XW91eg==
X-Google-Smtp-Source: ABdhPJxflpBQPuFHfNLZHq5INo/Km294EDuN+fdNp+VNhx2ySh22x0QrBNqt0PSHIF6aE222nqQDN2JwkGoLUh6kMuc=
X-Received: by 2002:a05:6402:351:: with SMTP id r17mr25866030edw.186.1620133507857;
 Tue, 04 May 2021 06:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210428061359.206794-1-gi-oh.kim@ionos.com> <20210428061359.206794-5-gi-oh.kim@ionos.com>
 <BYAPR04MB496504E1348ABFEE30FFC0C186409@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CAJX1YtbJXWL7du8+6QzMisQhF72zRfMx92G2_LiLd3Nj6JSUYg@mail.gmail.com>
In-Reply-To: <CAJX1YtbJXWL7du8+6QzMisQhF72zRfMx92G2_LiLd3Nj6JSUYg@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 4 May 2021 15:04:32 +0200
Message-ID: <CAJX1YtZqe8h5vPbX0h-aVea7Oa08dmz9gMsasD-_JQ743phkag@mail.gmail.com>
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

On Thu, Apr 29, 2021 at 9:14 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> On Wed, Apr 28, 2021 at 8:33 PM Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com> wrote:
> >
> > On 4/27/21 23:14, Gioh Kim wrote:
> > > The IO performance test with fio after removing the likely and
> > > unlikely macros in all if-statement shows no performance drop.
> > > They do not help for the performance of rnbd.
> > >
> > > The fio test did random read on 32 rnbd devices and 64 processes.
> > > Test environment:
> > > - AMD Opteron(tm) Processor 6386 SE
> > > - 125G memory
> > > - kernel version: 5.4.86
> >
> > why 5.4 and not linux-block/for-next ?
>
> We have done porting only 5.4 for the server machine yet.
>
> >
> > > - gcc version: gcc (Debian 8.3.0-6) 8.3.0
> > > - Infiniband controller: InfiniBand: Mellanox Technologies MT26428
> > > [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> > >
> > > before
> > > read: IOPS=549k, BW=2146MiB/s
> > > read: IOPS=544k, BW=2125MiB/s
> > > read: IOPS=553k, BW=2158MiB/s
> > > read: IOPS=535k, BW=2089MiB/s
> > > read: IOPS=543k, BW=2122MiB/s
> > > read: IOPS=552k, BW=2154MiB/s
> > > average: IOPS=546k, BW=2132MiB/s
> > >
> > > after
> > > read: IOPS=556k, BW=2172MiB/s
> > > read: IOPS=561k, BW=2191MiB/s
> > > read: IOPS=552k, BW=2156MiB/s
> > > read: IOPS=551k, BW=2154MiB/s
> > > read: IOPS=562k, BW=2194MiB/s
> > > -----------
> > > average: IOPS=556k, BW=2173MiB/s
> > >
> > > The IOPS and bandwidth got better slightly after removing
> > > likely/unlikely. (IOPS= +1.8% BW= +1.9%) But we cannot make sure
> > > that removing the likely/unlikely help the performance because it
> > > depends on various situations. We only make sure that removing the
> > > likely/unlikely does not drop the performance.
> >
> > Did you get a chance to collect perf numbers to see which functions are
> > getting faster ?

Hi Chaitanya,

I ran the perf tool to find out which functions are getting faster.
But I was not able to find it.
Could you please suggest a tool or anything to check it out?

For your information, below is what I got with 'perf record fio
<options:8-device, 64-job, 60-second>'
The result before/after removing likely/unlikely looks the same.

     4.15%  fio      [kernel.kallsyms]    [k] _raw_spin_lock_irqsave
     3.19%  fio      [kernel.kallsyms]    [k] x86_pmu_disable_all
     2.98%  fio      [rnbd_client]        [k] rnbd_put_permit
     2.77%  fio      [kernel.kallsyms]    [k] find_first_zero_bit
     2.49%  fio      [kernel.kallsyms]    [k] __x86_indirect_thunk_rax
     2.21%  fio      [kernel.kallsyms]    [k] psi_task_change
     2.00%  fio      [kernel.kallsyms]    [k] gup_pgd_range
     1.83%  fio      fio                  [.] 0x0000000000029048
     1.78%  fio      [rnbd_client]        [k] rnbd_get_permit
     1.78%  fio      fio                  [.] axmap_isset
     1.63%  fio      [kernel.kallsyms]    [k] _raw_spin_lock
     1.58%  fio      fio                  [.] fio_gettime
     1.53%  fio      [rtrs_client]        [k] __rtrs_get_permit
     1.51%  fio      [rnbd_client]        [k] rnbd_queue_rq
     1.51%  fio      [rtrs_client]        [k] rtrs_clt_put_permit
     1.47%  fio      [kernel.kallsyms]    [k] try_to_wake_up
     1.31%  fio      [kernel.kallsyms]    [k] kmem_cache_alloc
     1.22%  fio      libc-2.28.so         [.] 0x00000000000a2547
     1.17%  fio      [mlx4_ib]            [k] _mlx4_ib_post_send
     1.14%  fio      [kernel.kallsyms]    [k] blkdev_direct_IO
     1.14%  fio      [kernel.kallsyms]    [k] read_tsc
     1.02%  fio      [rtrs_client]        [k] rtrs_clt_read_req
     0.92%  fio      [rtrs_client]        [k] get_next_path_min_inflight
     0.92%  fio      [kernel.kallsyms]    [k] sched_clock
     0.91%  fio      [kernel.kallsyms]    [k] blk_mq_get_request
     0.87%  fio      [kernel.kallsyms]    [k] x86_pmu_enable_all
     0.87%  fio      [kernel.kallsyms]    [k] __sched_text_start
     0.84%  fio      [kernel.kallsyms]    [k] insert_work
     0.82%  fio      [kernel.kallsyms]    [k] copy_user_generic_string
     0.80%  fio      [kernel.kallsyms]    [k] blk_attempt_plug_merge
     0.73%  fio      [rtrs_client]        [k] rtrs_clt_update_all_stats


>
> I knew somebody would ask for it ;-)
> No, I didn't because I have been occupied with another task.
> But I will check it soon in a few weeks.
>
> Thank you for the review.
>
> >
> >
