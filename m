Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B033B6F3
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713107; cv=none; b=qVZaGCnzCP78OzgXeO026u17YnrTyIae8SkFzCi/QtgLxW4cS4p7Csaylf8Tjr+k2UYrIfZV5ZVJtN42HvaNKXDccQ1x25qp4WN4xrRVVqxpL1OBXIfgqGlYDzky2oYRioxB+v4GLqNQx5IY88pMWfUh2OSWkdrl9FxsTUtK3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713107; c=relaxed/simple;
	bh=IQk4UzcYY75MLGhtAKmFDWXe3EWxpLfeGLiZbBZmOTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICVkKCgOHQ3zI6B2OLg2+E0lN6Y9hZ6vl/qFVTy5+aqEcAWxt3DT4n3ypkZBSCZyBj49rYwFy7MlW8Coursq0ngwEyA7ci7sv9C6INwG0OH+QmBa7NyNrZ808h1riBd/WmCSNxYNaUEFYZe4UXQiDvGZSwApKK/yoL2KOci2Yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEWAdUlV; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEWAdUlV"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2a45877bd5eso2695357eec.0
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713105; x=1764317905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=YEWAdUlVaOH/noOIugrjpzRr5Z1TkuhaccO7HwzLy1gI97l8y+2OepqjkoO6I5Cwk6
         XjKxrNtnzx1FJ6TbFyDq5L49ltJZhic8K2XdrHgBydXhkuq9NAXZNW/VkDyO6V1ymexK
         2mMUF9INciXOS0RHLhDvk366rKeNzvCjbpzRM/w9Af/lnI9owrXlBCqLuirEZZVm6lY3
         VXc5bOmRgZTZSfO7azHtL5phDBkugI5J7kYA6kxu1EQl3giLOZ18uDUqaAPGnywdKn9D
         M07J51EQ2sBHSOrCtD/Q9bp7dtLCTAOZx3hh0cRK4DuN0+j/7xXaFf1vlnPYS3KLA8Se
         t9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713105; x=1764317905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=Qisd3nFqo3Nw6twwyY4+d59z14+e39J4bB2qAI9Z7e6e/4PhmrFj3c8uNTnQ7dpe4U
         zs1SA8ZyJ6AWEnO7h8/88IwqejfMIU5K4X1dUmpALx/hcolej5+MpsZJ4RFs/nM/N4CX
         e9EK9ZXqYyUG2u2lns/bQB7BIHkMuLlvQ6L1vFDnx9YWQ6+1f1lWCBRgIojxhJ/Z+JYw
         W1uour/rqR7koCPBW3A3bhMeWAxHvW7zzc7f1vLWyMS+dfawIvfLBKQ8Zj/q+ikRyN+7
         YNOZ+ZkBBjOpkipFBKj9owGk2RDyPrvkpHqLtnFMimftIRfG4zz93q/7ltxHm/+IbVaI
         OLeQ==
X-Gm-Message-State: AOJu0YwVBIXj1UEGPjDFOtr3yp+or15Z8Kf+3yrM0b9PjbX4Gly/yN5D
	zgYlptmGIfjokHPXHMAfP01C2urULs9Tjq7qCWatxMZhuTy4hJ8PnQs3
X-Gm-Gg: ASbGnctFCSPXwqdYMJcedgimVcF0h4e1wF5nvIbn+sZafS/naPSucoZsuBisEGd1dbz
	Qm8YqQhHfD8kbN2kEGcTi+NeotR7FtdQiBFpU4s5VTYhm9chqAzDOucsSx7L9htVUrTP8h6G5bN
	se/mQCtHoXnHHsEQIocozL/U08PEdXC3VM8sQ2TZS8qdW501kT2DoMxykY6QGlBqehtYJjq66Hq
	R3CGaXdKiR+Dy6wYNu0XwkDR5nst2A4TesUvDZSUMIwQL2WWXz7Zoo8o7aWvfqIfh/sb2zewSGr
	54+4fz/gC3A8/eiKjOPRNcD+kD4Yh+JR92uRDp2JQm8v921zhRkyw7SGLXP1HhEww5G6bMmrY7E
	387lp7KJJBU7Ef8xMaO1BgoslI3EFnbnUdmt7AqXKIKgC3gUiiF0quuIu9RnSrsqrPakSubWjBO
	rz6kWB5QqhjVduopW5c3LhcgP/8g==
X-Google-Smtp-Source: AGHT+IHMz3ddZnRtvaJ/THHwP1wUMl1t1R0JBJZczRRfd42vINt7DVj8VsCW+6dMTczCFjZ0JXIsxw==
X-Received: by 2002:a05:7022:a93:b0:11b:a738:65b2 with SMTP id a92af1059eb24-11c94aefcabmr2003355c88.5.1763713104659;
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 6/9] fs/ntfs3: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:45 +0800
Message-Id: <20251121081748.1443507-7-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ntfs3/fsntfs.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index c7a2f191254..35685ee4ed2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1514,11 +1514,7 @@ int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		len = ((u64)clen << cluster_bits) - off;
 new_bio:
 		new = bio_alloc(bdev, nr_pages - page_idx, op, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		while (len) {
@@ -1611,11 +1607,7 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 		len = (u64)clen << cluster_bits;
 new_bio:
 		new = bio_alloc(bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		for (;;) {
-- 
2.34.1

