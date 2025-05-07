Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7497253F24
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654593; cv=none; b=ovB1mUNDL6O4DdQyQL1wqnRpxlB/0NQhvWYiau9w3y5q87rUacH26vkPP0ubpE/bm3FcAYxNfxQwF6L7gT29lGW/H87lhhqdjpmr0zieTUJxg41O25UZoGqstm8/OMIKCvkjO6G1mru7mW8tXLY0zXO14XMYVVdzB4cwEDB4Ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654593; c=relaxed/simple;
	bh=f/xTZ8BJxeNBMZ86V1uElFpd5cDr7++FrMMuSPkUyhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKKMJeEGq/2pIhTeHCPXB8cw6ZkIMs1ABn4RsVGuZyexJoT722NNZfDLLWB2Bo48d0Pi6AtExWhwpemV6ZHDau+PDMs9FoYiqXWwcYYBaSQ8JOzUDqqzXfV67O6XNywJGdD5M20RWJL0G5ybMnetvRZ9uv7xU2lYc+WMUy8uGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WYILmm/u; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WYILmm/u"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-2dab7a32fb7so273905fac.0
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746654590; x=1747259390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtOqL5v5hGaLj2nSYEbTs7MVaDma8jT2Iux9zNB98wA=;
        b=WYILmm/ulrWDuvRg7mGH0sDMJTqwudXYEx7iA38slj1nHr3LROdGYf9Cu7pXyuD2HH
         KRTx65WwbA0ExJBK+ADGs50so2g0A37+cLpB0kC09+3CC9MymgwmaWP7OO0IKmL4f0sT
         X9pn33qGlpaFIeIab8tSeUfEmYgCc1ahsqCT9RprPqhJQKprOsleCDS6Hm8aBMQ1QwhI
         FGXlKlKxPdLQ06Aun+fkUAzKCOFwaOkD/qTHz1Y5EVojVa0pkd710gGebYLxU+aTxb0r
         eiwQb6yeHrytusErUsXoRKs5iS4rx2zVsmWTsjMpsNzJI/awq/GByTekAYUiByGhbf3L
         EnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654590; x=1747259390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtOqL5v5hGaLj2nSYEbTs7MVaDma8jT2Iux9zNB98wA=;
        b=XXnj0G3wstmFUNWiVf9wbYLECz/An71UfvuJ0xlzliWz9qGaZ8RxGgmFTN0771GykD
         utB78tbwn4BSby3/HeEXBLaoiOF6yO3wNDGIXm4x+1SRiebxAESTGdCTvmhmBGMEFvCX
         m3lze5nYK2i5H8We5F7DmJnw0LLx7lERb3ofRy/ZNZhnIIJRMSuL2KJlsgFrkKazuWto
         IqLLk7Hqte4EpD3dtu3VR/9Hxn6JA9cpL6QmzXNSrr2r+7VGN6PyqI/M4gRvLX3GvGBV
         J0+KaWUed1jtclMg25dhvybClM8EHR2KHsxfaSekRPkLNoCJ1FYq9KXT1l6gpTFR5vEc
         pImQ==
X-Gm-Message-State: AOJu0YxTjts3aLbSmXAGcwpZOnQ7n59ziorhoSfFLMH2ilh11q+90BUR
	63w0nPT0qSjZsoNqHAocY3Xgpj7cf9u7crnOTA7SVuIwMUrOoGCi76UF0QIsZjzr6u8Z5nsTQOy
	+9bqnybXH/dv8TIKPQSF6aBHRN1OAsd7XMt9Wx1A+IVLj/Nab
X-Gm-Gg: ASbGncviZewtyn/+xIfeazlzBDIT76CRJBYXJsqEE29tC3pXztvSL199YM/zHtF8C0I
	HPkMj1o3+p00EfdA6elgzbdNTWeKy8zZ4Hmq9Ek6ytr0J2p4wzUQCbk7hBM5JkqcMWOYD3XmDYN
	TMhL/ROVjXPq4LTPkrqrScvOxZ9UZq2Nizz7es1mTauVmQ8Cg6zsiDgtxNzTlzRw5Rvj7NrS06q
	l7NKaBKBhaelax5n+uADuUmUTOlMoW80u0MkRKQkgJxSbbASbqztnCuog6ZJ243kGbJ/fvxkSRn
	xP9pdtkSqwmEqWfTxuuKhQVns4gOc+c=
X-Google-Smtp-Source: AGHT+IGMnFiY0xyQc6c4BYgqiuOS8Lq+bjP0JIRCUEyTMPXHCZjKDaIlzWCuY20vgwE60gGjQrKqLLEmav5O
X-Received: by 2002:a05:6870:8901:b0:2c2:561c:47e3 with SMTP id 586e51a60fabf-2db814c514cmr694916fac.21.1746654589745;
        Wed, 07 May 2025 14:49:49 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2db5cd9e153sm144323fac.23.2025.05.07.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:49:49 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 444503406B0;
	Wed,  7 May 2025 15:49:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 38F63E413C6; Wed,  7 May 2025 15:49:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 07 May 2025 15:49:36 -0600
Subject: [PATCH v6 2/8] sbitmap: fix off-by-one when wrapping hint
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-ublk_task_per_io-v6-2-a2a298783c01@purestorage.com>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
In-Reply-To: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

In update_alloc_hint_after_get, we wrap the new hint back to 0 one bit
too early. This breaks round robin tag allocation (BLK_MQ_F_TAG_RR) -
some tags get skipped, so we don't get round robin tags even in the
simple case of single-threaded load on a single hctx. Fix the off-by-one
in the wrapping condition so that round robin tag allocation works
properly.

The same pattern occurs in __sbitmap_get_word, so fix it there too.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 lib/sbitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d3412984170c03dc6600bbe53f130404b765ac5a..aa1cec78b9649f1f3e8ef2d617dd7ee724391a8c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -51,7 +51,7 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 	} else if (nr == hint || unlikely(sb->round_robin)) {
 		/* Only update the hint if we used it. */
 		hint = nr + 1;
-		if (hint >= depth - 1)
+		if (hint >= depth)
 			hint = 0;
 		this_cpu_write(*sb->alloc_hint, hint);
 	}
@@ -182,7 +182,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			break;
 
 		hint = nr + 1;
-		if (hint >= depth - 1)
+		if (hint >= depth)
 			hint = 0;
 	}
 

-- 
2.34.1

