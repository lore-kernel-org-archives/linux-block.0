Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048A4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 15:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhLVP0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:26:31 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53017 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhLVP0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 10:26:30 -0500
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BMFQI5C002483;
        Thu, 23 Dec 2021 00:26:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Thu, 23 Dec 2021 00:26:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BMFQHIX002480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Dec 2021 00:26:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <e9f59c70-5dc9-45ce-be93-9f149028f922@i-love.sakura.ne.jp>
Date:   Thu, 23 Dec 2021 00:26:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH 1/2] block: export task_work_add()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The loop driver wants to synchronously perform autoclear operation, for
some userspace programs (e.g. xfstest) depend on that the autoclear
operation already completes by the moment lo_release() from close()
returns to userspace and immediately call umount() of a partition
containing a backing file which the autoclear operation will close().

Export task_work_add() so that the loop driver can perform autoclear
operation by the moment lo_release() from close() returns to userspace.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/task_work.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe6f0e1..2a1644189182 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -60,6 +60,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(task_work_add);
 
 /**
  * task_work_cancel_match - cancel a pending work added by task_work_add()
-- 
2.32.0

