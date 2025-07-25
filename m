Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938142E36EC;
	Fri, 25 Jul 2025 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416890; cv=none; b=U1Flvo2uTBKJS0Ee1R7GrSZTiQ4iLqhDTdAUMvlu8aT5R2QhUGyvv50hhqC+bSLqyU19hfQLEgAxCwLHaxHb/CK26/lvhF8IabMIbyCL7mv0GkUPlm2A+j6SwJHy7OBoSjHitR4cwIcFUEcC9bTcKX/PBR1RZbhXqPN19sA8Blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416890; c=relaxed/simple;
	bh=e8/Rf2Rl3emQlwdrh/KtEghILOYRF8MMZLhlxdM5CpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esl3ybwHUWnxAKsgqfaoOvOBpXGxFaMmlG2p8ZojVTtkFb5DJn8tzEfOLzro66aIG0lNmNQlUrOE6SA5w9el6OhuhWmdTCqna7IfGFvF5XiEx5SKsBJRcJDp333JM/kOOGxMVAOZ4ZMEYirDLdfSmKQ0V7fgQtTUTdViUTSUid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV9oOBK/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV9oOBK/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso1994809a12.1;
        Thu, 24 Jul 2025 21:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416889; x=1754021689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga9XogkEtrsX1yOSuQL9P2/w4go9hGhVkrA25lcIBtg=;
        b=PV9oOBK/ikd68YjwVxyO0pUYEQMdV4Nm+0QDxzRAumZwTpy12d1o/wXE9TzMPsMGAP
         p1e7UsDLbp8VZk2vfZjHx8pmuOHGpGihoI+yqV5BCE+lRKLKEJrjZ3Lsl55clKG2JEtp
         7TCKGxqYdeoY6KoL07u/imAI+AR876OeNDyFooDfgC5ifH2qRkfXOVE2tfB2TdYlQsGY
         yMmvC2h+G1RQt5gB5rzXkn7fN28tEaQ68Rg0kX9/UT8ORhVlF3HNVpo+dUZEopd+OIbD
         ORVyFSs9JpVOASKOrJyCllvWUPtm7SIUfBAYYbaSZmwdV3SuT08z+kDYIWn10Zps4yLy
         xR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416889; x=1754021689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ga9XogkEtrsX1yOSuQL9P2/w4go9hGhVkrA25lcIBtg=;
        b=YBHyz9KwXTRq1j0n/s+GDyUufe4iVtb8D26wX/x6vNOtpGr3nF62RekmXZq/BhLRkG
         ReVvKfiR2sqZ3nSbEAnIQajHiu9/Tuh+nWom5EU+xxS1dVMNPbUpseBcpPY8PuR4cPRt
         fWeeX7xJotbstCO+ittO96Qdd9wnTDUuoLUuJJeKZg25DD5VnJnsb74xZDRF8PwgjRs3
         1LfU/xmCaohpQqOrYpUv3yyA5H+v6rUitCtUvU4xRqZSIuKLmQTfSRN1+FoW8Qeh9+fk
         aq87vgFzzF/cSf90tsaxYFp2JPjkz8XDVe6mu6OgkYgW5E1a4yIgbyHUzUpJaJgHnk/Z
         Bukw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9Oc//5+3uVH7RtyxjoK+TPP+hDFID2YkRgjNCnuwNJijI7zjQ8Im6ygwnd9wkHNpVRjDmGrUjF4A6Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFG5Ypc8vJna6eFAmgVM5uwpk9Wq+YAP1HLwigytQaSpRJIEN
	28lhu7yJUWWunv7QEg11XWmq5dJQ+/vzfRsRNTECHgMUfBsd3K+ANrq1
X-Gm-Gg: ASbGncuiVQSlC3zQkhTOMla/ox1iZBMWul0QJgKxKJxKdO7FBy3oY4cHvmDUfnneEwK
	udTs4IWiaCLmkbECFeNh8qqEdtBdeM5eSZU/tEjuLp/mJrfBeCiYZC67LXcn/prRh4CRyyGZbUx
	x36yg+pwHMhX3uZUg23XF8M5nl8z+W2BRsQT1f0srgGRGLYy0c5lHZtKVfSHd5nYohir7wG+kbK
	GcKl/VO6stKHkyqXFS0VU5HZZC4qQlRuJYZFK+kvvFn1FE/9LrRbfROQd/LJn24hMSk0w6SC7Az
	ZG9nUpzDsjsNPmCbQAkQquSZGjua7T6ZxkfWAlb5+s+SX2Q4J+N49aZVKTSlcK0bXnvdUxv9Wb0
	9GQpBs6fNdZr3UE26DiZEUmZZyrcND+Oo4xkF8tZs2H61706u4ZReK2lV
X-Google-Smtp-Source: AGHT+IGQsIshaNOvb5wn3SO1/Wor+Pe19TzgorjyOEgtGAsivFB/Mtn3V76pv/jmhjjTb2AafczW7g==
X-Received: by 2002:a05:6a20:94c8:b0:21f:5324:340 with SMTP id adf61e73a8af0-23d701ebc8dmr561882637.41.1753416888810;
        Thu, 24 Jul 2025 21:14:48 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761d52fe8cbsm2663916b3a.111.2025.07.24.21.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 21:14:48 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/block/drbd: Fix typo 'aquire' -> 'acquire'
Date: Fri, 25 Jul 2025 00:14:50 -0400
Message-ID: <20250725041450.73625-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d15826f6e..4012d668a 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1326,7 +1326,7 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 	spin_lock_irq(&resource->req_lock);
 	if (rw == WRITE) {
 		/* This may temporarily give up the req_lock,
-		 * but will re-aquire it before it returns here.
+		 * but will re-acquire it before it returns here.
 		 * Needs to be before the check on drbd_suspended() */
 		complete_conflicting_writes(req);
 		/* no more giving up req_lock from now on! */
-- 
2.50.1

