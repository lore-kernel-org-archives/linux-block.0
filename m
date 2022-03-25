Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F7DC4321E
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 15:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiCYPPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377027AbiCYPNv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 11:13:51 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0085DDBD2B
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 08:10:50 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22PFAnvA081406;
        Sat, 26 Mar 2022 00:10:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 26 Mar 2022 00:10:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22PFAmHD081402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 26 Mar 2022 00:10:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <23a87135-7f6c-0f0d-a054-e596114ea97b@I-love.SAKURA.ne.jp>
Date:   Sat, 26 Mar 2022 00:10:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 11/14] loop: implement ->free_disk
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
References: <20220325063929.1773899-1-hch@lst.de>
 <20220325063929.1773899-12-hch@lst.de>
 <53c6c4b8-0aad-c882-d2e9-91eb9533aa21@I-love.SAKURA.ne.jp>
In-Reply-To: <53c6c4b8-0aad-c882-d2e9-91eb9533aa21@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/25 19:42, Tetsuo Handa wrote:
> On 2022/03/25 15:39, Christoph Hellwig wrote:
>> Ensure that the lo_device which is stored in the gendisk private
>> data is valid until the gendisk is freed.  Currently the loop driver
>> uses a lot of effort to make sure a device is not freed when it is
>> still in use, but to to fix a potential deadlock this will be relaxed
>> a bit soon.
> 
> This patch breaks blk_cleanup_disk() into blk_cleanup_queue() and put_disk() on
> loop_remove() side only. But there is blk_cleanup_disk() in the error path of
> loop_add() side. Don't we need to rewrite the error path of loop_add() side, for
> put_disk() from blk_cleanup_disk() from loop_add() calls kfree() via lo_free_disk()
> but out_cleanup_disk: label falls through to blk_mq_free_tag_set() (which seems to
> be UAF read) and kfree() (which seems to be double kfree()) ?
> 

Ah, since set_bit(GD_ADDED, &disk->state) is not called unless
device_add_disk() from add_disk() succeeds, disk->fops->free_disk
will not be called unless add_disk() succeeds. Thus, it is OK for
the error path of loop_add(). Tricky call...
