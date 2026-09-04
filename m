Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB5368974
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521477; cv=none; b=rxUf0qdnYDEcCE/uv5OLumhIdD9stkDL0YvnXVUFinQoN9Gv6CxzykDkuIp5ASi02HxRdOiFaHN9obnzVoETwnCARRMo8ksJy6A9gBAzkm4IvuB4H1rC3I9BZz0dWLAPIcfdfG/ZQLn2a+mvdZ1eDOZmI5KSWELi2Zkm1ekgLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521477; c=relaxed/simple;
	bh=VrjZr0QY65ey/5ruqoMQdt4mmr1ftcLtXPhGdI3pIbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpsAPYHW0N/PWIpvOOqO3+gKjS2bcrKtuPyjZfz7ysjGkX6BxKhNEwiprK9ty2fA/QZHUuHqsKXPnYpho+qucwxGuG0xHcqzQM/OELJ3y1ydtHXzyV9MiI1STVwAEMaJ95BKaF/hY7EuOuKeWpSTf9TQa2NEpzuBBaH6HXSAdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/ppeM3x; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/ppeM3x"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f48c750afcso820594a34.0
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521474; x=1789126274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvSqaX7ltGau4iZCiWuSB8nu2EopR8JjsAseFdLGvA8=;
        b=I/ppeM3xvpXqamcCQ4V3l/DWRpxWVNlnyw8t9J6Rf0YQiUaITWZWqVLDgYtUBU80sG
         HIp/WQwwkm71t03HoCwkFwlCnvf12+xsMeP3Y+K4kCnMJ4qiUvZ0LUPZJ4nexlyrJ+OB
         zrs0z4YRv03OOq2dwxNRX8ty/ZcbrKjAj3TKXbQsa9aU7Kw5HWLJR8kboqdTKtJT6cue
         FeLd5xhnlCm2/Uy8+TLKZY4NIcTQ3DuoAgEYX0bm7LlHnTGo515sqhHnU9/gHTzBKibf
         vqpD9Z3xxU332FtDAQsEDmTZKTBH9JEUtDmLj6iqC0pHL/1CJTDx0zBXaVl8Yx3E1qqa
         B53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521474; x=1789126274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nvSqaX7ltGau4iZCiWuSB8nu2EopR8JjsAseFdLGvA8=;
        b=DffOdOIkk6vgrFkaNAxrfkgypWduP1nVbO9HNAzk5nKLhWa1zDFh4XgTVM3szDEgFt
         EwEqJ7KBYl3BsQqSlcF7BlI9eqjTMIYTzbw+P6FcU7wCJxBNMllgDrhpi6c93vJ7c03M
         2TQd9Fj6iPdS7hol9lk8JDjphEmeI33K+WdKx2Lh3/VuW1HHSDuTJh0Tqf43y/P/Njvk
         ufQntp2JsZ+N8ZspAlJN2WV65Ow7WhCNsY4yWdHrWPDIJ0pMqUnMuXipwUgJWxHtdpCg
         1ep5MJsx5UihgmxzT6LMKZ6tQXgrJg7zVhVl+qDgxDxxVPdl6oBSr88oVL5PJmYpe3f4
         euiA==
X-Forwarded-Encrypted: i=1; AKwUvBwE6SjMJvTHhkWKZhgcuEWwnp3hYqx2LpMAf10ciW76O+L+UMUBIEJpm5lvZHM+l2MsNwrNsBBoCXdOTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nGf2T8mwxkTu3N2poWJhZe7KfcHZXA/vVrKDXdAh/VUWHapU81
	/lGelRP3HrVDQ4/3wEavA0YAm2lqXIyPye50Cp5Vks8aDr/QX7meUrlN
X-Gm-Gg: AYBFou0JIiQKXPeacsCLls7Pezjp7J5+3QzH6Ia1JjqBAxV0eW/R09eHZfgRB1ncV8x
	uKWRQ+5hI/D/HkmUD1t4FFtIw0Uez72aoQPLLk5tFQpXov/y3OLZ3WcTzK4tAxpJ47WGhc/y4NI
	Kz11iHdBsI+Q2mwhmDM+eL+B201Pieop2KPtxxV8VDWWf6XiFftZOyxiCAEsZJphBOiSFgUtRJp
	hpbHsdX4Hvf075jpcxxg7yBuEkvHAMwaIVCt2kucYgCAf87guuYUN1OhQQh3utyZKJfRLFAlJdt
	mQCle1Y2ywQqOwkIQ6c2EgClrI/vxgtJO/AsY0YGMeTt2aYv7Y5TDQ9SqMjIYNUWHVnE1/ISAUK
	1p240DkXzKpTQLRsvMcg6U9235g8IfKo9aEwgiosdKM/V+chERKNHpKIMuzRLngmtioaOSKq8Pr
	SotUcWm/lZyP9jWNDp/lZMV5vQEd4Ps0fPdSLDgPn56spV63tyLKUqlwdd05tquOxcjzDn3q0df
	lKwmWvKiJYTojs=
X-Received: by 2002:a05:6820:810c:b0:6b3:f4b8:bb86 with SMTP id 006d021491bc7-6b6fbcd0911mr3941939eaf.22.1788521474327;
        Fri, 04 Sep 2026 04:31:14 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm6039922c88.13.2026.09.04.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:31:14 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix repeated word 'is' in comment
Date: Fri,  4 Sep 2026 17:01:00 +0530
Message-ID: <20260904113103.10805-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904113103.10805-1-hemanth.selam@gmail.com>
References: <20260904113103.10805-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'is', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 98abd2351d6d..679b19e6927a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1905,7 +1905,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		int was_io_error = 0;
 		/* corresponding get_ldev was in _drbd_set_state, to serialize
 		 * our cleanup here with the transition to D_DISKLESS.
-		 * But is is still not save to dreference ldev here, since
+		 * But is still not save to dreference ldev here, since
 		 * we might come from an failed Attach before ldev was set. */
 		if (device->ldev) {
 			rcu_read_lock();
-- 
2.48.1

