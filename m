Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE742089D
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169497; cv=none; b=KZPlu4/Pyo7qujOm3/xveYGNiNuIJbXDJzAlQjzukFxfaVTNXfGvclTpj06MYSo16STXG3zV6NdT9dvGapq1Sn3pIG8z9uBDRzXl4pf+zgtxQTVYCx1ISj18pJPFNBnx+agbXNNoyvIDjTQtVmBWFPe+ibKfDJ2uMZcgjmzrwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169497; c=relaxed/simple;
	bh=fpTs5+Rn8LU6JHESRuyZA1kN8a9iO0OrqSw+MfJB7bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReDyUkT+TxjYcSLH2iL0o97LuiQdTviw5XYP5FAnix09F9CPTYpI3MSkWCKT22qr+5NJEQLPFvctQi4c1OWolDykQsUMiPFi14ksICyRSvwptOZ00tAiFfLkRQaS/6q0SVTZ3bDu93WEAEUmyCLP+XqIuPsi2KMR0mlaAc1+4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LlJBqVWm; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LlJBqVWm"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5bfa1e7e123so97584e0c.1
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785169494; x=1785774294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SHbofcTHDrzXu568hDWlASOzkqta7dMos0Tr2u5adU=;
        b=LlJBqVWm+QdjZ33T8ODISFxqeLDU1HwLC3cFZkgVtjFTTLxpphB+ZxFPX/IHgwElgo
         pWxvGliCQbpI3iJEq8+oCZZnOKPLB1WOE9p739/7CsPTR9w7ueDyQj/HB3jCjzEUfe7p
         M+oZvh3PO4KpdG70awmJVXexXdSvT6ZXlTiBNkS5HtJ09S2Ob9ZhqZEnkfB1I+xpOLA5
         wEDwuZXcMNSC0U3xsNzQtZg3sQ9jXER6yepxWzE0GexDpcHek4uM2MpEiVZbPCmhVuBw
         CkfXk/Tn8q0Kl0bj7bambi1coU8TsU4vVeryIF3JjsFCrTlyAzghbrVNhtQROMw2pgh/
         f/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169494; x=1785774294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SHbofcTHDrzXu568hDWlASOzkqta7dMos0Tr2u5adU=;
        b=p3BSoGcP3Gqhq8zLrrifkbids3uY2jpHdqkZG248QyCR/k0PW0dFotFLARVGPlEJko
         BjwoTpILDqZw+Fox2wmtizVUPsXNNKHCLOs4e4AbuLIwc7A8/hcgj3iIZevrWUeAy4Ir
         WjEBx+DU69i8qjHgqoukC2YM5iHkbCu+HOQdN+WphVuj6BKOkJ10YPDspaba0wKlIGoi
         GwfKIZpznBPY40rP6A93f8WOZafQRrcW8rCu1wdx827bjT6EpnQSD4L12vpmQHeEfr5X
         D4MznG5k7jWxbqps55hZIkUOfpDWz9dKmd5df6qqliNIHEherGU4Q2bRykvmdEfy+o2T
         CDDw==
X-Forwarded-Encrypted: i=1; AHgh+RqRAGYmHyNtnHVd9nR0pGqjQnmEC/V6ZsGA2C0/Dqo0n2XOxoL7wZg198dAs/Lsjt+AEwBufu/ULp7c1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzPXQqny2VQn58epJ8TA1IMdhDZ+zGfjsZoXuXqgJumxTnTzr
	qn60Q3RGezhBLS+xq384Z5TaPJgVbNiHNZngdN6IBOQawfj9LpkDK3tcWFAb8oxrTv5g4RPrD3T
	+sQESlmCdamBwXrqKhajkwv1yFnVvqITRzAPQ7RvcppcrY3VHX6ni
X-Gm-Gg: AR+sD109yXhULUak3ZkgvohEOFAW9MY8y/e+BBtjQ/i1lZ3jzt/xCyAGURczM6qPyqg
	iein4rmpYNb+q6JE8n9IhvqVF1YJ2MadXkXbTTntUEo0fqU3NhWby9FMLkUxhb5y7+6qukTtanT
	a+tqAAZgcPV9MBwG/CJjZapy+qTR/P4JgOSK0LD1NZbQSqZrskwJFFAtR5Ar93+iBh/GvnPY0H3
	ZjP7BkRgwYJCzkLZpVT4TxnCcF3lUmE2Oq+zZO2GP5NMH8rR59mlUDjcdgKrIhxxXFoNrg7kYkB
	OHcttTFzzli27S6X1GKsuyvGBCAZiKX744YMccAMeI9hwMdRB/R03iiHm2grsbyABpWohKsEIEH
	YNJOVNN9H4K8Sno1+zQ==
X-Received: by 2002:a05:6122:2909:b0:5c1:24b6:a1e1 with SMTP id 71dfb90a1353d-5c33779e10emr158647e0c.2.1785169494041;
        Mon, 27 Jul 2026 09:24:54 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c3051150d2sm714653e0c.0.2026.07.27.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:24:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 5FA364001C;
	Mon, 27 Jul 2026 10:24:53 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5321FE40873; Mon, 27 Jul 2026 10:24:53 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove WARN_ON_ONCE() in ublk_unmap_io()
Date: Mon, 27 Jul 2026 10:24:50 -0600
Message-ID: <20260727162450.2921500-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io->res is set from struct ublksrv_io_cmd's result field, which is
controlled by the ublk server process, without any validation. It's thus
possible for userspace to trigger the io->res > rq_bytes warning.
ublk_copy_user_pages() already limits the copy length to the request
data length, so drop the warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4ca6ec738c93..4f30644756df 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1492,12 +1492,10 @@ static unsigned int ublk_unmap_io(bool need_map,
 
 	if (ublk_need_unmap_req(req)) {
 		struct iov_iter iter;
 		const int dir = ITER_SOURCE;
 
-		WARN_ON_ONCE(io->res > rq_bytes);
-
 		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, &iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
-- 
2.54.0

