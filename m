Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AD1A9B46
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518736; cv=none; b=EurXV6DIq6YlDG81IJUDmejc/ALgGJZUzO2Q5+E2FQLTkHXaRWSJHQSv1pcPhPLVocUVOF1WXqFtWOAQIP14sVJrO0yA4bJfPGYqedNfvQ7ZZZUvRl+yMk9ATRnuTrsShHaSmFBfu2gz08Mr/2NquQd3Bz2CSW5ujyqYMUU5PXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518736; c=relaxed/simple;
	bh=6GRv5GkkmkDW85ilHWxPO1Q+hLJLxbHbMJxp7x7FbEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFLX6WLQslUe3Nr3PVlnwhnjQyjEm5TEx9pbBzvtc0O95H5bAkvKagMIyRlGkjvae6Itg/AaCOib10owPY0Jt4nTxGOA1/9m483fGQsvYHZda1CoMv02mvtF2KLtRDuLX4eSY8B+Yky/koK/C65LCaW7W4K1oR9zDesjDn6NbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LxGYy4od; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LxGYy4od"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-855971b5d44so20233339f.0
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740518734; x=1741123534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9HhlrRcc1S9btnxpNw0XGFY9bznftGZITEbOrMrW6Q=;
        b=LxGYy4odxGdpSe2QcnA2MHBd6dOEtHKous/iy3PhvIuqR4dEgDHVnLinQJ/IaP964I
         sHravzzx6YjLTO8AIgj2aNxD6h+GTwpFakVwI3BAqOxEBqnE2bKAgMzbfpe7nWA7/CpN
         HjNcOvgTcn0gnpEX3moggoJLDIDgQFjyDIABPceg1QBUusRTnBW4f6DbjnC5EPCSX7L6
         YL19jXFF0gsueFzsgpEh87iQo2UjQ10zr8AOU6leiN1KgYJ7FtoIc4cGKNShzfAAh9Ge
         vcMsObQa4eZZtpjhTZ9GmNqlbg8p8LplTUD1yz51X8929fmncL8K7h/PkKMaYlbVUmIu
         F2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518734; x=1741123534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9HhlrRcc1S9btnxpNw0XGFY9bznftGZITEbOrMrW6Q=;
        b=J3+cPYNZbvMQFLlMLAk1dI0oIJG0Gt41WkokKDDhzg3RgFGYlOTaPNy1Y4M7k0aOFr
         UtrFWGxuUrV34l/FVkudY5bvZXe4dm/kEavMU0+X+Ix59/y0VAL3G+1rCn5sFQXCl2EN
         /P+dS6x+oqrSi9BfXNBNqy5An1UPeqo8iU9Yf9OlAn8S0vxEbKhDw/Q+LQhguBlAllmD
         oienXhSwhQZDeSPNH5RpTRgE6Dw1eut+CIxMKVTckpPz971QToahmcEZ0rjMBcx8Q8aW
         TVMRJq9S0WfW9yCy2IokZ4Xw/EtZugetfftvlK5QaTmblKuKZ/tDihNXqnINdksnaS5I
         yhTA==
X-Forwarded-Encrypted: i=1; AJvYcCWrfEJIzS4ZIu0gwBfa+CV4A7m4uDxaTH+4FgK5B46K3onv/0L3FB6rOqXvIr+6CT3VN3uWX4/m8gn3wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94+NZQXCGviyOMdNeiUc48+g6u3z5aeLqlvToi/LcfzEl+SqK
	SF8XQ3tCOaTnuL5wJJwwzBOfdTw/ERUGORyny5wORUmW3eBhVHEJv1Wa+gF6qlXi9wfx68+fq/1
	g6NhhO5TzVSJo1yTQVUlMzfKjXGBrBaL72o6spWf1AeLTrAEi
X-Gm-Gg: ASbGncsMLhSFRJ2Oo9sDOa949lknHtYfeFbYByQWaJaoD0VjlebCGbqoJk07rkVtAA1
	g4VeBJNM83xyA5GeJ6k9kvJleGIAK4V0fPCLkYqfhKeYW+ZSuc03sSFcOrjfir//slCx+ZypDvG
	jQ+L6YRJc8JbmF/0f3rBOYd/ByUq7CJoFfxr42rnb7BKNAjRGYKNritfcZV4+UW8m+fjZizv7qj
	ilsWJzZzjW3bNfLHSqmWxeM1Xlc5tIk3lWSh6R7rkbdIeY6lx3XkNFEIFBNqCXXeCUbVW6BbHOf
	9QGBoqq35nRwax/MG/Hl3SUljgj0FNp9Sw==
X-Google-Smtp-Source: AGHT+IF8UXXeus5YhJoPJknmXIZkIyvq5oCcWhAwt/3Kp6Y5QgdoVWzlq85YfoBZmVtowwISRWeJmt6k6Kb4
X-Received: by 2002:a05:6e02:1646:b0:3d0:4ae2:17b6 with SMTP id e9e14a558f8ab-3d2cad72c9fmr50961595ab.0.1740518734315;
        Tue, 25 Feb 2025 13:25:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d361652f36sm1306645ab.26.2025.02.25.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:25:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 676CA3400EA;
	Tue, 25 Feb 2025 14:25:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 62B3CE4144A; Tue, 25 Feb 2025 14:25:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: complete command synchronously on error
Date: Tue, 25 Feb 2025 14:24:55 -0700
Message-ID: <20250225212456.2902549-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of an error, ublk's ->uring_cmd() functions currently return
-EIOCBQUEUED and immediately call io_uring_cmd_done(). -EIOCBQUEUED and
io_uring_cmd_done() are intended for asynchronous completions. For
synchronous completions, the ->uring_cmd() function can just return the
negative return code directly. This skips io_uring_cmd_del_cancelable(),
and deferring the completion to task work. So return the error code
directly from __ublk_ch_uring_cmd() and ublk_ctrl_uring_cmd().

Update ublk_ch_uring_cmd_cb(), which currently ignores the return value
from __ublk_ch_uring_cmd(), to call io_uring_cmd_done() for synchronous
completions.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 529085181f35..ff648c6839c1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1864,14 +1864,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	}
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
  out:
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
-	return -EIOCBQUEUED;
+	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		struct ublk_queue *ubq, int tag, size_t offset)
 {
@@ -1923,11 +1922,14 @@ static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 }
 
 static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
-	ublk_ch_uring_cmd_local(cmd, issue_flags);
+	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
+
+	if (ret != -EIOCBQUEUED)
+		io_uring_cmd_done(cmd, ret, 0, issue_flags);
 }
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
@@ -3054,14 +3056,13 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 
  put_dev:
 	if (ub)
 		ublk_put_device(ub);
  out:
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
 			__func__, ret, cmd->cmd_op, header->dev_id, header->queue_id);
-	return -EIOCBQUEUED;
+	return ret;
 }
 
 static const struct file_operations ublk_ctl_fops = {
 	.open		= nonseekable_open,
 	.uring_cmd      = ublk_ctrl_uring_cmd,
-- 
2.45.2

