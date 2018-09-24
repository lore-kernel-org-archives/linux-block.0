Return-Path: <linux-block-owner@vger.kernel.org>
Received: from www262.sakura.ne.jp ([202.181.97.72]:21276 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIYDLY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Sep 2018 23:11:24 -0400
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
To: Jan Kara <jack@suse.cz>
Cc: Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        syzbot
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
 <20180924184734.GH28775@quack2.suse.cz>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <70de0609-c9f5-1747-93dc-fc4d693f1c27@i-love.sakura.ne.jp>
Date: Tue, 25 Sep 2018 06:06:56 +0900
MIME-Version: 1.0
In-Reply-To: <20180924184734.GH28775@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/09/25 3:47, Jan Kara wrote:
>> +/*
>> + * unlock_loop - Unlock loop_mutex as needed.
>> + *
>> + * Explicitly call this function before calling fput() or blkdev_reread_part()
>> + * in order to avoid circular lock dependency. After this function is called,
>> + * current thread is no longer allowed to access "struct loop_device" memory,
>> + * for another thread would access that memory as soon as loop_mutex is held.
>> + */
>> +static void unlock_loop(void)
>> +{
>> +	if (loop_mutex_owner == current) {
> 
> Urgh, why this check? Conditional locking / unlocking is evil so it has to
> have *very* good reasons and there is not any explanation here. So far I
> don't see a reason why this is needed at all.

Yeah, this is why Jens hates this patch. But any alternative?



>> @@ -630,7 +669,12 @@ static void loop_reread_partitions(struct loop_device *lo,
>> +	unlock_loop();
> 
> Unlocking in loop_reread_partitions() makes the locking rules ugly. And
> unnecessarily AFAICT. Can't we just use lo_refcnt to protect us against
> loop_clr_fd() and freeing of 'lo' structure itself?

Really? I think that just elevating lo->lo_refcnt will cause another lockdep
warning because __blkdev_reread_part() requires bdev->bd_mutex being held.
Don't we need to drop the lock in order to solve original lockdep warning at [2] ?

int __blkdev_reread_part(struct block_device *bdev)
{
	struct gendisk *disk = bdev->bd_disk;

	if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
		return -EINVAL;
	if (!capable(CAP_SYS_ADMIN))
		return -EACCES;

	lockdep_assert_held(&bdev->bd_mutex);

	return rescan_partitions(disk, bdev);
}

int blkdev_reread_part(struct block_device *bdev)
{
	int res;

	mutex_lock(&bdev->bd_mutex);
	res = __blkdev_reread_part(bdev);
	mutex_unlock(&bdev->bd_mutex);

	return res;
}
