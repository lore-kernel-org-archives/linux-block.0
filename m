Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC323284896
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406925; cv=none; b=r2aLJoqGM7a6Bxjkpt5slIdYg1dKqjZDzNOp7jD40dEfjv2C6bVfkQd+6ewTf81lslMS8IAhW/2xOBLWYEz5WRJ8uhMjzt1qxu0cKV0dGYvm06zKl7gt97fw7RqacfMBX3eDtmchW2YT6SPwMgAywUnRs3sosEXJ7fuGVXscHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406925; c=relaxed/simple;
	bh=Hfn+I4xKib6YHUNH+g6fjmCyECLvbavw8yPYoNL/5CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rntlOcI1lV0aJxx3bq8WThUQRJJB+RPyAaC6Sqto+YTxcAVur1MIpkZnAVVZpKhPG3KSARLk8L61h4KCX3nlBsJCdyebDl2WBMiycJExGRwt0EM2dnm73E1qfYdp/YGcz+lx9XdQ0w84uN8y6RCD8+C2/IFGVmrJc+44I1uvVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd1ocxGz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd1ocxGz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so3089593b3a.0
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406923; x=1765011723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=dd1ocxGzdhjSsgteQ1J8SNLo8OkTdBZAanb6vnoi7oFFq5bU9MJlGPjhuAytnKRXwd
         7foxMQOWM9CeGrUlD1kcXTTvusKIKkyx13/f7/rFKW6layhbqq8l8U5wGBJ8Kgig59eJ
         p99Qc4DmI+mPpo5U5ok8IbPT0fhgeP3x9lRrqtvDlQhJ9QmDIDHVLCauvhgyhhmGfMG8
         FFkIU8Zl1AFofkQhVPM6eE64bjWyk+7YTN9jf6MxPy15TjQlLCGmg68P2pBHzIP6EL4W
         RAQIEa5ud3nDqEtRoDP2v/ieowml3UaYUT+nzfVlXXDAK0DLgRBhxecyQrP3aL2K90zH
         QmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406923; x=1765011723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=qlvy47DF1XaF60zQtxLVP0Zpkvx9pLOeOq9hQUEiu/1LhVBXBDRvJAgyxAerBqSTAI
         NT2/vSCa4mLk+P4BvPCrfW9ROkoHMFKkwO5iTrFvPtkWftzqSMP7HiH2adD1np95Uo2k
         j+kKNG3OOMHTvN9KUphE1TISAcT4pY1tinnoKJh23IKCFlC4Hf+pM/CYFQtbcLV8M0xh
         9K0WK4Ei7gOk5NshbNZI4GcWtfqP2ix1zCifrSM9BEyuNuBHbW8J5qwMRUIQ1mtyov5s
         7+KpgHXgGvWrm+oZjjfa7Z4aUvxrVg8ntt53NP4tGiac2dYExorIsvHTv9numqwxmiU8
         fweA==
X-Gm-Message-State: AOJu0Yznk2Y4c8uobsioHA57qHOZ9QUfM9sOZYU+dSzoQ7VXB8G0YBgp
	D1IcfT6t66IngdocKd10QAl3KJ7TrQTmyoNy8zQytQ/Asn7a1XjE21N2
X-Gm-Gg: ASbGnctIs8ObzH7CEuitU9xH8FUojbVuZVPtLAckHKR3qH1936ySv6wbtVI075GYw4t
	1CX5vWHo2Q9zH86X4iF5cmaXGwLQKi3HfIyS91HwaCmx0GId5ayALzidSX6IP5fQhbcX2zNgJxa
	NcYW9v0nAKZUlOqyncrCTv/vzfsUwjmqblS3lq7pK+r7nn/uDlgSOItHtZ1xbl5joanm5FgL1Sk
	jK/LWneNlIBttyoZqJvrzpp6tMNh5fVAwbM0GDCA5oZimBhNYkvAKle+zAjXG7QNLSjUO1RXd1Z
	TdrCf9V+sNOOEyVWn7Ty0pgxNWW496Gv25V77e593quVtiiQWkW2M7N6zxO+ZoOxvbJgDja0qGw
	N1S3YP9Y7dToQmnbptdJvqHdp4a0o2x2f66FuMuWx7+wdlg8i/m6kG9Iu1rWUMcrtkSdj1LJ72U
	rWmAV9RxozQcX2C6ZJseh4taDMOcUCz/ptoP5I
X-Google-Smtp-Source: AGHT+IH/QH6JeY8zEnnFSEp2edvSj4WvW2OiftF5ahPSC2LjhfBX3UeSnFliqzhG5QTteUkJDEx/bA==
X-Received: by 2002:a05:7022:ebc2:b0:119:e56b:957d with SMTP id a92af1059eb24-11c9d6127f9mr19966464c88.2.1764406923339;
        Sat, 29 Nov 2025 01:02:03 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:02:03 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 6/9] block: Replace the repetitive bio chaining code patterns
Date: Sat, 29 Nov 2025 17:01:19 +0800
Message-Id: <20251129090122.2457896-7-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251129090122.2457896-1-zhangshida@kylinos.cn>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/squashfs/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index a05e3793f93..5818e473255 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -126,8 +126,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 			if (bio) {
 				bio_trim(bio, start_idx * PAGE_SECTORS,
 					 (end_idx - start_idx) * PAGE_SECTORS);
-				bio_chain(bio, new);
-				submit_bio(bio);
+				bio_chain_and_submit(bio, new);
 			}
 
 			bio = new;
-- 
2.34.1

