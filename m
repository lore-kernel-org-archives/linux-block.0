Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556402C08CF
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530592; cv=none; b=Ds2KKnGKMpErgWyUG5EefQVarifpN2PigjOOBCya49HBPSwYXatB0GRiC8hK6HrKeHwOGUyDuDs2Y0BhpfN5upDLWMAVdKC/B0TGbdWtn34Z6SJwgjbw8gGrGSAATOsh7C34dC6BA6RuEhk66KVeTD/KhWCrBuG3XaQO62eBXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530592; c=relaxed/simple;
	bh=1OFERuWCzicdiztTF/q7QW5F9IVu0Slo/TPxet3gSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjuEOvDJVaytLl1VuuH2bJ7OqluLj4CDe8Ha6hvl+0nKyARPqILbuFtoTQrIUw//yWbvm3FKYvI4w6kD8o4vsSYJg5tAxmKiOmNPEq8WHp/+M7IjhNB4umK2+eP1LeWPRm++tJnc1cwrXivqf3I1jd9xGoW4eOggJ+EaBvaUfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=R2w23gKe; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="R2w23gKe"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-47116aaf345so5650265e9.1
        for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530589; x=1762135389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=R2w23gKebBpUsSrkjs9qb+uA933kY17ORq1QiEZ5dqv+HqNaKr6LPIUvwfCzoO4xTf
         y2kPW4HujgD2GSJ8Js/FS3z5VFkQrma6RhS5N6Cyv7Y7E5QUJY/fzmXXBDhpUAyKzyh/
         L7ur65v+m/RlBdlox4CsmRbvVTDvVtbwyPe/dOc41TqLGfeUQSD+cmzFLHmCerNa+cly
         CGSis1jcmGt4WRJWWIP/HgchMqOJ7JuTGiXnLG5ENcUbnTPcDzD1zGAuAxwjgIM5LXAS
         Oawgzp5gHr+7ia87D5X+B2NlnylMHQKxDBjC4S51RCr+vySGBnOCDpkvNdeKYqk1vDWQ
         k2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530589; x=1762135389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=Xh/FgQ529rapHa+K0lw6U5s+ApcURcIS3/CwyaXfohfRk7dOu0rNhg5PB2SfO6N7EN
         iroqKNdXpltzmXkkVRXZgSMtmz0Iq3Zs/Az8rBPVvKF5DmRB8P6CUJpiGp4A4jhNyJ/8
         igt1jWTBjvHtYUZcaFUWFzr4OV8yU8VBS/SNooVqtFtcesto77/pD3cxd+N1nwwVMuX+
         IsoOnkv4e1Ezc4ddWEDe9reho8+hJmzFgLt8kiF9AzA5nYIb/dptURDmEzCICMjoc8Or
         lYYJhUGGk0ARZKYBudFMJR118aWQTzXUVx6bzCDxknXs1wVSSHFa3/neui9HcmanKoWH
         8jbw==
X-Forwarded-Encrypted: i=1; AJvYcCV1yUDoqE6RsLvBJWocSq6opVyA4gYIXy+8vxAOwEmiOb1jxOmtoddhuFV3tnsHnKcDHvNe+G/aTexxyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZumJcDO31eGmiTafoprDzu2pq+MtdIUbpH3QtjubZzF7Vzlr
	zVymtjtYNl7VQoeP9bakaBscDmA9PgaP83oYgmt6Pl/v5eXLt1lBkeTqKTWw8nZ3sFUJRXJlVRI
	nAhOg2ZBvRY30Drdcv2XwXlgPEC8TQ/Yxj51W
X-Gm-Gg: ASbGnctATuYCqwAWWJuPFV+HM58sgIuhYbTzvklOB67svJtOGefpnamruJ9rBYdVTQ2
	ec0iupANr8ulm57y0xzq0nrB1KGI9MG5QcP55XH713HZ5A2+uBk2D3Y9Hb9wdnuNld3NYsxa570
	qNCzxTnOsfICOz1/VEo/BbU2hmFpFmZWP7RHGjQRScQBfQzWj4djKsJfs1HA3z5lA73dJKwj+re
	EBCoOWNWP90f4dFpJwhvTx4Ebr4rZjT8ve4qZaoc8BxtGD5xBNeTeYE/yD47jPBLwwSLif3vpue
	dN5U5R7JG/GQcp97xlECPNrFPgWtYTdTj8h0Bof9kqUtSyUG0LKvSbOB3zqqBLysJ/nQHpgR/v4
	xOQLaM2vG/9siwjftyMPsOqfeILEKAaU=
X-Google-Smtp-Source: AGHT+IENasqP0ZhtKF05fLncLOW0V3k4buf18cx1cMtCyilYnh1Ti+hR7o9I8wqQWZYLbNuPmDGjdwUp6Ttv
X-Received: by 2002:a05:600c:c4a7:b0:475:d7fe:87a5 with SMTP id 5b1f17b1804b1-475d7fe88b4mr40752065e9.6.1761530588575;
        Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-475dcbe5592sm5859395e9.0.2025.10.26.19.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2F7A0341D24;
	Sun, 26 Oct 2025 20:03:06 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2CC8BE46586; Sun, 26 Oct 2025 20:03:06 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/4] io_uring/uring_cmd: call io_should_terminate_tw() when needed
Date: Sun, 26 Oct 2025 20:03:00 -0600
Message-ID: <20251027020302.822544-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251027020302.822544-1-csander@purestorage.com>
References: <20251027020302.822544-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
it's computed unconditionally in io_uring_cmd_work(). Add a helper
io_uring_cmd_should_terminate_tw() and call it instead of checking
IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
Remove the now unused IO_URING_F_TASK_DEAD.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 fs/fuse/dev_uring.c            | 2 +-
 include/linux/io_uring/cmd.h   | 7 ++++++-
 include/linux/io_uring_types.h | 1 -
 io_uring/uring_cmd.c           | 6 +-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..71b0c9662716 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1214,11 +1214,11 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 
-	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
+	if (!io_uring_cmd_should_terminate_tw(cmd)) {
 		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;
 		}
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7509025b4071..b84b97c21b43 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_CMD_H
 #define _LINUX_IO_URING_CMD_H
 
 #include <uapi/linux/io_uring.h>
-#include <linux/io_uring_types.h>
+#include <linux/io_uring.h>
 #include <linux/blk-mq.h>
 
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
 /* io_uring_cmd is being issued again */
@@ -143,10 +143,15 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
 }
 
+static inline bool io_uring_cmd_should_terminate_tw(struct io_uring_cmd *cmd)
+{
+	return io_should_terminate_tw(cmd_to_io_kiocb(cmd)->ctx);
+}
+
 static inline struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd)
 {
 	return cmd_to_io_kiocb(cmd)->tctx->task;
 }
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c2ea6280901d..278c4a25c9e8 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -37,11 +37,10 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 
 	/* set when uring wants to cancel a previously issued command */
 	IO_URING_F_CANCEL		= (1 << 11),
 	IO_URING_F_COMPAT		= (1 << 12),
-	IO_URING_F_TASK_DEAD		= (1 << 13),
 };
 
 struct io_wq_work_node {
 	struct io_wq_work_node *next;
 };
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d1e3ba62ee8e..35bdac35cf4d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -114,17 +114,13 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
 static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
-
-	if (io_should_terminate_tw(req->ctx))
-		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */
-	ioucmd->task_work_cb(ioucmd, flags);
+	ioucmd->task_work_cb(ioucmd, IO_URING_F_COMPLETE_DEFER);
 }
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb,
 			unsigned flags)
-- 
2.45.2

