Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEED339B20
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869247; cv=none; b=gDNctCFV2qSvf6v14syY8hYGpslquCvV0PQ3bgzBhTEKSsz+jXZxe9nHk35FNLf3L37IERSZWDkDCuFl3FNzl+rFjJ4SM2qJJ8akL89TRl8gUARnt8KLc59csE7pAXxhuYrYJhdoLRv671iVM7bGu7cft6GqKgqNljj2QoSWIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869247; c=relaxed/simple;
	bh=DiAzDYRqTBmi+hx9n0dYlwt97SWgA3PLS4cNusI+AAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+VCyHrFabo95n37D3tL3NjMFxv7SioFR5CsyCLFbwzRvMu9YCbDy68qmxaJkCRwYTPqQ4Ee/BuidgbewFac/BJc8xXjgb1wTpotm84pFynyCqwWrVUHjuYCL7Pw9KqfQdEmddND1oeEwu4HQPxVmK52gqOPPiCyz/f7gILMm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EU/cCnUp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EU/cCnUp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0b4320665so31506065ad.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 23:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765869243; x=1766474043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNatl6J6BcJk/S0sXAT6q/VLY30ES4IaJnzY7IJFPDI=;
        b=EU/cCnUpbxAhTWb+79IXHWV5LDUCHGqEVtmzJ/SvYiL6HrjitB2L+HlFhRH/2RaTm5
         mDJsa4BqKL3qyb/NtrGoOQMP2G+0q+C5GKwygyTBln/1NgwaHfNpeh7ngc5e9yZHNGLc
         09bX4/WJ5EDpvVnE6H2tJrMCcmPnVK2f2k3nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765869243; x=1766474043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNatl6J6BcJk/S0sXAT6q/VLY30ES4IaJnzY7IJFPDI=;
        b=S7xUfoHu/XzRQhOAtG4dcQDSs7ueM/Q0ahi4oxUVcP493Io1l4RMYqJrETxNnNkTRv
         9hhjhr20NlBpPEW4X0wHpHzYA2ArFAfvLe6oMi5uxgKEjDTEveEi1d875gD13wpQHTr3
         DwnnkNb8hV44rrvJIrRpLPTBn1+pwUkL38ztlgRRt8byiCOJzICzCrJzy7izHjlz4Llb
         sXVkk89cTmYVCLOxnt/8cLY0DEQrVM7WJRCnHUnFspOrJhSoVBE8+U4PB8BoJpVTCbHE
         hAfsEye9HISOaRNcmkaq5BQlvQZF3FG+LoUwdn+E+ZnoCxazsimo4hO4XfMvnVrTWuJe
         eJxA==
X-Forwarded-Encrypted: i=1; AJvYcCWrm673INvbgg3fUxBG/EfscIZUR50e4yfazx6Lta5Sv+VeEGZFkD5ChfUccycM+ddUyINe97vliOBugA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4HRyOd1k62dNCakMdb7lOAXFx6d+M8HloNAIzPmU9kCnjb4q
	WN7hTntW45X4+S3Xgm95ed1xlA+dqTndumOYMFTOrF0MTkX6Tqv56+OdBqSaqYAfCw==
X-Gm-Gg: AY/fxX7Yk7zG+4J5ej5WL5eJPW7o/bddek5plrN53VdhyP1QeHm5Ec1cbl2GwpgPfrz
	EgOxcOkGJ1FEDy8ZbY2K1Nl4yzCTzT8sFSo+Fg7zafTijv0+KcoDLUiPFK8+hsDljC2d7x2XZzP
	8TuR6CIeUS8j8cPmTx+0QoIktQ/WnmoQ63xPgUQ+TzVh0wUiainzJ5uJMNdzoKVkLRhE/O7PNtG
	pWZg8seFcIMrtc1Cf3Q12U7dBKYn0AxLeiV9uGqEZdhPgskwlq1LYGVmDA4c5VhLHP659Ft7ySs
	ISGtpSRMTavtVKaIySPYmdIAWDZWw5Fqn+i7p25wXG3qunFQgZ4xPYBLLbsJnwYwvJyAA2H22r1
	TYQvBadMe/+SQ9WbXrjpBacu3Ii2ouZO9EeRE6iT/aUaxk8Ea0rD9TQtyBvuHPhT3Hrekt0QnRl
	SDVg3wGhxuIPu1vc82GA8DP5omZWeIgsrA7FJsohRHlwBUnizCqnoBX3VXC8jC1cAA1MUbLucod
	g==
X-Google-Smtp-Source: AGHT+IG0syAFJhjlxLN2Aw5XB+eZPhRIhKo3rCILYb8gAbNKQjHe4RCRPMTSFXN3FJZtNVG/AkOQdg==
X-Received: by 2002:a17:902:cecb:b0:2a0:de4f:ca7 with SMTP id d9443c01a7336-2a0de4f122bmr54142285ad.1.1765869243447;
        Mon, 15 Dec 2025 23:14:03 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a48f:6b66:399d:86cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f2563b116sm119253685ad.102.2025.12.15.23.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 23:14:02 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv2] zram: drop pp_in_progress
Date: Tue, 16 Dec 2025 16:13:42 +0900
Message-ID: <20251216071342.687993-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pp_in_progress makes sure that only one post-processing
(writeback or recomrpession) is active at any given time.
Functionality wise it, basically, shadows zram init_lock,
when init_lock is acquired in writer mode.

Switch recompress_store() and writeback_store() to take
zram init_lock in writer mode, like all store() sysfs
handlers should do, so that we can drop pp_in_progress.
Recompression and writeback can be somewhat slow, so
holding init_lock in writer mode can block zram attrs
reads, but in reality the only zram attrs reads that
take place are mm_stat reads, and usually it's the same
process that reads mm_stat and does recompression or
writeback.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
v1->v2:
- updated lockdep assertions

 drivers/block/zram/zram_drv.c | 32 ++++++++------------------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 634848f45e9b..9f91eb91dc72 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -902,7 +902,7 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 
 static void zram_account_writeback_rollback(struct zram *zram)
 {
-	lockdep_assert_held_read(&zram->init_lock);
+	lockdep_assert_held_write(&zram->init_lock);
 
 	if (zram->wb_limit_enable)
 		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
@@ -910,7 +910,7 @@ static void zram_account_writeback_rollback(struct zram *zram)
 
 static void zram_account_writeback_submit(struct zram *zram)
 {
-	lockdep_assert_held_read(&zram->init_lock);
+	lockdep_assert_held_write(&zram->init_lock);
 
 	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
 		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
@@ -1264,24 +1264,16 @@ static ssize_t writeback_store(struct device *dev,
 	ssize_t ret = len;
 	int err, mode = 0;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_write)(&zram->init_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
-	/* Do not permit concurrent post-processing actions. */
-	if (atomic_xchg(&zram->pp_in_progress, 1))
-		return -EAGAIN;
-
-	if (!zram->backing_dev) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (!zram->backing_dev)
+		return -ENODEV;
 
 	pp_ctl = init_pp_ctl();
-	if (!pp_ctl) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!pp_ctl)
+		return -ENOMEM;
 
 	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
@@ -1358,7 +1350,6 @@ static ssize_t writeback_store(struct device *dev,
 out:
 	release_pp_ctl(zram, pp_ctl);
 	release_wb_ctl(wb_ctl);
-	atomic_set(&zram->pp_in_progress, 0);
 
 	return ret;
 }
@@ -2622,14 +2613,10 @@ static ssize_t recompress_store(struct device *dev,
 	if (threshold >= huge_class_size)
 		return -EINVAL;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_write)(&zram->init_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
-	/* Do not permit concurrent post-processing actions. */
-	if (atomic_xchg(&zram->pp_in_progress, 1))
-		return -EAGAIN;
-
 	if (algo) {
 		bool found = false;
 
@@ -2700,7 +2687,6 @@ static ssize_t recompress_store(struct device *dev,
 	if (page)
 		__free_page(page);
 	release_pp_ctl(zram, ctl);
-	atomic_set(&zram->pp_in_progress, 0);
 	return ret;
 }
 #endif
@@ -2891,7 +2877,6 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	atomic_set(&zram->pp_in_progress, 0);
 	reset_bdev(zram);
 
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
@@ -3127,7 +3112,6 @@ static int zram_add(void)
 	zram->disk->fops = &zram_devops;
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
-	atomic_set(&zram->pp_in_progress, 0);
 	zram_comp_params_reset(zram);
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 48d6861c6647..469a3dab44ad 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -143,6 +143,5 @@ struct zram {
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	struct dentry *debugfs_dir;
 #endif
-	atomic_t pp_in_progress;
 };
 #endif
-- 
2.52.0.239.gd5f0c6e74e-goog

