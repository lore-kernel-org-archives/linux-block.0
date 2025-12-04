Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3F2FF14E
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816514; cv=none; b=TCzuVoBMbghSdtaMH0tB6vvnc2/MfZKI2h2dhDcxJkpUn2EoTVspN9NL8zCE2OoJGFo8W+kQ0HsTxc+9v9o3fTMHyJPKS2XVmKu5vUTB8O8lXNwaPTmfdjBHMHkhn36azXKny/V9cPCywEZOm4Unb/PHyqptvN4VA9dzq+bSf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816514; c=relaxed/simple;
	bh=GWGqYe6NZTrI9deOI6ejOoQBWm5NR0OgoP9ZCzjXKGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCjtS2MqcvyF1pSGPSQHSSpelZDQGZyQTjwsNxPV17+1TD2wDMkDWs8Nyhyy9S1ZM+lRTiSOcmd2HvNvNSxXAEI0qYYo/69McWfuVfHujW/HojzMt7Q4OT8ktVPXeqLJlYQaTHD+NGk0B1bfXiwJQENNbie/2lF2LDFgzK9kpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1B06UWI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1B06UWI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7e2762ad850so279728b3a.3
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 18:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764816507; x=1765421307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODLAjaeZWmKKDwhHXqzdB6DoouDdnHDHsOcQ2a6RqDY=;
        b=m1B06UWIUHYuAmSdR3uhDTaDpbqxedM8WF6af2dRS9/R62CHeg01oFYuFoxvDgsuq7
         voBeipjgYzcV40KTCF2Qh7Syy29iTSkZHzs1SdGFmGMsusQ/IFqOXEoWLcPrgUWm4T9i
         A+92ZsFyniEPHedFbSJAR7OpqocbbqByi77fO1hVH9ey5zhVNLd+e9olloTkCkl8gb+9
         BmBSlKtjmCQCXJQn3Xw5lBFcFdi9jNzJWJH3N3WnHgjoDI4KBfmXfcaN1nxVMvESiRr0
         oGh6xuVih+AXtKIJIf47k4v7UHJqksZT33MwYKA6V2bcRRxdJ9L2Rhxd8yb8p7+IVVfx
         Kd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816507; x=1765421307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODLAjaeZWmKKDwhHXqzdB6DoouDdnHDHsOcQ2a6RqDY=;
        b=U6KGEkgNKsn/fiv5JLexFJza+Ch6IyIEQd8PLWvN9fM1BwVU7gsEOm6S6W5DPm9LLp
         OlF+KrBEE2Qe4NP5dg+ZM18fudZqFxINsgA6X/8VgkBD3m5gaVj3Dsf52l+VB0xi0Sm2
         nlIxEKcQVIj4DQaUNNqzsVlZlwe1AaXglbFNlcN6Swx67Lqqr/V/u/kB9ymc/pIbm7p1
         MYIxiUkl0TtTtmW0bYOsERUmjbcXZLElT1nMkF1Xf17aEdnjmaqVTdw6hFtxB5ooy67S
         TD4Uzt+4U0Vpoc9jvlT1WPWFB75YIP7ugKmJuJ0BgQxLLaYW45uAPV6Tn20fqhAB6DHp
         E2Sg==
X-Gm-Message-State: AOJu0YxHAVoRFv/vl9p1pCv/rt3/WxsOXbLSyOvI9Bdj6ezIZWRU1IMS
	IDioVeCH38lbj6Nw7d3IZDD17h/BovNzqd9f/AAsV7A2eCTxpQB3FijDpM0eZPCC
X-Gm-Gg: ASbGncvwnGV71x5il6yXJg84I5CLi09qMYdyyd+K4Gr3Fo5h014woUm92wYcdpCyVAD
	U32dbjpg/b3R9I+ZoxXw16K/PBJf2Dcujg8DrY6qwIXA8JpXPQXPZBx6yHZOel2SF2Dl+5cluQE
	ky8ckMiWSwK7DFM+OJsh4lqWXI5eDcA6ZK1gRIkrvzrFqiwHIpRlqg9DrjsGOpmzAg9UKGXLJ+y
	xqlb+M9OSQKwF8nhKMRyZCLvRRmRVfdgdA7rvF0fThZcTKKDt5KR2bFQsV46i1GfO1Fkhbc76te
	tQl0iP4kmncywAvVi9y5oahNP5x7C52gizl/6R8kXH4RfXIwE+SEAdzxDqCRHUZQqp9FwzQ4Mgo
	blB3baKXM5yHnol7J/+n2aO9iZP22kgqPvnzWZ1L5a/t9XDXKevyXgFdmFoMl7B4/8sjtmV45VH
	H180/tT4t8zuJYW9D/AM9PKp5XWg==
X-Google-Smtp-Source: AGHT+IGM6SlIysHbulWdQG8xyoxU4IAcs1YhWt2VJRjAfRnb3Xvrgep+D+UgkBMDQdlNnkJeXkWtsQ==
X-Received: by 2002:a05:7022:63aa:b0:11d:f464:38b3 with SMTP id a92af1059eb24-11df4643926mr2045006c88.2.1764816506518;
        Wed, 03 Dec 2025 18:48:26 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm1838847c88.5.2025.12.03.18.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 18:48:26 -0800 (PST)
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
Subject: [PATCH v5 3/3] block: prevent race condition on bi_status in __bio_chain_endio
Date: Thu,  4 Dec 2025 10:47:48 +0800
Message-Id: <20251204024748.3052502-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251204024748.3052502-1-zhangshida@kylinos.cn>
References: <20251204024748.3052502-1-zhangshida@kylinos.cn>
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
index cfb751dfcf5..51b57f9d8bd 100644
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

