Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C28C433F5
	for <linux-block@archiver.kernel.org>; Sat, 18 Dec 2021 09:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhLRJmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Dec 2021 04:42:03 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56650 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhLRJmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Dec 2021 04:42:03 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BI9fxv6032222;
        Sat, 18 Dec 2021 18:41:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 18 Dec 2021 18:41:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BI9fxUM032219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Dec 2021 18:41:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <9ecbf057-4375-c2db-ab53-e4cc0dff953d@i-love.sakura.ne.jp>
Date:   Sat, 18 Dec 2021 18:41:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: [PATCH v2] block: use "unsigned long" for blk_validate_block_size().
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
References: <f81aaa2b-16c4-6e20-8a13-33f0a7d319d1@i-love.sakura.ne.jp>
 <b114e2c8-d5c2-c2e8-9aeb-c18eaba52de0@kernel.dk>
 <7943926f-4365-f741-a353-4820b8707d87@i-love.sakura.ne.jp>
 <6e9e3cf6-5cb6-cde6-c8ef-aafd685d6d97@i-love.sakura.ne.jp>
In-Reply-To: <6e9e3cf6-5cb6-cde6-c8ef-aafd685d6d97@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) and ioctl(NBD_SET_BLKSIZE) pass
user-controlled "unsigned long arg" to blk_validate_block_size(),
"unsigned long" should be used for validation.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Rewrite description.

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

