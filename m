Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2630B536;
	Mon,  9 Feb 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625810; cv=none; b=gLb2nnE0THUv+oXHH3RnLKLrE+EHLQ0tcFuG3jxVEQT1sJ3DUW0zEra+axwKEPoDncsR2bT8EL3S7Z+9aC1s9Ltq+TrDAj4kFmT6E2tIP+AZNRJPlPBdPgre0A9zejuLQSp+/t49HbSc4BmdXzZAzKvJUyn/LvCXOWTc/SmmoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625810; c=relaxed/simple;
	bh=WxhlLRcQZA1fFOo6S0CCP91q007hIkuVTKBx5+PJ95c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp3wSkoTFOcXVMnO5DIbUzWnPGCVYk8tjqt0bhvQIIHnSgDXDfZiQA/4yU3ptSFbF9Q70PpjUY1ANw4+uOTNF+fePEbGLIIAQbnz1gIvu8pShurTmSRGZF64IVCDtiY1MxKVONrifHfnZJzWfRR0v62eq80szvsglC6HhfgndY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C11DC116C6;
	Mon,  9 Feb 2026 08:30:07 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	sven@kernel.org,
	j@jannau.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yukuai@fnnas.com
Subject: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after nvme_unfreeze
Date: Mon,  9 Feb 2026 16:29:52 +0800
Message-ID: <20260209082953.3053721-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209082953.3053721-1-yukuai@fnnas.com>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
When the queue is already frozen before this call (from nvme_start_freeze
in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
only decrements it to 1, leaving the queue still frozen when
debugfs_create_files() is called.

This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
debugfs_create_files() and risks deadlock.

Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
so the queue is unfrozen before the call, allowing the internal
freeze/unfreeze to work correctly.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 drivers/nvme/host/apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 15b3d07f8ccd..1835753ad91a 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	nvme_unquiesce_io_queues(&anv->ctrl);
 	nvme_wait_freeze(&anv->ctrl);
-	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
 	nvme_unfreeze(&anv->ctrl);
+	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
 
 	if (!nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_LIVE)) {
 		dev_warn(anv->ctrl.device,
-- 
2.51.0

