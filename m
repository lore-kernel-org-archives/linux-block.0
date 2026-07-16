Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0E40A936;
	Thu, 16 Jul 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197298; cv=none; b=fqayfnxRDHAiwpeq0Att51zzNZy1to7YSJoJaDk4qDxFqBz+UQy9pCKDMZFj0Vbua0LXAsNEE+4SYYlcB8bjvUjarFwkgMlgcGn41dwXP2YHW9g8keUHTcof43L4iOuSDTxwf0Sj8BY0CC2j01Md+I4m5iGpzvbpAsPDtMwlYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197298; c=relaxed/simple;
	bh=5Z7gh1iDmfsaSCQL05HqXxPSrW8IOTf9GLqL7bLnSdI=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Ur5cihxnSfoqmj0/gCBqNWE+jiRh/2fOEwrt7pVPMIsHwp8A+RPzluoX0idvfCt4HqGk0fJfBLKwBGjSfapxWk/IaLFB/OE9EUpqoQ2VcmwP01RBIWfrODEPtbfffVrUjZQ1Aqky51VeKBLZt0pozE9IqjV2G2/bRruF6j0zkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qmDGPB7D; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmDGPB7D"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0DB21400091;
	Thu, 16 Jul 2026 06:21:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 06:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197295; x=
	1784283695; bh=x8JGduKONPmo/PBzYvXS7XHuuI1iFLmi8/ohOiMJDxM=; b=q
	mDGPB7D4L3QxM208ybjhyFLNTFS8eKttwZjMmXxVIdF5XxcwxWIs9V0bRcPUivvW
	trOvalw1HCKS30bUmGzzXjVh9FAejPLBPUnft41C3UpzGCy/JkJhGJMOAPnOYfJ0
	4FAJ8kSwoi8sN7U3WatQoqP2MuPJnzS4C1DiSU7J6b70LZ6TSGZp7JBJcIJ7B1ya
	ccA/Uefr6aAL6/3BpZZ0qR6iBtuvvv+M8vwq9OMqGkh+YdwDfukRgNFlDrC9oHCT
	s8yBSoWQ3PG8hhA7bROZkVpK/q/zzmwU1QsJeqz7ICdXzjkeuzjfdWuAjquPeBCf
	Ts/Xw+HhJfw+2R/aY6a7Q==
X-ME-Sender: <xms:r7BYanjSioY6DkvTDvnhFnSlhNzpaFXgo6M2lkU_T4sSimU8v3Id8Q>
    <xme:r7BYauHMIGs1QCmEOJF9LhziQBhm5JtuFQ14ZrOf4NQ87GLD40XQ0kE-RsFOtWAv6
    25yx44sgrw4M01_OGiSLrAIJnJDcd20QNJaGiUzuiFpqloqXFv1-nE>
X-ME-Received: <xmr:r7BYam-9T4ahvXOvduuIC5JBrXXqwzHb7WR8uwUWXzJbwho43pHv3aegdRQDyAem8PA4aPA4wWrkRQxASddsrNJLYDJHdwOk7sE>
X-ME-Proxy-Cause: dmFkZTEWnmxZkPFMy2enDcPJpMGZCsQrS3tU6aQFHOQeBM4Tf3VV7eHN9zaTDOIGXLd+9T
    SRExTGwzfq2Lqmd8Lm3Fuem4GNfOt3cb77RNwXh4L4fc+s0J4mfnOcTydQU+mEhVzEj4zq
    y+XExqj3ZYh3utK/CKNSBtokpdZZJGQMKwn4uwZW5HurDKR2noNLkMHyEzSVcZBbRlGDg1
    FScxIJI2b2LcaA/s8UKm0G/vlj2kt/sUaepUi67G9jKK4dXT1xfro5PgsI3MVW370AAraC
    TC6HF+gjVHkiVSpSZUk1hZX/eT/gIg0gc6s8avIf05lrPl/4kLS4CtpVlSmU66Ja271/nf
    ZBrB6CSPngn53PyJUS2yDx2osY8s1ypHCzSMKrd3lWV8lcV3dYZCIV4+ShMzwWIjyRRJnW
    Fp7p/7vuRfi7Sim9mBUaWb8bKZzc11s2W234ByB0LNXfN7ACukla/FtCbvF1qAbQg/J2bg
    eyDPRrfbPs3JQlUHJ9Qcqi26D1gzI24s2ApJMO4ijgcEiPNX6qbRVWLZf+FZ8TVrejE9vo
    YtBy0I8vWMeGwj8L9fMpQqGTPhptnN8QhvwxpEJbxuPoZ5+oYSW/QdsZLUAAknF5yU24ZQ
    2waxAbiVyXAKErdXbMYg4CkAAhFYwtH4MndfVvfvXXc9kcrVQL5Zf1mKnDBA
X-ME-Proxy: <xmx:r7BYalxd4kZM32c1X-j-8t27tooVaEaqld43a_aYL0s0ozFQbwsyvg>
    <xmx:r7BYaiMmn_pepv4BbvNFUdIQXWOKLz9h-_SDA0nFOfPWxDvplU9Iow>
    <xmx:r7BYaq_MM6kXtqPxpKbKkd8PzC-wI1AALi2fNam-URWn0xTOwxU9GA>
    <xmx:r7BYav7uhTDWJI6yha67xE58BAEOv1288jFlVXnVY6nYzRGbI90vwA>
    <xmx:r7BYahtICBJut5sywb4xbjoNMso5ru1wSKYHUvYdMrO6uNPAal6Gp306>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:21:33 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <60cdb6ab6079c8372b05040978d0da7fa2b216a6.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 26/31] swim: Add some helpful references
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

These documents relate to the IWM, ISM, SWIM 1, 2, 3 and associated
disk drives. No functional change.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c41d56ab6c04..444c3f31ba48 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -8,6 +8,14 @@
  * based on SWIM3 driver (c) Paul Mackerras, 1996
  * based on netBSD IWM driver (c) 1997, 1998 Hauke Fath.
  *
+ * See also:
+ * Inside Macintosh, vol. III, ch. 2
+ * https://archive.org/details/SWIMDesignDocs
+ * NEC uPD72070 FDC datasheet
+ * mkLinux source file swimiiicommonhal.c
+ * http://www.mac.linux-m68k.org/devel/iwm.php.html
+ * MAME source file sonydriv.cpp
+ *
  * 2004-08-21 (lv) - Initial implementation
  * 2008-10-30 (lv) - Port to 2.6
  */
-- 
2.52.0

