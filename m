Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121456;
	b=etS6ci4krh0HkLPsIySX9IneyrXbTReZQ51FEz0WnXdTjO9zLkCLZyWqpfB1W3cvhcch
	 vx3kBe+NRgQURZMiOX/5ATQFFJbYU5XiwcrowjkNYHAGLZJ26ct4sWYlkN3/H47cJfL5x
	 qp6V6bE6nURbsQL9cWbJlayvHELa54SIb8Sz/nzbDPBlCBZoo+N0655++ZIiqBEmu9Vpq
	 mIPyoNlwxNmFPRSRBtm+t2OV6Yn7xk1+B77Gnka8TWYoUDjnsp+c3JWWKZP1eFahKKRFB
	 XRbg7Aq9MoraCy70h+q00uhWoAYcaWbD4zW6AOD6guRTWavpcYTRQFjkd9gDdgJ8rQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uikZsMnz/NyOMgTmLiqZoj1Ur6F2M6OswVzpjhz9zcE=;
	b=cRoU4yyk4cjCYJJeGh0oLLT/SBaAIw2hatGJQRIcYpt++RB8nnWIi4V9vFHpRsxDVm+z
	 jTyF0TesPySy62a4ZLBjQhTGJukyqgGzzO8n4ePwFok1HeItF4CAZb0Gs7hE57eEk2gHX
	 XXluhCLz5tXdyUFRDMqlm9vVa1YiuVR5tu+fsjFSHVQTLVr7etn97f9iGzP5Ra7vMGGgG
	 Aybp7blx+UjddYUWVGfJrWzNxVsRrKCDAF7WLEDs/8tGZps8IEnZ8WuTinkp9N694MpGk
	 Vpp7qYEbj+/Wk34kJIW9c7wGnAlW42uB3Ju2i6VZORmxUsbsnGKxDDhOcLL6Q//SZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRmAjFG+;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47745606A31A
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 17:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47745606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRmAjFG+
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so629365e9.3
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793121453; x=1793726253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uikZsMnz/NyOMgTmLiqZoj1Ur6F2M6OswVzpjhz9zcE=;
        b=xRmAjFG+bILbgyfefWrvhgWMZgcumqS35Pk34iwPunQgRuY4BuW8Yml86p+O0sVgWD
         4IBCFWmrDYhnmj0wmiOZFQTuS5Hc/GPwaBHK3PeG/O5AyUW7EOAhjztGcKxKnoUWxb8d
         6/muSzVTrIOXGyVEh7PzXGnV5ho6+FYjsfh1s3nMQ+NlLibwaT4+ac0zYKL6M1wcbWIF
         kIQeIaEyrNZcMPNl3WNCcmb5jenTRWYKVXeCER++kcSB6Tuhe8LrjP+mZAlOP7cg04fM
         8uoU6YoOs1CqwRM+a/yMjv+6t1wVjmSi1auUQDoAeJ81712QGwvXGKY5TgKNthpEJz4P
         Odag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121453; x=1793726253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uikZsMnz/NyOMgTmLiqZoj1Ur6F2M6OswVzpjhz9zcE=;
        b=P/vpwWnN1Xbame3bpSGj0tvCTgMqopbf1q0XjnGc8B579lvMQ0wSsD07OMNr2uPlpv
         TPgkiN6SeVNZhZz+Od/TNav+aPHPlxsBSqe8aiLc/aHzm0QBVMQZyXPJOLi9B3Kr8k0z
         82Ml+ZuHctOEYDv5H0jGfZZtzmHhUcz36g4Qi0X/HDN9vVNXUaea8ne+ip9gii78dqk4
         ICcBZEiJzfRUCmhwy4JrcJYhBmMoau7C9m2PVGK+l0BZsP6w4XbkJXxfH3nOG1QEiV80
         dMTdgz1ZF7wIBoFSOsxzxelHwRjO6xry/imD7VBV62IB4YN87cIxtm/lS+yBlBAqf0vi
         YMVA==
X-Forwarded-Encrypted: i=1; AKwUvBx3inOsELnFJNsidUDFxiHGv+keUW89C1AFZ/MvRbG9GM7Q7/G6PrGOHSWb5XqjD+g59wg2QwRuAFjDkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLjXDqqc3ws87QSrukedYYcOZjbr/v4ikzM75+KiqHFNivtYB46
	EoIO40cKcv0prp3ZnJTg58KDVj8U7B9f9o8KP2StI7E3XjvacbYYZVF5
X-Gm-Gg: AYBFou0HT9gqT0MAzaP0F+9UkznxrTmxh44/XFvxjmNNwxNCom2c/s0Ui4PohQMR+wm
	/10nEHmyFClLwmJbRDOPnrJ7m/cWzsMiw4gYZsaHjxjcQIS6NTCtzHu1LRX8giiCyC785izYq9z
	bzYuJfHObOq3apXpwVTvlST0UTvkiCW5VOnhrKizR1e8vaMe5ApqzKS8kUlAAOjj7F3E2VBq113
	AVjhbCxr4qLhSdSPlrvae2u4DexNbohjps1bB0HCBUcWG7HiHZNAvUw4wrigHY6+agJ8T4FhPU7
	PMPlJLDrg45JUDjej52kbzJ3FUesHgmXdftReYPLSd60mpHdValjxtiloOhGwypsvGN1KUWkEhp
	+gzczbHL175VhTy7ri98G+kwA89WV0MvXCaiExYkwvpU5f2gX30sS5vEM4u/dtDx/ZaEcB9I7p8
	NIuEWKgi1tp7GB4kF1knhXNZKHXCgiClH0TSYOxPp1BJH1l3aBeV23NIhQULLYMSiGNrD4TSeuC
	8756GjvS0Vq6JtagRETOnJG6xmzZS46ihn4gBJeybd3Gy9BK6F1CZYoaiU2bO/NbqweeC9DLvtz
	Kus8Oxn8R5w45oHurg==
X-Received: by 2002:a05:600c:3f06:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4a35ac99b9dmr190327005e9.5.1793121453233;
        Tue, 27 Oct 2026 10:17:33 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:7887:1744:66c7:cbb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a930c5b6b5sm3015175e9.12.2026.10.27.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:17:32 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
	Jens Axboe <axboe@kernel.dk>
Cc: Rafael Antognolli <Rafael.Antognolli@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] block: sed-opal: reject invalid method status tokens
Date: Tue, 27 Oct 2026 19:17:30 +0200
Message-ID: <20261027171729.331186-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

response_status() uses response_get_u64() to read the method
status. The helper returns zero for an invalid type or unsupported
atom width, so malformed responses can be reported as successful.
Values such as 256 also become zero when truncated to u8.

Validate the status token before returning its value. Report
DTAERROR_NO_METHOD_STATUS for invalid tokens while preserving valid
status values and the end-session special case.

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 block/sed-opal.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 79b290d9458a9..1eb68ce33647b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1167,7 +1167,14 @@ static u8 response_status(const struct parsed_resp *resp)
 	if (!response_token_matches(tok, OPAL_ENDLIST))
 		return DTAERROR_NO_METHOD_STATUS;
 
-	return response_get_u64(resp, resp->num - 4);
+	tok = response_get_token(resp, resp->num - 4);
+	if (IS_ERR(tok) || tok->type != OPAL_DTA_TOKENID_UINT ||
+	    (tok->width != OPAL_WIDTH_TINY &&
+	     tok->width != OPAL_WIDTH_SHORT) ||
+	    tok->stored.u > U8_MAX)
+		return DTAERROR_NO_METHOD_STATUS;
+
+	return tok->stored.u;
 }
 
 /* Parses and checks for errors */

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

