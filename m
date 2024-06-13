Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02B2F34;
	Thu, 13 Jun 2024 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252114; cv=none; b=Ox7pzrXmqFTEXKdGvQc5w93/ll2JeoABqnoyqDmP42I1b1wDbWBWRxYcO/mxJvdG1E4sK1+l7VtFOwBauiwNB/X/Md1YI5bfuirYi9YeQ4qW5ynySWNk3VGa1mT4KWZrCxZIUNH8tY4Bdw+PpBDK1Z3y7Xrzu75+4C0yWAav1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252114; c=relaxed/simple;
	bh=dt/WYvtEBcI/9XUJ+2dYNtW7n1MtjR28hx4ZzaIMLKU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=omYQlDgLTDp8LDot7xeW04Gj9uSTLQFdbqw82Rx0y9dQcQGsbmjxUknfp0lXm8sqPRtuq8jB6qfcrjUGHLKLInpCRShzmzZuQth4dA+srKNAxboU4cp5wgo9ur3nlMK2nAnDEu3Ning0fCx3SrmGZzA0olRJ7r3uQkcLj+TWon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0pU02Pz; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0pU02Pz"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-254fa9fe36eso175582fac.2;
        Wed, 12 Jun 2024 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252111; x=1718856911; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btx4yivix146TVd/SKshMhrh5VFqOrFOPHMbbJetuZk=;
        b=V0pU02Pz9fVV5UhoRGmLAIz5LLrOhzaATJoD7yonGQZ2I4feT9xFRr7Fs2Dit+uL7C
         SSZpDSKLr0g9mPdCqx+1ygQbPeVYR1E2bBInLMNbr70oCpIxzG2we0+ICKXf0pdYsntX
         LiG7ITSgFrcEvhufZPV8sPtECCmjbDwpNTm42eQn2lr74oG1zTrgt5lK5HmXGe5R7k60
         sxOd3wR3Lq+e3Cie3HGTM7Q2s3JbR3yqCuhoknItQ3yRBl7Z7SgbwIWpLSnX6nN4Xs/L
         fv+5lqolkV8ahQ99ywpKZ8E5O5A7V4wo2kpgwjxrIolqZZ/P+Si3gAkUNNzTkpTOLdNZ
         Lxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252111; x=1718856911;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btx4yivix146TVd/SKshMhrh5VFqOrFOPHMbbJetuZk=;
        b=r2MQIuIJ4OLQ79AHcM0ExobahUPTxSdlYkj5iieKV/rdXo+0flHPwbNbsTeFL80lVD
         LB+5uMrProCLR2o+OlANZNIBpuUOzosTmOHIMi+CuVu4cGuSHQgnO6YJAQ3Ucf+uGNVp
         WkcbCyzWuKr2pnbbrXurlbOVS2TO700JYi1NbBLFgzSAdynJ5XsM/Bo0UjtqsEXD4Dpa
         xQNuu/I52ch8E0XkUZGoAc1DgLeNY3fQvmY4ItudlCBZvzSnI12b1EuK8AJEjhakcygk
         th3nak8gMrniNsMbQ9BXNQEltAGT7TONOrK9BTJiIHhsYqA+Qu/BcYtwYjUuEqWPOY41
         TXBA==
X-Forwarded-Encrypted: i=1; AJvYcCVdi1REMT1rQ8bJe/hm83A0JraUqE9vOHvTGl20jj9+b9Tbw4TxYK9q0J9M/tgkaTPFqZUUtcEWNiQTE34tqmcHPOCocq61t/N5o4PkYH6EN5dkXWW2/wJTW/+uZna98RIQ+ZNYrOuU7GQ=
X-Gm-Message-State: AOJu0Yya30FBjq7g9p0Ytqi6XTzheeYCaqrpbDTPJWMxmahUiBUxV91K
	PHr6YjJbUSY0j5hdxl/JjEfw75NJ+hazpN64YnJfomPYoTmYS41zQdPAJA==
X-Google-Smtp-Source: AGHT+IF8qel7SHwA6+OpEbOOM0mom4DgY2fppqE6RgGkKhreq27UGnMdb/hlvIYSC5IxqdDxl99V+A==
X-Received: by 2002:a05:6871:780f:b0:254:8d5a:f9f5 with SMTP id 586e51a60fabf-25514d46766mr3911442fac.30.1718252111058;
        Wed, 12 Jun 2024 21:15:11 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d268sm370448b3a.101.2024.06.12.21.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 21:15:10 -0700 (PDT)
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
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH v2] aoe: fix the potential use-after-free problem in more places
Date: Thu, 13 Jun 2024 12:15:06 +0800
Message-Id: <20240613041506.5001-1-jlee@suse.com>
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

