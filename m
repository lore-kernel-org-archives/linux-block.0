Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205881;
	b=OMlnN+wS03slS/KSjO2lBck4RSH1dcUP5OzPfQpvH3KPBMXhgqr51p9glSUiPg1M6iDF
	 s+Abc8mKaFtxpfsYOFo6+z0sq4KyNd+fYI+QuFhWsJwqKGtaFQF1HlOyvj549eRsV/uom
	 q/ic6YExZ7MIU52/1yuz/8Z+UQuuX0srjSidOWBviEqTgFET7m0xr4reNfdVBlY0XpFWf
	 aJ9APfvkDpi69FHha9tRV0uIwVZLQGb9F/JODMj1iNZ+5KxNeLDBY7DYTyQ19nQAkvYMs
	 xXEOJz5ru49pOVhFZHpneFe0QXhRFrWu0iTdRlaYAiePxLuVFfOgQ5N6/uLH9vIsn9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=33+ynEUywcAdLhtkebxUby9NaO2HGzajRiZm4XTL4Sc=;
	b=hFmuboMpzmq3T5MTEpmR5QCdneHb36wIsn4nq2m6fbM8K77nEBWvHFynOo0tYOOP3u77
	 JC7y5aH6UHuOkgWPqjoEnNNemLzHJhqeRqjgOw6Ds/BYb45pTHP2ICIoIIoRJtFljMSiO
	 X1aklBLm+8NgGlNiZe2T15sFCcJEaqzEs6PZwJueiwjV4LQ0tkMzvoAbGpJ4dKiU+XjsS
	 CEhdzxQxo9MdjtV9Az4Tiqm9V4A4LLwKL79hMIog4yGikkZL+BWfiaB21+Rsv61BB/Mo9
	 ZjE9me/ckiiE4NeBdeJHYhRsNmqOSmEM9wMCUy/YYjYISiNl5XGmv6c++7npjTrHhmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AfTEeHUT;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D8606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4D8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AfTEeHUT
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8470d7d430fso575670a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205880; x=1793810680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33+ynEUywcAdLhtkebxUby9NaO2HGzajRiZm4XTL4Sc=;
        b=AfTEeHUTLS+bgHoE59ZKWeu2J8B7F+MboY2bPMrRB5nmBOvRAvMxfKxfCAG9jwsSpM
         21fYqg8KIfrvB1gLebknvqr/ztyzR/p5EB67gVtcAUQ1ccp9+6fhLJ8zEU93WjTp1JT1
         y09CHBh0Vkc5T8bhPLXG5EoQws0M3MR/qTMGSFQmQp6Vshnuo3AxV6PCi5WeRP+lctox
         uPa+vvOFSMlEqoUDIXN1v6EwzZaQVsq9h71oCYGUkyQlBTC5qzE/FftlSRK20ILTTJ/J
         y5aGRCshbsOezfaS3EfsSvq4uJ7Y2IuUXKOD7BJdyNiDjZrOkXh+TtqLjKrm4rwZjFWo
         +boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205880; x=1793810680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=33+ynEUywcAdLhtkebxUby9NaO2HGzajRiZm4XTL4Sc=;
        b=C1nWePCNxPnytzeGDso8mRKrDKW+EXfw7n4kZCgU1Yr0vDockMAuxqV68bidpzvQiL
         w7HY1z4vKA3oNBmCQSXGpVoNpsf/E3Cy5gIOQ9QP7BrsuvnlwmMUuFgAy0SQiUO8ErA8
         8Wh9qHvx5RbGN8NE0T2aMrk8DayegQJ81I5Dbsg9YTCpm6sj4R+qSXvpRUtYq8KDu5fp
         ImMbsV1P5t4HXmbWtPWwZIdjQQRtWO+28G7BRhs8jpjUtNzXcWQyCy5LtLLauY8kxF5d
         5i8jbqWK+/lPfxxCkSUFMRIiJQKu1f8gjMq0ktBHynNcJoULs43y572jK8t1JM5dEri2
         XyzA==
X-Gm-Message-State: AFq9FYI3wpXzVWl25r4kk3cgptI7KirFxemqUUXIqulll2aY4Zy97X5Y
	/aXzdrAreTfiwAOYv7+1iQmxmroRtuJRdz1+4cr3XgB1GkjAzZdTDOzCyEJN6jeDbxA1ngTg0mq
	ButNWN4s=
X-Gm-Gg: AYBFou3NUZFIU4OjLihXefzVQ1xGMMfugqVhMAs9NKjdOtuxGwSyC6d+V7fL9WFRCTL
	vgc9Gbj4G1D4zoZIrKeKkmi8pHozROL63bf+7d5OdQmGTUTMqc4TnV6XnTxLZZaTv4j/xVpuSYg
	2OZc5fGhFMa7sJmWo1xIu49AE93WG9zE7o8rpdRCXa6oNkVkPmmmmbRv/rBTg2UVskQSsz3Ymrv
	Rk4Rn8y6wLkdKxfjo44J7mLtUOHB7WAEyEJzyj/d3xHdeKoBP7xN0lgvuIfEY0vzq8NuGVFS+di
	zZtJaMpAhk8QzG0t4+kj9DDdMOOMkKBhs5cZU6/+xF5Qjoior77waoxjAWUchIkcpY0qsc5nGPn
	6dp1RmNPkYXwv2C9W8oXcC7rBLNoHSP7KbaM/Tl9Qmlx9cJH1lPLiW/hiHQfPLSXZhAGe0VFxh3
	EHl38yM9xotrypkehxtyL3d8Q2lweLquOn5XhBsbjWCMngAZia/nvE+/IqIqzpTzWfhGQOXZKwG
	bzJY0dLs/4WfuDmXSW0dNFfg39MLfHwBhviRJiR+5Y/NhP2AOqT4VOnTyicc5nzc/qmzhs+qWx+
	I1f75O7mhMj60Uc/DMIcWdTqJRrxB/OMmRRr37AAA8TzSU1OA69LX0vaNoeJE8hABzckuksXQQ=
	=
X-Received: by 2002:a05:6830:2306:b0:7fa:ab72:9df9 with SMTP id 46e09a7af769-85aba32a04bmr2571630a34.17.1793205880481;
        Wed, 28 Oct 2026 09:44:40 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/98] block/rnbd-srv: drop the sess_dev kobject unlocked
Date: Wed, 28 Oct 2026 10:41:20 -0600
Message-ID: <20261028164415.1262013-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

rnbd_srv_create_dev_session_sysfs() drops the kobject reference when it
fails. The release function is rnbd_destroy_sess_dev(), which takes
srv_dev->lock, and the caller holds that lock: the worker deadlocks on
itself. A client opening one device as "ram0" and "./ram0" gets there
through -EEXIST from kobject_add().

Have process_msg_open() drop the reference after releasing the lock, and
leave the rest of the cleanup to the release function.

Fixes: 8cee532f469b ("block/rnbd: server: sysfs interface functions")
Fixes: d3a95ccaaf4d ("block/rnbd: call kobject_put in the failure path")
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 12 ++++++------
 drivers/block/rnbd/rnbd-srv.c       |  8 +++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 33d5d1738be5..9d00c42f2624 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -193,6 +193,10 @@ static const struct kobj_type rnbd_srv_sess_dev_ktype = {
 	.release	= rnbd_srv_sess_dev_release,
 };
 
+/*
+ * On failure the caller has to drop the reference of the kobject. The release
+ * function takes the lock of the device, which the caller holds here.
+ */
 int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev)
 {
 	int ret;
@@ -200,17 +204,13 @@ int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev)
 	ret = kobject_init_and_add(&sess_dev->kobj, &rnbd_srv_sess_dev_ktype,
 				   sess_dev->dev->dev_sessions_kobj, "%s",
 				   sess_dev->sess->sessname);
-	if (ret) {
-		kobject_put(&sess_dev->kobj);
+	if (ret)
 		return ret;
-	}
 
 	ret = sysfs_create_group(&sess_dev->kobj,
 				 &rnbd_srv_default_dev_session_attr_group);
-	if (ret) {
+	if (ret)
 		kobject_del(&sess_dev->kobj);
-		kobject_put(&sess_dev->kobj);
-	}
 
 	return ret;
 }
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 2b0619389fc9..1e3de82fd70b 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -590,6 +590,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 		return sdev;
 
 	kref_init(&sdev->kref);
+	INIT_LIST_HEAD(&sdev->dev_list);
 
 	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
 
@@ -789,7 +790,12 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		rnbd_srv_err(srv_sess_dev,
 			      "Opening device failed, failed to create dev client sysfs files, err: %d\n",
 			      ret);
-		goto free_srv_sess_dev;
+		/*
+		 * rnbd_destroy_sess_dev() undoes everything down to the open
+		 * of the block device.
+		 */
+		kobject_put(&srv_sess_dev->kobj);
+		goto free_path;
 	}
 
 	list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
-- 
2.56.0

