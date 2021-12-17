Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 17 Dec 2021 11:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhLQLiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:38:11 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54070 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhLQLiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Dec 2021 06:38:11 -0500
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BHBcA8g045292
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 20:38:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 17 Dec 2021 20:38:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BHBc9Xh045287
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 20:38:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <f81aaa2b-16c4-6e20-8a13-33f0a7d319d1@i-love.sakura.ne.jp>
Date:   Fri, 17 Dec 2021 20:38:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] block: use "unsigned long" for blk_validate_block_size()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use of "unsigned short" for loop_validate_block_size() is wrong [1], and
commit af3c570fb0df422b ("loop: Use blk_validate_block_size() to validate
block size") changed to use "unsigned int".

However, since lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) passes "unsigned long
arg" to loop_set_block_size(), blk_validate_block_size() can't validate
the upper 32bits on 64bits environment. A block size like 0x100000200
should be rejected.

Link: https://lkml.kernel.org/r/20210927094327.644665-1-arnd@kernel.org [1]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca..e13e41f7fad2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -44,7 +44,7 @@ struct blk_crypto_profile;
  */
 #define BLKCG_MAX_POLS		6
 
-static inline int blk_validate_block_size(unsigned int bsize)
+static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
-- 
2.32.0
