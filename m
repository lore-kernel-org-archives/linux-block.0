Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6E39FCD0
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655405; cv=none; b=ZGF+0XyvtYxqH9TyDiSh5y3CflsbwctJ3E1a3kNczToqD7s/MllegnYOGqVonAj+9aGEOXvkxBmU8AWJk1qbcKqKoQqUb0qU/PfOQD+vHKJH1BH7e7AEEx7WNnIkBsoSY3QirKjVXfR6USCAWxbeR3Yd9UJ+avZTWZbJybh+gz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655405; c=relaxed/simple;
	bh=yhT0EdIn34OudW5j/r+UeOcpI1T1LAByDG3DZD/bLMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VVr3SlViSP0q7OKLWcj/39mDHNOwTYHHC3aPACBTzbUFHDfee9mwuY8jy05yN6R4kgmkSr7oUnOAEfP3O2qYx4idpkMiJFrKVIf9DVKGLJkNKYg1e42qJpa9TB8+FiMau9dvzOHZNRREfHpNc3r3yHIWchhrZXRttwCZhH5Elcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=vIW8aOVU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="vIW8aOVU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-444826c16ffso5454516f8f.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778655402; x=1779260202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICO8dJZapJhTfhwfOJGvuSMwHyEwmud9Z8lFAXKdCLI=;
        b=vIW8aOVU8p3Q7LbIDA1bwtd8F4dpTWh2ApyY66PW5s4itvBfOViIJzt9JMnkqU59wR
         Vl1CJ1R7xpN8N4KFvGPjmsqH7soymYTTbWKvw99AsuHv74Zt5mKBu92dHpgJ3yreM+HP
         n8cviuLHUMaa3bTEzqokO1clN4Sjx0uUvFEXdbqXPeFrYPs0j+32vvvj21G6K5R/DJiL
         FLzZRl1GwoLTpqcGHvwkUY78vonSXOzaKrzmcGfqWweEOJF+LhlZzIx8msfC6igtSZ4t
         NEAVAZODyaExPB85Ot8txRRAAR7iLoND/SAVlKcwPs3dSibfLBm827iW+IesBda4bQgV
         QpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655402; x=1779260202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICO8dJZapJhTfhwfOJGvuSMwHyEwmud9Z8lFAXKdCLI=;
        b=cD4vsMThOAO59TItWraGbq4TwludrxFFx/M5UU8vA1lV8y2mMHTLxh32ugh5N8hxhl
         DBvEF0TnGDbeLiDwKkE9m7ma+EXeEa6XUJZTND76lEjL3Fr2Kkb2tILfM+AcoM1MrySx
         +TZN2Y7IIYiMmBwgOFTYdImtNFfjRYL29CRBN+7D+zWoiPQg3x+PVIdUtmW+uaSRBjph
         dgjLgU+eYfLSxmvYXh6ruHBG2sjFyEOQMUESaaOb7TKnAlCfiPzeZWaE6/kb7VEAd36Z
         ZUJUvZnbtfoLF5xMnrwnd9cPHUMjceX+xGsOD6TG2obbjVImKo/t6W8A8y4xol3wDjyL
         0qdw==
X-Forwarded-Encrypted: i=1; AFNElJ/lDOMi/BdL7hEO+8X1W6lXtzPuiJEw6yPKPMic1GdOXaDCAdL4nlx/R+ouT6Ap5a6OaY6IBBOBidNZSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPayyo+AtHpO9mCDnQGjZmycvFsuXPSoMu/Lcl+1KhB9RBGuu
	M15eoTg6a5XRMqrPZ1ojNLZQk6qxZTjg+N68KOGkyvUsforegl8m90vJccMfeBJKhzvdwClZSzC
	Y6BBI
X-Gm-Gg: Acq92OHCzbSTC6Dh5LFFyT1j+q0dfn73FmalnHIH/e7mv2oU54246EyUHlE+K6EHKCQ
	yg6QWx1haP58whKz/uUWyw919zxL0Xg6XJbnCKzknRzpNgZwZsK/ZrYU5lnphmlImKXtWWmUEYR
	U2kF2rQprb4QAon/GZ00wciV4l6+ZKp1QeS+KhaQ8sBzEeeB9JCB+dW/huuu5atfSMH6DFIwLHp
	PiwT33rHJoAb6Skizt0kE4dntxOxl43QL4wY+T6tK43gVlb9j9dT/O04Mb+HBPgmPyJh0oMkNIC
	b4FPXuV0oPAEBekPWFotKBh/7ZJ93BUeN41sgvx2UDszXQlv9SeG2ssNUnGhaYtxklVByYmv9ra
	wNtbYPuqvePtsOioHrhfHawZywnnFetwTE+E6oRX1GtJ/eS0d87YWrdVjEB1wGmABxDp9dTI6cB
	N9TJD/3ADL8g8wrv/UHB9RQaFtPYv//+vSndPJ/xkWPtjyKU4bZ/bX95QIDK2nVj6+q6zmeaRVz
	GMCOMWrVHsbWA/HMrCjHt/1/7NcHA==
X-Received: by 2002:a05:6000:268a:b0:43f:e934:50ac with SMTP id ffacd0b85a97d-45c5859efc6mr2894173f8f.7.1778655402253;
        Tue, 12 May 2026 23:56:42 -0700 (PDT)
Received: from localhost.localdomain (178.115.63.61.wireless.dyn.drei.com. [178.115.63.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm39386799f8f.18.2026.05.12.23.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:56:41 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] MAINTAINERS: use new drbd-dev mailing list
Date: Wed, 13 May 2026 08:55:57 +0200
Message-ID: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are migrating from our own infrastructure to lists.linux.dev, so
change the drbd-dev address to point to the new domain.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4abb3345bc4e..b8db0c038c55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7773,7 +7773,7 @@ DRBD DRIVER
 M:	Philipp Reisner <philipp.reisner@linbit.com>
 M:	Lars Ellenberg <lars.ellenberg@linbit.com>
 M:	Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
-L:	drbd-dev@lists.linbit.com
+L:	drbd-dev@lists.linux.dev
 S:	Supported
 W:	http://www.drbd.org
 T:	git git://git.linbit.com/linux-drbd.git

base-commit: 36446de0c30c62b9d89502fd36c4904996d86ecd
-- 
2.53.0

