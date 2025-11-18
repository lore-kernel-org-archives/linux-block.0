Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA52231A32
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432412; cv=none; b=SZvGO++dkdFBTV6DC+TDNWAdVM8Gv48499W95zT3deGM8aKdQ3Yqpjas/71QFmpsEIOd467nrvvfzIZT7eZTopRfdQXZMTRv/daB7KiaWihi8cI5g0N/6I9CUzhAtFgErpBVKEZ2LB/TzRMDE2jp5O0P9+bQU24Hqu6I2WmqOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432412; c=relaxed/simple;
	bh=4CkFqydLmvVVwrjA/Ze00/Arh4rN8N7u8qjqIkjg2Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGXjQDQ/y9OTNfiZ2CWNA+IqemxOoLi9c9ayJj3Eze93lnCT+E4HBGzLmNXAwrs18hGSZ4Xccv4+xQu1b6eOc4L79x3oM+RP7LPeLQtntgiKIMA8gPtfX7s0pVlDeiAMUNfl+ImcNanYvTn09tarWKy4S7Yc8sCSyFjDxNU/d7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bWkGo6VI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWkGo6VI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29812589890so63828475ad.3
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763432410; x=1764037210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeLhe1K/FglLKQM5Rjl2nYfqwEdDA+ds4vbwWhubKBY=;
        b=bWkGo6VIOOjve1HGkSm6GaJ2AinRLz9ZkRuMNKWeDngjx325CzvdAy1gu1zJvIWX1l
         Tsr6d02/V778o8wB2aQs4XArnw0Ncm9Ql057P9+s7CzEZQQPzsd7mn8guR59QZ/YSfdk
         E42fRfvIsdtgfDgT2LUq+G9GCdX7oDdwVbrjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432410; x=1764037210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xeLhe1K/FglLKQM5Rjl2nYfqwEdDA+ds4vbwWhubKBY=;
        b=dfYWmUkArTBofv93PAE+GyFmNdlk2gRS3RNVlJYsF3PsTsFZCeyglc/Mdo9+sRq5BP
         qNHH6BOkou9MHMAOCK2A+Lu+dnPAKRifpmYFNcfDQ0yyehTAs1SpZC3e7DgGUbGrpCz3
         MCIudBBz12fQkb8QzAS9ybS9z76nF3xc9u/vDBBmwyqPPYsCoU8/Qs8bZU3wi6DDTPnS
         kjmWesOeIyVsb7Og1H+HNEU8w9hvkDL16GfHWXDCY/95A+kN2Hxh/m1r8xaU5Mo6WpDT
         OldzIk+32uRw6YZkWg9/lUIraAtEDTNZ6PjrrbTdFjNx4LhPQxKOksdlf/R6jw+1VG+k
         wj/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBAXGpPZdP36os3DCndLtaaIFsMSl1Pgt+qnXrlVz0TgXO5e4MS8c4pOU2EXE6VJ9T5i4n7oW2BmyPMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmv49uVWhMV9LQGxqcT42frtvmIdJYMF6Wd6ulrYubCnJVBv6
	jEJt2b2bCSn9FoZ6Y0oKxX4CzIbRVE702neg+wPv/pqKCPHMDgCZSiPWKGlHkyCz2Q==
X-Gm-Gg: ASbGncsAKi+/JLLH0V8ruSyzgDdKiXb1d9pcr/urZDZ/KBkFdu6e5w/GY1iicuJrpJT
	EzR3PMTXdDBBk++MOijmClZg/tli6+EYT9r1Chup4uUkrXaUzSy2f8b7KP9lhGrgh1mqm/XqvEt
	11gfMzunk8RT7MHGI6DoOOBJClBEf1xkiPoQdEION8+BKm30k76hBRf1tRKoE1TKDZ0r6InDIJl
	uuIUfNVnjY+VQgDEEPACEaO6l5dafBH7OumUCJzIhuuOmbSMM/Zr23o/8H9lcLhlyXsFldKOnSB
	Dnqd59IEvhQLKsxU0mix6SLL38p698kcCRogH2pWpn6C9VmeSv5oT98n5Tnz0Z2PkVxF1FpKqNe
	F9HEO50+zAH5eqahZZWHxPv6gLe4gYPqiH4RN+V+JBU67vvTJzR0ytAcsCKt2VATCLd75L9OOjv
	jxmsGH4rFKy4ucjwiqwYtmS0nAFHActOJBSVt3XA==
X-Google-Smtp-Source: AGHT+IFgnrwBGVvnNemFqa0iZ9eZXNHLWkG3IlWjONUzoUMyhxXmmvIdkXpepLq8mpGRgS5yPNAvdw==
X-Received: by 2002:a17:903:247:b0:295:290d:4afa with SMTP id d9443c01a7336-2986a6bf9b5mr158238435ad.23.1763432410069;
        Mon, 17 Nov 2025 18:20:10 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:54de:ef1f:fc04:3ba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456511845asm10961801a91.4.2025.11.17.18.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:20:09 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: fixup "introduce writeback bio batching support"
Date: Tue, 18 Nov 2025 11:19:23 +0900
Message-ID: <20251118021953.1794503-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251117184414.CDFE9C19423@smtp.kernel.org>
References: <20251117184414.CDFE9C19423@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set slot index to current post-processing slot index.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bc268670f852..0a5f11e0c523 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1015,6 +1015,7 @@ static int zram_writeback_slots(struct zram *zram,
 			}
 		}
 
+		index = pps->index;
 		zram_slot_lock(zram, index);
 		/*
 		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
-- 
2.52.0.rc1.455.g30608eb744-goog

