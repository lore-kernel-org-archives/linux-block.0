Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EE2BE7BC
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432221; cv=none; b=ZhJYt8Bad1SRV3wD2K0dieuBcOBm1TtcrkPiSvI2aRNAxmcVKKE17dJ8aDubwRMc2xYoTSL0kYwvwX/GSf9wU7xA5hKjhWTnH5uVKgaB3cWc2MnHQ9nndXJtiI4Aih18BUpykdMeAbFhiQL4sl1iSEXG43t216KCap7hoaImRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432221; c=relaxed/simple;
	bh=lKNwObrdchFUPZZFEvYZpYC7wuYd6i4aj5sPg2u5iiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecLEsNDfWBLlQTrrNSR1IJAP/izBEQx3YvUuKFYylLeRrA2/P1iN2Zy8WdqnBFwMdhSvEFlKt2Fe/3+m2h1ptU5QaF6S8MEXS8ASAqYBHP/B2XLwqgqn2ge5enezeMfV7FCMNVpLaHf16q8FCn+V2nak60br8N5taUuAnOct30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C0kkTUw4; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C0kkTUw4"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-52f28e83e13so79080e0c.2
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432218; x=1751037018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehyRaKf8fvNjMVDgW9JnYgUfBF+xWKOAxVTWa24fakc=;
        b=C0kkTUw4SzBpkf4umuipSFfIp5S2pyO0yxkiDeJjRpdzuPtWc9bDphrPqgxhpMZXSr
         M50842MGqlzOP3mlUjfEgp5YZbB7OYnc7U/jo8PUXuytStl1XvvJY62//5zjsgNX/at2
         HPXShQHWMjguscitPHnW8BNQTaeNFD8qhK1cvLYaxHG2qfLf9p9JJb7GppQR332trdhK
         A2wJAF5R7a+/5OF8JJyfWD2QEh9JAO5oVLXsXHB3p9MZpdIb1+XlQh7KzMV2BiGl/Mlh
         dLU/wYvqdDa61lQjoBXSqTtOEJbE78rb3Y+QYnRPCMk9uTsDzcKFmaGSsq1TuMYk6vkd
         barA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432218; x=1751037018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehyRaKf8fvNjMVDgW9JnYgUfBF+xWKOAxVTWa24fakc=;
        b=gPiDxCYc8UpvruMRY7HwcSmmrmC66cCwfX3nO/TmmiHdhxYAxziPrCytvjz42h/yCD
         1M9fIInuO7HfMQQNXSMnQ7FwZRAPzHaRNvAr0xv5KbwNWNg6hwFkYQ1Q0uf7gq07zi8k
         br8aMQs+RVgX4KuYDdh2f386C/ecMm3XqkJAHM0mjN9WWI8U5J8gBS4vnafbJ9R37Dkd
         e472kvmvXw1iyqwtRHtIUHqP+ZHOpEOezS7q3APZatPWhbcaICgD2D0I4/WwiggpdNpO
         3Inccv7D/59/y44w+7uh1p1ly6K7CgFuwM3fl714pBIkBHuBn94lKA4r5aMYkhwZV1Ui
         Pm8g==
X-Gm-Message-State: AOJu0YyOd4ggUbMYL+OTHfYRBz6k3IGwkQpkyX9tH8ikwnXes1BxR90O
	cVrVSzXq9DnYjASWzb8BCq4eZU0CmArQZV/rjBE3LJeEV98KS7UCivXxWUzZyi/XxiJsnfcwiPf
	5E2gYNuSGazNzLOinkvxlHy39rpnrL6OZ3VdX
X-Gm-Gg: ASbGncspETlXfUQ8zP4phs3JikKTYbGc8HBngfXaxkOJBLi+8r/qsWkQMCN2/h8XQbA
	k7vzrEszkkmnI1YmGDgwMEtEzbvAlE2rym4XAp9e9qsxngIzlx6NPzWfxbSAKIn00jQLGJ52Z4O
	hRCdUk61UA+I89c18wODPlQ0h2AJH9r3I1l2T+tXv1E7lZ06zz1ArDutZUSKurkDwup8X1XMW6C
	dSI2Nk0aIC2/kAo+AljtGmUPWtpVK5lcEp410hk/r4QG0J8Bs2pyeyRZnflLVHALNXQr6luZ6Xf
	yNFonhPL6pVYMiFPRG40ld8nFSb7YFFCta4W03j957hIwsR8f9S44bM=
X-Google-Smtp-Source: AGHT+IHpX4MGhnOkGsp6HXQXhAGNyEGIJiJMK30zpAI4Twy3ML+6S3f19TdKTCHWALVPSsK8LKgUwI61+nbz
X-Received: by 2002:a05:6102:38ce:b0:4cd:43d2:1b05 with SMTP id ada2fe7eead31-4e9c2a6b927mr630418137.8.1750432217664;
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-8811ae4d225sm28938241.17.2025.06.20.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 99BD1340747;
	Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 98753E4548E; Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 12/14] ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task
Date: Fri, 20 Jun 2025 09:10:06 -0600
Message-ID: <20250620151008.3976463-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_io_release() performs an expensive atomic refcount decrement. This
atomic operation is unnecessary in the common case where the request's
buffer is registered and unregistered on the daemon task before handling
UBLK_IO_COMMIT_AND_FETCH_REQ for the I/O. So if ublk_io_release() is
called on the daemon task and task_registered_buffers is positive, just
decrement task_registered_buffers (nonatomically). ublk_sub_req_ref()
will apply this decrement when it atomically subtracts from io->ref.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b2925e15279a..199028f36ec8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2012,11 +2012,18 @@ static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
 	struct ublk_io *io = &ubq->ios[rq->tag];
 
-	ublk_put_req_ref(ubq, io, rq);
+	/*
+	 * task_registered_buffers may be 0 if buffers were registered off task
+	 * but unregistered on task. Or after UBLK_IO_COMMIT_AND_FETCH_REQ.
+	 */
+	if (current == io->task && io->task_registered_buffers)
+		io->task_registered_buffers--;
+	else
+		ublk_put_req_ref(ubq, io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				const struct ublk_queue *ubq,
 				struct ublk_io *io,
-- 
2.45.2

