Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 13:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbiCWNLY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiCWNLX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 09:11:23 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191F52AF6
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 06:09:52 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22ND9Vg7090425;
        Wed, 23 Mar 2022 22:09:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Wed, 23 Mar 2022 22:09:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22ND9UuE090419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Mar 2022 22:09:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <13337248-e940-acb9-4731-1e22ab56bd09@I-love.SAKURA.ne.jp>
Date:   Wed, 23 Mar 2022 22:09:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/8] loop: remove lo_refcount and avoid lo_mutex in ->open
 / ->release
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-8-hch@lst.de>
 <20220316112258.6hjksrv7yqiqcncu@quack3.lan>
 <26f0d3da-d45e-72aa-de2f-62ead4d2c25b@I-love.SAKURA.ne.jp>
 <20220316143855.sqm2dk77rbvxtxh7@quack3.lan> <20220322110908.GA28931@lst.de>
 <20220323121830.55g7dlbhmpfz4m2g@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220323121830.55g7dlbhmpfz4m2g@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/23 21:18, Jan Kara wrote:
>>>> Use of atomic_t for lo->lo_disk->part0->bd_openers does not help, for
>>>> currently lo->lo_mutex is held in order to avoid races. That is, it is
>>>> disk->open_mutex which loop_clr_fd() needs to hold when accessing
>>>> lo->lo_disk->part0->bd_openers.
>>>
>>> It does help because with atomic_t, seeing any intermediate values is not
>>> possible even for unlocked readers.
>>
>> The Linux memory model guarantees atomic reads from 32-bit integers.
>> But if it makes everyone happier I could do a READ_ONCE here.
> 
> Sure, the read is atomic wrt other CPU instructions, but it is not atomic
> wrt how the compiler decides to implement bdi->bd_openers++. So we need to
> make these bd_openers *updates* atomic so that the unlocked reads are
> really safe. That being said I consider the concerns mostly theoretical so
> I don't insist but some checker will surely complain sooner rather than
> later.

KCSAN will complain access without data_race(). But what I'm saying here is
that loop_clr_fd() needs to hold disk->open_mutex, for blkdev_get_whole() is
protected using disk->open_mutex. Then, KCSAN will not complain this access.

static int loop_clr_fd(struct loop_device *lo)
{
        int err;

        if (err)
                return err;
        if (lo->lo_state != Lo_bound) {
                mutex_unlock(&lo->lo_mutex);
                return -ENXIO;
        }
        if (lo->lo_disk->part0->bd_openers > 1) { // Sees lo->lo_disk->part0->bd_openers == 1.
                lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
                mutex_unlock(&lo->lo_mutex);
                return 0;
        }
	// Preemption starts.
							static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
							{
							        struct gendisk *disk = bdev->bd_disk;
							        int ret;
							
							        if (disk->fops->open) { // disk->fops->open == NULL because lo_open() is removed.
							                ret = disk->fops->open(bdev, mode);
							                if (ret) {
							                        /* avoid ghost partitions on a removed medium */
							                        if (ret == -ENOMEDIUM &&
							                             test_bit(GD_NEED_PART_SCAN, &disk->state))
							                                bdev_disk_changed(disk, true);
							                        return ret;
							                }
							        }
							
							        if (!bdev->bd_openers)
							                set_init_blocksize(bdev);
							        if (test_bit(GD_NEED_PART_SCAN, &disk->state))
							                bdev_disk_changed(disk, false);
							        bdev->bd_openers++;
							        return 0;
							}
	// Preemption ends.
        lo->lo_state = Lo_rundown;
        mutex_unlock(&lo->lo_mutex);

        __loop_clr_fd(lo, false); // Despite lo->lo_disk->part0->bd_openers > 1.
        return 0;
}

