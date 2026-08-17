Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3DD157487;
	Mon, 17 Aug 2026 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931951; cv=none; b=jrr5J5e4ZaiQDK5AbaeSRs+Zi784+abO5h4ZutHZQ/viToFl8LOx6ivXSkGVa1pFu22sEKskTJFmeJZSuqLVTB7xMVUzgLw0HXTvK2YHKITetCTuq13FcP9O7+ZKkI1Fbt8slE1yxnzCgtbAeSCBb39OB+9gw4nj6kbS2D35WiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931951; c=relaxed/simple;
	bh=eULRCd2QNmGkSZHMs5L7TaejLX2Kvi8+kNfHo1iDsQ4=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=KcTY8sXVhZ4q7paVachueuSSYVZGg67YWgn05epAQSYWBk3d8bS69zxH5tot0B24UKGYn62c37Ro7dUYcXntF65P4sLWo/tI1ep0Y3C/TI+FUIUJVvLKcSPjgjTSk2T1CS0jWLq0GWyNKen8lSzIIVnyp3D4+alMfAUuJthiOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EUj8xtBc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUj8xtBc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 85CCEEC01FD;
	Sun, 16 Aug 2026 21:59:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 21:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931946; x=
	1787018346; bh=R1DE2V6SDVx8ZYGFLLkdM80PuBCPxQvp8Lue6HaFsPI=; b=E
	Uj8xtBcLitJa5VJDYd4uUjIPXg+S6JhhI7K+nkbBOwZeY8gwY4uGqbrzzrN6COxS
	toF49eta6RKBRm6fmMqmkAJ98kNPqqHp+YmC7pxbsdCl9ROC/zyYJpPnCKJDZ/Uy
	8sUvcH1fnjXb47OvO+wXEn6jRy00MWuUGrk4PniLir6Xl/KE/KspcltY2LojolQC
	tOPyZQBNdLcFXWDKl18ACzerQpbO9znhwdxw11z+Le3pwvIPYdqFP8Z0TEPkG3U1
	AN+LejvRdDAye6+fPa9TcVH+iMbzrbdKCmUuCq5y3IzZwTUrvAl29dH1NrMFXwOs
	6KozPlubMZwrKJWhWiAww==
X-ME-Sender: <xms:6mqCavaqhSAYYFnF-AjFCW6aXxvA-W6cfNpXcoAJPsYorn4EQGxPgQ>
    <xme:6mqCaocumDHL4M0UDgW9q5E4_Z_bohpJ5WVgLkX2D_L_LudNsdMeP3gC-PlWSSx6o
    VokMflEX5ik2hzbAiDLgypxL-XP2T3k_aJY2o15BQinRl9w4krfdf4>
X-ME-Received: <xmr:6mqCah1150HKwUIvO1qrVTkSDrBgd9_wVAyYk7O6AuK5w8StXO40vpJqqRqk>
X-ME-Proxy-Cause: dmFkZTEcdm/H6lUz/GNYCURxrkCd1HPfYRd3zhai/6cdZjeenE7g5xoDzlQAxk+7iMQq6v
    xV9q7s5fsS3/JQzvNsjwyK/4cWW065gbm2GoN84iHcVNvAdCqKzmKSHTb8iEr45WtpyqeY
    cz4yU9C9Fo2z94qtPVV3dAzmSvJhNew7HqXMqftu0soscmI1GAdFoXf04kdvALh7XeUIuU
    Tuk2XE2OeIJdmWhM+PiCh0JMVi0kltBn7CwQl945VNkrHoqGgbuYhi8WoWtxLKIumeRTK5
    /WtK4yCHPyxyd9XATZrYk7BUHibsQzupfidfoh//hSLpDEkVyPVHII4Kj/fp06fOz7jScy
    aSnZHqetEhng4HTldt/HSedMyjo7oqymf/lePQMOy4DCklTcyOrZsCFmQIyMkE+uosH47D
    wmxPu2WMeEfNWOeugifdCZ7aFavyTjP8z3o16+FzrOnSGyx+lYmBRHaczW+V9NsYd6zC0c
    E30cbMw865pdw/qcCh+1PAksFsChTK03c8UvKBI00VXmFbhz+naDMslRUL3pL3j0lPjU14
    3xwFZCsKBwvzcAMXrnJH6cSPhFTKb8qMh0VW08Ysv3cFoPFbx1vDk8xxgHlGb1qtokBRkK
    pSnMWPO4w2VmbLsGdC/oGEkRv9/bJBJQYEw3kedkaZv1kIbd59coaryht2NQ
X-ME-Proxy: <xmx:6mqCanLm6a0R9jqrj4u9qfiQAYhz4tVy3TpKoB1OPNbRt_Ni5NAkKA>
    <xmx:6mqCaoFIRhKbysZBeArovaoLNK_GFwPQQwJabt5p1ozkGinTRQMrEg>
    <xmx:6mqCarXi5RaPKUQGZhuQc5tBr1mzG73PZUk3JttlGCT89mBdyYS4mg>
    <xmx:6mqCaoyzqmbFTMNZTSBU8snbuln__OVzFWAWphtPK6Y_0HZANdVXIA>
    <xmx:6mqCakIyUF0X2r8rKn04zYh0p8vQGR8znHXxhEv6JedOqEwOel-XFMiP>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:59:04 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <1839f5862246006d5aab0841d95ae0793bd3638f.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 30/32] swim: Define macros for constants
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Define a SEL_MASK macro to name the anonymous constant. Define STEPPING
rather than re-use STEP because the latter is a command bit macro (see also
GCR_MODE vs. SETGCR). No functional change, just better readability.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 73d11e827e5d..69ac02b8b256 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -105,6 +105,8 @@ struct iwm {
 
 /* Select values for swim_select and swim_readbit */
 
+#define SEL_MASK	0x100
+
 #define SEEK_POSITIVE	0x000
 #define SEEK_NEGATIVE	0x004
 #define STEP		0x001
@@ -115,6 +117,7 @@ struct iwm {
 #define SETMFM		0x101
 #define SETGCR		0x105
 
+#define STEPPING	0x001
 #define READ_DATA_0	0x004
 #define ONEMEG_DRIVE	0x005
 #define SINGLE_SIDED	0x006
@@ -271,7 +274,7 @@ static inline void swim_select(struct swim __iomem *base, int sel)
 {
 	swim_write(base, phase, RELAX | PHASE_PIN_DIR);
 
-	via1_set_head(sel & 0x100);
+	via1_set_head(sel & SEL_MASK);
 
 	swim_write(base, phase, (sel & CA_MASK) | PHASE_PIN_DIR);
 }
@@ -366,7 +369,7 @@ static int swim_step(struct swim __iomem *base)
 {
 	swim_action(base, STEP);
 	udelay(150);
-	return swim_readbit_timeout(base, STEP, false, 20 * 1000);
+	return swim_readbit_timeout(base, STEPPING, false, 20 * 1000);
 }
 
 static int swim_track00(struct swim __iomem *base)
-- 
2.52.0

