Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:56142 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdJWPNO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2017 11:13:14 -0400
Received: by mail-it0-f67.google.com with SMTP id l196so6322999itl.4
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2017 08:13:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508529929.3029.20.camel@wdc.com>
References: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
 <1508435243.2429.42.camel@wdc.com> <CAJrWOzCyLSNYAmEY6afoVjPYK8KaoH1HSs63iGpDuCwesjwBLQ@mail.gmail.com>
 <1508529929.3029.20.camel@wdc.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Mon, 23 Oct 2017 17:12:52 +0200
Message-ID: <CAJrWOzAmPT_0jrYRi_U-fHHjOitk2XE461ZhL=aKFiY3iQjGMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx restart
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "axboe@fb.com" <axboe@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Oct 20, 2017 at 10:05 PM, Bart Van Assche
<Bart.VanAssche@wdc.com> wrote:
> On Fri, 2017-10-20 at 11:39 +0200, Roman Penyaev wrote:
>> But what bothers me is these looong loops inside blk_mq_sched_restart(),
>> and since you are the author of the original 6d8c6c0f97ad ("blk-mq: Restart
>> a single queue if tag sets are shared") I want to ask what was the original
>> problem which you attempted to fix?  Likely I am missing some test scenario
>> which would be great to know about.
>
> Long loops? How many queues share the same tag set on your setup? How many
> hardware queues does your block driver create per request queue?

Yeah, ok, my mistake. I had to split both issues and should not have described
everything in one go in the first email.  So, take a look.

For my tests I create 128 queues (devices) with 64 hctx each, all queues share
same tags set, then I start 128 fio jobs (1 job per 1 queue).

The following is the fio and ftrace output for v4.14-rc4 kernel
(without any changes):

 READ: io=5630.3MB, aggrb=573208KB/s, minb=573208KB/s,
maxb=573208KB/s, mint=10058msec, maxt=10058msec
WRITE: io=5650.9MB, aggrb=575312KB/s, minb=575312KB/s,
maxb=575312KB/s, mint=10058msec, maxt=10058msec

root@pserver16:~/roman# cat /sys/kernel/debug/tracing/trace_stat/* | grep blk_mq
  Function                  Hit     Time            Avg             s^2
  --------                  ---     ----            ---             ---
  blk_mq_sched_restart     16347    9540759 us      583.639 us      8804801 us
  blk_mq_sched_restart      7884    6073471 us      770.354 us      8780054 us
  blk_mq_sched_restart     14176    7586794 us      535.185 us      2822731 us
  blk_mq_sched_restart      7843    6205435 us      791.206 us      12424960 us
  blk_mq_sched_restart      1490    4786107 us      3212.153 us
1949753 us    <<< !!! 3 ms in average !!!
  blk_mq_sched_restart      7892    6039311 us      765.244 us      2994627 us
  blk_mq_sched_restart     15382    7511126 us      488.306 us      3090912 us
  [cut]


And here are results with two patches reverted:

   8e8320c9315c ("blk-mq: fix performance regression with shared tags")
   6d8c6c0f97ad ("blk-mq: Restart a single queue if tag sets are shared")

 READ: io=12884MB, aggrb=1284.3MB/s, minb=1284.3MB/s, maxb=1284.3MB/s,
mint=10032msec, maxt=10032msec
WRITE: io=12987MB, aggrb=1294.6MB/s, minb=1294.6MB/s, maxb=1294.6MB/s,
mint=10032msec, maxt=10032msec

root@pserver16:~/roman# cat /sys/kernel/debug/tracing/trace_stat/* | grep blk_mq
  Function                  Hit      Time            Avg             s^2
  --------                  ---      ----            ---             ---
  blk_mq_sched_restart      50699    8802.349 us     0.173 us        121.771 us
  blk_mq_sched_restart      50362    8740.470 us     0.173 us        161.494 us
  blk_mq_sched_restart      50402    9066.337 us     0.179 us        113.009 us
  blk_mq_sched_restart      50104    9366.197 us     0.186 us        188.645 us
  blk_mq_sched_restart      50375    9317.727 us     0.184 us        54.218 us
  blk_mq_sched_restart      50136    9311.657 us     0.185 us        446.790 us
  blk_mq_sched_restart      50103    9179.625 us     0.183 us        114.472 us
  [cut]

The difference is significant: 570MB/s vs 1280MB/s.  E.g. one cpu spent 3 ms in
average iterating over all queues and hctxs in order to find out hctx
to restart.
In total CPUs spent *seconds* in loop.  That seems incredibly long.

> Commit 6d8c6c0f97ad is something I came up with to fix queue lockups in the
> SCSI and dm-mq drivers.

You mean fairness? (some hctx get less amount of chances to be restarted).
That's why you need to restart them in RR fashion, right?

In IBNBD I also do hctx restarts in RR fashion and for that I put each hctx
which is needed to be restarted in a separate percpu list.  Probably it makes
sense to do the same here?

--
Roman
