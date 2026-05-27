Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064337B3FD
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852401; cv=none; b=GamUJskSQJgNnVg4QqzrAX4mh6vGqsF4DyDPXeLJy5I8RZbPIZ409wHosIAfwqFS3wFPBmkPt9WRSNi9PuC7R/74m6hREendvQAKWRWDv2PBX5KRkxzO1F/sSw8b48LQcWK7jWfhlZet3QbOwW4849VwkW1xKbKYw4qVUUePvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852401; c=relaxed/simple;
	bh=7NqP8wTnbRIxVIzZFbQP+alLTQXvzELVOk1InVzXOvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hu56/traVj1wNhNdwHf7QSzgvHMoEwRr1cUMXhV6tWWmTYLwVbvB2MzrbZVqNE9o9EhuakWi21SYh26aWFVH62VKDwn1v7KFL2OCGCfXV9qRaDbPh0OpqEPkhNmPasWFjVQfl2hLSITrpiQsnKQWpDNc7QyjmoOjlTmzCXPHYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4qt36iV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4qt36iV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b941cd869cso72680645ad.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852399; x=1780457199; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H63J7/JvszdGRcjeN8wXnJUHZrHDcDH58PcyxoI9MIw=;
        b=A4qt36iVvMAc/ws918KKQtswgZCew6tKtj08YXiOQLED15c9SiN/uusGM8CTylFeSl
         g87yM963JeyP4zCslII8wGa1nRNJQA9ZRqEVpfimfSo3FXxRxlHIDFUHjcacTT/o+Toy
         ldKOC/1y+/6H+1eyQ6u74xVICH4lE6tKCoXe7gzu3MmFTjzJQB8II2Vxx5AXVDqm/pPN
         VXh1Y5R0yZomLWH14p/JQvm0YCqIVXyM3MBxe2kp1IJJtF1LUUJF0TjAZYKMHVCafxqr
         F3rXvPHy6ozXbH3afC2tkil2ZH4wq5ECA+mRTkMh4TQBJqBIqq7ozwmASFue0Ygr3M+T
         AZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852399; x=1780457199;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H63J7/JvszdGRcjeN8wXnJUHZrHDcDH58PcyxoI9MIw=;
        b=DOjQ6eeWnMs0lK5l8T3emcp87b4A4IvSe7Oub7+MkRZJn4JCLjOY+oAiHkiBkxu5Yn
         WYCZYo8G6NtjBFVP9V/21/bAHhBkcIhKR2Tma44k8x0e4j2BAQ4f/+2PIeUqFj0qKWTF
         2F90Vnk6r8zbcQkg9ZS/DVxmIm2XqwFuFfVS+x8VX78t+Ly5BPfudh95rLrPCiT1MfXb
         MyMLvG8fnqnLSs/OZjfucmVknMvnDFJb0Hw3zKlzDZqFnHvCV/ukJ9Et1bFCSr/QXwGh
         vZz0DUjP8ikX2fTkL4IhIecoKE8PUCOKU3ALswb9VUCHSzqmizYYOcqcUwaMXc+Og+Fc
         zE/g==
X-Forwarded-Encrypted: i=1; AFNElJ/PIToDB0nfRbyMhvCw9w2Gd3bx8WKIzADCcalDLYfAXe4xDt81ygmbwC8tS/uLwe1Fb3ErBvO22RvWmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3sNrio9z5nrCNNghJYsU1tWQ0i9fVqoxdrFdgSP8s7XSUP6Li
	Ehw3XXy12BRV5P+4Zy7SnYNhIpt6hs8JgqX9GDXx9xY40OuU8ZfPKGOqn7MfR3OA
X-Gm-Gg: Acq92OHsDOxHITTZJrhOWSZJ7HPNoS5PV51WQhiSMoNzVztpP+CAnsOiC3kok86f4tY
	iRFSv5Fb3iWpYZf/idZz995Q67C3djfzRXQyfwowA9rx0vzfLwO3Y7fcI4oMWbInYuP/xYfRlRy
	bzltKFPPgSfbSuMuKVBg5MhrZBqe/zQCMpjKE+L6eLtSTyt6QLheUMVQsLUfKy7txYarMEaGzHU
	MUDFnPwn6uiJ3J79b5dsDsvgWr4mL9scIcbX5IPi8DmP7xKUJkWUgrrSKkHB4ZBLbKUgLh1DqNS
	nv52NUZTM2tydcDXYSAJp9UBWVY0d4Mmz71fWGC7SUU5mPbrwNexCiYLxjbS8fFO364JtH0KvLi
	ME8gEkiXT/ggL1obfr9MLXOavw/YR5R9x0ZHC583SYntdGvpbTajRJbyAHvPHKNLqjlpTmYoSks
	r20cIYgPyMBLJ0BrZDBZ284PiRR02YjR56ThRSnhwM5NfF
X-Received: by 2002:a17:903:2bcc:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2beb069970bmr226864455ad.25.1779852398945;
        Tue, 26 May 2026 20:26:38 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm133826365ad.66.2026.05.26.20.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:26:38 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Wed, 27 May 2026 11:26:20 +0800
Subject: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFtkFmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3aqixFzdJANDEyPTJPNUs2QzJaDSgqLUtMwKsDHRsbW1ALPvOSp
 WAAAA
X-Change-ID: 20260526-zram-b01425b7e6c6
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779852395; l=1573;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=7NqP8wTnbRIxVIzZFbQP+alLTQXvzELVOk1InVzXOvQ=;
 b=rMIc9aoiEnh5ChwVz/WDhL34yOkVfP7nSmRV3FVvu4I0exZ1M9lMnRqSVW+ZJNXsgn1H9tPeZ
 cerOcUqZw+JCmnJWc/vNNzhiTrqiUdUtfEtbzW1nN8rRT966vG6i9zb
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=

zram_read_page() picks the sync or async backing device read path
based on whether the parent bio is NULL.  zram_bvec_write_partial()
passes its parent bio down, so for ZRAM_WB slots the read is
dispatched asynchronously and zram_read_page() returns 0 while the
bio is still in flight.  The caller then runs memcpy_from_bvec(),
zram_write_page() and __free_page() on the buffer, leaving the
async read to write into a freed page.

zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
("zram: fix synchronous reads") for the same reason; the
write_partial counterpart was missed.

Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..b23a8bbb687c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);

---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260526-zram-b01425b7e6c6

Best regards,
-- 
Cunlong Li <shenxiaogll@gmail.com>

