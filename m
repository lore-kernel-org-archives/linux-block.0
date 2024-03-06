Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CC13540D
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733863; cv=none; b=Vo7BCVZueu/ymZTfz9QYK3jznMTJd0lj84NVBDIHlXfDDnny8KqX/rTdNTfs5sSwlOlWvl/kDDTsF78uToe05zvPtPCZjEbr8Nqd+P/EpmnoKgXiCm7ek1wbj605BKI4b3DqN95IJReQtkbiuwhJ5uJfaWFNzEWg3n2EaK5xpY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733863; c=relaxed/simple;
	bh=38dwFCT9cRKzgpj+9628NvIj+otReVaQKLf51gHfDEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSb691S8SXO1BfbgIHmMguocC2tu70HLhxNsGnMAR0y1JMqvNIiXinio2s7r2qWE3SF1+pMq17rvXLHIgFZg/x20+AMmMMlCEWweluFVKm2QfGECR5KFaHhBkrYMdfpm2NZjHNAYDLFtgTdQVa8/XvJGEapEw2BmEZRxoDMn3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=FTG9vu+U; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="FTG9vu+U"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so9033810a12.3
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733860; x=1710338660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OwPUuyVmsoh2r1aHxw3RV8Tg2NmftwwODINyucCfwc=;
        b=FTG9vu+UH9bq6VbUH7/s1zmndslp7a+LagTvQ0JrhnYBATwtG2saxj+WMKk5fsKCaq
         G+hF4NjQa8Ng4Jm+UbAkaR4VxRhATf50nBMt4d2VfWGJn7cB6zeVKPK+ADQ09mLZ4nvC
         PXLEYaywzr+qyfzB8GJiNcOK23h8C4a1U5WZmLoNaazRe5SowA2cKeGLSzlRfGKgJMKL
         1bPWd4by0lWAp4CC5qXIqLGpd5p6BlaCZvVTYIreTMxqteaMvKFQoXqD8rZfvuGia2Ba
         7lFXvyIc37RwyfHXDC/vVT4pBux0XFcfp+2nigjmy+N4B5cXnwDtSLDnHOLw1IkwAXHG
         L/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733860; x=1710338660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OwPUuyVmsoh2r1aHxw3RV8Tg2NmftwwODINyucCfwc=;
        b=amkDCkPSOsqnguTjXeNhM9R5COqqFisRYEnf9Ge/p4cqg2x4oTXiPjrgOtlW46YnFr
         pz08kW6wbEEmTrMn2XXOLasjFwZI8+I5t0lMjy1sNUKyBnTWz7LWyU6I+xzVuEuMakIc
         og5ZE3aFtlRG56y2M6KmOvjtYQXMHMjMf94CQHjgx66UE1t+ooWsqq+SD+OwYAb14rRA
         XSi7ATCes5967ajKymhn8kcP0qUY3tdxSi3FvoN5rDozdznUXy85AUzcq1ZDuKbGotuF
         hUY6xy7z22OndYMlhO/TFciOETufqtkjEC+Gvw/HKflgBNVAh2WfPro2wOViCEN1I5/I
         yrKg==
X-Forwarded-Encrypted: i=1; AJvYcCXaRpE/HqousYBpgy3G7zZf29TdZyMsvBZjVBJ6FfAyVCE8UBpwjeeKfJupBtE8Jn4/O1Kf4GLzoU3jk8gjFfhA5Lf71DlUlgfZawY=
X-Gm-Message-State: AOJu0Yw0/y4swmFQkAlDB7nV2CfZG8FCPUwQfl7ApP3GWje4oCZl+J4s
	QzFUaUFi1sIrw6TWjAqHgPWGwy0ZApKA0ISKbrL61HC7Pm+fAsh+G6QfU+UD794=
X-Google-Smtp-Source: AGHT+IFo4frb0xUw34CkfDxdsamgCJ6nAx1QPSDWFHeTB3OUKfwmFvtU0AtdfTpm6nZ5gaSR90ZDvw==
X-Received: by 2002:a50:c90d:0:b0:563:c54e:ee with SMTP id o13-20020a50c90d000000b00563c54e00eemr10850628edh.2.1709733859877;
        Wed, 06 Mar 2024 06:04:19 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:19 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 5/7] drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
Date: Wed,  6 Mar 2024 15:03:30 +0100
Message-Id: <20240306140332.623759-6-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

fixup_write_zeroes always overrides the max_write_zeroes_sectors value
a little further down the callchain, so don't bother to setup a limit
in decide_on_discard_support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0f40fdee0899..a79b7fe5335d 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1260,7 +1260,6 @@ static void decide_on_discard_support(struct drbd_device *device,
 	blk_queue_discard_granularity(q, 512);
 	max_discard_sectors = drbd_max_discard_sectors(connection);
 	blk_queue_max_discard_sectors(q, max_discard_sectors);
-	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 	return;
 
 not_supported:
-- 
2.40.1

