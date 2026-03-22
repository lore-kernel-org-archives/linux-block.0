Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCE13B7A3
	for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774156728; cv=none; b=fKMreDX87ex0IZROcPsSU46pK+6jhSiuGeAWqnUsYyABGr0AlXwnEjTjw38G/SkKrrttmPgJ/CAguznxczPOk+3h6Qu4y3SCpyyogQZyYy2LtTE8JGQEa0gZBzHBq0XkVXiZmayJRmmb/BcuOUtOc3lCSW5NfkVYwsc9IfWNo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774156728; c=relaxed/simple;
	bh=2xaEnwLXi5eOBedz1ZoYUtT9EFWQuAofCjjQbziteGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqE4AyFV5uqEbI5Z2s7fVqz4zcHtlwX0iaXStTTlLh/F6T5KaAYcwf+JEH49G1t34T6fwdyGQijYnQrpI0rQpUtfviSCKphc/quFyqA3HJrP2mnuv8pIE+5SYO8f2atAfXFw/WBBXwyPtGeptqcJS8s4VOAMNF0IdeQ/9zp3I+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2nXET5i; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2nXET5i"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso1883328a91.0
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 22:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774156726; x=1774761526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ2ydp5DIXGTbamssHDT6ki+K9ebqq0Fzx0VDSRMkzU=;
        b=M2nXET5i6kNiNvNqphgmOjSbm9EbDPiiPXICDQ6Hhfy7aEY5Zv5Xt/8zRXErNZSnTZ
         YRSjdHoxwRHVe+EsvB6q40LkohT/RBoJnWpv0Sfdh6wkDnw3pTatsNhxQHCXMc3CMdcX
         12MvACZSkhhBrDvKadkHeG/VF/G+g+sFlM3j82SdtW7tLaIbkdG+3drueuf/Xx31Nt+p
         hTS59ZodlEt08CKADmW5yd+UtsErc9MZiqLTy08dRxe3O29lOSKrCOdp3Sryr31pCzH1
         N7akmawhMF3V07hopbT4nop+t4msS+bgMh/7sSFV2a7u+UZBIolWkil/Sgd0mNAq/lIr
         w/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774156726; x=1774761526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ2ydp5DIXGTbamssHDT6ki+K9ebqq0Fzx0VDSRMkzU=;
        b=ZGfCQzE0uikAVsACCuiEVsmasT3Rj+JLPeQ7Yb8/0B9V/sVXu43DnubMc+DXjdymHc
         ECMoYr1B3OlXH24RJO1IkzK7/wJ6dF6xsnkvD+BGdy4V3oCHAkKY+Q47SfN9hPAhd6Fz
         PP5JE4QQ+afE33TGhBkVFR2uShe9IicP8vqpec/YZz2DgU1zofXkZyxd//uSPiMkJVyV
         rbHI2kKWCGITLYbUyBo1E75hKiq5LL9UrUgYhcHKd/bViGQSN8fPPo85bpXsTburKM2h
         BBgfOKS/H2GskpP4cGGdeA9K5WzE0g+uSOJ6ID9mAg4aER0xaZiIDh3Fxg+RREbpKlDG
         +vtA==
X-Gm-Message-State: AOJu0YzKvFhMaQdNSiQanL6GyWbzza7MH5ItcABXvxXf1wTpX6oJ8wHg
	6Kt/JDvYjIqLF3WBa12zZBek1ZtOUB5VOlpdyLem0tE92ETeEueROHCJ
X-Gm-Gg: ATEYQzzf8p1ZMvdwD2vUzTqsxswAtPG7WZG7oTfVNDy8iSSKf0Q9GrvICaY5rpTKrNJ
	nX/xlvehG8z8xkX6oRUakNt+xjr3QMiYK6+lDlr1BTA27uig5vt2EJcVbzQOok0dIxz7uKtcTtw
	sHr4z90zeUpu6wheaZIo7ttgT1Cp7LAIxw/zqg86Ie+Dc+SD78gA2mCDL1YoMVFwiM4J+6yBmC7
	10wG4pkrLyAy9BUKtpS0kTDYZ2FkxH+YL4tBdyzJ1GQUb1m8ZWTnpHN9BYUnx9GE7OioGAaQghz
	CS+fsVAVjwkW+wVauOMPHQvQL/+alv5OyMHq4fVT+moWuPBPeUhSE4WsufA8Wi8ROC2xfUweZrx
	GXc0eWpbKgyvZiynR0y/U6t/ctz0efOgL8Bz0izPo3ujZ1Lt4wkPxHD5fi3YtA/sBuY+N21GoUv
	pB4CChrui4D/ONm7JVqx5QfYOU4U23/mmLu516/BwUheG+/YcEVcC0VV1moEuVWVzdQwAmZpRNZ
	kd76iH9DWPGoNJNrA==
X-Received: by 2002:a17:90b:3c46:b0:359:85b0:4023 with SMTP id 98e67ed59e1d1-35bd282e00dmr5496794a91.16.1774156726184;
        Sat, 21 Mar 2026 22:18:46 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:37b6:3d88:f486:a8ee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bf2sm5681646a91.11.2026.03.21.22.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 22:18:45 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] blktrace: reject buf_size smaller than blk_io_trace
Date: Sun, 22 Mar 2026 10:48:38 +0530
Message-ID: <20260322051838.1137822-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_trace_setup() accepts any non-zero buf_size.
If buf_size < sizeof(struct blk_io_trace), relay_reserve()
always returns NULL and all trace events are silently dropped.

Reject such values early with -EINVAL.

Reported-by: syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ed8bc247f231c1a48e21
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..6cc7d83ed1c2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (ret)
 		return -EFAULT;
 
-	if (!buts.buf_size || !buts.buf_nr)
+	if (buts.buf_size < sizeof(struct blk_io_trace) || !buts.buf_nr)
 		return -EINVAL;
 
 	buts2 = (struct blk_user_trace_setup2) {
-- 
2.43.0

