Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06814A00;
	Sun, 13 Jul 2025 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752390031; cv=none; b=ZmfJns+Ccv3yD79hC6WbA2H0ssD8ZMFXsqEmVksZDxwh0+Whch9IeZ98D+Gb3cD6q9ROGQiJJEfYAPfMfAnw2qZJ3cICKR8pW6TKrq08U42K5wY1UYG9d9/exBxVM4zsTXSakEDD7Jw8ikWcEg/rhSEDQMDMaK7SvIZErljdhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752390031; c=relaxed/simple;
	bh=EpzrXwEa7paTUdaZaSd+MXTCbTnQvLhGAlv1rCXSeoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EkUPvsE6x+sWdc2qI3OYD9LxptnZMRz5v42GyXiZSGZn/FS6uznk7bib8cZtMWxZXjzynjBZ7au+42IPuH5rLiqmxqc5efJT4Eq6VUPfTLWXy61FHwPmO71YiO4sj9JKLOpMwwDyprfswpRYBjGyjvzD/2AJkEMm7cXPifmYefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4Ul9sqi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Ul9sqi"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-315b0050bb5so2436249a91.0;
        Sun, 13 Jul 2025 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752390029; x=1752994829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0Ih0he8WVy9FU2boxxtThvW/s+yfwKvu4DYVaR+dHk=;
        b=E4Ul9sqi95FgSLjnYV6kNFFX3uqbXt1VLeSkPvP0SLjffakjgjxhnCPY2PFmPvKOLP
         zIU4RJFozB1JYDZtCNAYe7gw6MjHhjT314g/fqC2SwY+gLu7I/9JFUfKkfn0PgxbLCm6
         YG/bPH1OTgr8E68KApb3YSXQlsGSaoFQNCpqTAozhU+VltaPdurRjYEfymX5xw7oRgRj
         f9fbZxdCd/F9kRbaJniyXOMf0DYWzW+BlqHW4XQ/6166HE5R//GKfYrufZxzNTrP8cub
         J/Zw0jragL4Co9OmGh49JZGy8LLMKnlSBKa85F+o8V2fFsoFaZb3ZbGIrJXjI4E8bRLj
         AY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752390029; x=1752994829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0Ih0he8WVy9FU2boxxtThvW/s+yfwKvu4DYVaR+dHk=;
        b=NBEGv9V+rI5KNP6oerRBiIhmScum9A++ILSUKTvvE3/chzy0hDiOkycmJo0UP62YUZ
         0hSrwl261IFZ1sDS3FZgPdjcmYsIObXATyoGKRC/Bo5/x7gBk/2QU7b9LnpjZUfkNHvH
         3RoBPTplPtU0Q/TzolBouDx2EqzNTOLSu2YYezl/weJOGi8dtOYHZLuuO4Aai12NKMo/
         97JjxtRAH3tX36iZtQn5HI9Y6grLsoP565NbuAK/ObiBDjlsYwjaqBvHDDhCI6a95UFZ
         rcdnHtc71ocS5wh3k9mcJZSihRV+ObT+G2lwR/nqGhqdmxa57+dQwMOQgE5up627AiU0
         t3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHlJGpkR3xd+JJmSKMBScf3XSGf8O3Q5jM4LZRk/EshHbfT2oVf09cI5jiwWv7JnJ1KyouA3FENEc64Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHG0gdyJGYqFZmHQDC4HRVlgplqHdc/zzSQmChyvYHp0iv8j2y
	/IC4u8KX7YaA6TNj3u/eh3PaBaqfS1+5Fc0YEV/+qHuRgLCpTPjmLn47/3R9nvQN
X-Gm-Gg: ASbGncs+RLfVsmcxi7QRlrKBeO2ET8MNSuNphRSl0KOUF2rLCSt6LHYmGTC4QMru1r5
	DsjO2qqD1Oj+09waf8yJl6is+IE8elNEcXeerYznxvvraPVGaPTbfTv5NMpo96rQXHSBoZ1LLjk
	99NPjwNJe4c/qQlNBoGi6C5bBiwyeNxToo1/8QDUMepCxso1Jecg4Pylcr8meEn50BBu291Y/gd
	RtOsjFwZPCWADT+9VKY3yfQsCSaXaNMuhEWaN6tAnymSIXsQ94TEWCe3kxkGwpcSKAdQE7cPqrr
	JN9AL2JVcAcXoKcic6ib0Ne4GWEcvkRyBwcQsTRF6ZI9a2VxQn4mkaBOnVq07O/2l3yTnkEDXOD
	Z3zLNLnbpwNN7qchzIq2RS83KHewd8QRvfIlY4aCZt3Y=
X-Google-Smtp-Source: AGHT+IFyckgsnZjPj6FE0B1ZTkK4hDjIP2xQ6bnXhdkWtj40+hx0qVEOCL2RcdwdTvNbf3F66RqA5A==
X-Received: by 2002:a17:90b:2dc8:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-31c4cca23a8mr14393372a91.4.1752390028648;
        Sun, 13 Jul 2025 00:00:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:4090:20a4:5c0c:4cc9:81e:7950:c690])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c622sm11340878a91.29.2025.07.13.00.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 00:00:28 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: efremov@linux.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v2] block: floppy: Fix uninitialized use of outparam
Date: Sun, 13 Jul 2025 12:30:20 +0530
Message-Id: <20250713070020.14530-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
drivers/block/floppy.c:3569 fd_locked_ioctl() error:
uninitialized symbol 'outparam'.

Smatch may incorrectly warn about uninitialized use of 'outparam'
in fd_locked_ioctl(), even though all _IOC_READ commands guarantee
its initialization. Initialize outparam to NULL to make this explicit
and suppress the false positive.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/7dd94691-0b37-4855-be43-661f954275c8@gmail.com/T/#t
V2 - Initialize outparam to NULL to suppress Smatch false positive.

 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index e97432032f01..24be0c2c4075 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3411,7 +3411,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		struct floppy_max_errors max_errors;
 		struct floppy_drive_params dp;
 	} inparam;		/* parameters coming from user space */
-	const void *outparam;	/* parameters passed back to user space */
+	const void *outparam = NULL;	/* parameters passed back to user space */
 
 	/* convert compatibility eject ioctls into floppy eject ioctl.
 	 * We do this in order to provide a means to eject floppy disks before
-- 
2.34.1

