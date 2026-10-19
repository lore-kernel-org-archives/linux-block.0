Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1E489875
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399371; cv=none; b=aIIIbCMnHCLK/41tM3d2cnee3fvY30QOm2Cg1tW8wwCEEhWPw51kP+MeJ7bj+yb9j1pmpHU2OQFzTltuTSvY2FQnbSFDadExu1tdDuRx5A/kNkKwAHdd5Ka3C5j6ulQN4d8Bes+fofhz57Cyv0CLP/HgBtK4rbNzN1h6sNd/SD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399371; c=relaxed/simple;
	bh=ksNUGRQT9LCU43qV3CKM4g8h+dZB1R858d69Z1SgGT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMEessF7otbV+eIPrEyq0qQiAKtJ1lKx/kmUkNTcUMrRxZgtGDrfBfn+F6fUJAV1FtV/9sA6dtKUJsCTRgF5Eds8+2PwvcMKVb/XcoPnwAqGcgm8k8pcvjyllDnR91L1XpAtm9p8dt6mI5wArL+v0YDC0rJWkuYAMS0QKNHB3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vajxFgf1; arc=none smtp.client-ip=95.215.58.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vajxFgf1"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ksNUGRQT9LCU43qV3CKM4g8h+dZB1R858d69Z1SgGT0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792399368; v=1; x=1793004168;
 b=vajxFgf1jE7DEzPRWRfZdXJ3VHtisUKgjJ7ex0zRxJnjqRzsLsTHjoty6qP+hFb8CBVqERkt
 x/v8ge6V/khzZd8XE/Sys8n+4kKiV5qekrX7KTuOWTHtl9+N7lyo4DDV9Q1YcnJNETNwDZGLM/n
 jo9aUdI+/REwipv+VKaMk0qI=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 90aed93fe0afca04;
	Mon, 19 Oct 2026 08:42:48 +0000
X-Mizu-Trace-ID: 90aed93fe0afca04
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: josef@toxicpanda.com
Cc: axboe@kernel.dk,
	shuah@kernel.org,
	tom.leiming@gmail.com,
	yukuai@fygo.io,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/4] nbd: reject concurrent device starts
Date: Mon, 19 Oct 2026 16:42:24 +0800
Message-ID: <a9863287183349b2332e8f372e0cc637bdb72d83.1792399225.git.liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792399225.git.liuyun01@kylinos.cn>
References: <cover.1792399225.git.liuyun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Liu <liuyun01@kylinos.cn>

nbd_start_device() drops config_lock while updating the hardware queue
count. Two NBD_DO_IT callers can pass the initial nbd->pid check before
either caller publishes its PID.

After the first caller starts the device, the second caller overwrites
nbd->pid and fails to create the existing sysfs pid attribute with
-EEXIST. The running device then reports the losing caller's PID.

Recheck nbd->pid after reacquiring config_lock and return -EBUSY if
another caller has already started the device. Do this before retrying
the queue update or changing any startup state.

Fixes: 8b428f42f3ed ("nbd: fix lockdep deadlock warning")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..e8e8517fb6c7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1530,6 +1530,10 @@ static int nbd_start_device(struct nbd_device *nbd)
 	blk_mq_update_nr_hw_queues(&nbd->tag_set, num_connections);
 	mutex_lock(&nbd->config_lock);
 
+	/* The device may have been started or reconfigured while unlocked. */
+	if (nbd->pid)
+		return -EBUSY;
+
 	/* if another code path updated nr_hw_queues, retry until succeed */
 	if (num_connections != config->num_connections) {
 		num_connections = config->num_connections;
