Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D3224AE4
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246059; cv=none; b=ahprtDam3HbdOSUG97yBfucXaoQs/yF6Y4UWyxzxphHKug/Wpn7aPdU8D67eV2Q86oyJkYJD3dq3/+1WXMtQnjVOt3m0RR2pSL/GSFRvfyYWZWbrBAkpkQs08O/XLXF3+7lJ0rccw1QNeZ1UneJ6TxZya/iVu7NAZW3FvwyGNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246059; c=relaxed/simple;
	bh=5De2+cWjlXefHPK4gGVRu9VU3FCOIaFTTUNuaAsb/pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+bENDJuIbNd8macGM2HwL8kMWXlhxe8YinNo/6Kq2xU79XoVmJn4Gnlc5ndzZtdAm/eGfgqGcOBwHpK4cpFoe6f5lTGL/ii1xje2TXivrm91yKENcE5sS1iTVXg2jPDK0tXbNu4zwTULQpyh7MbbUsqEaEKRz1uQ06ILK68lYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BkHHkC6T; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BkHHkC6T"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3ddc9e3e61aso891925ab.2
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246057; x=1749850857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAYXnb2C8p4utc1eYOFZtRQQEfQ4mcwmoVKDEsk/OD8=;
        b=BkHHkC6TJ2jrw3OZcoRumDxAlX5IosrmJSEWiD1F4EX02UpDBMHiMup1YfuwhWM+P6
         EXSoF/pP9fuFgYJQBAGRb6Ye8//plOAuhc5WBjrWLUlD3qjADKNAxROs+3w6/Wun2wze
         /iM60B1LHpoJR2eKWkTh8abwcfAa8R1ItIaA9w6R+ChU5yhjGY519Qzn+yewkjDGrVM8
         0irLwasEm4Mbp8ArhPYad1zLobypbvWOcEYeNnUtugKAziDx6VzontC2SOLAGalUlITO
         9zo3XimqA7xAtkrEaKSZoy8vBymiea0LezPENTGj0IsHJMg9UkRbZRWSwCkI7av4sch2
         dAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246057; x=1749850857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAYXnb2C8p4utc1eYOFZtRQQEfQ4mcwmoVKDEsk/OD8=;
        b=p0QadSCGtd+ycCNisDRuFP4ah/aP2WVQuYEJZYd9QpPOEr1XQDakyeLqf0NRTXux6t
         79FGHDZizHghVQBN9ufuq3ALntpDy9Hknot2LB99WW2cptoR/RmAGs3ypBIJCrV6ubLU
         m1V5aRI782FqOCfoflyiSQm/aNJKJuPLFEc7J0WyqVZWXLuZE9On/AsFP4fl8t+i5JJa
         uxYusYYP7V3/sf5osKAMAdcgYFz50gmm1yBOh1QT+QhrCushINHhV32pAevpJhpYcKPa
         xu3KgVCjoCnHN3aduG+vHCOHuEfBpMcdSUoVBmVY37UaSbI3U1EI9L8UsDZlFiBGWCZ3
         Z6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUSE8a1i3gP0tZfz901etxB52I+FMCdNllTmsavTUhc21q5PvDn7TQwBm4IdaFm5lV92NsiKP0t+/ajww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyscnQYT9VqFJsqrilNtKeDbv8O6jESuIMosCeJzWdsHUVIcdHI
	j1JwMiksux73DJQAwOX6Vh5Efwr50beccfRNjGLXVo4yeuGjPkuYAaIHSmDvO1DgHUVHLsVdTlq
	KhFqz7gLX/l1I/VW0NAMn1p7KdZvtj80sJsQP
X-Gm-Gg: ASbGnctRT59EXwR1JYVBeyWuCsGu5qjaVHYNxH7VXL0iq2bQuiRbU08xwj36x1wYnHV
	a+8kZ0oz35GSl+G1d4LtZqkcFvYOk0s5wNoJqvSaa7BZrMADAL4skmosWMlJdOQgO2qoRduSbVN
	kuOjRaUXb4+PW0Fq0qP4LIYUsj5KnxhhlWfObRQ4zQT0Du7jttaTZ6ntjhQPRzIqH+TDZZBw3qY
	VRmGfe5vUFtLB6zFeEdn6N0TjHvKc11u1toxWJFH4+c111w+X1FmDe9BLPo4gTdksYmR2wWafC4
	9cpC+ixGKkqzMHqH1zdkJfuw1vmCP+WnoQobwvNYyyQ8SraTEQhPP6Q=
X-Google-Smtp-Source: AGHT+IFRcDzp6dRKyRTohkhLHoy+2gmV4Qd6fRsmWj1nAT8QclC/78sokZWYlZaGNnfqdUZkc0BknB5aEdRz
X-Received: by 2002:a92:c261:0:b0:3dd:c927:3b4f with SMTP id e9e14a558f8ab-3ddcfcacd52mr12122785ab.2.1749246057367;
        Fri, 06 Jun 2025 14:40:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-500df42b823sm118597173.20.2025.06.06.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 94125341D32;
	Fri,  6 Jun 2025 15:40:56 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 84149E41EDC; Fri,  6 Jun 2025 15:40:26 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/8] ublk: handle UBLK_IO_FETCH_REQ first
Date: Fri,  6 Jun 2025 15:40:05 -0600
Message-ID: <20250606214011.2576398-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250606214011.2576398-1-csander@purestorage.com>
References: <20250606214011.2576398-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for UBLK_IO_FETCH_REQ first in __ublk_ch_uring_cmd() and return
early. This allows removing the allowances for NULL io->task and
UBLK_IO_FLAG_OWNED_BY_SRV unset that only apply to FETCH.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e7e2163dcb3b..c4598f99be71 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2195,23 +2195,31 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	if (tag >= ubq->q_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
+	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
+	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
+		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
+		if (ret)
+			goto out;
+
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
+		return -EIOCBQUEUED;
+	}
+
 	task = READ_ONCE(io->task);
-	if (task && task != current)
+	if (task != current)
 		goto out;
 
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	/* only UBLK_IO_FETCH_REQ is allowed if io is not OWNED_BY_SRV */
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV) &&
-	    _IOC_NR(cmd_op) != UBLK_IO_FETCH_REQ)
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 		goto out;
 
 	/*
 	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
 	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
@@ -2223,15 +2231,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
-	case UBLK_IO_FETCH_REQ:
-		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
-		if (ret)
-			goto out;
-		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 		break;
-- 
2.45.2

