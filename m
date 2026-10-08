Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9A443C04
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459572; cv=none; b=hOu5tXobdscFsH5ZrNJPIOm93TzVhqsVd3RZH5DF8r7OxwwbWitpGh/rV3j4VpXDdVWB41dwau/cInc6dWtn5b96f72HSgM/q7QdWj2MOHKVP+5K6xoedwgLvfGU+KR6bqNT4jZ/iQqFt/1BDXKn///ECxjgR3Uorx0dMxn1ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459572; c=relaxed/simple;
	bh=tHDvZ9UTS8z6TVttFHT7It9al88ZCQZC1GqFCkMOQBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVVKXzCxi5GwSZ/PI/L7meHMpPw2IaLzmjnfNbHJNUuU6srThTu9+VEqaJZZ8oWihFM1SwAhH3LlVVO8MmqdIyQkV7fkXYMxLbTzxfuc8tct6YzFRJGnu+pnhEYRC/97/cgu0yl+Y1khqKKGmmgXsBkNuwZNFyC+G6AyTDGxUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pffqVvqd; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pffqVvqd"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-823b938464fso3927483a34.2
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459570; x=1792064370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XIwI/fIIjWk5SS/ctT+NY9VAmffg+AV4sHGpqKh834=;
        b=pffqVvqd2dy+jGphyMltYYiIHjt7dmROqvTsXY9eLYRD6RD5xfpmuegULj/+prWBEg
         q6qrg0sjCmEH5EEbd+QQdnS8cTPhV+8/BpDrsrXSzQGx/nBXTFzYoG0NZf6AN+FCb2nS
         kHG3iq4qQjtvSIAHjTZYUSwi94kRosjR4aRiNwWexVX6DxtRxjsHWrJBWQQGLDxtsR0c
         PM4DC8HPRibk4SF9NVD6blaSY4bLIqRXMN83DXSDENzo+YH02VIjfYycHazNKV61lYOJ
         ywUfMKLFiGUJaNnCuOBT/WQmRMs/FD6KGjscxJgRbvyQUWLu5nn0kItypO4KDjpYKdK7
         No1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459570; x=1792064370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XIwI/fIIjWk5SS/ctT+NY9VAmffg+AV4sHGpqKh834=;
        b=VaFBXn8CIFjhaOWiafMCUl6VUSwAM8/s8n/oTXT6jOqWDGVIZpbtNG+uxbGIdVZEdJ
         Jg1XTmop9YDvGejPvPuk1CnwHnsPsblwcIKiWoSvCQ14U02pdEF17Xd4otoBCGNKmLeU
         jecsk13AP4jqYcLIZpWC54ZG6Nu8wRRLYC26bXIPnKCcwKsfVe7v+esJb8DeRZ4rrU+K
         PmZgxgXp45vA4uCUn6bxTnqXwb4Foo1JmPsLlssBGCK9lZZQgkEg42m4AdLF5hs5qwWu
         wBqI7NNLE4RODhaTWp+Hl1fPpc+FbQDe/sbsy2XJbxxwCI5a2I2j90/Dh7tF5k02S/Ra
         yAQw==
X-Gm-Message-State: AFuF++kPfE8qy9cjwCioBec6EGBIkFtgjOVGwKDs/rFcaWm/VZkGx2o2
	WKfkGIQq/e6Ez6PHIAIuDxw7zKw8mGDQjvAFv2XKnqhvs5++gSv/DJYaNOpUPvnC
X-Gm-Gg: AYBFou2o2ykDo1a3AQTgq9KUlCUz8uoSsxLCW9qsKVo9sGpYDbSIevIIUfOgATncC5b
	MTuO046ZrEbqRDGHSbK9WnkSKMVlq8vPfNXvouw4BSvX0zGKS135C/sbNz174RrhRX3ha91EJ4a
	i5pSGYbF3obKdRiayemq36BtTwUXGWJqLWJ3kNQgDJ2jZCX6Phfuri3G6yFGFpM3TEq9OpiMeQG
	Qq74TrZzeqBwhhY1XC24aUvCyjA0mKShOQFpm3nZ/CLH+DiVHVhX0M+F0wdgHvsdt7YTBG3Im4i
	REr272hFFvkxYvFytFq85BuVvvX/J+l6RbC6S+7gUEKTsM0Pnb6Afw2pFZbrjr8cjiz67BrsX79
	R9dnJ4GIQ1A8vAWDMsC6eNWnWysnw538ttx/9Md2h+SoSg2ogsX9p0KhiKXBIwHbTdDVNncfxPu
	rudNB4/0ImR5Z9IViabv8Xm0xzmImkbjM576PrIZIWXwSGWBlNV8l/S2ZqywB28ZBCq2biM/H5p
	vO9PMDLx6vxo+LQfNDOLo5VPwXHRO35srkzSYC6EJlPE7vvHMEluvTLVCgabVu26lAObnhXhYfk
	Nijpch0OT8pWGnxBrInZO7oFh0s=
X-Received: by 2002:a05:6830:64cc:b0:829:10c4:2c11 with SMTP id 46e09a7af769-82aca19895amr5961649a34.0.1791459570118;
        Thu, 08 Oct 2026 04:39:30 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:29 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 06/11] ublk: allow a NULL io->cmd in the cancel callback
Date: Thu,  8 Oct 2026 06:39:02 -0500
Message-ID: <20261008113907.4000838-7-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
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
index 162a4d1a2e2a..2fd0c265ed20 100644
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

