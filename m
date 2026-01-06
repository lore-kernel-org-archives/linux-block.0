Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1E21770A
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661098; cv=none; b=jf99A3lHTxRamwFSI984RFzvCKby2zD9nnO2Yv/DdgP6xDGM9DonoEDznFLUAMVzH7/ZShhgxUo6mXQnoYZSqXf741J1UNhhvvHxSo/GD+gpTpaj5mxePSZGoiwJgsQC4Q2SuBSFodag1f0hN4ktljoez0NdfekU0qBIB+2KPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661098; c=relaxed/simple;
	bh=QglB6BGs25acZBZ2X1ev1Y2R47EaBUb4fHz318ccOjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk8YetckNwGIzNJL8GNz2BnAWNeI6sNqT6B7uDQ9BrjjNqrq4LUPyRa6PNndMVnHJcTW/+bJJ97dQHD9BVpyN1f+Klj9IRSgqJVwX1InthXgSFr+V8xW3RRVvur9WOmQKGoVgzCfN7Lu2mMhmH9tuNIdXtB8bgOm+a9U6zmtn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=c2+3K+Hs; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c2+3K+Hs"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b29aaf9e3bso6779385a.2
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BbKFwj6h+lok/a61k6jPQXyKKIaN26l620iO0DTX5Y=;
        b=c2+3K+Hsg9J9HIqPIFY6xzuVNidUVXFtg0YEgdmJoPEZAPU07aOKoG3CjFjUEgr6wT
         5SlqcFEEqpatwPBsNLRD7+NM+6fFezWZAHdoqe5WEmQ6fKvmOLoYneNXIjKBNN+2EhOB
         jA53DjXUfCAhBGXeO3cxvLsPm3AXVZScshGaD9hUZa3IxFwc7LUR3shyGdJbiFYgsuOd
         alPTdT2uXwlhgNTvF9YgrhFgKKLZM1o6L7UVTcIHYA1AQg5BNBJHzKzYQ3h6OyXcHzFr
         iPSqPLvBLHN/u+b8Hv56T9vJ6FcVA0Zkjuk890STRFEmmbz9zLRHR1aBM4T+0eL3w4wj
         ZrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BbKFwj6h+lok/a61k6jPQXyKKIaN26l620iO0DTX5Y=;
        b=ozc0q391Ykykh1gInKqMGeLMxzwCyYsvoQ3LW585qu0ZjNPncLP+FdadTqUQPpTsOW
         i79Isln5/h7jIeneQuo1YsCJp2ZFiYpG0fAnjNSXrTQ11rttrD4pnlNGjNh97T36LVRf
         WNujFH1X/N+FVPhAXRadwGqh/wElly2EarboDoa3PvfMzZVBpVWg8Jpc9t0JjlWInb1O
         FK1RWHL9myU3VVbzcUudkjCvqdMsPHNfT6IEeiauKqIYduJjs1X0TtpDtNO/spQxCXXu
         qwg98S526PxBjAYwZyqIHs9NJc/pRae5zCYraomCkI7W5/WhQhxneXL/zvbpNLdLR7Gy
         P2Cw==
X-Gm-Message-State: AOJu0Yy4oBVMCWnzLMyGrnCoceaj57wkacCc/nGFIj1024k2lqTfsguq
	GymTcdAzsHeCjPiplQwXjCIbZe37OgMYlizsIeEKvlgUSmWG+Dq56Ayr5oHak5e1TPk39gUuznJ
	iDoR/cgTRC/pTSR5pCMfuKnjbybhvCvwwre3S
X-Gm-Gg: AY/fxX55MrU0+I/h1Q9VI+YtiqfzaK1P565BpFrw/2m5AHt5qgaj/8sKbk1pz0LVTEK
	rUi6Fy/SkyIp64oSWZ8oeiLvHK9xrdw76/fkT/r+6RI6loeuOMsloDhkPryehWus86XBmA/zxRa
	EALYgcDnzxs1A/QfWqiyDo01mdHRvctUDIgcpnP15U5eQx0vm9cOeo++y2zD8Kqx4j68+ABMRgC
	s/5zK9oQbvhoIZna8v1YvTij2jdxJWK0q+bGLt/rBCGolFBgPM0gArUzcNqL+9jt3SbeH9dJFrS
	sPFKK30WroUfZKsjpQsiNgTY0wvmq4AQQzsfqc2CFdfjqMZkxHvX8vcBzObLqsDkAUuJQTWsZHh
	wELrrPXypuinI5v+nMCHsDwM+cg7ztv2lLrGY8Yl3wQ==
X-Google-Smtp-Source: AGHT+IEDNXV4VdNZ1DJwkLlmPxJbs0JiakgrmjqHOO6P+b26CkjANhu8BNuBM6Q6P5Surr2WvM7vVk5hYPgL
X-Received: by 2002:a05:620a:3724:b0:8b9:fa81:5282 with SMTP id af79cd13be357-8c37eb6d00amr164322585a.3.1767661090570;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907715cec3sm786396d6.30.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BAA7734084D;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AC289E44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 10/19] ublk: support UBLK_F_INTEGRITY
Date: Mon,  5 Jan 2026 17:57:42 -0700
Message-ID: <20260106005752.3784925-11-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Now that all the components of the ublk integrity feature have been
implemented, add UBLK_F_INTEGRITY to UBLK_F_ALL, conditional on block
layer integrity support (CONFIG_BLK_DEV_INTEGRITY). This allows ublk
servers to create ublk devices with UBLK_F_INTEGRITY set and
UBLK_U_CMD_GET_FEATURES to report the feature as supported.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: make feature conditional on CONFIG_BLK_DEV_INTEGRITY]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9694a4c1caa7..4ffafbfcde3c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -73,11 +73,12 @@
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
 		| UBLK_F_UPDATE_SIZE \
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
-		| UBLK_F_BUF_REG_OFF_DAEMON)
+		| UBLK_F_BUF_REG_OFF_DAEMON \
+		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0))
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
-- 
2.45.2

