Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808E1CB337;
	Mon, 10 Feb 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186013; cv=none; b=C0f6S+iIRxQdgWuqmuvdvV3i0O3KOEwRnnmN+zUPDitwJLNFifDskRvPZprIa5Ats2hy57q7nW0dc7815HZHLU8XuCITosMUQycT0sFr6F3OydztIK8egkICGDRihftox5JVZvAg0qipHc5VOvPhQQllTdTWKSCeRcksU+ynKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186013; c=relaxed/simple;
	bh=2zJ77jcUVTjeAXAGAxzJaL/gPkHMt5mWPCza1IUne8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVeRotJ/5jGSisF1VIlziKk7T07WpRXgPzZyVLwk/4cyA77SCToOYVBgMJou0FiQGX8z20Vwzrz954ugD148RavT0rm6xBbHbq2LY/sK3JNE6CckIldIY0HYZnkEfYxuVtkSZ7TeSup0yzTR6/6twZ3pSxqmJwRGYz1HcllCPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUFDZAT3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUFDZAT3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361f664af5so47312795e9.1;
        Mon, 10 Feb 2025 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739186010; x=1739790810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSdJQgcp2y7iHjwit0HOOl9HKbnE8QQbbuMwDImG398=;
        b=eUFDZAT3xzlqz88/IIBLKL/zc5StcsBcgmiNm5D305ZPjdyfOUXDOT9a1WMyqTsOEc
         UQusRf8VKMu0DU7cwcP1KeEMpam0saD0mvZJtqhK4vmMilZv+kAbM5KnV0UE2c0EgGGn
         FgmW52AzcFKrYEfGpkbXKzRxxSiBxmMIBm3xW7tx0aWr9niQlxqc83hlwoxukh6a12kZ
         RdKynkX5Jsl/ZA760Lh6l59eCn4tI0Wm/fz4J7TO/OCwP0vaGlQWaFpO61+Qa/l2iOVU
         JxTm9DAXRagSdBx4CzEY7SWmAR4jIy6rw5JeyCmkGzMKrVjzAPjSRIbzEi5bDCYXInqL
         ROOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739186010; x=1739790810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSdJQgcp2y7iHjwit0HOOl9HKbnE8QQbbuMwDImG398=;
        b=m5hMzFGWT/pxAF00wR4HwrkDxqvhYQZ7alpPcE72/Go2tEUX1jSKt3typYK5xiLYTr
         vRTB+I01/cxo0jubIoPbym9N4H34rhX+BUYxUJ0R/05w/K3Nyb47AF4ERIKicdnPMg2m
         YbCht2lefPECNfIaflHQjPaG21Y2yMcAP/RdK2fy632y7yVrYeNCUt1cxonAGfhRYMXg
         /kdSDkg+HcOfxVt7X4GC1E9TtZJfilzSz0WivHD4BFrpX8FeyV2yQad/HC4avUeLJx8Q
         5GuAGRjpMH+U8G/p+BhkosmRha43k1rhaI8b0ruhNo6gzTcs1hw0MLaqJeogATzHIWZR
         JbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNd91y97fw7bhrLVjnzsgvoZ4jsuP/r9NG4/HiXyoodQfgElgYdKePfb2E9O/CCp7da1K9dUClUNC29SpV@vger.kernel.org, AJvYcCWFVGT4kupeiWLrO0YBo9hBGOfYvTeu+I4tLHMTQJ7bB8+w2kHxI0Am0LTTIRcXQjkBKGYAvAzet90vCj/Xm7g=@vger.kernel.org, AJvYcCXFbagOX6WqnlUcqawqZPrLueRwLOWE0RaEtzwrNWdSrs+9CYMOFqKfVc1+LMDx3JGtrs8mDP2Hl523ExE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIP9O4s/7E6qsBCndUiulZZswF5jlwZvXyjrYRpU6SPe7gLFjZ
	gajQ4CyAjBAw9BfP9UqKoUpPsIqALMJe/UHIek6SF+5O4Zb8xmg7
X-Gm-Gg: ASbGnctU2K9PHw8UC0mEkmRorkzcciSU8nygCXyl5swbfLsUmdl8WRLIBG4W59oYHNA
	Hg+LjaTsBZVRvTmjr83ED5SOqcqXRI842Yxh/ApeuZ28WBZVtKShoBptt++H6hzGDsYmi5CDnfh
	sBJs8jmP8ecwvHwVJZNSQqe666i0t7Xn9HRxSRUeve4LOUSUBmod+qC5ideL4SoChG3XixzCpGO
	lbFzxeAieDaWJaI/ABRJcxm5jfyFFlgMUFMqCyJhECPysw14cjwgC+nqVabzssZh2WNKcp0qGH4
	TURZB1YuTW1u
X-Google-Smtp-Source: AGHT+IFaU2YoCTpHdtd/tojrjTH8ALsB9SNLM2ym1wrDznm+SKutFiqojoOwPae3ZpHcm6k0gVP0mA==
X-Received: by 2002:a05:600c:468c:b0:435:23c:e23e with SMTP id 5b1f17b1804b1-4392498a1eemr107768405e9.12.1739186009633;
        Mon, 10 Feb 2025 03:13:29 -0800 (PST)
Received: from void.void ([141.226.169.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc672b55bsm10260635f8f.79.2025.02.10.03.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:13:29 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] drbd: Fix typo in error directive
Date: Mon, 10 Feb 2025 13:13:05 +0200
Message-ID: <20250210111324.29407-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.268.g9520f7d998
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in error directive:
 - endianess -> endianness

Fix it via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index cbaeb8018dbf..89d7c828eb59 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -106,7 +106,7 @@ union drbd_dev_state {
 		unsigned peer:2 ;   /* 3/4	 primary/secondary/unknown */
 		unsigned role:2 ;   /* 3/4	 primary/secondary/unknown */
 #else
-# error "this endianess is not supported"
+# error "this endianness is not supported"
 #endif
 	};
 	unsigned int i;
-- 
2.48.1.268.g9520f7d998

