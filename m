Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1F3E3166
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055777; cv=none; b=jxloO5rlJS/jI6ZXOe5LdIDmZUlQfMpnmwtgosC50J/qD6QiSlcdh27QBicxtodn285naj+EiXSWKaDArddHmrQPmPkmGRDg/3u2lEl7l3jneT9tbS35d9V+WeJ9GcjKOqI8MqC54UWnVjwxCW3h8SV+gYfY7bA4U2xFU61dkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055777; c=relaxed/simple;
	bh=hmf510Ov3EeF70DCYYiFhHmFrdUpMkk7KLJ9vm8LokI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fk/6i628zcAa8ZSSLdxX0YdMO7wW0PVHeY3y7rSIe+neLw2LrET4NgwwNZ32QWS7qeDvJia5t8WcH33JdCDK3B0VOhAEM2QxIVTG2p7nTSlbNMaR5fgo1OKMpj06dwCJJmzF8KXfi640XpdpDQWY7m1z0+U7tw0htCWYrId6ps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGBHuQ6i; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGBHuQ6i"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so31681535e9.1
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778055774; x=1778660574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJPWrd8dw3wtAv09ZbzzyDIXa8XSYzZ3K19Z6D/HyDQ=;
        b=lGBHuQ6iDQ+2d8JGHJlDZP9BLt7HakjfojgO/XkyICqIgJ3KMMslXt9JQiZf7aaspV
         GICX14NjQHPg7g0fT49l9aI86JfjjSiVZTf9ocfxYIS7nKc7p6BSS3soSRW7HTzm9se9
         afJOWqGTgzsDdtWULDDq5lhPeV0qm0dwL7SICcjVIonkRCnSMlsdROeTAMlJnpaArBaH
         gEJgV1dX90F640B19h4gZsz/Zi/SBMz0LIDuP+XCYfZr3NOFdwsB24OYbCuuRyypyRqb
         9hlpOxRNkONON3CpvIPFjiiOHMkWMY2PqX1vpX/UyYmYU/L8Dvm+RC9BCsuDQN9+CkZz
         HEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778055774; x=1778660574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJPWrd8dw3wtAv09ZbzzyDIXa8XSYzZ3K19Z6D/HyDQ=;
        b=UzRc7MUEsfBVfMVyO+zfvrqGRc23t7wHAnZv6rBteWrv5ppsDQ54bEKuZmGqWiWB5x
         o28vT7MOtFvgRwJD5szQrcEmQaOC/grUSz7eXwkhQWR0yPligSFOG4ibkAN4UFnTITB+
         xrkLMBfHLQ2ndH6K8ZBpuqsYXkoumtqSkNWf7nZY40NwIm7Q3ob3t246tQS44slfP4Nm
         b3KLzk3/DXX+X3cTjd97gs+vhkM6YTWRc597PA3RV8cMu0Lv+ESduDHcyC5KTOJNSOw+
         uLrAED1qychQIitiN4vkNj+Zg8BciFFgCxLd6zgpx+rrfc/eWf1YLqztgEAeIEzfYSQP
         gchA==
X-Forwarded-Encrypted: i=1; AFNElJ/3DtR2lTMahOhVkB0lheT1qoVBUb2buZDPzAUWFPU2HIwbYQQ8b2L+W4G76SvA05PBiTrrUmK3A8M/zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9igp1WsYh7bH3mJrHDuCL3sdeKPRMZwCLOk/9SqjhyG58letc
	PtYtkUDRAjh2pf0OMPMYvQPwJyfO5hDghGenIc7GmlhGTVRccVlrtpiax8OUbQ==
X-Gm-Gg: AeBDieuF0q1j9mu97aLgTKT1X3imeScG+wi8mfgH13GjjunlFBlrysPlh2eXwQNuE7f
	RQERgvlC3f1AMxIpbSZMG5ymP/7yPvVPkNWq++cJYG9qQKD7haz1geFzqcW16XKoJvF8gH5i+CL
	+35CZW7fjcuFJxFlAdxZdtUKNwmA+QDcgObw2+o3LI41nbmIGqcIHMx9ywSen6vdPnxlbF3/vI7
	kSmqe6D4R7ag5q94ZXA6FcYwsH508BSittVz3iSR1wxFDkk6HM1Jwz3gEZrF01R33KaIr9GVsxw
	yCPNwdOKu5U4y1ePPlp1yxAtX3RctxLf+3BhHaAXPJV4Xlubyx7bx1cOhaeBsMh/oPfgFzDzSXl
	g3BHRsQSPpfV/g8eZrGgdAdX6HU4jNtlghoqcSGCW5XuMILPbrdAxheW1xyToKIKESUB3lpGVgo
	2nC6L1qxlApd5w/zY29bgo1d2fEV9kAE93tj97IO9Wshzzig+uh5OwoCoUu9r4hcc7UTpX5Bag2
	zl94DxNhJOObQeAl0N7Gw5b
X-Received: by 2002:a05:600c:4e0c:b0:48a:55d8:7882 with SMTP id 5b1f17b1804b1-48e51e16e58mr45385535e9.9.1778055774175;
        Wed, 06 May 2026 01:22:54 -0700 (PDT)
Received: from fedora (185-147-212-251.par.as62651.net. [185.147.212.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm33428665e9.5.2026.05.06.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:22:53 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2] ublk: validate physical_bs_shift, io_min_shift and io_opt_shift
Date: Wed,  6 May 2026 16:22:38 +0800
Message-ID: <20260506082238.22363-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_validate_params() checks logical_bs_shift is within
[9, PAGE_SHIFT] but has no upper bound for physical_bs_shift,
io_min_shift, or io_opt_shift. A malicious userspace can set any
of these to a large value (e.g., 44), causing undefined behavior
from `1 << shift` in ublk_ctrl_start_dev() since the result is
stored in 32-bit unsigned int.

Cap all three at ilog2(SZ_256M) (28). 256M is big enough to cover
all practical block sizes, and originates from the maximum physical
block size possible in NVMe (lba_size * (1 + npwg), where npwg is
16-bit).

Also zero out ub->params with memset() when copy_from_user() fails
or ublk_validate_params() returns error, so that no stale or partial
params survive for a subsequent START_DEV to consume.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
V2:
	- zero out ub->params in case of partial copy or validation failure

 drivers/block/ublk_drv.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d10460d29e4a..57ec900f0ce0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -900,6 +900,20 @@ static int ublk_validate_params(const struct ublk_device *ub)
 		if (p->logical_bs_shift > PAGE_SHIFT || p->logical_bs_shift < 9)
 			return -EINVAL;
 
+		/*
+		 * 256M is a reasonable upper bound for physical block size,
+		 * io_min and io_opt; it aligns with the maximum physical
+		 * block size possible in NVMe.
+		 */
+		if (p->physical_bs_shift > ilog2(SZ_256M))
+			return -EINVAL;
+
+		if (p->io_min_shift > ilog2(SZ_256M))
+			return -EINVAL;
+
+		if (p->io_opt_shift > ilog2(SZ_256M))
+			return -EINVAL;
+
 		if (p->logical_bs_shift > p->physical_bs_shift)
 			return -EINVAL;
 
@@ -4992,13 +5006,15 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 		 */
 		ret = -EACCES;
 	} else if (copy_from_user(&ub->params, argp, ph.len)) {
+		/* zero out partial copy so no stale params survive */
+		memset(&ub->params, 0, sizeof(ub->params));
 		ret = -EFAULT;
 	} else {
 		/* clear all we don't support yet */
 		ub->params.types &= UBLK_PARAM_TYPE_ALL;
 		ret = ublk_validate_params(ub);
 		if (ret)
-			ub->params.types = 0;
+			memset(&ub->params, 0, sizeof(ub->params));
 	}
 	mutex_unlock(&ub->mutex);
 
-- 
2.53.0

