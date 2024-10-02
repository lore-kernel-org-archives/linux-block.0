Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36231AAD7;
	Wed,  2 Oct 2024 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841306; cv=none; b=OQWcLukcFaGaCDhJqzpJtIPSRvClVz/WBdd8YrBYsmuMrMNhlsN/RV/nDLYq9ugraGVuubYBrO5/FwwR4iNkZKNZU8zRCvd9QE9vtu2DgANB+qg/gRRz5muexZ2+ebD/jwXYcAnCIvlpkxHoXLuxPpDttwQabFYBKSoZk1K8qpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841306; c=relaxed/simple;
	bh=A+iDuCBesx2uZjoMq70giOqCcHQkICZmgXdASAw+6+0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FobuUZF6xKxPHBDHoWj06hQKWxz0uORVqxGDSGminNtzRIgsIpS9OLZpKCe3BmfB5HXHoT16aXqiaRsH0Jt5ZTylxrTxulTNO0ouhAM5+xa/VFVat2CQqNXRNsiiBBnQOMm5atemld3xvEVd4eDaVVtbnFWxEWZ1wuLB6VWhrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/aVWM0i; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/aVWM0i"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7179069d029so4511522b3a.2;
        Tue, 01 Oct 2024 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727841304; x=1728446104; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSYr48DYuXWJ/2DzNlg7n1tiTod6Wi6grHXELQOaVw0=;
        b=a/aVWM0i16Oi39WfEOm7ihQsfsD5N9dPxQeEs2g8wsy3Gs+bLmdojB+LMW9de6QoFc
         tA037WfMH09Clw/IrgpsTVxbb55KsjX1oZEC85Tthob7JLg4Yzd2xunz8A/c3efrhUTE
         hxlsMpPYc1MG4YhewjXcM8LViaYJg3t9+hImkjBMVwIWHJmZVTd3m8v+fDSg8Q6b+7Q3
         pdsYytrjg3R6tta+jAGOBcVVEMRA5BQZO1UIcTXDXeZN/05+2NvCTm+i42wubcwJGnBK
         O5oQhNuTUN3orE1BkERUaGUiEMXidO6f0zc48hHSwK3tJQGygpFIiRsNGmCpqeLfO92v
         obQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727841304; x=1728446104;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSYr48DYuXWJ/2DzNlg7n1tiTod6Wi6grHXELQOaVw0=;
        b=ISEBnyAE7RdhF1DWiYzH/f+9bApW6TtWg6XlUsnLK/z2feClaDNtZv85U8l0C4avIp
         F73oA6qIzy0Z3W5Js3WWabRxAx177jPwiyEEoXSWSzr1oN797TQDv6/WCmo5zdv2JPy1
         j9xECRPB+HVC6zwIF+2ToGuvivKmGVrlFysuaIUU35APl5giH9iCjVbtRX0A3UXkvDxg
         EYIHElpUpX4tIvI+aO9NaqZNaH6+AKK7Pep5Jsss8uBfcd2nP/JOPJO1HXtJ5oECaSQe
         WkWFF4ayGHlooarYKbri53n4Gq4ZTd71ZE5L2cTToe2HIY0nsNvftq7AY29dNcZIOmEU
         UIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxiU8Clf4etykPf03W4ICtz+006w7LeiAKMMYbs5UxXwUpnC5kh+V6+LOts6PaujFE5Dvazj8N6o+P7w==@vger.kernel.org, AJvYcCX6dI2nHz4J9K8s1z5LWq0x4FsETjs4/oNTM3Z7LG8iijQNAXlLVOzHVsWyluQqz8XF58W8o1nk8meu9OWt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Nr35hgeIHl7dlv/j5c6a+GH/gSgGUnTH7RjcSAp3eblmlIzH
	Ao5c+Xl0T0Km5A9/6oABdDME+K7T1P4dSLhQW5hDOCRJwuHcegsL
X-Google-Smtp-Source: AGHT+IF5FwiHndI2fUSIWG/g/V4T/eVlBfcZLiMEQbmIE6fQVIa4UtCvjQ4iZu0tz/V3p57A1PzpWg==
X-Received: by 2002:a05:6a00:13a9:b0:717:8ab1:7bac with SMTP id d2e1a72fcca58-71dc5d56b4cmr2734779b3a.20.1727841304120;
        Tue, 01 Oct 2024 20:55:04 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bb0c8sm8911475b3a.51.2024.10.01.20.55.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2024 20:55:03 -0700 (PDT)
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
Subject: [PATCH v3] aoe: fix the potential use-after-free problem in more places
Date: Wed,  2 Oct 2024 11:54:58 +0800
Message-Id: <20241002035458.24401-1-jlee@suse.com>
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

On the other hand, moving dev_put() to tx() causes that the refcnt of
skb->dev be reduced to a negative value, because corresponding
dev_hold() are not called in revalidate(), aoecmd_ata_rw(), resend(),
probe(), and aoecmd_cfg_rsp(). This patch fixed this issue.

Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts")
Reported-by: Nicolai Stange <nstange@suse.com>
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---

v3:
Improve the patch description

v2:
- Improve the patch description
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

