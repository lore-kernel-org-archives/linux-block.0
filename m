Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269639891E
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125885; cv=none; b=mWaAV2rZWL1gYQpu7eN1ZXEVf5hj3kUvBh2mAw4Ld/8qd30frxlYKW/zz4PsA/mRDTXdd8HSacJABZFg4K2FAToiGtdWywKCuN7y1tDBlk5jfZJTT9IQ2ZcIKMcuwB3AWAmSuKN+4+UxP+d7DW05ZojdrXwtkeItUYIS9qQen0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125885; c=relaxed/simple;
	bh=RHYtUzD64UUQO0I5Gujz3c30bA6fMFthjuPZDuvoyFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjlNYEw+I2VI0dAquLeSxuVqbSw0lguORRdy/kPoKhIBMDYYELB8O66R7xCoFYjGday4nZXgchQ1bZTmWYsi/2m6FOihWn5t1PJ6V8X1gApwgw3S9aJgRYIbqPgLgURtGt0r00TRg9rYaDvnQWeSYJMOOre5xeJTLmi4qTQE9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oIkqTZre; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIkqTZre"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so32708865ad.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125881; x=1792730681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSllIrSwa3+mZd7MmtH8oNKCmldtJhE3Jr9UEV+PDik=;
        b=oIkqTZrewVMHmu6ULWHxqfoQlEUWJjaG4/sI3yWW2ifbpxlkUrGqgOt2E5fW7UZfvT
         X/LwqZzKKkJ6JyKOlk4opSBRhA5gYZ4ikHhRHh+p4luFtjF/i2qAjf1uFRjrURPG2gQ8
         J3qyx+a6wR4K/o58/ubpjZGCbBBTcIkeLCe1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125881; x=1792730681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSllIrSwa3+mZd7MmtH8oNKCmldtJhE3Jr9UEV+PDik=;
        b=wrnm6829XaLr6wqBikEcoUPIFoKrZnam8x06ZhLPodFhBfbZ4VLHiRgnSjDxZBd1pr
         J2rOhdlIZBcfEdGVtclNN0rOCrwu5Zwh0bVV5KKZurOIhF87AB3JQXpR5irJznnIrfDo
         qtJolSzeLrhZqdFVIR5QkkdDGaqzioScbNIsg6eCns5B101E70dTJyTZHqooOicJZisH
         +HZ4Q99ToAOKnZr6NurXNmkGD4wVh8wYS+R9Kptyg+ktGoinAnhB3oCeapOodxHfdYl5
         ZFH3Mr+irDJcuVk8OGkTLUmylj+Wg0XksP8GTbcYVQ66YRU1b4eAEkq/eeB7VXKYyuqy
         ggzA==
X-Forwarded-Encrypted: i=1; AKwUvBzeufQrreCo86tXIDfEblSIMzOAZeL7zJaXGSlHQ6h8fYFZX1SVh4EyIfu9OQ/4SqUHC7L2P4Vf2BOeTQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJdIeDKoUvyGbwJSJ3RAdUFxFDp8H5gPZTzP9vTs3Z7viYnZ4Mo
	x1dCH2/KOukBEl1BzRxRtPqRHRK3jn4EXZ+mWBgIu1TpZ2UK3tKGAnUY8tE8qYxIeA==
X-Gm-Gg: AYBFou3rb0qtAl5V+L3KrExATaHBpZf7TSYxB49GphhQ6ydxDkRGiMB1ZTmtwAVUVgU
	SkEoZWJdNthkEsMWALhPNICeOPJeewi1urbCH4Xb+DgJrOKlJHWeQkOQNgswDDvHJV1aMsrY/I8
	KoMa+RtfgssljZRz1yC93wjJRAuBXr1zJTlU48OON7dabaxlJnROCi2IT57PKkEMiSO9vH5Y1az
	zbJKA8//1BF0bD/QHUwoMrr8ee0Ed3XJ2I2PIXrDURtftwA/An+8qMIbvkfnaSnGKsmfionVhqi
	D2/eIwGgYyUfFgghBPZQKDnHPZ4wGJ3lZvpbvmb2f8XKLsyYL/M7Ia+7QXdRXXnPQpbt9FAYPSP
	BJ8MU8LO47C/ZBKQXq6iTv2Yx2NJqBjoaOCCZ61TwI3N/XpxgZdb4AX5nhtk1hymX4YcmlcarHF
	V/LqAPIDUqDexXHA5aSMjKeMIe/AFPChvQe6MpW51aopAjRliPGSJBc9ku0ymJ7w8u4fI7jSQzF
	s79HlGQtw9Rg5T/AyQCEENDzeEg+VVPSLllX+FeK2iTU/dpMm164/KTaHja8NM=
X-Received: by 2002:a17:903:240b:b0:2e9:8505:5471 with SMTP id d9443c01a7336-2e985055683mr10946845ad.7.1792125881530;
        Thu, 15 Oct 2026 21:44:41 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:44:41 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 02/12] zram: remove debugfs entry on init failure
Date: Fri, 16 Oct 2026 13:44:07 +0900
Message-ID: <20261016044429.1304561-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261016044429.1304561-1-senozhatsky@chromium.org>
References: <20261016044429.1304561-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not leak the debugfs entry when zram_init() fails to register
the block device.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ab064c84b092..593fa4ae47c4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -3297,6 +3297,7 @@ static int __init zram_init(void)
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
 		class_unregister(&zram_control_class);
+		zram_debugfs_destroy();
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
 		return -EBUSY;
 	}
-- 
2.56.0.176.g3575e65682-goog

