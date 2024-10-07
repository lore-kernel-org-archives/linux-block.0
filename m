Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E418BB91;
	Mon,  7 Oct 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299687; cv=none; b=ppJXVkPUQNCEZ0zqUbweG2QZ4Mne6HCKgXHEbMLEKXVALISV7yPNCtTmKtHCQvJ2mJdRTrdYPQa3CFYX4szSWXK6kENZ6USJcnRhDoDanMIUmAqeZdkemlrLFpyT4lJOqs2EeKd48ivoGZ+wJ6IPrNp1USrxxolbZ/1QtmTxriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299687; c=relaxed/simple;
	bh=t89V9ZIf+7EC7oAwDnLC96q96etjRCywu8RGQ/ZjT0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YolnMTf/eLuWuCL8JSQi5bImNmIxAk5f9Oo5N+MfFeTzjCdDrVw0+8nYuF0wZe+QDttyBdSyavS5zPjOISocyV7lzz03WPkfnVJco1Y/btI2GXMIWhixboeJ9qwvoFsCgv0+GgFqnT6nbt3KVhEBIAyzGqt5dQqowQJUcN51s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnyl5vec; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnyl5vec"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b95359440so35562495ad.0;
        Mon, 07 Oct 2024 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299685; x=1728904485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBgdKVkwRlU+zQtQRnhA3xxf+pC+TcZmWUow2x5/NV0=;
        b=Rnyl5vecmdsje3A86nKl+A/gv3jiKdGJJQ6JoYCLDWyiOgVrhbbMO9cb8NWLYkIQ9Q
         xSFDqLJVzCnzeb3dV/dus7SF7PRE2TMjwAoPRQQK49sWTCfCYjUt7YNB3u+S1ebNrG84
         RBq1DXbpCH3H5u/pUGruRF/dB1iQncARl3z8XHxdpAaF+4KYcxHsVxuf57B9ILfPLMDI
         f84A0mlFv3qakUAAN+iurQ+MjA+O+c7L3q6TN9v4MJksg+4RR9QxH2xtOdxWF+PnlhUT
         PfyitjEPQhoCzYG92/9kQgwIeGFOBr1+xQbofKA1XFGZLNxMLa2BRjwcMVQ3z1FOVWLe
         bbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299685; x=1728904485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBgdKVkwRlU+zQtQRnhA3xxf+pC+TcZmWUow2x5/NV0=;
        b=qAuHqOFKtJYn8UaaRAGcRqWe6q/bUOyUSZroyIiuyBVOyAS80w27K/C24Xswl1ysfr
         r/5vbe9D9JQCKuHBlAQVmWvbS8lKP9Wq9BVFII08vd10my+xgnCj7RQuyt8FZ5pt9cSA
         HpkLaX3qEHa2QhuGHNEc3G0br7zJeNrE7QAERAnQxJoF/GZAuxRg8oafxTTURGLwuRMD
         s9QNHuaUAhGqITlLC9Sh/uZpX3Z+3+KaO3+aTlKvY5+hNRjK5TqEGkDodcVf8l5Nke8a
         Pa4/r/H17SsAMknlutGRxJD6ZYVpwIsr1FI9CCD203xDD6gjQixvZcoiAqmjm7Oi9Br8
         +U2A==
X-Forwarded-Encrypted: i=1; AJvYcCW2Wec/qn6iFKytAJtfMCcuySmB28TnIrUpNjZ70hiCLVxS+Ntyw+1v8OBsXDPPurootcKOazwZEmFyLyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yRStEFB8zkSPMyfU3Y6zhNfQ1F1lcPysynZRoKNDV3Nvy5j0
	Brtc77tUHYKV32Aa0MLWm7YKSaG2n+IgLOEx0kpsUudZ8NX5ujP8
X-Google-Smtp-Source: AGHT+IHUEw8puB2+YlhAA+4KIyDpWwk8Yf6kgV8F/vPUiA8oY+I7hsx/GNkMDDfeYAOj1koUkXK1Fg==
X-Received: by 2002:a17:902:cf08:b0:20b:bf5a:e0 with SMTP id d9443c01a7336-20bff073a1bmr129799515ad.55.1728299684873;
        Mon, 07 Oct 2024 04:14:44 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4040:d83:9ed5:69f6:9499:16b2:23e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13968e35sm37711165ad.235.2024.10.07.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:14:44 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: [PATCH V2] block: Fix elevator_get_default() to check for null q->tag_set
Date: Mon,  7 Oct 2024 16:44:16 +0530
Message-Id: <20241007111416.13814-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004123922.35834-1-surajsonawane0215@gmail.com>
References: <20241004123922.35834-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix error "block/elevator.c:569 elevator_get_default() error:
we previously assumed 'q->tag_set' could be null (see line 565)".
Since 'q->tag_set' cannot be NULL for blk-mq queues,
remove the unnecessary check in both `elevator_get_default`
and `elv_support_iosched`. This simplifies the logic and
ensures correct assumptions about 'q->tag_set' in blk-mq queues.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
V1 -> V2:
- Remove unnecessary `q->tag_set` check in `elv_support_iosched` function.
- Remove `q->tag_set` check because blk-mq queues always have a valid tag set.

 block/elevator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 4122026b1..60497e3b2 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
 static inline bool elv_support_iosched(struct request_queue *q)
 {
 	if (!queue_is_mq(q) ||
-	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
+	    (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
@@ -562,7 +562,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
-	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return NULL;
 
 	if (q->nr_hw_queues != 1 &&
-- 
2.34.1

