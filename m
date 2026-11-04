Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793820316;
	b=islX4t1NWir+KPEBozvBuMl5vTj0364Knb6j+wvhsEPPsZA9w4NC9LhJoxEQAqC2b73a
	 Pbi0kCalCwAskekRCxLTJZ0LO9rNRGETN+TbTpn9tS7/APim4/XjE7wDXy2LzpN+hc1iO
	 1iGeRRfU9m2e/h5YJPvsqELuUCCrvHJOjTSZIdEeAEpmF3lE5HaR9IbhAzcT058BfipKR
	 PTAClXessPpQxjkMcRtp2/iF3+fW7VGwCqZ92Npf+9ZtlzcKSowCIxK6hwkhmY8WT4If1
	 tf86XjUHOY7rD8C+sKmR6qubEGdjDerETz0CEws4zrqQAGLL8dKa5lDbzMVRpfmtZYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820316;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+5bZu1eNDxT+h/X926N8ObB9yoVZbilGy5OTDJHDUEo=;
	b=BZ6KEgrJrL24xi8SjvcdWhZmnfvcV9/QMxSLv/IN9N27PWhgPQbyr52OyqtIv5wNTcel
	 0gHIynjBeucsTClyd6n+agdFFIe2DfdwZPSGbOZMM3oVzF42vGw4H7ngL/jr5rDfJp0jr
	 hpd/iQsXlcwLF5JEZi83hPrRTURio98EqMIDEYuaA/svsbdc0iQsuc9RHFvVGducvV4yR
	 z7zpJwMjoN3OdZO8Pel52uKwIbualjgZJRBZJKz6UbNGa/Ow6D6zjCYPk3SuZDZ6TKfSv
	 Pup0RVhgBcdsaq0LQIKBIncYLfePuJPQHjN2NqrYe/+0Fu1EdmTDz1zRQUrrRj3Gyjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhQJjALP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083060807B4;
	Wed,  4 Nov 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhQJjALP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793820315;
	b=vgsOFo7NvJhwqw1G172B68bCLyck66taBVvoOi34qPJbD+KUJ56jTS91/TBV+19emxJH
	 2XyjW2HjlqZov1d8HFlA9ddAmtRNMW4H0HE5bfFxWGHnzKWtUReYcmITmcTmMaWyhqZW/
	 DbGj8ckdYT1hw69mROt4lrLbewPEMTQArayyWB0CAT/m5ZR9II7NChSRUjH9swzMttJpr
	 ORd5PLmfba5o3cAUl3pIfUXRuqD+xE3i/U1SrcjHnf6LNrWBcDFR2RutkzRhL+DREz0Ch
	 6wB+pSVV0wG7YRer9MgcMtFL2uvn8LMQuk1SOCNrGBXDeE887EVTOHBPAImo2aXUWuw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793820315;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+5bZu1eNDxT+h/X926N8ObB9yoVZbilGy5OTDJHDUEo=;
	b=E2N23nm2wv0mamDfEdZ6iG0SCu3aoageUOt3PLwzJcXlJMF1Iz5xTjveR/UypfUDtadg
	 SlVqUEneWz1yY1NOpwRJv3Qimi9SF9xw8jiDLTkMh5v4q8UZT52j7mK2cF7/4OTFBtQ5h
	 1lsTdayfScCV1IH/wET49jNngFU9A9IWmTYaMneNp30zf29up4tebXd6c+EryhcHMolH4
	 ryOfVLp9c13TrppUWHJzTJrSe5SIS5OeaoCa/9K/Ci95FT7qyTM3+g4qukLZWDQcvjswf
	 P+hyXiOA6Hk/pyySgJK0rX/8EHx36H2Ijh3VrUEUYYnW52fMHN0RJ5Cp2x8cTsTweMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DA2041F00A27;
	Wed,  4 Nov 2026 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820315;
	bh=+5bZu1eNDxT+h/X926N8ObB9yoVZbilGy5OTDJHDUEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EhQJjALPww3wrqrPE44qPmw3vfWaIJYQ7/hD56OvMP1efjZrezKYJ2OvfeWtE1XRh
	 DeqcouhjklqMUn/SvaAZiwoppvWjrwNsjIFRmp9RqOIkULAC3CKKaQAII1VhgT53Zo
	 IDa/kewQjc8euFuVG945yGu/KW1Wb3TdcCu8/XmX5FdLN7oYCGUQu2IbR8V9dhJsqS
	 FrvwYaYA9OSDPTefYO9FtSShwnKdYem4vM++PbiX7Bh487BKUzDyeTeLJ20jVxwun1
	 klLRq39cTL5VTeYNnUWMB/3wGWUySLA/unaKQXA7eLl/itIDO3BW4m317z11YJcdOV
	 88zb+1is98Alg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4EEC446F62;
	Wed,  4 Nov 2026 19:25:06 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 00:25:06 +0500
Subject: [PATCH 2/2] ublk: don't take ublk_ctl_mutex in DEL_DEV
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-ublk-del-gendisk-hang-v1-2-913a91a4314d@gmail.com>
References: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
In-Reply-To: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793820305; l=4989;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=rq+V0p9ah2pKCehbSs97gh/beSumuzgTTTAyhHi8BZM=;
 b=O9eOIbxuERP1hL8Q7gLQa3qXQHEASMBS+huKkFqP9unpltD6yK5P6uuGh6wt0Vx1Z+zTig/n3
 VveVbkTf+HcATVEwiBv50BN0YagUNt3baVkzWMAIgTv44bxrzT0VYxT
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com
Content-Transfer-Encoding: 7bit

From: Mark Korenberg <socketpair@gmail.com>

ublk_ctrl_del_dev() holds the global ublk_ctl_mutex across
ublk_remove(). Stopping the device calls del_gendisk(), which syncs the
filesystem on the disk. If that filesystem is stuck, DEL_DEV never
returns, and ADD_DEV and DEL_DEV of every other ublk device wait for
ublk_ctl_mutex behind it, until reboot. This happens with the server
alive, and also when it dies: the release work then hangs in the same
del_gendisk() with ub->mutex held, and DEL_DEV sleeps on ub->mutex
uninterruptibly, holding ublk_ctl_mutex.

DEL_DEV doesn't need the mutex. ADD_DEV is done with the device when
DEL_DEV finds it: the device is found by its id only once it is set up,
since the previous patch. Claiming UB_STATE_DELETED with
test_and_set_bit() lets only one DEL_DEV remove the device, and the
device number is freed under ublk_idr_lock on release. The mutex also
protected unprivileged_ublks_added: make it atomic. ADD_DEV still
checks and increments it under the mutex, so a decrement without it
can only lower the count, and the limit holds.

A second DEL_DEV of the same device used to wait for the first one on
ublk_ctl_mutex. Now it sees UB_STATE_DELETED and, unless it is
DEL_DEV_ASYNC, waits interruptibly for the device number to be freed.
The counter is decremented once the device is removed, so at the limit
ADD_DEV of an unprivileged device fails with -EACCES instead of waiting
for the removal, and the limit is never exceeded, even if the removal
never completes.

Reproducer: XFS on a ublk loop device with an external log on
dm-linear; "dmsetup suspend --nolockfs --noflush" the log device, write
a file and syncfs, SIGKILL the ublk server or not, DEL_DEV the device,
ADD_DEV another one. Before, ADD_DEV hangs on ublk_ctl_mutex until the
log device is resumed. After, it completes; only the DEL_DEV of the
device with the stuck filesystem waits.

Signed-off-by: Mark Korenberg <socketpair@gmail.com>
---
 drivers/block/ublk_drv.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 14d2823a92e5..40f521077bc9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -881,7 +881,8 @@ static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fetch_cmd *fcmd,
  * by cgroup.
  */
 static unsigned int unprivileged_ublks_max = 64;
-static unsigned int unprivileged_ublks_added; /* protected by ublk_ctl_mutex */
+/* checked and incremented under ublk_ctl_mutex, decremented without it */
+static atomic_t unprivileged_ublks_added = ATOMIC_INIT(0);
 
 static struct miscdevice ublk_misc;
 
@@ -4486,7 +4487,7 @@ static int ublk_add_chdev(struct ublk_device *ub)
 		goto fail;
 
 	if (ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV)
-		unprivileged_ublks_added++;
+		atomic_inc(&unprivileged_ublks_added);
 	return 0;
  fail:
 	put_device(dev);
@@ -4518,15 +4519,9 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 
 static void ublk_remove(struct ublk_device *ub)
 {
-	bool unprivileged;
-
 	ublk_stop_dev(ub);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
-	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	ublk_put_device(ub);
-
-	if (unprivileged)
-		unprivileged_ublks_added--;
 }
 
 static struct ublk_device *ublk_get_device_from_id(int idx)
@@ -4916,7 +4911,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 
 	ret = -EACCES;
 	if ((info.flags & UBLK_F_UNPRIVILEGED_DEV) &&
-	    unprivileged_ublks_added >= unprivileged_ublks_max)
+	    atomic_read(&unprivileged_ublks_added) >= unprivileged_ublks_max)
 		goto out_unlock;
 
 	ret = -ENOMEM;
@@ -5042,23 +5037,23 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub, bool wait)
 {
 	struct ublk_device *ub = *p_ub;
 	int idx = ub->ub_number;
-	int ret;
-
-	ret = mutex_lock_killable(&ublk_ctl_mutex);
-	if (ret)
-		return ret;
+	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 
-	if (!test_bit(UB_STATE_DELETED, &ub->state)) {
+	/*
+	 * Don't take ublk_ctl_mutex: stopping the device may wait for the
+	 * filesystem on its disk indefinitely, and ADD_DEV and DEL_DEV of all
+	 * other ublk devices would wait for that too. ADD_DEV is done with the
+	 * device, it is found by its id only then.
+	 */
+	if (!test_and_set_bit(UB_STATE_DELETED, &ub->state)) {
 		ublk_remove(ub);
-		set_bit(UB_STATE_DELETED, &ub->state);
+		if (unprivileged)
+			atomic_dec(&unprivileged_ublks_added);
 	}
 
-	mutex_unlock(&ublk_ctl_mutex);
-
 	/*
-	 * Drop the reference outside ublk_ctl_mutex: if it is the last one,
-	 * the release frees the tag set, which waits for an SRCU grace period,
-	 * and holding the mutex would serialize concurrent deletions on it.
+	 * If this is the last reference, the release frees the tag set, which
+	 * waits for an SRCU grace period.
 	 */
 	*p_ub = NULL;
 	ublk_put_device(ub);

-- 
2.56.0


