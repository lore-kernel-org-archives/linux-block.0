Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144928691
	for <linux-block@vger.kernel.org>; Sun,  8 Dec 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733646244; cv=none; b=gY/2JJ8WyuMr5emlqMhrtZb2hJHfsNoUNzptfuHEflRcjtxGIzDjIX9EGql8UeLFji1kXba9trvw80HcNdUP7YKeCu6e9g8OXE7qgJYQr0YEPKyKPdzSnie84ANhYd3L4Pp4btjZHxu9053FFheqqkYfqcMKyI6AAodGXsAu2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733646244; c=relaxed/simple;
	bh=8aRWBK5WQcRw4K3HV07EVQqZG/7KdW/c8EDNNrWbrvE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VI4DIwaXHUNJ6E+bkyAM/z01iWTAzGNZRdFOZoyeCyjojokT5YwiIsiHTqmEo4MhcE8gCfVc8vDM/QfzjwY/Y2F+mgBkhhwAIWY9UXG22DWkqV8YXC+L/E5IiXF89jGxSphUw/qFAXBBIfCHgisA9ESNE6etTIPeZnOYnnD5xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2ADGu3v; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2ADGu3v"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd17f2312bso2620532a12.0
        for <linux-block@vger.kernel.org>; Sun, 08 Dec 2024 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733646242; x=1734251042; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB78cRtZZT5hejzGHdpaP2CLbI6RH1R69rGquJpRCBY=;
        b=H2ADGu3vFuJQmylwabY1szCtnN+Xw3uTb21sTGsp1QbFUYrPZRZXptrFW/hkVy7EF2
         DuF6GeUk9JtpMpLXHM6LLPl/1WwUh7PItyKGlpxgsuL5r7QZsKEjcVou1rSelUbJpc6p
         8iyosbhPaB1WJDpRTHUUWAdi859VUUQGppcpBpmDFBchGRejvBf+TpL+FnbOM3Qo2tAW
         lC7Sd6N6s76Gv1R6gV2nGT8q89wpRTmoUgvuG7LPMIeLu/J9Vp5XpHEz9JrfdrO9ZfyD
         4adIZ6puF5M3lBJyUDZyD8C/cdcGM/ym0twEKL4X5djUvKH+bTmuamUvyW9RHpGy5P8a
         X7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733646242; x=1734251042;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB78cRtZZT5hejzGHdpaP2CLbI6RH1R69rGquJpRCBY=;
        b=vIR0t83Ppb/JNMZITQxX06WVozmsaZkiS0cHJIfgf1nbPUJlL0BIyLPsvVlnHaBBGA
         cDTQf03FS09nimsjgGyttuPSB6P/nRskCopqWfgc110+EKsvdSxCEvEG3Hl/hGQg5gA6
         bRgrKExuZhn0NVgwOUHUF5kTmX2BBvVGwGeHM3IcD9ieqLleoLtgwj3H61JZXTQ1UTcY
         ZiNfaHAuYzp8NNHRmXCMtpb61uXp2as+NV4on2HXgyry/ixMsZSLJOiS2Pv8r2/Zvym+
         ZGLgJNYzsPf1LvWXZto9CMgpPwx28epMBhZBXBQnBnrF31pL6gy2nvMSSWO7eW5ZnMzg
         MSrg==
X-Gm-Message-State: AOJu0Yw5GHe6W0MIybAWuNzyDT8hoY0L76bFNH8YnvnykAXJIbwqaCYc
	80g0o7y6KrWe7f4vAuN7YHT/eG0YsGsDVCaKd2uq3F+03qsEQHg8
X-Gm-Gg: ASbGncukh46uSd3vfcgIZZ7N/vwUnKaz2kd9W3yzObYtO0Xtp558P0W9IQb6z7pUC5B
	hOUoZHdCMfOFKJwAH20Lh0LoPhRw+Up7XLmrJ5lE9mcZe9PIpvoVvsJbOpJ0w4r2X+cEGlG2/Xw
	anOtczmeypR7+PeOuA8N0daxYwH/R67PDZb8YeNkYF+Q5Xf2EVk0YiFsDAMAGveqOc2tCceAG84
	nv9Upl9rZFVMrtzfHO7X5zY5Gg8UB6m/oteN0dYFNq8zwASGd6w/7IE1CA=
X-Google-Smtp-Source: AGHT+IEAXPAgC4NPGcfH5XqftFqhI7wMKBZejYs9mqkMzdJxO3JO7SCA87L3PVcuQNp/mwImqrMItA==
X-Received: by 2002:a17:90a:d88e:b0:2ee:b66d:6576 with SMTP id 98e67ed59e1d1-2ef6ab10612mr14111279a91.30.1733646241854;
        Sun, 08 Dec 2024 00:24:01 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f95bf1sm5905827a91.21.2024.12.08.00.23.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2024 00:24:01 -0800 (PST)
From: MengEn Sun <mengensun88@gmail.com>
X-Google-Original-From: MengEn Sun <mengensun@tencent.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH] block: Fix the comment error in the __register_blkdev function.
Date: Sun,  8 Dec 2024 16:23:57 +0800
Message-Id: <1733646237-31928-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The comment for the __register_blkdev function states that if
the major parameter of this function is 0, it will return the
major value upon successful execution, and the range of major
is [1..BLKDEV_MAJOR_MAX-1].

However, It seems that in this case, the actual returned
major is in the range of [1..BLKDEV_MAJOR_HASH_SIZE-1].

Therefore, we will modify the comment to ensure that it is
consistent with the actual range of the major value returned
by the function.

Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9130e16..188163f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -204,7 +204,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  *    then the function returns zero on success, or a negative error code
  *  - if any unused major number was requested with @major = 0 parameter
  *    then the return value is the allocated major number in range
- *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise
+ *    [1..BLKDEV_MAJOR_HASH_SIZE-1] or a negative error code otherwise
  *
  * See Documentation/admin-guide/devices.txt for the list of allocated
  * major numbers.
-- 
1.8.3.1

