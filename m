Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28985C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 16:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhLPQAN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:00:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54981 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhLPQAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:00:11 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BGG01Va003055;
        Fri, 17 Dec 2021 01:00:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 17 Dec 2021 01:00:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BGG01EE003052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 17 Dec 2021 01:00:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
Date:   Fri, 17 Dec 2021 01:00:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] block: fix error handling for device_add_disk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting double kfree() bug in disk_release_events() [1], for
commit 9be68dd7ac0e13be ("md: add error handling support for add_disk()")
is calling blk_cleanup_disk() which will call disk_release_events() from
regular kobject_release() path when device_add_disk() from add_disk()
failed.

Since kobject_release() will be always called regardless of whether
device_add_disk() from add_disk() succeeds, we should leave
disk_release_events() to regular kobject_release() path.

Link: https://syzkaller.appspot.com/bug?extid=28a66a9fbc621c939000 [1]
Reported-by: syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>
Fixes: 83cbce9574462c6b ("block: add error handling for device_add_disk / add_disk")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 30362aeacac4..47bb34ab967b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -540,7 +540,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 out_device_del:
 	device_del(ddev);
 out_disk_release_events:
-	disk_release_events(disk);
+	/* disk_release() will call disk_release_events(). */
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
-- 
2.32.0
