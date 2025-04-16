Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FE202C38
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765212; cv=none; b=SzXykpmiwSDCt0ngl9MtCFsS8h2ZUH3I8nAW+QoHTJczTdjfMf87ozRwobjuwUAJMkJXAk0ix2MxIIlFN1JSqnmtdIlbCGONTwxV6R+EcrfElstk4rDYaNWgwBL64LU8kl3kN/DRN5SJ/vKtiO+YsYRd8KjVMlyTnxg+9lARb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765212; c=relaxed/simple;
	bh=U1bGSc2/nLMY1+nk4hzmzUuRmIijrn47A/VZgqDeFSQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WbYh6jehT2GLh0FJaWLlFFKDLGYsxPOohj9d/410bm+G6UrjKGITx4e0RpJcXUoQuCns4WlOaZXGv+xGuWvj2eteda2U+T75miZilHaAWZh3GBjLQDyO8OzoK7ac17696q3E8KFyawMUcKq660DEcmUY6DYrvLPvdS7DjsThSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ALg9fH3T; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ALg9fH3T"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85e15dc801aso494384039f.2
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744765209; x=1745370009; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oCtxuzbiw7A2fjHQxchMMP5hVbTuD1H5d0tolsC0hJY=;
        b=ALg9fH3TG4ZtVtUq4MM+gyGvYrYf1JMzIWIFp8a8LD7Py7kxCZGsqqIyk4FmD5GIIV
         quNHmYpQ0WffWXucoWz7TEJsdtmbfvZD7nuWP98aaZcCTriK+OhLpigyy72sgPLoMRyF
         PF8qsIHJ0pw3ddQp2u7viqItdqQrPZiLFMMDxP/CWt7XES13y/loE3bKJThK5f7QBrCU
         lxPLirvGObysgEHuDKqNRru8gLbsY4mWCPuyFHc3TolvNvDX5fWKd4PegXWdWKVKYn+g
         W1zjBygqcY3KnYUeuA/uIqW9N4yJLWKnCrhmcAnVcYPJFmO3nr1WGlldnKtm+lxtJWEL
         cTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765209; x=1745370009;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCtxuzbiw7A2fjHQxchMMP5hVbTuD1H5d0tolsC0hJY=;
        b=BISK2TljO9hDnhnZEDZi2YK+tKMd2WaD2x2V80Dbx0Ukggirwq2X/cSck/6N2W+rgW
         lfFvXQTX3y2GXy2peNxK7xiYdcJ48uBTkzoM+gMyoxFsAfeHb6OY18nilLkbSOWAIjKI
         LVmeQ1llsJgQPLOeA1dOJmHZOCgIPw/BkyQ/+X4Fc+wHCObhgm+s1lP/f2Ep8iOAfyNQ
         fkrNRh/YSUE+BTJcA16uZyPxMIgpKYP37i9wkM58wT5sHE2F0aE/XeSuLBpAhFwpJqeC
         sRJXKWkHtPKxSTiO6VYglpRWMGjji3W6J7apmlhJO5M/rgF74M0ZACogakRd3H4rZaDw
         QDmw==
X-Gm-Message-State: AOJu0YzdaK2VCMXbKSIi6wWHfTzoYxhc5zc28255a9OUC3S7RB9QgMpP
	HAfUfu8P+VBAmpFwd0tgddPmEC7ObVhNPlE650eXUsFobpzm31mwWYG/vYJ8SkGUyaiLSj6nedG
	xtTLt+G+Sl4iqU6UNJf/kxfGL6UBu78zbm4cNEirPyzSL5Iry
X-Gm-Gg: ASbGncvislMiYlEfkDpLXj3OdKSiMmJrVXmb7PO9fw6H5J6CCE+jih1EA3BftBj24ht
	xLdiLVDFxM9W9uH+cZBfCVFRnFpDqx1UOwgM46/fTEmZSVY+Jynpne21bM4AyWPKLSXwEz00YAC
	+uWcjJV1EN/168l+Enhf6wjF4c9Ry1eQ+rPtWGmNUeSsBX76VAOvFwzRlI8RBb0BE3Mw4jXYjBc
	nRrQFiT62dN1zWOUTLRMWkyGM/T6CiBItKcHvv7TI1r9MNfxDajL/SQjYBVZLuakBsC+QYxpmhp
	MlbnEjRaQWvsMucPUbOpxG9V5TBqIY4=
X-Google-Smtp-Source: AGHT+IEcpjg7SzGB4NuiaamC7OJymu8iX3OpxT46nVTcfyROGQNAohxfp/QCq27936eQZhxInEAm9vHNLdCG
X-Received: by 2002:a05:6e02:3605:b0:3d2:aa73:7b65 with SMTP id e9e14a558f8ab-3d8124cdf02mr13580195ab.6.1744765208884;
        Tue, 15 Apr 2025 18:00:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f505d18f78sm735169173.21.2025.04.15.18.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:00:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0339F3400DE;
	Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id EBE75E40391; Tue, 15 Apr 2025 19:00:07 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v4 0/4] ublk: decouple server threads from hctxs
Date: Tue, 15 Apr 2025 18:59:36 -0600
Message-Id: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgA/2cC/3XO3wqCMBQG8FeJXTc5+6ObXfUeEbL0aMNS2VSK8
 N3bhCDILr8D3+87L+LRWfTksHsRh7P1tu9CkPsdKa+ma5DaKmTCgacgQdPpcmuL0fi2GNAVtqd
 llouyzkBXypBQGxzW9rGSp3PIV+vH3j3XhZnFa8QkA+CcSylUIkDrXDPK6OTDZmvccZgcxpppM
 Cn7O4nQzD/lP5/MnAK95EorhVldpbDNiC+GwQYjIqMZQ13LNJXml1mW5Q1PjeVQOgEAAA==
X-Change-ID: 20250408-ublk_task_per_io-c693cf608d7a
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to allow ublk server threads to better balance load
amongst themselves by decoupling server threads from ublk queues/hctxs,
so that multiple threads can service I/Os from a single hctx.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v4:
- Drop "ublk: properly serialize all FETCH_REQs" since Ming is taking it
  in another set
- Prevent data races by marking data structures which should be
  read-only in the I/O path as const (Ming Lei)
- Link to v3: https://lore.kernel.org/r/20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com

Changes in v3:
- Check for UBLK_IO_FLAG_ACTIVE on I/O again after taking lock to ensure
  that two concurrent FETCH_REQs on the same I/O can't succeed (Caleb
  Sander Mateos)
- Link to v2: https://lore.kernel.org/r/20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com

Changes in v2:
- Remove changes split into other patches
- To ease error handling/synchronization, associate each I/O (instead of
  each queue) to the last task that issues a FETCH_REQ against it. Only
  that task is allowed to operate on the I/O.
- Link to v1: https://lore.kernel.org/r/20241002224437.3088981-1-ushankar@purestorage.com

---
Uday Shankar (4):
      ublk: require unique task per io instead of unique task per hctx
      ublk: mark ublk_queue as const for ublk_commit_and_fetch
      ublk: mark ublk_queue as const for ublk_register_io_buf
      ublk: mark ublk_queue as const for ublk_handle_need_get_data

 drivers/block/ublk_drv.c | 205 +++++++++++++++++++++++------------------------
 1 file changed, 100 insertions(+), 105 deletions(-)
---
base-commit: d3b4b25e363e4ce193e6103e64f7de12b96668b9
change-id: 20250408-ublk_task_per_io-c693cf608d7a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

