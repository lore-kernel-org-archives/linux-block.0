Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131142868A7
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775273040; cv=none; b=G5W7rCtaISDYq2U4tdn3lPAPlrbt0WOO7PC4H6STSqK5LhceZKEpVxaU5DxqG+pfC78DDeP0KDvrJcZBO46OraJxyUd9bViAWsBh329IxHWAnrKBm7m+QAYGz6M5KyVB+pBNaIzu01sFFVlmbSZm/SeAykMD9wxG+LlIRKWB+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775273040; c=relaxed/simple;
	bh=GxzP0crHuoLNsQ25wbUfZ0tt2BhG4K8QmO1b7YEBuI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3C02qu5x0x3ljEEXjKtA10Ys57IWjoDaUu9BNrUhHdrsvGI3Odd1a8CXVQdIGQeZr4gC6S9X6b1nRIG0LlnBEOYWf0JqUaAyYYyyVVUrBdLfZFklOo5RK1a477GTFxfJrfa7QvVBzUGkqjWj35YIx58r1LU0QW5qmz/K9NSFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=go8Xio4g; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="go8Xio4g"
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2ba895adfeaso2713961eec.0
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 20:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775273037; x=1775877837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDuvDbXHwkEle99hrrUH04L5WbIEpbGMjepkPBSVZYU=;
        b=go8Xio4ghx3eymfjvTYS/YN/FGss6bGia32mXJuZrDwwHpirJj4oz2ObVWfAqfgTzd
         1dL5+pq4N0Z2o2dVufKBCVqOZTVyfwnCkjIvlgYFGQhD9CRWwECToQVPySRwBZWkcVfd
         xs8ivljxd3vTpXa+x+iwtsKZiUxeEG2QjuSs5TOc8nNLrLg36R4JBus62UY+FvVTXs64
         5L1uwb4dK31WNcjwkDx0M+SIgdoSOUP1OAnU3SLOyXeUyjifc5Y3SyB3s+Dn6Ote3zWL
         WpB12OnuT/nuH7x84kW4ll1wwW0izSDIMlrvHlYCiiOSXqSjSdoBO7zL8HGIQkUeZITJ
         qKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775273037; x=1775877837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDuvDbXHwkEle99hrrUH04L5WbIEpbGMjepkPBSVZYU=;
        b=nRaOqUZKUBj7f1iGHkdUcLQcUJ03ctAt2wvGbMYTfcsOTYHEHh8yQflvpXnkHuVgYV
         WFnkOe2mZ9YDZn6cLhr5VYyT/ygc1BfeUPTHj1mM2zIB73geX2ZhpdCmakrS0zGuEAJ3
         Bq676h7yx2DCcn6BylGbo5Aj2Wlhxh3hF6embapEvcOJUejCaOgO58bhfYQ+XkdwrtQR
         9htgBLZXWWhQl8ZitTmFWc6pTtMe/Ew+pkCkjdZUU5CVywnQc5eEwy71YWw2oLoKapBy
         FZWGVEFjSMKp5HGLoQvAtDGgj2v/yPeIJnxgNmGtrJtDhbP/UrK758GI3a2vqFtKHyB3
         nh6g==
X-Gm-Message-State: AOJu0YxaEVYk2HIdhVE0N5sbq4WBEAUjRHweBGP9bjferbBdQ0OwEnZN
	QnfgusNhJO/o7hZtUuTCA0qkSqZghwpfjJZukoJ0JlTrhhMDfeEo5YkJ/nW8vTbq7F8gw/KjKqz
	5u78JslLA0OG11FojU8feGf3Gs4fzbnVfsEst
X-Gm-Gg: AeBDietfkr0XHJNCtnFb92qA7EVTEE+pwN5T6VmOdJNTUFlvaPywuF44HTLaAFSUCPH
	2sqlxoKIO5R8z0B+xcsCkwsaxHLeNY/BdFQdin7uOT72O49yDE5dTlefxdZHPC005nR0K6lFO+5
	bhg0+kcLD3ZGOnteRcT9JXOXrELfLNLmJEt2jPdXUo0ygR/9jkAD0zImmuGAib9AwL39fJZXdF5
	TwYlYogMzCi59O4lbv9zGmPQAVkchMjOY8nndDwiQObH/YU93H5CnfAOAqEHiHuWmd9hr1yjzF0
	o6vfYs/i04JJM7S69QPXrLP0qFZHX4JFAfmkM4KABwJnqQX85UExyvL+YZPCXoQgA3iNZtO0hpg
	sFvzsTLKcUb412MtPzO3J3T2LAx6B+Zb01ZmrkXmDSlUTu4ATvFxDYnA=
X-Received: by 2002:a05:7300:bc86:b0:2cb:53f5:553e with SMTP id 5a478bee46e88-2cbf64ab2c5mr2500520eec.0.1775273037061;
        Fri, 03 Apr 2026 20:23:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca793f55d3sm518145eec.11.2026.04.03.20.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 20:23:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::2c94])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9F4AA3405EC;
	Fri,  3 Apr 2026 21:23:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id BC324E54EC9; Fri,  3 Apr 2026 21:23:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Fri, 03 Apr 2026 21:23:55 -0600
Subject: [PATCH 1/2] ublk: reset per-IO canceled flag on each fetch
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-cancel-v1-1-86e5a6b3d3af@purestorage.com>
References: <20260403-cancel-v1-0-86e5a6b3d3af@purestorage.com>
In-Reply-To: <20260403-cancel-v1-0-86e5a6b3d3af@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, 
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

