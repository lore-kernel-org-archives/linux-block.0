Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AF238C03
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160239; cv=none; b=l7CoDIGiBaV5JM5W5qP52jf675fAQrxJQQqUApsjC9qGA9FNmMQiA+8HmKX+GqJMQ1S9uJE5AguRDSM3Ze2t1uXB9VrBpV+YtVXDUcNn7l90eIKs8k5i/tV91dy3wX+hEh2vKGkoXok6o3DxrlRtnpfqWdxAB+b9r4nQ/sBsBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160239; c=relaxed/simple;
	bh=PQSg+NsLM1jaPnr5u1yPylTembKfBUItPrTQAH0AFug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJtrZ/0rdYk+la6thPmmd/RnLpnxXEwKe/UmU6IxzaiapohLuh+yYnlaWtLYYqz1NII4wZsv4ynYabt3ZAVMV9A6QwLlBPdu8w0EUQAK1x+3U31rZ5YyRI0m8zAEMzD/IVApOHNOPVPATsnN6rf8O6PxuuylTaajHYSKgk6y+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SZqXbgj7; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SZqXbgj7"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b47174b335bso17216a12.2
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160237; x=1758765037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eZ3+bX6WBSXtjdkD/31SI/WDmoI3YRtPN1z9wSuqAs=;
        b=SZqXbgj7rqA1AWZHgIzyISYHRfh3nx1mov6Evkq8jeguYIO89ONMD/QTvnaOQJGMZ+
         mubAGMBH0rtee+SBzgtLPgYL9K2ykwyPJtSH9uRH2FsB7Vr2JCia0VjX7BEgnLXDQbeQ
         8/JBipWBjBC+y4SkUzttbE9BRu/Tf1aWMDh8ZEDLRAJw62KS+KFCNLOmAsCoM+edQZy3
         vg28S8wLRLX8OkrCuo/YOWbJzcFx/ktTZPSIMdJ+E3gM5MlUh6/P/7l8NEk/tKiUnVau
         H6xAeKy0sjMNWz84Lr2ZUy7D3O7eio6bdtA+lSDDhYEmAZ9g9dEpJdIwZFmRR2pL5tNM
         38rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160237; x=1758765037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eZ3+bX6WBSXtjdkD/31SI/WDmoI3YRtPN1z9wSuqAs=;
        b=iax8KYHEsFmMt54qqoYYUtrs9xmTVjzkCIvi+OY3RGlQr9TOXU+o9zVclUDuykD5r2
         NeAj6tAQ5ObaU1lrEhcXdcRKY5H8qJT87HdJavDtLxqZSX+kPQaHUEYxNhr2YeJ+d0Ba
         LigRBFo1wnR4Ogjh53+tF6dOT+VA6gaOWsvw3wMtlKLdsz7j2UWm2o2Alchdf09DYIjO
         jHqf1hmEFx2nuuFxJyD6hBwzLrD/GzR85rCfhJLSQqhRe3yE+3jvWwBFA1aH0SMyZAtW
         9sy/xaKz5RhoV+rqPFtY2tp6fev+QPmRtYzjK254PIVjxaHjEHrQV2EIvBR5ckl0WarE
         q4bg==
X-Gm-Message-State: AOJu0Yxk4RvSUWpfeqWYi4j1WxAh86gAtXTx6w0UIrsSIJ/yybRCd/cE
	VQ09TvYNhNVpdkg5qITehW2a5gg9VAyE7Zl44Z7MtVowq2U2tdTeNMokq9b4LPMtyyBLanVTwE7
	aM6rKTfDqVtiLTDVvQJqihgCC7dSMCvpQKSQXFxJAoaLh102slu81
X-Gm-Gg: ASbGncsZdvnATgs2OGFBiYzTjsRVf231L3bi3IElh8qEEfQ0dw9cR1XQnWvsogrCGJZ
	x4zzudSMoCxxlNh4/RqiXWzaQpw3OLT9ZSx5JFGblCSHX8ZTO2yD5IfaBFFWM7XJd0c6lZ6ahZv
	0LdSJWnAuKY5VkXiOsRyDa/bfMhF9yBghkVWDPZeKae583Q+umXBYtBbs7RUGeSzhL6HUy7Ix7N
	hWs5sFO19ftupNPcZIH51F5AOiG1qJweuiqtRIJ1gyR0ae4PS0PbDI5tUF1KtvvaYW/8KmA0Nve
	40XlGmpHzucp9izvTMo7qPz66BH2UevEIwbHm9rWD0EVv4osGhfkMiPl5w==
X-Google-Smtp-Source: AGHT+IGpe3PKGk/dmNU7uwnyKBD/mitYkbE56glp+d2Oisz9q42fB+T/0U/g/b1NfT6i+UsFR0qJ3eamQB1L
X-Received: by 2002:a17:90b:3889:b0:32b:8373:203f with SMTP id 98e67ed59e1d1-32ee3f8b01emr2848443a91.4.1758160237037;
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-33062e1abc8sm78607a91.2.2025.09.17.18.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 60D77340325;
	Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5BF28E41B42; Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 06/17] ublk: don't dereference ublk_queue in ublk_check_and_get_req()
Date: Wed, 17 Sep 2025 19:49:42 -0600
Message-ID: <20250918014953.297897-7-csander@purestorage.com>
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

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_ch_{read,write}_iter() is a frequent cache miss. Get the flags and
queue depth from the ublk_device instead, which is accessed just before.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 58f688eac742..d6d8dcb72e4b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2525,14 +2525,14 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		return ERR_PTR(-EINVAL);
 
 	ubq = ublk_get_queue(ub, q_id);
-	if (!ublk_support_user_copy(ubq))
+	if (!ublk_dev_support_user_copy(ub))
 		return ERR_PTR(-EACCES);
 
-	if (tag >= ubq->q_depth)
+	if (tag >= ub->dev_info.queue_depth)
 		return ERR_PTR(-EINVAL);
 
 	*io = &ubq->ios[tag];
 	req = __ublk_check_and_get_req(ub, ubq, *io, buf_off);
 	if (!req)
-- 
2.45.2

