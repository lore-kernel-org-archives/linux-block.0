Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63842C11CE
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110118; cv=none; b=Zi5YNbD3uuMZH2Q+f2IbLwnGFaBwPKjDBRqu/eWOjsxnxMPjph4Z8NF7AV1nqQjyX5ecCUH0IXy2zxyHKxI2bwaoM2lMyrTX4Kor3gOpyiIw71/xej+YI5GXD1SCu2m17XyD7+TxjQa1OeK+kuhW5LBgnfFgmu8ajE7gto517OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110118; c=relaxed/simple;
	bh=4CeP8091EqjUK9CskNSlEn27rcVvsb9klIf5F54UFj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taCpMoApGenAjiHUzvURy5lcN6ayDaDxPz9+XiBhQavjAv/XDLMpUG4KcAKmaEUs1xdn846HplfKIX6LfhTBVzPImMLuBF40141aM5zKYiNyFVE8m2+jBuMVdUVhCnfqTANA9hTXgPiYYAaAUs6VpXqMospqiepoLy2BYpHqgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy7D1DXB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy7D1DXB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so2586524b3a.1
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765110116; x=1765714916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDKxCQi4WubAv8KgzENdDuZ74b0CZmQcA4s08IiUA3A=;
        b=Zy7D1DXBBrOd+V5D73IJWoEvycklFwPBBKr6XzogyF6jQvf7ceG6VznuaXR/pHC60X
         KhP6cGgcU0WhaEQejhvkvbajUmWUvJg7VH7bo4BRPCbLsmM5ezWJhSZXC/DKmk7X6Rx0
         XG7+MHmqK95TWXjapl6YT9quA78X+FiY6N/fe91yUq/qNUaFX1EMrTbGuI585xYoHWIe
         B4emYF8X5v7q4+dvPz3Nsvj8LD8H2VhImgYL5Y7IHR44JrjaiD0mSC7ryygOyt8qaZI0
         PQ5tgcxOE+Vq6wjDgmiueuyPcKnCOrIptsPu9N58AhKaBn+Pqh8336YMFZ/Qxxxtzpjo
         R1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765110116; x=1765714916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDKxCQi4WubAv8KgzENdDuZ74b0CZmQcA4s08IiUA3A=;
        b=w5tYupPX/XT3YkXpdkcSD88V9SHfcIuhK3wy6so0UPt6frFRUVggn51KgKH0ghUYcd
         Y17pdI9n3YVl4ZSftRoxk2dHiiRB+aUDyeutsM/1F4y75hF5W/TdgIL7ZzazTHW1krPR
         7JGPeUGUJo3T8C50+0kpcCxsXbM25KJuRQSf90Db/toz3VrBOGwzmzH8RONB+va8FwMe
         DwIycBeC791aXDfHUqm7/Fgu39yPNhh9GCdMpAy8O+CDipQL8Z6A4VkZB+mE/uyHWfN6
         A9M1ojoLuKcx2Zb8hOtQc1JX5W+gAUgNNXyDgC/yDPfvbDhc0mqyqQ4Q0ZYrWmp3XdFH
         /B3A==
X-Gm-Message-State: AOJu0YxROkLvvJunTPcUNkEgmRc9dA1TDGImvy617Ycu3PwJ3CbB3ulU
	xCvzgnSxXoaN1T+KjbZFJ0KccqfyzDEupeUkmkj6RoZpAA+IYQ98v92J
X-Gm-Gg: ASbGncvJXmi7f2HzFrmGFfzp466WiJ9YkutKOE6WQrEKZmLP2IpFdvsxCiFF4uKgQEO
	1xwVOsq6Xxw1QFW/i0ux2IyEF4PUNrttqLWYr6py3+Bkt0iLUVieTcb+NGgEZN+EUwwjEW98x0G
	29Tt3GIN2VEOI4uWu+KgsXhJbcsegRWGT+TnrRCvvAwKIPjctZXbO86ChcMlihNoVeK9C/4/Cyv
	a01nqhlDOIHxennSwJ6a1FpUWXs1NuF6pgEpTSQPfS7b9DS78GjRHVIQ9kmKBlHirSzzU8Nn/6F
	LnPfpN0Y+RhoATNVGH+htX6cwrToperXQSBCRVq6gIZ0wg1DQeAkhQHIgp7dHX6bApecTpO/57h
	8s1YPMpjShTppc/cImguj6WH8Qfne5L1gaZN6rLotghraDb3xnNZOqqVIjrzph41Vuh74gnVXk0
	zKEk7yJi+3e7HpQ3uTfNqW5PMBuw==
X-Google-Smtp-Source: AGHT+IEFoaufhtQhW9IvDY1RlPlNMuzHF+hZt/2aoSTSKZxkU4XhEbVtz7dv7vqUjHSWeE+D5TBt/w==
X-Received: by 2002:a05:7022:408:b0:119:e56b:98a7 with SMTP id a92af1059eb24-11e0326a1damr3443282c88.14.1765110115829;
        Sun, 07 Dec 2025 04:21:55 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm38598822c88.5.2025.12.07.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 04:21:55 -0800 (PST)
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
Subject: [PATCH v6 2/3] block: prohibit calls to bio_chain_endio
Date: Sun,  7 Dec 2025 20:21:25 +0800
Message-Id: <20251207122126.3518192-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251207122126.3518192-1-zhangshida@kylinos.cn>
References: <20251207122126.3518192-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Now that all potential callers of bio_chain_endio have been
eliminated, completely prohibit any future calls to this function.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..d236ca35271 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/*
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	BUG();
 }
 
 /**
-- 
2.34.1

