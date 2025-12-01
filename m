Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79712FFDD4
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579911; cv=none; b=DPKgaER1clcnEc/CPka04ACIbEhazsn+4E/VfcPFIqkw3Bs1/5hhwJ0DXt/uylu+d+q7ptEHMVgxojLbzNwyyNQIVsUEtiW4n04zI7Y3Zu4is+3ExMxguZbiWkn6LOzKbWG5c5roUZGY4ocpSvahWJPRavCtZks10sCfCLLYobc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579911; c=relaxed/simple;
	bh=aYxMtN+DE9oP1VlQcVa69Tb9BdLadbrZwyizizgybXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcidXhqXJ6mcnDYMf6qXWTiVHJBhQbAe/rjLnkSjbhFgj/E2spio2XbNeLWJOvNBNkSr6ZsdTVG54RpXlEdD9RsOROIs5bd+nxzrcyIuAdiv0wDl9vnsg2kH7C/5SNp4/rXFnHc+ZpK7/rPbsYePIuaU4NXjm31JZ6/HEOM9Vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpcWBsdP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpcWBsdP"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so2814074a12.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764579908; x=1765184708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyEEQJEWsLRxIUx0Z9OWCeFI3uMaF2jR+E58v4Ivl7s=;
        b=OpcWBsdPV1blfQTxLrrgkv7mt972nHHZPujPQeiAmtBgaDD9lSffyrUFaL7H00erFY
         w6b8OEIFvGc5QeDB1cqZOxYQ0mEIl5W3OH4/kGrW+P/8WlPqCR2N2zLYVZnYp2rUPxo5
         MbjaeieBdZzU3XQwOrtVQPunCD05y2jtFmVfQs9uru8kQQOpbP/xGJxLzRfDwBtV09TR
         fNt2zis8X7m5gqhODtdMm/Nk14kS6T/6t9jyWN7xg82dDql3k2Bj1CA4rfbq7SbXiKIL
         z/Z+AOSxx/SwbMtyJxx71gN5J5QnDMNr1fCabzBLsygp0waTCGyU28764Oc2uyLNhwzR
         teRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579908; x=1765184708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kyEEQJEWsLRxIUx0Z9OWCeFI3uMaF2jR+E58v4Ivl7s=;
        b=gWAkIGnUmS53g0tZGOXNfyeFKpiZGXplPKVZn2HZMyO/yPAKqxEEBxgVF2hrfvQwrf
         iuMWJg6B43c8CIggRHmj4QAvRvkqGDxhsihOXFpweOQHEiFHGGrUigUdc3taeacDGyAe
         orEt0PfHEJ6Gte2R/ZS83TY9J8YxjvJ9gXPzpsbtIrQNE0nvgZ1so7W1IC8Rv5Z1K3o1
         WgL/j+fsSsm4hG/2aED/QTM9CfMn3dlAxawc1KfuaIjASvDAiXB6hG5ncIFOn0RKQpOU
         AueOTpeT5KU1vmFukLr9F6oWdbvxHij9dw0TrRc0oHoNHvIR1mulOCGr+8JPLMVl8iv+
         dg9g==
X-Gm-Message-State: AOJu0YyaHmFKXm3lgGYgREGUfIqsHK5bIayB1Idwl/cEuSf69ZAFJyUc
	OXJKvn91YkD0yvss8VnNBvzieDlWtez+ctxPo4SZPh8Q6Ptxk4XDtKkI
X-Gm-Gg: ASbGncu0AeVog4qCKHex7u8q6EnhwEkXF/1QvhM7Ehj6/wWWeptq/S51e0Cab/z74k/
	hx1joqbbBmQOxa5Pel9VXyQmbFsmZIj/JOrZOJydeig9duXi01A3pQlS+4FI9jqyGRDGnOYPn/N
	Wg/jfO/a/qder2wMqIcNDT8cDaUst3QgJvchpS6P+pWw52sNnMWfk4p452Nj6Tk+lAsGarGX0gE
	UrTM8xP5KB5hUxgcicZuxBD/RN7VE2jikKxlyru3A1M1x1gWXO7dlFNrN+6Dz72zUVkJ+DGhTTG
	eLLkwl/Lp60HAMs3zZ0S9vvCcegaKKCkF0FJS+jhTi9tuJoBCX33OPd5QbLxjTXrVB5706ynzPl
	GqpdWgbP94PEev4m1KIET7+Owg9TAx/vokvL99FhUvxXUio7SKhfAAl7I3zcMX0u9ME1UHE1TsM
	tCs/D2lah158Scv4d4Du9y50UAyA==
X-Google-Smtp-Source: AGHT+IERKCYKXvZ6dTL/bPTF2aHnk3Job6CGRSNu/ZdXHTkTIUuDU/0EXZprXpLJTdUnmnyIDS++sg==
X-Received: by 2002:a05:7300:dc0d:b0:2a7:3eee:df10 with SMTP id 5a478bee46e88-2a73eef4cc5mr23118540eec.27.1764579907713;
        Mon, 01 Dec 2025 01:05:07 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm54908307c88.0.2025.12.01.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:05:07 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com,
	colyli@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/3] block: prevent race condition on bi_status in __bio_chain_endio
Date: Mon,  1 Dec 2025 17:04:42 +0800
Message-Id: <20251201090442.2707362-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251201090442.2707362-1-zhangshida@kylinos.cn>
References: <20251201090442.2707362-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Andreas point out that multiple completions can race setting
bi_status.

The check (parent->bi_status) and the subsequent write are not an
atomic operation. The value of parent->bi_status could have changed
between the time you read it for the if check and the time you write
to it. So we use cmpxchg to fix the race, as suggested by Christoph.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1b5e4577f4c..097c1cd2054 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -314,8 +314,9 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
 
-	if (bio->bi_status && !parent->bi_status)
-		parent->bi_status = bio->bi_status;
+	if (bio->bi_status)
+		cmpxchg(&parent->bi_status, 0, bio->bi_status);
+
 	bio_put(bio);
 	return parent;
 }
-- 
2.34.1

