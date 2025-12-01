Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39C301018
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582497; cv=none; b=M5KrEt/28DtQkZAVBX0cvMBaEjpgJRtEhb/vWJRcpC5PRDY9Ajx3wr7q9Tp9jbm8OPSZfqZmFQJu3Rp9G8k5pEBBM1ThWRvYXxMS4JP5sSbwvHKHKiekAvuvgjcWfwS5OEP0xUagcQ9midJNjWvHjk1bdRFNfGHMIuIzLjIv2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582497; c=relaxed/simple;
	bh=fhPPnuNbDyoEke+x2rMjuYapNn/Kl3pDEdUNL8/gOpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWBR9S/yrNPkDQlQoB585qv0B90mkHiCn0ylqKpBy4keFUfgnu/emmQcAJcpro74QQuq+Zd/O4UhgH7DdqpRbX5L2vNbgR/18D5VJnWTLHyvMvgdVYLuvGKuYyQRFN3m/eosPrF0eRaVcl6rni5/1JUMzNC75rs1OExt2ihket0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HYMayj4n; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HYMayj4n"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so4853910b3a.2
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764582494; x=1765187294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft2UmGA5efiA6Tnkdeu/pt2sAJb70nd3fcBnsirWxOw=;
        b=HYMayj4nVLxROdgZHB0EsVR2TRUEb1RrBAjeyZr1O5IZCCbCbV031hbKg1yBJdjXWx
         GSyK7SyqiQZlns3aJMqwLb5onsI+AAR7LLSC2I1sc1srVOxp/UCxrU0C524sULBvKeM/
         398SvwRlprK0KQsJq+DmDS7gq3K1O4NN/FpL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582494; x=1765187294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft2UmGA5efiA6Tnkdeu/pt2sAJb70nd3fcBnsirWxOw=;
        b=GKjHw0EXROQPLkJ2WyNjkA/kUmfI+ic9Ds5ecNWqoOzMqJP1Z/GMliPcQR3AjFouAR
         9NhFwZguVq9/furHzdU7uBY066OQrv2CgQlNdRaF4606oknq39ZuWQ3zwyh2vnd5zBk5
         hOsB3BxsZSV80KPWk4kFui6yds8kvBj0pUPp6GS0+LGUTVb6LUKCCSC1nKKl2rxENcoQ
         PrI2RDCCRkynQvzzzP+C2i+i+T1jVslmJ4RKlb26J3Jxb+HJf6tnDun/F+s99yQ0Eoof
         bi3xdLfCKCX2USVSo51EERr08zSG8OWQDQn52OkNahZdBaieTDXOlefaQRHfZw9k0gdH
         /hGw==
X-Forwarded-Encrypted: i=1; AJvYcCVsqFgME8A8wD4FJ9guibFH4bUPpWOHbBPMP4lpCOW2bWse61cfXMNO3OYQ4twwJWYSdAHFOvoKBHtC/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdwdGIGj2OwPHWmmaN2UnpXQIOb/NZXYEFu6qrlJoqsPDzbvJ
	nBOv73uGS6YrxRNocFTNXucMrjptDkqI+YDXXUVQQO/zGJaeZqYyeiv/O1suAQzS7g==
X-Gm-Gg: ASbGncsiZxQl5C/YeARB15HAbZEAg3EuliavT+cx02XmfUlAR6wxZHyy/Qzl8on3xjs
	cWwlVcN3IqvsOzJEhUozCneG9M2qw5L3ou20xcZOYJybmihJbSunfqykXrPk3YlbSs6rrdh/JqE
	L/M5C3QeWzORStC2v3qSKQK1qx6uN162fEdSfR2KsoCeEndafmVVe5OmiiLFhrE24R19aaxAWPu
	z1NDmWqnu7sl1V4HRc3hnIAmjuUxHDXY2qokc/XCHNneUjlZfERcZ0YCzUehhlDUSJTMx4Jpd2X
	tasXVjswRW+wBivolqIUlZqlrygQqd27Tlt/MpI+a/EqPuSTUNuq9IMEPKiKy8MfwnZObhDZkJM
	QolPRZvSLgAA1vqwvz6qobb85Nl8oQ7J7N2eAdLYoWdffyAqnHlaf6qazvF3ed1PfX8bMqaFKbj
	o4dYdiqbvvvkcIRp6fyDc/0yLoZYNj/mK7ZldVx/IPvuIIFuF2ig0rLSs8zS5gxJEKC2psnq56y
	A==
X-Google-Smtp-Source: AGHT+IFr8VXpbsnicegVCTPVhcS5UEK7jUpu+3p79wdFmEMCIo/SsUZlSBzDwoKUtRp+pBy2lth03Q==
X-Received: by 2002:a05:6a20:7288:b0:361:3bec:fe28 with SMTP id adf61e73a8af0-3614ed96c9amr43808576637.37.1764582494151;
        Mon, 01 Dec 2025 01:48:14 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db577sm12882074b3a.31.2025.12.01.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:48:13 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/7] zram: document writeback_batch_size
Date: Mon,  1 Dec 2025 18:47:50 +0900
Message-ID: <20251201094754.4149975-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
In-Reply-To: <20251201094754.4149975-1-senozhatsky@chromium.org>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing writeback_batch_size documentation.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/ABI/testing/sysfs-block-zram  |  7 +++++++
 Documentation/admin-guide/blockdev/zram.rst | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index ed10c2e4b5c2..e538d4850d61 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -157,3 +157,10 @@ Contact:	Richard Chang <richardycc@google.com>
 Description:
 		The writeback_compressed device atrribute toggles compressed
 		writeback feature.
+
+What:		/sys/block/zram<id>/writeback_batch_size
+Date:		November 2025
+Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
+Description:
+		The writeback_batch_size device atrribute sets the maximum
+		number of in-flight writeback operations.
diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 9547e4e95979..94bb7f2245ee 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -214,6 +214,8 @@ mem_limit         	WO	specifies the maximum amount of memory ZRAM can
 writeback_limit   	WO	specifies the maximum amount of write IO zram
 				can write out to backing device as 4KB unit
 writeback_limit_enable  RW	show and set writeback_limit feature
+writeback_batch_size	RW	show and set maximum number of in-flight
+				writeback operations
 writeback_compressed	RW	show and set compressed writeback feature
 comp_algorithm    	RW	show and change the compression algorithm
 algorithm_params	WO	setup compression algorithm parameters
@@ -223,7 +225,6 @@ backing_dev	  	RW	set up backend storage for zram to write out
 idle		  	WO	mark allocated slot as idle
 ======================  ======  ===============================================
 
-
 User space is advised to use the following files to read the device statistics.
 
 File /sys/block/zram<id>/stat
@@ -447,6 +448,14 @@ this feature, execute::
 Note that this feature should be configured before the `zramX` device is
 initialized.
 
+Depending on backing device storage type, writeback operation may benefit
+from a higher number of in-flight write requests (batched writes).  The
+number of maximum in-flight writeback operations can be configured via
+`writeback_batch_size` attribute.  To change the default value (which is 32),
+execute::
+
+	$ echo 64 > /sys/block/zramX/writeback_batch_size
+
 If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
-- 
2.52.0.487.g5c8c507ade-goog

