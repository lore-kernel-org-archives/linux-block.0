Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04A18BBAF;
	Thu, 12 Sep 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136982; cv=none; b=cGSXqjcFTd+AutfM+XJM2ZG6a7qi+vGQfE2VPoGyGS9z8LYnjZgB4Fn4WQ1Npbn4Snhardw7mieF0M97NobLO+YrU8r1E36YJ50xFl7qdSwM1t8f9JFdTix9y0Om18zm/s8yup3E2wohU3cMbHEMYyjvKg4yRPCQugR2EFr+zIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136982; c=relaxed/simple;
	bh=dt/WYvtEBcI/9XUJ+2dYNtW7n1MtjR28hx4ZzaIMLKU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Jwq2PneQVVJU7eGy9eaAooKtQb0I7Lf4waTsRw6/Rzayra5g02HMfg0wZMCuHpP7yD1y6ndIlRbFmcFzTzpp+AG2378fc8XxI1r1AAYJQJH09hX2i2wbtlrnqW02pqZCPUeGOHTAG/Efvb6JEdbUGjdN8sxZg+tdk4hIFJPYErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVGsKrA2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVGsKrA2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206aee40676so7218075ad.0;
        Thu, 12 Sep 2024 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726136980; x=1726741780; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btx4yivix146TVd/SKshMhrh5VFqOrFOPHMbbJetuZk=;
        b=BVGsKrA2elmlQWjvlQB2cscO1vrwMd5dkrfUnh3pz8HHXhyUWDKBjX1dUgYLKRhfps
         QQBqpgWDIDVPxzhgrdmvin3a2WfyIe37ZUJoeBbjCnzU/1/teLLmaQcygGPPr27nDx9m
         i3xPC6iab0vuyOgl+VAS2uydN4e4yO/F0q1HYjjwTxO8FX/JRHlF9rABXCy9KkLbyXOd
         uG6aN19DDZo3291BPJZgVQVPQSSrB2XsNyJyaWLpJ/0iGmwzs5PMhUOxCP+9Xuec5+mY
         gdQjxzxkcDaCHz2ibaVBm4Njuq+MCcliD8CLpZfaVNS3xRex7Xf8DYtArFcxX5Yw/9B+
         4gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136980; x=1726741780;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btx4yivix146TVd/SKshMhrh5VFqOrFOPHMbbJetuZk=;
        b=veHNBHA5jXfOVepjM+O8gZAA1lV6yS+4fwxWvNBnldGsScW/xsh1ESCpx3F0Pvx6kb
         3IQI1dwdvQyOuqbJxfW4Gq86iEdOet+OJJdvbXxIHWHLFB2HYoha/1Ap8GsgnomkgpJ9
         tfcUkLq8KTukwj1byPJe1lIHliJr2Vq+vt6CDCRu79cyZEDESSmWT92Ly5xW8v1uItd2
         /f2WJAHCxyGFsNgL7owA3PcQt6xDQ0bpYTIdk0O1gAtA4ulcsE8SCGwDGoHFsBXF1PIB
         u+WxD/A96XzIhx61AfW/lu605Qc9KvgJDsZDstnefa/GyR12kcs3ULdCBiwt7WGqlvMF
         IVcA==
X-Forwarded-Encrypted: i=1; AJvYcCUXIFV9ZAVXmCoe79JD/IR+lrBtqZGtvEfaccgshBE3LM2c813XvKgVWV9aM0Y7X9R2Xtp5TITSlRSOac6p@vger.kernel.org, AJvYcCW1YqWba0TCcw+tmNmPRUC6geEtx41RSUVFIcdjPoS7AxmiIhq6tUe6S68Pkn60hMbDTYd4P3zrgMneNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq0SUPgWyi0bh3pcPHbQnequCy5YimPZmLWe4Xl7Uq6HjkrNU
	w+UUklaNZQ+Sn3moRzxSFg0yw5yxqqG9g5H4U6EIfadggvpDNOaq1mNu+g==
X-Google-Smtp-Source: AGHT+IHKW2SwbLT1hp0sJ6IDn5F7PTZKMfHlmsxABVnA0fJtbYIGyCpF0WB7Vo8Jq1W4my2llDk85A==
X-Received: by 2002:a17:902:da86:b0:205:8b9e:965f with SMTP id d9443c01a7336-2076e370560mr31434095ad.31.1726136980366;
        Thu, 12 Sep 2024 03:29:40 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b00974esm11933415ad.253.2024.09.12.03.29.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2024 03:29:40 -0700 (PDT)
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
Subject: [PATCH v2] aoe: fix the potential use-after-free problem in more places
Date: Thu, 12 Sep 2024 18:29:35 +0800
Message-Id: <20240912102935.31442-1-jlee@suse.com>
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

