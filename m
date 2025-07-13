Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457161D7E4A
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417275; cv=none; b=PIcbrkcMVZdJ+YB8/EiB42UiJtL89JiaGBVXk5EBydUtiXvDB6vE+Qb3Bj23iRzuM/iu3QmQ2h5UB3+K6I55DOFzWO2e0I5zKZGx++jO6b9oMr2w59oaFZMFL5zX8K2M99oBnFBdEHa0qBMsb4Xnfd8VZcfmrwditV0v1l+y69w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417275; c=relaxed/simple;
	bh=C5ewcjozXHsEBs0FCdMUSqPQQ0nzw1SHRDFf8+dhVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZP22DIz4iGBm9jb/RRAy7HJYn8ITjwseTPFCPbE4lGtMav3w5fbwQcCcsG0t/R5Al4tJOoop8Xk8lBQOzEU5Prnrjqn25uouuDWSOK/o8g2T09+IcPiZxArOPA7C7jiBCQYiC5k4/IqzK7/VodT9mrl9wetAjgADUUzrSm8UyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGpHjB3E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGpHjB3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNWY2IzrEW2dkCh7zB2sFR4yh7Xn8mnFvgBwB9GXGeQ=;
	b=JGpHjB3EbwekueQme8sVjp5zxBDvqs6Da7cq8yibtcba4YWtczbkBPWNCzCCx+irr5qMAr
	NMbPRPTFbW2Xk5pF3KIP/hHsjowUuoM2placzn58sCLvRu9iMCcsq0vHznibnMnE9mlnSo
	HGs9XIYfG5DBp5oNU7o98h15GHGq+uw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-2j8K9vICOWW8AFxVMPLKrQ-1; Sun,
 13 Jul 2025 10:34:28 -0400
X-MC-Unique: 2j8K9vICOWW8AFxVMPLKrQ-1
X-Mimecast-MFC-AGG-ID: 2j8K9vICOWW8AFxVMPLKrQ_1752417267
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 680271956080;
	Sun, 13 Jul 2025 14:34:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8148119560A3;
	Sun, 13 Jul 2025 14:34:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 01/17] ublk: validate ublk server pid
Date: Sun, 13 Jul 2025 22:33:56 +0800
Message-ID: <20250713143415.2857561-2-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

ublk server pid(the `tgid` of the process opening the ublk device) is stored
in `ublk_device->ublksrv_tgid`. This `tgid` is then checked against the
`ublksrv_pid` in `ublk_ctrl_start_dev` and `ublk_ctrl_end_recovery`.

This ensures that correct ublk server pid is stored in device info.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a1a700c7e67a..2b894de29823 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -237,6 +237,7 @@ struct ublk_device {
 	unsigned int		nr_privileged_daemon;
 	struct mutex cancel_mutex;
 	bool canceling;
+	pid_t 	ublksrv_tgid;
 };
 
 /* header of ublk_params */
@@ -1528,6 +1529,7 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
 		return -EBUSY;
 	filp->private_data = ub;
+	ub->ublksrv_tgid = current->tgid;
 	return 0;
 }
 
@@ -1542,6 +1544,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
+	ub->ublksrv_tgid = -1;
 }
 
 static struct gendisk *ublk_get_disk(struct ublk_device *ub)
@@ -2820,6 +2823,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
+	if (ub->ublksrv_tgid != ublksrv_pid)
+		return -EINVAL;
+
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_LIVE ||
 	    test_bit(UB_STATE_USED, &ub->state)) {
@@ -3321,6 +3327,9 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
 		 header->dev_id);
 
+	if (ub->ublksrv_tgid != ublksrv_pid)
+		return -EINVAL;
+
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
-- 
2.47.0

