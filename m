Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959B40863E;
	Thu, 16 Jul 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197250; cv=none; b=PhLEhKZiVPdOIWrzohbjtcrhXtx92HOybyn4Q6wlkBS4O8AyACylTI2mr0RnRcVjiaMWGUUOrlPoknTTwV5iLMHaZUk4/0Dtp3pWr7nkMm1MLPX9usYFKwRfV0sZy1TOqWZ5gQiBHDY/RWMhaDCeTFjFmPR2WHuDUvEsBZAegv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197250; c=relaxed/simple;
	bh=T2LUkvIBUWrXFLVSYHwpaV7OfcCsoqMZxuB4tZMzuIE=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=GJjPc4PEXsoo5mPxf91W6OLq1ntdzXTO3ChRNaQYsqi+4+zyUqSKcJ0da5Fzi/T8xxLwXIWn+M6KPzVFJUKcrKqZvt+aWQjPkzKLhDGSm7aMAcRgmCLXZdAKSKmj4xF2nHM0HyiMjRBd3ifi7EBFIUVls0MV8neLf3i3AqN6fos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWtlDShP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWtlDShP"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E9914EC01A3;
	Thu, 16 Jul 2026 06:20:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 06:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197247; x=
	1784283647; bh=xz4iMYdAJzjaPhZ5a+ZlUyR6AWkSSg63UidPL+PYbJA=; b=I
	WtlDShPQYsSDZjNMGU0kvpmBE7vn9hJk5ucWYe1HrhsYse9Dfrr3AE7fPDsOqYgJ
	o0jIys501uKW6WDkuE/HpWcV0d1WS7rPX20dHQJhqLf9nXxq5nqXL/L6Yzn9Zxhz
	MwAqh7q7jwg+w9yBQOYaLObsJz2uYUvQg95frA+BEFObWoKKlCRod5h+EJJTx/TZ
	S9B64bDEO+fYZmEejj3jKtEJIIWr5nQcwy7erkhzFUKNQRdcUoOy8O3qxxi+9BC2
	d/re7EKGEohxaAePqdliK1RepS4+w8JEMLBxYhShLSYgO9QRKv/4sOUF+X5rvjCo
	4huq9EEUE9rJ/O0q5UMqg==
X-ME-Sender: <xms:f7BYagj3GNh1cSxOBUlXx8JisJ54Qt_3kEF6uhDE8Ga7bNNctpC4EQ>
    <xme:f7BYajG-P25l9t0xXHryWoTs4ocImuZy15T7FW566kI1EMqMTA6mRtnDXCpr0kNdu
    ppe9OA7T-0oH9yCjsiOWf9vjrTX-ZrID__54KFx9FtY_-RMS2Z0OpA>
X-ME-Received: <xmr:f7BYan9cCn0bsVeU4GuaFHM0cyvOsCbIXHxniqYJ7BQVDw-UM6rOut4FY10xkDqxPjV_7gKcH05ynIndTNTKjC4NAdkvtVIZw2c>
X-ME-Proxy-Cause: dmFkZTGnu0KdDU6Cnnjzjut7Ynh6tk2+ovdpnczbl4TEpYjd2xea/2V+9/ei9yK10Kdl/H
    MbnOLuulMTuh04InA34id9JiQfcRHmEvLbwyFCa5AII7mZh4DTPlhaDZ0EtjPXqANZvanI
    gKXX6FTRmvs81e/SXh3Y2RykIsd2348XDj62kawHLLsABLDnR8PY9gSZYcetb1jCVEBUF7
    NNBy9UN+k4f/mjPPJM+IIU/fCaOQ7S5w2BvgFaksakvMJ3PE6CWzUaileWz2f2pbUkMMWm
    PCQh/JnlR8kHHa5+ppdGiXm20K6ZlwccOsrQO4Yn7guYiLAWoI1ITGaZd8YRxp3Crl4rBz
    cl4OY97TpWb3gllu8wcWLXvZ/0XxOGR3Ml0ZJu2hrx3BHjRkoRjDWvW2uBpPVNxwVDQPZz
    4lwjkOthDmwyg7EqxZrnvwUZL+5OPjO1ow39774qMzIGkeRz2/Qo4izoI007c2AI0/VSVW
    mB7PLCITE8a7ZxKMJ0d8mYlcRuMm4CKR+ikJJesBoQqLtJhXlGBstzzURjGkAAjHLgvhse
    COyYLmG6WVwrGmE4xxE5Q9aix9Ec8u+eT+5rhSdtJon7i3pErNQsS+jK4w7T4203hekq8c
    FqJPeYS2L5mB2kRDXsRMxkhYaspxJFFF+sNYe+bxcHguQj1hzuuzlw6140OA
X-ME-Proxy: <xmx:f7BYaix3AIKLK20cY7E0YG_PCvPsQGJqDxqr0Ne7GI2V1JU8Bq7FBA>
    <xmx:f7BYarMDYV0fymFu9lOdwqwqrQZUgw2vceRpPVpnZUKBm3djaJe3Sw>
    <xmx:f7BYav-CjgNjHbai14WPjH_435zRADKHUn9SPhm80uaYiYW5-SxldA>
    <xmx:f7BYag5vsZpbdKresuEn-vYt6PoYxSz346HY_m_0qpzDn7VLnOHWKA>
    <xmx:f7BYapRhF1NV8c1TDVuWPY5oGbx41c11A5rXh-Mxsydf40LV9WvklEYi>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:20:46 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <71ee4a9aea796a452a32366cc1305fe33113c8fa.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 21/31] swim: Revisit delays
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

AFAIK, timing requirements for the various FDHD drive mechanisms aren't
well documented. But we do have the UPD72070 spec and secondary sources
like swim3.c and mkLinux source code. This patch is needed to satisfy
the requirements in the UPD72070 spec and follows mkLinux.

Change the LSTRB pulse to 2 microseconds, because this is what mkLinux
does. Inside Macintosh says, "Hold LSTRB high for at least one usec but
not more than one msec".

When a disk is ejected, pause before de-asserting /ENBL. Wait 150 us after
the STEP command for valid signalling. Pause for 1 us after setting the
step direction before sending the STEP command.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 77d7ac3765ae..44fe7a79059c 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -290,7 +290,7 @@ static inline void swim_action(struct swim __iomem *base, int action)
 	swim_select(base, action);
 	udelay(1);
 	swim_write(base, phase, action | LSTRB);
-	udelay(1);
+	udelay(2);
 	swim_write(base, phase, action);
 	udelay(1);
 
@@ -340,6 +340,7 @@ static inline void swim_drive(struct swim __iomem *base,
 		swim_write(base, mode0, EXTERNAL_DRIVE);
 		swim_write(base, mode0, MOTON);
 	}
+	udelay(1);
 }
 
 static inline void swim_motor(struct swim __iomem *base,
@@ -358,6 +359,7 @@ static inline void swim_eject(struct swim __iomem *base)
 {
 	swim_action(base, EJECT);
 	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
+	msleep(1);
 }
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
@@ -371,6 +373,7 @@ static inline void swim_head(struct swim __iomem *base, enum head head)
 static inline int swim_step(struct swim __iomem *base)
 {
 	swim_action(base, STEP);
+	udelay(150);
 	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
 }
 
@@ -401,6 +404,7 @@ static inline int swim_seek(struct swim __iomem *base, int step)
 		step = -step;
 	} else if (step > 0)
 		swim_action(base, SEEK_POSITIVE);
+	udelay(1);
 
 	swim_READY_timeout(base);
 
-- 
2.52.0

