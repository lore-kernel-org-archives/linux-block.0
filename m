Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B85C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbiFTQL5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242145AbiFTQL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9DC20BC7
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2FE8621B85;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2ws/QxBRb/M2rDqfKbqG9c7pW0RmRLlad4HiaJaQ2o=;
        b=MM8vOpUq6kNzxr402Z3QvaclRyMEtm5YEiVn6oW1cEHEVthIioNOAMAckKOzqpXygpquTo
        mzYY3JaMh3dPNH19RR/DiN0WoeigkSQRHHddVLjYY7qlSh7OlKTSF9qAHtHpgPob5K/ry7
        CTR+r/aSB6mIXO+as8CCl9I9O2neRgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2ws/QxBRb/M2rDqfKbqG9c7pW0RmRLlad4HiaJaQ2o=;
        b=KMgmpFONVktmrWp2pFvMgTH1Vuo6rCSX8cJ7Bdn4kSvIZZWjfdPv/CJqqdYl+vdtJ9+PY4
        O9wixsKzeERXHYAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A50432C142;
        Mon, 20 Jun 2022 16:11:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39BFAA0637; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/8] block: fix default IO priority handling again
Date:   Mon, 20 Jun 2022 18:11:42 +0200
Message-Id: <20220620161153.11741-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620160726.19798-1-jack@suse.cz>
References: <20220620160726.19798-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263; h=from:subject; bh=PJc+JSJchvfeOzZSCrbFJ2fBI9++bCpTYDxnDWkhbBI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJw/ZmWK9FC6GkB36zwOPYVbpI8w1LLy0yy3ms1c L4WtZ7aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcPwAKCRCcnaoHP2RA2c8sCA DRWzUveYUtr5xuIa3RDYS9zfHlHg2q3Ji1FgaW9fEq6IrzFGwEV7EDb6C/KGgBmbToivmjN+eG0gx7 XVIFkr4375nlrNblLUUmCQeNj0FUF4I2eK8LjjbeWMsJTF2zJ4LjICewAZXG/pCVD7UiqA683yRQND 9M4cZeXnjVkFqmX2KdsbJsp9VeuKOLX3D8uFnzLhEgUqysVja3krQRhAd54jemCqjokMFhy0y6SA5a sUXHwL0G/7M7SDTDKyXQufuw+2kPcRGGxzO4seLP+8lOMHKoucw7YTpkl7ZJY4xsd1JnnGymNaWuRh N8F2rZGqHc2yxCBQrWROKVhQPpuP8Z
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit e70344c05995 ("block: fix default IO priority handling")
introduced an inconsistency in get_current_ioprio() that tasks without
IO context return IOPRIO_DEFAULT priority while tasks with freshly
allocated IO context will return 0 (IOPRIO_CLASS_NONE/0) IO priority.
Tasks without IO context used to be rare before 5a9d041ba2f6 ("block:
move io_context creation into where it's needed") but after this commit
they became common because now only BFQ IO scheduler setups task's IO
context. Similar inconsistency is there for get_task_ioprio() so this
inconsistency is now exposed to userspace and userspace will see
different IO priority for tasks operating on devices with BFQ compared
to devices without BFQ. Furthemore the changes done by commit
e70344c05995 change the behavior when no IO priority is set for BFQ IO
scheduler which is also documented in ioprio_set(2) manpage:

"If no I/O scheduler has been set for a thread, then by default the I/O
priority will follow the CPU nice value (setpriority(2)).  In Linux
kernels before version 2.6.24, once an I/O priority had been set using
ioprio_set(), there was no way to reset the I/O scheduling behavior to
the default. Since Linux 2.6.24, specifying ioprio as 0 can be used to
reset to the default I/O scheduling behavior."

So make sure we default to IOPRIO_CLASS_NONE as used to be the case
before commit e70344c05995. Also cleanup alloc_io_context() to
explicitely set this IO priority for the allocated IO context to avoid
future surprises. Note that we tweak ioprio_best() to maintain
ioprio_get(2) behavior and make this commit easily backportable.

Fixes: e70344c05995 ("block: fix default IO priority handling")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-ioc.c        | 2 ++
 block/ioprio.c         | 4 ++--
 include/linux/ioprio.h | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index df9cfe4ca532..63fc02042408 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -247,6 +247,8 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
 #endif
+	ioc->ioprio = IOPRIO_DEFAULT;
+
 	return ioc;
 }
 
diff --git a/block/ioprio.c b/block/ioprio.c
index 2fe068fcaad5..2a34cbca18ae 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -157,9 +157,9 @@ static int get_task_ioprio(struct task_struct *p)
 int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
-		aprio = IOPRIO_DEFAULT;
+		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
 	if (!ioprio_valid(bprio))
-		bprio = IOPRIO_DEFAULT;
+		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
 
 	return min(aprio, bprio);
 }
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 3f53bc27a19b..3d088a88f832 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -11,7 +11,7 @@
 /*
  * Default IO priority.
  */
-#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
+#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0)
 
 /*
  * Check that a priority value has a valid class.
-- 
2.35.3

