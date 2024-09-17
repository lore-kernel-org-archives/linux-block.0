Received: from mail-lf1-f104.google.com (mail-lf1-f104.google.com [209.85.167.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0115672
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532538; cv=none; b=LWHPHnVLjRlXrxJjx961eX1TLKjZxIyT+eAm42Qne9CO1WmXd+0CWsilmUu0E27OWw0zEOBo3XvNZxl6dzDiyDgrYICG88c0xg2+4r8KOut2A73bvKdMI07P/sThCD2hCMsvYaKi3l2NE96yY+ACmN4GD5ngPve507W0AQA4hEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532538; c=relaxed/simple;
	bh=tQ2AIiOzt79oPoquQ578qjHgc8IqkC2IkDtDmyCRvaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJVNqHTSW+4AhIml+CsN1mr0K3WF45aNxW8Esyq7+3tW5LWJYtlB/bxAXi7DVhBRPpNRQAHh8YR+mxNHXzMiyectihGZEcj8V/68dikBy9F/mIigLupivaAyaydUFJwD9m7BeA3SMxvON/liVIj2gsjXe41WLGilQDsYCmGNqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=a6nOJEa+; arc=none smtp.client-ip=209.85.167.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="a6nOJEa+"
Received: by mail-lf1-f104.google.com with SMTP id 2adb3069b0e04-5365392cfafso3680460e87.0
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726532534; x=1727137334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF+IrPzfd801zBWUyZuqeid0cQ3AF0F6yKbHsEmtcdA=;
        b=a6nOJEa+DBNq7hP9JgRExC3r+Y4rkKLldV0CD+dyk/pv4jazhczZT/mS1Weagx+ema
         OGshhXhNNbCBuQWD+jVL4FxoQms/oXI6cGJAjR/QJRhhF1tISWAbYUXsLokaFNuBdlww
         eNjpgXWOJanANn6NUaCT3g6H6CqDYCGoFKzUtR07YJbPXeWD/DrnElJqTcwoMJbMioHx
         hJ40RFiiep+xw2vhpKSxJy4Vajke81Iuv4uJatLAmvngBGj7Pa3hJm+yPcJGpXBR9/lT
         J/mxlNELJSx+wFrSgi+pcCnzl7UJmW1xf+Q7oKtCXCDwel3Kp/+LY6H9DVW3+KaFODte
         sfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532534; x=1727137334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF+IrPzfd801zBWUyZuqeid0cQ3AF0F6yKbHsEmtcdA=;
        b=l8NzYkrP+/oXTHqpqp0maWywB0pBu8h5c7e+hMXAE7aFfl+8F5kXDgOw+kezngtR1L
         GkqKTdqUGDUQUAL8s5//M4ptRZXZ7ckZpSqYTenFU1fviQboOk0X5+DlYnD4+dca2C8A
         niksxCC2aySgiP8IApJnx8FgMz00/YQ3RtnmtbF37LP9k/5i6WXrTK9uGLqxYt9r1q19
         K+6FVKEfS2/URsed6m/yX2mlxoLDEttQBhigUTtGlroXTsv9MIUTN/adX6JX8jA8rc4V
         gz0HyLD17GN6FmdAJXeRluwA1zzoT3e3cBi7Ppw6M0bsV8IOsGsaVQcdc1xByj8D06Zd
         SDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpNXQwUcdCSx1HnaaCe6oqE+chDOXmg+u+fY41J+rsTN7KsZTMoUDbUL48OgGcUjsUI4XSq8Fs+WCVYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVq0J4V683ysJ4BGiEDyJdIke9Lvltm6rBIVB+IZHQgbbUFyE7
	LAhOv25Ml1cV24mNr7Uz3wosE4h05BzYpIQ9eVt2x9VO/scHD1JcHg0hxFGw8mE/eSfeiAfW91E
	jK5X3d/2FDDY5ZE7WOutb6x85xKxKq4xS
X-Google-Smtp-Source: AGHT+IFlk3dxfHFme9y2L3ACC2yqLxEqSa/GXqoGTe1j6E8U1s4EaY2V7oubJSmym7RCTTzbW33npIFvaSFl
X-Received: by 2002:a05:6512:1114:b0:533:4620:ebfb with SMTP id 2adb3069b0e04-5367fed70b1mr7071557e87.21.1726532534008;
        Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-536870b239esm79997e87.137.2024.09.16.17.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:22:13 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 68B813421DE;
	Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 58137E40F90; Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 1/4] ublk: check recovery flags for validity
Date: Mon, 16 Sep 2024 18:21:52 -0600
Message-Id: <20240917002155.2044225-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240917002155.2044225-1-ushankar@purestorage.com>
References: <20240917002155.2044225-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting UBLK_F_USER_RECOVERY_REISSUE without also setting
UBLK_F_USER_RECOVERY is currently silently equivalent to not setting any
recovery flags at all, even though that's obviously not intended. Check
for this case and fail add_dev (with a paranoid warning to aid debugging
any program which might rely on the old behavior) with EINVAL if it is
detected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes since v1 (https://lore.kernel.org/linux-block/20240617194451.435445-2-ushankar@purestorage.com/):
- Replace switch statement with if statement

 drivers/block/ublk_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bca06bfb4bc3..5e04a0fcd0b7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -62,6 +62,9 @@
 		| UBLK_F_USER_COPY \
 		| UBLK_F_ZONED)
 
+#define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
+		| UBLK_F_USER_RECOVERY_REISSUE)
+
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
@@ -2373,6 +2376,14 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
 		return -EPERM;
 
+	/* forbid nonsense combinations of recovery flags */
+	if ((info.flags & UBLK_F_USER_RECOVERY_REISSUE) &&
+	    !(info.flags & UBLK_F_USER_RECOVERY)) {
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

