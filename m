Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028E2EA154
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110122; cv=none; b=cfGX59L1Vy4Ir0GYoLEki6mmB0WIO4n5R6sR7r5uTJhxcn5GauHPCtBM9Kzw8YwG213AXEhKWZbbfOz4PSf5C6ReY5PpHieswioRPF5aamN6IrJssowmW04wFfr8Tbzdqg9oK9yZHAePbGc+rlV9+qda/0hgdoi8svJre0ymcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110122; c=relaxed/simple;
	bh=w8eGtVtlolLagnlYNt5x+XC8+sk1v+JVwx6mfbCwbOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfHnwDS7aX0qafSrVv99MkDFfYP5qrlWhE+7GOzhKv9MkSm440HnoaMOB+lblpSzsVESqc3ilNtr8ZhYszsLYd1adFJPPevldg4DXnzIEpsmRTbPc18poCPcKRdeWBes5iCrUXjYbW458YudQMuW+ju9bd5vlZsNkBOPNv0whPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T20n3oaE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T20n3oaE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2953ad5517dso34515645ad.0
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 04:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765110119; x=1765714919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izKeaJNjYDUXJJUmuNDk2T6fLdmn69WrrecR/pMCWDY=;
        b=T20n3oaEQwzxXBknNtxQZvm1mNJm9vaJHB77antzABXhJJ0YhkOAOG7P429Hy9vUR5
         ZLlqlOXFSRZBQkKYoryHdt8D2vbaNapTHpD/zD9zR8Ff8pPf7lE4iUCcJmRAS9lkLVoY
         wpCRjAfHXwdf7r5Aq/JkAlmxKb7xQIpdjyFWPZGQOBVI3MapzGQEwUBlgDSYTeWpb6t9
         mL9JRfPMJbb9hh+i6FUA0Yj5Nv8oifhSxrYba3UW6xJRp1PCG6Uz/Gor70C2IqyKuC9C
         jUFiu7DaS2cylWolqkliroma1pEQ6g8Elv0SFLxqShmDDu0lcRv03eMxm12fQqpO0eU+
         DchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765110119; x=1765714919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izKeaJNjYDUXJJUmuNDk2T6fLdmn69WrrecR/pMCWDY=;
        b=ZgR0jxYS/o4Kkl7ZTCqxjl1vdX9Vc0xq7cugxqT8x0lGaVBjyqokaXiJF/qcbbGphD
         FBvoCgn4u617ir9+DkB7AgjzWIY+yX4v1CNTdgN56RwNEanReMfCfdNYuGeHOwXVUYWE
         Uh9DYYrzBIDNVqfOeIYUxDU5pln8s4vdCXqb+8GhF8TBgXH18VE7O0UY4Ixi3j1EJTVs
         cGj6BmNLVIBRZIoV0mKEi4wdIDpGmxcNcwjbPnDhxDDEqxSTNrdVQD1TPSZGsy+e1w2n
         nJO+0QdOpHK34zWdwe6wLCG4Qgz2ZuA89EcvrO5SmtqFeA/YWJZSx+4kM1D+WroY7O+H
         i01Q==
X-Gm-Message-State: AOJu0Yy/bo1UvCyCOrKh5SOgdzglpbQ6mI3ctXpCCnzklwNphqumPKdW
	a7H/iEUGnBR/OuMvqpGwCMgl8hU2CDJ0FmvjyF7Hm1t2wxlA2CyAdrcs
X-Gm-Gg: ASbGncv3Roa93M4S11PLG7BDNeL1wBN6gHcJgsWSYb2KbalPGoNvb3mO44p4Ly6EFRf
	AeAzqPyuD49pgra+lY8zHN9b1xfKhveJ5gsEqsvI0TiaNgApQsZtr85SfZyBxNoG3NLRW5usTqu
	TlZsIwri8esqGtZePHMTLQ1dd32rnxVS+WrPovTBKkKOX4XiYXGwRB8dSeo/P+1HtB+f5ivc4+d
	GBVVbdkkqrd/w8Vf0NAlTlX7wIzOBeUdn6Xxt/mnD44mMArc68ZZguwHlQncDLm8dh0SNvKRpWS
	4wq6txsDwr9wSeYTW9M+HteP9C1cxFnsw0bw8yg7YjeEqMF1iKjvJU2m2ms6M2kI0L+0bxZryKF
	CU4AEEfhefolI8dcp3QB45fqiIHKUoxPm57/jVz05dBTQsjJTmaLF+6HZbMLavrbe/J+wEhYDu3
	PPF3qbymgK96MBgEb3D7AwEFwQPQ==
X-Google-Smtp-Source: AGHT+IECvKJIBxL4NZCJGy3oY+S1k6hGdcU74QcxSoe7E6jhp3VaKBVwnJ2amzDXJrC/dyJKXDSsxg==
X-Received: by 2002:a05:7022:f89:b0:119:e55a:9c04 with SMTP id a92af1059eb24-11e032ac37dmr3497724c88.32.1765110119410;
        Sun, 07 Dec 2025 04:21:59 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm38598822c88.5.2025.12.07.04.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 04:21:59 -0800 (PST)
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
Subject: [PATCH v6 3/3] block: prevent race condition on bi_status in __bio_chain_endio
Date: Sun,  7 Dec 2025 20:21:26 +0800
Message-Id: <20251207122126.3518192-4-zhangshida@kylinos.cn>
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

Andreas point out that multiple completions can race setting
bi_status.

If __bio_chain_endio() is called concurrently from multiple threads
accessing the same parent bio, it should use WRITE_ONCE()/READ_ONCE()
to access parent->bi_status and avoid data races.

On x86 and ARM, these macros compile to the same instruction as a
normal write, but they may be required on other architectures to
prevent tearing, and to ensure the compiler does not add or remove
memory accesses under the assumption that the values are not accessed
concurrently.

Adopting a cmpxchg approach, as used in other code paths, resolves all
these issues, as suggested by Christoph.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d236ca35271..8b4b6b4e210 100644
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

