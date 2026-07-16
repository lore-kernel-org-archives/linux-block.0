Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6E40096C;
	Thu, 16 Jul 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197120; cv=none; b=HYv1A8HksirMhAvfdKizVk8QK373w3c5FEwTPzs5aGP5cHZ4e9LEM24/5kOe3QwLeb8PLdMTE8GRfepmoW+5dOqTkhidoX5MS9vJfyiivHafPMwp7464MRyA3madZvFfVbhUn2s8eEwz7x1peSxHiC66FzyQPjFZULI0ynnpD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197120; c=relaxed/simple;
	bh=6bSxI3jsOa9bulaoslDedaCXGVs/50nUYBcR4Dbu/I8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=feQgAo92kl2N6FzuKqoSjRBDtPimuFTiHmmzqjBX3qmX29PlP+RC8Dc0oZzrS6cr8J6QtrY/R53fPgAvVoVBFLgku8gJNcrOpHXydForslWKO4yzHvXGVkwlJ1RrDojtso/pWx7yUKUdi9ir/nj6iYFtQkVuQzDFOmdqt3/BZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsYwFIxR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsYwFIxR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 026211400106;
	Thu, 16 Jul 2026 06:18:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197119; x=
	1784283519; bh=JulQMjCCONoobf82CW2km0pSqotDKY8JR4gRwV7Uujw=; b=E
	sYwFIxRKejWFltXpIAZrR8Yiw3jWYJK5G7vOgBCvlbiirAFUzishOxpAyp/Rpo3r
	gsCG99YDAvNqbp3refyWohScJfrTJaAK8DQ8I6wFRvLK2s794EdVOn8p3KjIYzkS
	bNGgGossHMMmm7cT6/rMTcl8fSLH87U4L506lkLoG3+joT6lT7Av+/M6JS0rJSOY
	9D9wLzZr97uZMlSiCgYwJ+ojsdhrNgFkirK8tJsmlMdqCNGd6524e0CCdO9Ehyln
	JzWdUkRw/qx4LZGs9+PrCq7+rHB/lsqYgWhHOTPuGbcKGtlHfCn7UeQNMWcHNs3k
	+g91nLXDlraCq85x0K6bw==
X-ME-Sender: <xms:_q9YatmBrO5e8_c60HCc8kLe4IIugJtusJjsOnoW-ADfU-_1QYWOOA>
    <xme:_q9Yai6fddCh3AjIZ3eRZ6z0bTtwu46FcbWiZ-rcifwdmRwSwQLw1Osfo9zptvvEw
    F7Y1gMMAag4NU87QXV__fQiKZEct2Boec9OrHWQJnnYVW3xa3uxUyg>
X-ME-Received: <xmr:_q9Yajh2WoVHuyruL7xHx6F9dDNObEnTrG_Pua4SOH_2pl_TzHaJLRqvJSpUSWlsTV2apQYosxW2C5wBf7zSgh_BTG87fBxftvo>
X-ME-Proxy-Cause: dmFkZTGS6ZY5pWCItkgy9Xukn2zcuewFxo8ZHHN4pRvLqTF9Ej/jkXu4Mnxg+8SVH62C9Z
    NdfHOTAcoQsik7u3NMaqdaj/Sb4GyhvEyXqxfPz1ORC+VOfUwL7xO6EixFaof20XPTjQoT
    w0gMCsjiGcBL5Sc/2+7W28zCMKgBMJ8o0m6Z5UnNj8t2Ub59pnmCGLWOBXXFwHGukKnjg9
    oPwii2VoGp9LyZNtBuP22Qc33o2tx6mCHkKvSggiUEwKtN1s+YoPNk4J+4iDvPQupo41VS
    yjh7oZu4qBQRwkQZnPNtC4Habjb6Lk5fCXqzalnvP7SEl72bFlt1OaIxxzE5VmPVNQezsH
    yQbPnSI5UhdQEg5VdwqzFHlES8IKgLZsvRBA4NCZ0S8Wn+DkoBSVYBfiS3t/dYOjtpT5/g
    OsRF1KVToL3XCWVbpBJYfa6uGEmODPMkQ66NPkrruoADK/89Awr3UqP6/Xt4q1ekGCxjGR
    lhHz2i8/dRz1qKZG+H9otn0+vIkYgRTtlQIaz+ZbZf0vrJh8hkGfSkgtBfVU3ayERNZG8R
    dIr0WDGYGFOTDavf741bz8PGnZM8xINdcKb0m1GZIhGtnhTobnat/bsqK/gFOY2/TL6Lxc
    VlbR57p4PBfH27As+A+lcoJfNjlXk3hd6dCcnvzzjI/3lGI/r/8BMEaCvjsg
X-ME-Proxy: <xmx:_q9YavGgwyeIica3PZfTq4w5gSBcMHqLBoHQOkiZbqaF7u4rBvznOA>
    <xmx:_q9YapTKnKCOfcFGZUTX3i7hNX0BEFkkjRle1ZznTzt6sFW39xGxhg>
    <xmx:_q9YasxWHM5GtN3Ctd66J9UfwuVY2vMq0nMGbGrPXf11Y7SZA2_aVA>
    <xmx:_q9YalfLWkxUfiUclx0pakzJmlU9wBiju3es71f5tI0BbG0CY0F_Jw>
    <xmx:_69YagU72yDXjfzXoHjV0tURCCdqYF9i7RiEyZ0SoTlYBbuBkZm5ONqY>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:36 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <b54674c57285acfba1179eead2c3b7868c1061a0.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 08/31] swim: Don't start motor until medium is present
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The spindle motor should not be running when a disk is to be inserted.
Don't start the motor while the drive is empty.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c49e584cd663..03a89916d4ed 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -630,8 +630,7 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		fs->ref_count++;
 
 	swim_drive(base, fs->location);
-	swim_motor(base, ON);
-	swim_action(base, SETMFM);
+
 	if (fs->ejected)
 		setup_medium(fs);
 	if (!fs->disk_in) {
@@ -639,6 +638,9 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		goto out;
 	}
 
+	swim_motor(base, ON);
+	swim_action(base, SETMFM);
+
 	set_capacity(fs->disk, fs->total_secs);
 
 	if (mode & BLK_OPEN_NDELAY)
-- 
2.52.0

