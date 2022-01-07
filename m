Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4942C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 11:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbiAGLBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:01:14 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55805 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiAGLBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 06:01:13 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 207B0lWQ060528;
        Fri, 7 Jan 2022 20:00:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 07 Jan 2022 20:00:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 207B0lNO060523
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 7 Jan 2022 20:00:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
Date:   Fri, 7 Jan 2022 20:00:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 1/2] block: export task_work_add()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Export task_work_add() so that the loop driver can synchronously perform
autoclear operation without disk->open_mutex held.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Update patch description.

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

