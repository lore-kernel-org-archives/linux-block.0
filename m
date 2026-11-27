Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749426;
	b=Teb/7XcNNvtlxARMShGiLLrNLy5YgC88ROGSSK1Q+ct0LvudYmpTjBf39pxLQZO3b2SF
	 MpzLWWkr8j3VGqBQamjtxmUZTkmRc8W1CQd2jTnMmPwd61WqyQAUp9SgwGdBzcoAvxyiK
	 9/BN0C9gQY5L0TGbHZx9cCYMTjFkha9iksocONgYXx69gwtT1DGw4DIVjg2Zb2Liao4Pe
	 gXWC7AjAWCtdCOAx/1W3ivbG6DjdETOK3Yh492ySoN9+uMD0j8g9nrsTNbyaiHx1MrHkF
	 Wlc72Gq/MhKEKR1pw7IRhyV9ywIGlJtNlIBDwzaLW4gXWZt21SHUQF92nedr0MpFsyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zYwGFrVXRtVQNbh2j9jq0UMXN8rATCr949DIEhCXwno=;
	b=qWmXHK5L6nLkEHLbZMgbtrIZzPKaIUwAHCDGEXwS81DC1jV7NRgifhUqARYvXx3pTz79
	 P3N1c+JsKUc0w2eTeo+CrdwmZz8VXqds6FiO8qxm1oP+fe+FuYoSVzDjsjuJp+rTtXViy
	 oY2XHz3TFi6xys0bbfGapjAxBUhqvxvC+Y94V7hpNtHw4zxT0j+ZFGAyZFzJMGERvKj5P
	 Uj907w1w/9uKi0RsEj3/rRiwS5W0qxnZjxrA+IWtG/NxMmNiOcYFrePQWBe4hVxoQl9c5
	 7ZqyYAxrT6JGPTgFgh093IcnJ1NSijlZt/khFdKg8aY4vSQYvM/iiAuHarfVCPcY2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Nfsq6Q7w;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F775606A31E
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 03:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F775606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Nfsq6Q7w
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so3733678b3a.0
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 19:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795749424; x=1796354224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zYwGFrVXRtVQNbh2j9jq0UMXN8rATCr949DIEhCXwno=;
        b=Nfsq6Q7wRhpNbfSiRyUNzpz5NbquK9H4W2aGEej2aXFwSsFi7ym9g86K1Pt8jpkXZ1
         pfg2Be/7L6jereXokz8Qwyx5kZdovJCpeuHGCeA630Yzk/DKYIbYEjNNYKnHOVDzWw3Z
         Qa1SoebOfpE1aG7OG+6J26FmTnVCImrBOdF5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795749424; x=1796354224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zYwGFrVXRtVQNbh2j9jq0UMXN8rATCr949DIEhCXwno=;
        b=CgceM++A92Si0I7tFrl28r5IUqi+t8hh0nMclzxQ5jbchehAv7A/3FUuehlXP+u5US
         1MahqkM5ckQC+vRnZ3v+d3JsXM2f5xvS/fkiiMVoONWGCZuVfJnYHxS7IVjlYKeDCZtd
         pS6DG/1HFRO9zNjbzipMZ43X6R77M9QLz+XalzLwWeahysCkQt+p8HRS0cUXAGk/jblL
         GVlqmnqalfLbkObTtWxErV59fykYerjvT1wBrBN0X83KqETyL6eOAwOEnxkRJy5gZqB2
         c47+lqpKr78yRk6KjVNEINDMUnYqdm6wJLI/lIOhvGLh4mZu2z1h1G6na1bcEZx+83zK
         AkpQ==
X-Forwarded-Encrypted: i=1; AL+hErHDN8tZmqkfJkNO9DJf7TlKRs/aQXR5GQ1l0pwl3/8lFIA56PX/8LGGqNApWX77yNHoag3XPUA2LgxEiA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gl9w/Mi3giH+L6rnHdsGYgWRUdnfCiS20ZjMtfAmUB3Jk7doc
	ezH5mkQrLsKrf944rqGgBo3dI2kfVLkH17N24ZxC3tAdW3eDtSAhwjDBwoeTRp/wy+M141kfeyg
	SPV4=
X-Gm-Gg: AZFdTZf3i4QCgJMXA80Xmt5sdxISSw3ruRUemuFxClFHuFgKliEKpG+xb4GaaXk8CsC
	LC5Sk2anM3xr8S6qgbwHC/nR5eLog5pgXYQ+H5D86XgjS8M6A3/hasIz75CPaGL8WXffRhdwnGP
	036ocHFZrbcmmeMc0yZWN1NdZTphp053HMPmVSJnADX18++zy4OoJvV+g4PsqTEHEv619d9Xy+0
	RYq1YHuyvNZ8JPMlrQEXNzLqu4cvZSn2XSCqENEOWDKUaw15ed/4kdIS9Lh49/W0go5V7aph29i
	1E1d7PmPY7QTDwum5t9rmkWvi32G7hgw5Of4weRbPlySpzCVBeggnE45e5G2ZFCObqOyCl3j2hX
	BZKbFLz28XIpeVFu1b5u0CnLUP66ExKw34rKsO2TxS3Ca0pVcwVQtTGb5RVfpAbmbH+a22Rmh8D
	8PQwlYDutWv7A9Q3LP9xFaTMiuP0NU/uMDtKrAprDuw4VaI8Ars1Cty5L62k6bO9CkXmplwgZew
	jswKbxbLABSNfkwl1M7uzECNv3DaVoIiXe7K0uo0opoAchDa4U2+xcw+zR21HKa7BZSHtw2CISL
	+Hja7S780vVpygTRGegL8IQV0uFEltdAbaQ1tU3nEZM4SRMNe/VFIpY9+5rIyPdVpKnaGjs+GVn
	p/mN8oAHDAC9QlVe+uw==
X-Received: by 2002:a05:6a00:419b:b0:89a:5:92b9 with SMTP id d2e1a72fcca58-8c87cf2ace1mr19349814b3a.44.1795749424469;
        Thu, 26 Nov 2026 19:17:04 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:5bf8:984e:5bb:e51d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4d7basm11333567b3a.21.2026.11.26.19.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 19:17:04 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] MAINTAINERS: add mm and block lists to zram entry
Date: Fri, 27 Nov 2026 12:16:38 +0900
Message-ID: <20261127031658.2049871-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

Route zram patches via linux-mm and linux-block lists,
rather than through the generic linux-kernel.

While at it, fix a DRVIER typo.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68811a0b7916..3f10a5772b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -31316,10 +31316,11 @@ Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/driver-api/media/drivers/zoran.rst
 F:	drivers/media/pci/zoran/
 
-ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
+ZRAM COMPRESSED RAM BLOCK DEVICE DRIVER
 M:	Minchan Kim <minchan@kernel.org>
 M:	Sergey Senozhatsky <senozhatsky@chromium.org>
-L:	linux-kernel@vger.kernel.org
+L:	linux-mm@kvack.org
+L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-block-zram
 F:	Documentation/ABI/testing/sysfs-class-zram
-- 
2.56.1.839.g22a8290db9-goog

