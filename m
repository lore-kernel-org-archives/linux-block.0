Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F36CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Dec 2021 14:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhLQOvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Dec 2021 09:51:32 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52564 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhLQOvc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Dec 2021 09:51:32 -0500
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BHEpVeJ006860
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 23:51:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 17 Dec 2021 23:51:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BHEpTM5006856
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 23:51:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <b1b19379-23ee-5379-0eb5-94bf5f79f1b4@i-love.sakura.ne.jp>
Date:   Fri, 17 Dec 2021 23:51:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] block: check minor range in device_add_disk()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ioctl(fd, LOOP_CTL_ADD, 1048576) causes

  sysfs: cannot create duplicate filename '/dev/block/7:0'

message because such request is treated as if ioctl(fd, LOOP_CTL_ADD, 0)
due to MINORMASK == 1048575. Verify that all minor numbers for that device
fit in the minor range.

Reported-by: wangyangbo <wangyangbo@uniontech.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/genhd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 30362aeacac4..b6a278f54f34 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -425,6 +425,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 				DISK_MAX_PARTS);
 			disk->minors = DISK_MAX_PARTS;
 		}
+		if (disk->first_minor + disk->minors > MINORMASK + 1)
+			return -EINVAL;
 	} else {
 		if (WARN_ON(disk->minors))
 			return -EINVAL;
-- 
2.32.0

