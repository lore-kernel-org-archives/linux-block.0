Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB4C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhLIGfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhLIGfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF4C0617A1
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BDkhBCN75BBMjSbllkGaYiHPOJT4ig4I1D79GC9roqA=; b=I6peD2OMDqkGDpUlX2QxwjaeXY
        oGOseNbKd5qoixaRJk4hQXNnp0O2TEt93vg1Gd0plI9TRfbH4x+qHJSCgxsxXIScYhJvCQ6Vob/Cm
        mGnSp5ebBp3hPMzwglfxJy6VGR6WRyoag0FrXYp3uZ7PU+SjyWUsxcTpskZpLyfAzyYJkIs5E3knc
        UJlZaLn8Mv+JanAlAdDKagjeF9tmk2/WJ27cnI4/Y+k12QmvcBROE8+M56yaqMDPN4XtVmCxZ+CxT
        XmshKAYjlLGnBEsWeSnu/gihLBgTKIehQ5ZYpwN7+XnZKeehPRACqm4ik85W9gXtkyLXhr5y92TVG
        TG3WfXMg==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxx-0096UF-3l; Thu, 09 Dec 2021 06:31:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 07/11] block: move set_task_ioprio to blk-ioc.c
Date:   Thu,  9 Dec 2021 07:31:27 +0100
Message-Id: <20211209063131.18537-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Keep set_task_ioprio with the other low-level code that accesses the
io_context structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c           | 34 ++++++++++++++++++++++++++++++++--
 block/ioprio.c            | 32 --------------------------------
 include/linux/iocontext.h |  2 --
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index f98a29ee8f362..c25ce2f3eb191 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -8,6 +8,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 #include <linux/sched/task.h>
 
 #include "blk.h"
@@ -280,8 +281,8 @@ static struct io_context *create_task_io_context(struct task_struct *task,
  * This function always goes through task_lock() and it's better to use
  * %current->io_context + get_io_context() for %current.
  */
-struct io_context *get_task_io_context(struct task_struct *task,
-				       gfp_t gfp_flags, int node)
+static struct io_context *get_task_io_context(struct task_struct *task,
+		gfp_t gfp_flags, int node)
 {
 	struct io_context *ioc;
 
@@ -298,6 +299,35 @@ struct io_context *get_task_io_context(struct task_struct *task,
 	return ioc;
 }
 
+int set_task_ioprio(struct task_struct *task, int ioprio)
+{
+	int err;
+	struct io_context *ioc;
+	const struct cred *cred = current_cred(), *tcred;
+
+	rcu_read_lock();
+	tcred = __task_cred(task);
+	if (!uid_eq(tcred->uid, cred->euid) &&
+	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
+		rcu_read_unlock();
+		return -EPERM;
+	}
+	rcu_read_unlock();
+
+	err = security_task_setioprio(task, ioprio);
+	if (err)
+		return err;
+
+	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
+	if (ioc) {
+		ioc->ioprio = ioprio;
+		put_io_context(ioc);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(set_task_ioprio);
+
 int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct io_context *ioc = current->io_context;
diff --git a/block/ioprio.c b/block/ioprio.c
index 313c14a70bbd3..e118f4bf2dc65 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -22,46 +22,14 @@
  */
 #include <linux/gfp.h>
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/ioprio.h>
 #include <linux/cred.h>
 #include <linux/blkdev.h>
 #include <linux/capability.h>
-#include <linux/sched/user.h>
-#include <linux/sched/task.h>
 #include <linux/syscalls.h>
 #include <linux/security.h>
 #include <linux/pid_namespace.h>
 
-int set_task_ioprio(struct task_struct *task, int ioprio)
-{
-	int err;
-	struct io_context *ioc;
-	const struct cred *cred = current_cred(), *tcred;
-
-	rcu_read_lock();
-	tcred = __task_cred(task);
-	if (!uid_eq(tcred->uid, cred->euid) &&
-	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
-		rcu_read_unlock();
-		return -EPERM;
-	}
-	rcu_read_unlock();
-
-	err = security_task_setioprio(task, ioprio);
-	if (err)
-		return err;
-
-	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
-	if (ioc) {
-		ioc->ioprio = ioprio;
-		put_io_context(ioc);
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(set_task_ioprio);
-
 int ioprio_check_cap(int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 82c7f4f5f4f59..648331f35fc66 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -116,8 +116,6 @@ struct task_struct;
 #ifdef CONFIG_BLOCK
 void put_io_context(struct io_context *ioc);
 void exit_io_context(struct task_struct *task);
-struct io_context *get_task_io_context(struct task_struct *task,
-				       gfp_t gfp_flags, int node);
 int __copy_io(unsigned long clone_flags, struct task_struct *tsk);
 static inline int copy_io(unsigned long clone_flags, struct task_struct *tsk)
 {
-- 
2.30.2

