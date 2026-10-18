Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FC3CD8D4
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295502; cv=none; b=Pux2cOh4QufIxZmhy0eMO9rvVQ/0z3eV/tj2Mg/0xTa7dpd1EIBt7vJQQYzZfNT/U50E+atAUicp3DucM6MeEO6DRy19fT2KO0KOkBryKict9W7ETMWW94iyHTRbyYirTQdqcSNvd2FnMYN6TStOVwvJRx2jIHpHunP+JYeZmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295502; c=relaxed/simple;
	bh=RHYtUzD64UUQO0I5Gujz3c30bA6fMFthjuPZDuvoyFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGv93J3ZA/0lD7ZaxLjWVC/rDEY1Q0BtV735EKBqJRD5e7djmXjKDswFgTgtAeuaLSaPFKJZqK7ffcG4e/7srklRUhZqqWsjlEp58QmygrAGr6jJ4ygf5abC/cvXY2zXJ/7HvtyxmttfEaNTMBT5NQMHJJJ44SLnNlzjLUlzI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=feHV8BoG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="feHV8BoG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e942864693so5070705ad.1
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295500; x=1792900300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSllIrSwa3+mZd7MmtH8oNKCmldtJhE3Jr9UEV+PDik=;
        b=feHV8BoGwsmQoP6heYJmEO9t0VjeC/NNdPYK+Fmf62WT7lKN0cL4XzINL2aJKpbnaK
         Dm+xW9Zq5M5jeqFpAes1DXCdy1d8GX70JSmGGNSQ1jX+5IaGPsx2LysWkR1qu6MyEl/9
         JBYQ3Oo9IqH52UNtu//EhfVsaEu13wkDkhUhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295500; x=1792900300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSllIrSwa3+mZd7MmtH8oNKCmldtJhE3Jr9UEV+PDik=;
        b=0jL1TPQQxvNwqnQkcgTY0acXeLhuuQQf9bnTqVd1x29wVG9LWGH9qyCexBFnJxKjWX
         L1C04wskYlyVSlFPP/JCxaYs69Gq0NZyuXkhAhdlp5maR132syslYrD6PSZ3DqXwDgmI
         w7W3wf1Lx5RaGOhrS/rPvHZ5y0GKgxp/stsq3VdjUL9DmdLX0cF55YjB41DDETUOTAyR
         xmROG0CVNGnkR38Og9PCpViHhG3QvLNafInG0/IQe4uI3rV9FCpIIkjsQa0v7Tg0LKql
         i/UNgbgRdDuRrVN0hK6vd5d2PHgptmvGm/HJTsPGcb2f4q93my/DmiddCkKn49yt0XNo
         w6gw==
X-Forwarded-Encrypted: i=1; AKwUvBx29v1bJvHUxW9j7K+HfRD+RPdjdcbhgJN3bUIfdbEZO3KzW1KNW46dCpjoEeCZ0Zo+98UcaMRxm/fc7Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJNhO4AphGr83WRqMZabeGB+oAEPKehJh3g1ZEvNxT4w56oppIe
	fPE7nsTFwna3HcEz+4vqTSqK76aTstRXWxmKHcT3ZFKLxQCRBU9ad12kmuyxAUJXcQ==
X-Gm-Gg: AYBFou3AEXbTeiMjGVgrfJ46Wk6aq7GcDGlj2nKsHpWXVHcpR6B3ASux/Xd6qhubcJD
	o2BnoqIDEd+nrU3seD+wT+8Sd/dFH7k0qZUyXmrgvtkcWm1yBOw4ItKvRJFepSomGM63Y/6AEnb
	dq3IGyIVB/Hgb7zzDfw5Yh6GykSLros++qeV3feYG/7Cn4HwiPzVLR8txRMcF8qrDEZia1lFR1R
	/YgvzS62x3PTM1AGcDaewYCv0jiXEFwmXEboah35RcRJXrDD+gASHRX2N00gMlFRrCoMQTuISb3
	+F8X3xRSYht1OSOOcnnuw8ukOkHI6ywb3DgDDD8UTsYImfcv/JQL+VxtVVojOyGP24R/TMpw8CH
	tqPKDc4+roPe9Q/XVGU5H2EZP5OZQHhcw4BWScURmaTI4vVBLefiMs/1klnS3XW4evWXWSyLkLP
	jlINBW85Df7vUwCTLaeDixa3e1C3U40+eqFst0JvKk2yUt5cXMSns14xr1QCMGeJEtGVftbkq8R
	u+rDQCWdJ2MUucTnY7RaiQSY9ukjlf90RxK/iH5CFXk91dladG7y89eF7Zzd5+7aUou8wyt6w==
X-Received: by 2002:a17:90b:2c87:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3aceec709d7mr3568222a91.10.1792295500608;
        Sat, 17 Oct 2026 20:51:40 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:51:40 -0700 (PDT)
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
Subject: [PATCH v5 02/13] zram: remove debugfs entry on init failure
Date: Sun, 18 Oct 2026 12:51:04 +0900
Message-ID: <20261018035125.3120704-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018035125.3120704-1-senozhatsky@chromium.org>
References: <20261018035125.3120704-1-senozhatsky@chromium.org>
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

