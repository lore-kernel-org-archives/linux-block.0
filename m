Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A71A00DA
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554642; cv=none; b=AJK7KxhdHf3ed/PIq5zjPKnsm3vYIim/rdnIOFNCXxSzHhKUYYCctP2v18ZAIsb0u7rHY0i3jenbkNQv0PJ540nlowFD33TZvIRi0qmlt+XGJZsgsAlGCsC5w65Tzia3YVHPI8tfythkohjXbTcLmxRtjmd29nkl+A4aontYajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554642; c=relaxed/simple;
	bh=Cw3U99JPIOapLVhYnSDk1daJZegBsN2Qpv6Nnjp/Vu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+L6idzHBtRN3ewCSel7b3FiHCwCpujSVH2KHAgtMWNBbKE+i5pw5YEka81xPWNU/IHioRv0igfMIIol/y793QiNiP/XjWWTvhI+E7WMpEnwj6voRCy7NkliZj4peRtawwVbFls6V6YV+0EYlJhvu6atuKLN9dSyijMxG0nxsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eM61/XdL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM61/XdL"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f4f2868710so11374181fa.1
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725554637; x=1726159437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWD0CFMBOjkRPOcl/mw058bZdab8AGLnFV3fz4t//Dw=;
        b=eM61/XdLzhhuN+/V9hQ+D8zfZsLiKjRPDSbawJvz2N8Owc17IVRuOzINT/R4G9Kf8T
         L4TaNmBiQleiV6F/gbPu0G0GOarn/txw7z5Tys6uFBw29n5oGQA7LLxYzRqrxYXLX3TG
         mGPli9NJOkrpj9E7s694FAn5CkC+P1keHw7WXILiD7v0cVXWq2+RESbyMukoCN+Vh/X7
         dZHJ2UbP9Mouwx/dYjwtl7gFnntm5OpRkxx3mJyz8vBYd//9Zi7cpaaTRSBxJSlIrj32
         AzhX2kgYF7uIqH3NhC/3f1HjYT989cc7ALuR82x856XBByDRCwz5psNWYQ8t/1KM14gb
         trBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554637; x=1726159437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWD0CFMBOjkRPOcl/mw058bZdab8AGLnFV3fz4t//Dw=;
        b=chG9ME3XNtNk9H85NxzRlFBUh98KpMtQKqaRAzrDRIA9ZPogWQC6IqIVn/3TWxxlS1
         5+GYBZirZvide47AjMPwOF6f7pkdilFez0IuTIwt+fGfOsz9iMid5ZXoZlQf3YFSqzz1
         vkfZKBrOv/r5bCdnlIMYvKL5KFoQWtN644GXjZ4kIXkD6jrgO8M/ZOaOE3TfGegnVORg
         +pdXDPb/ANnwzqq7bE3cGNQ78JKl/Ib1Jl0F9nBn4s4SbsHPedxjhGdDwd1LNRKDzKjX
         uyuJGiqAtjhN3/n4QQuSr+0+Ny6NKI5StTesF48dF+OlRnGcpnFaiD8mlnFiQFrGsy68
         cR5g==
X-Forwarded-Encrypted: i=1; AJvYcCW/rMAP+7xpuReMyWVXNihfnsFu2BNTkkKc3MC6OXjTsiWkQb7XesgM7YoFzuxTC+ivZ8NZLDFuF0e39g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1AdK5v02u3mY8zy5h9KgW+Sv4UX0cByUbJdOgFojxcasply22
	jLum9UohTOY4TQCnO0xlg4/Eg+fssS5QxBhwrfTrqlSYppNIi/Y+eZMprCslSfo=
X-Google-Smtp-Source: AGHT+IF07Md11BWV8oFFnBHbuiTIDWwJbHyyyk9jxHfr5601frX56+VpwBGGcRRCNqplS2HW+UGXdA==
X-Received: by 2002:a2e:bc09:0:b0:2ef:2c91:502a with SMTP id 38308e7fff4ca-2f6443faf63mr96804751fa.3.1725554637346;
        Thu, 05 Sep 2024 09:43:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f653d5a2afsm5539331fa.84.2024.09.05.09.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:43:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
Date: Thu,  5 Sep 2024 18:43:44 +0200
Message-Id: <20240905164344.186880-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To not give up entirely on maintenance of BFQ, add myself and Linus Walleij
as maintainers for BFQ. Although, as both of us has limited bandwidth for
this, let's reflect that by changing the state to Odd Fixes. If there are
anybody else that would be interested to help with maintenance of BFQ,
please let us know.

Cc: Paolo Valente <paolo.valente@unimore.it>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3eb6aaf5e47..af9d318cbfe0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3784,7 +3784,9 @@ F:	fs/befs/
 
 BFQ I/O SCHEDULER
 L:	linux-block@vger.kernel.org
-S:	Orphan
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Linus Walleij <linus.walleij@linaro.org>
+S:	Odd Fixes
 F:	Documentation/block/bfq-iosched.rst
 F:	block/bfq-*
 
-- 
2.34.1

