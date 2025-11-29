Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDB274B23
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406916; cv=none; b=fzVqZBBhCps8vB1UiORt6RDXpEhiD3QKMkYEFTsIOgEu3FMo/ysiCKGcabdyQMocvqKKzM08S50Fk8O0VMyxj22XFa0KR01isLOR3zzF3Oprd/np5dJv2rw9HY225t9Kg2YZC693kcW7XUaorinz7OARIj8HaxFQvqJfkq0O8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406916; c=relaxed/simple;
	bh=pDPxpgP4y7Y34S846UZ5pdageZyT3VDirSvStDnHRd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPlVDdiVJzI0lVxujps1ZC2Zc2c/63548aYvH4emtNZAMQ2TVuTrDYNYdCnhvgunQXO1/jsXiOhfPcVE9mIUHFGwGh8JaBq5/93Y11zXLLB8KmvNB0CUP58AnWlDeJqzezS1Capg3XiNed6G3s7PWtVZMQtFCkuEYhCdeBkqxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCQquR5g; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCQquR5g"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so2744099a91.0
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406914; x=1765011714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8NoibJSiNHVArlLUK5xHvDn/GmQ96N4NjNkgGx3wcU=;
        b=eCQquR5g2nzkSn2xhtf/misuhs+3/XAS8F89freoYMhp/QU2qz/W7KUKu01a/B+W+B
         qnt8HseNzz86ai9qT4vvsoI0a1AkF/PujnGoqDBMjIvv13WLo2vV8hSgARMExFaic8Qy
         6cHt1lezisfN6o/qaY5VGjok8CJkHHLi//N9zsORIFU07TrNviikiX0OMaeV/YlWSjUX
         yf1L068Hrtnde45bQb7zfgSePLkZQAkyF7A5MSsfY9+5Y2wv31mq+nUxc76XXG5W2Q6c
         2W7XzjtCSM7AMVBb/tne8Qf5Im1KuKZJk88r4q7+B4iR9HxlRHwoiJxREo8T/vtTDn6B
         Do/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406914; x=1765011714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8NoibJSiNHVArlLUK5xHvDn/GmQ96N4NjNkgGx3wcU=;
        b=xEyXtkW5u/7MaG6GX3HNuTmlYe6WLVk6Sx3GrtYaMu84pu83IscTB2ffGZDFO+1HoI
         CLHdw9Q3mFgfTS+YcE2Pt92sfxLetTLkER6/7JnOx6+4805b/VqWw6mJv2s/aVSH/t3p
         8AH85NaaihT9lJ3Nur1+4EOGOZhVXuSs5UlkA6SqNVRv7AzFAtV3tC6YDIVJZORtNd0t
         flnULMINJhzdX1gNQGBx3LK9E1k5+o2VVlFG7652hzLWIbGKxVT/OeA2hM7hW3h6VMD3
         1fNPz4X8W7NuESK6uYn8VjY1TYC4DZtC+LyoHRfdxBnjZSdsiijc2to7Mvx6hmIfq3XG
         r4vg==
X-Gm-Message-State: AOJu0YyUqZEaDJZ50PtM0z/xlBlvLqZuQyYZT7jyTs9jM4d49SJP9C3g
	BAslUY9hHxtJ3mLIeVPPg3HadiFpo3zs3JhlKuao5g3V6eINR2GA4OM7
X-Gm-Gg: ASbGncvYlaH+zCmvqkMXbHZTgmzcdAdJa2i+c/+JbfqocZY/JKcv3yQKFx9LCY8oysq
	0ZUX9ob/Pa64zEZMV5on9bUc/i6Bcah8YCB2xTK4U2/Zsuac82wEWJ0RLMhtzQB1LJ34uYt9n7B
	prG84+Qj2vyBarzhokdL+KsXEOOXM2TJgjeWnOGyvyyIzlgbdVswKAXZUCplFkEb3O5RZ3J0HB0
	BmEgMDkzfp2JfxZVcVL71uoR8MJwBvHWmg2vgmYOzhPAvo9lV1HbgbSMO2x7Wxu8hBNW5QgLH4C
	SWcRGcfyMNAH993Lv3LWf4MzJXkQGE3Q4jHjHE9sltYf1oxt03T+2aAay4UGNLlUBnWR7ErDC5O
	yyZUOPdBDI7MDqjAN6BcGkbskdXo0f7EJIDiFtLQHG1GA8IyqzY3D/rmm925ImHVqOCSs/F69NB
	H+iPpr4RdbV5iT86rst2RAHuXXcGOlserBcHQM
X-Google-Smtp-Source: AGHT+IG2wahiB2PBWVfrDNRf7p52lLBDrzQQGimm/4V6gX8Dcmjw91342gxhdzWR3iErnl9Stx9Lzw==
X-Received: by 2002:a05:7022:3c84:b0:119:e569:f277 with SMTP id a92af1059eb24-11c9d864eddmr16724097c88.32.1764406914041;
        Sat, 29 Nov 2025 01:01:54 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:53 -0800 (PST)
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
Subject: [PATCH v3 4/9] block: export bio_chain_and_submit
Date: Sat, 29 Nov 2025 17:01:17 +0800
Message-Id: <20251129090122.2457896-5-zhangshida@kylinos.cn>
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

Export the bio_chain_and_submit function to make it available as a
common utility. This will allow replacing repetitive bio chaining
patterns found in multiple locations throughout the codebase.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 097c1cd2054..7aa4a1d3672 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -368,6 +368,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1

