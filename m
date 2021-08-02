Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446B6C4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2261060FC1
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 13:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhHBNeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:34:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7775 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhHBNeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 09:34:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gdf9n62VJzYh4j;
        Mon,  2 Aug 2021 21:34:21 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 21:34:25 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 21:34:24 +0800
Subject: Re: [PATCH] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210712031818.31918-1-yukuai3@huawei.com>
 <ade72519-5e16-1cc5-9a77-cb9ead42035e@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <5ab07cf8-a2a5-a60e-c86a-ab6ea53990bb@huawei.com>
Date:   Mon, 2 Aug 2021 21:34:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ade72519-5e16-1cc5-9a77-cb9ead42035e@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/01 1:15, Bart Van Assche wrote:
> On 7/11/21 8:18 PM, Yu Kuai wrote:
>> If there are multiple active queues while sharing a tag set, it's not
>> necessary to limit the available tags as same share for each active queue
>> if no one ever failed to get driver tag. And fall back to same share if
>> someone do failed to get driver tag.
>>
>> This modification will be beneficial if total queue_depth of disks
>> on the same host is less than total tags.
> 
> This patch adds new atomic operations in the hot path and hence probably
> has a negative performance impact. What is the performance impact of
> this patch for e.g. null_blk when submitting I/O from all CPU cores?
> 
> Thanks,
> 
> Bart.
> .
> 

Hi, Bart

I run a test on both null_blk and nvme, results show that there are no
performance degradation:

test platform: x86
test cpu: 2 nodes, total 72
test scheduler: none
test device: null_blk / nvme

test cmd: fio -filename=/dev/xxx -name=test -ioengine=libaio -direct=1
-numjobs=72 -iodepth=16 -bs=4k -rw=write -offset_increment=1G
-cpus_allowed=0:71 -cpus_allowed_policy=split -group_reporting
-runtime=120

test results: iops
1) null_blk before this patch: 280k
2) null_blk after this patch: 282k
3) nvme before this patch: 378k
4) nvme after this patch: 384k

details:
1) null_blk before this patch:
test: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=16
...
fio-3.13-42-g8066f
Starting 72 processes
Jobs: 72 (f=72): [W(72)][100.0%][w=1095MiB/s][w=280k IOPS][eta 00m:00s]
test: (groupid=0, jobs=72): err= 0: pid=4986: Mon Aug  2 11:25:33 2021
   write: IOPS=279k, BW=1091MiB/s (1144MB/s)(128GiB/120009msec); 0 zone 
resets
     slat (nsec): min=1069, max=1837.6M, avg=240280.55, stdev=3604257.00
     clat (usec): min=89, max=1837.9k, avg=3882.70, stdev=13528.70
      lat (usec): min=175, max=1837.9k, avg=4123.03, stdev=13939.66
     clat percentiles (usec):
      |  1.00th=[   223],  5.00th=[   223], 10.00th=[   225], 20.00th=[ 
231],
      | 30.00th=[   478], 40.00th=[   873], 50.00th=[  1811], 60.00th=[ 
2737],
      | 70.00th=[  4293], 80.00th=[  6915], 90.00th=[  9372], 95.00th=[ 
12780],
      | 99.00th=[ 18482], 99.50th=[ 22676], 99.90th=[ 62129], 
99.95th=[231736],
      | 99.99th=[641729]
    bw (  MiB/s): min=   32, max= 3681, per=100.00%, avg=1106.55, 
stdev=25.25, samples=17006
    iops        : min= 8405, max=942588, avg=283276.25, stdev=6464.60, 
samples=17006
   lat (usec)   : 100=0.01%, 250=24.18%, 500=8.74%, 750=4.72%, 1000=4.01%
   lat (msec)   : 2=12.28%, 4=12.86%, 10=24.23%, 20=8.06%, 50=0.81%
   lat (msec)   : 100=0.02%, 250=0.04%, 500=0.03%, 750=0.01%, 1000=0.01%
   lat (msec)   : 2000=0.01%
   cpu          : usr=0.35%, sys=0.79%, ctx=35473919, majf=0, minf=1419
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued rwts: total=0,33525688,0,0 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   WRITE: bw=1091MiB/s (1144MB/s), 1091MiB/s-1091MiB/s 
(1144MB/s-1144MB/s), io=128GiB (137GB), run=120009-120009msec

Disk stats (read/write):
   nullb0: ios=0/33485328, merge=0/0, ticks=0/4817009, in_queue=4817009, 
util=100.00%

2) null_blk after this patch:
test: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=16
...
fio-3.13-42-g8066f
Starting 72 processes
Jobs: 72 (f=72): [W(72)][100.0%][w=1101MiB/s][w=282k IOPS][eta 00m:00s]
test: (groupid=0, jobs=72): err= 0: pid=5001: Mon Aug  2 10:36:52 2021
   write: IOPS=281k, BW=1097MiB/s (1150MB/s)(129GiB/120009msec); 0 zone 
resets
     slat (nsec): min=1104, max=5358.9M, avg=239050.23, stdev=4040598.71
     clat (usec): min=2, max=5359.3k, avg=3862.86, stdev=15270.20
      lat (usec): min=4, max=5359.3k, avg=4101.96, stdev=15742.32
     clat percentiles (usec):
      |  1.00th=[   221],  5.00th=[   223], 10.00th=[   225], 20.00th=[ 
231],
      | 30.00th=[   482], 40.00th=[  1106], 50.00th=[  1909], 60.00th=[ 
3163],
      | 70.00th=[  4490], 80.00th=[  5538], 90.00th=[ 10683], 95.00th=[ 
14877],
      | 99.00th=[ 16450], 99.50th=[ 19530], 99.90th=[ 30802], 99.95th=[ 
34341],
      | 99.99th=[650118]
    bw (  MiB/s): min=   23, max= 4395, per=100.00%, avg=1119.48, 
stdev=27.64, samples=16872
    iops        : min= 5906, max=1125367, avg=286585.88, stdev=7075.29, 
samples=16872
   lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 250=24.77%
   lat (usec)   : 500=6.12%, 750=4.51%, 1000=3.97%
   lat (msec)   : 2=11.02%, 4=15.75%, 10=23.34%, 20=10.15%, 50=0.34%
   lat (msec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
   lat (msec)   : 2000=0.01%, >=2000=0.01%
   cpu          : usr=0.36%, sys=0.79%, ctx=35506798, majf=0, minf=966
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued rwts: total=0,33697894,0,0 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   WRITE: bw=1097MiB/s (1150MB/s), 1097MiB/s-1097MiB/s 
(1150MB/s-1150MB/s), io=129GiB (138GB), run=120009-120009msec

Disk stats (read/write):
   nullb0: ios=0/33657152, merge=0/0, ticks=0/4812746, in_queue=4812745, 
util=100.00%

3) nvme before this patch:
test: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=16
...
fio-3.13-42-g8066f
Starting 72 processes
Jobs: 72 (f=72): [W(72)][100.0%][w=1478MiB/s][w=378k IOPS][eta 00m:00s]
test: (groupid=0, jobs=72): err= 0: pid=4780: Mon Aug  2 11:22:36 2021
   write: IOPS=382k, BW=1491MiB/s (1564MB/s)(175GiB/120113msec); 0 zone 
resets
     slat (nsec): min=1234, max=328006k, avg=102467.85, stdev=4967629.26
     clat (nsec): min=1788, max=329044k, avg=2899631.83, stdev=24819488.97
      lat (usec): min=31, max=424004, avg=3004.41, stdev=25334.53
     clat percentiles (usec):
      |  1.00th=[    39],  5.00th=[    39], 10.00th=[    39], 20.00th=[ 
39],
      | 30.00th=[    40], 40.00th=[    40], 50.00th=[    40], 60.00th=[ 
40],
      | 70.00th=[    41], 80.00th=[    41], 90.00th=[    42], 95.00th=[ 
45],
      | 99.00th=[132645], 99.50th=[252707], 99.90th=[287310], 
99.95th=[291505],
      | 99.99th=[304088]
    bw (  MiB/s): min=  783, max= 2394, per=100.00%, avg=1492.49, stdev= 
5.56, samples=17278
    iops        : min=200590, max=613014, avg=382076.48, stdev=1424.37, 
samples=17278
   lat (usec)   : 2=0.01%, 4=0.01%, 20=0.01%, 50=95.89%, 100=0.06%
   lat (usec)   : 250=0.06%, 500=0.15%, 750=0.18%, 1000=0.22%
   lat (msec)   : 2=0.96%, 4=0.60%, 10=0.21%, 20=0.05%, 50=0.18%
   lat (msec)   : 100=0.27%, 250=0.65%, 500=0.51%
   cpu          : usr=0.44%, sys=0.94%, ctx=123991, majf=0, minf=988
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued rwts: total=0,45859799,0,0 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   WRITE: bw=1491MiB/s (1564MB/s), 1491MiB/s-1491MiB/s 
(1564MB/s-1564MB/s), io=175GiB (188GB), run=120113-120113msec

Disk stats (read/write):
   nvme0n1: ios=308/45807739, merge=0/0, ticks=57/2334550, 
in_queue=2334607, util=100.00%

4) nvme after this patch:
after: nvme
test: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=16
...
fio-3.13-42-g8066f
Starting 72 processes
Jobs: 72 (f=72): [W(72)][100.0%][w=1502MiB/s][w=384k IOPS][eta 00m:00s]
test: (groupid=0, jobs=72): err= 0: pid=5320: Mon Aug  2 10:42:07 2021
   write: IOPS=383k, BW=1496MiB/s (1569MB/s)(175GiB/120098msec); 0 zone 
resets
     slat (nsec): min=1229, max=370007k, avg=100549.47, stdev=4919208.81
     clat (nsec): min=1634, max=370050k, avg=2892105.62, stdev=24891976.05
      lat (usec): min=31, max=380005, avg=2995.16, stdev=25391.59
     clat percentiles (usec):
      |  1.00th=[    38],  5.00th=[    39], 10.00th=[    39], 20.00th=[ 
39],
      | 30.00th=[    39], 40.00th=[    40], 50.00th=[    40], 60.00th=[ 
40],
      | 70.00th=[    41], 80.00th=[    41], 90.00th=[    42], 95.00th=[ 
44],
      | 99.00th=[135267], 99.50th=[252707], 99.90th=[287310], 
99.95th=[291505],
      | 99.99th=[304088]
    bw (  MiB/s): min=  827, max= 2248, per=100.00%, avg=1496.99, stdev= 
5.51, samples=17278
    iops        : min=211931, max=575591, avg=383228.21, stdev=1411.19, 
samples=17278
   lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=95.83%
   lat (usec)   : 100=0.15%, 250=0.05%, 500=0.13%, 750=0.18%, 1000=0.21%
   lat (msec)   : 2=0.85%, 4=0.84%, 10=0.14%, 20=0.05%, 50=0.14%
   lat (msec)   : 100=0.25%, 250=0.65%, 500=0.51%
   cpu          : usr=0.43%, sys=0.95%, ctx=123368, majf=0, minf=989
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued rwts: total=0,45995620,0,0 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   WRITE: bw=1496MiB/s (1569MB/s), 1496MiB/s-1496MiB/s 
(1569MB/s-1569MB/s), io=175GiB (188GB), run=120098-120098msec

Disk stats (read/write):
   nvme0n1: ios=190/45976809, merge=0/0, ticks=34/2374865, 
in_queue=2374900, util=100.00%

Thanks
Kuai
