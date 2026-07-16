Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EED3B7B7B;
	Thu, 16 Jul 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197131; cv=none; b=g//w8nENUrQrATPb7yI3oD7dIIzSSoDvsvkdOpJqykyowXaTK0Rm2/6OVygQ1ox42hEdc2iWOy16Dkn+9UFxuu9EMSbahj1D/UEALke9ACMaaRCS2Qjn+4+C1LPGxDYKWiPPr2EUCfPo7tAVXNrc3AeFHr+ig/HfUhQAo8eGB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197131; c=relaxed/simple;
	bh=IiHpFkLVeVYMO0cauaPqji4GEKe3CwKCIsQrGzPITlU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=CTz/zjtMXDapW12nKbeQiBv2GEaLEsn7tvx8tmYDmrhkEb3D8IPtSVw/onql6Tqk0QvAs7CYwJ7PREv8rO3RmWpqV2urRqGtiu4OBTAN8+boGHLOG9Mb1HIDVynYUjIq/fjPcCFkc24O1MqaLD7BbXOgAfCMgBDURkv4HFxtEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aekxMy0T; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aekxMy0T"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EEF8BEC01A3;
	Thu, 16 Jul 2026 06:18:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 06:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197129; x=
	1784283529; bh=ZGrscjJmGeT+4hzzWfncsz4xUAdpa1xTeSKrBrpvDjs=; b=a
	ekxMy0Tug7Wkbq4utyqWAJF43qtQgMzIoV9lOnvRWOZ3Ep+0NhXDHKwhVG3CpAc0
	tJYYj+5XyWtNUT+BLrsFf57eltvovC3AWy6AhGpjcjwVfVe+pH1tptxtqScPKOWQ
	iQBb70KCyHIjuY+eAl3PVyZPbcKIOyynR7WM/OMEUGsTgewtt8MgqmAGLUkuqjx3
	kPA52cuNR66AsmOuVttY/RzsNhxruG1srOoHqdPcRWr8ictQtDFjJtzuCCWKitlk
	Z0XMlKbb9Pelan7ssMfvJMvjPcO3BgJM8AcPXtEFhDeGwYGVP2gCrToS9FkLaKwt
	4QEvcnAx2grcgBRnr556A==
X-ME-Sender: <xms:CbBYaujMYze8dB6Wtiok-PxdVBSj9WvuE7dW6BvdkJU9XufrNQne_g>
    <xme:CbBYapEOxKckjog8Nfydro-wzqxE4AfrRj1_-tjSUcPDm_sTuVsPNQkQjXUisoDzT
    HjNkh8eTKflqetiFtDYdorH5P4lngD07VozHiXMqM5PzS0zyylRurw>
X-ME-Received: <xmr:CbBYal_VFjMtx_oOKFyD5uGMWCZtEriutjov-zJZOJ-jd3PZmhBr1ucdVCsxAsq4pjdNqWUTxUJJzu5w0FxaTFlVG_x_u8-RO9Y>
X-ME-Proxy-Cause: dmFkZTGS6ZY5pWCItkgy9Xukn2zcuewFxo8ZHHN4pRvLqTF9Ej/jkXu4Mnxg+8SVH62C9Z
    NdfHOTAcoQsik7u3NMaqdaj/Sb4GyhvEyXqxfPz1ORC+VOfUwL7xO6EixFaof20XPTjQoT
    w0gMCsjiGcBL5Sc/2+7W28zCMKgBMJ8o0m6Z5UnNj8t2Ub59pnmCGLWOBXXFwHGukKnjg9
    oPwii2VoGp9LyZNtBuP22Qc33o2tx6mCHkKvSggiUEwKtN1s+YoPNk4J+4iDvPQupo41VS
    yjh7oZu4qBQRwkQZnPNtC4Habjb6Lk5fCXqzalnvP7SEl72bFlt1OaIxxzE5VmPVNQezlD
    VageywburkNtV7wu3uN5mh21toEO1PnbnOOdnxGUHW4ArALnydN3FiO7o/WoiqcZU7Uf6b
    EdyY8ZgAmHy8Za7Kgi/cqH/zmfLrF18E5tLlyVDOgPysdfhxaZVWINuFiKmKC7q9rbAmN7
    amJwbotcbskVjJwhszZ+k+bwMK6f91O9mQfa91995U2HdXBG8+v7mfsquzT+rDOMKiVWUw
    4IVIoBf1Vt1IN1et5d9b31+vWUCEfA5bzcBGUJ4qCqorGa4tTn7VuBynDT4uY4K4JjeF/+
    rDnzaMQdk/s0Yvj0Vu4rx4vQIdllP84JbGO2jNVVM+rAVfsdPF8rsqknzj+g
X-ME-Proxy: <xmx:CbBYaowuaej7kPaq4Gwmv5RM0QLkTpgnfyRonnfG0SihsUYBNs6wkw>
    <xmx:CbBYapNXN1kAd3Raau627VAxEcFZu9Y0yAo0IOdNBPa151MiIeZtOw>
    <xmx:CbBYal95q18QPUaJcIs-HHMEWxJ_Vd6TXeG69AXwBPZVwRO_J_W_2g>
    <xmx:CbBYau6V4DjOWEZ9iO7J6RPrUqNNcRIDcoI2RxCeSfxcFx1qGB3wBA>
    <xmx:CbBYanRjNuj0I3KrfSZ2yOwasoGBwrdkuA13REM5e0keipuGK5KRLzQo>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:46 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <c6a525e6f5bf4cf93c69535a68be842a95b902db.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 09/31] swim: Recalibrate when drive is probed
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Track zero recalibration can be slow and is normally done only once i.e.
during system POST or boot-up. Recalibrate once after the drive is probed
rather than every time the device is opened. Don't register the drive if
recalibration fails. Move the heads to the edge of the disk before
ejecting so that recalibration happens quickly.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 03a89916d4ed..76f6cfa68432 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -412,6 +412,7 @@ static inline int swim_track00(struct swim __iomem *base)
 	if (swim_readbit(base, TRACK_ZERO))
 		return 0;
 
+	pr_err("swim: track zero recalibration failed\n");
 	return -1;
 }
 
@@ -456,6 +457,7 @@ static int floppy_eject(struct floppy_state *fs)
 	struct swim __iomem *base = fs->swd->base;
 
 	swim_drive(base, fs->location);
+	swim_track(fs, 1);
 	swim_motor(base, OFF);
 	swim_eject(base);
 	swim_drive(base, NO_DRIVE);
@@ -596,13 +598,6 @@ static void setup_medium(struct floppy_state *fs)
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-
-		if (swim_track00(base))
-			printk(KERN_ERR
-				"SWIM: cannot move floppy head to track 0\n");
-
-		swim_track00(base);
-
 		fs->type = swim_readbit(base, TWOMEG_MEDIA) ?
 			HD_MEDIA : DD_MEDIA;
 		fs->head_number = swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
@@ -610,7 +605,6 @@ static void setup_medium(struct floppy_state *fs)
 		fs->total_secs = g->size;
 		fs->secpercyl = g->head * g->sect;
 		fs->secpertrack = g->sect;
-		fs->track = 0;
 	} else {
 		fs->disk_in = 0;
 	}
@@ -773,6 +767,7 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 
 	fs->ref_count = 0;
 	fs->ejected = 1;
+	fs->track = 0;
 
 	swd->floppy_count++;
 
@@ -827,11 +822,11 @@ static int swim_floppy_init(struct platform_device *pdev)
 
 	swim_drive(base, INTERNAL_DRIVE);
 	if (swim_readbit(base, DRIVE_PRESENT) &&
-	    !swim_readbit(base, ONEMEG_DRIVE))
+	    !swim_readbit(base, ONEMEG_DRIVE) && !swim_track00(base))
 		swim_add_floppy(swd, INTERNAL_DRIVE);
 	swim_drive(base, EXTERNAL_DRIVE);
 	if (swim_readbit(base, DRIVE_PRESENT) &&
-	    !swim_readbit(base, ONEMEG_DRIVE))
+	    !swim_readbit(base, ONEMEG_DRIVE) && !swim_track00(base))
 		swim_add_floppy(swd, EXTERNAL_DRIVE);
 	swim_drive(base, NO_DRIVE);
 
-- 
2.52.0

