Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366FDC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 10:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhLUKV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 05:21:57 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56246 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLUKV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 05:21:57 -0500
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BLALdbo046079;
        Tue, 21 Dec 2021 19:21:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 21 Dec 2021 19:21:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BLALdst046076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Dec 2021 19:21:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <9946ace6-7a00-fd15-3cfa-886eb3b63c6f@i-love.sakura.ne.jp>
Date:   Tue, 21 Dec 2021 19:21:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
 <20211216161806.GA31879@lst.de> <20211216161928.GB31879@lst.de>
 <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp>
 <20211221100811.GA10674@lst.de> <20211221101517.GA13416@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211221101517.GA13416@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/21 19:15, Christoph Hellwig wrote:
> On Tue, Dec 21, 2021 at 11:08:11AM +0100, Christoph Hellwig wrote:
>> On Fri, Dec 17, 2021 at 07:37:43PM +0900, Tetsuo Handa wrote:
>>> Well, I don't think that we can remove this blk_free_ext_minor() call, for
>>> this call is releasing disk->first_minor rather than MINOR(bdev->bd_dev).
>>>
>>> Since bdev_add(disk->part0, MKDEV(disk->major, disk->first_minor)) is not
>>> called when reaching the out_free_ext_minor label,
>>>
>>> 	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
>>> 		blk_free_ext_minor(MINOR(bdev->bd_dev));
>>>
>>> in bdev_free_inode() will not be called because MAJOR(bdev->bd_dev) == 0
>>> because bdev->bd_dev == 0.
>>>
>>> I think we can apply this patch as-is...
>>
>> With the patch as-is we'll still leak disk->ev if device_add fails.
>> Something like the patch below should solve that by moving the disk->ev
>> allocation later and always cleaning it up through disk->release:

Then what about this simple fix?

diff --git a/block/disk-events.c b/block/disk-events.c
index 8d5496e7592a..05b1249650ab 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -501,4 +501,5 @@ void disk_release_events(struct gendisk *disk)
 	/* the block count should be 1 from disk_del_events() */
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
+	disk->ev = NULL;
 }

