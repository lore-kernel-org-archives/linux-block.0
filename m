Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1572FB093
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028107; cv=none; b=uE9zRzKfAO8sZs0b9HW8N+w2FzXnz2iqIlN9hXR4ChLQtDmLpCQyBwRzhdr2DiTYthizxfr6x22aCQVO/jtCeBcYTiHlJDrLfxydE4FP/T5DYln7NTq3DLeFA+7kh3XTAp/bw000x1kZMDa1aZygiOBE5uhcUBJ7Spl8S55wgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028107; c=relaxed/simple;
	bh=ZSqWbY8pVyhLaY6mUuy6f+COqFQf+G+FnHH6zSesNgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBIqpTyz1zweSBuIHxwY5VFzRBpbCgfagO2DSXmCS9hojoTduqpCs1KrTnq2QZvz2bA3B3aybT+hvfDurLgma7gUhzcNl3rH/fmrJA2RUZ24ZlyIeWqk7IWlq+WrJfFE0cQg5gOr8u/H8q+5zkAeT/eZix6qSHxdWtUaSE74d14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb345Nfg; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb345Nfg"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11beb0a7bd6so5763221c88.1
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028104; x=1764632904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hEyetpjb5QpX08wjji0bcnEJUxus+pp0XTDG4Zkk6c=;
        b=Qb345Nfgcp4/TxX2cohDRFWy4A7Z8bs6C7M20K9EPkPwIvIIqvJcVU5QcCx/pVLHI3
         +nhvatqStEz4oKY8azbMrTkKu3oSrZpEK5Ep0VUn2e2LA+//TqGUJQZ507mggj2l6Q8h
         2k2JC3xiaANHCMK93YTjPDulC/6vXvv/WCeAbIsdWXjd7eeVQs3amslApCRGHRF67apk
         mIDoYKUYSfblcY8ACgSg3xqpnfQ79aAxC/mH5xofaBHX61fKsqoUtGA44+Jfut+P3fn1
         ovfpu1tJJC1qqmeWtiozD/8WxYkFXA3pOrKSpv2x0jJJMl/7tfoY8LWsML2YZEJzoVfO
         F4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028104; x=1764632904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hEyetpjb5QpX08wjji0bcnEJUxus+pp0XTDG4Zkk6c=;
        b=MHFadC9Pab/HINID67Wcz9qtcTfOzb1XB2FvvS6b/VQyUlMzA8YnfdC+cuHd4FJzHU
         VNJfuZILbPEmzB7pr9XMlM84GxiOfS0TwrLWdVQeWryUCc1d36w7Mj4yb3aTSf/qwUx4
         B+g8LvlwEDs2Fs2B4Gyp1AErg1JrH5wCQfYZ1kdm7RPMh6iEkAEnpyU50/unw1B/5KyS
         uPXbcfuzJbYa9qw6L7lXao68rErYcdiAoebKccXcrdKG4nmNW+94L6vvozn8tfJ4AXxI
         qiMlVSX9pVxfeRf9pw9QwyFFIN9qEkc8RHPmN+nsvHs7jsOfNZp9u1Nl6475zmN3Pboh
         Nlrw==
X-Gm-Message-State: AOJu0Yx/X95ie2koD6/lSI20yFyasD0ik7OjYndN12RH6b1MWXcjxBuC
	oR3JnpqelVjtR6IjXCEOSfEoFZrAntFPQLV0XFmbj+9ZWU1ay+XBKJ0N
X-Gm-Gg: ASbGncvrymKf121gtBFURITKNmWTiOcSNdfB4CYDPSh82wPuoqNZH8OngVJ//TvVFTi
	QaBesDgWW2Lv2SxpDkj9QPFq182HyyXrT0MkiB1WKC3v+7OEp4k15L8X1lpX2MnHdJJ8vaivu4m
	+hqrAybD0D8o6+knicBOZq7ccGqgOHcJAbdJAuIw8msb32eTX3naWmz1TgO+JytgnXrE7Ivu4FN
	CJmsDREce22lfTsQ29/xAAdX8U8oOPKV9NN0fi9qIzyXPg4BQqILkTe+lo8anUq1znJW0EDI1LQ
	9FFVmAERJNvjKe4zCc8S0bPX9UrTktx1/Vf20eL1RBDbnCaWp7r/wtMqFAfEwVP/ecJbzZIaWi7
	gIa++r82OVFFu2dLTJwSY892OLctPI0eniEGsQvtlshtTueiNuORW/lxooKeEiOxCUCXbTFJnBu
	UEANPjnF8Bum6mnzj0Qdi3Njf5gKe/t2+WLbNXHQbQamRCiww=
X-Google-Smtp-Source: AGHT+IG0os1yUTB1U8y0wFQR2JhU9wfG8RKwx2eS9+a2sORTH4Ie8rtwmUzrvPIYkCFTBjjRJcm4Ew==
X-Received: by 2002:a05:7022:ec17:b0:11b:9386:a382 with SMTP id a92af1059eb24-11c9cabc4f0mr8878128c88.21.1764028103912;
        Mon, 24 Nov 2025 15:48:23 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm72215229c88.0.2025.11.24.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:23 -0800 (PST)
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
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 2/6] md: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:02 -0800
Message-Id: <20251124234806.75216-3-ckulkarnilinux@gmail.com>
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

__blkdev_issue_discard() always returns 0, making all error checking at
call sites dead code.

Simplify md to only check !discard_bio by ignoring the
__blkdev_issue_discard() value.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7b5c5967568f..aeb62df39828 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9132,8 +9132,8 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
-			&discard_bio) || !discard_bio)
+	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio);
+	if (!discard_bio)
 		return;
 
 	bio_chain(discard_bio, bio);
-- 
2.40.0

