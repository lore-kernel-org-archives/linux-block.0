Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9253002AA
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582495; cv=none; b=dnvKEJstai4rvHHudDzlURrK5R2Qs1NeHYjKfEQQgpQnPtiAOAVddSB3UOmElbgvn+os3OOC/udQp1utfUqV4S07cPCAOHRvGmvSuB0fPA1/DhfilOoAGDP7OTp/6nQf7tZD90oWGnF1TH5JWURCCt4fIx3g+IMiYYkGhj2ZKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582495; c=relaxed/simple;
	bh=pBIHL/+s3slAbUIkwhX3xs51RwCrZ2BcTqbC6s/6oF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dj/nlRDcOhAuRAw9+pqdrKtWD2gkqH/7aZbe+hd3n7iMV1vePvRNX/evdYgzvhu9iaqIXcIMIoY5HZ3WchArWaKFquTq/O3ZHnGE0pG/SKvwa/2zkJ/LBJ9d49gmsimw3A9CJBcUXY+3NTwrrsBGNzvfzcNOcFYBr9RN5VH88WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eACAm8yR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eACAm8yR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so4073081b3a.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764582492; x=1765187292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqN6IsMp+xic4hsBD/TTSEY4e1QCsNoi7vBlxa2loK0=;
        b=eACAm8yRoPgEPZdvlasJxEfm1e1d0KxdJp4ceqjPQqEjBSMp3ZFyusLC7X9yFpwNBR
         OKvDo/N3y7LafNSKUVSmyGrhwepDtBE98Q4gR9JUv8xrE/hsrJecQxex8aBsaiCUlI7c
         0OmIJ6rBAXQ3XW9GagYo5U70bR36dhtRPJB9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582492; x=1765187292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqN6IsMp+xic4hsBD/TTSEY4e1QCsNoi7vBlxa2loK0=;
        b=h/YbBxyf4anbZxnmdCqtC2ELIVftb+BsBJY7VdLTttLyNFHNZo33FKXe3Pbf+VQ/1z
         1UxG64wON497QEylsDClRvVJGkiRTFBtffvpB/tRmcnywIy3mPyzdfQYBnODY5Po/xsU
         J00l+AGacxHBnXRd0pdGNp6UbvR4DN//yFX9Q2Ctn2PtFmTtJE+AjnycLnM3lYbcZk6e
         rjiXtiEIupA5ZdG0nB51dhm8OG1sgV0jJyXZEVLwDoelw4TME/85sDOqQsSlwxeu5VjA
         NcoAhfsRkmVEwLCI1LJPs7KvOvtfz453BGuQguu9ZAB/wzDkzY1GPMYUmSSqwfONnHUo
         z3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7YmsH9EJDpxj8s0gApQDGoS0nwlRZtI3Wdeu++48/b93gtcPqR7R9w31hUqXLM+/fk4iqADt34oLedg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFhIZtlbWD9qXhohapAoxPj+MVLFZ5cUvzOrwopcBlaQGN2DX
	B3X40/vQwZO74gFYzxYwMcz2TCgE4Rwdwxb27CWe8doAPvXEr6FXSwPxyLpQ3dOucXZI8SLrkn6
	xkPw=
X-Gm-Gg: ASbGncvE5ULSzbE59AiEBcbnSGD/iXVknXuRD3/CyFqR8P+3bko0Voh7gnVN8OlowgQ
	Q6S5xVFsCqHACjtaGtDiTe8ZsgyiOLJiQmd9CwsPscM8taozYqHvJQtR54AOHNmZlnY0mf2iFJV
	NHDzON1rWyuCSQg3fMAgE7TxBeinBl44p8b4IBz/niA+AYk52FsoNRbqj0PI+AunEckD+uuvh1c
	TxNwrLgY9LxKCYgq6GQGr+zcfdGCARSi7YofOJ1L+DCYnXwckEdT7YEEb8UZlKlCyxrnLCHtYOG
	mDbEvGS7WKSnLgZ9Zri1iA03em2stmJwKelr5IqohiqDIp3pLCN3OXlq14PmS3VZOfx2DwnlN9e
	1tEWXZ7unHryiOPJd0GZWrC3QCCsTKMStM8pijsBx1IP9xFuI6TJKgCGlln5SdN125y9SUIcZxq
	NJ/zUb52XEMwDbNIJT4QfJqfo/Ol012tVHLvqM/gUbtP35vZahWewUBR+q7qPpFxIQ9cXaVPDt4
	g==
X-Google-Smtp-Source: AGHT+IFPOKXBPxIWlb2N5bOWQcJ4Qpt2yM3sF83+3IIpZZQ0LRK1r32xVMYgoCct611DyaOc2sndNw==
X-Received: by 2002:a05:6a20:9184:b0:340:d065:c8b3 with SMTP id adf61e73a8af0-3614ed971edmr40400894637.36.1764582491688;
        Mon, 01 Dec 2025 01:48:11 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db577sm12882074b3a.31.2025.12.01.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:48:11 -0800 (PST)
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
Subject: [PATCHv2 2/7] zram: introduce writeback_compressed device attribute
Date: Mon,  1 Dec 2025 18:47:49 +0900
Message-ID: <20251201094754.4149975-3-senozhatsky@chromium.org>
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

From: Richard Chang <richardycc@google.com>

Introduce witeback_compressed device attribute to toggle
compressed writeback (decompression on demand) feature.

[senozhatsky: rewrote original patch, added documentation]
Signed-off-by: Richard Chang <richardycc@google.com>
Co-developed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/ABI/testing/sysfs-block-zram  |  7 ++++
 Documentation/admin-guide/blockdev/zram.rst | 13 +++++++
 drivers/block/zram/zram_drv.c               | 38 +++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 36c57de0a10a..ed10c2e4b5c2 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -150,3 +150,10 @@ Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
 Description:
 		The algorithm_params file is write-only and is used to setup
 		compression algorithm parameters.
+
+What:		/sys/block/zram<id>/writeback_compressed
+Date:		Decemeber 2025
+Contact:	Richard Chang <richardycc@google.com>
+Description:
+		The writeback_compressed device atrribute toggles compressed
+		writeback feature.
diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e273c1bb749..9547e4e95979 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -214,6 +214,7 @@ mem_limit         	WO	specifies the maximum amount of memory ZRAM can
 writeback_limit   	WO	specifies the maximum amount of write IO zram
 				can write out to backing device as 4KB unit
 writeback_limit_enable  RW	show and set writeback_limit feature
+writeback_compressed	RW	show and set compressed writeback feature
 comp_algorithm    	RW	show and change the compression algorithm
 algorithm_params	WO	setup compression algorithm parameters
 compact           	WO	trigger memory compaction
@@ -434,6 +435,18 @@ system reboot, echo 1 > /sys/block/zramX/reset) so keeping how many of
 writeback happened until you reset the zram to allocate extra writeback
 budget in next setting is user's job.
 
+By default zram stores written back pages in decompressed (raw) form, which
+means that writeback operation involves decompression of the page before
+writing it to the backing device.  This behavior can be changed by enabling
+`writeback_compressed` feature, which causes zram to write compressed pages
+to the backing device, thus avoiding decompression overhead.  To enable
+this feature, execute::
+
+	$ echo yes > /sys/block/zramX/writeback_compressed
+
+Note that this feature should be configured before the `zramX` device is
+initialized.
+
 If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6263d300312e..3cc03c3f7389 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -539,6 +539,42 @@ struct zram_rb_req {
 	u32 index;
 };
 
+static ssize_t writeback_compressed_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	bool val;
+
+	if (kstrtobool(buf, &val))
+		return -EINVAL;
+
+	down_write(&zram->init_lock);
+	if (init_done(zram)) {
+		up_write(&zram->init_lock);
+		return -EBUSY;
+	}
+
+	zram->wb_compressed = val;
+	up_write(&zram->init_lock);
+
+	return len;
+}
+
+static ssize_t writeback_compressed_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	bool val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = zram->wb_compressed;
+	up_read(&zram->init_lock);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
 static ssize_t writeback_limit_enable_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
@@ -3048,6 +3084,7 @@ static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 static DEVICE_ATTR_RW(writeback_batch_size);
+static DEVICE_ATTR_RW(writeback_compressed);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -3070,6 +3107,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
 	&dev_attr_writeback_batch_size.attr,
+	&dev_attr_writeback_compressed.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
-- 
2.52.0.487.g5c8c507ade-goog

