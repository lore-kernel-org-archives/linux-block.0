Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314539E17A
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634618; cv=none; b=QyaJfyoGeti8wWDS2ucps+a9HDVFoB1LjOPTP6yIgn4tFU9XC8/JPjDBI6epTYvifx+IT+3w4IMd9jj3vqIqcIE+JAe9w0SVjt3UdqtbpKSug/128e1HIZFJnH9rhgpbJZMdm1G7RNXtoe3ac31wkrV1AXx3W+U4s3QX25++6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634618; c=relaxed/simple;
	bh=WMySMhSY1HbZtrRGZKBa7H8/7kI9ofQUKDZwuaJwjnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kL9YYXhYhE/Afyc/HKB/QhOEhdDz7jPLuihGNL4hK6pygPkqJoZKv4YsV3Sky7fWQIe+cruCDFK5mhOVu+WCdoBxSPA8IHsc4eYRO4Z241f2N3W2Z0sERAD6nDZVxk8CTRmmuCTO3bB7tA8Alg+vbZ4ys4Kka1WLn0icjgKkZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7sEYLEA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7sEYLEA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so18267275e9.2
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 04:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777634615; x=1778239415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctKDfUxcBJv5xHYKM/TY8s/R9Ax+DgkJmDB04pWI6HA=;
        b=g7sEYLEAfmLw6XPZbQvyUL71aHhlX66+L74YEpA3u593ahyx5g4QK4IsagUx51D/nh
         tTWuDViV4PEc99b6lcCFA2CZ2bnn47Iw2MaRlnwobE/MyPav3wD9qOwzDDX/DlrUS8Xz
         TfKmy3RsG61pCCvkbC/zjt9ICYMtHJJGRnrRlCD9GstPJzCDBcroT+B7dwu1KZXuc7SM
         rN2hVREISmnIAMN2c9FcwLnTlGFuhho9tCA7xDADXr8i67ca3a+SG1hMOCzG2Wu+lH6U
         ZKGEnXPktWYsTBn3NDPD/jFgrH97xZfHqXsDw5tOexD/DAT6qgUVRVLG2O0VOtUJNQua
         J2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634615; x=1778239415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctKDfUxcBJv5xHYKM/TY8s/R9Ax+DgkJmDB04pWI6HA=;
        b=nEJhUyf5tD6jzBcwY1d0R8n+IlVuclvXRjqMbhLFPNvoL2hUPRg/9KLSZmKh2ZeA8q
         y43vy3KVmq3Rj99BH6HIva5HdJrSVXxNPZ9wTbQfEV4Hma1Ea+i5hdOJMqkPlXA18KVX
         JuyBOhD7L2LtB8OAAbH0eDC80DgCERfRjIpomgM5lNcAIzk8Hf7hNh3Kdpv7vPHx7Dag
         YwSuqOZl4LiidIlUIb+peH61tsCP8KC2U7wbP96bYgCQuHAUFr5M5h7c+tvn48+o7vI7
         CgUgMBmMjlee/f3HMXU9fp9g3X4WWKqHygoWGRxOJZPh89RdjApCjvuHCuOmFlqy2myT
         DSbA==
X-Forwarded-Encrypted: i=1; AFNElJ8KtwNJYgNGdWdzkqlDdggGNjEW6X5UQx3g+9p+YR4fb6iLdDebdINFyxuKw+nA/rFm0uRmCXOShbNHTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeX/J1zHFVKV6CsmFour8TzKW9i4eOYw32+py07LZdPdlcgDY6
	04ec1oyNtDn5+uNuUyd5n3C3HaVVDan++vT7psyZJCPqXHjXzeObi5Lm
X-Gm-Gg: AeBDiesL1vWeN5v+Q3DqzMcu36uRNooQepoSw2fRRjPuIdqsj1upOrM9lN5JrFU5e2t
	FTxgMeE2YHhTZ0O2DnYEb4G+3Ei9pB8MKNH3wv2kpUQqXO9Cpv7Z1kQRle6BCj2ptrb2fDbOC73
	+IwJuOLTT4jtVbXUQvBTgIz8cJ9ZXzlX3pdTHcclsyQpfh3mGeZP/fsZ2vACbYoRQvNXuMQbPRn
	w8MNlavzC79kWAbv58LGwKXBdJmCaX1kOnqJNuRpSwXp4fwZKeDPDHdUHET+NMn85jv36aLS4fy
	5c+hXuksxOFZa2LIVixN1GwXceZJaNQ9FkfvaQ2hnXz6xnIu5pgybkv8H2BEOG7LMFKxPCLuz5w
	QQPZYulms3DpB1kiVinsQt/uemVwaHWdLy4IqR1wAFRWo6gl4GfZyLpX79TgQ6nAG0C1uc2JTco
	5jA2EEmmqI0e3B2hx6GimrS3IBwUc0+OluzE+uJPymdcQssKSez92fC7/ivCH/AdTsgiUBuJN+Y
	vs5PLX1D95gUbICOxc=
X-Received: by 2002:a05:600c:4645:b0:48a:8cb6:88b9 with SMTP id 5b1f17b1804b1-48a8cb68911mr32091255e9.22.1777634615182;
        Fri, 01 May 2026 04:23:35 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8feef7d5sm11320215e9.27.2026.05.01.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:23:34 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] ublk: don't issue uring_cmd from fallback task work
Date: Fri,  1 May 2026 19:23:12 +0800
Message-ID: <20260501112312.947327-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

When ublk_ch_uring_cmd_cb() runs as fallback task work (e.g., because
the submitting task is exiting), the command should not be issued as
current is a kworker, not the daemon task. This can cause io->task
to capture the wrong task in __ublk_fetch(), leading to a task
mismatch warning in ublk_uring_cmd_cancel_fn().

Check tw.cancel and return -ECANCELED instead of issuing the command
from fallback context.

Fixes: 3421c7f68bba ("ublk: make sure io cmd handled in submitter task context")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8e5f3738c203..d10460d29e4a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3496,8 +3496,10 @@ static void ublk_ch_uring_cmd_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
 	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
-	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
+	int ret = -ECANCELED;
 
+	if (!tw.cancel)
+		ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
 	if (ret != -EIOCBQUEUED)
 		io_uring_cmd_done(cmd, ret, issue_flags);
 }
-- 
2.53.0

