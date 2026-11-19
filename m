Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061660;
	b=0wDSnCZGKFVn/FMGjVa7FQswBsfmWHMHTs5lT9R6P0Kilm67fEv410ujjs0dZfamzXmi
	 ac3h376t1PCkSZoY2H6Q+DFEN4vw58Lq8nkGFWdKidOkcOLAJh5++mkSW0YqplTcsUs5C
	 198mi7dV/KhcJo2Hnw9RAaQK3fY0ZwP0CpxCIAoHI+5TXEi+lauayDTVCGebyWetTFqB1
	 a5vdy73KrQ2vy6QRypMC4NDuuQtChtXw58jYsI634PpLQNkPdb88m08r9bLeg6p6/tdO7
	 I2NHxvk++9qMqslGAneC1oMGU1kWMj/65TBH2+rNZvHrYNxc+hN6Qa3TPs18M50zayQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NiL1NT5qnEnqZDpOhZrlQYA5hzsUwLBbTeQ3CkP6SRs=;
	b=CKLaSYslgEw9GIuPbuLywsEeoEvP0nefL4U7U/8O6KC7KNhdQohaZ/cisTRM4/9sRJs3
	 hLv+EYxsAGbETS/9cEoprZ1PPH0R/aX8SZC7G9Y42Pjpjsao0So3rxEl9ya7E71lh3vkW
	 OQUBaTuLyh2XzaDfS89MUrt/a1ZDfR0RNkkh60yTD9dMOR6JhwDYYlnElFLGDILG0TnHq
	 byIyZ/9IEnVS3dfpzZ1CiNLHVOkOpxCXLNBmYFP/YDdys2JrGlozfEhPjnM8ejco6tYd2
	 ykkJXbTX1F14xHqceHizslEvdi1UPonLKLmDxT/ulThfEnDNteEdDp3i3VVV7zgAW8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WMlpNaJm;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8554606A33E
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 04:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8554606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WMlpNaJm
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so42046a12.2
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 20:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795061659; x=1795666459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiL1NT5qnEnqZDpOhZrlQYA5hzsUwLBbTeQ3CkP6SRs=;
        b=WMlpNaJmFXpRMfqrSnoZUIAmOvP9iaDUxDKMqFRiHsa3qVqEipT2t/ciU6U+7q2EOe
         RT+PK4nousJqCxBSy/i+uPwlLse0iZHa2iC2YNkhFaLkLGisC+yk4FjLH6qnDXo9UedA
         ++yEdJtSZdfNjVOC+AvhyndkHTy/ppFjBY5Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795061659; x=1795666459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiL1NT5qnEnqZDpOhZrlQYA5hzsUwLBbTeQ3CkP6SRs=;
        b=2HMrdl693/DzB75WIJleGlLrzwlz2vlijRSlCKLtId3fxmRpjd85cpJC1SHEJKu4kB
         Ww3NMLvbIdykRSO/TDFklFDsByzVIUiKhXxwlANAxK7Tru1yul8f5+RkF7Nhls/tcuAo
         UoCmq2zJq5U3EAypQL2pKDjB7q5brZtynPdlvqPfLoHINpZVDUIP/cDcRy8SkySjqUKZ
         ib32r/rUU+6bG6d6B3rE6mSoXShhutn7S6K6AEgu2Pj4Wy0nOv3Ttaa45aU5l4cv812W
         h1UHlq1IqZLg6jqF+NUfnGAbTE83UEBROW1VKIdyDoR9BhiS2qUcPvFaSQj5YBhSn+on
         3+cg==
X-Forwarded-Encrypted: i=1; AL+hErGDwB798sF0bGMyjxypnqqcnVTsHEoKdxU+LqBMHFMrZnzSRaR2ClZ4NUc2PkzzYiYHfD31at7Sk9bu2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dEmA+YmUFF+87EwLkDRY22hM6kwlN/T81dNmzh7VFbWuKbZv8
	/8FJJc2OIKMGc6RI1fP2zCNOL0WxG775qPV+SKoLLtbPxAlH2L9rEsyVu3LI2S0lMQ==
X-Gm-Gg: AZFdTZd+HFcfqK0lKe7vdqbCne2eg9qd531+c4B0gf6Qqgb4D4z39nn8wXz/HXbSjOP
	hQknYA6da3AP+BSYomfbbmb4gZxLIDllpMxsA0ehZ8u96bJwrkR6Nd3LTM39Ohu9YmcByalxb/E
	0ejw/0wKz+q88x+encDOa4ER3gpFqnE8KJVdZCaNj7IlQAyTk/Y5+3aXzTk7IbYlwdLdhVKtspX
	Q0jIgHO+tfeuCc5WJCKIKE74o7daRKAogjAtaf+ldS90Yfz4ikQL0l9TlFbnIOvtoANjhvvwEvl
	6+oCCvx8V2qQ5k0PgycOj9u1CGOOOj+cQ+1INFruzq2ulTgKM0G2LxUmbqzl6znIRTcz//ne7de
	WBuVVjLkYkNIWhiSnsJqF4t7fVUpihIJOnj7lzgT4zUf5G/bBpX+A6qr7GBLCk9hGbeUQgJ8LkS
	3XkUloj/eAVLvw0VX7Wu3C0DyHR90Rjm4qGSJYnYM1I+uvPkGyXq/hXB8GkaSVO/HyGcci55Ry9
	7Bab2ZvtLCA4HFRT84BLPO1biV52emSq2Ya2/DEimchACL3W04fQxlVwFX2jixzJrwlZuW3OxcZ
	vYoUgcKeJ5Fadu8zJUcDIk0dDmVV27s28baST8gCjjaO5i5PY3DtNJNUSEIy/ilO78jySRvY7KJ
	XZbuF2A8qP4YPyVKRug==
X-Received: by 2002:a17:90b:5307:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3b3d0761a5cmr4646684a91.26.1795061659189;
        Wed, 18 Nov 2026 20:14:19 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9297:4989:4c44:dad6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40593719esm438795a91.13.2026.11.18.20.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 20:14:18 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] zram: use SPDX license identifier
Date: Thu, 19 Nov 2026 13:13:52 +0900
Message-ID: <80d88d3679dd0b67afe634562e1520aac6686a91.1795061575.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <39f6056e0c8834fc3eca2001fcb44f3b6048f74d.1795061575.git.senozhatsky@chromium.org>
References: <39f6056e0c8834fc3eca2001fcb44f3b6048f74d.1795061575.git.senozhatsky@chromium.org>
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

Replace the license text with the matching SPDX identifier,
(GPL-2.0-only OR BSD-3-Clause).  The copyright notices stay
as they are.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 +-------
 drivers/block/zram/zram_drv.h | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 946b625761f8..90f06523bb8b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 /*
  * Compressed RAM block device
  *
  * Copyright (C) 2008, 2009, 2010  Nitin Gupta
  *               2012, 2013 Minchan Kim
- *
- * This code is released using a dual license strategy: BSD/GPL
- * You can choose the licence that better fits your requirements.
- *
- * Released under the terms of 3-clause BSD License
- * Released under the terms of GNU General Public License Version 2.0
- *
  */
 
 #define pr_fmt(fmt) "zram: " fmt
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index d64c99b74214..724f8ce6709b 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /*
  * Compressed RAM block device
  *
  * Copyright (C) 2008, 2009, 2010  Nitin Gupta
  *               2012, 2013 Minchan Kim
- *
- * This code is released using a dual license strategy: BSD/GPL
- * You can choose the licence that better fits your requirements.
- *
- * Released under the terms of 3-clause BSD License
- * Released under the terms of GNU General Public License Version 2.0
- *
  */
 
 #ifndef _ZRAM_DRV_H_
-- 
2.56.1.708.g77570a6a1d-goog

