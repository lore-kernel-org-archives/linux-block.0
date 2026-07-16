Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BD40A936;
	Thu, 16 Jul 2026 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197289; cv=none; b=A7QD2lVg8eXjzXXrNMsOwY4QVXzdipbV0AT4ip8WUbahE2rYk/SIBFHQLcVINgba7p5TW7GUIAKtXdfFcCoFRb8F9qnLLUvXsWPHqm7ZYkL32Z5lfrUBjPnRyLFjV/nS9WYmdLDuKjCOrshWLyO/ZHlCo9DFaa4bJY7kU0B0z+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197289; c=relaxed/simple;
	bh=H2fvF/XqQ+h53xRFMvWk8tUAbFU3sycdrcKGXVtwxsU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=sEsIAelq4HNsOboi8yo/kd90QvIHkGWYukEfYYX5AWVYJUIcPkra7tUGvSwK1y5ZOQn+yXDdhVa1BWI6cWpbkhMqugAo8e/IwKGJjOLawiB/6YVpXE0Waz7gXLnKHJUL6Rw5Va1u5gVO+ULDjdiChKQDYNdGGwTV79aftZyWnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkKUJOdB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkKUJOdB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 237A91400041;
	Thu, 16 Jul 2026 06:21:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 06:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197287; x=
	1784283687; bh=9ti8JXbHBEXGKh6MFRKVvQpRtFWCg9tgiph/1FPF3dc=; b=f
	kKUJOdBOE+jW+oCh0GRQ1y4UfGAPmpQqnQ5pISnIbwcqv9S/3EPtkUgR9KGWzBYk
	0xbjTRYqD4fDw2rGNKt5YgG4p1mbroyxlrfSWNYPzh5YQKKQ0Fl73/qeKFv9S2IP
	YRf6+PwRaq4UTVIdjmlhVxgBeLb0tb8YjwQdIhHWn2jXOlXRKxDw6Yrbm/z4LSca
	DV2OiJDQQQ7RtRjZEKAMX/kvYCvi90Ep5iPt/7V4LlNwrlam29gXIHf7UJqmr2xz
	IiqBKq0eqdCMJHmN9dEFNUz7K2erfsF9avyFddSD3y7VRh1R8mvr6MwixshbJLAw
	LltuvOuM4Ksu+/9WHQ5YA==
X-ME-Sender: <xms:p7BYaq8FtW_nJbxTdcsAre2mqyTgu5I5PTl0c78095IhqooZG-d9Aw>
    <xme:p7BYakwF0ISLNhvhbpj0pGtAEMpXu9oLhO38XDvRtSALs4ZsEJB7AlnCQMMKx2soj
    ISFEV8GFy-LOwHncdah_-Tupp8QaSb2ZcrZPUpGqJfTgT3R_FGO287y>
X-ME-Received: <xmr:p7BYav7kPq_H8VLDaVJ3gZe9Vz-gg7EoaFUFL4UncFT37O7Cb9TLzW49zGhWtzzNraJyv31dfo-PWO5NOe1NZ6Fkgfbkg8poxfY>
X-ME-Proxy-Cause: dmFkZTGS6ZY5pWCItkgy9Xukn2zcuewFxo8ZHHN4pRvLqTF9Ej/jkXu4Mnxg+8SVH62C9Z
    NdfHOTAcoQsik7u3NMaqdaj/Sb4GyhvEyXqxfPz1ORC+VOfUwL7xO6EixFaof20XPTjQoT
    w0gMCsjiGcBL5Sc/2+7W28zCMKgBMJ8o0m6Z5UnNj8t2Ub59pnmCGLWOBXXFwHGukKnjg9
    oPwii2VoGp9LyZNtBuP22Qc33o2tx6mCHkKvSggiUEwKtN1s+YoPNk4J+4iDvPQupo41VS
    yjh7oZu4qBQRwkQZnPNtC4Habjb6Lk5fCXqzalnvP7SEl72bFlt1OaIxxzE5VmPVNQezt8
    RBN1drnRXpQvE4iGeesjsXQFqkkbeUWCAHlkh+fl4l9j1aIFWmhkqh6xmMexMm42xNRKWJ
    OOdhZUi4mXrdgHlOoMsgBd1LAFBFs5BDJhg4bD1g/4GUv5FPgpaxP0UQppUIq4gTBERo0D
    ANdTYC62RSYPmF3X4L7oPyMPa+qvXeXU4MFDp7pcU3NCYWHUvFy8fwNsX+w2tSUs0oN4MZ
    XMPOeAlfBQyJYfF2Stkseio8FsflbCq0PExMrk9rRGJZL6OrxNxLMZoWM70ZL68CfEY2eW
    RLLUd/4p3p/yQhJgXGzvR2buVEpYv1Ri9V+eUgU/mS8wug/JzwDw3rOAFncw
X-ME-Proxy: <xmx:p7BYaj-vFAwPfwt3i7HJQ0zFrxOfDzhCOIZWSE2oovva09-gqooyMA>
    <xmx:p7BYasr14X1FATgCbi42XESWv80i1zNIWIXV6zJ32RjGAlkhgD0E1w>
    <xmx:p7BYaspAKtNT3-qkBiYcj_EEBzn7_sa43HIRum8tE5BXLjMfXYe8hg>
    <xmx:p7BYan2gqe1FsZGrMr_y6WAOa4o9gSXrJ3WmzA2Bfs5H-TJwUmTATA>
    <xmx:p7BYapustgwyC1iSx2pG1vllMyrNPwJcN6dbZN39A7cScfZ5KRq1TX_J>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:21:25 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <2cc2eea25a2e1a444d037c3629fd8c144adb94f4.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 25/31] swim: Move swd initialization
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

For better readability, initialize the swd backpointer along with the
other floppy_state struct members. No functional change.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 4679f554fec5..c41d56ab6c04 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -760,6 +760,7 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 	struct floppy_state *fs = &swd->unit[swd->floppy_count];
 	struct swim __iomem *base = swd->base;
 
+	fs->swd = swd;
 	fs->location = location;
 
 	swim_motor(base, OFF);
@@ -855,8 +856,6 @@ static int swim_floppy_init(struct platform_device *pdev)
 			err = PTR_ERR(swd->unit[drive].disk);
 			goto exit_put_disks;
 		}
-
-		swd->unit[drive].swd = swd;
 	}
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
-- 
2.52.0

