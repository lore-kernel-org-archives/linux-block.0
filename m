Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5B19F11B
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765777662; cv=none; b=Ywbdt4knUM6mHeycq4jCwcpx8r3Qk3CGdKZOTb4EteOQQVp5nZgMBJDmZN1VS2213obkZB8cy/daJEB7ctI7Zj0Omtyd6J2TF/B1wsJry6S/5EDxEiik0ZbyMQIZe8YZJg4j9NzZerskiDTLA5OLJjtVVgPw2i/0vPus1orFIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765777662; c=relaxed/simple;
	bh=0BJnRd+9ZFInGY9TSO27vWLMUX6wTMtsEUd9Lxdp3o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emftELwQOxPyk2CRX8BNkEW5WmQdCwm8uroYmoyV7WKL4UduPSmcNJo0UQUur6U3oiPjiqmp4xkvuDK9aJRgDySpumg2bsu8XzppN7mstUW5EwwAwKPUJcDavNcPDBsiOKJNS66ApTLBWos/C0PG6Ji1GnVK0coQ7xbjOp61zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iKmZ0nwo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iKmZ0nwo"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ba599137cf8so868874a12.0
        for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 21:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765777659; x=1766382459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4bgQIWtnTguUUfAUeAsZ365C0z4iWE0GTuA5IhKscc=;
        b=iKmZ0nwoJe6IQiLwclR0j3ocsg/ETHUi9iED+mxWgk+snWCB7zkW7q/OatwFDZ6Svo
         Afcm2XSfgPTSwTgK1P93BIwVPBZDzuLd3tmA/h4saHYwDs1yvsIpwTNuD0QK/4ePiX/6
         Bb3wrtSszyMOvoQTzLb/AfR1NsLjpJ8de/txw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765777659; x=1766382459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4bgQIWtnTguUUfAUeAsZ365C0z4iWE0GTuA5IhKscc=;
        b=u7YxBvGQjH9QmnvPm2DdozE66HwYihELsoM8IniHY2LAEUaH5YQQnsW+a/w/OMwbOi
         URbcY1VxITG3gDLmOZGqgAqCRjWqeZxZQ8cOXVtqEhMqUl1GPWv6ASUfLFO4B0bJ1N49
         SHbY6xoI4LpNUgaozOmbhiv61ciFcvpArAZthwPi6arSkcMzhHEJkkHFesZL6Y/d8ayg
         I+Wx/U2Ia8boGef9i1x0bR8yVa+eEdtZhBt0ldmi5Jcm0zrVqOLMZU9wWEP+tKquGd1v
         hdRu6nGwFWRjucOIUX5D6da20PUwoLeQH81oDzS4bhats+WvuwKSfgymj8+4Kuy4wnDK
         Annw==
X-Forwarded-Encrypted: i=1; AJvYcCXWSwqX02b9tP91FfzsOqPT7Q+LvYGj2XM5Zir9pTAZZZmWe58tsVjbw/ZXieohegnKSikpsfk/ZPZgiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSj1rnGrrEMV+h6LJ/gRCRog3M+WdMGA5au+KUaaukb8lupM5W
	qGn1+nEcS4qJJKe0b6x2pqHYT1sy8C6/JIZI0LERYntnrBFM2SFzi536mOBiXpdlE13NXJE0fwf
	LONw=
X-Gm-Gg: AY/fxX7eMZPKKtGVZTd3xsN92RQwhcx9jKiET9LKswInD9Q7XBmlEePye87yWatKhwx
	pERZE3qseRBBV93s3+xfUEn/87NjX/m21fDkUuX4DHFXB08TMz9DHo8XJHx0qrqCHKJTEkYkg49
	JdfZz6Kyihjz6ezsjRczhHlvODw1Pm+Ziz3jb8nbCXz+K/nHLwPghmREr78wNjRMIydNROAoypb
	sT6Fyh55Qj6Bo49vnQJMGQVTKCK6SbmcwUAaOuATN5l6VdjFc9nmcgo5kdhPMXLVMPoZOfsCpIm
	uxg6jO6w/YbQ7oHSyCrr/Pi5DCLvQslb0b1HpPMTIAGcMM3dC+8wS1B+DNF3cA9Tg3XgNTqQmTf
	pRAs7Kp6sz4YrJUVS8ruLqw1uyIyTEbf8ppO7noq1CsUZekRtqYUodKgbmjYYC9azm540W0f9GD
	ovC5RTTogKP46IJjcZXCTauPnVcmsl9QnZF2EVy7DnD6XnB0cQEusVZpZ3fRXQT/xjlR84gHVAX
	A==
X-Google-Smtp-Source: AGHT+IH1pv7Qw3Bz8dzGDa2+eo2pIwyjJURHPjoe4mHOqDp2Z8Kt8ofVXUXNMGs7j6q5q25WElVfKA==
X-Received: by 2002:a17:903:38c5:b0:299:daf0:e044 with SMTP id d9443c01a7336-29f24e6f768mr110715045ad.18.1765777659360;
        Sun, 14 Dec 2025 21:47:39 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:88fa:c762:fe19:6db7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0bb39db53sm36391945ad.11.2025.12.14.21.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 21:47:39 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 3/3] zram: trivial fix of recompress_slot() coding styles
Date: Mon, 15 Dec 2025 14:47:13 +0900
Message-ID: <ff3254847dbdc6fbd2e3fed53c572a261d60b7b6.1765775954.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
In-Reply-To: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
References: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A minor fixup of 80-cols breakage in recompress_slot()
comment and zs_malloc() call.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f00f3d22d5e3..634848f45e9b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2517,14 +2517,15 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	 * avoid direct reclaim.  Allocation error is not fatal since
 	 * we still have the old object in the mem_pool.
 	 *
-	 * XXX: technically, the node we really want here is the node that holds
-	 * the original compressed data. But that would require us to modify
-	 * zsmalloc API to return this information. For now, we will make do with
-	 * the node of the page allocated for recompression.
+	 * XXX: technically, the node we really want here is the node that
+	 * holds the original compressed data. But that would require us to
+	 * modify zsmalloc API to return this information. For now, we will
+	 * make do with the node of the page allocated for recompression.
 	 */
 	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
 			       GFP_NOIO | __GFP_NOWARN |
-			       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+			       __GFP_HIGHMEM | __GFP_MOVABLE,
+			       page_to_nid(page));
 	if (IS_ERR_VALUE(handle_new)) {
 		zcomp_stream_put(zstrm);
 		return PTR_ERR((void *)handle_new);
-- 
2.52.0.239.gd5f0c6e74e-goog

