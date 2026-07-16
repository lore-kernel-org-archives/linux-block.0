Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC0409134;
	Thu, 16 Jul 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197080; cv=none; b=fq63GeKPVoh02H5EjNq9Cs0FHtlhh5PKoGfOuhifm85PkcDFQdjS9+kkzJhoWZYVOgtF3qShPjGquEILN3g/UWTGSc22mirnjsKUG5fvsKgeQ5NjUOBiHam1UuN6J8uH19OaqNqjcf7Ic9F6I5m4ih+pZqoausk2RNVYTcjt/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197080; c=relaxed/simple;
	bh=NSqQap68oxV7eoBPsR41ukmr66HCzzvF5hQYA1qhZjs=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=U1x5Hki9I+zgnIUECwgUDXlWocMi9FtfE9aDYhyO0bELShcTrbseNtPopLD3VeHZnXbb5DYT6MIRtyVSvSWjYqC5DE8J0PtJaFy7SMKOa5fdeK2ImnelxiZ8xOmmBDQj0dKqGZYEp6FLYFv85x9pH+5/SbGOLp5nB6rzb+rAHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+EyQWnV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+EyQWnV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C28EEC0178;
	Thu, 16 Jul 2026 06:17:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 06:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197074; x=
	1784283474; bh=jSUg0JfrRNEks5cQ476tnZPfbAgkMLpeEj/Q9ls7Jco=; b=O
	+EyQWnV5QKh4cGNr5xRihsb8+w10j/3ayQ8+vCCWtXZDIMAALkCK8gouUyOd8YEj
	iOsqnZcMUzl+4X1W77+hETIeSredW5ppr0fAmuglTVc3WKNvH12n5zQbO8eQWVN1
	JOKxEqzCNDmtnwMUCN+N/FjFFSr8kITuKgnAQDvzW9VbCQvyJ3CA9+fMGW3aRhSV
	oFP+boD1E2viX7TBFDhIvBlIiR9kKwrB85nAcl3hY7QK71n7TrqXfuERI54v/Sgz
	XTHyqskm53RQMTsXJBAv8qVY0y9/FL2Zn8FnBv9Cchmjv9EBWX/0X6+NouMuByco
	Mbx6H0HRhCZgk3y2G4R8g==
X-ME-Sender: <xms:0q9YaoiQ-1fbPNk-4HQ2Vx5Efw988kc7zHBIoOdKn_90SDTASjGiOA>
    <xme:0q9YarEZpPkqxaacL_BElAr7aHeMCQ7Yswjl47KI4kYK0ZZx0HauDDbaddDttHwW7
    P5SoAYeixffCq127mTn65N7VpelrPBNhNVpjR-kpUqlg0HlVzr6jT8>
X-ME-Received: <xmr:0q9Yav9R-loC2XIpDByn89gzFO8toJWx-dGQqP2CDnFrgMoKT3vTZ_TsF62-_gvFd4q-2Vi1qqXfPv5S-U1rHdoAxoTefwkoWrQ>
X-ME-Proxy-Cause: dmFkZTGS6ZY5pWCItkgy9Xukn2zcuewFxo8ZHHN4pRvLqTF9Ej/jkXu4Mnxg+8SVH62C9Z
    NdfHOTAcoQsik7u3NMaqdaj/Sb4GyhvEyXqxfPz1ORC+VOfUwL7xO6EixFaof20XPTjQoT
    w0gMCsjiGcBL5Sc/2+7W28zCMKgBMJ8o0m6Z5UnNj8t2Ub59pnmCGLWOBXXFwHGukKnjg9
    oPwii2VoGp9LyZNtBuP22Qc33o2tx6mCHkKvSggiUEwKtN1s+YoPNk4J+4iDvPQupo41VS
    yjh7oZu4qBQRwkQZnPNtC4Habjb6Lk5fCXqzalnvP7SEl72bFlt1OaIxxzE5VmPVNQezWs
    AMfDbXFx5xwYaMyFKO3X5jky9MtyQnU7jv128bGHC6g3zm7pdfhkTa8M8GuwTwEM4V5fw9
    vAECgGxF+0chfsurUlMhANgF8ZRJn2KG4Wy759Qx8tceLw8NSk5S+CV54lDFPNtY95RyUN
    qfDL6jS5x0osDnRrJIi0fj2QMA6Tc+DCkRSLVQWSB5FxKBYifTwYW/1goQ+FQ292nt6LNv
    WSZax9RzxeFbz9894OrKJbuJUGgtlKSZ6fW2o2N4qGNQz4NVz1MYAbw5BHIVr9dMza2kCh
    jWXB4ixnS2jEc04T2tcQhM37+xWY4mh7+91eDv+hL35zXYK5D8L+BnK5xnbg
X-ME-Proxy: <xmx:0q9Yaqz-vOkfvBZ1hGc3_CRz1_zSLc7VD3gtRz8nBPsik11r6Tjp2w>
    <xmx:0q9YajO1Y9TETKiZJCzSY55SqnwOy3KI6T-F6OP2zehVX7tvDTkhLA>
    <xmx:0q9Yan8WLb1vEMJ8AUCstj3mXnt1EkkNPhPR-KugdVM_96sueITRxg>
    <xmx:0q9Yao48uxVULIGGSCcUugAVCppRiJKXrxYgtVSXNHctf5XlH05vug>
    <xmx:0q9YahTra_voNgqOVWc_AyW02F3hTg6XrSDIwTeG1wf_OhgtWjLeOtud>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:17:52 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <5d8b1ca2808d723fc58aaa7be4bab7e4d9eb946c.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 04/31] swim: Don't disable drive after every sector
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This fixes multi-sector reads on a Sony drive. The Mitsubishi drive
doesn't seem to care either way.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 2a400e544959..f9c59282b81f 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -473,8 +473,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 	short i;
 
 	swim_track(fs, track);
-
-	swim_write(base, mode1, MOTON);
 	swim_head(base, side);
 	swim_write(base, mode0, side);
 
@@ -490,8 +488,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 	}
 	local_irq_restore(flags);
 
-	swim_write(base, mode0, MOTON);
-
 	if ((header.side != side)  || (header.track != track) ||
 	     (header.sector != sector))
 		return 0;
-- 
2.52.0

