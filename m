Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D63630AC
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700589; cv=none; b=JVNx2HrvNZ2WXg5I32fg5Pke+94PMNSZjmF6IvX9WbTQdm2oFbQIxsfDZ65R8CEDbJm0eGdp+lv+0Rdl2UjAKTU/+ee2R4EEH/Jdrg2RJD5bb9oR9QpioYjKl6+YgWtlhQ9IxJ9qtdT7FHMCGo69rVssV+HJ7mWKuzoHkkJt/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700589; c=relaxed/simple;
	bh=Ej+hBWaozkqTfJ4vKiUhC+XVQBaBBPNnqwS2N4rVKJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcHDJQE6Uw5cHH+ofzJpJH+GNR1JQC+iboWoAXNJc9E67EGbHGpGsmUvNuJT/uEbqoQ/e+YKiHGxN8ZOsl/mSP80Juuz13aNfNv++0asG3Sda5bEWDi+mJ0Bt/bBL0/GolesebNwYbcJ5CFJjALQAbOeP5SN7mfuNJRuD68sDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M29oV9GU; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M29oV9GU"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-821a7bee9b2so1049191a34.0
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700587; x=1792305387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyTqb85boO6sjAdVqtm8uviHY4bLTi6KSEdsKIQQNKo=;
        b=M29oV9GUSpkSthqmL+gPzbwERci8a842oYxlE95yjDzCrYUrUTiOipRwbulkCXdJ98
         eOxiRZ56p0/YT6KyGf7i8GUvkJGMdJ+UyXnc72Hbn6GFqCEQmzf04lCEPnAltvEoyMjY
         Hf8N26MWThnDlWDPCGSBK36UglD1mJ2O/0/e+24vzsu9uBVnzrHpyURdhAW+bIreRBZ5
         XGBT6+yvztuDgWa1b+FWOBW0f7VArRg7GeouTX3oZjtNSuRkENeAcKUkgV8cJ4959QS0
         9dckAnm7+TSODOr+54z/Qn3mC9a9yG1zv/2vG2eYGs2HurQeeszAZGq5Nd2u7r95FuPp
         cBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700587; x=1792305387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KyTqb85boO6sjAdVqtm8uviHY4bLTi6KSEdsKIQQNKo=;
        b=C9hhW6D5bQ4QVK904RZnU0kMgvPcQVtHnho3/pqMWbby4YaDUY83WHHyN5R8cm4QSZ
         L7fk2j/CZz2/hr3K5FOBXuaTLvb5peoSAAHIIsnp1h3MqW5b8yHoPF5LELE3ilmsXJtN
         HPFfZp0WmnhcP+0nJBm5fmHgeWDo12x9d3ozoThtb7m079aqs6QbbMoWk1mDJXCqA75c
         shd+n+MkE8Y+ngtUnbwMssBFxcDglS53G5ZbM3lhQ151rcfPahmf/D8mWvPgdRrGzk4s
         F5kPmsC3zkSCvo5R8U0bZQN63Isu6gc/2RgF0HTVJhnDV1C6wcU7i22WG452UADj9j2C
         8pmg==
X-Gm-Message-State: AFq9FYLiI+afx0/RfWA0gw/JSRY18jEqag71UuABUQAaCWi41e0g1NMx
	DqEp9DIL7LNp6vidi7U8FpMkqHNZ+JTU6i9I18lCMu2UOtjLwpYAJLE/MzabNh3a
X-Gm-Gg: AYBFou27aKhIjdF9tTpVIoMlgsFVX1rGGDpvJ9H3F4Or2982uMWuCORvl1mp9sjunA5
	EK3/TEmBHBr3df/tR/gA4DYku+b5jMPYNTBQy37CK7x5Etgku0cdT9pdXRTWK45HvfXdRaFpARP
	A9UdMRx3Itd+LDFMYYYVMUBrpPbxwQkdFxcx+5M3geqgHoYd9PLc8uct/q5Ubs/kEfHaXubp0we
	B2TkSJH1zKACLqQWDrYekNHdwzs5HkhBGB9/ge5QxyzR59IZ2waMfS+lw3CbOZBY4zufnGYESuJ
	SnbAcdRcJVbbKrsHEVkG0FihLF2pleUCFG/Xuhv6qB3C1IB9ZaZCY1RkT4r+nWHal0K0w0NtpCF
	KdTjUb7JDnbBFOBaems88oq9wyxI6+PDzIFO7K95fGvzijsvMZxEJ6ouIlbp3rbAfvLb7Rre9X/
	boGZ/EU80B+2ce5omzsd/0xhn/H/t5W2FEfIZFIDVkxKwTXCcrm6cat5H8WJwGlJtg0pIV9Q0vu
	8pHeDbeqTWEf2reTNKk2D3MNKvylnzocPsiVEzhI7p/zch6OpVJzwCivZsVFjR6azaa2NBaIDY2
	7pX2AcMLIKFz/sL5yPVMs6NN5WU=
X-Received: by 2002:a9d:69ce:0:b0:82a:1141:e62 with SMTP id 46e09a7af769-83029527d51mr3199193a34.20.1791700587438;
        Sat, 10 Oct 2026 23:36:27 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:27 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 06/12] ublk: allow a NULL io->cmd in the cancel callback
Date: Sun, 11 Oct 2026 01:35:49 -0500
Message-ID: <20261011063555.1142277-7-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cancel from the control path, like STOP_DEV's ublk_cancel_dev() after
dropping ub->mutex, takes the command and clears io->cmd under
cancel_lock, then completes it with io_uring_cmd_done(), which takes
uring_lock to remove it from the cancelable list. The server's io_uring
cancel runs ublk_uring_cmd_cancel_fn() under uring_lock in between:

  control path cancel                    io_uring cancel (uring_lock)
  io->cmd = NULL, CANCELED
  io_uring_cmd_done()
    waits for uring_lock                 cmd still on the list
                                         ublk_uring_cmd_cancel_fn(cmd)
                                           io->cmd == NULL: WARN

ublk_cancel_cmd() then sees CANCELED and leaves the command alone, so
nothing is wrong; only warn if io->cmd holds another command.

Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b65b33c1996d..4ff37119a11c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2896,6 +2896,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
+	struct io_uring_cmd *cur;
 	struct task_struct *task;
 	struct ublk_io *io;
 
@@ -2912,7 +2913,9 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 
 	ublk_start_cancel(ubq->dev);
 
-	WARN_ON_ONCE(io->cmd != cmd);
+	/* NULL if a cancel from the control path took it meanwhile */
+	cur = READ_ONCE(io->cmd);
+	WARN_ON_ONCE(cur && cur != cmd);
 	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
-- 
2.55.0

