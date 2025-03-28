Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F8192B89
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185091; cv=none; b=P0H38qCML93HcTWpzGmd88kcVW3AWhewMVf2pckzoYUXpySPkL6yq8v8ORI5DSrxfgZT49EVbSHvuVtea5pZ9ZA4DmLk2eK9eWSuR8zqt5uQWWHJ9pkqsZwlrEO++Y44ScIsjZaSWFl/4VX605DvuBWSoGmapaZ7LudcBvCZguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185091; c=relaxed/simple;
	bh=PwwHN7IqP88DTTQV80OKz7nlEHX4zcF7Qrd9VdcrqNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABph0H0jDq+Rtl/xWoFtZ7lKqhCmuor+/PjQs2y/BcEZs3kvHGBEJFUzLzsgcLvd3/H6NXlWEYXzTR1CzpsfCTeJ0H6zVO+zn2Vm5OIVCX2WFwk3Is6fSweM6Fg3PxKy+QpXy9+HinqEdkyMBplZQpjXdoJRW8QgpfYcNMOhyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Eu2aDNh5; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Eu2aDNh5"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so537215a91.0
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743185088; x=1743789888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj4J8k1qL5TaHC2pS/xYDJ3AApG411gLa2b3V6a909Y=;
        b=Eu2aDNh5CFS5p/3TxC9hitGPafDzMxzBbIrdVvAogeKDtld3aNqihATxzT88ZYOw0E
         lG2pIUiQh2/3aDfi6XZp7odpAk9J/5FR5NvHmEM1Ja+58n2OTYkbj7L6WM19nQ/nT9S2
         wG9dV8n+Uzr1N9lVUx41KxPKol6+L7G7+uDDOERZPshdGAHqu0y9kCtrlcXLPLXJLTSp
         ODSyzx/ZuITRfp3iYw2kp9595j5CrIgzUgg0QNsDa3U2vDT8RVGz5b4ucGIx6yZpCkF6
         NC48tgQcQBgiPqZqpdueETSgfdploRpxf7hYfEhaWOikx1sWmdEHwsGTOQhd3SOHOv3W
         /UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743185088; x=1743789888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj4J8k1qL5TaHC2pS/xYDJ3AApG411gLa2b3V6a909Y=;
        b=bPmaEIvqLXaIJ5RQbhrl5XCr3hv6DGWPGKYXDDrJt3aCD1LwYwlMS9JB5IDGMNgAyt
         lW72o9vCiZCKClp3xwluO2WTcXo8NlXefZbCMBImO/oLyDO8pF8XufEVMLQhEfObqqKz
         KfZ5homMmGJ+DyXviO6JtQiSiufGpwVBfAHwxpBLq/rAU1+dp2YcF2Wbur2VfjDl9B6Y
         lJwCIZzpAlvdCFXsqN8NU65f7U2jfTizz1zhLUPEGXqdKraQRnLnQTV8db6VjQlhTHUa
         CTCfukINQB/j8gm/96gztqdPrJ92e+s7IdRYg/t7qIzIU+svC6LXF1KOeuNnR4P6qPsx
         Nfeg==
X-Gm-Message-State: AOJu0YytMNAtbdonwUruIgj5km+14Kb+P2fneU85tL3G1+fN8TXeNLPP
	LlVnwEmIzwF78xbHaEp/sTMDqvJ5ABHr40Vw6QSNLIpaioHNs1iFcrre3WQM34gUO1S8vi9h1Pm
	dq9sALkHiXiHwXqgRwFGsAtgq0PThwXK5jDXMPhkIJd0L5f4W
X-Gm-Gg: ASbGnctn584blRv2sO/ZWFgdLTMc36uXM/GBtfM1lRnc/CX5dFR2nVcN4I8oft5ZsXJ
	DgPzsn/6HhL2C4XJi21BjLxehQp4saHztaNOn1RRekPP6HRhxvHaLm9Hg0/NGLKK7zSQlV9BKYw
	+D/JmCd/oIaJTRE6gSfjDcoeoXie5ovCMO0c5Tkg7XxMmo1hIhRDXtg82QvlZ0BRuY28eqvI/Q/
	p2K5LqNtl3yIm34v1PAy5zAUOCTTpA4HHu/4zTlLYoR7AAglhHzd51Ur0nuh/x1dJj2lnQJKq7V
	kQR0ij1nqNJEdY0xZmuB0SW1T7d66UkY5g==
X-Google-Smtp-Source: AGHT+IGLq/NREs7Ar+m0I0zw96xZqeWn0sWBJj45iV6NXy9CwoEMc4w3wdUIdjPWM7sfWF+XBmbDZ/3WkwbG
X-Received: by 2002:a17:90b:4c0e:b0:2ff:7b15:8138 with SMTP id 98e67ed59e1d1-30532165358mr89413a91.7.1743185087574;
        Fri, 28 Mar 2025 11:04:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-30516d57bd8sm301896a91.6.2025.03.28.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:04:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D725C340721;
	Fri, 28 Mar 2025 12:04:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D34F9E412FD; Fri, 28 Mar 2025 12:04:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/5] ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
Date: Fri, 28 Mar 2025 12:04:09 -0600
Message-ID: <20250328180411.2696494-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328180411.2696494-1-csander@purestorage.com>
References: <20250328180411.2696494-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save a few pointer dereferences by obtaining struct ublk_queue *ubq from
the ublk_uring_cmd_pdu instead of the request's mq_hctx.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8b9780c0feab..9276d1fcc100 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1285,11 +1285,11 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct request *rq = pdu->req_list;
-	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_queue *ubq = pdu->ubq;
 	struct request *next;
 
 	do {
 		next = rq->rq_next;
 		rq->rq_next = NULL;
-- 
2.45.2

