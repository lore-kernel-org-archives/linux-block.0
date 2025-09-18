Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDA23AB81
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160239; cv=none; b=AVuQXX5rkIhRd4LzZUJLV3vemyrF5D1gTZtqVizTGFQw1SLi8QAU/lkealchkDFmzHD55+gdOSoYCEvZKi3uEJUT3eiviidzsAx3UEivFzKQlE2Z+uh1yvdStr8yefCs3S8Dix+S5rn0NcVHr9g/xwXA2NSHstww7aV2tmT9q0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160239; c=relaxed/simple;
	bh=8fCwSybfSb+ztMiEZfG9Uw8IwGt/oQT1hKJDe6hJClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+yUtL+7y0ow/POsCEb0zRGAWm1+NCm6oHx/ui6mDZhuR1DHw4YCvj7gnPzoqGbOz+fO71vZ4dfxF4jc7lEflLmKFXykwVHVtZd+za3mqG+IHdjvhqLgeSGBedIYYJ0SrJjFpA3pGvsnCgCEK6wb/hkGl1o2mx5SFWEQde4DLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QTNBG51p; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QTNBG51p"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-315333ebc1dso91061fac.3
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160237; x=1758765037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hlg0LwnvqE1ZMcyukI63UK6V6Dmpb/JL+/bnCbL9es=;
        b=QTNBG51p/hP85+GWjau3NYEheZiYjP2oXDNYlaMjdZBbJuFOTzUq3zTjmzugMMocU4
         IcL084OIYrVqkjKjGlaMrULqjbTiYacGsEcBlj/s2lzmKs5UjQgKRxj3POFd76aPqrKL
         FA8PJdCIOCnqDRVmRPa++zO5vmzmxDHP8PV4+cI2MnT3eX3fEbF6C0VH9SNzQvLM6lrE
         OLjCl3xOpmAH1EC+rLOOjGWuWwPTVgseeibFUEnQLUsFtUEsxirhj8GvkxqTWm6Wnt6l
         fWHhznitS5k0BSZ13nNL4haCrvndc3pZ3zLYaamLQr4ex8i9TqT7WEHqNs6PBc7/Cc3G
         kGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160237; x=1758765037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Hlg0LwnvqE1ZMcyukI63UK6V6Dmpb/JL+/bnCbL9es=;
        b=KF02wyna3a9DCPI3bKI/zT+BCXE/C1XbnugRg+7WdrK9Out0vNBxY9YDqO8X2h3NNk
         ylzItyCL6lFrnAbNpiKDjVV74YUphv/Gc+EaCezPBCXBpMZE/hlRcrNdk0Bl7CYJcFZO
         wBgij4Di0sMziCaBU4wMg38SGWYdcMA2JDcxZvcgFg5NUnirajJTSALobq7O+Eu+K6UY
         O0IKeOM/KAkfuG/TISqF9BGJ63F7ouUUXcoikOV6LP3C/pChMnOve56SPeFfHGkHk9vu
         Uqjer/zvCrHcaLoDg6piEW2jwH/EEQuC4gFmjsCzvGg8qukPZipeyDcFsZl4PsEYtm5P
         w2ag==
X-Gm-Message-State: AOJu0YwY/4u7czy7PAfTf7ct52VoL0YIgYlod7R6PolSRw9ebxpppdJw
	w0FdFRNbpmDbLiiRsPkPqu+vyRYbJcVT0hnIDhNNYxjAjGXjHGIzek2A/p9TqcyveAQXSH0YYKm
	4CcKz/AJk6D0lpDyF5zaz31uzENufJoH7VYq1kGnroyKBItat8y0h
X-Gm-Gg: ASbGncs5daSdME0P/DcKuIoy0IOcyGhwNGmBIbvEWyAyhBYuReor2qv9WMm5uHq8C/a
	iuvLr5bSqiuUdLsyTDVOiIsUDJEcFI+PSzqxJZ3K+wnIerUuhDlDkRdacwp2CajL8eIITZrPGOP
	x9haR6YVYGdl+vCiUYMLBLQhOCiXpsaBqaX0fPCIcgZFWJm7qLX70iamKpdhdweE8FM1fzmnv04
	TwMaO3E5y+tsbl4ol0akayECModkGQAIojJxQ0L406k9vFEcV4UuJ8L3S4wFaLC78lZrtX5iHcz
	lSJI92opkkj17RS6Kv4WFb/PaVUP3CQ2jiOIzF9w4G+a7u+XaChuOK8P/Q==
X-Google-Smtp-Source: AGHT+IH05i5HOyeOVNivDI54AuJFBG+1BVvOmWfCFFlEmT1TpgGivNz5pQWfiOVxR1apuSbY+NQLUExwZi6T
X-Received: by 2002:a05:6870:320f:b0:30b:81f6:6bc4 with SMTP id 586e51a60fabf-335c024c218mr1080971fac.6.1758160236712;
        Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e4892c35sm122214fac.11.2025.09.17.18.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 04C1C340508;
	Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 00DD7E41B42; Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 05/17] ublk: don't dereference ublk_queue in ublk_ch_uring_cmd_local()
Date: Wed, 17 Sep 2025 19:49:41 -0600
Message-ID: <20250918014953.297897-6-csander@purestorage.com>
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

For ublk servers with many ublk queues, accessing the ublk_queue to
handle a ublk command is a frequent cache miss. Get the queue depth from
the ublk_device instead, which is accessed just before.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 04b8613ce623..58f688eac742 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2331,11 +2331,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
 	ubq = ublk_get_queue(ub, q_id);
 
-	if (tag >= ubq->q_depth)
+	if (tag >= ub->dev_info.queue_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
-- 
2.45.2

