Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338923AD508
	for <linux-block@vger.kernel.org>; Sun,  3 May 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798530; cv=none; b=l0Zq/D5rvFRXWMwWw16J04fyx1b06q8s+G5xWWgI6RegaTps7LxZkajHl+smhL3wRQHcrHAosgqmunfTFTDciFn+ali7ysc54A2COC7ch6E6bBUTpMnAlPEGew6QCs/+Mw7HQCwcULbRa7e80qlE6ICfJS5YvWt+jyGp58/ojQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798530; c=relaxed/simple;
	bh=xuQ8QFf8jmlibQWJn+fCCUbp7U1NGtUiH1EfFJywqXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kr4Un9hXB9jzlF546X9E9/KYlbrvwGo5YPdkU/lSXtu75RKyedj+du5rIlMiDNxQQmdoyluY5Ij2l0EgwEOgZqRjwjbeIdVi9HQlXspKOKj/AgkZGcxBLPwze0Rdz1z5TGUY9xyY67TFs+D1jlewrayAk/LVzn7VazmCz/4RbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dprKYGDL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dprKYGDL"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-834da62e52dso1486162b3a.3
        for <linux-block@vger.kernel.org>; Sun, 03 May 2026 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777798528; x=1778403328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGAmO//KzqMjyS22/4dzu7gfEipkR6dPnAvU019iFJg=;
        b=dprKYGDLzZq+j1JfsA6HBGrFHDpFiEv+qXWwwJizIz/YMzBTDNRXWj3NtPKZgQCFzQ
         vyMGOMPhB9j62TVOI4Hwl8EhK3PsakzwLceadB+s19bdp6ewd4yOjlD1ySqBcv0YOz7Y
         SmQeZI3/kDKNwUAnG18/V9oUIH9WLU12MRXCkBiAlQ2s1xDV0T830yam3nC0Bl40JEKh
         igDSWiPUrxpTZTmnPqmb0yaSg1F9vlu4Tp/0CJFIuQs699zP0oeUHhyo8XmcIsMfpH7W
         VMFpHQX+q2pBCzsRZcbYKYyUEiEIxHlBpB/BgyD+LmL/xiWRq24Zok6EmsyfRQkXlvkc
         W76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798528; x=1778403328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGAmO//KzqMjyS22/4dzu7gfEipkR6dPnAvU019iFJg=;
        b=lATI9oXzyCobJN5lVCSOpRJdAgiWUIpmz0vlKU84arJD8Uc+SGZbaMGELbK3Ue+TZp
         Ep8aPjRZmp6glWcEDXdqDPURQB8zO4mzDEEDS9h5X6Dug4eZERPIu30eO1Gi6nKCjxCy
         yXZSYUEsXLePp1aW9GaesGBgrBGEz9cpW3KY9dGPg+7G+Fif8BuAPU3GBOcnsOMdXhmw
         nQaWsiO1L+8L1VKmqVrKEv58EPnXQ5+d6p9V5rARmNUpMzfzZyH6ohGRYE4WAy1F0NQX
         55ooDlUm1zf2o+Ega41whhANG3QzSjS20YDJkdnVreC0uUl5owORwccrsxW0ut4nwwzO
         iOAA==
X-Gm-Message-State: AOJu0Yy9730xcc+pFNw9m5rmzSucRiTg3yQm4RWkALtgd3QamMXO8MOY
	01El2aypbE8qVlBRadb+XUyEF9Vw43wIT5ke8+OVGjdGSlg9kbvLopP+
X-Gm-Gg: AeBDieskcOnbvKJJxp8qbyeIHHl2QWLNZxLHabxLwPcYVinmaG2+vYid+NrfZ46H/v+
	P44zzpzJZjz6+HM4bwAE3+VaIS/bXj7/m0A3yJP98LbSsaoE6uObjpGqzduUAWn3hijkLzjIXxq
	LL10X1PMnXJ80ayqvUZPuKdd5d8vLndQZy78HF3wbCSSc4B6LWZeuBhOI8K1vl0mFRVnN3feUwI
	GvpAHoeh2YZ6kA9uGzw5I6EWAudIiyffZ40vglEHqsZfI96nY+yTSzylAn7EzWQGUwPuJjcxGhC
	9lIy9wplYHLqHy+ZflWEUUYdPlue5vvNlpYK6mTMmi9Ie7TV9GALW2mXncLcVOAE7fuJtxsPhTa
	3snm2CdsBP62q6wJJ2OmnZ7tEpg4Br3nKxzkDqLafJ2fltMYrsBkGn764DYtd4xwScQsuWa7AxY
	nTephh88H3t2O9zfok290W2Mv5yvpxPNpAAkU/qAzkgJwXP/OTAei6DmU+qKjqc/x7TkVrE8kd8
	+Fkth1Bwf48Y7NCFQ==
X-Received: by 2002:a05:6a00:8506:b0:835:6388:655d with SMTP id d2e1a72fcca58-83563886e73mr790073b3a.14.1777798528430;
        Sun, 03 May 2026 01:55:28 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ede7:7091:90bf:e569])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837081abadfsm363489b3a.42.2026.05.03.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:55:27 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH v2] blktrace: reject buf_size smaller than blk_io_trace2
Date: Sun,  3 May 2026 14:25:19 +0530
Message-ID: <20260503085519.138360-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_trace_setup() accepts any non-zero buf_size from
userspace and passes it directly to relay_open(). If
buf_size is smaller than sizeof(struct blk_io_trace2),
relay_reserve() always returns NULL and all trace
events are silently dropped.

Reject such values early with -EINVAL.

Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
Changes in v2:
  - Use sizeof(struct blk_io_trace2) instead of
    sizeof(struct blk_io_trace) as it is the larger
    of the two structs
  - Remove incorrect syzbot link from commit message
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..20f941495151 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (ret)
 		return -EFAULT;
 
-	if (!buts.buf_size || !buts.buf_nr)
+	if (buts.buf_size < sizeof(struct blk_io_trace2) || !buts.buf_nr)
 		return -EINVAL;
 
 	buts2 = (struct blk_user_trace_setup2) {
-- 
2.43.0

