Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5036FC433FE
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 02:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhL2CXg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Dec 2021 21:23:36 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61228 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbhL2CXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Dec 2021 21:23:36 -0500
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BT2NIa1099286;
        Wed, 29 Dec 2021 11:23:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 29 Dec 2021 11:23:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BT2NHMO099282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 29 Dec 2021 11:23:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <22b51922-30c6-e4ed-ace9-5620f877682c@i-love.sakura.ne.jp>
Date:   Wed, 29 Dec 2021 11:23:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] loop: use a global workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
References: <20211223112509.1116461-1-hch@lst.de>
 <20211223112509.1116461-2-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211223112509.1116461-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/23 20:25, Christoph Hellwig wrote:
> Using a per-device unbound workqueue is a bit of an anti-pattern and
> in this case also creates lock ordering problems.  Just use a global
> concurrencymanaged workqueue instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 36 +++++++++++++++---------------------
>  drivers/block/loop.h |  1 -
>  2 files changed, 15 insertions(+), 22 deletions(-)
> 

If a "struct work_struct" for an I/O request depends on more "struct work_struct"
for that I/O request, WQ can throttle and choke. It seems that use of single global
workquque is prone to I/O hung due to hitting WQ's max active limit.

---------- recursive-loop.c start ----------
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/loop.h>

int main(int argc, char *argv[])
{
	int i;
	static char buffer[4096] = { };
	const int loop_ctl_fd = open("/dev/loop-control", 3);
	int file_fd = open("testfile", O_RDWR | O_CREAT | O_TRUNC, 0600);
	ftruncate(file_fd, 1048576);
	for (i = 0; i < 512; i++) {
		int loop_fd;
		snprintf(buffer, sizeof(buffer) - 1, "/dev/loop%d", ioctl(loop_ctl_fd,  LOOP_CTL_GET_FREE, 0));
		loop_fd = open(buffer, O_RDWR);
		ioctl(loop_fd, LOOP_SET_FD, file_fd);
		close(file_fd);
		file_fd = loop_fd;
	}
	printf("Writing to %s\n", buffer);
	i = write(file_fd, buffer, sizeof(buffer));
	printf("Wrote %d, flushing.\n", i);
	fsync(file_fd);
	printf("Done.\n");
	return 0;
}
---------- recursive-loop.c end ----------

----------------------------------------
# uname -r
5.16.0-rc4-next-20211210
# time ./recursive-loop
Writing to /dev/loop511
Wrote 4096, flushing.
Done.

real    0m55.531s
user    0m0.005s
sys     0m13.628s
# losetup -D
# time ./recursive-loop
Writing to /dev/loop511
Wrote 4096, flushing.
Done.

real    0m4.734s
user    0m0.005s
sys     0m2.094s
----------------------------------------

With "[PATCH 1/2] loop: use a global workqueue" applied.

----------------------------------------
root@fuzz:~# uname -r
5.16.0-rc4-next-20211210+
root@fuzz:~# time ./recursive-loop
Writing to /dev/loop511
Wrote 4096, flushing.
----------------------------------------

Task hung because the task cannot return from fsync().
SysRq-t shows that a BIO from blkdev_fsync() can never complete because
recursive BIOs from other blkdev_fsync() can't start due to "active=256/256".

----------------------------------------
[  250.030246] task:kworker/1:251   state:D stack:28896 pid: 5511 ppid:     2 flags:0x00004000
[  250.030270] Workqueue: loop loop_rootcg_workfn [loop]
[  250.030289] Call Trace:
[  250.030294]  <TASK>
[  250.030313]  __schedule+0x8fc/0xa50
[  250.030356]  schedule+0xc1/0x120
[  250.030372]  schedule_timeout+0x2b/0x190
[  250.030414]  io_schedule_timeout+0x6d/0xa0
[  250.030423]  ? yield_to+0x2a0/0x2a0
[  250.030441]  do_wait_for_common+0x162/0x200
[  250.030460]  ? yield_to+0x2a0/0x2a0
[  250.030491]  wait_for_completion_io+0x46/0x60
[  250.030505]  submit_bio_wait+0xba/0xf0
[  250.030548]  blkdev_issue_flush+0xa1/0xd0
[  250.030573]  ? submit_bio_wait+0xf0/0xf0
[  250.030608]  blkdev_fsync+0x3d/0x50
[  250.030626]  loop_process_work+0x35c/0xf10 [loop]
[  250.030725]  process_one_work+0x40a/0x630
[  250.030782]  worker_thread+0x4d7/0x9b0
[  250.030808]  ? _raw_spin_unlock_irqrestore+0x3f/0xb0
[  250.030826]  ? preempt_count_sub+0xf/0xc0
[  250.030864]  kthread+0x27c/0x2a0
[  250.030875]  ? rcu_lock_release+0x20/0x20
[  250.030883]  ? kthread_blkcg+0x50/0x50
[  250.030903]  ret_from_fork+0x1f/0x30
[  250.030959]  </TASK>

[  250.054300] Showing busy workqueues and worker pools:
[  250.054352] workqueue loop: flags=0xc
[  250.054391]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=256/256 refcnt=258
[  250.054402]     in-flight: 5511:loop_rootcg_workfn [loop], 5409:loop_rootcg_workfn [loop], 5396:loop_rootcg_workfn [loop], 5365:loop_rootcg_workfn [loop], 5314:loop_rootcg_workfn [loop], 5303:loop_rootcg_workfn [loop], 5280:loop_rootcg_workfn [loop], 5493:loop_rootcg_workfn [loop], 5449:loop_rootcg_workfn [loop], 5410:loop_rootcg_workfn [loop], 5406:loop_rootcg_workfn [loop], 5325:loop_rootcg_workfn [loop], 5467:loop_rootcg_workfn [loop], 5429:loop_rootcg_workfn [loop], 5407:loop_rootcg_workfn [loop], 5322:loop_rootcg_workfn [loop], 5295:loop_rootcg_workfn [loop], 5272:loop_rootcg_workfn [loop], 5372:loop_rootcg_workfn [loop], 5364:loop_rootcg_workfn [loop], 5312:loop_rootcg_workfn [loop], 5264:loop_rootcg_workfn [loop], 5453:loop_rootcg_workfn [loop], 5345:loop_rootcg_workfn [loop], 5490:loop_rootcg_workfn [loop], 5423:loop_rootcg_workfn [loop], 5472:loop_rootcg_workfn [loop], 5463:loop_rootcg_workfn [loop], 5442:loop_rootcg_workfn [loop], 2302:loop_rootcg_workfn [loop]
[  250.054771] , 5501:loop_rootcg_workfn [loop], 5388:loop_rootcg_workfn [loop], 5316:loop_rootcg_workfn [loop], 5302:loop_rootcg_workfn [loop], 5268:loop_rootcg_workfn [loop], 5516:loop_rootcg_workfn [loop], 5434:loop_rootcg_workfn [loop], 5404:loop_rootcg_workfn [loop], 5354:loop_rootcg_workfn [loop], 5399:loop_rootcg_workfn [loop], 5343:loop_rootcg_workfn [loop], 5319:loop_rootcg_workfn [loop], 5471:loop_rootcg_workfn [loop], 5378:loop_rootcg_workfn [loop], 5360:loop_rootcg_workfn [loop], 5420:loop_rootcg_workfn [loop], 5398:loop_rootcg_workfn [loop], 5318:loop_rootcg_workfn [loop], 5311:loop_rootcg_workfn [loop], 5486:loop_rootcg_workfn [loop], 5470:loop_rootcg_workfn [loop], 5309:loop_rootcg_workfn [loop], 5298:loop_rootcg_workfn [loop], 5464:loop_rootcg_workfn [loop], 5342:loop_rootcg_workfn [loop], 5315:loop_rootcg_workfn [loop], 5281:loop_rootcg_workfn [loop], 5459:loop_rootcg_workfn [loop], 5424:loop_rootcg_workfn [loop], 5418:loop_rootcg_workfn [loop]
[  250.055144] , 5353:loop_rootcg_workfn [loop], 5341:loop_rootcg_workfn [loop], 5299:loop_rootcg_workfn [loop], 5284:loop_rootcg_workfn [loop], 5414:loop_rootcg_workfn [loop], 5363:loop_rootcg_workfn [loop], 5304:loop_rootcg_workfn [loop], 5285:loop_rootcg_workfn [loop], 5419:loop_rootcg_workfn [loop], 5397:loop_rootcg_workfn [loop], 5387:loop_rootcg_workfn [loop], 5379:loop_rootcg_workfn [loop], 5338:loop_rootcg_workfn [loop], 5253:loop_rootcg_workfn [loop], 5489:loop_rootcg_workfn [loop], 5445:loop_rootcg_workfn [loop], 5432:loop_rootcg_workfn [loop], 5356:loop_rootcg_workfn [loop], 5408:loop_rootcg_workfn [loop], 5310:loop_rootcg_workfn [loop], 5279:loop_rootcg_workfn [loop], 5358:loop_rootcg_workfn [loop], 2295:loop_rootcg_workfn [loop], 5287:loop_rootcg_workfn [loop], 5265:loop_rootcg_workfn [loop], 5261:loop_rootcg_workfn [loop], 2298:loop_rootcg_workfn [loop], 5508:loop_rootcg_workfn [loop], 5368:loop_rootcg_workfn [loop], 5488:loop_rootcg_workfn [loop]
[  250.055494] , 5469:loop_rootcg_workfn [loop], 5385:loop_rootcg_workfn [loop], 5340:loop_rootcg_workfn [loop], 5290:loop_rootcg_workfn [loop], 5494:loop_rootcg_workfn [loop], 5481:loop_rootcg_workfn [loop], 5361:loop_rootcg_workfn [loop], 5348:loop_rootcg_workfn [loop], 5286:loop_rootcg_workfn [loop], 5273:loop_rootcg_workfn [loop], 5495:loop_rootcg_workfn [loop], 5454:loop_rootcg_workfn [loop], 5392:loop_rootcg_workfn [loop], 5355:loop_rootcg_workfn [loop], 5327:loop_rootcg_workfn [loop], 5457:loop_rootcg_workfn [loop], 5417:loop_rootcg_workfn [loop], 5413:loop_rootcg_workfn [loop], 5306:loop_rootcg_workfn [loop], 5267:loop_rootcg_workfn [loop], 2308:loop_rootcg_workfn [loop], 2306:loop_rootcg_workfn [loop], 5500:loop_rootcg_workfn [loop], 5446:loop_rootcg_workfn [loop], 5331:loop_rootcg_workfn [loop], 5289:loop_rootcg_workfn [loop], 5474:loop_rootcg_workfn [loop], 5438:loop_rootcg_workfn [loop], 5390:loop_rootcg_workfn [loop], 5382:loop_rootcg_workfn [loop]
[  250.055846] , 5381:loop_rootcg_workfn [loop], 5357:loop_rootcg_workfn [loop], 5324:loop_rootcg_workfn [loop], 2304:loop_rootcg_workfn [loop], 5482:loop_rootcg_workfn [loop], 5475:loop_rootcg_workfn [loop], 5351:loop_rootcg_workfn [loop], 5300:loop_rootcg_workfn [loop], 5266:loop_rootcg_workfn [loop], 5430:loop_rootcg_workfn [loop], 5339:loop_rootcg_workfn [loop], 45:loop_rootcg_workfn [loop], 5461:loop_rootcg_workfn [loop], 5460:loop_rootcg_workfn [loop], 5394:loop_rootcg_workfn [loop], 5375:loop_rootcg_workfn [loop], 5259:loop_rootcg_workfn [loop], 2303:loop_rootcg_workfn [loop], 5507:loop_rootcg_workfn [loop], 5499:loop_rootcg_workfn [loop], 5497:loop_rootcg_workfn [loop], 2305:loop_rootcg_workfn [loop], 5405:loop_rootcg_workfn [loop], 5313:loop_rootcg_workfn [loop], 5478:loop_rootcg_workfn [loop], 5465:loop_rootcg_workfn [loop], 5376:loop_rootcg_workfn [loop], 104:loop_rootcg_workfn [loop], 5505:loop_rootcg_workfn [loop], 5462:loop_rootcg_workfn [loop], 5389:loop_rootcg_workfn [loop]
[  250.056207] , 5293:loop_rootcg_workfn [loop], 2307:loop_rootcg_workfn [loop], 5503:loop_rootcg_workfn [loop], 5403:loop_rootcg_workfn [loop], 5393:loop_rootcg_workfn [loop], 5366:loop_rootcg_workfn [loop], 5332:loop_rootcg_workfn [loop], 5278:loop_rootcg_workfn [loop], 5254:loop_rootcg_workfn [loop], 5484:loop_rootcg_workfn [loop], 5452:loop_rootcg_workfn [loop], 5439:loop_rootcg_workfn [loop], 5395:loop_rootcg_workfn [loop], 5380:loop_rootcg_workfn [loop], 5444:loop_rootcg_workfn [loop], 5416:loop_rootcg_workfn [loop], 5402:loop_rootcg_workfn [loop], 5350:loop_rootcg_workfn [loop], 5411:loop_rootcg_workfn [loop], 5369:loop_rootcg_workfn [loop], 5371:loop_rootcg_workfn [loop], 5370:loop_rootcg_workfn [loop], 5307:loop_rootcg_workfn [loop], 5271:loop_rootcg_workfn [loop], 5256:loop_rootcg_workfn [loop], 5421:loop_rootcg_workfn [loop], 5336:loop_rootcg_workfn [loop], 5277:loop_rootcg_workfn [loop], 5443:loop_rootcg_workfn [loop], 5283:loop_rootcg_workfn [loop]
[  250.056557] , 5255:loop_rootcg_workfn [loop], 2301:loop_rootcg_workfn [loop], 5502:loop_rootcg_workfn [loop], 5450:loop_rootcg_workfn [loop], 5391:loop_rootcg_workfn [loop], 5367:loop_rootcg_workfn [loop], 5352:loop_rootcg_workfn [loop], 5276:loop_rootcg_workfn [loop], 5506:loop_rootcg_workfn [loop], 5308:loop_rootcg_workfn [loop], 5305:loop_rootcg_workfn [loop], 5301:loop_rootcg_workfn [loop], 5294:loop_rootcg_workfn [loop], 5427:loop_rootcg_workfn [loop], 5492:loop_rootcg_workfn [loop], 5422:loop_rootcg_workfn [loop], 5401:loop_rootcg_workfn [loop], 5344:loop_rootcg_workfn [loop], 5320:loop_rootcg_workfn [loop], 4429:loop_rootcg_workfn [loop], 5509:loop_rootcg_workfn [loop], 5468:loop_rootcg_workfn [loop], 5458:loop_rootcg_workfn [loop], 5441:loop_rootcg_workfn [loop], 5362:loop_rootcg_workfn [loop], 5330:loop_rootcg_workfn [loop], 2300:loop_rootcg_workfn [loop], 5480:loop_rootcg_workfn [loop], 5282:loop_rootcg_workfn [loop], 5274:loop_rootcg_workfn [loop]
[  250.056930] , 5498:loop_rootcg_workfn [loop], 5323:loop_rootcg_workfn [loop], 5262:loop_rootcg_workfn [loop], 497:loop_rootcg_workfn [loop], 5435:loop_rootcg_workfn [loop], 5426:loop_rootcg_workfn [loop], 5400:loop_rootcg_workfn [loop], 5347:loop_rootcg_workfn [loop], 5275:loop_rootcg_workfn [loop], 5514:loop_rootcg_workfn [loop], 5431:loop_rootcg_workfn [loop], 5328:loop_rootcg_workfn [loop], 2299:loop_rootcg_workfn [loop], 5510:loop_rootcg_workfn [loop], 5428:loop_rootcg_workfn [loop], 5377:loop_rootcg_workfn [loop], 5496:loop_rootcg_workfn [loop], 5451:loop_rootcg_workfn [loop], 5383:loop_rootcg_workfn [loop], 5374:loop_rootcg_workfn [loop], 5288:loop_rootcg_workfn [loop], 5257:loop_rootcg_workfn [loop], 5483:loop_rootcg_workfn [loop], 5436:loop_rootcg_workfn [loop], 5425:loop_rootcg_workfn [loop], 5349:loop_rootcg_workfn [loop], 19:loop_rootcg_workfn [loop], 5433:loop_rootcg_workfn [loop], 5384:loop_rootcg_workfn [loop], 5373:loop_rootcg_workfn [loop], 5359:loop_rootcg_workfn [loop]
[  250.057292] , 5269:loop_rootcg_workfn [loop], 5258:loop_rootcg_workfn [loop], 5513:loop_rootcg_workfn [loop], 5292:loop_rootcg_workfn [loop], 5291:loop_rootcg_workfn [loop], 5477:loop_rootcg_workfn [loop], 5270:loop_rootcg_workfn [loop], 5515:loop_rootcg_workfn [loop], 5448:loop_rootcg_workfn [loop], 5447:loop_rootcg_workfn [loop], 5415:loop_rootcg_workfn [loop], 5386:loop_rootcg_workfn [loop], 5296:loop_rootcg_workfn [loop], 5260:loop_rootcg_workfn [loop]
[  250.057477]     inactive: loop_workfn [loop]
[  250.057496] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=1s workers=258 idle: 5526 5518


[  360.319488] task:kworker/1:251   state:D stack:28896 pid: 5511 ppid:     2 flags:0x00004000
[  360.319512] Workqueue: loop loop_rootcg_workfn [loop]
[  360.319533] Call Trace:
[  360.319538]  <TASK>
[  360.319558]  __schedule+0x8fc/0xa50
[  360.319603]  schedule+0xc1/0x120
[  360.319619]  schedule_timeout+0x2b/0x190
[  360.319663]  io_schedule_timeout+0x6d/0xa0
[  360.319673]  ? yield_to+0x2a0/0x2a0
[  360.319691]  do_wait_for_common+0x162/0x200
[  360.319710]  ? yield_to+0x2a0/0x2a0
[  360.319743]  wait_for_completion_io+0x46/0x60
[  360.319757]  submit_bio_wait+0xba/0xf0
[  360.319802]  blkdev_issue_flush+0xa1/0xd0
[  360.319828]  ? submit_bio_wait+0xf0/0xf0
[  360.319865]  blkdev_fsync+0x3d/0x50
[  360.319883]  loop_process_work+0x35c/0xf10 [loop]
[  360.319986]  process_one_work+0x40a/0x630
[  360.320045]  worker_thread+0x4d7/0x9b0
[  360.320072]  ? _raw_spin_unlock_irqrestore+0x3f/0xb0
[  360.320091]  ? preempt_count_sub+0xf/0xc0
[  360.320130]  kthread+0x27c/0x2a0
[  360.320141]  ? rcu_lock_release+0x20/0x20
[  360.320149]  ? kthread_blkcg+0x50/0x50
[  360.320171]  ret_from_fork+0x1f/0x30
[  360.320229]  </TASK>

[  360.344504] Showing busy workqueues and worker pools:
[  360.344556] workqueue loop: flags=0xc
[  360.344572]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=256/256 refcnt=258
[  360.344582]     in-flight: 5511:loop_rootcg_workfn [loop], 5409:loop_rootcg_workfn [loop], 5396:loop_rootcg_workfn [loop], 5365:loop_rootcg_workfn [loop], 5314:loop_rootcg_workfn [loop], 5303:loop_rootcg_workfn [loop], 5280:loop_rootcg_workfn [loop], 5493:loop_rootcg_workfn [loop], 5449:loop_rootcg_workfn [loop], 5410:loop_rootcg_workfn [loop], 5406:loop_rootcg_workfn [loop], 5325:loop_rootcg_workfn [loop], 5467:loop_rootcg_workfn [loop], 5429:loop_rootcg_workfn [loop], 5407:loop_rootcg_workfn [loop], 5322:loop_rootcg_workfn [loop], 5295:loop_rootcg_workfn [loop], 5272:loop_rootcg_workfn [loop], 5372:loop_rootcg_workfn [loop], 5364:loop_rootcg_workfn [loop], 5312:loop_rootcg_workfn [loop], 5264:loop_rootcg_workfn [loop], 5453:loop_rootcg_workfn [loop], 5345:loop_rootcg_workfn [loop], 5490:loop_rootcg_workfn [loop], 5423:loop_rootcg_workfn [loop], 5472:loop_rootcg_workfn [loop], 5463:loop_rootcg_workfn [loop], 5442:loop_rootcg_workfn [loop], 2302:loop_rootcg_workfn [loop]
[  360.344951] , 5501:loop_rootcg_workfn [loop], 5388:loop_rootcg_workfn [loop], 5316:loop_rootcg_workfn [loop], 5302:loop_rootcg_workfn [loop], 5268:loop_rootcg_workfn [loop], 5516:loop_rootcg_workfn [loop], 5434:loop_rootcg_workfn [loop], 5404:loop_rootcg_workfn [loop], 5354:loop_rootcg_workfn [loop], 5399:loop_rootcg_workfn [loop], 5343:loop_rootcg_workfn [loop], 5319:loop_rootcg_workfn [loop], 5471:loop_rootcg_workfn [loop], 5378:loop_rootcg_workfn [loop], 5360:loop_rootcg_workfn [loop], 5420:loop_rootcg_workfn [loop], 5398:loop_rootcg_workfn [loop], 5318:loop_rootcg_workfn [loop], 5311:loop_rootcg_workfn [loop], 5486:loop_rootcg_workfn [loop], 5470:loop_rootcg_workfn [loop], 5309:loop_rootcg_workfn [loop], 5298:loop_rootcg_workfn [loop], 5464:loop_rootcg_workfn [loop], 5342:loop_rootcg_workfn [loop], 5315:loop_rootcg_workfn [loop], 5281:loop_rootcg_workfn [loop], 5459:loop_rootcg_workfn [loop], 5424:loop_rootcg_workfn [loop], 5418:loop_rootcg_workfn [loop]
[  360.345363] , 5353:loop_rootcg_workfn [loop], 5341:loop_rootcg_workfn [loop], 5299:loop_rootcg_workfn [loop], 5284:loop_rootcg_workfn [loop], 5414:loop_rootcg_workfn [loop], 5363:loop_rootcg_workfn [loop], 5304:loop_rootcg_workfn [loop], 5285:loop_rootcg_workfn [loop], 5419:loop_rootcg_workfn [loop], 5397:loop_rootcg_workfn [loop], 5387:loop_rootcg_workfn [loop], 5379:loop_rootcg_workfn [loop], 5338:loop_rootcg_workfn [loop], 5253:loop_rootcg_workfn [loop], 5489:loop_rootcg_workfn [loop], 5445:loop_rootcg_workfn [loop], 5432:loop_rootcg_workfn [loop], 5356:loop_rootcg_workfn [loop], 5408:loop_rootcg_workfn [loop], 5310:loop_rootcg_workfn [loop], 5279:loop_rootcg_workfn [loop], 5358:loop_rootcg_workfn [loop], 2295:loop_rootcg_workfn [loop], 5287:loop_rootcg_workfn [loop], 5265:loop_rootcg_workfn [loop], 5261:loop_rootcg_workfn [loop], 2298:loop_rootcg_workfn [loop], 5508:loop_rootcg_workfn [loop], 5368:loop_rootcg_workfn [loop], 5488:loop_rootcg_workfn [loop]
[  360.345758] , 5469:loop_rootcg_workfn [loop], 5385:loop_rootcg_workfn [loop], 5340:loop_rootcg_workfn [loop], 5290:loop_rootcg_workfn [loop], 5494:loop_rootcg_workfn [loop], 5481:loop_rootcg_workfn [loop], 5361:loop_rootcg_workfn [loop], 5348:loop_rootcg_workfn [loop], 5286:loop_rootcg_workfn [loop], 5273:loop_rootcg_workfn [loop], 5495:loop_rootcg_workfn [loop], 5454:loop_rootcg_workfn [loop], 5392:loop_rootcg_workfn [loop], 5355:loop_rootcg_workfn [loop], 5327:loop_rootcg_workfn [loop], 5457:loop_rootcg_workfn [loop], 5417:loop_rootcg_workfn [loop], 5413:loop_rootcg_workfn [loop], 5306:loop_rootcg_workfn [loop], 5267:loop_rootcg_workfn [loop], 2308:loop_rootcg_workfn [loop], 2306:loop_rootcg_workfn [loop], 5500:loop_rootcg_workfn [loop], 5446:loop_rootcg_workfn [loop], 5331:loop_rootcg_workfn [loop], 5289:loop_rootcg_workfn [loop], 5474:loop_rootcg_workfn [loop], 5438:loop_rootcg_workfn [loop], 5390:loop_rootcg_workfn [loop], 5382:loop_rootcg_workfn [loop]
[  360.346122] , 5381:loop_rootcg_workfn [loop], 5357:loop_rootcg_workfn [loop], 5324:loop_rootcg_workfn [loop], 2304:loop_rootcg_workfn [loop], 5482:loop_rootcg_workfn [loop], 5475:loop_rootcg_workfn [loop], 5351:loop_rootcg_workfn [loop], 5300:loop_rootcg_workfn [loop], 5266:loop_rootcg_workfn [loop], 5430:loop_rootcg_workfn [loop], 5339:loop_rootcg_workfn [loop], 45:loop_rootcg_workfn [loop], 5461:loop_rootcg_workfn [loop], 5460:loop_rootcg_workfn [loop], 5394:loop_rootcg_workfn [loop], 5375:loop_rootcg_workfn [loop], 5259:loop_rootcg_workfn [loop], 2303:loop_rootcg_workfn [loop], 5507:loop_rootcg_workfn [loop], 5499:loop_rootcg_workfn [loop], 5497:loop_rootcg_workfn [loop], 2305:loop_rootcg_workfn [loop], 5405:loop_rootcg_workfn [loop], 5313:loop_rootcg_workfn [loop], 5478:loop_rootcg_workfn [loop], 5465:loop_rootcg_workfn [loop], 5376:loop_rootcg_workfn [loop], 104:loop_rootcg_workfn [loop], 5505:loop_rootcg_workfn [loop], 5462:loop_rootcg_workfn [loop], 5389:loop_rootcg_workfn [loop]
[  360.346496] , 5293:loop_rootcg_workfn [loop], 2307:loop_rootcg_workfn [loop], 5503:loop_rootcg_workfn [loop], 5403:loop_rootcg_workfn [loop], 5393:loop_rootcg_workfn [loop], 5366:loop_rootcg_workfn [loop], 5332:loop_rootcg_workfn [loop], 5278:loop_rootcg_workfn [loop], 5254:loop_rootcg_workfn [loop], 5484:loop_rootcg_workfn [loop], 5452:loop_rootcg_workfn [loop], 5439:loop_rootcg_workfn [loop], 5395:loop_rootcg_workfn [loop], 5380:loop_rootcg_workfn [loop], 5444:loop_rootcg_workfn [loop], 5416:loop_rootcg_workfn [loop], 5402:loop_rootcg_workfn [loop], 5350:loop_rootcg_workfn [loop], 5411:loop_rootcg_workfn [loop], 5369:loop_rootcg_workfn [loop], 5371:loop_rootcg_workfn [loop], 5370:loop_rootcg_workfn [loop], 5307:loop_rootcg_workfn [loop], 5271:loop_rootcg_workfn [loop], 5256:loop_rootcg_workfn [loop], 5421:loop_rootcg_workfn [loop], 5336:loop_rootcg_workfn [loop], 5277:loop_rootcg_workfn [loop], 5443:loop_rootcg_workfn [loop], 5283:loop_rootcg_workfn [loop]
[  360.346857] , 5255:loop_rootcg_workfn [loop], 2301:loop_rootcg_workfn [loop], 5502:loop_rootcg_workfn [loop], 5450:loop_rootcg_workfn [loop], 5391:loop_rootcg_workfn [loop], 5367:loop_rootcg_workfn [loop], 5352:loop_rootcg_workfn [loop], 5276:loop_rootcg_workfn [loop], 5506:loop_rootcg_workfn [loop], 5308:loop_rootcg_workfn [loop], 5305:loop_rootcg_workfn [loop], 5301:loop_rootcg_workfn [loop], 5294:loop_rootcg_workfn [loop], 5427:loop_rootcg_workfn [loop], 5492:loop_rootcg_workfn [loop], 5422:loop_rootcg_workfn [loop], 5401:loop_rootcg_workfn [loop], 5344:loop_rootcg_workfn [loop], 5320:loop_rootcg_workfn [loop], 4429:loop_rootcg_workfn [loop], 5509:loop_rootcg_workfn [loop], 5468:loop_rootcg_workfn [loop], 5458:loop_rootcg_workfn [loop], 5441:loop_rootcg_workfn [loop], 5362:loop_rootcg_workfn [loop], 5330:loop_rootcg_workfn [loop], 2300:loop_rootcg_workfn [loop], 5480:loop_rootcg_workfn [loop], 5282:loop_rootcg_workfn [loop], 5274:loop_rootcg_workfn [loop]
[  360.347219] , 5498:loop_rootcg_workfn [loop], 5323:loop_rootcg_workfn [loop], 5262:loop_rootcg_workfn [loop], 497:loop_rootcg_workfn [loop], 5435:loop_rootcg_workfn [loop], 5426:loop_rootcg_workfn [loop], 5400:loop_rootcg_workfn [loop], 5347:loop_rootcg_workfn [loop], 5275:loop_rootcg_workfn [loop], 5514:loop_rootcg_workfn [loop], 5431:loop_rootcg_workfn [loop], 5328:loop_rootcg_workfn [loop], 2299:loop_rootcg_workfn [loop], 5510:loop_rootcg_workfn [loop], 5428:loop_rootcg_workfn [loop], 5377:loop_rootcg_workfn [loop], 5496:loop_rootcg_workfn [loop], 5451:loop_rootcg_workfn [loop], 5383:loop_rootcg_workfn [loop], 5374:loop_rootcg_workfn [loop], 5288:loop_rootcg_workfn [loop], 5257:loop_rootcg_workfn [loop], 5483:loop_rootcg_workfn [loop], 5436:loop_rootcg_workfn [loop], 5425:loop_rootcg_workfn [loop], 5349:loop_rootcg_workfn [loop], 19:loop_rootcg_workfn [loop], 5433:loop_rootcg_workfn [loop], 5384:loop_rootcg_workfn [loop], 5373:loop_rootcg_workfn [loop], 5359:loop_rootcg_workfn [loop]
[  360.347592] , 5269:loop_rootcg_workfn [loop], 5258:loop_rootcg_workfn [loop], 5513:loop_rootcg_workfn [loop], 5292:loop_rootcg_workfn [loop], 5291:loop_rootcg_workfn [loop], 5477:loop_rootcg_workfn [loop], 5270:loop_rootcg_workfn [loop], 5515:loop_rootcg_workfn [loop], 5448:loop_rootcg_workfn [loop], 5447:loop_rootcg_workfn [loop], 5415:loop_rootcg_workfn [loop], 5386:loop_rootcg_workfn [loop], 5296:loop_rootcg_workfn [loop], 5260:loop_rootcg_workfn [loop]
[  360.347762]     inactive: loop_workfn [loop]
[  360.347854] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=0s workers=259 idle: 5695 5518 5526

[  628.625721] task:kworker/1:251   state:D stack:28896 pid: 5511 ppid:     2 flags:0x00004000
[  628.625746] Workqueue: loop loop_rootcg_workfn [loop]
[  628.625766] Call Trace:
[  628.625771]  <TASK>
[  628.625791]  __schedule+0x8fc/0xa50
[  628.625837]  schedule+0xc1/0x120
[  628.625853]  schedule_timeout+0x2b/0x190
[  628.625897]  io_schedule_timeout+0x6d/0xa0
[  628.625907]  ? yield_to+0x2a0/0x2a0
[  628.625925]  do_wait_for_common+0x162/0x200
[  628.625945]  ? yield_to+0x2a0/0x2a0
[  628.625977]  wait_for_completion_io+0x46/0x60
[  628.625992]  submit_bio_wait+0xba/0xf0
[  628.626037]  blkdev_issue_flush+0xa1/0xd0
[  628.626062]  ? submit_bio_wait+0xf0/0xf0
[  628.626099]  blkdev_fsync+0x3d/0x50
[  628.626117]  loop_process_work+0x35c/0xf10 [loop]
[  628.626220]  process_one_work+0x40a/0x630
[  628.626279]  worker_thread+0x4d7/0x9b0
[  628.626307]  ? _raw_spin_unlock_irqrestore+0x3f/0xb0
[  628.626325]  ? preempt_count_sub+0xf/0xc0
[  628.626364]  kthread+0x27c/0x2a0
[  628.626376]  ? rcu_lock_release+0x20/0x20
[  628.626384]  ? kthread_blkcg+0x50/0x50
[  628.626598]  ret_from_fork+0x1f/0x30
[  628.626660]  </TASK>

[  628.650621] Showing busy workqueues and worker pools:
[  628.650771] workqueue loop: flags=0xc
[  628.650790]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=256/256 refcnt=258
[  628.650801]     in-flight: 5511:loop_rootcg_workfn [loop], 5409:loop_rootcg_workfn [loop], 5396:loop_rootcg_workfn [loop], 5365:loop_rootcg_workfn [loop], 5314:loop_rootcg_workfn [loop], 5303:loop_rootcg_workfn [loop], 5280:loop_rootcg_workfn [loop], 5493:loop_rootcg_workfn [loop], 5449:loop_rootcg_workfn [loop], 5410:loop_rootcg_workfn [loop], 5406:loop_rootcg_workfn [loop], 5325:loop_rootcg_workfn [loop], 5467:loop_rootcg_workfn [loop], 5429:loop_rootcg_workfn [loop], 5407:loop_rootcg_workfn [loop], 5322:loop_rootcg_workfn [loop], 5295:loop_rootcg_workfn [loop], 5272:loop_rootcg_workfn [loop], 5372:loop_rootcg_workfn [loop], 5364:loop_rootcg_workfn [loop], 5312:loop_rootcg_workfn [loop], 5264:loop_rootcg_workfn [loop], 5453:loop_rootcg_workfn [loop], 5345:loop_rootcg_workfn [loop], 5490:loop_rootcg_workfn [loop], 5423:loop_rootcg_workfn [loop], 5472:loop_rootcg_workfn [loop], 5463:loop_rootcg_workfn [loop], 5442:loop_rootcg_workfn [loop], 2302:loop_rootcg_workfn [loop]
[  628.651170] , 5501:loop_rootcg_workfn [loop], 5388:loop_rootcg_workfn [loop], 5316:loop_rootcg_workfn [loop], 5302:loop_rootcg_workfn [loop], 5268:loop_rootcg_workfn [loop], 5516:loop_rootcg_workfn [loop], 5434:loop_rootcg_workfn [loop], 5404:loop_rootcg_workfn [loop], 5354:loop_rootcg_workfn [loop], 5399:loop_rootcg_workfn [loop], 5343:loop_rootcg_workfn [loop], 5319:loop_rootcg_workfn [loop], 5471:loop_rootcg_workfn [loop], 5378:loop_rootcg_workfn [loop], 5360:loop_rootcg_workfn [loop], 5420:loop_rootcg_workfn [loop], 5398:loop_rootcg_workfn [loop], 5318:loop_rootcg_workfn [loop], 5311:loop_rootcg_workfn [loop], 5486:loop_rootcg_workfn [loop], 5470:loop_rootcg_workfn [loop], 5309:loop_rootcg_workfn [loop], 5298:loop_rootcg_workfn [loop], 5464:loop_rootcg_workfn [loop], 5342:loop_rootcg_workfn [loop], 5315:loop_rootcg_workfn [loop], 5281:loop_rootcg_workfn [loop], 5459:loop_rootcg_workfn [loop], 5424:loop_rootcg_workfn [loop], 5418:loop_rootcg_workfn [loop]
[  628.651533] , 5353:loop_rootcg_workfn [loop], 5341:loop_rootcg_workfn [loop], 5299:loop_rootcg_workfn [loop], 5284:loop_rootcg_workfn [loop], 5414:loop_rootcg_workfn [loop], 5363:loop_rootcg_workfn [loop], 5304:loop_rootcg_workfn [loop], 5285:loop_rootcg_workfn [loop], 5419:loop_rootcg_workfn [loop], 5397:loop_rootcg_workfn [loop], 5387:loop_rootcg_workfn [loop], 5379:loop_rootcg_workfn [loop], 5338:loop_rootcg_workfn [loop], 5253:loop_rootcg_workfn [loop], 5489:loop_rootcg_workfn [loop], 5445:loop_rootcg_workfn [loop], 5432:loop_rootcg_workfn [loop], 5356:loop_rootcg_workfn [loop], 5408:loop_rootcg_workfn [loop], 5310:loop_rootcg_workfn [loop], 5279:loop_rootcg_workfn [loop], 5358:loop_rootcg_workfn [loop], 2295:loop_rootcg_workfn [loop], 5287:loop_rootcg_workfn [loop], 5265:loop_rootcg_workfn [loop], 5261:loop_rootcg_workfn [loop], 2298:loop_rootcg_workfn [loop], 5508:loop_rootcg_workfn [loop], 5368:loop_rootcg_workfn [loop], 5488:loop_rootcg_workfn [loop]
[  628.651895] , 5469:loop_rootcg_workfn [loop], 5385:loop_rootcg_workfn [loop], 5340:loop_rootcg_workfn [loop], 5290:loop_rootcg_workfn [loop], 5494:loop_rootcg_workfn [loop], 5481:loop_rootcg_workfn [loop], 5361:loop_rootcg_workfn [loop], 5348:loop_rootcg_workfn [loop], 5286:loop_rootcg_workfn [loop], 5273:loop_rootcg_workfn [loop], 5495:loop_rootcg_workfn [loop], 5454:loop_rootcg_workfn [loop], 5392:loop_rootcg_workfn [loop], 5355:loop_rootcg_workfn [loop], 5327:loop_rootcg_workfn [loop], 5457:loop_rootcg_workfn [loop], 5417:loop_rootcg_workfn [loop], 5413:loop_rootcg_workfn [loop], 5306:loop_rootcg_workfn [loop], 5267:loop_rootcg_workfn [loop], 2308:loop_rootcg_workfn [loop], 2306:loop_rootcg_workfn [loop], 5500:loop_rootcg_workfn [loop], 5446:loop_rootcg_workfn [loop], 5331:loop_rootcg_workfn [loop], 5289:loop_rootcg_workfn [loop], 5474:loop_rootcg_workfn [loop], 5438:loop_rootcg_workfn [loop], 5390:loop_rootcg_workfn [loop], 5382:loop_rootcg_workfn [loop]
[  628.652258] , 5381:loop_rootcg_workfn [loop], 5357:loop_rootcg_workfn [loop], 5324:loop_rootcg_workfn [loop], 2304:loop_rootcg_workfn [loop], 5482:loop_rootcg_workfn [loop], 5475:loop_rootcg_workfn [loop], 5351:loop_rootcg_workfn [loop], 5300:loop_rootcg_workfn [loop], 5266:loop_rootcg_workfn [loop], 5430:loop_rootcg_workfn [loop], 5339:loop_rootcg_workfn [loop], 45:loop_rootcg_workfn [loop], 5461:loop_rootcg_workfn [loop], 5460:loop_rootcg_workfn [loop], 5394:loop_rootcg_workfn [loop], 5375:loop_rootcg_workfn [loop], 5259:loop_rootcg_workfn [loop], 2303:loop_rootcg_workfn [loop], 5507:loop_rootcg_workfn [loop], 5499:loop_rootcg_workfn [loop], 5497:loop_rootcg_workfn [loop], 2305:loop_rootcg_workfn [loop], 5405:loop_rootcg_workfn [loop], 5313:loop_rootcg_workfn [loop], 5478:loop_rootcg_workfn [loop], 5465:loop_rootcg_workfn [loop], 5376:loop_rootcg_workfn [loop], 104:loop_rootcg_workfn [loop], 5505:loop_rootcg_workfn [loop], 5462:loop_rootcg_workfn [loop], 5389:loop_rootcg_workfn [loop]
[  628.652633] , 5293:loop_rootcg_workfn [loop], 2307:loop_rootcg_workfn [loop], 5503:loop_rootcg_workfn [loop], 5403:loop_rootcg_workfn [loop], 5393:loop_rootcg_workfn [loop], 5366:loop_rootcg_workfn [loop], 5332:loop_rootcg_workfn [loop], 5278:loop_rootcg_workfn [loop], 5254:loop_rootcg_workfn [loop], 5484:loop_rootcg_workfn [loop], 5452:loop_rootcg_workfn [loop], 5439:loop_rootcg_workfn [loop], 5395:loop_rootcg_workfn [loop], 5380:loop_rootcg_workfn [loop], 5444:loop_rootcg_workfn [loop], 5416:loop_rootcg_workfn [loop], 5402:loop_rootcg_workfn [loop], 5350:loop_rootcg_workfn [loop], 5411:loop_rootcg_workfn [loop], 5369:loop_rootcg_workfn [loop], 5371:loop_rootcg_workfn [loop], 5370:loop_rootcg_workfn [loop], 5307:loop_rootcg_workfn [loop], 5271:loop_rootcg_workfn [loop], 5256:loop_rootcg_workfn [loop], 5421:loop_rootcg_workfn [loop], 5336:loop_rootcg_workfn [loop], 5277:loop_rootcg_workfn [loop], 5443:loop_rootcg_workfn [loop], 5283:loop_rootcg_workfn [loop]
[  628.652994] , 5255:loop_rootcg_workfn [loop], 2301:loop_rootcg_workfn [loop], 5502:loop_rootcg_workfn [loop], 5450:loop_rootcg_workfn [loop], 5391:loop_rootcg_workfn [loop], 5367:loop_rootcg_workfn [loop], 5352:loop_rootcg_workfn [loop], 5276:loop_rootcg_workfn [loop], 5506:loop_rootcg_workfn [loop], 5308:loop_rootcg_workfn [loop], 5305:loop_rootcg_workfn [loop], 5301:loop_rootcg_workfn [loop], 5294:loop_rootcg_workfn [loop], 5427:loop_rootcg_workfn [loop], 5492:loop_rootcg_workfn [loop], 5422:loop_rootcg_workfn [loop], 5401:loop_rootcg_workfn [loop], 5344:loop_rootcg_workfn [loop], 5320:loop_rootcg_workfn [loop], 4429:loop_rootcg_workfn [loop], 5509:loop_rootcg_workfn [loop], 5468:loop_rootcg_workfn [loop], 5458:loop_rootcg_workfn [loop], 5441:loop_rootcg_workfn [loop], 5362:loop_rootcg_workfn [loop], 5330:loop_rootcg_workfn [loop], 2300:loop_rootcg_workfn [loop], 5480:loop_rootcg_workfn [loop], 5282:loop_rootcg_workfn [loop], 5274:loop_rootcg_workfn [loop]
[  628.653356] , 5498:loop_rootcg_workfn [loop], 5323:loop_rootcg_workfn [loop], 5262:loop_rootcg_workfn [loop], 497:loop_rootcg_workfn [loop], 5435:loop_rootcg_workfn [loop], 5426:loop_rootcg_workfn [loop], 5400:loop_rootcg_workfn [loop], 5347:loop_rootcg_workfn [loop], 5275:loop_rootcg_workfn [loop], 5514:loop_rootcg_workfn [loop], 5431:loop_rootcg_workfn [loop], 5328:loop_rootcg_workfn [loop], 2299:loop_rootcg_workfn [loop], 5510:loop_rootcg_workfn [loop], 5428:loop_rootcg_workfn [loop], 5377:loop_rootcg_workfn [loop], 5496:loop_rootcg_workfn [loop], 5451:loop_rootcg_workfn [loop], 5383:loop_rootcg_workfn [loop], 5374:loop_rootcg_workfn [loop], 5288:loop_rootcg_workfn [loop], 5257:loop_rootcg_workfn [loop], 5483:loop_rootcg_workfn [loop], 5436:loop_rootcg_workfn [loop], 5425:loop_rootcg_workfn [loop], 5349:loop_rootcg_workfn [loop], 19:loop_rootcg_workfn [loop], 5433:loop_rootcg_workfn [loop], 5384:loop_rootcg_workfn [loop], 5373:loop_rootcg_workfn [loop], 5359:loop_rootcg_workfn [loop]
[  628.653729] , 5269:loop_rootcg_workfn [loop], 5258:loop_rootcg_workfn [loop], 5513:loop_rootcg_workfn [loop], 5292:loop_rootcg_workfn [loop], 5291:loop_rootcg_workfn [loop], 5477:loop_rootcg_workfn [loop], 5270:loop_rootcg_workfn [loop], 5515:loop_rootcg_workfn [loop], 5448:loop_rootcg_workfn [loop], 5447:loop_rootcg_workfn [loop], 5415:loop_rootcg_workfn [loop], 5386:loop_rootcg_workfn [loop], 5296:loop_rootcg_workfn [loop], 5260:loop_rootcg_workfn [loop]
[  628.653898]     inactive: loop_workfn [loop]
[  628.653919] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=27s workers=259 idle: 5695 5518 5526
----------------------------------------

Of course, we could limit recursive LOOP_SET_FD usage. But we should be aware that
"active=256/256" situation would be possible via multiple concurrent fsync() requests.
We should try to make sure that execution context for "struct work_struct" is always
available (even under memory pressure where a new workqueue thread cannot be created).
