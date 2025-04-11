Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4EA17E0
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744330691; cv=none; b=r+qi8rgp3ghqvSnOwmv6ca5R0y2Osjg+gg785PIzRcXV0fLI6yIihfCTIDqaGJpGWc7Dww/8S8edL+JFp2d4K8W7w9xU/4qpSYryS1wju0Cbp3HcYyAKWy7ZZqrCsBmk3b3KI5svD3sGNOH7LfmuZ/S0s72HLB3hwTTMhGQbh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744330691; c=relaxed/simple;
	bh=dzI1O+aMOD39xo2YXQbx+esok/jSsAztyN9y6J3QSXs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VJ5CanCzq8+0FTtXsIpYETxrurOzw81idmwu31KYhNykgqIi7dr8GjjaQJGzL9CdjvXRmz4IJJZeh61sbavCkJ9dvcSVrIiRnXdQyQKe3R0fzPi+vwMqcec1EOVa5o/Z0hVWBcvt2oidUgammYuLmgRc8JalFzqDpeAs3JWPGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Sz9PUFGU; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Sz9PUFGU"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2279915e06eso15350895ad.1
        for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 17:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744330689; x=1744935489; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkwOAFHiSAgw7bl2ETmwkr2cSGVxHPvXKQOQaTU5564=;
        b=Sz9PUFGU19bF90mldbllJcMHqR5TNZosvSg2YCAPF7ORcn+4wKQugOm+BId6Vnmst7
         uRo2WkaAAJoL2JiAQGUAqBwZKROe01qHzo5frK0BuR9IZDosAQF1Qth2aiKRXhW6kxyn
         38KQCH1nOcXLkVbnhltFf8Tx3EjOMp6KxDcr0ZN2yCSFldS2b9C/sDqXJCh30SFrjtjw
         XxvJQJedkfinHZJWp1GyQ62kH7N8o0KNpE6bG1pCzQ7QKR8NZFCbdbJhir/YRC7aLKWq
         9WeZr1ZE9YTMN1rApY3dLabGP9JCvrE/oE2+I7YWFFmqkbfkCSpOjLd5Bgrm6UKzTHi9
         Ho4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744330689; x=1744935489;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkwOAFHiSAgw7bl2ETmwkr2cSGVxHPvXKQOQaTU5564=;
        b=G6ccXCSr23QdaHKy42bsMQjLIUemLpFVTBVP44WgCeAOYN1lNr/m3sRLtb6wuS65rE
         4aQ8yiq0rG7w5Hi7Sxi4B+ul9jwLPx/srzMknYLqrQfuSa2NxTeewjJHOBE/zGEptgQx
         2OZONiOb0iP95Buf0Y128wpy9uFEpLmihf6iduLGfX7oeAA5vCtDTwU1mJPKyNZh9FTs
         uHU87+MdftY6EsamYv+/4/2knPAWRzRMrBTSyxnQKabPAgvTV9oA+9TUBdgcB0ez0rcl
         /xReSI6bMETraDx+qczibf+sBt3eNRKgGyI73c0ICyfN3t7UOSXsa5RALMwAMc3696YK
         qW+A==
X-Gm-Message-State: AOJu0Ywsh45C4Lsa/pjP6qZeEpU2P4voP0E3ujprYF46llEHGUROLywZ
	z5baPSzhRVI6O37aj7v0VRrsTXK0lkOyQIc5YBEaODjJ5+t+pekEuRBMqrCDndLnDUC9vKVO7jy
	06j7+fBsoq5La2JCuKFSwuX68eyQ0wLFQ
X-Gm-Gg: ASbGncvkw3Eu1U3w+33w3h7sMW75Pd7/CyEblNCstgD0r88fQsxcpt4MzkTy1lgtnTK
	vqBwvAi7H76jRuzz9jhBIJFK/UPgLVQuHfYnlWiSbODCAVMTUo9GCUIBrDrfnOm5Gt3BmTmsvDr
	W5irWkvYMld6Wa72l4zyfDtOvC5b1FUVHDL7+0yXnDGUsyhrA8htNVR9PzGwW5wqui4yYe8L7ah
	iJYbznP5goHOOtVFrqN/znS1TGluS7mn/4IL+ACwgIDh+UA0KBAJxty+hfRtYpzabacAt+5TE3m
	tRFLQ2WOC1kLK/FeQoxX638NOkQHnlG7VLCGs0H/xuWjbA==
X-Google-Smtp-Source: AGHT+IHW2xlO6DzQfu1n6gyqru/VNydUvYN97wsANdr81J8A/PGKeAgdmmZm8L39L2wYjRWN/0ywIF/yopCJ
X-Received: by 2002:a17:902:e5cc:b0:224:1780:c1ec with SMTP id d9443c01a7336-22bea4f181amr12661725ad.35.1744330688614;
        Thu, 10 Apr 2025 17:18:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73bd21e50a8sm17278b3a.13.2025.04.10.17.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:18:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CEEF234029E;
	Thu, 10 Apr 2025 18:18:07 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id CE8CAE40E9B; Thu, 10 Apr 2025 18:18:07 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v3 0/2] ublk: decouple server threads from hctxs
Date: Thu, 10 Apr 2025 18:17:49 -0600
Message-Id: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK5f+GcC/3WOQQqDMBBFr1KybmRMoold9R6lSIyjBluVREOLe
 PdGoavS5Rt4789KPDqLnlxOK3EYrLfjEIGfT8R0emiR2joyYcAyEKDoUj36cta+Lyd0pR2pyQt
 umhxULTWJ2uSwsa8jebtH7qyfR/c+FkK6X/eYSAEYY0JwmXBQqlApTeni42av3XVaHO6abjEx4
 5PsocC+8p9PAqNAq0IqKTFv6gx+M9u2fQApKRS78wAAAA==
X-Change-ID: 20250408-ublk_task_per_io-c693cf608d7a
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to allow ublk server threads to better balance load
amongst themselves by decoupling server threads from ublk queues/hctxs,
so that multiple threads can service I/Os from a single hctx.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
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
Uday Shankar (2):
      ublk: properly serialize all FETCH_REQs
      ublk: require unique task per io instead of unique task per hctx

 drivers/block/ublk_drv.c | 99 +++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 48 deletions(-)
---
base-commit: 88e581728f3f0036110126adbaa0d88d3cd3b48d
change-id: 20250408-ublk_task_per_io-c693cf608d7a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

