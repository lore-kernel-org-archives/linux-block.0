Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699221B7FD;
	Tue, 14 May 2024 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715665343; cv=none; b=A3wLq12pEKpw0mtPxihCkwsaZn4yMrRxqXkA4pjwj5qXj+0Crv8OPNvhp1Nj5WDwLQ+KjbXh2WVSl6Nxh9o15YwRdYGhmP1LGPjoVz0HmZ/bLS5wIXa0Gq2O0QN1hXhn4TuU8RTzceQyv+gbWkwglcWqcnSf0tXawNGxdRPIlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715665343; c=relaxed/simple;
	bh=ozr7xl62K7WbuarAMLArxLdpqPBL/FThgfzdQev4Djg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NueMGxMWGqaCj+5+1pGe90DeYr3Z3z6w8g4qKSSAJs8gFyPNIxEXDmWLe7mJtKcO+80sOZClM6sXXaQWX+BP1m6KXSUtbA92+6/j0SPWorx2A01SwnciI4g499r5thca4oKrNQ83ZdcUKT9EImIkdEZM4aqzKeHU+yxe4bQfRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaI0RDxJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaI0RDxJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so38660115ad.1;
        Mon, 13 May 2024 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715665342; x=1716270142; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL6hZzpsePBF8+b5Yat6PN6BeezEI8EqZPW0XQO1tBQ=;
        b=XaI0RDxJqjocb/iQ3XBV9cYoXGFKCbiZcgAWT8kehVNiQ8dVOteX3WG7wp7bej3Clv
         b873A3A/wdagVcbfoobCOuK4qOK2xgSwYCXbmH2yr76OiXk0bfJoNfxq4vK1BvWgvgzt
         96T9Euarp/jtoVkI5wp6A7CtKQk+Fvm0rEfJdKdRI1CZ2clV+qHxyr5A5ypnhwoEJI7b
         nEBri4UkLlHGMbB2uEQ+dBIzzlmjSeaEmVchSzhXcI2copvdUEPNtRc0aOOT26sRwN+G
         badXez2LbAb23rBiAWnQ9h4ESuJOvAvBeOdcnp0iYhSEh5y1ItN1/hRQi5ssooUAj9nd
         XgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715665342; x=1716270142;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL6hZzpsePBF8+b5Yat6PN6BeezEI8EqZPW0XQO1tBQ=;
        b=TcHVU27iYTw8xpEjT9FQHMrgvDZJov0ByHUYyTCDR5WA2cD0ohEK8HSLG4YqgzcJjW
         lx4nAp87si0vB9VR1ye+VsopRLBZjIi21JwH5mXbATOWvpeHzD3+tFt6OCGvLDGEhndw
         eyIc4jwN94MpXG558O8fPRmB4YiK2R3jDyfzSun8hzOn/N+rnN016ryETKFa4FdIHVQp
         PE9lUstR59OqwoTx5kH88RENKKdRlIEmVoCGHS6AoyiRJ1T8qJaJnHWaGQHRAfC1gLYo
         gXx4tBBUxny6XvlF7o94od3lXh0S69P6K5mEbIGm3pejA1Yw0m4/GdiNJW6vRh+fhnxW
         Sosw==
X-Forwarded-Encrypted: i=1; AJvYcCVkqZ5QWOGbYB0SSI7gjCnndjsaGf4fra8yFYX4JnTniYO4CKOZh0hecqHjoFh+CLkEOoCPoIIzdwNH6AvlLQPEBJheFSXezJ2NnptRiWczbsLSD7ELMe5KtSwmwhni8kQU/k2kv6dGfG0=
X-Gm-Message-State: AOJu0YxlgiqSFrozP4jl4m8uiAk76K1Tr4VfJUNyaNqzcj5OcAeI37sh
	KaVop/nXaNf0zEbea6HesnvBZY6cHVQQovFotSHg3oYCJ0tqxI+l
X-Google-Smtp-Source: AGHT+IEsvha7h9nRTcCLJvkLcGy21PI2oRDl8Ay3px1r4qUrnFrH/FZwKdz1JivQkJMfamFfFHFoDQ==
X-Received: by 2002:a17:902:e5cb:b0:1eb:63d9:8d85 with SMTP id d9443c01a7336-1ef43d2e27bmr151384955ad.14.1715665341601;
        Mon, 13 May 2024 22:42:21 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c160a1esm89202935ad.279.2024.05.13.22.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 22:42:21 -0700 (PDT)
From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH] aoe: fix the potential use-after-free problem in more places
Date: Tue, 14 May 2024 13:42:14 +0800
Message-Id: <20240514054214.924-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

From: Chun-Yi Lee <jlee@suse.com>

For fixing CVE-2023-6270, f98364e92662 ("aoe: fix the potential
use-after-free problem in aoecmd_cfg_pkts") make tx() do dev_put()
instead of doing in aoecmd_cfg_pkts(). It avoids that the tx() runs
into use-after-free.

But Nicolai Stange found more places in aoe have potential use-after-free
problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
packet to tx queue. So they should also use dev_hold() to increase the
refcnt of skb->dev.

This patch adds dev_hold() to those functions and also uses dev_put()
when the skb_clone() returns NULL.

v2:
- Base on submitting-patches.rst document to improve patch description.
- Used curly brackets in the if-else blocks.

Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts")
Reported-by: Nicolai Stange <nstange@suse.com>
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 drivers/block/aoe/aoecmd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index cc9077b588d7..d1f4ddc57645 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -361,6 +361,7 @@ ata_rw_frameinit(struct frame *f)
 	}
 
 	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 }
 
@@ -401,6 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
+	} else {
+		dev_put(f->t->ifp->nd);
 	}
 	return 1;
 }
@@ -483,10 +486,13 @@ resend(struct aoedev *d, struct frame *f)
 	memcpy(h->dst, t->addr, sizeof h->dst);
 	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 	skb = skb_clone(skb, GFP_ATOMIC);
-	if (skb == NULL)
+	if (skb == NULL) {
+		dev_put(t->ifp->nd);
 		return;
+	}
 	f->sent = ktime_get();
 	__skb_queue_head_init(&queue);
 	__skb_queue_tail(&queue, skb);
@@ -617,6 +623,8 @@ probe(struct aoetgt *t)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
+	} else {
+		dev_put(f->t->ifp->nd);
 	}
 }
 
@@ -1395,6 +1403,7 @@ aoecmd_ata_id(struct aoedev *d)
 	ah->cmdstat = ATA_CMD_ID_ATA;
 	ah->lba3 = 0xa0;
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 
 	d->rttavg = RTTAVG_INIT;
@@ -1404,6 +1413,8 @@ aoecmd_ata_id(struct aoedev *d)
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (skb)
 		f->sent = ktime_get();
+	else
+		dev_put(t->ifp->nd);
 
 	return skb;
 }
-- 
2.35.3

