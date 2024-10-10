Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17721CDA31;
	Thu, 10 Oct 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569730; cv=none; b=At4QCzXeyTHT+/sHKDzAUeNPNw2wz3SwqFwcndOnTooxBVtzK/i9eqS3LFO040XToj1KyTiqZfVUE6vp8UFvzWkcry1KSlu10nV3ZfKi2s6JfvDiZ4ZC14OOSOiXisJWvm2LI0VnK36VP+TFyEjfjNSlG//vyySPyEc1uJbtRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569730; c=relaxed/simple;
	bh=0O3qLIwabkfJjg7vjJvJhhihy5pIpp9LHtHoeUvNVS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMmU38pOLZiDtCxb50LK8F++o21tPK27rCqAa1q9lvx9l9l61dJHlMAE22c84rv1/24SybmWAbCEVtuv3MQVvGdqI2ROOEL2E4lAipmlAVGv5Wfga679Pjmj/lsB+bmKf0Tga0VNFXdULS6hTmYHR7e2zVsEtWC6o/oAybp97YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1210404f8f.1;
        Thu, 10 Oct 2024 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569727; x=1729174527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiL/UILgNXMtanx2hI22VKf1tWURitn+rwodmW8oVeU=;
        b=rdotPadDRG0hvtDmwu1t+xSk6dTTPsolr0sRZUeDxx+jbVIHr1zuRv/TCu/4RGCjbe
         LGu/Z1n+koK/Kpm/KKfoVZvGX+4Du88GEAU46qiG45jzSgNIGptmDPKpf91dgfwaLWp1
         q6cGjYjyT+bUE1POdQpuaLrgIgUsUFR38BcLZxUvlzBQCi/tJIbn5GwGTfS9EGoro6eR
         inc9uryGLcOJiAefW3BuJ4dhJjnGqvCRGYKlgHDgOWysyRPjwNmofkRE9YWFxc1B7E8w
         1pBYcvgudmmFZCXY+R+UowGyk0vkkSVSwnh/Dm9KrYYpVT9HdzkIKpgntgsHl39DS+RI
         m4YA==
X-Forwarded-Encrypted: i=1; AJvYcCX4S3V7vmKcDLyCNu714PQeR59/BGxo3mnnGIbAE+IyIDsfQnOWL2a/h4vIVibn4S3VGkRUmwPe/k+QRw==@vger.kernel.org, AJvYcCXpnGZWKqCw+WYMi0784X01eiaFcNy/93InDEqbAhA+RsHzHbB4Ty4+CbjEGV4YuXjnM21oJedRJyr5HImD@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPmUDAgMDLR0zsVdB0lxCZnIKLdaRsOlIKLgMkeHBHWMHScXt
	puNxlezVzTN8Y2N5v6MlUyeywOpayn1JQn8U1Kd6hEXIIDeqgciQ
X-Google-Smtp-Source: AGHT+IGzurF4FC/yFEYCrr98z0y75xH4NL1ZPIsqQ6Lqas43ijfGyeOFOPVsQROENM9KrCsBBa6Csw==
X-Received: by 2002:a05:6000:1251:b0:374:c1ea:2d40 with SMTP id ffacd0b85a97d-37d4815fa28mr3143722f8f.1.1728569726842;
        Thu, 10 Oct 2024 07:15:26 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf43da8sm50265135e9.11.2024.10.10.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:15:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel-team@meta.com,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] elevator: do not request_module if elevator exists
Date: Thu, 10 Oct 2024 07:15:08 -0700
Message-ID: <20241010141509.4028059-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever an I/O elevator is changed, the system attempts to load a
module for the new elevator. This occurs regardless of whether the
elevator is already loaded or built directly into the kernel. This
behavior introduces unnecessary overhead and potential issues.

This makes the operation slower, and more error-prone. For instance,
making the problem fixed by [1] visible for users that doesn't even rely
on modules being available through modules.

Do not try to load the ioscheduler if it is already visible.

This change brings two main benefits: it improves the performance of
elevator changes, and it reduces the likelihood of errors occurring
during this process.

[1] Commit e3accac1a976 ("block: Fix elv_iosched_local_module handling of "none" scheduler")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 block/elevator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 4122026b11f1..1904e217505a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -709,13 +709,16 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
 			    size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
+	const char *name;
 
 	if (!elv_support_iosched(disk->queue))
 		return -EOPNOTSUPP;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
+	name = strstrip(elevator_name);
 
-	request_module("%s-iosched", strstrip(elevator_name));
+	if (!__elevator_find(name))
+		request_module("%s-iosched", name);
 
 	return 0;
 }
-- 
2.43.5

