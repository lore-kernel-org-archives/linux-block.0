Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032D373BF3
	for <linux-block@vger.kernel.org>; Sun, 19 Apr 2026 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776575425; cv=none; b=VJM5dMLLjrUiT+QwwQUMibYx0alD49Ti1yGrS1qkswPxOzMQsOUw6IC/uCEYjwYRUbDP66Vek7DwsYRlV1NAOFL2Kq5MWuk54wdofDcYCJ6xN5F03JLfS1tthYn0EdXPVq/A/nC2ZNh7RldFBmO53EATxZ0hwZjLfChwozZqOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776575425; c=relaxed/simple;
	bh=1u391uZeLxEQyZ45BL2xTX4amzHuWYTpTIzLk1Vf3Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZGuDmDUu+JjlfGOFk6iF3Fi/JVIfbf6aisrOtj3ytL3tSBPTK3sUyHMGGtzllZ2MjfSAAcWzTA/ATZqWiWnPAZuOehbh73k2Noy1ZFylFc6Gp5PSVYisSQGjgoOvuTKYLhbeA+orPckLmUk7XOKiY8DVtZt0OkxeorehT8GJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Q8yXL6w3; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Q8yXL6w3"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so4327669eec.1
        for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 22:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776575418; x=1777180218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbBBdgyXj/Yl8SlmqY/l1ScYp86XUfVwJbvRMbxmcBw=;
        b=Q8yXL6w3i36iRVqGM8008IFdYovW0kJRCrH2GTOpZhdoLsKdMszua0FWAgEn8W46MI
         6bsFt8Epn7VH0Pl2JMo1fGOLcvp8R4D0coUmKZw1x9D/g2JEZQFgm+9xgJw2vqPb731E
         JZI6fb2i6rWRQqf1Rp0RCKbohVFCxLPXXY2vRy4bgdM8ApKQqwNhZHqU7GsG8VuYGI0V
         Y1UERn6nXN2dmNln6dp5l7fD5lkdBiqjJnn/Tg7mdlSidfkfi3G0g73eGU4nZ+b4r6j+
         C9h97tGbJg23up2XfWt6irKhy4VEZbl/oyB876fYHy8GEWUMc4xGvNZLavvqn7UOz2qg
         d8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776575418; x=1777180218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbBBdgyXj/Yl8SlmqY/l1ScYp86XUfVwJbvRMbxmcBw=;
        b=l8wnoFI3AGwnUpyRWw7VWE7DbR8274tnsJHOQRcyDxJsnsEkS2XAacCpL7Z4vkwYEm
         5cXZMRdgfXLIVbcijvt19mU9o9rUL9pnZ6g/otAlcbBRC59gN2afCtUcJB4MOeIG84mP
         dssnLbPK8jqvTUY4pn+PGcTfzbFvix7WFlyshxuPRLzq+QmaOd1s5odWCOgf+SxRKMbp
         4G99uh56Cz6e7J421KoAZw2aIhCbIsIuGcaZSlklG1JkL4dD+f1e4U1sxCYFcVjSP50k
         Eq/Qq+EyEx/hw3VY1Dg4bIbldSCpEvtx0wzAvLefyq1+dmIJM9sEej9EyosTQZkCo0Zp
         2gmw==
X-Forwarded-Encrypted: i=1; AFNElJ9XGYoH5HtswxLna/JGj/p6A89jlezD+711yl9vYmABpYpljbX6OjR8nwn8veEXHeloh7oMUaQ4yolEUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaffdXWhdKwvpmFTZ+p+O7cGktjiTpUnpKzvbrv0zks7D23r0Z
	TE2aTumXm3tyvQOEywiP9ctfJZ+wvnu61odeaZ28jyYp4Gj8s7Xcdh8xwzb/gAZwIXA=
X-Gm-Gg: AeBDievwF0bA2JhmAY0+qyOWn5MaVAy/4Vedypu0QHLIIU1M/5F3kH5TD7gdR9i/p8P
	OW/VuFNt6QrL6uHeR83glnT1bMAcRru4rBhS0tWZb712XpQL90lx5pvmoUllLH/IKti6RjgX5Ea
	WLNZF3an65Fm3f/IKOJ6rtamlaQ1oFnPMnJ3dicfkqdDAygB7nV5R+fiTUCb++NfnWuEPoWZ+NV
	M958TYBhhSAKCeXE9+gYRsLsEEUPGXl/yFlDFDFJ/5zl8VOywkFpeXt4r3Mkv94CRb6hAbXr7+Z
	IKx+ZEraodHW7VLXRO+29Nt79nyqwxN046b5OZVljZhfnYcFpcjCthL4nlXQh4LfX9NESEEzO39
	vfO0cT8MegTkwIi9Y5kG7+ZKrFxZmgrvmdW58RdEcoHekA2cK9Flxu1iO+VJs/gEUXVccBVkzp8
	97IBW38EguiRjhy1t5qMMQagIHUopnkFAXLwKMaJB9wjQhSg==
X-Received: by 2002:a05:7301:1f01:b0:2c8:6361:ab2e with SMTP id 5a478bee46e88-2e465770823mr4567945eec.8.1776575418318;
        Sat, 18 Apr 2026 22:10:18 -0700 (PDT)
Received: from chrysanthemum.. ([2804:7f0:b081:9846:8d5b:e745:5172:e188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b3dd9sm8745052eec.27.2026.04.18.22.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:10:17 -0700 (PDT)
From: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
To: axboe@kernel.dk
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>,
	Gabriel B L de Oliveira <gabrielblo@ime.usp.br>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 0/2] nullblk: use lock guards
Date: Sun, 19 Apr 2026 02:10:07 -0300
Message-Id: <20260419051009.796491-1-ricardo.kojo@ime.usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() for handling mutex and spin locks instead of
manually locking and unlocking in main.c and zoned.c. This prevents forgotten
locks due to early exits and remove the need of gotos.

Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
Co-developed-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
Signed-off-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>

Ricardo H H Kojo (2):
  nullblk: main: use lock guards
  nullblk: zoned: use lock guards

 drivers/block/null_blk/main.c     | 86 ++++++++++++-------------------
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    | 19 ++-----
 3 files changed, 38 insertions(+), 68 deletions(-)

-- 
2.34.1

