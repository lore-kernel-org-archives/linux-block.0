Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9621D3E8
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860843; cv=none; b=XdfKy1YKbE7mYjer+YcVG/OHd+C9+/L6/nr2vS4OKxcyHY3RxgAUv2BGNf8l7/2mdSTAH5kFSgPxsovV57t9F8WqKjZqxxxK2PqVaCuPbkmtVIjY7Q5hazlfKTpLBIo4/SJ98VGZT5e1mAnEAhLUIIiAD+o5hQnbIxiBU2Ns9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860843; c=relaxed/simple;
	bh=Q1mlWwYaLkVluPXmDrFeV3qn9UNrPlRNx3tBAwvjXGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djgXj5b9CflZnoon/n2DiljxQJs6CAUkVO2l6rVBIma+0YKBW/ydswrmUYHb2BCqnSCnrL/0PJ1WmZMYWdaLoSqCNZN9X70xxVLlz5EJHxWSMwf6ZqJhfnoq0T/zn14/QsfELdeDzZ1SGYLAxrSCSAX2KKN0P9K7PanfckpA41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZDqi0Wg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZDqi0Wg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-793021f348fso868410b3a.1
        for <linux-block@vger.kernel.org>; Tue, 07 Oct 2025 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759860840; x=1760465640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNH7CpxZO3HtMj7WjMvzIrMn+R/eBczieyRcit2i4aA=;
        b=PZDqi0Wg96vMPhqQbb+0yiL/twuzY/t9JZecBj8oGdTEWSTmf9n0TO3zdfZOF5gR9W
         8F80uQZJqrMuZFxFA441Tza4PoiwQBg5E0SXqgpI+IM5XDULiNBfIc6a+Kno2uIiWj5Z
         gpNP8aiNuS8zEwzuOAvTqqzrrhGhlFrzebmq9IOwpbwCQxbSOVx01FU3amrdlD5b1DOI
         Kz06EmNt3PqMO+/r4uzmQKe9TPyob7Zi6NNRBSDSVA1hbHgun9d6wehP7DgqqnzXTZwF
         1aVLtJ4fMEIjy56qHfXKwkTOcll161fCRQ4mcRvC7cRDFBLG7BbebJ9vWDD4aadDIGJy
         nmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860840; x=1760465640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNH7CpxZO3HtMj7WjMvzIrMn+R/eBczieyRcit2i4aA=;
        b=anljTfozcv7WqHL5HaGlI0/ZF5HmBTvYJrA6B48ec3fNamx5tDU3E7jNtrNuFoFrw4
         BZi6fb0UoS77whlJpHki3pSm2jzrXsZzQ5MRbLqxS6/7aOxXNe4pUUTtsaRhaE8Ex3kZ
         ja2upTo/Deoc5/tc8EDb+yigfM3qA6pK/pxDiPyvKwFR/vNO+Ds3Swxs1QRXh44WylwZ
         2HobZOWWbJ++yYE6taNX23NhjcC/rmH1d+KecKWtEHWq+8QbgjB7iaE7KXVnKaBWExF6
         /J2Dh+RkyG+9+7FuNlI+btwpFewCvarB3mUCilEy68ntBZlGboMOU963dmokYBrX9Tc3
         EWow==
X-Gm-Message-State: AOJu0YzwqbFINkm6rKGQJl98VlU3MEc6PbfX5nWUeskKOXRwb2hm0yFP
	4HwpKPf3Ehr/jSqiDem09Vi8UixdxUB+Axn3XgVHS5c9inH6fCcwO7ARi0O4BoV1
X-Gm-Gg: ASbGnctgDJ3hh3ZauQV3c8IEtQRfcMOuVkzJpQAI6igkge51msihwOhHSEpvht8cuTM
	5/5SxGEHgnH/kPEMsWtTPvk5RBTIS+wKiT8tiHNC+7P84p5VEVZIYlhntMH+odTLD2qWYtUMVNt
	6hiFtKiyzB8/P5wDofKgn2a/829wOe59lW909mBTeuq2cIGe84hgphUMuQuHtzNT8fJeWv6pHj4
	vzqyLlgv7MCAINAwbf/wsA7Pj9kTzWVR+0lecj623azv5az4kARB0Ecyv1DEjNZRNtYgKoORBl1
	EiDxsZZY7XLb3ujrFds5zvJtAQTDX3mRk0J3as2SrdBoTH4Blok+D2KgxXl1IGpT2ryyYNFZScV
	mZXm464H6dsLgRfN5XueC6tQDSOLAq9pwhzV+NNq64DzI1Ei5jSh1alXHzSt1xg+VhAZKEb1i16
	Q=
X-Google-Smtp-Source: AGHT+IGEoaS30JkexbczCkER0b0ny9qzXgkbHht7xAbLrqWH1QGS1GjhAeCdWjt9DWYhbnAnZJI8QA==
X-Received: by 2002:a17:903:3d0e:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-2902734491dmr6799305ad.33.1759860839964;
        Tue, 07 Oct 2025 11:13:59 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:71cf:b339:3993:4f8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b844fsm172349505ad.69.2025.10.07.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:13:59 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] loop: remove redundant __GFP_NOWARN flag
Date: Tue,  7 Oct 2025 15:12:05 -0300
Message-ID: <20251007181205.228473-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the
redundant __GFP_NOWARN.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 94ec7f747f36..13ce229d450c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -824,7 +824,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	if (worker)
 		goto queue_work;
 
-	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
-- 
2.43.0

