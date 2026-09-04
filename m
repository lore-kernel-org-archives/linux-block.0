Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA49442FDF;
	Fri,  4 Sep 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514558; cv=none; b=FPGO6/zSrqVaBchHt61sUIt89zwdJBgUe2EbMC+gn7ZGnzEpf/BzdrhTS59FIcZBhssv7Bx2mpLa51HC3LAqeALDFvUe+a8nEjhU3kD5jXJNn+vQ26G3464oBysCtLgjQbNeeZNH1v+JNgHID463mHdw8BM+CjwOA8aaLPq8ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514558; c=relaxed/simple;
	bh=54s669xz9R4knQSDFIxGY95Jbs1iNwq26b5KurojJus=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=asRU9jTLjg01ETdn/OA1esPq0iXVIeHa2+ANBTrxTY+Jm9YZocLb7RZBBc7XoAC+y03XukFA/xtAto497Mfkq1N9qz9Zhh1VZ+F9eUN5t7XDQwlOqutJ63gSFMy4bQ8JYQy3dzY7zlwqay/zkpSq2wsrWr6Gf/kuhCbEhGQrHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ojDBP+D0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ojDBP+D0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CBA6FEC01CD;
	Fri,  4 Sep 2026 05:35:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 05:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514555; x=
	1788600955; bh=kMa4KjbYmjabaIB7zCkIhmIco0mIOh9GB0j7GmK0U+4=; b=o
	jDBP+D0HzaKWgBbiITJ0ncR1ADpbu/gXumY2HzwzpGbgR+vVbyeADF2RYaveGh6M
	EiKLtDzaEX21My9ileXh8OyR+rPMdq3wk41u2OIEVTeZzjIo1vX944n9IOE8qo0v
	e+muCCFLQGMK+7LeKj6FEzGpQKIeNSQyy9OQM7z18Vi7TBr9nXvdj6wRc9iRKX31
	ZqSg9wuSe/i6IxgxLU4Z0or6HdCxw0QoHTjMm6vNYJ+rxq07j+l6BPW4ClF6lCng
	rTgUclA9c9P3oVH7/wZLA5p+KlRHBmYDd8iwlS/fjj7J/fOqiDwaFmJNYSsx0Xr1
	lwGrdXDEMaDeYFFOd2uOg==
X-ME-Sender: <xms:-5Caap3UiLxh4OHMfQhZpYt9AhjkTRh-7A3r1RqjSR5a1vHSV33PNw>
    <xme:-5CaaqL0UK61msETh9wkK4WVMKQJ8zdYk4Mu4XLsWt3B4HqsbwHLkYZ5pHn0Gh5yo
    Snfe2i5UYEcbfuZrxYtj0z_eHiQkXJvC1S2KrdKnE-z2JI6N0cRiT_Y>
X-ME-Received: <xmr:-5CaapwQdGmZqcc-BWgAitZat-C36-NfD4Oq-w9tCvy2-vgiP8seV2VlfWO3h6W7dWXfR5CId3Nn0r5CKhlnp466zdB3Oot3ezc>
X-ME-Proxy-Cause: dmFkZTEgSwz66V+qSU0onCxC1F8ShoiVzEkD4nv3k8arPvEJrRCttwK35Oooa03yDS3V7Z
    X24bDVU3zk97dZjGWhXiX/ncGofJJNeEuYKgl31r/eDK9q5L7nwuD3/hEQU4j57irJs8tO
    84Cp9nRkKueV+P/Zh+1MA5C3iN5rv0++YXPj7VEh4HRI8ixbdKjZUIuiKKcqpAq6/i16Ze
    PQjCFsqYVbtDn7r5YuWGcGxoEjqVvREju6nRSm6O4BMaQ0J9b6++FaFcvgP73aZ6WigYRi
    RlMdiJjw76SzlSBX2alJJ3NXs6ywRX0EZbPP0m8cGOgA5DoC4o+kLwJIiLSJDXjG4wSOWd
    BGUbTFruA+0pFCU8Tb0J7j06EvzYhq5c0S+S7D/wSSH/sXYelGRtHPbcEV3kMV00hQ2qxX
    7PV4m7V6HqRDzRnfMqKOsoDh7+rgAA3hmn+dN0lSTD4SlfvraKTmUiiwuhQNIMEtQ5YJOi
    xM9h2ymqVtOGbnDZPCpdW9oyGpUt5vJmb+X+WSZmELU09W7nFKS9TaVsYR8ZbzBhiNB0B4
    qrAVxnhVc61LBH+lOpP7em5J3O3PkMkHr7qo4ND2+IqvVp0julfc9CXxfscYc8+kVX94jh
    YJEhEFSmISBG9rxLMceGXq8MHbZ3TLZZF+Jh27HSRzLQAZUu2rl/uM1r1bCA
X-ME-Proxy: <xmx:-5CaaoU1kFOcjlJDtKr4Pk5YMoxehEZzlcig4zd3asrdlfvuOZdFiA>
    <xmx:-5CaapgFpWQ-gp8JslX5ITg3LfKbk-IW5Dal7rotU57u7vm76-nQQw>
    <xmx:-5CaaoAPU4qEmSUoCatcEakXFgepUiMpT5gX2x-tqrEq20D9o0P5sQ>
    <xmx:-5Caavsnifc4WLmzS2FNE23Syq7F-PklMHTt26QybRfBoaTHsnlJ-g>
    <xmx:-5Caakl4S04W7MHRVn56IutPz3buTOwqulCr94iUk7JVvEEYGhHBCr9A>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:35:54 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <613fa64bc857fecd141b5049eb9188ed72c9ec52.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 27/33] swim: Move swd initialization
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

For better readability, initialize the swd backpointer along with the
other floppy_state struct members. No functional change.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 3ce73176da2e..f249b96339d8 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -764,6 +764,7 @@ static void swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 	if (swim_track00(base))
 		goto out;
 
+	fs->swd = swd;
 	fs->location = location;
 
 	fs->type = HD_MEDIA;
@@ -853,8 +854,6 @@ static int swim_floppy_init(struct platform_device *pdev)
 			err = PTR_ERR(swd->unit[drive].disk);
 			goto exit_put_disks;
 		}
-
-		swd->unit[drive].swd = swd;
 	}
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
-- 
2.52.0

