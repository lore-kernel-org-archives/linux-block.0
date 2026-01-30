Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB713502B3
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793273; cv=none; b=ulKoYzequTUrWdEbUgUNmTZ+O9eXdn2NeTGwGI6Fs4yEmU1frX5mwBSCnf/Q7wYSfN7IMkBCkvKY4uILTOwAN3eMC0ASRfruzc6cL1mP2eL0g39CJM/ork6Pxx01ZWf01UO1YsutUk9wyFL2U/POQTxQVezpckbW4hVTQ+DkJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793273; c=relaxed/simple;
	bh=uH26QxCWKhGjIjs7WgnjKQrwoovULgl956akyEOBsdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYVLTCjmIW9uxyOT7r/H7mfbaYwG8G0WNIguUfLBTFDhKFfp+HXyGAxsxfvHbTexOot8n5KcxOUSqKA4nRf5bBldqgA5E3nIn+XQhjdTC8LB10JfT8h7Bri7Zmn2ioXqQxBMkVbiDF0qvn9MeOviaPaDfzxrbYgmHikTd1v3+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=H36yyUrg; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="H36yyUrg"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-34c567db0a9so33382a91.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 09:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769793271; x=1770398071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg1XU3B6cgpEe2psLflcWBiUZvtKlNIIXguQ1b/fEKw=;
        b=H36yyUrgWN5H0VCiZpwSIinJV5TX2r7VdFI2bRpyMHbG1wrOXRHVXwyIQsh6LmBeh9
         yFSbS10+TteqoKenLr/60QnX/Hj5Z+il7/7PRTLZsHQO5xm4RxP9EONIRMPWa46/YHpX
         pdcUNA9hWMzStDi3atKUY85EKevkDIXrV2BpO1nslNtr8XqRfMB1bfuMl1El2i5hIiU9
         Y8K0ih1atz+iAZ3K6Mph72F07SjK7Oo+42eA84weQbuBB8jzMVqW1aFORFnwEGmFcZpe
         qlh92zSVL2e3Grj6HcWO0i/idXAJJgCRBMV8xQENgct3J5f+ZadtAoodn2UK7xBw6Qai
         03Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793271; x=1770398071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gg1XU3B6cgpEe2psLflcWBiUZvtKlNIIXguQ1b/fEKw=;
        b=oJYZWnfjXwEpqpPbhI1EUjoVLxbJ0mdRlea2xRLVwUXMiCiS8em0Ht1zKybNYuKG0l
         lTzU77Kf9iXOVrhpPQGinWF/2ftoYnt6PHWQOo8t9AFBS+m1+Esdkd9m/ymhhriwIPrG
         3JANSFg/RaEtX/CKdSUVolc0F/tlsFO6JSlrAm3JgSI0cTP32yDp8KwxYFtODRswVplx
         UNwK+NejTKU+mXrIjn7Bw6/MFN45DRG1+QRNmyDAhLVJZGVWnzf4Jq0nWV2SaJzLCbEI
         KSVNGd0Cn2+LiGCIt+9FSW6S9TA5qbkL/7NB2wLEHXF1c+flfByhwSaDBBkqT5jlbLAq
         x17Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU2pAYkmSQW1yiNRl2pbo8mRuchSmG/EX10Pmi4S8SQ0r+wGfgjk/Rmil1Ix0yAnSLqB517g6V1f1lhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5H6zRy6WZvB6vY9G2oyiM9WiuTwRHhmBepROzxDJU8hs+1cz
	fi3bmSl1QUPFNgThJ3biQtz+JrYIAkW6lqIbZVnYS0RS7Gs0j7uJevnc2K+itTin9Fn0clokfxv
	NSc0KzECBaZD2c7huqs3Hw0cEksi0mYmXJEar
X-Gm-Gg: AZuq6aKHm1aAFwfxeLolu6pHlLLxvkz3zMPehsKmX5rkXgcUumLT0BnBc9BU42TNVmx
	GyzDlNTpBXQgAlPy4dIcvIUaovrhqriIPxT5IAWrVWhv7vks4FB3VdChUoXhAXVI5QELr5hElno
	YHjta1kxF1u3lwC4s2qJSGpGkaZnFDMl4F6C4Ck8JIhua+oS7qQAyD9+5xNkEmv6e02iayl+jgE
	F27xmr1x4EFJMS46/AdwyqSL9TLwhiajD4fqjqD9/oD3yt/q+AO+X9vXEbupGjUM9judxSGLA/Q
	KreDOgsetBOxfBecoAkTwmiT7yHA1GhUc0rEOzTuXvYrHBa5nYXmSDj8xmqrByB1uNXgV+ukwwX
	ZsPp3eu2b5ZuPe4qW+QsOBxX5cCAccbI+IMct+EJ9hA==
X-Received: by 2002:a17:90b:56c3:b0:352:ebe9:2828 with SMTP id 98e67ed59e1d1-3543b416d7dmr2651094a91.7.1769793271050;
        Fri, 30 Jan 2026 09:14:31 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3540f3a37f6sm1168618a91.6.2026.01.30.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:14:31 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4E88D342042;
	Fri, 30 Jan 2026 10:14:30 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4AADBE40249; Fri, 30 Jan 2026 10:14:30 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/3] ublk: drop ublk_ctrl_start_recovery() header argument
Date: Fri, 30 Jan 2026 10:14:14 -0700
Message-ID: <20260130171414.1376543-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260130171414.1376543-1-csander@purestorage.com>
References: <20260130171414.1376543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ctrl_start_recovery() only uses its const struct ublksrv_ctrl_cmd *
header argument to log the dev_id. But this value is already available
in struct ublk_device's ub_number field. So log ub_number instead and
drop the unused header argument.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8122b012a7ae..60d07480a24c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4870,12 +4870,11 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
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
@@ -4900,11 +4899,11 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
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
@@ -5281,11 +5280,11 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		break;
 	case UBLK_CMD_SET_PARAMS:
 		ret = ublk_ctrl_set_params(ub, &header);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
-		ret = ublk_ctrl_start_recovery(ub, &header);
+		ret = ublk_ctrl_start_recovery(ub);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
 		ret = ublk_ctrl_end_recovery(ub, &header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-- 
2.45.2

