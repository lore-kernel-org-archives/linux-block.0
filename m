Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Linus Walleij <linus.walleij@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
 <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk>
 <CACRpkdbngAKuwDaUwZ=QaW9POb4U2tFJA60aLKD6QZKf60bq6g@mail.gmail.com>
 <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <adfd57be-1e12-e900-6a78-3e9607017a10@kernel.dk>
Date: Fri, 28 Oct 2016 08:22:06 -0600
MIME-Version: 1.0
In-Reply-To: <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/28/2016 03:32 AM, Linus Walleij wrote:
> On Fri, Oct 28, 2016 at 12:27 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Thu, Oct 27, 2016 at 11:08 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> blk-mq has evolved to support a variety of devices, there's nothing
>>> special about mmc that can't work well within that framework.
>>
>> There is. Read mmc_queue_thread() in drivers/mmc/card/queue.c
>
> So I'm not just complaining by the way, I'm trying to fix this. Also
> Bartlomiej from Samsung has done some stabs at switching MMC/SD
> to blk-mq. I just rebased my latest stab at a naïve switch to blk-mq
> to v4.9-rc2 with these results.
>
> The patch to enable MQ looks like this:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/commit/?h=mmc-mq&id=8f79b527e2e854071d8da019451da68d4753f71d
>
> I run these tests directly after boot with cold caches. The results
> are consistent: I ran the same commands 10 times in a row.
>
>
> BEFORE switching to BLK-MQ (clean v4.9-rc2):
>
> time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.0GB) copied, 47.781464 seconds, 21.4MB/s
> real    0m 47.79s
> user    0m 0.02s
> sys     0m 9.35s
>
> mount /dev/mmcblk0p1 /mnt/
> cd /mnt/
> time find . > /dev/null
> real    0m 3.60s
> user    0m 0.25s
> sys     0m 1.58s
>
> mount /dev/mmcblk0p1 /mnt/
> iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
> (kBytes/second)
>                                                     random    random
>     kB  reclen    write  rewrite    read    reread    read     write
>  20480       4     2112     2157     6052     6060     6025       40
>  20480       8     4820     5074     9163     9121     9125       81
>  20480      16     5755     5242    12317    12320    12280      165
>  20480      32     6176     6261    14981    14987    14962      336
>  20480      64     6547     5875    16826    16828    16810      692
>  20480     128     6762     6828    17899    17896    17896     1408
>  20480     256     6802     6871    16960    17513    18373     3048
>  20480     512     7220     7252    18675    18746    18741     7228
>  20480    1024     7222     7304    18436    17858    18246     7322
>  20480    2048     7316     7398    18744    18751    18526     7419
>  20480    4096     7520     7636    20774    20995    20703     7609
>  20480    8192     7519     7704    21850    21489    21467     7663
>  20480   16384     7395     7782    22399    22210    22215     7781
>
>
> AFTER switching to BLK-MQ:
>
> time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.0GB) copied, 60.551117 seconds, 16.9MB/s
> real    1m 0.56s
> user    0m 0.02s
> sys     0m 9.81s
>
> mount /dev/mmcblk0p1 /mnt/
> cd /mnt/
> time find . > /dev/null
> real    0m 4.42s
> user    0m 0.24s
> sys     0m 1.81s
>
> mount /dev/mmcblk0p1 /mnt/
> iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
> (kBytes/second)
>                                                     random    random
>     kB  reclen    write  rewrite    read    reread    read     write
>  20480       4     2086     2201     6024     6036     6006       40
>  20480       8     4812     5036     8014     9121     9090       82
>  20480      16     5432     5633    12267     9776    12212      168
>  20480      32     6180     6233    14870    14891    14852      340
>  20480      64     6382     5454    16744    16771    16746      702
>  20480     128     6761     6776    17816    17846    17836     1394
>  20480     256     6828     6842    17789    17895    17094     3084
>  20480     512     7158     7222    17957    17681    17698     7232
>  20480    1024     7215     7274    18642    17679    18031     7300
>  20480    2048     7229     7269    17943    18642    17732     7358
>  20480    4096     7212     7360    18272    18157    18889     7371
>  20480    8192     7008     7271    18632    18707    18225     7282
>  20480   16384     6889     7211    18243    18429    18018     7246
>
>
> A simple dd readtest of 1 GB is always consistently 10+
> seconds slower with MQ. find in the rootfs is a second slower.
> iozone results are consistently lower throughput or the same.
>
> This is without using Bartlomiej's clever hack to pretend we have
> 2 elements in the HW queue though. His early tests indicate that
> it doesn't help much: the performance regression we see is due to
> lack of block scheduling.

A simple dd test, I don't see how that can be slower due to lack of
scheduling. There's nothing to schedule there, just issue them in order?
So that would probably be where I would start looking. A blktrace of the
in-kernel code and the blk-mq enabled code would perhaps be
enlightening. I don't think it's worth looking at the more complex test
cases until the dd test case is at least as fast as the non-mq version.
Was that with CFQ, btw, or what scheduler did it run?

It'd be nice to NOT have to rely on that fake QD=2 setup, since it will
mess with the IO scheduling as well.

> I try to find a way forward with this, and also massage the MMC/SD
> code to be more MQ friendly to begin with (like only pick requests
> when we get a request notification and stop pulling NULL requests
> off the queue) but it's really a messy piece of code.

Yeah, it does look pretty messy... I'd be happy to help out with that,
and particularly in figuring out why the direct conversion is slower for
a basic 'dd' test case.

-- 
Jens Axboe
