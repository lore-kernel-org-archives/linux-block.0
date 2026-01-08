Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D42387342
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864018; cv=none; b=DdbrP35BPVH/OZRkD5WiaKbtdKjkXjfcP4i+3NPr9zgPzEpcFL7knj4RkUdUGgkjcZJGOiorFalOdmbY3Cy5bBGOF8EVtPCtpftOwLjSfquZv0cpwRZV+/3fk4w5vII7mHx15VdQm28DKR/xlmdprHbfziFXthAE21584hlLeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864018; c=relaxed/simple;
	bh=DG8cT5egglUbcMbgq3vHZoCNJC5DKE2cmf1JYXKnNvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhziZ8lsWBi8N6np9BU1w0khaqvmv+dkmo+OTaOuQ9Qdfn75nYrU82FvbmWtGKVo54V7rXFkIM3HRdjExTpn6pp91M434T50oQ9I23fcxq+oxX/TuS+4Gnrq5+Mvx1xOvZiyj0RbFsdCrsd0ccU5bLKKR9fNi7iI3wYrK6PtOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=N9ekjVxv; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="N9ekjVxv"
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-11f42e9733fso96191c88.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW9SsgZLsT56tsZ5FPzuxlQOX/d2/F2cU00tFSPwIi8=;
        b=N9ekjVxvI371zSTfO5zIZJIn21fYH8SVGNE2PKYBYMtPdIZIXBJqCBwIUm1OWWIYTu
         ykqjXURg0imrkLWLBEm3gXvLST+v9pvOYlIWbSJebYcEPM8BfqZSDnp1Ug/Yvm7eJdTI
         pB318qsLeH47gh5zKnT/SPMcL6TDIHFuG4K76+ECUSlHxMFBujJ6IwXCq33RwiyYuWuU
         HVuNlUW6BkHTpThlAGHR0gyhJhuKu/m0IE78RKGvjDUOuYAi7WyTsa6rqdC/2YNn2dfg
         ulVgbqyxbJ31xbEy98/TlbfzXQcIgsaIcwitywRJxp9dNbiachS+xSVVgNJ0B3rLDA+k
         WBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gW9SsgZLsT56tsZ5FPzuxlQOX/d2/F2cU00tFSPwIi8=;
        b=g0rdst8bFXY36PnCNnp/MhJeGIlTlGPPyRNf/O2qzcvpbo4VbYbF7Yqv+RrX/Z+Sen
         QElrOFnEngAJhFTn9xkB3KfOxU7uxkz6V7cOK/QEmTZFibJgem0qWvUAZUUD8cjrRG6q
         qnHT4NgW9Zvqj+dSk98q+BA5m3KbRWBcAFueVJS46dtFsL1FXp9/zPXEys1OD1EIHMOC
         nzZfuzcweERqz9KIbY/TKgw3ntV5+B3hoYtibnOwB35xy/RQ4fbfu6nmDsWuJ0xU2fuC
         ig3rmOOMx8pRRHWNOFkPx7yCG8f7yCPBiZ7Tyd8Zv/XFTxDpGcW1lXuSKBOFyyUOF3do
         1Gow==
X-Gm-Message-State: AOJu0YzS+i+o4s5ttEiK9mNOaSVr19V8X6UtjqIw2DiOqFdUpgHt/JZ6
	VIkX12Z8fiiSS34E6tyG+Sztfo40bhHNT7IEQ3Cql0m58h7/ju7CTMg/2aiFfozWXZ2SZ15Tega
	jcNcEcknQ+sWIFPiZZQ9mHL66qO+G4ucffyOc
X-Gm-Gg: AY/fxX52bfa7CoATQHVoC7ez+tX1AU3VEq1/+zQa9Q2nV77VlC4T7AlMomHtw9wyteA
	+5BmA196uaAWYx5F5Vp9uOaKTTX+A2g8AaTPkwiaB9XUYQfDCwZW6/y/qVQKu6i36h2Nc5NnLU1
	g1PHW6I2/9QiRRR0K3cIZvH7A2wQ7FhFb8LsNxSW6zIFYkJMs+24w++Q/unso+XwIn5jHrlmUTq
	xR84WG417SSbVbX0+CLuHvm46ESgpDoQcLyChdVjj94p2RDM0k/S4sZFIgnu4vtbc00csJb85aO
	uqVbqdmWMFmH2TA2oJAuILV/JU+R/zZojmUbjzCZZaFyN78uqm9nizmBA+Wi4mCydhJ18v2EoCi
	rqXoxdjo6hYdJi5AsUyuP7Tejzk80WvhHhoNn/fmEKA==
X-Google-Smtp-Source: AGHT+IE/kBJmAenA7OHV8bMZchiak2YgUNV0Jh2fIqSK7t7BrW+Oj0EwFqF849WShUKzill49TjNtmW2L7qy
X-Received: by 2002:a05:7022:619c:b0:119:e55a:95a3 with SMTP id a92af1059eb24-121f8b92076mr2680115c88.5.1767863996918;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f2489521sm1704761c88.3.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 78FB63400F7;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 732EBE42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 10/19] ublk: support UBLK_F_INTEGRITY
Date: Thu,  8 Jan 2026 02:19:38 -0700
Message-ID: <20260108091948.1099139-11-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2a8a6a9c0281..08674c29cfdc 100644
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

