Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498892D2CAD;
	Mon,  5 May 2025 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485204; cv=none; b=GQMRcm723YceGmqdUDARnjwe8/nsSLNnV3c4xO4bpl/uIri9xtuou9tuvVtR4UJo+PBQexWxFbrSHmwHRDfD6JBG44VDLxm/G6ivV09dyKbzNgkUthqF68wO/TqAXopjLpUkcbvdWTtc6h7hWBn73WLmhfO4xxMtdTmAtM108e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485204; c=relaxed/simple;
	bh=aSLgbfzk2HEG9qUqlIxdd5CqAMFUEsWG6Ay2waY87o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S28tzY+Vdxn+sr4xbiwLiYkKJfQNy0oocq75brfHrywhDKv0yDKIaW+uDeZal0LbSF9kOINgCNcRaFmcanCnI9MqTWBGQvr6sxq2exva3+znF/mR93JGpThFh9Vg24cevIbw5596Q6AGsqG7cYFXp15vj0Plz8hO7JltzTOE0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFyvsR83; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFyvsR83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A111C4CEEE;
	Mon,  5 May 2025 22:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485204;
	bh=aSLgbfzk2HEG9qUqlIxdd5CqAMFUEsWG6Ay2waY87o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFyvsR83v2EBMFs2Wh8xm17aSmJI/AkLC+KNFxeLZZr1Xddm8NeYz7gFQeSBYMfTi
	 dr7mnKutX7v87lVm7l5O8/3CkNEm2ZVO2aFkasQpQzeemHsoSRSl0oxMvM3MRYPSb0
	 x0w50tfCP6fZ1YKQTSmr8qhEMEBuvxKbm++qJk8hfa3pLowT7Q5cO9I3VYNMw5ykFE
	 qH8ZO4WP4ftcx2vaXKeZe4EqcpX1S0PWammmsNbx5rDmuV+/oJBQ3Cf0eKcg8sBjK2
	 7/a4/Z9BXPg3Nrn5ybpZ047seOZVc2UnEOH+kNahjnzUNioMfNV2fFcvGEFTQSI1fU
	 UOIjSV6BivFbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 209/486] ublk: enforce ublks_max only for unprivileged devices
Date: Mon,  5 May 2025 18:34:45 -0400
Message-Id: <20250505223922.2682012-209-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit 80bdfbb3545b6f16680a72c825063d08a6b44c7a ]

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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250228-ublks_max-v1-1-04b7379190c0@purestorage.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 42 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 38b9e485e520d..5ec5d580ef506 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -484,15 +484,17 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 
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
 
@@ -2203,7 +2205,8 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	if (ret)
 		goto fail;
 
-	ublks_added++;
+	if (ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV)
+		unprivileged_ublks_added++;
 	return 0;
  fail:
 	put_device(dev);
@@ -2241,12 +2244,17 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 
 static void ublk_remove(struct ublk_device *ub)
 {
+	bool unprivileged;
+
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->stop_work);
 	cancel_work_sync(&ub->quiesce_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
+	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	ublk_put_device(ub);
-	ublks_added--;
+
+	if (unprivileged)
+		unprivileged_ublks_added--;
 }
 
 static struct ublk_device *ublk_get_device_from_id(int idx)
@@ -2495,7 +2503,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		return ret;
 
 	ret = -EACCES;
-	if (ublks_added >= ublks_max)
+	if ((info.flags & UBLK_F_UNPRIVILEGED_DEV) &&
+	    unprivileged_ublks_added >= unprivileged_ublks_max)
 		goto out_unlock;
 
 	ret = -ENOMEM;
@@ -3123,23 +3132,26 @@ static void __exit ublk_exit(void)
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
-- 
2.39.5

