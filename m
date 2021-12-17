Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E42FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 17 Dec 2021 18:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhLQSJo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:09:44 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60342 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhLQSJn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Dec 2021 13:09:43 -0500
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BHI9eXY008807;
        Sat, 18 Dec 2021 03:09:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 18 Dec 2021 03:09:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BHI9dCD008804
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Dec 2021 03:09:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <7943926f-4365-f741-a353-4820b8707d87@i-love.sakura.ne.jp>
Date:   Sat, 18 Dec 2021 03:09:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: use "unsigned long" for blk_validate_block_size()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
References: <f81aaa2b-16c4-6e20-8a13-33f0a7d319d1@i-love.sakura.ne.jp>
 <b114e2c8-d5c2-c2e8-9aeb-c18eaba52de0@kernel.dk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <b114e2c8-d5c2-c2e8-9aeb-c18eaba52de0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/18 1:25, Jens Axboe wrote:
> On 12/17/21 4:38 AM, Tetsuo Handa wrote:
>> Use of "unsigned short" for loop_validate_block_size() is wrong [1], and
>> commit af3c570fb0df422b ("loop: Use blk_validate_block_size() to validate
>> block size") changed to use "unsigned int".
>>
>> However, since lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) passes "unsigned long
>> arg" to loop_set_block_size(), blk_validate_block_size() can't validate
>> the upper 32bits on 64bits environment. A block size like 0x100000200
>> should be rejected.
> 
> Wouldn't it make more sense to validate that part on the loop side? A
> block size > 32-bit doesn't make any sense.
> 

I think doing below is embarrassing, for there is blk_validate_block_size() which is
meant for validating the arg. Although use of "unsigned long" for blk_validate_block_size()
might cause small bloating on 64 bits kernels, I think 64 bits kernels would not care.

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c3a36cfaa855..98871d7b601d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1474,6 +1474,10 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	err = blk_validate_block_size(arg);
 	if (err)
 		return err;
+#if BITS_PER_LONG == 64
+	if (arg > UINT_MAX)
+		return -EINVAL;
+#endif
 
 	if (lo->lo_queue->limits.logical_block_size == arg)
 		return 0;

And reviving loop_validate_block_size() in order to use "unsigned long" does not make sense
for 32bits kernels.
