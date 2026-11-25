Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620918;
	b=bfSSU6Ey/SRslvZmTF/0qmpQnk2eppzVVGPF5C1w/DZrn37NVdh08CiRfkkkeKgmnMV9
	 U1iImibTR9FNZZwEhjxDFKR+HCxNACmUm1ZFslzI08re8smjMveJ2ei4ggpaNrul/UOTW
	 ROyUkjLxgNN8aSpqYD6jCmWa7EhHLwAgCE1civdTuQw+Lma3AOs8auiuaNxGpQVRY10Wr
	 VWEGoQ7MzGRhVlhSnFN8sWKN1m0y5bVWc9bJrb9pHCuT57oYQGTrddjfjQMaGiEu52pF9
	 PcREct+JadQZVQf+WrmOizJvmM6w7Zrmiw9icd/sdtlT5LpDTSXyflL9mJfh76UHisA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vhkFSXBg3GgpQvepNDJMBuRf8NhXV0xRBkRjdJ1kVu0=;
	b=Fmr+qMOA1DB/bsUuT6lVUjZq/mCbCV9OnEijE4NLyvuSOkYC/6Qh0v60f1C8dn3KjNkd
	 uixZ8yeXWMxPPkdLF4GxNqlm4gP5YfRyKpHnE1aPf3Pvk7hdxOedPAdenDJvHnFGh2kra
	 QTHqsb0kZbPHW7x6i2M2GzvfKfTFgH06QdPu4MRJTXCJL31o2pEhPsg2j2kjpZDK2bsfF
	 KKgujTYjT6LNPtQrLbL01c99jRSmuO8v5B6CRMO1en0ImiUEa/CTJbLrIPp+g87jXObZw
	 3LhLRPwuMTmPu2DrGywjoWXe+FpoAWuEhyACpQ3x/+JxE8wCxfUgt4+sI01VQnmTsNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=faP9Krxg;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AD606A330
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 15:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227AD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=faP9Krxg
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a357b1c649so3466993f8f.3
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620916; x=1796225716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vhkFSXBg3GgpQvepNDJMBuRf8NhXV0xRBkRjdJ1kVu0=;
        b=faP9KrxgjbZ63ZEOV428WdjRtzLDO0aqlsXeW5xv6ju1u950zL4qz8x5/GECab7zwM
         U0IbVhPBgcVVHDCxXpog5E1ZLrxjB6/Z+1hq7AWBIeRp9i8oKSkDl0uOsguiniFAwZ7o
         yi0zDz8mJuQpTmNNwDwDtcpWvjigQqx+0yCzKldN+Nv3O4bCEw12+QRzZB09jdMJ/WP0
         4Q03q/PlFPbBV0thhbXoe4Q19joXOc1+oEPx3llh1tfi2W9tuSzntYKvUFmQNnM2c+bK
         sn51MNNLLHdOpflaxg2HCyii0/pu5KRRYyk79zusb7iWz7144gWKI3HQWQxhryGju6Rb
         p8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620916; x=1796225716;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhkFSXBg3GgpQvepNDJMBuRf8NhXV0xRBkRjdJ1kVu0=;
        b=IN9XXvvUXu0R7F9u8bFg613kyRF7E3sUW8MQngnhCD6WFxXtaXcZ3Bfnndej5ODHpv
         NE+KFhl2LM9+DsfmsuQPQ5sZX98r7Udhp5siisg/NbdgbZVH2GGynWgpOlKwlhWb+aW9
         +J2eZ38n5WgOOmroU5M23wyD8pet1q1zZ68PfFG3TMKEVXsrtqjuep3McyCwNG4y1S+j
         jAKMo8uiO3ihJDmvlqTGLl0WJmAK99OxeUuSmI5IlVo+oJBSngF+3rknfHbCXYYkfs/t
         nQqgVFog6K87QZjx13XSr0H6YpW2JXReYOsSev1pLST/kuCr83Cr4DqMsV5vPjHyUfwK
         /Tvw==
X-Forwarded-Encrypted: i=1; AL+hErHLWU74g1gKwg3kp1zuG5+6UjziVFwffegSVol99YLDTq/vXhS+/T+zLcbWUWYdEA2Z4XtQNB6LfxCW8w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tch5D0xbSj2IVhcIZWo30/56TOMzUYmpXBE0pMgncsLHZ0YLU
	n+TroQVQmMhK6xgRBQ1a8LsRTfYl2wkgcrx+0gLMv4kjjiVnH0EkZDyzKQ09pr7Sp8Q=
X-Gm-Gg: AZFdTZcUtrT9mQFpFAtykgiVhJom8HHGAzaWvufl2Xw9Aq9ZrSS2MNtU0TCA2ibi19L
	m5penlktJMgrhOUU3OBWCL45woIvLljR1UMPOppZuG7PsrJx6EeYlTNhT8ufT5enIIy7HDRYJtT
	Vxcaz70zdc16BQuYmAwabgrKCcG/m1P98qXxVLB7n4M9pH0OlViTIehSK6FTH6O4vwcjr3A5GhR
	6jPj3ErXAIA4I7Sxb6RQIzBVHUaCfFoj9j9hisMJafD/RagI5/ms+eKREk9qvZGTI/gkvISYdQL
	x7AflKNz8OlcB9h9CYEAqvJ5Lf17hQ9b7GtyoD0UE8DV/it3feF8QsZcZEJ/0c7ZOvhD69NUETH
	s+StXUqXFvgJP1/+fVY3VMyJGh1yv3f4LO8peS4Hcqorh+WcetzUDoKfM+ueBdz81u2gG+pLDUt
	mAefLkvocVhf87/qmPR4/D5yb0SOg35v+7cwKgWcupNMPZt8/0L4UiqOjcGhrqrI200ANIjU4Dr
	1He9l3cTorjwjldvEpDbO030Lx9eb2Dsni666qkMHZwdm/xbOHWKopWGpfpC1cfnaVegTEurXZY
	9+Nzk59ptbX+2RBNmcV/t6lp29s1y59qM26e38liazo7voEfk+QGpZJCrXzk9eu2G4OwuE74Dg=
	=
X-Received: by 2002:a05:6000:29d6:b0:4a8:bca4:f295 with SMTP id ffacd0b85a97d-4abb32a4173mr23941677f8f.38.1795620916557;
        Wed, 25 Nov 2026 07:35:16 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:16 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v4 01/21] drbd: mark as BROKEN during DRBD 9 rework
Date: Wed, 25 Nov 2026 16:34:51 +0100
Message-ID: <20261125153511.3060599-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
References: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mark DRBD as BROKEN while the driver is being reworked for DRBD 9
multi-peer support. The following commits restructure the driver
extensively, and intermediate states do not compile. DRBD will be
re-enabled once the rework is complete.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..b907b07468bb 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,6 +8,7 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
+	depends on BROKEN
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
-- 
2.56.0

