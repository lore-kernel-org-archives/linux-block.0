Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA41CF87
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289084; cv=none; b=dVX87OHa60MCHebVWvx7iiykjLy9ie8W/beCpm9jQ1B3soj9QoFJnouuuodHzx8SbEAyQ04rjfG+q/eS/8auPu3B7DgL2PUfVUzVejQNs48LeVxFMNzNYvTOXn5lCsYukndx2vpfaCyWrRoqH6byu0HbTBLYgShFapfwo3rrAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289084; c=relaxed/simple;
	bh=v5LeFjZ/D+DaTKsnl4J5qcG/I8zC69+dw/jg0kjeUcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMaHEb3DrHmSB+f3/lkL+8NlQmuoCdq8r2w07o/lUcmtK1/CX2lMMDLfPGIsD9o2bOzN/cCs3zw8w8ySs3viFEO9qmUrvPLjvzmjMm+xM9C7sWPfk6OzfmG2FycaXsSRYvyGOeQivGVgtXW0eEyJ+lVc8bWGVgjOqiSVi83Wzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LDJ07n8j; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LDJ07n8j"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3beb504c985so142530b6e.0
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707289081; x=1707893881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF8DJPB95uBblxoCa1mRhbMMCPpx1zNPhn967dUKiP0=;
        b=LDJ07n8jVqD4skDOFWP86wWchOI0L0N9Jeh+kNBIeM4+/ZG0mUSAiGPhG64L2d2Bgc
         bVDyDs4gCxiuRZXKVL3NHa82LAWZlw+ze54OHH06HrXeSRAvl2u9a5koe+xghY/vpR40
         JSUPCdfATLlJI08Qpe4Psg1ZVWwCoZGn/NHQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289081; x=1707893881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF8DJPB95uBblxoCa1mRhbMMCPpx1zNPhn967dUKiP0=;
        b=wmnGj9zXmGCZFzWiEcTUbhOVeF2G3jYQAY1hb3KzX1Rrixn/wXVcrbdiUiOpoU+kZm
         7JOGmHMgFPlk/IPB3lqnXtoZuQG8/joot7LSwcsCRHv+50YznRUin7z6/XjcSev8M1+k
         Td9H+J/q+AiviWOL3Bf7ClQ7DRM+CHw1L6nSWuIX6WiKteSKC5S+CfNM+6trq1jJUOWp
         ZRHry0WDR3W9Bu77QSiT+xen4sJu5EUBCEkyxaQgqajbC1N7BgEiZvVuameKzZCLZ090
         f0tqqT+GeHYg6CdxNaRfCz16tNbT5NsyhjJ+4X0Al+Lud9h1fsNfJLnKA7xxbcRhUbFV
         kc6w==
X-Gm-Message-State: AOJu0YymxqvmamfMRI+3RfmW6jS+bVBfoKoQGcffIYIXZ2MGirMv9vxF
	3qTd3bGIndF6WoX5fV2G4EtD8/FNgEWKuzHujhmxDNO94U4ZE4zSq1VcWA/Msg==
X-Google-Smtp-Source: AGHT+IEHekeImTPE9NRNwFrQZKoMYfTgezv+odH7iCMfoq3rY0u2xfsS0Fr4CgORLpMNIUrmFkW2cw==
X-Received: by 2002:a05:6808:398a:b0:3bf:e5bd:fc1b with SMTP id gq10-20020a056808398a00b003bfe5bdfc1bmr4815266oib.36.1707289081746;
        Tue, 06 Feb 2024 22:58:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLmrmWS/mMqY7L2YZEcevanmoauf9UvbeDLYH3u3rPdDH6h3skOTxnIMss+kgLRqMS+lVEbpLeX7+TP7nWlvGwQR3y+kHEdmu78wsfyYOaciYrSerUsRbQoNEDtFl8skHzyQwWJJMlB186V5h3UZd7JKuRaPhIMQuDmwimNjleg/Y=
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:aa4c:2868:935:7ac6])
        by smtp.gmail.com with ESMTPSA id jw15-20020a056a00928f00b006e03ac84d53sm672576pfb.193.2024.02.06.22.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:58:01 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 1/2] zram: do not allocate buffer if crypto comp allocation failed
Date: Wed,  7 Feb 2024 15:57:11 +0900
Message-ID: <20240207065751.1908939-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207065751.1908939-1-senozhatsky@chromium.org>
References: <20240207065751.1908939-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not allocate working buffer if we failed to lookup and
alloc crypto comp. User-space can request unsupported
compression algorithm.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 8237b08c49d8..d88954e8c7bf 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -50,12 +50,15 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
 static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 {
 	zstrm->tfm = crypto_alloc_comp(comp->name, 0, 0);
+	if (IS_ERR_OR_NULL(zstrm->tfm))
+		return -EINVAL;
+
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
 	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
-	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
+	if (!zstrm->buffer) {
 		zcomp_strm_free(zstrm);
 		return -ENOMEM;
 	}
-- 
2.43.0.594.gd9cf4e227d-goog

