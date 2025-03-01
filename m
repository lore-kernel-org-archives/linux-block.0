Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE216BE3A
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740803515; cv=none; b=joS9OUnC+rSgiCYUonqdSShOS7yndGnEd6HFQNmUI6b0ZwAe4PMguX6fXPpxG7n+iQL633BV/NDuQP44fwV55w2/5sPprfHkiwW2Uwm2AxUowbpnI6VJTj7NWGaATp37qtTXg5gGzJWn5dBYcFA7QP1IpWpA8CywKRmZIvhrYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740803515; c=relaxed/simple;
	bh=TXAPhRB9eitZW5hzeNhONguO8WpLLCE9UoP5i9CZjb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kbVdFIyErSya7IBUhxu3Sz5/sgQdmeLKpYIjQp4xYA9tCBP7JORCYz+PWFYSZeIbckTzCq1paXMsgYYk9UhpHT8M98T4vDpOBCLFXRW7XgFGvTtW8YwVCMWIBlSz/LMSrbvgomD4z+xmfs6YGdGFB3S7cJ1SDdlWI/VPjWrwesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QFBCnVfa; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QFBCnVfa"
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e60b75f8723so916472276.0
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 20:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740803512; x=1741408312; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SgjNXfY52xt38ST5Zng/ohjV9qpw0riaMy6p4zfYhg=;
        b=QFBCnVfa3/rrgWIu39xViaZ0O3fcEoNnUvWhjUB7HeGbbQyuQj7xJ0tostKVxVkdqd
         xrwLIL2nMlTPWcI+SVhfE3EU2zrJKVko2EBXRCVkj2GmuH5JfDkF3vALPbRF+5a7ac1s
         LznIXtdoI1Yd+WEBY7x1yqp8cVdbYM/4+wWTF28upp3OKLl2lpl+MXVPFrGZ+BGP2W6E
         LLq4f4SroJF0VDVOpX1zGleARqhttQK0yH+nzCttbDQE1RpDzURcijsT6ya5DqRfyrUi
         3gaX+GkL9KIfjaDbOD9HYSj1wQW0TyTqH6VLJOHJjKyWbNwESBsnkz2mwIQH57GyPhyo
         V5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740803512; x=1741408312;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SgjNXfY52xt38ST5Zng/ohjV9qpw0riaMy6p4zfYhg=;
        b=wXndMhvT17LKRA0SyWlooimjEyHzJkqA/Q78j2LKEP6T9FDzBSMfVS13/Ck+7/cER1
         DRN28JN8wRh+IwqWffq0TuBAVpsUeb9VaA7FZrao6QpYWIr4Odh8po5FhFE/Ix1Q9cHs
         fulwiXiIRBJdEc393DYs15S3YM1Uu/Djt5/zAOfs0A4xWNRu7H/UZ9/OqcGYCWgSpIAG
         HbNOCrfRw0VXw4p4jevBIOdo3SclaR8yaThsVeo04Kg44Shf4aVtQC0pKlkEA0Jop6Go
         Y/baT/dRr9YZXgKXBuTMfz8DuFxl96wijaQ+yqBpQfUCo3x5c6oHtV+Ukrk2vbYbx8P0
         PXIg==
X-Gm-Message-State: AOJu0YxjB1X8gxWAIQbWAnxmnqlSrqfrzQJV9gWlERChFMhjtzIh6VJu
	4knLpRGmihUGTe1Hv+t081kUxNDBn4HU/+iV8/A/1Jq/9L9VYoT7zL7yj27gWkNUkK0AZ1vCMCy
	ER4bsczjYMofv1GGseBHR/VflR4ID3ZKS
X-Gm-Gg: ASbGncuvJ5Kv4bFaHOQHsUasJTgTMTC0IEZ9qLC3XRXmcxwkHCajfPY1UXPIJf+ka66
	utNAIWelGzgUrG6YWNaiTSVBViiISW/wNCDiuyi1vX3ThbG3dA8UHr9kxSBwBoiUTJ0FjABl4pm
	bjXlXYqKG+FhDojvQ14CGQU8BIXDFzLQCSVOBE/qNHVMNhtZLOcmB+m2QUxhWmwVcIetyWLR9Wa
	g2tGf1upo09/YoofAvc4S2svSfc9mFsOz9dKTZIQKFjK8zoblxLT0a30idBvbAMsinbHaLXufwg
	3QgfAO8D1oiyfb2fJxjFwzBuKYwcIGXvxOp6qdc2dybjDbgRZg==
X-Google-Smtp-Source: AGHT+IHV3BHsYkCPjiiKDyiICH8hCMXjVuE3py7Q1RhTU3b0ZCSiAtBZxbAsAjzCB+g2WX1qUURUr/ogzDSZ
X-Received: by 2002:a05:6902:120c:b0:e5d:bef4:30bb with SMTP id 3f1490d57ef6-e60b2f2ec12mr6323049276.47.1740803512030;
        Fri, 28 Feb 2025 20:31:52 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e60a3aaa869sm249818276.25.2025.02.28.20.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 20:31:52 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6692B340164;
	Fri, 28 Feb 2025 21:31:50 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 5AD56E56F4B; Fri, 28 Feb 2025 21:31:50 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Fri, 28 Feb 2025 21:31:48 -0700
Subject: [PATCH] ublk: enforce ublks_max only for unprivileged devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-ublks_max-v1-1-04b7379190c0@purestorage.com>
X-B4-Tracking: v=1; b=H4sIALONwmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyML3dKknOzi+NzECl0LM+PEVEMToyRTcwsloPqCotS0zAqwWdGxtbU
 AAqR0L1sAAAA=
X-Change-ID: 20250228-ublks_max-863ae142b578
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Mike Christie <michael.christie@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Commit 403ebc877832 ("ublk_drv: add module parameter of ublks_max for
limiting max allowed ublk dev"), claimed ublks_max was added to prevent
a DoS situation with an untrusted user creating too many ublk devices.
If that's the case, ublks_max should only restrict the number of
unprivileged ublk devices in the system. Enforce the limit only for
unprivileged ublk devices, and rename variables accordingly. Leave the
external-facing parameter name unchanged, since changing it may break
systems which use it (but still update its documentation to reflect its
new meaning).

As a result of this change, in a system where there are only normal
(non-unprivileged) devices, the maximum number of such devices is
increased to 1 << MINORBITS, or 1048576. That ought to be enough for
anyone, right?

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8d7d6862a80f519d4f5c0a58d1054ead234d118d..d378d2c9b20217bf3e765bcb4914c457d76b7e33 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -495,15 +495,17 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 
 static DEFINE_MUTEX(ublk_ctl_mutex);
 
+
+#define UBLK_MAX_UBLKS UBLK_MINORS
+
 /*
- * Max ublk devices allowed to add
+ * Max unprivileged ublk devices allowed to add
  *
  * It can be extended to one per-user limit in future or even controlled
  * by cgroup.
  */
-#define UBLK_MAX_UBLKS UBLK_MINORS
-static unsigned int ublks_max = 64;
-static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
+static unsigned int unprivileged_ublks_max = 64;
+static unsigned int unprivileged_ublks_added; /* protected by ublk_ctl_mutex */
 
 static struct miscdevice ublk_misc;
 
@@ -2251,7 +2253,8 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	if (ret)
 		goto fail;
 
-	ublks_added++;
+	if (ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV)
+		unprivileged_ublks_added++;
 	return 0;
  fail:
 	put_device(dev);
@@ -2280,11 +2283,16 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 
 static void ublk_remove(struct ublk_device *ub)
 {
+	bool unprivileged;
+
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
+	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	ublk_put_device(ub);
-	ublks_added--;
+
+	if (unprivileged)
+		unprivileged_ublks_added--;
 }
 
 static struct ublk_device *ublk_get_device_from_id(int idx)
@@ -2549,7 +2557,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		return ret;
 
 	ret = -EACCES;
-	if (ublks_added >= ublks_max)
+	if ((info.flags & UBLK_F_UNPRIVILEGED_DEV) &&
+	    unprivileged_ublks_added >= unprivileged_ublks_max)
 		goto out_unlock;
 
 	ret = -ENOMEM;
@@ -3183,23 +3192,26 @@ static void __exit ublk_exit(void)
 module_init(ublk_init);
 module_exit(ublk_exit);
 
-static int ublk_set_max_ublks(const char *buf, const struct kernel_param *kp)
+static int ublk_set_max_unprivileged_ublks(const char *buf,
+					   const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(buf, kp, 0, UBLK_MAX_UBLKS);
 }
 
-static int ublk_get_max_ublks(char *buf, const struct kernel_param *kp)
+static int ublk_get_max_unprivileged_ublks(char *buf,
+					   const struct kernel_param *kp)
 {
-	return sysfs_emit(buf, "%u\n", ublks_max);
+	return sysfs_emit(buf, "%u\n", unprivileged_ublks_max);
 }
 
-static const struct kernel_param_ops ublk_max_ublks_ops = {
-	.set = ublk_set_max_ublks,
-	.get = ublk_get_max_ublks,
+static const struct kernel_param_ops ublk_max_unprivileged_ublks_ops = {
+	.set = ublk_set_max_unprivileged_ublks,
+	.get = ublk_get_max_unprivileged_ublks,
 };
 
-module_param_cb(ublks_max, &ublk_max_ublks_ops, &ublks_max, 0644);
-MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default: 64)");
+module_param_cb(ublks_max, &ublk_max_unprivileged_ublks_ops,
+		&unprivileged_ublks_max, 0644);
+MODULE_PARM_DESC(ublks_max, "max number of unprivileged ublk devices allowed to add(default: 64)");
 
 MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
 MODULE_DESCRIPTION("Userspace block device");

---
base-commit: 590f25e543b895578e10282b8d8fd0701ceea6ca
change-id: 20250228-ublks_max-863ae142b578

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

