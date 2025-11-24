Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106C2F3609
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028105; cv=none; b=XdaVoYWEW59DxiaFhi+ZUhyQAWukSk8tvqxuD4DKFXiV20lhCaUhwhNyLp8Mt/vJZeut2XDrtGwEm4MuHWL7gsRvD51Xsar7aaNpKM/PVbCPMuqNXVSaYiLgjLiYIBYXQ2XUliy4wR+ZPE/ocD6m885l7SbGJ319oEqRf4F6g3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028105; c=relaxed/simple;
	bh=O/JUDf1xQdyUKKqPMxOm/ySwho1/juV+ixb/yhr4OcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDboGCFA8WNoq4/K/fXZIZEUcHLP4J7T521TRshimn8F+YiIeahwSEcF8UB6bBopkjT1oNTRGYTnY9rzW2ypO7DNcNXJ6ogHXXRPvR7ysybY8nQYAqHhAuDF0lPlM3j9MffvNjnevpQhD8L4cqitX+biFL8mqbris4tcOHZaaMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyRvwB0P; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyRvwB0P"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2980d9b7df5so60587185ad.3
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 15:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028103; x=1764632903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcqbQ5S4JXXbau3fgh6ZbMU20qGzRcIfkGSPAKTqhkc=;
        b=fyRvwB0PwJyRFVMmj9BwngRdyh1FxB+k80U4l3kSgDZisjLtKwedeBZ3WsHlXzv4LW
         smguUguTqO4ye5EUVlnlvpwehhBTfYAqQ/x5sNJHqkipIoz1rFFOO/xvS/2DbnpZKGWU
         NT7VSCuaOqINYCuFj77EXlZa539ZIvO0qNkghSekpJ5G0ksAQiFu5ykpDGTAVN31tJfk
         64rRkgLXr7NPb8V3l2WHWDXRrJhsD4fRRbJez9GqQhUbppDygfJEiz8/8/j6tRnC4bcU
         2SvXeNYZLlS+Zu8IJeuLKXeJkDs+fSU0LrJknD6fbkf69ZraKuFmm52FKSe5bUPXEgYv
         Qv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028103; x=1764632903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcqbQ5S4JXXbau3fgh6ZbMU20qGzRcIfkGSPAKTqhkc=;
        b=gcRhexWMLgCKAjteMJuLyp6XlAah+kZKH92MBb/8ZrSheyt1VXPOQB/lIBxOJ77TN0
         C1riI6sn4dLi1u7KzS5OzJ13Tjz5MILIyNHOxWS89Ys/Fuw2UDmi3zNKdMO5SK25MryD
         GbbzLkevJRiefz6JiCs82Qye87Oto2I7gj2j1dPVQE6FFFz0rlg3e0q3uw39dgRdKpsK
         eNd3IAGh81eFWx/lMN//j4DODomrIaXjHrylr+ZKEUvUr0erFfkQADzJrFtFzpJYjZek
         UqO8iiEkzYj/syPY6y5xjJocb7CbB5QLTIJLs2OJTXaz0IgXAttAQI0xA5l9wbIDAp7v
         CEZw==
X-Gm-Message-State: AOJu0YwNB8xd8rW13YY4MBVu2cLgZyZXP+UepFDk8tKe98DqU4VWc/mN
	5SwSTl+ySxpDiFImIzOIaJywH9VNcA2KDx3czuLGMdFXXacdMC/ruRPzL3lzDw==
X-Gm-Gg: ASbGncukVTuzphollwX+2H9sW7WYV3itmRH8gijNtr5rQdenIaYE9QCaRzV04mEx4p6
	rXiBgTTLRsgFdfe7vl410Fo613S3KTOuYHzZ6m7WYBWryDHWMsQafgDzDmWDMxqsHDexMl36apC
	I/onEySZoqXi0UCcsWZcwLmbS1KpJ1WbxkOzk5p4ehC4Sk873rQ+xvc/UxmWksLxys1UAFO2dfs
	C+IGXVtipjO3T8gRrXErcyyWOhVGcFHu8SlsTWN0Ic1YU2pwyBnWlSX31YLME+y2XNuNZ6DSWzY
	IgEMilTg26vuRLIo2YGfYPAhJFBSn2GpWbJEJcPg9wFZcGquMD+W31hM72yfvCCe9BCPMw/UA/i
	NKkjm2K9Ymqe8brHcTR0hIKkE+bgaDwAM1qmckxCsAaz/r10Ew2ovvzNDEMykd3O488tRjWNbhB
	AxDxJWTDRuPK5MK3tbDtkPTodriWq8ot02hjHcyOdwmDN5KYY=
X-Google-Smtp-Source: AGHT+IH9F80PvdpBpbojg7Y02KngkDHXsfXBdGLUzofDSvSvFO71NKJ3uHp3bN/w9c26If04NsQEQQ==
X-Received: by 2002:a05:7022:d45:b0:11b:c1ab:bdd0 with SMTP id a92af1059eb24-11c9d863a0amr6183635c88.35.1764028102624;
        Mon, 24 Nov 2025 15:48:22 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm72215056c88.0.2025.11.24.15.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:22 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH V3 1/6] block: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:01 -0800
Message-Id: <20251124234806.75216-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__blkdev_issue_discard() always returns 0, making the error check
in blkdev_issue_discard() dead code.

In function blkdev_issue_discard() initialize ret = 0, remove ret
assignment from __blkdev_issue_discard(), rely on bio == NULL check to
call submit_bio_wait(), preserve submit_bio_wait() error handling, and
preserve -EOPNOTSUPP to 0 mapping.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 block/blk-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3030a772d3aa..19e0203cc18a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -87,11 +87,11 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	struct bio *bio = NULL;
 	struct blk_plug plug;
-	int ret;
+	int ret = 0;
 
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
-	if (!ret && bio) {
+	__blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
+	if (bio) {
 		ret = submit_bio_wait(bio);
 		if (ret == -EOPNOTSUPP)
 			ret = 0;
-- 
2.40.0

