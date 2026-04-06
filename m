Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451AE30E82D
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775449535; cv=none; b=NgM3DdVni2c6c6COFu9sGR6MdmE2FZ9byeyUIvWO9ypvT44QSw8HNCuJIlfNI6B6yUMai4c7end57P2q8QH8t3XzVcLLKBMDT97jU+z1bFlnzeN3HgDmkJNDsZXzCtawXd4LEbDPei3gHnRIGpJ3m55T/0M7FSvA0JGobMzX+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775449535; c=relaxed/simple;
	bh=NYiNrf1m+usN85Dbh0+F0m5BpO5qZqMWkcz20OKnhR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hW8iNqAKXZ0uzj9jtbH7EMA2Gb3M42maDpFmK8s2+XuX19Nzz33XpUBwPvasCWo7aRy5TZbrLqwyNz6BMCvenUXFZwamDNK2qQpDILbgmdsaL0iv+Q9FLmDpErzI4e4vvINBB6l+L6YX5FYktsg/7rPFSXsB7BiCMf/O1nzIyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NB32vq8q; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NB32vq8q"
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-12bfa7fe691so437009c88.0
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775449532; x=1776054332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62bRSDeTpVA3G/ejEet2ndeFOHy2K2YoDaPpaJqQpXw=;
        b=NB32vq8qk2bdqsJMLO0dqJ4VdjQqInLro20BhHVc9pfQjxAliHmDySbdDJRPeKzJOm
         cTNw0i3tkXND5RmcbYa9r7Vo2TnTcNiWStQgoagp2LCaw0636/NhOLRtXWOuVpbxseta
         sONSfAhrxwkbwfTGPIwPgaTNB8rJafBO78AlbxkiLqMlrLCS/Kx04jCZsgGc18qqhKTI
         yrYBh3gizfzL8TJ9LqK5DGl4d41Vhekm0VjKm/6n+Mwhg8rfIZJnnyank7ZtlijOEuSA
         PIwrXFkkzeSOendVfqFdo8l/Hc5kFDQLti6hBohbGSIR7Yozey9IS/Yvlff4fqGQwEpX
         MwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775449532; x=1776054332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62bRSDeTpVA3G/ejEet2ndeFOHy2K2YoDaPpaJqQpXw=;
        b=jW5q2u2Nw9cKYQkU/ALoNDBayVXfe8KShAyme5t0ASwQUh78Uo8fD3ou7slNUMYum+
         Abo1iTtAMdnkCphgOs5Cck9LxD6xZU5d5WzWtIYKOEzeS25WDie/CFITKcfMe33p2a5/
         DNbDEkCQyumU5JemRSjlZ2rplew5PR0WQ08tEIbI6Vl1VgA2RBiPce7mvZDm6tnnNh1F
         SzgND4zW843iDb+YlhV1oFuHaEJyXbn3XwJUsKqgzp7m8UEXYniDCvw5xbN3Mh+pbl2w
         R0awBRQWBW2Ur7VGjX/gVVzoVbT+6lpD1orgd5fjq+KatRBBFOqjn1s2AVWK3tpNllBF
         iRAw==
X-Gm-Message-State: AOJu0YyKUhaIKF2aurNTLBp2xF3UrdLP/5culyl8Qz7Urwyq7cGSJg3p
	eCMY1FfF73P9gOp6TGlgYpMeuETnPm37sr8BoGFly6/LrxDO/VqWsz1JiMvLdHGln7A4+KVDw/R
	fC6IAMo16V1ZtCOq0P+gF3fhrSD5zNv6svPef
X-Gm-Gg: AeBDievgnlZNBoROvcHj4b7URDigdUu1JeqKINh3a9oNQTZk8mhAyi3UIK7sd4YBU+A
	Pe4SAWQ5YKa+hn4IOYEVgTD69c3dJhJfJ3jEfWFUAqPVQzpKN/7KXS6284igKSPzKHSql6LStBd
	cXFJ/xqNUVjdKIteGU+fBL7lh5zHDjfse8jIbLjgpcLMcc5VmTQ5nwrsU1xwHjN9Apt8XQD8DAc
	B8xHk/opFv/aSi+psDFev8/A2R9x8ikeaITqsK5JkRvDWNzHJ3QyWReOZgAT8RTqf1ZzoXy9z/k
	y+TMWltDBVfQoH9xbaGTHx6FvgRQ15v6ix6mJJaIGUU885tzGtQvmb9B1ON8GeUIGTZtBY1ZYmg
	5hqLmy/k04uYzVprj7pwhMjhasc5MUiHQJhWjDCQU2EKkNJhaEpn8EGw=
X-Received: by 2002:a05:7022:43aa:b0:12a:6c84:6054 with SMTP id a92af1059eb24-12bfb770514mr5207916c88.35.1775449532246;
        Sun, 05 Apr 2026 21:25:32 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12c03576f99sm261142c88.4.2026.04.05.21.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:25:32 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::2c94])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6D05D34018F;
	Sun,  5 Apr 2026 22:25:31 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 56750E4010B; Sun,  5 Apr 2026 22:25:31 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Sun, 05 Apr 2026 22:25:30 -0600
Subject: [PATCH v2 1/2] ublk: reset per-IO canceled flag on each fetch
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-cancel-v2-1-02d711e643c2@purestorage.com>
References: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
In-Reply-To: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, 
 "zhang, the-essence-of-life" <zhangweize9@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

If a ublk server starts recovering devices but dies before issuing fetch
commands for all IOs, cancellation of the fetch commands that were
successfully issued may never complete. This is because the per-IO
canceled flag can remain set even after the fetch for that IO has been
submitted - the per-IO canceled flags for all IOs in a queue are reset
together only once all IOs for that queue have been fetched. So if a
nonempty proper subset of the IOs for a queue are fetched when the ublk
server dies, the IOs in that subset will never successfully be canceled,
as their canceled flags remain set, and this prevents ublk_cancel_cmd
from actually calling io_uring_cmd_done on the commands, despite the
fact that they are outstanding.

Fix this by resetting the per-IO cancel flags immediately when each IO
is fetched instead of waiting for all IOs for the queue (which may never
happen).

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: zhang, the-essence-of-life <zhangweize9@gmail.com>
---
 drivers/block/ublk_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3ba7da94d31499590a06a8b307ed151919a027cb..92dabeb820344107c9fadfae94396082b933d84e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2916,22 +2916,26 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	ublk_cancel_dev(ub);
 }
 
+static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
+{
+	/* UBLK_IO_FLAG_CANCELED can be cleared now */
+	spin_lock(&ubq->cancel_lock);
+	io->flags &= ~UBLK_IO_FLAG_CANCELED;
+	spin_unlock(&ubq->cancel_lock);
+}
+
 /* reset per-queue io flags */
 static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
 {
-	int j;
-
-	/* UBLK_IO_FLAG_CANCELED can be cleared now */
 	spin_lock(&ubq->cancel_lock);
-	for (j = 0; j < ubq->q_depth; j++)
-		ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
 	ubq->canceling = false;
 	spin_unlock(&ubq->cancel_lock);
 	ubq->fail_io = false;
 }
 
 /* device can only be started after all IOs are ready */
-static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
+static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
+	struct ublk_io *io)
 	__must_hold(&ub->mutex)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
@@ -2940,6 +2944,7 @@ static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
 		ub->unprivileged_daemons = true;
 
 	ubq->nr_io_ready++;
+	ublk_reset_io_flags(ubq, io);
 
 	/* Check if this specific queue is now fully ready */
 	if (ublk_queue_ready(ubq)) {
@@ -3202,7 +3207,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 	if (!ret)
 		ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
 	if (!ret)
-		ublk_mark_io_ready(ub, q_id);
+		ublk_mark_io_ready(ub, q_id, io);
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
@@ -3610,7 +3615,7 @@ static int ublk_batch_prep_io(struct ublk_queue *ubq,
 	ublk_io_unlock(io);
 
 	if (!ret)
-		ublk_mark_io_ready(data->ub, ubq->q_id);
+		ublk_mark_io_ready(data->ub, ubq->q_id, io);
 
 	return ret;
 }

-- 
2.34.1

