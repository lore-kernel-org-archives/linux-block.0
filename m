Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF4C433F5
	for <linux-block@archiver.kernel.org>; Fri, 17 Dec 2021 10:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhLQKhz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Dec 2021 05:37:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54283 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhLQKhz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Dec 2021 05:37:55 -0500
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BHAbhoA092696;
        Fri, 17 Dec 2021 19:37:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Fri, 17 Dec 2021 19:37:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BHAbh3x092691
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 17 Dec 2021 19:37:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp>
Date:   Fri, 17 Dec 2021 19:37:43 +0900
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211216161928.GB31879@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/17 1:19, Christoph Hellwig wrote:
> On Thu, Dec 16, 2021 at 05:18:06PM +0100, Christoph Hellwig wrote:
>>>  out_disk_release_events:
>>> -	disk_release_events(disk);
>>> +	/* disk_release() will call disk_release_events(). */
>>>  out_free_ext_minor:
>>>  	if (disk->major == BLOCK_EXT_MAJOR)
>>>  		blk_free_ext_minor(disk->first_minor);
>>
>> .. actually while you're at it - blk_free_ext_minor is also done
>> by bdev_free_inode called from disk_release.
>>
>> So we can just remove the out_disk_release_events and out_free_ext_minor
>> labels entirely. 
> 
> ... of course we can't.  But we should return after the
> device_del instead of falling through to the other resource cleanups.

Well, I don't think that we can remove this blk_free_ext_minor() call, for
this call is releasing disk->first_minor rather than MINOR(bdev->bd_dev).

Since bdev_add(disk->part0, MKDEV(disk->major, disk->first_minor)) is not
called when reaching the out_free_ext_minor label,

	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
		blk_free_ext_minor(MINOR(bdev->bd_dev));

in bdev_free_inode() will not be called because MAJOR(bdev->bd_dev) == 0
because bdev->bd_dev == 0.

I think we can apply this patch as-is...
