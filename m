Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13550C433FE
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 13:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhLUNrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:47:00 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54201 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhLUNrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 08:47:00 -0500
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BLDknfx026573;
        Tue, 21 Dec 2021 22:46:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Tue, 21 Dec 2021 22:46:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BLDknb2026560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Dec 2021 22:46:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <6562c672-e6e4-2f85-c5ce-dafc8b528cbf@i-love.sakura.ne.jp>
Date:   Tue, 21 Dec 2021 22:46:48 +0900
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
>>> I think we can apply this patch as-is...
>>
>> With the patch as-is we'll still leak disk->ev if device_add fails.
>> Something like the patch below should solve that by moving the disk->ev
>> allocation later and always cleaning it up through disk->release:
> 
> Sorry, this still had the extra return.
> 

OK. Since blkdev_get_no_open() from blkdev_get_by_dev() returns NULL until
disk_alloc_events() after device_add() completes, there is no race window for
unbalanced disk_block_events(disk)/disk_unblock_events(disk) pair.

Your patch seems to work. Please propose as a patch.
