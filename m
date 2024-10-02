Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF338397;
	Wed,  2 Oct 2024 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841997; cv=none; b=GonEX27lhHt0Bgcoug8UTMqih1Ow142gkL31BkgFwuXBTpT/t7fo0QAz/nRwX2GrfctFKuNkGGVjrnGmzebH/xBURAl3CE4QDKK3PP8TfuvI+9Z3Y7LYYXaFSzc6WxoPjb4fP6p5NlQLrmuDfCMnCoDQ/Q+R4SIQJ6pmO8qRjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841997; c=relaxed/simple;
	bh=lWuFZNp8SGcuyk7Gf4k+aq+Idi1/bmDlYGOXJ0H77wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cQ7zCjgV5U5jU3MoMQvuRMRHxfYGYo9LnFM8a+qxO8TfwUrjyJ/BRR3sHa7Ou/dVAbL5qAj0IjJb5FMm5Kg/YBHatKwiF+k9Of+SPJrVF31pcp05+78uIHNqq6KMedUeN7YWIvRb8NNhrz+WTjGMfMzfs2/9zMrimHf4UaDNJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVwMGjbi; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVwMGjbi"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4702931a12.2;
        Tue, 01 Oct 2024 21:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727841995; x=1728446795; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zYaHB61WqWgkxXuSD6BdpH4wlWMX7ZgatPU8DqKwYTU=;
        b=IVwMGjbicr6QuJqTGmx+sq7Z9Pw9wYBhWPMf5Bn3YYz+cuCf6RsBhxNcA8lGuDd2h5
         xlvCwibRTO1uP/QWOQyItNHzhL4Enu7ZOS+eEW/DnwMfMgGO/4dot/RISz8GJSRNG/7W
         rIQHZa6yyF9TJaKiVxQOplCUWAfbJpZtRsOk4Tq/MGBfh3HiFfTZj4dwhg8UALAn4PP0
         p382RPvxmuHjWjdWSRbD3g7gCkyiJ3erZhSU3tbwirGHCsmBNrbBv1oBw2yXx0LSC9rC
         7UPZJ52XIykkc8FI8JTQgPVA7bQTtcg+DgBO8cqI5d1uj691SiNLLO+i6s5FV2i8y1pV
         671A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727841995; x=1728446795;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYaHB61WqWgkxXuSD6BdpH4wlWMX7ZgatPU8DqKwYTU=;
        b=QsTNp7MoGCwlCkK7ZZC6/5aeUtx/pFDyC6OQYnfVuGV6DqvoXHpOT6z4qTQCfzRcDU
         /qTOH8ImIi/rHZ7s7ZUkbNZdgYSgyqwEF0T8cuXsDGQ00EeiqMZ0vYurOX5pfB7ASrtw
         /NBohAk2p5aBM0FwKwgC/7tRxwsO784rVNTZcmVXfc1B6VD9FbJnatP3FDE5CDK1RFq0
         Esfw8/yH0+18x3IxyYzQ52nHrLWyFSrrmFx8sddPGhery8XjJ/OWkEHLJvSPSXPNmV1F
         b5kHMT3AKYqBYzMD670X0tL1mqHSPDDQiLTpunuexMO+GE5H0tniAFKfQATWqebRJOdO
         ulnw==
X-Forwarded-Encrypted: i=1; AJvYcCXlXfy905i1fTucjSvz2fbfMfkoe6DPmYas+a8zrqUi4Q2OJ6tSs99wrGRx/YtgeUMeXG0qv56vaGaiE481@vger.kernel.org, AJvYcCXqunEtXXLxBTZ3oeyE2ggF/fJuHVl420OYux9DIkTLcvIxodZwvZDZ8Ne+pI3aGupVaUZTBVzOVqT7Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyInhHcF1ZcfD9LfgZdGkgDsM+ZWvTiMHKXdh/qZXID3IzlU//0
	ZZKCnnD4nJs+h/Zy+M5hAMiFA8HsxsmK1JQxTI2nBShuBbUqu77G
X-Google-Smtp-Source: AGHT+IE/+Jk4TQMRVhQ6ytQzbXd0DS3r9HoGUWNL1fkubxZ8o5AN6Q3LrG2zofg4RpD5c2YH/ULQtA==
X-Received: by 2002:a17:90b:4a4f:b0:2d8:898c:3e9b with SMTP id 98e67ed59e1d1-2e1848e2c70mr2483022a91.25.1727841995129;
        Tue, 01 Oct 2024 21:06:35 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a1429sm511331a91.32.2024.10.01.21.06.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2024 21:06:34 -0700 (PDT)
From: Chun-Yi Lee <joeyli.kernel@gmail.com>
X-Google-Original-From: Chun-Yi Lee <jlee@suse.com>
To: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [RFC PATCH 2/2] aoe: using wrappers instead of dev_hold/dev_put for tracking the references of net_device in aoeif
Date: Wed,  2 Oct 2024 12:06:16 +0800
Message-Id: <20241002040616.25193-3-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20241002040616.25193-1-jlee@suse.com>
References: <20241002040616.25193-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 drivers/block/aoe/aoecmd.c | 24 ++++++++++++------------
 drivers/block/aoe/aoedev.c |  3 ++-
 drivers/block/aoe/aoenet.c |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d1f4ddc57645..2bae364fc5ef 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -361,7 +361,7 @@ ata_rw_frameinit(struct frame *f)
 	}
 
 	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
-	dev_hold(t->ifp->nd);
+	nd_dev_hold(t->ifp->nd, t->ifp);
 	skb->dev = t->ifp->nd;
 }
 
@@ -403,7 +403,7 @@ aoecmd_ata_rw(struct aoedev *d)
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
 	} else {
-		dev_put(f->t->ifp->nd);
+		nd_dev_put(f->t->ifp->nd, f->t->ifp);
 	}
 	return 1;
 }
@@ -421,16 +421,16 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 
 	rcu_read_lock();
 	for_each_netdev_rcu(&init_net, ifp) {
-		dev_hold(ifp);
+		nd_dev_hold(ifp, NULL);
 		if (!is_aoe_netif(ifp)) {
-			dev_put(ifp);
+			nd_dev_put(ifp, NULL);
 			continue;
 		}
 
 		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
 			printk(KERN_INFO "aoe: skb alloc failure\n");
-			dev_put(ifp);
+			nd_dev_put(ifp, NULL);
 			continue;
 		}
 		skb_put(skb, sizeof *h + sizeof *ch);
@@ -486,11 +486,11 @@ resend(struct aoedev *d, struct frame *f)
 	memcpy(h->dst, t->addr, sizeof h->dst);
 	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
 
-	dev_hold(t->ifp->nd);
+	nd_dev_hold(t->ifp->nd, t->ifp);
 	skb->dev = t->ifp->nd;
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (skb == NULL) {
-		dev_put(t->ifp->nd);
+		nd_dev_put(t->ifp->nd, t->ifp);
 		return;
 	}
 	f->sent = ktime_get();
@@ -552,7 +552,7 @@ ejectif(struct aoetgt *t, struct aoeif *ifp)
 	n = (e - ifp) * sizeof *ifp;
 	memmove(ifp, ifp+1, n);
 	e->nd = NULL;
-	dev_put(nd);
+	nd_dev_put(nd, NULL);
 }
 
 static struct frame *
@@ -624,7 +624,7 @@ probe(struct aoetgt *t)
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
 	} else {
-		dev_put(f->t->ifp->nd);
+		nd_dev_put(f->t->ifp->nd, f->t->ifp);
 	}
 }
 
@@ -1403,7 +1403,7 @@ aoecmd_ata_id(struct aoedev *d)
 	ah->cmdstat = ATA_CMD_ID_ATA;
 	ah->lba3 = 0xa0;
 
-	dev_hold(t->ifp->nd);
+	nd_dev_hold(t->ifp->nd, t->ifp);
 	skb->dev = t->ifp->nd;
 
 	d->rttavg = RTTAVG_INIT;
@@ -1414,7 +1414,7 @@ aoecmd_ata_id(struct aoedev *d)
 	if (skb)
 		f->sent = ktime_get();
 	else
-		dev_put(t->ifp->nd);
+		nd_dev_put(t->ifp->nd, t->ifp);
 
 	return skb;
 }
@@ -1514,7 +1514,7 @@ setifbcnt(struct aoetgt *t, struct net_device *nd, int bcnt)
 			pr_err("aoe: device setifbcnt failure; too many interfaces.\n");
 			return;
 		}
-		dev_hold(nd);
+		nd_dev_hold(nd, p);
 		p->nd = nd;
 		p->bcnt = bcnt;
 	}
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 9781488b286b..48c936dbb9e5 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -504,7 +504,8 @@ freetgt(struct aoedev *d, struct aoetgt *t)
 	for (ifp = t->ifs; ifp < &t->ifs[NAOEIFS]; ++ifp) {
 		if (!ifp->nd)
 			break;
-		dev_put(ifp->nd);
+		nd_dev_put(ifp->nd, ifp);
+		aoeif_nd_refcnt_free(ifp);
 	}
 
 	head = &t->ffree;
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 923a134fd766..3565042b567f 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -63,7 +63,7 @@ tx(int id) __must_hold(&txlock)
 			pr_warn("aoe: packet could not be sent on %s.  %s\n",
 				ifp ? ifp->name : "netif",
 				"consider increasing tx_queue_len");
-		dev_put(ifp);
+		nd_dev_put(ifp, NULL);
 		spin_lock_irq(&txlock);
 	}
 	return 0;
-- 
2.35.3

