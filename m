Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B72F12D6
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318780; cv=none; b=Iyp+Xy+hLR4s7f8851gtTk8IOUkKcRmuBP4DRe/Xm+LwLJS8EbLqPIJhi3XOqBVd4paHqPSWACTd8dEUQhKuqD0UAZwLtJOCtLwlqzmITxA9P392bodcZ96fRONj13BISP9VW9LOvgKipiY9ZIj8jfdVSSqc4H2+baelzrs1NKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318780; c=relaxed/simple;
	bh=XfGf+/4TH9UT7Q+DEbtJ2829MlGgMcgOkxUS/OB2JNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpyR6jPqsVvRxIG9qeVNKO35anLhhnSR3lNca7V8B0tlBjYyr/hTFvABwzs6t+hSvXCGxA/Yxg2Vg26ntS74Vmp8xvRkr5RQkXXB0OuX9OeY/QQMo2Mseod6/B6f8LYVsblvm3HnOdq7dy3r1HYu7Njqe1gdhdwpdTNM+SZH9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI4ktECW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI4ktECW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so2014256b3a.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318778; x=1764923578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=SI4ktECWGAdxQ/h5ju+9D467iQ0/b5onxBwTSANKtpdW6BDsrTCOBt0Z2whVC1Kgc6
         SqxC9/yrtDlAggVPK64cjH8kfhOzaGrZ22JS17I7r32M+F/OOlRvLkW9VmrFlWdD9BQi
         cd1dIhzw76SZZqIIZBA55GnPK92aV9L3rFxGG87UGo6p7jPJJvEACSIdXqbPgIIAoWXm
         dpzrjxLacGVnjfljRCZozEBRW8Srq7qH4WQAk2301BB7dH1yjlKEIYl+H49ja7BuNBTu
         4msQwv/o6Lclgz2gjm+b7vK17E6S1wuf2ciylRy+pf7mRsGXYNvw0hyiuerrllb/+E4l
         NaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318778; x=1764923578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=ZKpnhV9Rjbt8U7/FebLlqTIHfak4KB9uyjKBOuDx6K8hSORaqcmH7VHKgJICa68ngb
         3OmrOnzWZiEgyQSh0/O6DKopSQWfrFhX0S5x5mohKUUXCtwYQc+3OZXSDC0UJZ/NsSVW
         spmMS8i+tCd0rX+NX+Q1Yzoxdf/nG0wirmYsbk3lbVE0pGI5vy6Uro0QuhPHynYy3CBF
         GZkxoVYLUBWzqQ9PPBx6hF2yzs56+WkYuTIOOKuGZCtn544q3KjqI7oI03LxBYYjmwxM
         Y4yKi5pdJCgD6VoD5BNlovM4FgJXimpn3OLR1iWcotJi1qbvlFHlK3JNGEgKACuM4dXI
         9/VQ==
X-Gm-Message-State: AOJu0YxqI7iCpZpW98utRHqs0gyt9UvTCkXRjUKJDJoeUg8LGn0VdnCJ
	fGOd5BU4BYtM2ONnL2Yx+SqRL4+JHGUfXEccY1OcTxFDRhiuzVazrssS
X-Gm-Gg: ASbGnctrYlVSKxy5ioWgUfRE9OugULaDmx9X/4PnNdrg2SdYcNvnDOm9Dmjvo1wVeEH
	uddcJygDwbFzeO9m8YmcjUgVaajiNXpNbIjtyrU2slfxiXQ/nKkdq6qWJtL/bYA3mEZLVR7S23b
	THasGYpCOzn7WTmMRy/hJnz0ALupE/+q2S+si2CHZQvsejD0Ww0/L5TIoYtsCwjEq6AC0IOzLxF
	7o/Za8E0w2OeGUmrX7NAG5ovJScVy3ZAgDr+V/giIkkmPVRd8uyLFvREGYld96Q1UOz16s1UyNb
	sf0bV11NFK9XT4888qW0RQyIx+wCVmIgqKQyF/0+h5nXI/YpwjNd/QF1bIsUe325w205Amcnc6S
	19UM0Xrmh5lY4/8u0jsCmt6tIjDiDvKDRksTSjP0m88fzEhVidccxbzOb9nNQAjQQa2c1lct5p1
	MnZ4FLiTpfReoLK7ErHMlPbpW2Ug==
X-Google-Smtp-Source: AGHT+IHuO0sAEeNowy1+oe3IeEgaIYQcRN0FMbygDOiWMPQmdT1sBtyBJY7y0vyzVSrhuxE7eNWdhQ==
X-Received: by 2002:a05:7022:5f0c:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-11c9d8539f7mr12036129c88.26.1764318777892;
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:11 +0800
Message-Id: <20251128083219.2332407-5-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
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
 block/bio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index aa43435c15f..2473a2c0d2f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/**
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
+	BUG_ON(1);
 	bio_endio(bio);
 }
 
-- 
2.34.1

