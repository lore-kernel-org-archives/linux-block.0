Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C71C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18F3217D8
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LgBi6Spc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfBHRfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40046 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfBHRfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:35:00 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so10786990ita.5
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyuM0dnPuVU7KgrSQK34TQOUl0fgJTh6boF0RdVGlFw=;
        b=LgBi6Spcp+Pwwd879uefw24SXzKawrhdzCeYg7evYuUj1cBDlnq8QhKzi3+BKK1Lj+
         FE/Fbrno+OQnL/U4FhUb2d5ohfTtgzi4AzHNvqhuJXglpKqW8Y2xLbS0G7U36+iU+7Td
         doXGfgIqUQjTUuiWRAkkazBKjcMxVU2pmma5YPtaxaP2bYDCFOLrQ3vwhD6+L3XIUHCu
         TSHHpCtN35vpBF/93uzgF4OgriGHsLIuWRlCtTVnnrOfrt/8LrcYvCAb4Z5Ngp8BbB85
         1vnZV0g1TuiH0rLX8TGrMs1owuivMwF9wocslIZoHPapcvPFvS7L+9zhjXtwYsjzJIk5
         bFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyuM0dnPuVU7KgrSQK34TQOUl0fgJTh6boF0RdVGlFw=;
        b=aSKnYuLa7ZcRXT1Z6pGGvTgO1x+Y3bwaLa280xdYnJ8MBBG54guArfKjrb1sLFP8xd
         CyO52phEv3IiuVE1c32A0NZXjRsSd2BO4Npn2+GDTe/7+N3xIHH7scaJGS7WBneK1x2r
         MDRcjmHxfZIhQlo684CFBSYUoBAOgAcmV1vgcdX4pILn59D4eAJ6cYtrmqQK11Sgc+6R
         W4gY4TbbW5bnrRVoNTdDVeuckiZaJAzy0vY8Gd1sNjiyzZUDxJvll8gUH9/4mXDbbuRr
         9E17LehCpGcfFzku/sBe6NlCLfyrgmCxSHZVoTIfdtYuBI/s69lvZzmEI2HyO3F70Gjn
         6xCA==
X-Gm-Message-State: AHQUAuaeRZcLKP/9u5CiFNZdwcBVJcE2qjnG+Pc7w0Y5/72XK0mPsItr
        lqVBIBZn7IcrKRwnUQM4pgej+w==
X-Google-Smtp-Source: AHgI3IbyNn8UiVHVfI+zf5IVICGvjQ1CXhU/XcGg08nF7t3P8RuRccc+3DH4AMKqCIti455V/80T4g==
X-Received: by 2002:a24:6f51:: with SMTP id x78mr6719044itb.121.1549647299486;
        Fri, 08 Feb 2019 09:34:59 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:34:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>,
        netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 13/19] net: split out functions related to registering inflight socket files
Date:   Fri,  8 Feb 2019 10:34:17 -0700
Message-Id: <20190208173423.27014-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need this functionality for the io_uring file registration, but
we cannot rely on it since CONFIG_UNIX can be modular. Move the helpers
to a separate file, that's always builtin to the kernel if CONFIG_UNIX is
m/y.

No functional changes in this patch, just moving code around.

Cc: netdev@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/net/af_unix.h |   1 +
 net/unix/Kconfig      |   5 ++
 net/unix/Makefile     |   2 +
 net/unix/af_unix.c    |  63 +-----------------
 net/unix/garbage.c    |  71 +-------------------
 net/unix/scm.c        | 146 ++++++++++++++++++++++++++++++++++++++++++
 net/unix/scm.h        |  10 +++
 7 files changed, 168 insertions(+), 130 deletions(-)
 create mode 100644 net/unix/scm.c
 create mode 100644 net/unix/scm.h

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index ddbba838d048..3426d6dacc45 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -10,6 +10,7 @@
 
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
+void unix_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(void);
 struct sock *unix_get_socket(struct file *filp);
diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index 8b31ab85d050..3b9e450656a4 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -19,6 +19,11 @@ config UNIX
 
 	  Say Y unless you know what you are doing.
 
+config UNIX_SCM
+	bool
+	depends on UNIX
+	default y
+
 config UNIX_DIAG
 	tristate "UNIX: socket monitoring interface"
 	depends on UNIX
diff --git a/net/unix/Makefile b/net/unix/Makefile
index ffd0a275c3a7..54e58cc4f945 100644
--- a/net/unix/Makefile
+++ b/net/unix/Makefile
@@ -10,3 +10,5 @@ unix-$(CONFIG_SYSCTL)	+= sysctl_net_unix.o
 
 obj-$(CONFIG_UNIX_DIAG)	+= unix_diag.o
 unix_diag-y		:= diag.o
+
+obj-$(CONFIG_UNIX_SCM)	+= scm.o
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 74d1eed7cbd4..2ce32dbb2feb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -119,6 +119,8 @@
 #include <linux/freezer.h>
 #include <linux/file.h>
 
+#include "scm.h"
+
 struct hlist_head unix_socket_table[2 * UNIX_HASH_SIZE];
 EXPORT_SYMBOL_GPL(unix_socket_table);
 DEFINE_SPINLOCK(unix_table_lock);
@@ -1486,67 +1488,6 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return err;
 }
 
-static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	scm->fp = UNIXCB(skb).fp;
-	UNIXCB(skb).fp = NULL;
-
-	for (i = scm->fp->count-1; i >= 0; i--)
-		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
-}
-
-static void unix_destruct_scm(struct sk_buff *skb)
-{
-	struct scm_cookie scm;
-	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
-	if (UNIXCB(skb).fp)
-		unix_detach_fds(&scm, skb);
-
-	/* Alas, it calls VFS */
-	/* So fscking what? fput() had been SMP-safe since the last Summer */
-	scm_destroy(&scm);
-	sock_wfree(skb);
-}
-
-/*
- * The "user->unix_inflight" variable is protected by the garbage
- * collection lock, and we just read it locklessly here. If you go
- * over the limit, there might be a tiny race in actually noticing
- * it across threads. Tough.
- */
-static inline bool too_many_unix_fds(struct task_struct *p)
-{
-	struct user_struct *user = current_user();
-
-	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
-		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
-	return false;
-}
-
-static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	if (too_many_unix_fds(current))
-		return -ETOOMANYREFS;
-
-	/*
-	 * Need to duplicate file references for the sake of garbage
-	 * collection.  Otherwise a socket in the fps might become a
-	 * candidate for GC while the skb is not yet queued.
-	 */
-	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
-	if (!UNIXCB(skb).fp)
-		return -ENOMEM;
-
-	for (i = scm->fp->count - 1; i >= 0; i--)
-		unix_inflight(scm->fp->user, scm->fp->fp[i]);
-	return 0;
-}
-
 static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool send_fds)
 {
 	int err = 0;
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index f81854d74c7d..8bbe1b8e4ff7 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -86,80 +86,13 @@
 #include <net/scm.h>
 #include <net/tcp_states.h>
 
+#include "scm.h"
+
 /* Internal data structures and random procedures: */
 
-static LIST_HEAD(gc_inflight_list);
 static LIST_HEAD(gc_candidates);
-static DEFINE_SPINLOCK(unix_gc_lock);
 static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
 
-unsigned int unix_tot_inflight;
-
-struct sock *unix_get_socket(struct file *filp)
-{
-	struct sock *u_sock = NULL;
-	struct inode *inode = file_inode(filp);
-
-	/* Socket ? */
-	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
-		struct socket *sock = SOCKET_I(inode);
-		struct sock *s = sock->sk;
-
-		/* PF_UNIX ? */
-		if (s && sock->ops && sock->ops->family == PF_UNIX)
-			u_sock = s;
-	} else {
-		/* Could be an io_uring instance */
-		u_sock = io_uring_get_socket(filp);
-	}
-	return u_sock;
-}
-
-/* Keep the number of times in flight count for the file
- * descriptor if it is for an AF_UNIX socket.
- */
-
-void unix_inflight(struct user_struct *user, struct file *fp)
-{
-	struct sock *s = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
-		if (atomic_long_inc_return(&u->inflight) == 1) {
-			BUG_ON(!list_empty(&u->link));
-			list_add_tail(&u->link, &gc_inflight_list);
-		} else {
-			BUG_ON(list_empty(&u->link));
-		}
-		unix_tot_inflight++;
-	}
-	user->unix_inflight++;
-	spin_unlock(&unix_gc_lock);
-}
-
-void unix_notinflight(struct user_struct *user, struct file *fp)
-{
-	struct sock *s = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
-		BUG_ON(!atomic_long_read(&u->inflight));
-		BUG_ON(list_empty(&u->link));
-
-		if (atomic_long_dec_and_test(&u->inflight))
-			list_del_init(&u->link);
-		unix_tot_inflight--;
-	}
-	user->unix_inflight--;
-	spin_unlock(&unix_gc_lock);
-}
-
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
 {
diff --git a/net/unix/scm.c b/net/unix/scm.c
new file mode 100644
index 000000000000..ed1624588934
--- /dev/null
+++ b/net/unix/scm.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/socket.h>
+#include <linux/net.h>
+#include <linux/fs.h>
+#include <net/af_unix.h>
+#include <net/scm.h>
+#include <linux/init.h>
+
+#include "scm.h"
+
+unsigned int unix_tot_inflight;
+
+LIST_HEAD(gc_inflight_list);
+DEFINE_SPINLOCK(unix_gc_lock);
+
+struct sock *unix_get_socket(struct file *filp)
+{
+	struct sock *u_sock = NULL;
+	struct inode *inode = file_inode(filp);
+
+	/* Socket ? */
+	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
+		struct socket *sock = SOCKET_I(inode);
+		struct sock *s = sock->sk;
+
+		/* PF_UNIX ? */
+		if (s && sock->ops && sock->ops->family == PF_UNIX)
+			u_sock = s;
+	} else {
+		/* Could be an io_uring instance */
+		u_sock = io_uring_get_socket(filp);
+	}
+	return u_sock;
+}
+EXPORT_SYMBOL(unix_get_socket);
+
+/* Keep the number of times in flight count for the file
+ * descriptor if it is for an AF_UNIX socket.
+ */
+void unix_inflight(struct user_struct *user, struct file *fp)
+{
+	struct sock *s = unix_get_socket(fp);
+
+	spin_lock(&unix_gc_lock);
+
+	if (s) {
+		struct unix_sock *u = unix_sk(s);
+
+		if (atomic_long_inc_return(&u->inflight) == 1) {
+			BUG_ON(!list_empty(&u->link));
+			list_add_tail(&u->link, &gc_inflight_list);
+		} else {
+			BUG_ON(list_empty(&u->link));
+		}
+		unix_tot_inflight++;
+	}
+	user->unix_inflight++;
+	spin_unlock(&unix_gc_lock);
+}
+
+void unix_notinflight(struct user_struct *user, struct file *fp)
+{
+	struct sock *s = unix_get_socket(fp);
+
+	spin_lock(&unix_gc_lock);
+
+	if (s) {
+		struct unix_sock *u = unix_sk(s);
+
+		BUG_ON(!atomic_long_read(&u->inflight));
+		BUG_ON(list_empty(&u->link));
+
+		if (atomic_long_dec_and_test(&u->inflight))
+			list_del_init(&u->link);
+		unix_tot_inflight--;
+	}
+	user->unix_inflight--;
+	spin_unlock(&unix_gc_lock);
+}
+
+/*
+ * The "user->unix_inflight" variable is protected by the garbage
+ * collection lock, and we just read it locklessly here. If you go
+ * over the limit, there might be a tiny race in actually noticing
+ * it across threads. Tough.
+ */
+static inline bool too_many_unix_fds(struct task_struct *p)
+{
+	struct user_struct *user = current_user();
+
+	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
+		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+	return false;
+}
+
+int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	int i;
+
+	if (too_many_unix_fds(current))
+		return -ETOOMANYREFS;
+
+	/*
+	 * Need to duplicate file references for the sake of garbage
+	 * collection.  Otherwise a socket in the fps might become a
+	 * candidate for GC while the skb is not yet queued.
+	 */
+	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
+	if (!UNIXCB(skb).fp)
+		return -ENOMEM;
+
+	for (i = scm->fp->count - 1; i >= 0; i--)
+		unix_inflight(scm->fp->user, scm->fp->fp[i]);
+	return 0;
+}
+EXPORT_SYMBOL(unix_attach_fds);
+
+void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	int i;
+
+	scm->fp = UNIXCB(skb).fp;
+	UNIXCB(skb).fp = NULL;
+
+	for (i = scm->fp->count-1; i >= 0; i--)
+		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
+}
+EXPORT_SYMBOL(unix_detach_fds);
+
+void unix_destruct_scm(struct sk_buff *skb)
+{
+	struct scm_cookie scm;
+
+	memset(&scm, 0, sizeof(scm));
+	scm.pid  = UNIXCB(skb).pid;
+	if (UNIXCB(skb).fp)
+		unix_detach_fds(&scm, skb);
+
+	/* Alas, it calls VFS */
+	/* So fscking what? fput() had been SMP-safe since the last Summer */
+	scm_destroy(&scm);
+	sock_wfree(skb);
+}
diff --git a/net/unix/scm.h b/net/unix/scm.h
new file mode 100644
index 000000000000..5a255a477f16
--- /dev/null
+++ b/net/unix/scm.h
@@ -0,0 +1,10 @@
+#ifndef NET_UNIX_SCM_H
+#define NET_UNIX_SCM_H
+
+extern struct list_head gc_inflight_list;
+extern spinlock_t unix_gc_lock;
+
+int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb);
+void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb);
+
+#endif
-- 
2.17.1

