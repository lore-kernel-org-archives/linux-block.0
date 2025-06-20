Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA52BE7A1
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432220; cv=none; b=qAmHYO+s9dx9W6GzjeKJGf/p2hwoyfj5VX1xdwH/edZhjHmGK/DaoDvKd9VxhxvDWSNoDT/WnrFOitUg+N73f0Mgpz0T66C0yAPzN4lznm3SyvCfBiu0UEsMv5i6Dev+dfNGKbuZNFMXXTphvNArHO2bIa3qt6I+f9SRDkLyDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432220; c=relaxed/simple;
	bh=57F8wHF7HhenikIkVEjPUJGstkyTOdNKKU/m63cw7SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgM0YftVwOEtKFeiTbKMmt/yD1UEvaTz7yrVZyGEOnyoZQNPiuM1EHi3Ttjxuiaw0Bq09m5NQ02qAa9KTgYdUXiQUgxO9LYivo/9MT4ViMPsLvpBbHqK5VhLMWF0CFVuS9lIL3qkyjL+06Nl7vZAI2JElhweZnc6L3B2lhCFMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CmmOumCr; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CmmOumCr"
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e83199d55a0so269219276.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432218; x=1751037018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkHgRCGO5s6pL8hJfJlOWp6pJWylejqwR3mNGsQWWew=;
        b=CmmOumCrHBobRnvB994uaN3lYchT00GoMo0ztfjxeVeJCbpKGNMRlvyUHZp59ETn/q
         cMCS6JuDAUde/tjG9ZQWQLxGRCvrn815TrPKzKiiPUiVEnTS1HFGIWRPGo9w1HeYr3L5
         Vw71XXpsZsopo5loxUSVR5cZqXMXgqk/TQItaNWxQa8j+pN7y5wAHh2BkfIUnVO/BRxs
         nt9Kf/9frdy71dbK0lMP8XKiCR/0HyX5u6sGwlcw2836tB8SVqXaOTOj7Q/EbKn3bMrd
         ZD/fncXuN9IEjfcEPr3Q5mh+SSa6z1SGjBQhiPDz3qU0bGUdKui58Y2D/VP3h6/t9Gwy
         j+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432218; x=1751037018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkHgRCGO5s6pL8hJfJlOWp6pJWylejqwR3mNGsQWWew=;
        b=fuo16Iihn47a3Zx1LrVCelqYQe7Csl3TNEtd6QTtt5SRvFZ61yAUI/WSrCdcvIo7r7
         W3p7F7PZwY/KLiib1tZ5p752CJ0D+x+4VQgj0m0/yB+L02ZzejHEftW5aLsT7QaGbtTw
         HlkIrBPK/mOtuTXin017n7xEv82ikn0M1/SB49xkGMyCYeUkwuNZXBZQFqqvILGBnRMI
         9vi/s7mahZOsWaBfb2psCxEqNhCgytA6HrU7JwB8n4WqOOY1C6TvoX+sXhzOs+DamZhj
         /mN75ghcGcUTPU7I76flVOD53f6vCdVgMfceTHVLu8otK2I5GlPinG0NhGozM5uBTwUb
         VjyA==
X-Gm-Message-State: AOJu0YxPE7ZDP6BalLHG4tPD04zcmVcmM7TjcBQmLzSVuQ8xJ1ETR+au
	0yRa5WlFwjW94akiDXAMg2rlx+3C4v8DFZArn6AyaN3e3QF77etR5K44minW+fJWmFb7Ki1QXfr
	bUVr9TOcQTmAIu83geOKRaf7iy7MgbF22B8R9
X-Gm-Gg: ASbGncvvG61lYofILwV5QMMAUDEuN/avbjQyvjRKbVsyM6AUuMN2TTUzbOeJ4GfISIH
	R6hQsEF8OQLuRW66ccOKLwuUgzs8C52MCnnxatTmbUJ2wPN7e9aA6PwJUXi4FVceqTLdqUBJfdp
	40bK2Qk1U3QCoCP/EROFapHwICYgtU/4dWRj4HA28Vt1XmVuXTz/Juu5DgW0+KPwchqncxPn3Qc
	EiN5373WK7kq2RIA6nMK/KlHk3uJpPmIZ4xG9PUSdz1xmwcTH5qaxOQMfUxGjDjXYzKIyV/Gz6q
	G1IitKQxVAvK8O9xE9yQMEpx/sCYTpR6qnXQ+FoCizlG8AiXFR6jAh8=
X-Google-Smtp-Source: AGHT+IGJnIrBced+/4Uoknm8irx+zxytuahaw9ChzeGmiXEmNK0wijNA0OcCPFGVBgdZ+7wgeZ981DdB3bsz
X-Received: by 2002:a05:6902:1005:b0:e81:dd9d:d45c with SMTP id 3f1490d57ef6-e842bd31249mr1899490276.10.1750432217984;
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e842aaedbf7sm128867276.10.2025.06.20.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1AE3E341237;
	Fri, 20 Jun 2025 09:10:17 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 19C27E4548E; Fri, 20 Jun 2025 09:10:17 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 14/14] ublk: cache-align struct ublk_io
Date: Fri, 20 Jun 2025 09:10:08 -0600
Message-ID: <20250620151008.3976463-15-csander@purestorage.com>
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

struct ublk_io is already 56 bytes on 64-bit architectures, so round it
up to a full cache line (typically 64 bytes). This ensures a single
ublk_io doesn't span multiple cache lines and prevents false sharing if
consecutive ublk_io's are accessed by different daemon tasks.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ebc56681eb68..740141c63a93 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -186,11 +186,11 @@ struct ublk_io {
 	unsigned task_registered_buffers;
 
 	/* auto-registered buffer, valid if UBLK_IO_FLAG_AUTO_BUF_REG is set */
 	u16 buf_index;
 	void *buf_ctx_handle;
-};
+} ____cacheline_aligned_in_smp;
 
 struct ublk_queue {
 	int q_id;
 	int q_depth;
 
-- 
2.45.2

