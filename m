Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F4383B1;
	Mon, 24 Jun 2024 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211465; cv=none; b=WgcktlYm4BLO+p5lF4M7Y31WGWM+qKRresHTj+0sOU8CXjJRgavpVOLPEV1cBUsENxcRJNiezNt8pYpBKimeeavclcuhx+RNMTkh6fWSCrLvhlyVZZ+Q65xqE+RGM4elC3l5ILW7aia31I7VA1oUygcgj11ScewAgb9dyNVFvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211465; c=relaxed/simple;
	bh=dt/WYvtEBcI/9XUJ+2dYNtW7n1MtjR28hx4ZzaIMLKU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=In4rLVLwetAj3Z8x91niKlIof/mM4EJHAKVl3FukcWdXDZjYn5Wnpm8oagD29Dp9HbSN0cxkvvhNHo9QTYxldL2dmt+KOaul4ghkrDTLErJJgRuLIV6znSrp9Yo/oOxFGbfpWldLYSysbHk91FLM66rHSwqjmzR7h8If8CioyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9KiPXnv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9KiPXnv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9bf484d9fso25616785ad.1;
        Sun, 23 Jun 2024 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719211463; x=1719816263; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btx4yivix146TVd/SKshMhrh5VFqOrFOPHMbbJetuZk=;
        b=Z9KiPXnvsBVCNBbXUhspl6a/Uyje5Nc1OefTJpmoeRD6BzxM6gCt3R62rBkrzrfBJY
         CPE3PniI+SrtQYcLb5AzuFogIntzWRrS0g4NY4NJnenEcwTFBEl79tWhwxIN0TWBsafq
         KhVbBWO2hFuJru35jT3mBYZlOBRjaz2LLVVNjGvPrB1rr7K4Iujz0L2uvSHhXlDBIsli
         oKGPM3qRi+5pahDJgZiT/Ub/RVviHfLVaewHCj6jMvLtwCBneIU+KPAT6cHsvewk+ceh
         iIvcFF/BJPI6VdNWYH1C0/e6XOkJcqZFh5WtbU/3L666woFEmmTCVXUIpE5hoQDZiyga
         mr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719211463; x=1719816263;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btx4yivix146TVd/SKshMhrh5VFqOrFOPHMbbJetuZk=;
        b=ZDVnSyvKT8VVnALXoGeF5ukBzuAhHuRjNFg0wjaVx0sKfnlR4INczIDyt7EilJg+uH
         82hVMWBcQYEIcnYp/tNtKcVhu375bKJ48XcX7XPoIYPrggJtLwzQK6aaoPsnANW2C1jJ
         JtCN2/hZ4BlwcFo4gdITJEm/TcRiTZhk9Hm3kQHG84Hw0w3iFetE5c62jj5Izyh4VFdF
         qCxYPOqJsWiVFdRgnqgxoVXbQHs6/tRs5e8Yc1sOTEEtG5n+ZrYywCxJRFPIE4qTAy8u
         fNJ9nq1G6R+QK2WFamsoaIbAUOj3DYx5TfLSJGW/5/KjA+ZS3aF+NNnURRs4LTFKExS9
         zEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1oWkkMefxI1JzqYyv7Yukoi6dSLlwsbQhO+d5ElqWCtoAniKunnD0GdrqJMdoEoRRs3N48PPTbGXDmmwNwVgFBeALyGZtop9fkS43B7R6QAjSwKqafoGWSw7huLZ9P5PE6N1oYKqVGBR31krCxPlt9bHTtvX+euT2xDELBkFAzg=
X-Gm-Message-State: AOJu0Yyt1y3e0diUyHFDDXnKFZZ8DHzPmN/462aYLATZXswPou/VOLzM
	z05dq7F88xt0grZ1yBK2+kJikjbnYQ4OGSChORb3MIQwZJPoDCqx
X-Google-Smtp-Source: AGHT+IHS9/B19q2pLD4pSSABz5S8EDRjLcprJXdYfM+LVRBeHh4i4SsH5PGLN7pDHFQzSP9Kk1OenQ==
X-Received: by 2002:a17:902:d509:b0:1f7:22b4:8240 with SMTP id d9443c01a7336-1fa1048d25bmr56563675ad.29.1719211462983;
        Sun, 23 Jun 2024 23:44:22 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6ba7sm55371045ad.168.2024.06.23.23.44.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2024 23:44:22 -0700 (PDT)
From: Chun-Yi Lee <joeyli.kernel@gmail.com>
X-Google-Original-From: Chun-Yi Lee <jlee@suse.com>
To: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH v2] aoe: fix the potential use-after-free problem in more places
Date: Mon, 24 Jun 2024 14:44:18 +0800
Message-Id: <20240624064418.27043-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

For fixing CVE-2023-6270, f98364e92662 ("aoe: fix the potential
use-after-free problem in aoecmd_cfg_pkts") makes tx() calling dev_put()
instead of doing in aoecmd_cfg_pkts(). It avoids that the tx() runs
into use-after-free.

Then Nicolai Stange found more places in aoe have potential use-after-free
problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
packet to tx queue. So they should also use dev_hold() to increase the
refcnt of skb->dev.

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

