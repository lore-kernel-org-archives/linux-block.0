Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864E2C1584;
	Tue, 29 Sep 2026 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641741; cv=none; b=fU2p8bc7MFtsTp5b/RvhhHLfE6/YuNx8HzOHNtV4En7sToTyHLyoepIybeku4jyCNnlif9ewFkAvcqmMZ92Ah2PN7E4iCis2MlR5nRoZaOvEQz358REToSj1N2k6OHjFyZM+SokpSBaJAHMpZwYAlYM4w8Y0w0XhrUdN2wCxF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641741; c=relaxed/simple;
	bh=cDebOZgx6fqRK1RH1A/OIOzupkx2OQUKhAKRMy6U7qY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=K/xgCRbXzUuYUxf3PizX95LdZ90YsPTeWXc68XeO3pxtIg4pQJu2Sze929crwXkwq52ZoGn0FLKdHAGhHSQ6NldkcnQ/zpGBYV8CT6g3PHhUVCr6ucIDjwao17r05XV5E4yIQ4Rdb6vA/LFm8NJk1UpcdHXQ2ZXjOk1zvfF2tj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQeA58UI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQeA58UI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 338A31400098;
	Mon, 28 Sep 2026 20:28:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 28 Sep 2026 20:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790641739; x=
	1790728139; bh=kPClYuDThScF1EGrEFn5LWL6TERZ0ask6jMkiLykl6s=; b=J
	QeA58UIFw9vCMaLz4DNa1CvnlYjEvTNAE7xsi7P3CXPjWMyohueST7+MHAeQ9SOK
	p6rFLq2EcMlYcEfNl5r72eeYjEkGS/w5aBWK1Tzb4b2q//jnj4CF9QzdxAuUXrpo
	OSpZ9Uihn3E1BU6+mNqgl5AwwBnajuTTsAxNrkXgc1pt3VhH2QIffKa6ozlfZKcv
	q6ckI+nnWDPZibMIH9Ahko9yF5qi6wpvXPMZ3YTchV6H3qc100BjJuOMi3RDhxzu
	XiPBs5t0IIKRYDIpxWSFLI9bk7+2LvTjLuawHdJQCXm5pS5Z9HPMYiv39fVXcanV
	tI6lwu4RTvdv0GPyuWM9g==
X-ME-Sender: <xms:Sga7avtg5atqHbEOMihKi81jCfmNaQFgdUrQXKc0MIev4IvTwh90yQ>
    <xme:Sga7asfK5zd5hENeqi-s-0ujEvvxZ2bMSLQTFF1P27n-qorTe55vyeR7_5hY13Pid
    QHuPI3drKnhvTfvCRJwwayZLWqCzU3G1PrOMWkK88ZOD3KlItLzI8Q>
X-ME-Received: <xmr:Sga7ak9xFxKXzgsjN9Htsyb-yj3SWKhlU-q9tGxg2gJKAXJec1688mVuNGRCapZcFWzrmG7yLdOxnRB83WOmrZwnpVYLhYUhxeE>
X-ME-Proxy-Cause: dmFkZTFvVkWPdiE6nn+cl7P5xFBnKNzOXHNZ4eKj943n85xMEwwpwQBbZRt/UNf7hnM9sC
    uPVrP+UcbyvTpTEztDA8nAWIESxoAkKOJn2ZUxFSHZfDNcOaKpw6lXv6HRCZND1bjjgwdg
    Mh7qh5SeHPDlQIXJhO8R3txfGbQI4PC4ZB1pH8qfRIdGu7t4AnBmaOA3cwb7EPXDSJZH//
    2UbY+9RQfSl8M2+YPxgK2SBGR6qPQcEBVIJZQzobCDMnvCV15N3RS/fnKB+ImKobBaBcwr
    /KDXrG+CP3YzyTcVqEkrW2Zjxmph7hjAwlZ5ISpjHPjUSP+bSzaZssoh57/wWBy4TtPyAn
    B/iK4+QoNVVcFxzPBvwuMaiXk3Wd7czHy1bdlGudXy9Y2z/5Tsc/ayxu5+DWaKV7+6xlm0
    l+KBNIZBHIlxL58SIUiKEC3KhlvEK8Q8NBfAeV0Pa3slzmNJGxR8UXiuWmwM4EOJd/vE/k
    jO6ZBI3r2KRH3Zw5t1gjbvP/mVnHBkdFypTUnF3evfjyNEb72ocU+d5LkKIoWghFUpkx2F
    T1iUMdBuiZ559+TMtNCiEWBpN9kzC17MBe7dQRxMZ1n/XYJOaqTdw8hp2H6Uil7+bmyhwr
    SNhtLegQ3cMIzgbyayuOkpOjb85RkrFZ5TuTDMvnX++x8w8FF1XelUJbmZEQ
X-ME-Proxy: <xmx:Sga7avQYUO3jYWCivQENfcmIaeK-dx1k0BPUQpAdQHE5gnKPJvlLVg>
    <xmx:Sga7atqskyG32WgkWE3HrAyVm2xOyr6yacBHaJ4HtQag43i_XU09ag>
    <xmx:Sga7akkqsWtp3B802BsRgNQQba-OqMAys1aOzuhytFcKlbbHGmWviw>
    <xmx:Sga7aufGONGi4mLuoqsi1z10D6eZAmsDDA6Y5aze2ZfxKGPcinnYtA>
    <xmx:Swa7ajPQJ4j0i-5fmgYd2nJxm7TnrSvYvOI6rmnTxqMc9S1sIcNx5qfs>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 20:28:56 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Stan Johnson <userm57@yahoo.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <ae3ee8e86833a2739d7857460cbe2addf4146088.1790641175.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1790641175.git.fthain@linux-m68k.org>
References: <cover.1790641175.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 2/3] swim: Fix FDEJECT ioctl for exclusive open
Date: Tue, 29 Sep 2026 10:19:35 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The eject command from the util-linux package does not work with the swim
driver: the drive doesn't eject anything and the command fails.
Apparently, ioctl(fd, FDEJECT) returns -EBUSY when fd is opened O_EXCL.
Fix this by checking ref_count for either 1 or -1. Either value means that
the caller is the sole user of the disk.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Access ref_count after mutex has been acquired.
---
 drivers/block/swim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 49c894af7c13..baeb05f3e003 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -700,10 +700,11 @@ static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch (cmd) {
 	case FDEJECT:
-		if (fs->ref_count != 1)
-			return -EBUSY;
 		mutex_lock(&swim_mutex);
-		err = floppy_eject(fs);
+		if (fs->ref_count == -1 || fs->ref_count == 1)
+			err = floppy_eject(fs);
+		else
+			err = -EBUSY;
 		mutex_unlock(&swim_mutex);
 		return err;
 
