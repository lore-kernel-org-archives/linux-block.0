Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64011CAB
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653501; cv=none; b=phiryY5MVfYo+IgW0AoCcBcm2SX8xry8hvozZKDijd1JOA6LfjXLNRpTtkLmCUrtTH79grTf5iTU3zhUEgUIZ3olKJSC33tR7Ge5E10uf+yFTtkesgRPdgBum2ZwgBQ+nptil1WMe+/O50p2D0m2xOyht/o3fOtU+jMN+84RfG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653501; c=relaxed/simple;
	bh=q3OT82/5hPbQeWQRe7ZoRAYo/DmtuhC4FJtiSJ2ZuNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z363WBCDddo2grDnNbtbPJHNo2V8Q6dc8ggJBbvvU4or21sRR7TojfzbmXsR8sL9XAVJAOs2DGwlqvtmmIDbS2aG2fd9Kb9SC6gklP1lmF8KhXoLHeub5tAx4Lf3b4mc4aB/HRZik+Ju4moOg9CHXpDPvrnryPTNaUXcYDVVJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dgAGDNvp; arc=none smtp.client-ip=209.85.221.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dgAGDNvp"
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-35f23f3da44so4214617f8f.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1718653497; x=1719258297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2TV2BQQ7MB9qUDCbVKF9ekWJjR1zvRJg3acNlnp8OI=;
        b=dgAGDNvpTJhmzqAUx8dmdr8J1A112cFesFhsetLSCsuoJ++qA6+iOlpRdO2lQayk8Q
         Yhnn8IvCnkb8iEheEq2jnvGfGKyVyzWmEw7Lp6F52QpE0pxdLZHBGYXhM32Cr0YH9OXz
         V/YZq6w8Xb9EDW7rtBK7x4MFK/URvc1FCgIM9++g06cuAsJxZsv3Jf1MIwKtRS+TuD+2
         CN1JhrYAK+Q+lJnMf2aSExwwO1xrtpAz6NZwvwYsxEMmnk5f1wyN63u5dGntTxNTssfH
         w3LIXZjcX+BhiiOlrBgd6UwBmaaMHuKrHoRjgawJD/6k8Pr71viWj4hUKggsr0w5myy9
         9LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653497; x=1719258297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2TV2BQQ7MB9qUDCbVKF9ekWJjR1zvRJg3acNlnp8OI=;
        b=XIMTA+T+Ad+KC8JaA+U2Z0QROIxgWnfYDp1nJmf/Df3sUZCe9/HZJhJQQ4jGSMHnM5
         PPfJOdAbnV9bVblCkE+GOBqAYsRPZUpmcsQjKec72eJbzjmQz6KJ7ZV4HVFGg0+QXawt
         7+97YoTvmjtxEOdSgmf8aGYqO5Ahdv/MK1Ds4rnByKhCqA6/mcUoIIkP1NOTdNxuYbrr
         TRVDsNDUrX3tE4B7EjZKE/hiohHRHbcxlsXGP7a2qwSB3tO4RfY0XgNzxWU/VJPeXSoh
         p6u7mNaaO5gi9cd5muX6Ogl24AahNJDIZRFvuvfQhYbbKoloNp2eMcvnU/Cc2U2oPkDn
         OHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy3jgmuUAXpvjRYL+j3RMvBi16kTD+h2Yubfz6KiITZdZQg/MYjqAtpoT/4dqbIWaG/om4iFHj+SsCvbGsTKCbYNwU6LJRvlWlyiI=
X-Gm-Message-State: AOJu0Ywxk0PLkcioyx080/bNTqYpIOwsIOl3/3qJ7cA5qZS6og9NBzwU
	aRpqUtj6vQ5n8iqCLEgjDAD33GwuCzzbmwNzsoQxeFVxkQJDquxJYOIGRdES3G56Hd4/rK0Zx5C
	mwdsuKB0XGW+k5vuEW2SJXJtZKrQg4Y89xYYifeaZVYvi8bVe
X-Google-Smtp-Source: AGHT+IFoYx4fI/YGIm6N7q5kadC+ob/MIKwVAar81Ko+FTLLdZI7GiQypxjb9KJxUUwlblAHYD6fSYC9IQSl
X-Received: by 2002:adf:cf0a:0:b0:360:7a44:12d9 with SMTP id ffacd0b85a97d-3607a7c20aemr8261296f8f.42.1718653497163;
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-360750b75c5sm457968f8f.17.2024.06.17.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E7462340644;
	Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D76B6E401A9; Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] ublk: check recovery flags for validity
Date: Mon, 17 Jun 2024 13:44:48 -0600
Message-Id: <20240617194451.435445-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617194451.435445-1-ushankar@purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only certain combinations of recovery flags are valid. For example,
setting UBLK_F_USER_RECOVERY_REISSUE without also setting
UBLK_F_USER_RECOVERY is currently silently equivalent to not setting any
recovery flags. Check for such issues and fail add_dev if they are
detected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e159948c912..2752a9afe9d4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -59,6 +59,9 @@
 		| UBLK_F_USER_COPY \
 		| UBLK_F_ZONED)
 
+#define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
+		| UBLK_F_USER_RECOVERY_REISSUE)
+
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
@@ -2341,6 +2344,18 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
 		return -EPERM;
 
+	/* forbid nonsense combinations of recovery flags */
+	switch (info.flags & UBLK_F_ALL_RECOVERY_FLAGS) {
+	case 0:
+	case UBLK_F_USER_RECOVERY:
+	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE):
+		break;
+	default:
+		pr_warn("%s: invalid recovery flags %llx\n", __func__,
+			info.flags & UBLK_F_ALL_RECOVERY_FLAGS);
+		return -EINVAL;
+	}
+
 	/*
 	 * unprivileged device can't be trusted, but RECOVERY and
 	 * RECOVERY_REISSUE still may hang error handling, so can't
-- 
2.34.1

