Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F705224AE8
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160237; cv=none; b=mhSOmLNhC8lENBpjAuJTsAm9XhLWeeG3jEBXIpNwPUyrLqGqhGQc3hOPKyZX/C2zilCT5BH/Ja3nR4psnLo1ms3dnRaQfNhSNRXFynuDk+7nudS3GxJyBK6RmNxS+xqrOsYpNoPl1/muqFK6+9q1AajSPBy4HR+FKZzyDeuXcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160237; c=relaxed/simple;
	bh=JZ7WeEWAd1kWAVhMIzhhWXd+cCffqQi8fUXv/IWzAcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Myl01R9ngrfMo10oHNBlA41GthkvsTyv9mzbuQthlLgRA+/nzYBSD7kgejlcClzV5TU2EkytuQgX+SABCc2UwOUPgkF3i0JYlzR7Y+Y2vg5R5Bl2UD23bGAM2WQ0tuEqdVQ1L327XJp6hTp/Yma5U+PrcDPoGNBovQ532VbMp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kj0VVmWx; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kj0VVmWx"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-726fbc53376so39966d6.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160234; x=1758765034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm609mzNTyYSUqGencYamb949uYiGedbBCUE+WH6KPU=;
        b=Kj0VVmWxjVgManHyQfrwCbwfVSttvDoApACYghz79TbU8fM98kSz6lJULsVRXOaZ3b
         YjFnNc/6GkujNhfA0anQ6kiwP39J9U0XxUwii2YeyeI/gN03ZyzNnMwtZ8kQOzCIph5H
         2nVOEO6UhaIlwSMgyipcG2w/12DJwpto1R/PrIBTMm3iIRJrKiVsyxRhhKZ2Vvq51N8A
         QeIERQBNtA/HpSm5R3SrfoIvtrXXLfSFUiXWFLqqzPnQPHBNswPAle2xNiK2KS/I6urA
         ZxyVm0wF93DOMS4GNrE9Rw6KU+hgZoGRnGPEbELmKfkzjCdyMPeegmsS+b5dUOTv2vQ7
         +6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160234; x=1758765034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm609mzNTyYSUqGencYamb949uYiGedbBCUE+WH6KPU=;
        b=QHrfMtDgm2rY5ufroY3ytca08/uHpX6SZettLZL/i4J0fO9kI17KWzZn/tS+pYdtMC
         /OnazhJgiihSBlg2KMTN4RTIvIYqTW2ZJQXGcXewdVhcieCcUInmvuJixFP3DlfXNaaf
         XVcFDcadAryfuvSfHOdzUodc9w6Kbmt+0bufC2n8gUaejkfQKMJCzdrnDNMijXLSYuTN
         mJWmTAw/lXLGtpEyDpv9lWtwpHJeeuEzZOdvavlqcU+e/Jj7E/Hv3+9Z1G0Y92C9fV0q
         V8jYeb7S2iFV+21oKY6s+0rRLfdqyc3qeEhUVEGLgDX7HGyZ+hpbpaXmFqodBVSksrcH
         HaFg==
X-Gm-Message-State: AOJu0Yw83yFhyQcEOKW/4qAjQ3sLFk9KZsGFRZdzqbycp/L8okgVm39v
	sLsPl5uLttzxtWiheuVvvnkimPSDl9LF59OsTLr134CiCCvVbEX4KQfW0AFNSS7jZcP10T9cD6u
	oAhRZ6TnKJUXppOGyr/EyN7buiavHO977Gky8Gu3L2zdnEd0cJFzB
X-Gm-Gg: ASbGnctMCTUllJyq1S/J0bQMAvwVW1hKi9PxBopICDzcEpSXHb22Knoqul5qjc4+oWq
	yyoMpY7PKg2LU2ux30oHI+JMc/0uh4HnZ4npfDadzuykz7Nv1KhtciCynyLEJpJi1i2VJrgVs79
	vHqZSagtjqs+L5WjVZxRSDn+FaNkjGdcw4OOAYB1j970daJwwy2r5gSpvDMxZ7eh3ca8jcF3gEA
	tcLEy0uwAAD/dKtasYsW7vpsG3NbT7mmZVQxYpMbeXX6fScwqZgjJ4XzsvO3rtb9OamCLRYYSFD
	dxRy4kNXoou/O4cMHSOe5NnaZ5gA9aJGz47Koj/tBkoRgpLgmOPEo5VrqA==
X-Google-Smtp-Source: AGHT+IFmQ0KaH+u8epoMwh3aIK0YZmepufL4TwiNbT5S06XDLaPCdbBhz4ar/7SSxBpTz1Uuyu5XuJnEw/2A
X-Received: by 2002:ad4:55ce:0:b0:78f:baa:5712 with SMTP id 6a1803df08f44-78f0baa59bbmr21116976d6.1.1758160234441;
        Wed, 17 Sep 2025 18:50:34 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79350777108sm749816d6.34.2025.09.17.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:34 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C1B9D340325;
	Wed, 17 Sep 2025 19:50:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BC335E41B42; Wed, 17 Sep 2025 19:50:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 01/17] ublk: remove ubq check in ublk_check_and_get_req()
Date: Wed, 17 Sep 2025 19:49:37 -0600
Message-ID: <20250918014953.297897-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_get_queue() never returns a NULL pointer, so there's no need to
check its return value in ublk_check_and_get_req(). Drop the check.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index aa64f530d5e9..9f2db91af481 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2493,13 +2493,10 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		return ERR_PTR(-EINVAL);
 
 	ubq = ublk_get_queue(ub, q_id);
-	if (!ubq)
-		return ERR_PTR(-EINVAL);
-
 	if (!ublk_support_user_copy(ubq))
 		return ERR_PTR(-EACCES);
 
 	if (tag >= ubq->q_depth)
 		return ERR_PTR(-EINVAL);
-- 
2.45.2

