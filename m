Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC82356DB
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246060; cv=none; b=PPgQbKrId27OmdwsSMzxp47Cn1/pjrEmTbaR1A70+PuVmfsZMD5pijLSC1zFDLkXTkB3kOsYyWmTjaIPyUaEsJu/YoE/ygckEdkRC2neGRvSoGJCl3+zbcWEat6aCOXfCec8GHjU6zipWPDROwpuYabS46jRsuJpSL7Z/5RUmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246060; c=relaxed/simple;
	bh=2dPOKI4wT7upCDgEeJd/FpUwZT+IXiDVnk9mIU50Yx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYgIFluKL0X6ouWj1HvJYu4iBOE1M5h3hZ51wdqDhGd1Ggrr3vjgjyB4A6pw/coHWk+aDJMDSEeZUKoVySvch+uTV5Hpjf5ZdQYwX6wRc2i700TxdOTU4wGJbGEDNr2uVT5Ia6bmMKr0U2zoETAoyHTfQViHMiCh8dtYmD9BcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PZDZIC9J; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PZDZIC9J"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3ddb762ef85so623505ab.1
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246058; x=1749850858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewRlCDwUp4rK06EnbO0PJ7rwd3qKpkGs4RQOkLQkq+w=;
        b=PZDZIC9J6/OAZ8tNcVcaFDXznq7nSPDdFO83nECoQmU5ETG6Aby5r5TyMNEJ4+aZFP
         2We66kg3J6ObOspu4Qi2rHvBegvaGyPM7AmeY8c/kzgMSgtNrha8EW4KA93QNzW0SH6G
         dfblNuceA6kx3BLaOKhOwuAIAFx2cqW2Eah55QTIceCgeuU9nN/sL00QMbvZurks/23L
         rREcJdAFPIy/z0j941YBlioh0oqcvgnlon6VICadK78ugZxSTH3q+Myn76zbnGhft0qI
         4lIpTP8anIW/W7x6ppNb7t9kamQqHALhCmfM+kyvv4i0a0gjU6U6zuYLP6s+6gKOKukG
         R+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246058; x=1749850858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewRlCDwUp4rK06EnbO0PJ7rwd3qKpkGs4RQOkLQkq+w=;
        b=A7udviho4w+9A8vKHIwHEazlx8MvtU2Mb2F0JqZkEGRLnwGsoYyk7fztt1QnlBTOhh
         SVDHeLjsSPHaqSlDMGfyqyCtdaBT4G0S6L7gR5BE85vSp/pW4VrMibOTXatI+BmBhqcq
         TWsLIAiICK97blV/0LuSgCqTm9c1oLrhDyiAnfCCzzpZLXPkY8SM9gWZKwrqX1KI7P31
         XSwPJJRJ2AQXny5HBEzCC/YWuydrUf25g62JmzQuhNyzAP/eYU367AADkKnIUmOqRlOA
         XGiQfaGtC8mhZcE8iftI1F0YcM3BbjOvlEdCNlm0ey1N1o7j0L4euK9RhpvUQKDw9Sh6
         uz2A==
X-Forwarded-Encrypted: i=1; AJvYcCXojooTADTebXP+H86nU5sN420Fiz3ftrYf637nI3zQ97+36sE7SejU5uSiPgz4khn2DiOFnyLbA3ibrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22Kd5uY30F0ThAsHQVbaojjTOWciqWM7Nx9XR2aNeGcHz/W0g
	KqFFAcxc/SsUDkjcl9TJerGZ3iVrBW8NnAi4Z0Z4QJ/OEP6CKizACMFTXnInaa8shFJmhvPnjQp
	sl9PXRdTgLJnxosFl4C/Ir1jR2nuifcLdBhDv
X-Gm-Gg: ASbGncvQGKrRAN/crc7op/uRHiWuBYkzjsH5jfeu+x8fb8QUZl4p03nyjlpAuwGiXGa
	62NpcOYF172OLtBUmJ95+LMgCS4erWpTdeE3CoMd3gioqQAZVpesT00kLQOea8uKEHIgXa2E5JX
	ifKaIM1sQg5TwaxLc3OWJbkm9LPVYYFj/T0QSfEMQPUZv97wmDeS5FofKmyxS6Gl1QOhrKYoYRr
	6ep3oap3b3EQwoNJz++/bwCHV4WsP2YMn3qk2txfCIVtgP4FglV6Rl1FSjJaNhu96+zZXntYZHg
	g2/Qf5s4pWVTQSVL8m3DQeIjD9mEZHcSWIcV4js8H/dN
X-Google-Smtp-Source: AGHT+IH4z1Y1EySrJfluPM3G5azkHCPb6yTYsSiOVkvpAbTiambUGYlUlWOYXLia/mcLJNeeD74KYYL7MEuy
X-Received: by 2002:a05:6e02:1905:b0:3dd:b515:ba7f with SMTP id e9e14a558f8ab-3ddcfc9db44mr11137715ab.1.1749246058279;
        Fri, 06 Jun 2025 14:40:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-500df47bf5esm118230173.32.2025.06.06.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7D0AB3400F3;
	Fri,  6 Jun 2025 15:40:57 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6C011E41EE0; Fri,  6 Jun 2025 15:40:27 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/8] ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV} checks
Date: Fri,  6 Jun 2025 15:40:07 -0600
Message-ID: <20250606214011.2576398-5-csander@purestorage.com>
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

UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_OWNED_BY_SRV are mutually
exclusive. So just check that UBLK_IO_FLAG_OWNED_BY_SRV is set in
__ublk_ch_uring_cmd(); that implies UBLK_IO_FLAG_ACTIVE is unset.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 76148145d8fe..295beb6ab4a5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2208,18 +2208,15 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	if (READ_ONCE(io->task) != current)
 		goto out;
 
 	/* there is pending io cmd, something must be wrong */
-	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-		goto out;
-
 	/*
 	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
 	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
 	 */
 	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
-- 
2.45.2

