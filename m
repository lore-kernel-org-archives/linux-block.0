Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205876;
	b=rfks5/YbYqfGPtrjh+ecAgSyJUVNR9m6JT+gbc7gK8bxYc6l9kYQ06MQvDU3+tiq85KR
	 naqCaOZrVSZ6gyCAOX5tni1hU4HR71wyUhKNGzCBR6OuJUEgAWYyJt/v0LUTMWGvUKxGz
	 IwIycEXn0gJHuHrMmAF38YhA2mYSnI4CJM5H5J9nDcr7CnPGmt+pR0ZTIujlcgQneuPb7
	 Nmx0HyDlJvE26+YzBZK0ovFBuufQ85cZwSy6einlS7uVkSy+vWH82D/EW/awL8vh9pkOs
	 v3RUQ5uSPnDEwjR4ALA78H4ccbgvkUhlApr0jS9yxVQ1f4anQ9c5+C1KxusvbUnjk8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X3sjbvmlsmXYprWoRqYg3TVuD4s1wl5XXJ75sCGfGis=;
	b=AAJrFUVioxW7b1gE2smGxBAaiAwMEgvhwnT5rFSa4xm0/pCchH6Fs49GZTj/GYSCU8Qo
	 PPAtVZ96s1cDDMpQ9rW/e2jUS0qphqzEz5E/wB9VE1E9f6xXjAt94N27GRZURfeOZNvyU
	 S/+Q+DitP/PNMnA4vuumH58Lxp3hX4pXHbSp5e5sn9107eeUdylgwFxped0uHAwhfLQv8
	 PdNuFZgZzcUrv5mA8kYhtKf9B47L8rzM6zNXjlkABuhRYNMC8MfpJyWzO0ekhtrVWoDBH
	 WD4MrWtQkJiARzDFj6J3lEh3EHBdsqjU1rsBk04CloG6I1eo9phR0C4+HlRFFGKSedQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=U56Qpxk6;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E3606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240E3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=U56Qpxk6
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-85a5455bd3cso733399a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205875; x=1793810675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3sjbvmlsmXYprWoRqYg3TVuD4s1wl5XXJ75sCGfGis=;
        b=U56Qpxk6+8URXkat/TDXU2q+cfJ1UPkahXpccK/DsOCq5atVhfrn3tgUIsW/+Eft0h
         gNYZFwfMGSQbOSGaKAZLCf7M88FGvpYG3a5vOr8bFT7mY1P/VisRKt+7JCUUUieqsF5S
         dPJkTsiXKcCcdtOk3xiRCRaAHrStnz6qgVcGlR+c0kLXqS/5+Jp9Ww+uVlxdGqIlw88y
         ibSOt63ofv+NIBOemGOIY1Tmbw2bRqO1qudp+WgqN/9BJzEXfCUOvNECTyVKFcU880Ge
         mEaGh0injGPDXzGdZ2XTSFwlPHZmSp++YCYg2GNJizGwXSMdeMQZOWUmfOVYvrHAZKG5
         p40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205875; x=1793810675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X3sjbvmlsmXYprWoRqYg3TVuD4s1wl5XXJ75sCGfGis=;
        b=OKpTr9EN5/9yVhwPxvRJDIPFkqKOgE3BDVpFSCzlmeITJq95oheKrzIhSRZ2VvGYYC
         rbdiyyGntkCO8C0hJKv11sv1tm7sjRSXYDZJsynLBaT/mvfgyVyw83umkqQhOw7Zypxl
         xLoiNULEBvFxAylbYxKR4Sox02Vy99niX7hiaZKAiTtCzZUt3PxPKZrTJmEQRWutYOQb
         RVRPjKmF9Vg1IeuekoGDi/URxxj1NXQOGOQ4TT07Tta5QaBTC0Aqnpj3uelKkhiijn7f
         SXE0wJG0An5CB/dfg5q6s29ekq5pf68kwnECJJcT6Y1PCjSmQ0qmnOpR//1cQnUvEuoF
         k+5g==
X-Gm-Message-State: AFq9FYLrCfnfV1WEY4cVR8tdKvH4VdIS/GisbhOMRZTCvRcH8Mph9uqz
	0baK/zAX4u49Eu84Z3jnvrHoW7ErwH4LPbfdbNwc7mV7sZ1qeEie6ekCZRNGaV4Z1qZpeG8KxTq
	7mADl5hk=
X-Gm-Gg: AYBFou0Z/sXmrKCEUPcHNZ9nge4XuME34nREWJmPuDiJaXW5zKkAbr1OxjoNXVLAH5i
	Rwl9dNp8A/G+IRof1JeLpeuLrkKy+nMR0wfddLYgFKGdsbRMjWJy5rILO5Qe4g7xjHFLirHCxjq
	rr7kFjap9Gc0A2st+JWSp+lIQFgcjK4Z23i4O+aaSLAwDZ7UqifZiaIXqqgzNSNuNo+mVCVoMCi
	YVIuZXOGGVlG7IO47ChZyrNoPT6NL28fI5Wa2t5xE/3mI/seBk7BoNs0Vbju5EnSE2Ghp5c0N8u
	xb6qyRXI7uPntPLo/YM+9HGsvZlL9h5Fmf7RR9BSBjl5QxuX99bC5eS6xi4NJNnqaz2X9HWcUaI
	yx64jPl67f4RatUv0hywhG/ArWP4c+YNgMeX+Ra7AOdbWH6ATYxdHrGnzDTPEOQGv59/9O/yLay
	23dH4jtL1/rllnTDlzTqEK7w7H9jAyOX8UF6UTDElXPRqBxa1Uzt7G0cU3ica+dbsHmTOFPlNQv
	CihhvCabVuBBYZJelTn8ZwE+S5rbuBp5PFEsaohtlUlr5p49p33g7mKCBrF7bEhnz5znHE2kBof
	rfppFcHc8fsTYRYQ3IRW4GtQVNvRim2rw3gE6ddXWMt0kWE+U6OX4XNicb2euLD4AM2KWZD36g=
	=
X-Received: by 2002:a05:6830:25cd:b0:844:ce0e:e43 with SMTP id 46e09a7af769-85ab9f4a373mr2726242a34.29.1793205875171;
        Wed, 28 Oct 2026 09:44:35 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/98] blk-cgroup: fix root io.stat byte counts on 32-bit
Date: Wed, 28 Oct 2026 10:41:16 -0600
Message-ID: <20261028164415.1262013-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

blkcg_fill_root_iostats() shifts the unsigned long sector counts by 9
before adding them to the u64 byte counts, so on 32-bit the contribution
of a CPU wraps every 4GB. Widen before the shift.

Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup io.stat")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e79177ac2dc2..c9187d95a54b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1118,11 +1118,11 @@ static void blkcg_fill_root_iostats(void)
 				cpu_dkstats->ios[STAT_DISCARD];
 			// convert sectors to bytes
 			tmp.bytes[BLKG_IOSTAT_READ] +=
-				cpu_dkstats->sectors[STAT_READ] << 9;
+				(u64)cpu_dkstats->sectors[STAT_READ] << 9;
 			tmp.bytes[BLKG_IOSTAT_WRITE] +=
-				cpu_dkstats->sectors[STAT_WRITE] << 9;
+				(u64)cpu_dkstats->sectors[STAT_WRITE] << 9;
 			tmp.bytes[BLKG_IOSTAT_DISCARD] +=
-				cpu_dkstats->sectors[STAT_DISCARD] << 9;
+				(u64)cpu_dkstats->sectors[STAT_DISCARD] << 9;
 		}
 
 		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
-- 
2.56.0

