Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFA2FF179
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816508; cv=none; b=ltMWDR9KDthwfzoKFoooJ/uVLjjABjpF767CUHWmFfAchTbqZPeFgXz/LLBJcTTXIAhqOwtlfbgW+YIeRmnZJO8J7WKxTw4QeWPRwVm56ryOTcP8RrqIEedIuVIZ18yZ+DSJQpJOPoA/9OawqsxgnLJiVnKo4JfdmaxSf4tYl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816508; c=relaxed/simple;
	bh=KDrm5Wl7SwMy/FVrOjYy2K/P2b0W6LVDtJkcurNDtq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kta45QAtQYMqF6Sol5FUxxrNC8aOANX8fGXFRbLgphLtgt3ABD1m0JiNMrDcKU+w/ESHQhfgmjn/nkdn0+CDaUy94uQ5ieQuoIRObjcjO3+9grdU1D1W6ffZ5ZcKYM3QIcXyAbn7gHKyRfG2qpIXMnUUFEvE1jV3yzzyEtUeM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lso3dq6X; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lso3dq6X"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso429048b3a.3
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 18:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764816502; x=1765421302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NLLZx+mFtUT/k/qGnCVEA9+fBUA5GMxbqrpW9T4NgE=;
        b=lso3dq6XMltP2n7vWp4NPUbzMAfBgjugOkewORA9IYtCLD0Qm7p3CdpvoETtMh9a+m
         MBvF8Yj44J5+J63A82m8WTed8Ns0OJvb3ulg1dS8O/y6HXaeRmlf242bY1FHExZo0OMV
         Htn1K2T3RcTBkWyxFn1PAb0dimTUEfsVMQyoegLDXHKnvehNYaHjYR2bHAcB/I/1+gst
         urR1i0OWxp8pppG02FU8OoX3e4JUMqYGurXta/+tUadZAKNXYmPzusDBXpqMVW7bKYLl
         lRyTF7Bx4Sy6Bf674MWmNaPGM3iZS+e5EfojPWCaT6LD9v1gv2U4I7uj/zRpzKG1tjUf
         IS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816502; x=1765421302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NLLZx+mFtUT/k/qGnCVEA9+fBUA5GMxbqrpW9T4NgE=;
        b=ff4KS0NG0KBmQg6vEyt3+RgRTHw8npR7ojYXgqVjOs7DPPKS6z8fxf0GxLOd788hEi
         ShX2bR7vwzhI2RVLvWbeAoe7CI8d9No89F22y5s2kKpQhlEMAVbCqOzF7OmA7VGSfW03
         iQLUtoVtLxj5IE1lKNo3+P1iyV5W7ma7EgKimSs7/UsNL47/w7OQZyxPXOmMwlh4QJnG
         4LA8kO2EvYkhHcgZRpeQtcB+QiCG4+FtS5YyRTrGvSuE98tUzP6szAn3LSd2bhGR9MSM
         7w6nnmLn46JSOZGWXh/IXKUgBQ4mQ1bl3d0Bk/yPOzS9/FIQluELoSZQ79CNg7bxgt3h
         cwdQ==
X-Gm-Message-State: AOJu0Yz05yzqC6JYQK5HPur0ce2ogVhKksHcITyj61BaLjCs03KnshQx
	HVgTeEUe0jhfqf1Mkni1Q4l32XrmedQkIS+W51dKXPW4g5MJgqgaOLIJ
X-Gm-Gg: ASbGncvHDpb7tDi2BenwtVXUf+MypaBUQ9Yc2gUrc/OqMi9yXUo4RGxXopkO3YGm60q
	ByfGbGVPwonFESDeRsjulyMQNBJhqv/652dJuHPwmVUHVqOO5MYi/hnQYjlv4SmddNSrOcsoAkJ
	lfySCqW90IUjXlFHExs8LelRjXlOgVJtZQgy7tF31BCVXhn+HOmcXkUFlMbYEI3VNEKeXax+0+c
	FWkiD0DdvO4LPTKBUuWT4DWUFFamRCWXTrWEclI0iuCDhJ2xNYhMSnFfBwNxnQ+0GPFMTUz5N52
	Sv552/2Of9hKFTTLp9y0+la4PwxYlMd3s36PBQQzS834sEhlVUPDmv3+NRI0+uRRZkm9g3YFuWG
	tCXQQkYDtywzCcRc4t5X+g+MPIkYfkfZoMPg6+Ce1aPKffCkHPj4aBZ8ZL3KhFDAR9zRlcI9DDL
	M+8S+Y2T0LIRKn4wm+Iu27WZyjJQ==
X-Google-Smtp-Source: AGHT+IGYitTygcS9mzGlf9GhlZLT0eKknjI9LuN1aruThHXctHluTBM9GZL0ssswaZE5KQJhhrzPjA==
X-Received: by 2002:a05:7022:fd04:b0:11a:a20a:4413 with SMTP id a92af1059eb24-11df0c3c92emr3346889c88.31.1764816501932;
        Wed, 03 Dec 2025 18:48:21 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm1838847c88.5.2025.12.03.18.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 18:48:21 -0800 (PST)
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
	starzhangzsd@gmail.com
Subject: [PATCH v5 2/3] block: prohibit calls to bio_chain_endio
Date: Thu,  4 Dec 2025 10:47:47 +0800
Message-Id: <20251204024748.3052502-3-zhangshida@kylinos.cn>
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

Now that all potential callers of bio_chain_endio have been
eliminated, completely prohibit any future calls to this function.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..cfb751dfcf5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/**
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

