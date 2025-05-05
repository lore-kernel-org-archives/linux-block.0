Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727912F73C9;
	Mon,  5 May 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483912; cv=none; b=jXYM6MlludfO3nX3fo8IMf9AOthWfazIySx6jQ+h+1P8m8U0/0rMWUJ3N097dvo7/xBBYj5q8BuW5GcM4OMCJgL+Fgi7dy7SUE7GplQTM7AkfvozuLJ6sMOZN0/lDehzJMGLDARncGzXOGGU+MLjGo1fkhXkbiAb2rPGMBxC8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483912; c=relaxed/simple;
	bh=oDmdADhT7G0gHx6/A/6XvkT1lm8dMOBKkg6iqMVD3Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDeT3EoGtQZrNBjHOELBy+beHjTkgpZyT24zjlsn+O0m7Z0A2oEmQ5Uw85F4ir+QACSKKcyKcE8sOajQwt6pNaB8wz+ZOY5bnkRyGma0tQpzR29Nhoin1g65bdH4V3ohL7iXaXg6dXf9zb6r//nY7wZhNAfO09LAo+AwA+0TYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpVMyxqw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpVMyxqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80481C4CEE4;
	Mon,  5 May 2025 22:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483912;
	bh=oDmdADhT7G0gHx6/A/6XvkT1lm8dMOBKkg6iqMVD3Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpVMyxqw0t7QuzzISHCAgzvWozI/GROQLFYSs+ANKM8xpjkgkRBRJ2vAD3letCqMS
	 5JA+izPmmKMMuxIQP0N4JLD9rapooJObxLsp30X7ciEXcaNSTjz4KhYnBhNGiSLTZI
	 Omyve1Ra8FMFzibjzXfpOeCF4+GGtXxS39vjrFc0EhCWjmdGtwnTFywGgBW7U/1C9e
	 77IYTR+iMeNiXM9QTZUdNomehH2CblLqnlZyajvjbJYZpJa9fI/Uxlzx1SufsunElF
	 /xypuKjGS6ScoK2/AEcdgJPm4HkqwK5UZx3oL29a2YmNSlDWguttnHir3KcwGnFvF1
	 iohT3IOhlOq/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 265/642] ublk: enforce ublks_max only for unprivileged devices
Date: Mon,  5 May 2025 18:08:01 -0400
Message-Id: <20250505221419.2672473-265-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index ab06a7a064fbf..fb770b8b09412 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -499,15 +499,17 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 
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
 
@@ -2294,7 +2296,8 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	if (ret)
 		goto fail;
 
-	ublks_added++;
+	if (ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV)
+		unprivileged_ublks_added++;
 	return 0;
  fail:
 	put_device(dev);
@@ -2323,11 +2326,16 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 
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
@@ -2589,7 +2597,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		return ret;
 
 	ret = -EACCES;
-	if (ublks_added >= ublks_max)
+	if ((info.flags & UBLK_F_UNPRIVILEGED_DEV) &&
+	    unprivileged_ublks_added >= unprivileged_ublks_max)
 		goto out_unlock;
 
 	ret = -ENOMEM;
@@ -3227,23 +3236,26 @@ static void __exit ublk_exit(void)
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

