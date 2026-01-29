Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696436606D
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726805; cv=none; b=hEN9O/x+CjA01DB6tTzyMoAD7n5RUvvSRoOd4CXmiK9GnhgaHuEJuBkDppNzG2h/drC/eO2EdleLwIQ5d58CnJVuJx7GMJ3ZnEufmzU7qWqAJYPYfv5txGNTuYG+90dWYgOtm4XRnamDVRIyQJARJ2h/6x8tryA5lr8i95XCKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726805; c=relaxed/simple;
	bh=JuyPoYE7z3HLBgfeByBLU9Py+kqJmtHIeOM/fvYhpqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHTsw5IfggjHljn/JMrkOM2zG9F493Jw0xEX1G+te761OIatNByuCllRcRWW40N9w4kXLaTRpns0AwXzmL10fSEQanK7zv0aEoco4m0g5B0PyMBco/FejNDPLsVH5ShIt4A+BAYXxvduyYxYHU4bOhf0McCZVrww4ZOgucdmgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FY8q18pg; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FY8q18pg"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-644746e3793so7744d50.3
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769726802; x=1770331602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgzM/bjzSQsfBN2N2MIl2I8sr30VY03/XQyJxra3YSU=;
        b=FY8q18pgBejzl90XrrNPkORBu2HUWCdGdjIbG/RouTEXJKxhm8RDrL2IB5ImiqFCug
         ZcZtOiigSFES8PWCPfOOCImoXsIw76MPI01DfUp9IqJ3X0lyhiBrPUrDl06kQbd5t2ZS
         87xhOKIzCL/lt6gf8ujxSS8jnM8e/G4I5Ta/8lgRI73PtiEzhs3RXqpbzro0UKRB3klR
         RhDRhCoT2kuHaaJzf0yptAo5v3ExwEBZ6Pk30m535nMI7iGo8vMg/vdChIyA/g2ENLPl
         NF3i4+JVF5ZZ+UrDqbZzm4clmv+MOuW+fX1BtpqijOGcWL1chHVkqB+On8jsCa1UU6aG
         0Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726802; x=1770331602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fgzM/bjzSQsfBN2N2MIl2I8sr30VY03/XQyJxra3YSU=;
        b=etZLcaylEJBVG7edDVSbrdjVb7ZCk8sjZxjh89exJjsoCGdaosoMafaGuHT/WNjC07
         y2a9xr+Kuw0KHWOoelJ3zmdz8XCwUXI1n3Xnin7wYgJf0iYU+8+D/7lBtQhZmSykuhXW
         9c70k0L01rP50/2QoJhSbU4Jm4+VP1aeidDCy3Rv8BHy97ODHCyEswj0dGtxG/Vv2jOe
         JtoGcrP3I/rHGot451UFBmX3xgwTTxRVumRWUtdqu5rzbEtIltpoEsWlWS/zcF7PsB9E
         MyP8LzZuKj65fCWEV7EG3M5wqJmV9HJX59qtlbAq5cw/mls4bVeUzc3GpuJ6knM4FjI4
         ZpcA==
X-Forwarded-Encrypted: i=1; AJvYcCUC/KaTwifUOsMNFI2vhCg015x8U87G3PR7rCtfCvSPfR5zLpPFkEyNkRU3V/PfM8QFojzve+guZpPw9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpNEfzD1rADTvo58BzeOFFLq+uhU+W0iSA1ZKZGPH4JqGWxG2
	OMq/KCbBN7tK9qb+YkU91uTlFSw3G8Z2rXJCKQTU+q6IzktVfFz3eUn5XTIrlPslowxaqOsc0vz
	EipCMYL9tKbVte3x439g8RknDl6eFyqsOkn/Z
X-Gm-Gg: AZuq6aIsmOe8SFvXu9EYZFWr8LusmBj3CWt+woEokmb+Nusz+4dzDbulaozgnty7ESA
	Ki5HYOzFWpgpyLQe83rZNENKJENSu8V6QrQMoxCfH3kqOIpegaiw005tPYd3rZ9GRHNiViciGXE
	2GP3/bxLQIn6pqbtPPUPgAKzlMBRUYbvRW5WYgcQduazCWBaDs3xwPZ+g4J5J5zuVeMgNKtaXFT
	DNAvP8wfU6OOe6QdC2YEhWGYjBVnYYEtL/7b/1kjshLPOr+UM9cKJOUXpMoXunm0uVcmQdA0rY0
	Qz4q7Aa9/Vx8PbsM2KYec2A8ZEAf82WBlSOKVMVemaFa0H7mgxnEx99DAFKJOF9b505tCWNbDlY
	0Ej42DDiedcNWf23eey+26kM1Vc7Kt5ElorkfHtff+w==
X-Received: by 2002:a05:690c:38b:b0:78f:c943:b2f3 with SMTP id 00721157ae682-7949e0082bfmr9678737b3.4.1769726802516;
        Thu, 29 Jan 2026 14:46:42 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7948277e1aasm3617767b3.5.2026.01.29.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:46:42 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EEB37341D32;
	Thu, 29 Jan 2026 15:46:41 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E5603E40971; Thu, 29 Jan 2026 15:46:41 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/4] ublk: drop ublk_ctrl_{start,end}_recovery() header argument
Date: Thu, 29 Jan 2026 15:46:17 -0700
Message-ID: <20260129224618.975401-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260129224618.975401-1-csander@purestorage.com>
References: <20260129224618.975401-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ctrl_start_recovery() and ublk_ctrl_end_recovery() only use their
const struct ublksrv_ctrl_cmd *header arguments to log the dev_id. But
this value is already available in struct ublk_device's ub_number field.
So log ub_number instead and drop the unused header arguments.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 49510216832f..a0d1285d24d1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4773,12 +4773,11 @@ static int ublk_ctrl_set_params(struct ublk_device *ub, u64 addr, u16 len)
 	mutex_unlock(&ub->mutex);
 
 	return ret;
 }
 
-static int ublk_ctrl_start_recovery(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_start_recovery(struct ublk_device *ub)
 {
 	int ret = -EINVAL;
 
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
@@ -4803,31 +4802,30 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	 */
 	if (test_bit(UB_STATE_OPEN, &ub->state) || !ublk_dev_in_recoverable_state(ub)) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
-	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
+	pr_devel("%s: start recovery for dev id %d\n", __func__, ub->ub_number);
 	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
-static int ublk_ctrl_end_recovery(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header, int ublksrv_pid)
+static int ublk_ctrl_end_recovery(struct ublk_device *ub, int ublksrv_pid)
 {
 	int ret = -EINVAL;
 
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
-		 header->dev_id);
+		 ub->ub_number);
 
 	if (wait_for_completion_interruptible(&ub->completion))
 		return -EINTR;
 
 	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
-		 header->dev_id);
+		 ub->ub_number);
 
 	if (ub->ublksrv_tgid != ublksrv_pid)
 		return -EINVAL;
 
 	mutex_lock(&ub->mutex);
@@ -4839,11 +4837,11 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
-			__func__, ublksrv_pid, header->dev_id);
+			__func__, ublksrv_pid, ub->ub_number);
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
 	return ret;
@@ -5185,14 +5183,14 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		break;
 	case UBLK_CMD_SET_PARAMS:
 		ret = ublk_ctrl_set_params(ub, addr, len);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
-		ret = ublk_ctrl_start_recovery(ub, header);
+		ret = ublk_ctrl_start_recovery(ub);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
-		ret = ublk_ctrl_end_recovery(ub, header, data);
+		ret = ublk_ctrl_end_recovery(ub, data);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
 		ublk_ctrl_set_size(ub, data);
 		ret = 0;
 		break;
-- 
2.45.2

