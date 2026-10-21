Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550579;
	b=ysMlcQEtF3eeLjjnvpkI00ULHOSE6InhtX7hX4PRJDti+2i6a14mYjI/LnH9KkVZga7G
	 ToNhyASFcc/oqSFL7gz1nMQ6Gkwp3VMxd0wYR/lgP/HSd/jShvdn5Fo3bZkhoV1oP00Ri
	 LJYkY48l4S+HoJMcjRmiqtwn0xBP0xWShDlMEQtn6P94N4Ua1xocVtjm8ribcGk4eJLyQ
	 BKK1+RUFH7ji+nSZz5Gir3qKsstsU801fYeyjAXh2eBVDZawLWGNGFacWQl3WL0z8+ZGK
	 DlJtQV/wth0tOfV+Ae95229d/Q/o2x0rJ3iOR1wnAZQVE0y20YUFmXFdRP1Ans5AMhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YqvLnWab+0OyPrxtGw/AiXaMLQ8o5EGXMAvfXVZT4qc=;
	b=rtHygRAv56MU6FEo5HJTr3XN+/Ao5sprMgQ9uSYtg0/upoMJci4WoPJU2UvH1O2ZoMDM
	 A5LzgMVXi7GdfIsweDjIw+1wZVT0DZcqGP4kyzHLgVh8csDRCKo9gYaYQpDez23+wldJ0
	 xLJWHpxrOWqaeCDHi3VtyGXmNQfIQ7w2PwNlWmuqG2dp5ndnt5UELQlCcPlUh6zTBvtKy
	 JV7sc7C2ZokX6PeQYxM3wSxrOodFCxfYSmPKEQxXi03yTxxH/g4NcFr5E5VcFO0k+y4MO
	 JzBfNK6TDrkNbJcpkODdSM3D6GiwTFULI+bqKlPbwKKhuANSdiZuYRWGAXJqZ37dO0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TPEcTOxX;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEF60A2614
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EDEF60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TPEcTOxX
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso447558eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550573; x=1793155373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqvLnWab+0OyPrxtGw/AiXaMLQ8o5EGXMAvfXVZT4qc=;
        b=TPEcTOxXGZW+J9ofG87erLiyV8sL78UfwtfvrW8hljTU3LREahTZOOd/lhq4o4TUBi
         KBiKcvudUa47sPXUQjxVeSX7VgnzvJlO4rGykjDI9mIWoJH/rYHxMeyEmG9eYC7rFb3y
         7r91vIQBCmKHzG3DUoLS1mPobi225fG6pVtAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550573; x=1793155373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqvLnWab+0OyPrxtGw/AiXaMLQ8o5EGXMAvfXVZT4qc=;
        b=nmDUmBiAMLGG9Z5Irkab1BL0/b7YgcFCuoo9buqqfHES6DFYz2WO4rL30ABw8VJTtq
         peDLh4jPfkrxl2wsO3SQRlEOsaL3kvIQ4KYWaZg25Evon+z2o+TuvA/tJsgkySm3G95c
         Uqm7WdwiFA2FrE7W8AsMo2zOgw8veiKIKzMZ3PWL/q8N47N/IzVnkI0kxnJOeWh2wYRU
         uHnw9x7wPCaj/R+lvZncwe4AP+NEWDMoxKz8VEeXC0mhUTV/bueZQP1DdIdILILv09Sp
         rF4lBIExOMQaL2mADlIEkYWFt1K/v09kxavBAI8pbIHR4HIS5wBnlLDqVQwUopvJbd7B
         g03Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYpxsCQGPAJC8YdF7sNBIlmsBC9P3SB7G75p9dS1dyUJ58sVTnDv8dnfBz5O/WWuOnlIQSJ4xaqWgPDQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJaB+2h6kGUYnhji0CC/KcsDQP+8zEQCW9YELZst7fCXCa7GxpE
	z9WEFATagPuXyMoa//4lu9XhsXKnpPwmSFXuDIHQ0ccyXj0g9lA4ttLqFr3Ktea9CA==
X-Gm-Gg: AYBFou2MIZP2M2s8/FNneyOIYi7959ZoK+KROqUKuqY0eHdh8WpvG9F9sQCESyLbGN0
	w9gNRnLYQi1uczK7v5CBuHEUuXieZ3s3490rYoCg9482MV03jmVsvI+7zHkEdiYrVikSj/9nbJy
	TpeG/6B7vGXkdwPih1wsWGXXIkedVeSgJi0z+w66lGXyV+s4Vmp/3fUQUGIIG/f3GyJFg2AP3GW
	gHfwnCkIgto818LvGPCyAAwqbLsNqMn7vi08J9Pe14BdnsvlldfcpLLkkEt3bAoOVcmFleD8A/T
	3Pa61/Or4k+aRI7Zte6NhZVpTrA8Ng0RWb8moXcQXEOnmZjKEhLN0ukGyqL4JAxOc+cbDxlWmRl
	u4nEKFJO9/52/LzVxVbNJJHAJUK0LlIimf6PykmVttl4Qwlf1eZv6rzDGxWKDCaszshQxAxUgqH
	EDaVSTSXSh+ka39bbT/AMu+48+No0tLyWKq+vq98ioTrDYQZb4gUesfxMZ8AqFdfW0VvnUrqdKN
	iuVWCiojFEQWRm95kzm6lDEqwGgYNQA3Qwl/d3/tVH3dhJn/xTxKVGIVlUNYXqatXFMM1EzVrKK
	R1hZFB0TKJ6/MLYIMf468lARbDN36H1ZwXYnWFU+HQCi
X-Received: by 2002:a05:7022:f515:b0:155:7721:3a4c with SMTP id a92af1059eb24-190a660fd4fmr846137c88.35.1792550572267;
        Tue, 20 Oct 2026 19:42:52 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:42:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 03/13] zram: reset writeback state in zram_reset_device()
Date: Wed, 21 Oct 2026 11:42:13 +0900
Message-ID: <20261021024236.1787884-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021024236.1787884-1-senozhatsky@chromium.org>
References: <20261021024236.1787884-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset all writeback state to its initial defaults on device reset.
We used to keep writeback related data in zram->stats, which
zram_reset_device() clears, but commit 1d69a3f8ae77 ("zram: idle
writeback fixes and cleanup") moved it (along with the newly added
wb_limit_enable) to struct zram, after which neither of them was
reset anymore.  wb_batch_size and compressed_wb, which were added
later, are not reset either.

The patch is more about just being pedantic.

Acked-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 593fa4ae47c4..0e1aa0da11aa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -694,6 +694,7 @@ static void reset_bdev(struct zram *zram)
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
+	zram->nr_pages = 0;
 }
 
 static ssize_t backing_dev_show(struct device *dev,
@@ -2881,6 +2882,12 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
+#ifdef CONFIG_ZRAM_WRITEBACK
+	zram->wb_limit_enable = false;
+	zram->bd_wb_limit = 0;
+	zram->wb_batch_size = 32;
+	zram->compressed_wb = false;
+#endif
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.56.0.212.g129ede20d9-goog

