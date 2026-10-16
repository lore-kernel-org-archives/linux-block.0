Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADE453A29
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142441; cv=none; b=cQ1Pz4YS8cUwFRQGQd5MlwzJLZaTuXXJFlwQ+4Z1l5iLA9lIw/WdAYKeZixXB6nOFunciBXkyTMOlHYZcxrc0dxHN9+J1dMXwfeRSecjcllv+8cmV/S8WRYUa0wJBz2Eo379vRwNE20LKkpPnFAbZ4p1oCAJnv7dMOT+zs87reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142441; c=relaxed/simple;
	bh=9BdK+VeJvwsYM0Dk5L2ZSmQqrG4kh/m0+1A9f9hZy0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGXrJ4xKp+4P22NjGdyybD1SqLBh3HCX7ChC4T/qNmxTr7Wn9Q4ottACZqtMcf7XwiBvOtLjp+nflszA5SGaQ8Gn2QDQuMuyBMr73xcDlNn7Flm5aD96FaLWfXKifNLPjEDGkdqzDNgbT0JCT4wYRH2DJ057VOdvZwhEkhf/cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfp0mvG1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfp0mvG1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso4848635e9.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142439; x=1792747239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6BKgekFMvHD5DsVjwR+Gu2dMSmztQt4quCu9nPLUhKY=;
        b=cfp0mvG1gf27ByQcrZcLrpzvujTDPekK5VK59l57ACALhoRXn/9ImlTqFmlsME8Csy
         3bjS8QWdLK+bIW9dPY2owXNggsyNyBjDIZ8JGzUyEMQtIbVW7q5vyshrfDhx9ECpd98q
         z/OIK3rdWiPJzxJMGVoYvOwPhvIDLfUzPiWneIXFetcOH5nRtozCTimIQ2pKC+PzBk1b
         GJ/5ZQQjx0wmQsJF89YHkW150PZJTXlemeUiNJRMrrdlkyzdN2NpxBX7OaXfCouEJl0X
         MoeLdXbBU2QF9FBb2cYEBPqkLengOi4ucCqUF/UKUlG0dUqEJy8GczvtbjTsJ+J1D3+N
         EYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142439; x=1792747239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BKgekFMvHD5DsVjwR+Gu2dMSmztQt4quCu9nPLUhKY=;
        b=qjYGkIJU+FU2fGmeQ4/+nhz7jxxARGLAp7wkJMi0gR9RHsT88WuShJ6KVpG37zlTRd
         4WcGkKbUmONS3PGx8nUxIx+2Xu9ayZm6ESTDP+q86xVDqDJVyV+dHWIcBjsbUXav3XfB
         vbZCshkc46LzXog0o9XPgy85oF7Qd6ZnEJeavpt43+j+1D2R1dAkFhDNKEFbVgTewrpl
         jCDprsf03y+Brk/yi/ATx1pz/e+lzyjbT/4jHuyzwy+MJ0k8esWTATiRF0aT/X7U2DtT
         2YN+HDYx8pQsYplhziXUbLppB5RoW8rUcfoYADpvyaqIM+/KoeYa99WBL2qN9FjzqJsC
         Jg3w==
X-Gm-Message-State: AFq9FYK+ESI+87a+LIZriXzILdzJKEIl0Dix3aaK2gB3bom28u7ZhhHO
	9T0sGFThPP2M+FGvlLnjHithir4T7PUihABVgv7PgMwqSz/Um4CdFvzERRvz2g==
X-Gm-Gg: AYBFou3D2f4MI39v5NtiMrgc39aHr/0riu0AXrQJApgTIoz1JEe0C7FqKMwLCzcuT93
	BdmsrsyUNZGyF67Pun+i/jSQ+m1aVsOupSaY1DAEByrz+G1DytUYCIa9GN1Lpk0buQdGaahIZz6
	9wnm/7QNK9M9ziy2GZkhkH8qN+jekQzwkuOEr1cBcgjhKX33OGY5/IGK+j+mIjj5uEbpGxiWgiU
	mjwMBgDIQtjAi4og3iqnnl1JR8lvHQXEbAIOqCuBdsLnoX67Y0utXPW4ReBlVDNtjrocZ/Zo65v
	Q0RRSO495xA30xDoH/jCPdVpQKPsLMoYIqRklOrWduTah9mY4AqUCFofak0uqbpCaujF8Or8Ty1
	dcC/ywAL07mdornwA9G93Nrpo5ZlkEX/pzZQA9NzX5L6KbeBCmDTuYgv/cQn8n+ydjGM+eR60bb
	HfYW6ATfrfEwu7y+UEGk8JFH+dnyoctITh6G1w30l+4rqJAa7izTN8224SgFoDmEfg4i0txtYLf
	SvPHG3am663W/WPH4pE9zXxVz1i0UnN/zLleQio5ebymKYaFUWkMmuuNsEsux5SxWUouMi56Rb3
	bQ==
X-Received: by 2002:a05:600c:1f86:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4a1c6672f2emr51826055e9.10.1792142438508;
        Fri, 16 Oct 2026 02:20:38 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8b5fsm147408865e9.9.2026.10.16.02.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:20:37 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: fix indention for dma-buf checks
Date: Fri, 16 Oct 2026 10:20:29 +0100
Message-ID: <de91f480f8507d44ddf99c193ef63dec0f02c749.1792142187.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a weird indention I botched while rebasing, fix it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b7f8cbbda8b..726de869a86f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3151,7 +3151,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
-		bdev_has_integrity_csum(bio->bi_bdev))) {
+		     bdev_has_integrity_csum(bio->bi_bdev))) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
-- 
2.54.0

