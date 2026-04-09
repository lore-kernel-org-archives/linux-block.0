Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A22C15AB
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741447; cv=none; b=YjSp5hCc2AcGUOuKsPGosL+kP0xTITJt5pEykoIpiNpTvTIbu8BQFs6knAFwwV01mi4GEOtCNtm65vSpPMIy7b0XXh1Gnhe1cXSNc0nqoyYN96pVlrh6zh2LspFXZ4+owu+nNrp+TlX1l7TPwIpU2iWr58G35YYli8B2BgzzC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741447; c=relaxed/simple;
	bh=5NfhX0bWGLABVeme14dL7ws1MLwYAOl2U+ix2vG/sag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbsdvbMjSKDOwgZ5I4XJDQwD1lKnE2OS6IkkDUXlwqHvcrN4YY5nLsXkOO0hijPr+gqXdGmacdx5fJwK6LT6M7YCP2WZH7mK8IOXhTy7Ny6pjSqzaOAqdTF9lI00gVpofcHaSRnClgb1ldfXnWEBakrI08BBPVvTiw9UDc8DUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywr/weO+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywr/weO+"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso372562a12.3
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741446; x=1776346246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=585vcATMAsrKP7txUobs3Mjpta5cUx1LeSRd2b+CNEU=;
        b=Ywr/weO+JrU3s/V7UxtLZ2gJPpJDqfHVHZSyfJQCE599AC4qlePo74e7bx7sdpHZZI
         RfRob9ZmTRKA3BXiW1miEt6zRfLbkVEe16WKhfwczhBnV7T9Djejj3kKC6WBPJtlotb4
         uYTuR/dTKIv4wCZGX6V4TXoHwlFOSzE5u+K6nJBD3UIjizyuijCarZ783dv5HSmnV/S9
         0tbElwC2bC07GZ+3f4WQkmSR2aMT3V6ktkyQHa5OPbmFECRcTMh/av0WhblQHn8EZbu4
         tkPIseUqp/zpxbKRnq0QZ5gJtVpG2DcZK1te8BJXl54/1+kbSUsMJ/0GL8DeS3aOv4yc
         Famw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741446; x=1776346246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=585vcATMAsrKP7txUobs3Mjpta5cUx1LeSRd2b+CNEU=;
        b=SPifN9nVkxt0KeNuohbaG0CeKwGNgBapE5rMVsD2XsRPCVfLew5o4NIUFw3Er5pUCy
         QeFxpCWSoIAzUNwQGsYStbV0hAs2MsFjYY7h8dnK0qMkvA7EOJ0Mxv6KWAA/b94wfiD8
         Fvj6KJLH2ilb2EkD25e6hvoK4+QIPZAhcq/Kauo6amwn3taiRCvWvE9vhsFYxb0gtiVs
         40UBOGKW/YaPykfEatF7B93I/NeTQoAJw56sifjsKxckTbnN7R3ZD2L35PyhF7UmqixE
         HaWCeQLuWRe7Nu+jxIFqdg7mHbT7uck8Y3FmAZ+3orx8WTUz9jd1zhFyEoKJJQBg0xHk
         Tkdw==
X-Forwarded-Encrypted: i=1; AJvYcCVx3wwM2Z3PRzj+uJ25U65PklS3Wl0nu79cYTUegvLJUg5VvVTlaqsa9F578xd3nXV9JYmvkd6Rn4tgGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTIRG+xElOG1ayPtHbjDpk0Re6Wi2iT53YVWEs7XYidup7zhF
	7cRrgnL2FgF0NCZe1cA2jW1Xy1vUjv35GpGQFLkn1u2OaVUh6GMXEwa2
X-Gm-Gg: AeBDiesDXria+TNt+br9G8HanQK6+AE5vm25N0nyA3rP+okzlmyGLBcNmQtKMK1njXs
	yxGkHqzPw8GKbOByLah5SSJw4rAclgeCUffLGH8EG41iw6M6jMS3XaZwJWixH3qskYfSwpoQKB+
	6sbuLku/nRvCuo3bIQb644SGr+331ttmadMkmclOOCdB5QHGv3F5wyB688yEXSxeVqlvOHpTZnx
	41bj29aNjxPzeuoyNk+8cov4S5wvLiKOyVW08DEAzIlxlpFUxVEdyLyrL7nXzQhmd8lYEhz1EvP
	JOieS01NGSZNA7Rw4OF3pKMZQLOyqVAv6+D+zHHDGiXX4cxDwypQmoe6KcHEpZ2hZAzo5/BSiXt
	8YjY1PahfuSLw20w+lt+dXPyrQ7rIVUt35gxPhmEThqV29ZTufisI2Ug9Fo633tgIJ8LxAi66Ps
	bHxDASw/dGLKTNsB8vtmOvZSyLXmiy1nSjSQuf5mTCJYw8biwfd6Q=
X-Received: by 2002:a05:6a21:3396:b0:398:aea8:a9c0 with SMTP id adf61e73a8af0-39f2eff034amr27016790637.19.1775741445467;
        Thu, 09 Apr 2026 06:30:45 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:45 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 3/7] ublk: simplify PFN range loop in __ublk_ctrl_reg_buf
Date: Thu,  9 Apr 2026 21:30:15 +0800
Message-ID: <20260409133020.3780098-4-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the for-loop increment instead of a manual `i++` past the last
page, and fix the mtree_insert_range end key accordingly.

Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f990c10e963a..efbb22fe481c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5287,7 +5287,7 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
 	unsigned long i;
 	int ret;
 
-	for (i = 0; i < nr_pages; ) {
+	for (i = 0; i < nr_pages; i++) {
 		unsigned long pfn = page_to_pfn(pages[i]);
 		unsigned long start = i;
 		struct ublk_buf_range *range;
@@ -5296,7 +5296,6 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
 		while (i + 1 < nr_pages &&
 		       page_to_pfn(pages[i + 1]) == pfn + (i - start) + 1)
 			i++;
-		i++;	/* past the last page in this run */
 
 		range = kzalloc(sizeof(*range), GFP_KERNEL);
 		if (!range) {
@@ -5308,7 +5307,7 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
 		range->base_offset = start << PAGE_SHIFT;
 
 		ret = mtree_insert_range(&ub->buf_tree, pfn,
-					 pfn + (i - start) - 1,
+					 pfn + (i - start),
 					 range, GFP_KERNEL);
 		if (ret) {
 			kfree(range);
-- 
2.53.0

