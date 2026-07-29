Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC530FF36
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288621; cv=none; b=qsKrOX8GUxRq8oiAJWaZqy3n/ob+CatQeBp6l2mlpKRlEp7YoqJtH5AfpNOeupXN8k6UK58HOMO6KaNn5zimhITDeFyucB4RKyGj6QOef3tu1zBeun80UHNpbd2mqjY2pqSo7Mfx577LGyaxgF+1AT2pUyUU0UeYbhSoDP//tpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288621; c=relaxed/simple;
	bh=VlL1kRYCLOUEKeJkqA7nZGPbmYhFMbLCnhm8JyI+YVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXkPScwEntj9pbmZRIithvwojoEVUCxzWv7ZIBy8xJ7GipY/pI0odj1vxs/JXD6XyalYSvsi6d+Q2lJ7lUQQhIeodbaNb2MdxegPWDBtMbmxGS7ahb+6cTKq3Du7foNrOa/UY9xfjYg/wbxrXMe6PdMgbe629yKPe22bsPx7xK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DVwKnpkf; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DVwKnpkf"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-976fa913742so6298241.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785288605; x=1785893405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3cl251KwDdcxEWDiW/4IFfQDxLUFXMxCk6J/QXzlg9E=;
        b=DVwKnpkfpA6AeEtuMyPgvB63QMwI09uuw5VVjS1ZEXAypyEtQnRfDAa5Yzk8KBwA8q
         qn9JGYKRqnEZeohfG7gTXvDZ+qV4VdKa0XBGpBifprZq808kd65nLq1odlWKiMJirXCS
         mbcu71UZPR+8JPtxznA4NNTcREA1oGnVS8hKswn3T4PXMmgu/6BGmRSg27r/E2qz4tNG
         8iyyVWa2wM0g9iMco61y0KfQgCTajZyiRKeSe1l/RSF5F/TLuPGPCnCXiIZimM7R0wl4
         SLxDo1gd3M9hUqOctsaCeouqPhHy8Gr7LzH1tAeLQ9jw8SJkkhdJfiYO2T+ap0Bpm9Op
         S/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288605; x=1785893405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3cl251KwDdcxEWDiW/4IFfQDxLUFXMxCk6J/QXzlg9E=;
        b=W8mUvACJBJkzqM8Rg1UsXKLo2MqqUQLTHAKclLMETRvyrpbYZj/d3lc5Mg0INB2z+H
         I76rbULuhLgCuiLBhjyUETMrXIsPqnJLv3F6PxLQJxZYxDkjrMIQj3yEV7RMNrC7PWCL
         DiJXalLG52mNZMYkV97EFUjBoIEoHLesiTPDXVpTKZgmTP2BAlQeGzG7Clya2OG/FTTm
         WVxU3sOEebDjMbGnefBMw2zBZErtCn3pi+YeU+XwtjFeVuOFGL7TgTteJFCMxX/KH90l
         NK/l0AMHFpYdEi51JuuNeA2cZnYNsNDPIGQ+Jld1lcJfbZX3MvFJXWLLRcE/0VoTkK7s
         y6AQ==
X-Gm-Message-State: AOJu0YxQtwYskNOVnFlq3C1GpB9Nh0RPajryBmJm2GRIqjKANyjXlwSS
	pUL8Hr0LMJLD49VazUmwA7x+t04veziP+s7r1QjdxgkZYb72xGV2r4W9yia1QJXbz/bTV0q6ybG
	a7U7SS3lmLog99tgJfb4BhoN0ojT/HwLN9i4gVkYadvfUq1qwW8ey
X-Gm-Gg: AR+sD13ImJRBMLbp2FgOUtjZD/UA5phmupT3P0cc1N4BEsbm8GeS7OjqJq91nLaCazy
	lxx3t9wx5xmk2AYyH+voofzocKoTm5IjwomLtNnCz9PfuxSFbcl4ODnRNWX6b7B43HXtwkL8G2Z
	eBIqOHyViZ96xFQN5Pg0B6g6+d+GbjT49yR6hKaFDKy6QNTlECrtTEtOzxMKkzvt0HStsujzRod
	A2oYQWxWa0f7rIjxz5NVb7e8yzcGHOngyGw7gWuRSy/A5mTsOcdnR0m50Ja3/1ECin/z1hjbr22
	ppskI0mUajpzxiTxWf6huJWSvm3JUMD9d60a1o034Y9MOw/hAnpunBp3Ql/gmumM+kf+UePVDZ2
	E/bnx912YqOxnGTXd2Q==
X-Received: by 2002:a05:6102:3752:b0:633:3bf6:977c with SMTP id ada2fe7eead31-7554b743414mr1890804137.1.1785288604924;
        Tue, 28 Jul 2026 18:30:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-755a93903c5sm81453137.13.2026.07.28.18.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:30:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 25C3A40436;
	Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 236E2E40442; Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/6] ublk: remove struct ublk_zoned_report_desc's operation field
Date: Tue, 28 Jul 2026 19:29:47 -0600
Message-ID: <20260729012951.3744582-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729012951.3744582-1-csander@purestorage.com>
References: <20260729012951.3744582-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ublk_zoned_report_desc's operation field is only ever set to
UBLK_IO_OP_REPORT_ZONES, so remove it. Replace its one load with the
constant.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 257c61bc8222..fada30d8d350 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -526,11 +526,10 @@ static void ublk_init_iod(struct ublk_queue *ubq, struct request *req,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct ublk_zoned_report_desc {
 	__u64 sector;
-	__u32 operation;
 	__u32 nr_zones;
 };
 
 static DEFINE_XARRAY(ublk_zoned_report_descs);
 
@@ -656,11 +655,10 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		if (IS_ERR(req)) {
 			ret = PTR_ERR(req);
 			goto out;
 		}
 
-		desc.operation = UBLK_IO_OP_REPORT_ZONES;
 		desc.sector = sector;
 		desc.nr_zones = zones_in_request;
 		ret = ublk_zoned_insert_report_desc(req, &desc);
 		if (ret)
 			goto free_req;
@@ -729,19 +727,13 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		break;
 	case REQ_OP_DRV_IN:
 		desc = ublk_zoned_get_report_desc(req);
 		if (!desc)
 			return BLK_STS_IOERR;
-		ublk_op = desc->operation;
-		switch (ublk_op) {
-		case UBLK_IO_OP_REPORT_ZONES:
-			ublk_init_iod(ubq, req, ublk_op, desc->nr_zones,
-				      desc->sector);
-			return BLK_STS_OK;
-		default:
-			return BLK_STS_IOERR;
-		}
+		ublk_init_iod(ubq, req, UBLK_IO_OP_REPORT_ZONES, desc->nr_zones,
+			      desc->sector);
+		return BLK_STS_OK;
 	case REQ_OP_DRV_OUT:
 		/* We do not support drv_out */
 		return BLK_STS_NOTSUPP;
 	default:
 		return BLK_STS_IOERR;
-- 
2.54.0

