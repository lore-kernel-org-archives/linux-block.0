Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE41358D21
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726804; cv=none; b=uAGevXFQm9IR7Oes4j7QDGKlYTEFaYpYX1Ef/XsNyeH6kdK7kuGAx1zo+kI6+Yk+Bp25mKH1/lqkwQmD4OogAsv8C8JXs1d/PlymzBpddD7+u/odUR79C9lTLsEMinXPm3CLmCLj0nVINvnsfjx7DCE4UFcugqqObvLlAXwzOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726804; c=relaxed/simple;
	bh=LxRnyNMqZdQTNtI5+gBDaLbF3eE/PKtyIHlafMMwiDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtFhFZ3sCD8wy91+8DTnAGwo9/xYMfiKRWwxxrj1sKDaZeUvwT/L4OSRdrBDeE4T/UaQJ67dq9PDJGeIo0QzWk9oQaIVTaGBBm14XShM2okIZeLq9ThKsXV7zXq9wr/Udtnlt4Ywmiyy+3FJTXsQRMUb9iPDx96VkNDVZKB/Gcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=as72ZIVJ; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="as72ZIVJ"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5636e549defso62471e0c.1
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 14:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769726802; x=1770331602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6ty1uyYKM756sn4TycAtRGFmZ443M4y88c0mPRhRtU=;
        b=as72ZIVJaOjgNSxMUkBdNpS5Z3BXDpcbxNbG+TWiUprr4lamApg5wZQvxqP2WuMbvx
         9rSl4OvvSAh/y3CouJTb6+ZmugQtJTIgSNv3BCAnqsl8zhpIEPejNc6bA/qEaskRyqzg
         zmKiqc4/EnXgzzDcODSIt5Xgnu0NVJxUbL/wM9tsEqkf4bOir7G65MZKC56ax7Jo4Qm8
         0uHxngKDzE0MooQ9Qr+QfV1q7hRaPjwJ1vpsQyWTHfNpUsIW+vI77xvpvmbH+R04Ktvu
         P/qFdJ1soM093TQcaFXNUCaZdJMutqhsfR/C7LYbcgbGpiB4m2C1EpBFHLreg1QDJMDY
         fdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726802; x=1770331602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6ty1uyYKM756sn4TycAtRGFmZ443M4y88c0mPRhRtU=;
        b=noAuvJrgPwYPSGbrp61pYd9+aYOPrGys1oq4cMI/m+odEYUJdKp4e4uIpgy7MThwOH
         AH/MDeiLDObVpMv1dCB2WNCbx9w3ciBPH//MtvhNYX6iALFXwBlyz+grdaLqgzVu0emp
         GpB0kTKqJIPwK5ZOWrGDgHoptV+JVcoWqRhq0wov01HGZjtkf7tbqRkTpDAFl7PwOgj2
         pYcSO0AXiAJmRO2HG/ZBwupQMAsCjfJKY6JCdS+bluukBPKKE08J/V7W/wiMr98sD0RT
         P4I74EH/NwHUTVlHj5Q4LhFn5XbUk9VFfd9X4t4HeuUGaWf3MGtl1jv6dhw3ln3SIpAO
         ZoPA==
X-Forwarded-Encrypted: i=1; AJvYcCVWuAZjqxgKQxcpthRd4BPoS6O5rtLRNlNBw81Lpr0H4viVGrEhSx6Jso+8HCgVV6jg8vULtAK15m48WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyecHuXMHt6xcvnTan/gFktO0yCJXZfhdHkMWiwdRoG/MXXNNvI
	6UZyahBS/AJXJOSqR2JjegujCkOef8xIYrTjck1I1OyskGx1jaPNUUnZKdMPl/X/HblMgF9ig2J
	C55b+XpkH5NKGnzyjqneDBYPhFLFhKQihEFCQ
X-Gm-Gg: AZuq6aJJSnAkeeVqaybC5sMx+4nXKHWbf2ZIVSvxgcZVvIOMFZ2G0jbb7evBRGj6XZv
	1l/KACFgWNnkKyK7FFeBGHk/nnIIAlbFQXX/B7Au/yWkndj58ZYOBCjq1CA/GHYbQdgC/5OVkme
	m4TO7JdF1uR8WoQhrdV0fZKHsOn4PhLGpdTuLuPw2WOw8Um1SkeCx1SSPWwDd/Yx45xdWTmXpIw
	PQlyNjdao4HEeKuvx9hR8e2dKRug+GsKVvKZtWw706u6oQ+9ykgnY6PkFfm562gXYY+wniLSClo
	zvSOTLS9UlDlAUvYzJDKAxKgC0LZDc26sxjR/EiZ8IT2PTrTeZADwURd1D9+ECCaB+25VGsfXa4
	/X4QNRHadAunlBkDCdfzjOaE8ppC0GTBwNA6XB/g7IQ==
X-Received: by 2002:a05:6122:845:b0:566:465a:8b7e with SMTP id 71dfb90a1353d-5669ffcf054mr166347e0c.1.1769726801899;
        Thu, 29 Jan 2026 14:46:41 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56685afbe3csm666803e0c.1.2026.01.29.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:46:41 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 45719341BED;
	Thu, 29 Jan 2026 15:46:41 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3E824E40456; Thu, 29 Jan 2026 15:46:41 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/4] ublk: Validate SQE128 flag before accessing the cmd
Date: Thu, 29 Jan 2026 15:46:14 -0700
Message-ID: <20260129224618.975401-2-csander@purestorage.com>
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

From: Govindarajulu Varadarajan <govind.varadar@gmail.com>

ublk_ctrl_cmd_dump() accesses (header *)sqe->cmd before
IO_URING_F_SQE128 flag check. This could cause out of boundary memory
access.

Move the SQE128 flag check earlier in ublk_ctrl_uring_cmd() to return
-EINVAL immediately if the flag is not set.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Govindarajulu Varadarajan <govind.varadar@gmail.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7981decd1cee..72ee83ae303d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5130,14 +5130,14 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 
 	if (ublk_ctrl_uring_cmd_may_sleep(cmd_op) &&
 	    issue_flags & IO_URING_F_NONBLOCK)
 		return -EAGAIN;
 
-	ublk_ctrl_cmd_dump(cmd);
-
 	if (!(issue_flags & IO_URING_F_SQE128))
-		goto out;
+		return -EINVAL;
+
+	ublk_ctrl_cmd_dump(cmd);
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
-- 
2.45.2

