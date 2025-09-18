Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68F23741
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160240; cv=none; b=nnuiBcJcgz2x+x8ERwku4322tPAVFR6J9tTQz4pfK1whv1FsSWia5AnDGn2ADugqVWxGFpFwklfI9YmmcLN04jtxPuNWGiCH6CLP89CujLRVL05Zb2yVKKm3qrPrTjplDYV1IoqZkelyt6zxWBEWDjdyvLrLNg0M0yB/CgyTaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160240; c=relaxed/simple;
	bh=SxYD5WuHLRPoT/cs6wVVOR8hP8iZlHeIqgfFLbpvcHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUqKJk+bR9+IHCSgid0VzrNCsNw7qxsc84t370Cd25Z9KSXKp84L8f9LeNPViMk4CNCDnmfQOwhqCqGfyYRbyQjviHtRkHUwEYZOFIwHaNBi1/vxKpYLkDGKn05AZO6JZ9XtrKLOA9aJMgiBJSQpEd4jwWR4K/R4GIUQhPGRJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z0ueULhW; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z0ueULhW"
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-42409128eb0so144185ab.2
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160238; x=1758765038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHN5LrAZcA9wf+X46VWuoZMibI+SFl5Bk6BxNvNG8fQ=;
        b=Z0ueULhWplm7sJ2jk4hAVpBK2/dMWxuGipITS705kenj4lMxohAZQpFXOyIwvaVmKx
         2t+RmjXC/c3iUk1sLg4bmFgv0btgNLpb61+qfQp5B2ARXzjgVV7YDT5JIoOACOQ9o1HM
         kvn9m33SCegdXETp2Dr5heihU243+4CqbOn4RZW4csGFIfz63q7q1LNIQ8xxIFZEAL8D
         GNfFxCYsQTw096AM0U/17eU688UmSdXil2xaJ1oKqd2FcNzRBQlmE+BLaBtHIMBrqcZN
         zBFCM6DUQwElwpyacbhU0X7ip/PlYEOW+DbXBjpMn1M2JW8ZbP+GDtR1pOEc/D1H+8Oy
         2a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160238; x=1758765038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHN5LrAZcA9wf+X46VWuoZMibI+SFl5Bk6BxNvNG8fQ=;
        b=GcIs37RwoGevIcu9L9paxUqTx7RC537I8E57gNA1yUWT4/7vJqRTRM2eKueDC90Izf
         ctE3cN2UsjpF9ep3XjY7FgwZOOszZWGhIhmkqT6WdbluUJ9Qg9zRHGITE4U5kFRIG7V7
         KYy+BEYlpbgy/mV/8MUuk5mvg7r6xqJm9i4jBMdxunNEeP8uD4JS5eF4lFcMRDkHOTd0
         g8Q/3TpiUofwT2nRQ8Nv6eLuqAo7wFxfXbw4JHtssQIS7ytc3RlmQ2Ll0EHCLI9tfVCD
         +fHFzE9nife7JIIskHWZliYDEYCfLPzruJcjVImZ+GbAv5EhuAnS/uSoiXrQ3Xso2PmH
         VJPQ==
X-Gm-Message-State: AOJu0Yx04+Qm+JOgmiLgRzt1bUK5NUHt2cGtSGREIMcG8DhoRB4nBDBu
	FymtITL+ZiUVqPPhQfMtWlYG1foe056eRJzRtsJ1GbY+bU89F7NF95LCV1uPsJl8Xx9Di7NJs3P
	g5A/wrOIfh3NVUNhQb194dVqcAXFRCp2JcQGw
X-Gm-Gg: ASbGnctJ0CjEvyIsJwl1HtB0zjwfPzAtU2Iy108du6Q9xWCXZD27v2WNqEMEzpKQ0Pl
	e3+qMFccM5RDRU3GeO6ZSobCi4kw5x8hLQrsiWHUmxJPLw01MALygb2wSQHKgp7XLTGQyJvBc03
	ZilU36UVdk5tm/PT6/jADymqeDShOmAwnKuk0DIMJVnp8MEZ3NXOwwQv9Nf1oD8ZZienzhnoNlz
	iyaYM3KCew8LqSNzCCuMml9NHAoS4uVLMO3NCv3VLmrXB8Ot+PZIycpqSquRxMExUF/ObjatJei
	ttX42Z12KFpRAb/tJdZ7MFtWXEwXD77itjQo8WE8xN9sMRIchzJhgZ8C5SyDcGKfuq01hRUG
X-Google-Smtp-Source: AGHT+IHg9ormGeHNVdb3lk5wKhpVB+m7oJDCUTFeC6NzfM31elgAomyyVQtn+PodMnXbWY3OkRmL+hjR4jJD
X-Received: by 2002:a05:6e02:178e:b0:415:8117:d417 with SMTP id e9e14a558f8ab-4241a563cf4mr22899405ab.7.1758160237761;
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4247353db28sm47175ab.32.2025.09.17.18.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1E83E340508;
	Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 17A29E41B42; Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 08/17] ublk: don't access ublk_queue in ublk_register_io_buf()
Date: Wed, 17 Sep 2025 19:49:44 -0600
Message-ID: <20250918014953.297897-9-csander@purestorage.com>
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
ublk_register_io_buf() is a frequent cache miss. Get the flags from the
ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb51f3f3cd33..751ec62655f8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2131,11 +2131,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct request *req;
 	int ret;
 
-	if (!ublk_support_zero_copy(ubq))
+	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
 	req = __ublk_check_and_get_req(ub, ubq, io, 0);
 	if (!req)
 		return -EINVAL;
-- 
2.45.2

