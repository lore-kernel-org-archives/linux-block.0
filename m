Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB46D1A7;
	Tue, 14 May 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699942; cv=none; b=KMkDEsxWDczmrm4jG7epTgVKygSrQrDA0zABQo1SHHZ+/3MKuGaP89FoQbVDNs4ZrUuijJJ4kfQggJZhOCdkPZvidcCTArvR1nkHM3aZpA8dXM+cLhATfPJ4/gDDgDvk0wRe1RvQ9iVxA9b2Sco7gujzbCJ/HTl4ngCUOD8wX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699942; c=relaxed/simple;
	bh=JXROq6O+Dzwqo8N4KN5rAIu9jMja79JWlM4fwbIot2Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=U1G5vlOgzbOPtne+0y1YMeW7UvqEIfq2YSvK4T9DA7RZfpNne48XwsjVHUpFgMbsHLhjJvNgc4DlkpzJa88QEnTwLFat0R/YryInEgpbDfochJ9y0cnyadc402glAzYuC0FU19Q/lNqBFOae6vkm1dbIpdMdPzc+B0EwwZwszHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaEnBaLX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaEnBaLX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f08442b7bcso7637795ad.1;
        Tue, 14 May 2024 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715699941; x=1716304741; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4GeLlZbJrhRPA2trbEECF1V8nbw1OgWT9lb2M4w+JI=;
        b=KaEnBaLXl5ch0ktpAYSLvJXzpaYSlGdFS2PsPcYLEIkYI2YfNrf2Pr5G4mhP2L3kDx
         59tDL9oDs2fd1PJM+SVHuIbJ3Na6j/1fmnJ7Rber5DBz+QlPA02QqrBUU/1ot14s4TYS
         9a6vnKQFSaLBwx9gFN/rwLalWIkGj2QYOLVSakZ04x+24PWaVd/UKG9aHDT2QuzvnkZM
         6Qx7yb8jj8QSSgvQHAHhNuF8EnbD+ILoXQ+ea0ERkEI8zXxOH/O3EiNE9ZCdVb91DDS0
         KoQ7AwtxZ5F7JcvxzF/9B4fWV71Y/75J7yNQsshxRuhZ/5bEvvrRDhB/0vKSNj98Ihpu
         mjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715699941; x=1716304741;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4GeLlZbJrhRPA2trbEECF1V8nbw1OgWT9lb2M4w+JI=;
        b=N8+P/sQcrZGT0JPgLgpJaiZIAptF7IhJ0YWJE5aC6xBdE2qhcOrXr+gETMrJcU0r1T
         eiaYRCBDqqVBNwOsDBkvxcm4FKrCcx6cruuVrWVNJde+g3C9fVWFvMnj93wsnZBSqhll
         SfBT677VucW7k8acfFnteyySiOK8SeGU3/cEmfRfiWzpnN81JjHSu9O6xUlks7Y/jzPL
         sudmMGdaFQJYpB0+EikQF8Fq4sq6KYG+xH8JBxI1klXg/XO9BPP43WlkNCqka5pRvgUo
         QVZCCGeD0ydkwBf1RVpZ8WG8WRdGjNQIloB8gbpDo8QJKuASgdmpmblrwbk7ONurN1lc
         /W/g==
X-Forwarded-Encrypted: i=1; AJvYcCWAmqmt37ZqjjDX0hE+Zy+2omhhrNXTzJoeAwyfNILV0eZbjC/eE4b0RXdAxL/wmnzuweBxlogd475oN2Y04R6UOI4Kokgzye6anXEEqmvsbkWcNSYha6Go2AJ9t0G9UimzYE83j3Qskeo=
X-Gm-Message-State: AOJu0Yw6bIu7t4nnqUKMa6FUzSuHlEnwBDIOKH8MMz3k5I8sUFUktzY2
	Of47/hq/b9w7BePngPxyFzMJlut5g+KVcAO5JIwgUHMc4V5aGPqT
X-Google-Smtp-Source: AGHT+IFm8MKPfiycoB1goQ+HpoOa1qBMLv4wBkunNLhevPa2g5uhYi/Zl2t9RkAMvXiSpkPq5N58pA==
X-Received: by 2002:a17:902:d48d:b0:1ec:4cd7:6c7c with SMTP id d9443c01a7336-1ef43e2a1dcmr190159345ad.40.1715699940517;
        Tue, 14 May 2024 08:19:00 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c035dd9sm98689985ad.201.2024.05.14.08.18.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2024 08:19:00 -0700 (PDT)
From: Chun-Yi Lee <joeyli.kernel@gmail.com>
X-Google-Original-From: Chun-Yi Lee <jlee@suse.com>
To: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH v2] aoe: fix the potential use-after-free problem in more places
Date: Tue, 14 May 2024 23:18:54 +0800
Message-Id: <20240514151854.13066-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

For fixing CVE-2023-6270, f98364e92662 ("aoe: fix the potential
use-after-free problem in aoecmd_cfg_pkts") makes tx() do dev_put()
instead of doing in aoecmd_cfg_pkts(). It avoids that the tx() runs
into use-after-free.

But Nicolai Stange found more places in aoe have potential use-after-free
problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
packet to tx queue. So they should also use dev_hold() to increase the
refcnt of skb->dev.

This patch makes the above functions do dev_put() when the skb_clone()
returns NULL.

Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts")
Reported-by: Nicolai Stange <nstange@suse.com>
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---

v2:
- Improve patch description
    - Improved wording
    - Add oneline summary of the commit f98364e92662
- Used curly brackets in the if-else blocks.

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

