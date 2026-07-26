Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E21624DF
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077440; cv=none; b=LffAzyUBsL/Wkq3840pezLnEWtHjC75ntyRF1FKxNqM5yBzD4JA89Umm9EA4MhY3F4de89VKzTADxXFC8WdTy/N9Yn9lEBlJTsaxRil6RtvfooS5+39mWuWb1KVzw87RAgEfMLji8ACR5ATPRQpi68xwmxUgzhLjRp252PGfHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077440; c=relaxed/simple;
	bh=OwaQK5ACj6VXXqJS8l4fei+7T8PalV6SBruuV2Qfj20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzA/xbF43TzfwdosCA+Zb8nsv/bWXDaUSpkp7V3W9EY5Is+Nh2yLb3AfFj93WsKXTomVsYxbmMwxDil7yfyKlPCTd9uXizB6ORdO9BSza1BRG/K+vRR4ZaXHWOVhaT1wLa0Gh3+Bb74zhMbX/ZQOW0xCc70Hz0WS2lbIvm0tr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTVd1QKy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTVd1QKy"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5cb052edso147755585a.2
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785077438; x=1785682238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMeSotEc/3ox3Bn2HN8Am2NoxrfVodevyTk9qNPO5Gk=;
        b=jTVd1QKy1xKmNPcdyfmELT6QtpZXzCViEE1RKk5pxAuGJh2c0d5hpbtfR0Q1yDDVb1
         EgZZ6okohJpF1BM5S+kC6sD3Wfhtqz9XXxnYMfMXYmivpDtWMOnYLdHF/3N134H07cjq
         0nQPoT792hLUaRND/qFjFyaNiEYurw1fIzW8Yc9uXSp7YK4QknLugQ+YbevXs6XDNbOf
         9lv86jk9bM0bPx8uMZ4NjSEphGa54aFcdsXqy2RWrrPhKGNlMhA02LE81C05dKI8yVol
         OGFWpnTfhQQRRNaH+8V7x+ggRUrfbDTnxIbAomWV3WCB8hNlZEYMTrVbEixuHPv0hODM
         tOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785077438; x=1785682238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMeSotEc/3ox3Bn2HN8Am2NoxrfVodevyTk9qNPO5Gk=;
        b=T6meKm3sb5sDNw/6sCz3wG7i4fY3VDn6XhU/7BUbEn5YPtSPOUEGHpFS/6VCMR8KSZ
         rgzOoM29tlOsb6ncm7pyj1a0reHANidPXil1J0xTsBIzUr3EUmKMYxwGYLa+2qQHw+Fn
         6DVEYiIV+sR5dNLz5cBxv6x4zC1sh9WcDCvF0Kki5FBFNjl2mna40wT2zlCgWYQGJGrv
         j8otJe6g4ku9Kc1zM0LImj7GKbRzggi8wjxNvHHZ5UT1B4/8Dcf/I4uEZEmneVhCRdOT
         AUXvi9CC7np5CB850IK9QcW8SmEiQgXMQhOxuOi1UH1WcKDt1+WcVG9dDmcKYYG65xJZ
         GaCg==
X-Forwarded-Encrypted: i=1; AHgh+RoM5jWp7wJlQjCbihk1OS9mXUvQ9YaRe8fn5LMKMjOaTGbL956cpiAhLp88JUUEmWDiW+GdDVL3dkxLXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFn9DUwITYPMxmueSyx2Ko+2nwu+DKoZiaO7dJNk4yvTHHGCT
	ORo5IzfMnAIHQKlf29q/l0NY0hTPAps5tgz3x9PcvZhdkwGD5Dzwcrxp
X-Gm-Gg: AR+sD12f5oXRsvq1N6Sxl8ftixkK5HPp9C5te78Y/vmyfkrEryFlnd/IQyl7UIAa0bI
	tcmWcOJgHTtfcdYFOBkIgBTi3XTJ0g0KaHTAqBVMNberxIoWIoN5suxRInwKoPCMKHRxk1kGuDX
	0esqQOrf1J8rkuVHWhHpjQkNeXWft8XK1SpNLBKrjM3y+EwuND8s59Sdyq77REnmeXlPIdqdAQY
	lTtuie40KEqt5JSBS0U8p+uo2qeodtjNAj3fIb5r1t5lt9m68n6NDe504VuJoLJR5S/59ERLcHE
	A5xh/KCwQ8tlJ5O8KAd+ivA7Dt44+dZGZRh+a8xX5DraxkhbXdEzNJWNxhl/E+N3Gev46dfTSfy
	UwA/ff62APBzvBlK5uEhHyhnMW+zmtaLBkcQJk4aVRQS/2ABZ3kx7oUl30VIklSMMPdV/gotShE
	Eq9uu5sqPtESIMOHTcnhjEClK/cU+HcZD7K8H+creMMUXn5DOJVje5Ku/Z126TSaYhhRc6LJ+up
	VbLuFKisqPL91t0eEwxxQ8nBCHdV1xPNw==
X-Received: by 2002:a05:620a:bc7:b0:92b:6805:917e with SMTP id af79cd13be357-932df765487mr509006085a.70.1785077437785;
        Sun, 26 Jul 2026 07:50:37 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de515396sm391642385a.7.2026.07.26.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 07:50:37 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()
Date: Sun, 26 Jul 2026 09:50:25 -0500
Message-ID: <20260726145025.1507383-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ctrl_add_dev() memcpy()s the userspace ublksrv_ctrl_dev_info into
ub->dev_info and then fixes up the fields the driver owns, but misses
->state and ->ublksrv_pid.

A device added with ->state = UBLK_S_DEV_LIVE passes the
"->state != UBLK_S_DEV_DEAD" test that ublk_stop_dev_unlocked() uses as its
proxy for "a disk is attached", while ->ub_disk is still NULL, so DEL_DEV
right after ADD_DEV oopses in del_gendisk().  UBLK_S_DEV_QUIESCED plus
UBLK_F_USER_RECOVERY dies one step earlier, in ublk_force_abort_dev().  A
poisoned ->state also gets START_USER_RECOVERY and the char device
read/write path onto a device that was never started, and wedges START_DEV
at -EEXIST.  A poisoned ->ublksrv_pid just makes GET_DEV_INFO report an
unrelated task as the ublk server.

Reset both after the memcpy(), as ublk_detach_disk() does.  Userspace only
ever reads these back, so correcting them silently breaks nothing.

ADD_DEV has copied ->state in unsanitized since ublk was merged, but back
then it was harmless: the gendisk was allocated during ADD_DEV, and both
teardown and the START_DEV -EEXIST check keyed off disk_live() rather than
->state.  The oops became reachable once the disk allocation moved to
START_DEV and those checks switched to ->state.

Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4ca6ec738c93..2a22f9dc1f2f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4764,6 +4764,15 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	/* update device id */
 	ub->dev_info.dev_id = ub->ub_number;
 
+	/*
+	 * ->state and ->ublksrv_pid are owned by the driver and only read back
+	 * by userspace, but they come from the copied-in dev_info, so reset
+	 * them. Otherwise a device added with ->state != DEAD looks live while
+	 * ->ub_disk is still NULL.
+	 */
+	ub->dev_info.state = UBLK_S_DEV_DEAD;
+	ub->dev_info.ublksrv_pid = -1;
+
 	/*
 	 * 64bit flags will be copied back to userspace as feature
 	 * negotiation result, so have to clear flags which driver
-- 
2.55.0

