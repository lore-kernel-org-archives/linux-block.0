Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270676034
	for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750299046; cv=none; b=lCh1X4v8crIEM37RGlzuOS1FmXogkiQz3NR1Mb4qzd4x8HSeKAQfCpd4bG+fTUnLUtXeIE1zpzUCRtkHjiJsO7I7+Kpbc8euJUfjQ3JGAZKiDhHxlP/tAd44dF0VmioSjzIPnohnPhVJLmhG+fS2M3LWxBZbn0ZYRCT52S5arZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750299046; c=relaxed/simple;
	bh=ZHeCJlXOigqJcemC9u7Cdbkzg52CPlmGQ/3z/8Q3fFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7Uf3e6NAwx2htPdrDLAoJw6xtkrDRDVjUH/tFX+wcaQHbylC2e5cBIaD3ZDfMKCVXHycnf6JaflZdGuqlgGHRgGlwsElcKWCLa9o0wcgqp8mHG3VoDZqUQfbCsV6OZdElIa0CUtOcMka0830UTsi1YO/G0Smon30/VNk/xKqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgfhDtKP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgfhDtKP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c7a52e97so181301b3a.3
        for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750299044; x=1750903844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iinR7Klh7BcUelmhHhIFYOrnQifb8OvHRZqzwxVFcjM=;
        b=ZgfhDtKPJmyxvQzeqU3TsQI/TVJzG105C2koNhwUQ1SiUxbvtyV7+twLeSYe4OkOb6
         ui4+e3mb89CraBFperuPBe6bTqKTLQxAOqZ7Uu9ANNhVvy8JgaUkkZNjaP6bRFzd/Dtj
         lY6Ll08Fo6TRAhHvvEOF0a6hLcicRDGkZ0VO+yxWuZf8eCbsnEJDVBVE3pJhUBxbzY0R
         PlGaVxldwN2AOYdKsFkBTjXljrt16y4JHgU0IUwlL+rEEJleW4U9M4uV2sZPgpnJsW7J
         OhMvzTfL862ROPpbMLxDxAzXj8XzE9GDErJY1OsghcZNyxRkeFe9po3jGfTbg/RA06Zy
         oIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750299044; x=1750903844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iinR7Klh7BcUelmhHhIFYOrnQifb8OvHRZqzwxVFcjM=;
        b=wC1Ch3ftZMcSOpw3o+9i52NsNXamQu1MYhpPKpeUMjfIGKh9AdyOdqhCrayTml9p1C
         M5L5WExi/MqrBDtoHNoo2yUUqGf9srnNfzM/v1yG6ZZgjc7bPW2zMHJKsiGE2EoDy/dV
         5I4ChI3PmeoMVciGhnHGSt3RBneffX6ohqM4zBfz6MVo5BHMhqDXdvKcS4JpWsIH9y/L
         AHf/uNLG/N/RT0oBrKISPvcwZwX08LBEoJdaSfP46i7EMPK/UbYqvOZy4jfDgqBfnXKG
         0Z3Qm16MXkggPlEbUKWqs158iG2paIEHhbozDhlYmK/xs3EsVyh4IXMo7d/tnibT5/Tr
         DkoA==
X-Gm-Message-State: AOJu0Yxjhx5E8hhXmavLYVFurFOA5ZG3XhnuKYIXQNMWW/VzdeWRYI95
	zhNtbgQOAoKJe38Cee2OtmR4EM4u2w56/LuJt4M9vuFyXfVL6fcMU9r5UbjQA1IZ
X-Gm-Gg: ASbGncvipJDIhMLZC/8vqzFXumbeOM7DjiLnmHyQjjwMBTcQL0n9sKfYEaBQQwPd+mb
	EBrnbGdqkEjqs8BJooN1B866lA5DBma+iLDRNec7x0lVS1JV+2VTrwt2I1hApq8kTjvtvQttqAJ
	8KvJwYFo5wb0Rq9bSCzQU+c/paeBYfEMrUEsSknS0S+I0R6w5QipqFgvbQO/CaND5zhveuCFx8/
	Rh5BCfF+mA1xG29Og7P+qOWTqsbZPX6k7B4M3fXlibbGnhZNNm45g2WtO3dR2K67EH1Rm6OMiT2
	/nbI+BD5tuYj/kPINsBOTKDId2WxTFnt6V3bEC2hjLtuKxhY1jA0w7KOmCHnegyFj4I+DCx9Mxc
	LDTM=
X-Google-Smtp-Source: AGHT+IE+DVcSY/ZfIrO5QZFgnk/ZjIsdFcW+DMQkgvLltCof8HvFjBOS2743QFcqLUuzlf3DmDW+Ag==
X-Received: by 2002:a05:6a00:92a2:b0:748:fcfa:8bd5 with SMTP id d2e1a72fcca58-748fcfa9314mr976211b3a.3.1750299044155;
        Wed, 18 Jun 2025 19:10:44 -0700 (PDT)
Received: from localhost.localdomain ([180.216.2.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489000749csm12383570b3a.68.2025.06.18.19.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:10:43 -0700 (PDT)
From: Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH] ublk: santizize the arguments from userspace when adding a device
Date: Thu, 19 Jun 2025 12:10:31 +1000
Message-ID: <20250619021031.181340-1-ronniesahlberg@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ronnie Sahlberg <rsahlberg@whamcloud.com>

Sanity check the values for queue depth and number of queues
we get from userspace when adding a device.

Signed-off-by: Ronnie Sahlberg <rsahlberg@whamcloud.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 374e4efa8759..febdb5609e95 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2336,6 +2336,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (copy_from_user(&info, argp, sizeof(info)))
 		return -EFAULT;
 
+	if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || info.nr_hw_queues > UBLK_MAX_NR_QUEUES)
+		return -EINVAL;
+
 	if (capable(CAP_SYS_ADMIN))
 		info.flags &= ~UBLK_F_UNPRIVILEGED_DEV;
 	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
-- 
2.43.5

