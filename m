Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C412E4D;
	Wed,  2 Oct 2024 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841990; cv=none; b=EUao+o5fw2hBsl8DIVSt2vnYgn+Dz1H7f6/0sd1nbUi+Wa1Y21YFZTD+V+BF1Ck1k4WDmTYyvVgVo4JTRyW1D5k5fCzsbOLZ1YID6nf/VkbKQuIwY1+7qpOZ3k96j503SHTIzNQ/7C8uuJsB3JvuXrX6XZdMxohpX9O4p7xHuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841990; c=relaxed/simple;
	bh=hC0R6H2TjvRkP9JeNlPzsHoWjySJu2t/PrFoxDeDoek=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hDh+FpjULQx0X2iFADtHlQvkedoRTdmIobmytJ4iqY1in1PluFBbe2hnIL+M25IA18h/Z4tYp2znOI+GjyxbElWf9dCPScJ6Erq7LO51t5NooM5e4AD65zOTiSahxW4Q2PwEHoRYCBichXnOrt+ESKZkFNG+7LjawWUQYXPYzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K790jtoR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K790jtoR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ba733b904so19147155ad.1;
        Tue, 01 Oct 2024 21:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727841988; x=1728446788; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAMn/56V4m58dZcNOhc+SwDMRLrUJaDICF2bhtRJcxc=;
        b=K790jtoRe0gkzQLpJkh0poQfYKyw5pJnFyK+QHQbEOPljQ+r76m5Og9AmW7aWaGL8W
         wNDJLhweJWPNajPixadkNlOHXGEL7nUwZ5AvhZtFVWfvhIkKQaT4LfJaLaWW4wqHeou3
         N3pw9aEsL8580+ZnxKXlxgvMAtnTBrewE8NMnmEct+JyZiOgtA3v0V5ifxzRcC59ZNo1
         KkHwFKFUqH94KT/umm2gSCdPT9vs6c1vD8eeuj2b5A5l3bgm6jkEMtsyowYp3cJtUIMI
         nszSJOUvYmzrcmf958XR5BXaCpCOzWoDtKSF1l17aJYTmPhLXSCmAU/dN9Dg98WGvREZ
         tLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727841988; x=1728446788;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAMn/56V4m58dZcNOhc+SwDMRLrUJaDICF2bhtRJcxc=;
        b=MWtmUGWJEyQ7K7j6VJAUHRMbZecoQRVeSXoTQa5jQ3IC0IURpnBWsT7BT5uAfq9YVj
         vy3G5wtAp4euIsPc+i7y+3Nb1prenz62SbfOXBaKrh8giA5N4mhJse5Y+bZY1E0coR7i
         G44ZabhlB6kHAO5gbrsbLF3VGrDgF2Xt6MFx9ODh9ITfuSrdmFSIFTdC86WvCunTmJuz
         uXktn3rgqgFgvkGFfRVht8+6Vh7QkdUllX1DDY+QWO+it4whQ+niOz11qCgueb97VZ6k
         1V2poUqg+AF3TiAcaYLYrjy1uSsMJrvON7B5Gy+mQziGALEUx5xZwX31LrpsAb3Q9QlN
         b45A==
X-Forwarded-Encrypted: i=1; AJvYcCU1VDf8Ai6yOjZamFuymtMTT2xzSER4cscLjtbzH/kuaEh4YtevfkNMQ0fNj/KPoQP2+8i+4mvvzOmDew==@vger.kernel.org, AJvYcCVCPPta3Ed9HDXpxu97QBvJznkCJjVADz5hYArPIOiuTpBoqGV5pwaoiu30bboWswwQtVOtOmn7jOK+6gbO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05m/d1OysSl6V19wA8aob3Puu4Io9cSTjLWs0PYotIlpXHmP8
	/aFEq5ISq4VfHB3bOAdNnJu8HLoIx0RfaJIm9OoSIhyWg/GMlMcr
X-Google-Smtp-Source: AGHT+IHuXY1Kez2zF5PoJ2QL1bPfoXAtSo2UqzYskIulUTL4LT9TNCXCnswtHMqZ9YhjXjrYOzShZw==
X-Received: by 2002:a17:902:ce85:b0:20b:5039:7716 with SMTP id d9443c01a7336-20bc59f1c5cmr25810785ad.2.1727841988130;
        Tue, 01 Oct 2024 21:06:28 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a1429sm511331a91.32.2024.10.01.21.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2024 21:06:27 -0700 (PDT)
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
Subject: [RFC PATCH 0/2] tracking the references of net_device in aoe 
Date: Wed,  2 Oct 2024 12:06:14 +0800
Message-Id: <20241002040616.25193-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This debug patch series is base on '[PATCH v3] aoe: fix the potential
use-after-free problem in more places' for tracking the reference count
of using net_device in aoeif. It adds a nd_pcpu_refcnt field in aoeif
structure. And two wrappers, nd_dev_hold() and nd_dev_put() are used to
call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
same time.

Defined DEBUG to the top of the aoe.h can enable the tracking function.
The nd_pcpu_refcnt will be printed to debugfs:

rttavg: 249029 rttdev: 1781043
nskbpool: 0
kicked: 0
maxbcnt: 1024
ref: 0
falloc: 36
ffree: 0000000013c0033f
52540054c48e:0:16:16
        ssthresh:8
        taint:0
        r:1270
        w:8
        enp1s0:1	<-- the aoeif->nd_pcpu_refcnt is behind nd->name

The value of aoeif->nd_pcpu_refcnt will also be printed when 'rmmod aoe':

[23412.255237][ T2857] aoe: enp1s0->refcnt: 32, aoeif->nd_refcnt: 0

Using kernel dynamic debug can print more detail log but it causes extra
overhead:

echo -n 'file drivers/block/aoe/* +p' > /sys/kernel/debug/dynamic_debug/control

[ 6961.938642] aoe: tx dev_put enp1s0->refcnt: 31, aoeif->nd_refcnt: 1
[ 7023.368814] aoe: aoecmd_cfg_pkts dev_hold lo->refcnt: 30
[ 7023.370530] aoe: aoecmd_cfg_pkts dev_hold enp1s0->refcnt: 32, aoeif->nd_refcnt: 2
[ 7023.372977] aoe: tx dev_put lo->refcnt: 29
[ 7023.375147] aoe: tx dev_put enp1s0->refcnt: 31, aoeif->nd_refcnt: 1

Normally, after one operation of aoe, the aoeif->nd_refcnt should be
shown as '1' which means that calls of dev_hold(nd)/dev_put(nd) are
balanced. The final '1' reference of net_device will be removed when
rmmod aoe.

Chun-Yi Lee (2):
  aoe: add reference count in aoeif for tracking the using of net_device
  aoe: using wrappers instead of dev_hold/dev_put for tracking the
    references of net_device in aoeif

 drivers/block/aoe/aoe.h    | 84 ++++++++++++++++++++++++++++++++++++++
 drivers/block/aoe/aoeblk.c |  5 +++
 drivers/block/aoe/aoecmd.c | 24 +++++------
 drivers/block/aoe/aoedev.c | 23 ++++++++++-
 drivers/block/aoe/aoenet.c |  2 +-
 5 files changed, 124 insertions(+), 14 deletions(-)

-- 
2.35.3

