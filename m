Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B12773EE
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625312; cv=none; b=pFGJLnPfzRxTqN7x21CiQ8GUgTlAUPYCCS9miLQTEWBoujKvB2JKOMtWkMLNz2CiNDjIhnHXMzNkfLTkh5R7uhbj+3PcpfLdZw8q+BNwQ6YU56Yu63T/UqXzKNqOw1JeLOX3QZO40eksRBPsLamj+P7VZEiwSuxULHU/FpyUCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625312; c=relaxed/simple;
	bh=yFQfCz9Rtps4/E7qo/hMIjax8jZd30ye8qUXJyXi/Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZinhVfh15js8sPAX4pJzmQCMJD3v/ANzNT4kz/NloXdY9oR2orFEYcnUvBZnYHMigM9G3hm7lPZYzfj3i0c0RanCgN5nAaidMLI1Usy/YXhGMX2WPH6FC9PvCtdN3DVkDoXQS2yQ0urO0fD3QWNr3kAT6TWF2aJCAjwoIJ+Cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gl92UDIj; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gl92UDIj"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7a9fb70f7a9so341959b3a.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 13:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764625307; x=1765230107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnODA/nSVnwUuGroTkDbfXfMnw+yrill5Xwwc4at+HI=;
        b=gl92UDIjal4Vt6SyDRNGlwgaTBIDP5lpxh58zM93h2lM/DsEHWGCX0VNztT1CDK+xg
         Nnv/SSRoF5QMzeaOqQ7kr3Uwjjaoml4lt8dch5U9FlQhrzpFB6eUZCWlkJqL/jcyNIJb
         DhW1xiRR4RwzXC+AY8lXo9eoPgzKPMhZVS02KxqA94I6Om8eXBWng8YRQ6MrCr0MdljN
         6N6VRgeSNpbIj+0geRTgA7kp6pqtqxd0rOakEnpdp486HmEzlniB/kNACX8gU7rSswm5
         JfreL8TG9aCYwrI4U899eaCGRO2kfSwiiGEPQaTEHwwASjDRTolLUaudBxXSF28zOQe8
         FPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625307; x=1765230107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnODA/nSVnwUuGroTkDbfXfMnw+yrill5Xwwc4at+HI=;
        b=grcnTJbLyPdNppUzXvbB+mHqA7k436f5QQGpSZU4Gv/4r4sH4zdORn/vp+FsswxWCT
         /l08Hl4NfWP3sG8Ky6+I14hwJ1WVVfcd/oGZHOQcQWp0g5xf1C3pytmrfUjIqYqXej6b
         cLJBNjH4JiWEj4TsrmM+bYPyUxtfXYb7v4plAFTw5d6RK0S1W1cLdzFOmhFGvWpOgF2+
         Fp7czoyUrVQx9ylwW+iDOqwd+FL4i4F8Xb1YxLHPkHjFCmOzMkbePI864yIZvbY3xTxT
         aXr1y8K7kZhr10XfDb91IEGkqNrCTVYqh4Zx1vej6i7OH7MN6/8u8C7+tjc3YaNqejD/
         PC5A==
X-Forwarded-Encrypted: i=1; AJvYcCUu0WSYA38/ivClN8W03DAwgqyqZgqrmOuEVmz8KcpWHokxkw05WbUvQrIQS4r1Zfbzws9sSrSs+ARORQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFnleyWJSEDpLP0Bsw/ytUD/hrhBgZF60/1KXRYK2eKOehm1p
	fOaxMwFMm+xU2fD1gJgEjwcYO9DPn/H3xhRaZQ1wbF+O6NuR7Za+FxAAj4rUVQw5jgFlTPId/9V
	kQE+zeGXoYAgF4MkiqYB/GGIc8OsTd4oDmEJPxUb0cVqB4YOg7S0z
X-Gm-Gg: ASbGncuf0a6Q4RpGp6weNKw/jM7xALw7cW7wlTOkdR4A4rznU9dtuV1T50Y5pSzTltu
	jHR+6ez/Za+4xlIFD3zA9MJ1x3El5tvMpkDV/r3WvqNvTj7UUK7FYYS7SztzeMfXsTHOz/BBCWC
	9fqyWlqd13x7RnUopjMjbIh58mJ3yRBDkXxZh95gAHbGytK8CP/BW1xZrTAZn+wrE+mA9NkYgMt
	uJBiV7gw5PHeWzhtVgnvI3ovEhDA5BzV7jsNz9YN8+KUjZWlB+K0UoRjiPATQ5wL5RbiwpSJ08K
	poN/tD0bfgN8TSbipyvarG2qzBdardwGFqi4UKonQ6tSlCDQ+KyB/HFl3Gp8CN+UKGkwPZ8SYsR
	V9PzLERpuvJi53xFsDtz6+ysNgy0=
X-Google-Smtp-Source: AGHT+IGhdoJ0rWEut5PwNocj6uSZ3kC1AEB2+wuql1IwB0NPDS4GhlNgxykt52XD7wxG6IL3WwdxNqf/xGHL
X-Received: by 2002:a05:7022:4a6:b0:11a:344f:7a74 with SMTP id a92af1059eb24-11c9d8668f8mr21469721c88.3.1764625307106;
        Mon, 01 Dec 2025 13:41:47 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11dcb03f38fsm1689257c88.6.2025.12.01.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:41:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5C177340185;
	Mon,  1 Dec 2025 14:41:46 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 50CCEE41ABA; Mon,  1 Dec 2025 14:41:46 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue
Date: Mon,  1 Dec 2025 14:41:44 -0700
Message-ID: <20251201214145.3183381-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handling most of the ublksrv_ctrl_cmd opcodes require locking a mutex,
so ublk_ctrl_uring_cmd() bails out with EAGAIN when called with the
IO_URING_F_NONBLOCK issue flag. However, several opcodes can be handled
without blocking:
- UBLK_CMD_GET_QUEUE_AFFINITY
- UBLK_CMD_GET_DEV_INFO
- UBLK_CMD_GET_DEV_INFO2
- UBLK_U_CMD_GET_FEATURES

Handle these opcodes synchronously instead of returning EAGAIN so
io_uring doesn't need to issue the command via the worker thread pool.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c2250172de4c..3d6d5f568779 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3671,19 +3671,33 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 exit:
 	kfree(dev_path);
 	return ret;
 }
 
+static bool ublk_ctrl_uring_cmd_may_sleep(u32 cmd_op)
+{
+	switch (_IOC_NR(cmd_op)) {
+	case UBLK_CMD_GET_QUEUE_AFFINITY:
+	case UBLK_CMD_GET_DEV_INFO:
+	case UBLK_CMD_GET_DEV_INFO2:
+	case _IOC_NR(UBLK_U_CMD_GET_FEATURES):
+		return false;
+	default:
+		return true;
+	}
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	struct ublk_device *ub = NULL;
 	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
 
-	if (issue_flags & IO_URING_F_NONBLOCK)
+	if (ublk_ctrl_uring_cmd_may_sleep(cmd_op) &&
+	    issue_flags & IO_URING_F_NONBLOCK)
 		return -EAGAIN;
 
 	ublk_ctrl_cmd_dump(cmd);
 
 	if (!(issue_flags & IO_URING_F_SQE128))
-- 
2.45.2

