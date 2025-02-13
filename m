Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB482135D9
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441186; cv=none; b=AAwSbQxzaT2puIxIIB/z7BTJmfXqWmLpMNuMJMKAg+et6WkhhYCnlS1/JrFjkKv35yj2P6oMexXVBOCLEMQVAEl0jd/DjbmdS/tqGLFH1WHWlVwWrkB64ubOvwOXT5AgIkQo30RHYHLnKYfLgaCEed58SctAeDsB9JB/BYzvi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441186; c=relaxed/simple;
	bh=Ozsz8BPgoQN4B3zUUqM964eDIDqr49StEvbvIkkoggw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQ0wp7WZNq3sXKIxwh6WPizywuqEJg5xwVLk9uSocm/FW2qXY0MOIKKh5wtUCw/8vzbnFxNs8P5TyrLUEXwjHDmjQRfqiFcxVSja2vokGFADmWXYkRTHSPMYmIv9f3OkerZRwc1L50+TWZFs6TVhYeAbPfGLzOSF33HtiSwwFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=RNxX7nqo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="RNxX7nqo"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d132f16dso9083115ad.0
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739441184; x=1740045984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA+PAF0czZRgWnRE67BxncOcnNW40JhC9/ZsrRpE7vo=;
        b=RNxX7nqo/QV0eic+o41hW13hbz7hbJBEgQL9KZpLd4XmSrGUnDRgau5A4Vipmr53r6
         LyzNWneeXZWC7xe+wplb/3urdmJmNkjQeGmKbG9YOgx2XAaCoec6xe9t189oM/gfOL4e
         68bzcx5IqMdNObXhReixvb/9EDtoG2tyb9dBU9YbTIP96CM1CmAf0uMCquFgVPnl4B0N
         VJRZly26tjECro8Mp8WJiz0gd6ix+3aBwLRoDdsgQmpdhsHGTEByKwk/ZsE32Fl2l49p
         CfhdX/c8uF2aPw6g2XULHWuOnPmQNP6+MjPaBg+MctDtI52cE0ZlNghPUTGGcuqrwoBX
         8NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441184; x=1740045984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zA+PAF0czZRgWnRE67BxncOcnNW40JhC9/ZsrRpE7vo=;
        b=rzN1e5PZ206mcswaU/GF7/XLPu7zKml25cF61OcdqJ6/n5pKvfG6Hqg6NNsQWVwZUr
         YdZm/w2tf/fq3C9nYhGuN00CjZ7aYZyoKQMnx5AwsOHOmuSo8LdGTX5p+3CYs/6ArsXW
         yZt+fYy40qvxU4f5LlUvUlBnqo+RqYm/cz2J35jkw2I3CZvP9l6J66KNgjRmabweqt69
         yu1hfhm/u5Ou5xTGr2QKkGjnDpx581NoaZff8ooNnP7WsoKPSERYHMQHshBYJsfua+ia
         BWhAIgG431F0beBqL7AaaAPTYX8BfUGEtY8AafGlNbP/k1rlvFrUY7At6F69fYB1S1E2
         2m8A==
X-Gm-Message-State: AOJu0Yx8irIpCD+WtJdzIL556IbcgiFwr62f4P+19Dt7JBp38IXx99Lc
	fi7GSluipEkIRYgTrMMu+ZwXi8JX3QBhtUIOCi2wzgogRdlQdDGIjXIx1QJD42M=
X-Gm-Gg: ASbGncvio1jsPLceP58sYOaHDr3SCbYu//gkhFsvHDBD2ZoOYpAzT8oPQgZeV2z9mgh
	zYVI1DjII95tVcLanUtN/HCSEuecLSiYwk0Tf4dA9bQirgI29ExUip4o1PdVoVlf0YjUTG5wuP6
	dfcu28gK5k1PazqTr1WTFrl9yYd9sTQp9ziqG/DsT67FZU7Mou0rjzzj413ZsN3RCux9zcGqOWn
	M5FSozho/eOrSSQE447dxqZL0YWomD8b1ZvmKkgljsPiyLXB1m8WToINgZviYf9WdEZXk6mVsrF
X-Google-Smtp-Source: AGHT+IH6BO48+mvk8WAXI15mKey3CU3lO6dOiK5HN7kUT1OgIzkML5rU7vjzyJAMTQ255bPk7+t6Vg==
X-Received: by 2002:a05:6a21:6d85:b0:1ee:66f6:87ea with SMTP id adf61e73a8af0-1ee66f68ab4mr8632880637.36.1739441183980;
        Thu, 13 Feb 2025 02:06:23 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761569sm937442b3a.130.2025.02.13.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:06:22 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: yukuai1@huaweicloud.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 2/2] blk-wbt: Cleanup a comment in wb_timer_fn
Date: Thu, 13 Feb 2025 18:06:11 +0800
Message-Id: <20250213100611.209997-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213100611.209997-1-yizhou.tang@shopee.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The original comment contains a grammatical error. Rewrite it into a more
easily understandable sentence.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8b73c0c11aec..f1754d07f7e0 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -447,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 		break;
 	case LAT_UNKNOWN_WRITES:
 		/*
-		 * We started a the center step, but don't have a valid
-		 * read/write sample, but we do have writes going on.
-		 * Allow step to go negative, to increase write perf.
+		 * We don't have a valid read/write sample, but we do have
+		 * writes going on. Allow step to go negative, to increase
+		 * write performance.
 		 */
 		scale_up(rwb);
 		break;
-- 
2.25.1

