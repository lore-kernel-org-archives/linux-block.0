Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79552DAFA5
	for <linux-block@vger.kernel.org>; Wed,  1 Oct 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309952; cv=none; b=Qolp58oDPySTGmg96Brqn2Re5hRPlN0Ao6v4I5j67z6BFz+DNLE8jodLFb/5w09vnusfOd0c9v3SxdQ5x598SmQg+pqYJrweX5nWKsf2FovBTbfIBvh5uBwQhxWu8EQUnb7FKR76K3I/ChTcBkhJNLMURPGbscrAoyxnkXT5PiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309952; c=relaxed/simple;
	bh=pcPGB/dkNVmNUPRNo+DXzWGtd/nCSRGlepjtH4sr4w0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwNNj7/nDEAUDZPazkVBBhYGXemQbLYlkhZivtD6andB9vIe7wh/R5pZ9I5JoezCjjQwZh0nO323dJQZdiiXymUrko6QmOqAO/HkwLA6hHrHXesTu3GbTi7yJOxl4BvS2svPwfd687Y1MShh7kBMD1ZD5QuxOWfCsBZzyESuvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7+OTDyV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7+OTDyV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eceb38eb1so83044875ad.3
        for <linux-block@vger.kernel.org>; Wed, 01 Oct 2025 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759309950; x=1759914750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HpzxFyHZ2ZMy/pC4mNA7Ri5h9xiXLEXZ6WUw3XUfTw=;
        b=h7+OTDyVoIL24waxbOivVa5UWbsSaVD+23bqdi8RTSrGRXW44ut3wCCVknyNAQeqCg
         3MKTASkX5ZwN7PRx4xzsrjWSQ8t3DS9k/pFayibTsnvdYU1As/fyP1HUWd4sBf78EB44
         7obd5wiQgz6hyqmFGJvMyj5DwkC3j4tTHZlbRw63/p17eDjaCqYEFiicLxvzhB8T8a4y
         W6r6lrz53QGqOSn+6NkuZEgErCUhR/Xc0YegONeVTFOhLo8GwlgkrBOXAms+PEUc9P1n
         KGu/ZvWDBMVBJo5W4zo04yMwNAikxIXiLESaHogiJ6ppKsL7gmH3DQld+6InV77TIXhp
         iK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309950; x=1759914750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HpzxFyHZ2ZMy/pC4mNA7Ri5h9xiXLEXZ6WUw3XUfTw=;
        b=dj/4TPWMWtaT9eEnUrtZm3cOcSqrJLd5lZankCIaeRVY6kGHWnZwI//iD5c+mrWQUB
         uVe1EbRWE3ko0ZoTEkJAuaVQeqI3cgFIBDHBxrsnsmDEID/rqnxTtSlewV2R/kAZZcDq
         1/lJ3a4GzjYrpFpjOyofbCQol4ehWEokxnFjI7vnHp6iPonpvx0weWd/PnAPAji/LkrD
         EMbT9u9tyZLfcQe4/ExAOf351+fDkL29CNSRcYUt7FIZlFG/2vzA+pfm4dSrcjJRzF/q
         9Tkcj/UUI9AXhoyVvY33DjFpZO5q94cvoW3101WqmleYZO6vxHue+p7rH6fMUgGcsx01
         5RXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKkWOuUp4xCPxRRHtzVGSPV4FJzN6aNV1D1ZFiVyTz+AwxgcKEkU5wtW+0b1sm2LIH4zXonX2KtMWB0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPBNv+6b2GlKzJarzQvPQuXMcACEXJ6ICHuTbf81mcJhAQeWf
	qVO5KJOwBgSNbcc0M63eQR869LD5kBBkckyLdOb8M6Cmbp0rBP6qugRq
X-Gm-Gg: ASbGncvr0twQCgAJi7i95BCZPnWfvLR++0TgTXRDWSVlVMTHejGg9LAD2pNaBC0YVRf
	eSlkNF+cUxjSL3CmgaGX+BrBU+mPPtQ3Z9ye0AhVmW48dE3BBbEIrSrsvXzZX+e6jdwEpLjg/03
	SB6ILgrQSzk7qGNQexoNFM74eOZOjh+KvxA/KcMtalOrt0XeaS5owL24qm+b6CSKfwPPXhCAIAI
	s9yY5EmIxdU0VQkuBYKCKA9Ga9tF/7HQj38x+zJcHvoTateHWd1EzuNvmz7k44mFMK7v1gzn03d
	f1/MxjufZ2rfsJN7JyO/64DwuYRCmi9CI2dWW0lZN2iQ/DaCvc6rlgSbHSMx+L+73D4BJNsc/cs
	hbMy15ALTpSmrojZ66aIPl88yVyMK3NezP3EOOtGQ7Q/XMO7/1zuh7HHkq19dHG04/lw8cWfDmw
	==
X-Google-Smtp-Source: AGHT+IFhUZ/mGMyT3exSWSnoljUD1zZiQFnygIrQDjToqp+r+F99aKI9B8d5mZOODf5Cfr3g259Sdw==
X-Received: by 2002:a17:902:ce0f:b0:27e:f16f:618b with SMTP id d9443c01a7336-28e7f2a6437mr33385785ad.24.1759309950202;
        Wed, 01 Oct 2025 02:12:30 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-281fd60835bsm120299255ad.19.2025.10.01.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:12:29 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: bhanuseshukumar@gmail.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] block: Fix typo in doc comments
Date: Wed,  1 Oct 2025 14:42:20 +0530
Message-Id: <20251001091220.46343-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

heirarchy => hierarchy

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: No functionality change is intended.
 block/blk-iolatency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2f8fdecdd7a9..f2e65fad71da 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -34,7 +34,7 @@
  * throttle "unloved", but nobody else.
  *
  * In this example "fast", "slow", and "normal" will be the only groups actually
- * accounting their io latencies.  We have to walk up the heirarchy to the root
+ * accounting their io latencies.  We have to walk up the hierarchy to the root
  * on every submit and complete so we can do the appropriate stat recording and
  * adjust the queue depth of ourselves if needed.
  *
-- 
2.34.1

