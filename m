Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F81A683A;
	Mon, 17 Aug 2026 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931712; cv=none; b=G8SePgeGS59IW1igKlIfi1yKQVVRPaM9EswrwL6Ew6Vo07XJARKPV0NAeXyEpArbXxCl7EDymuVKTBvkSqAynBG58tnclVHtWrvD2Y0n9LiIrthuxbuOLE9IjgXbhpJdBUwY8pAehfaBYYh8qYVEMTgHM0XOkrZDWY6N7bRYpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931712; c=relaxed/simple;
	bh=y2aq5s8D/L5khZxRe/cFjwbxbHS1B0FaloGAs2bTUlw=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=huuPnOca2P6MDnm1uVYyRFwGozXyqiBNWh9yaKhsilctx9tcubmDhAkcO73E/kxX2rF12jitMKOSLt0USKgX5CQjUw1tn4wxVHDG2A/LC1cbDbcrvQviPttFoN+ZYgeyOrWdGSwHPMOJOxFd9cNKiEwX3bhnYwygu9RgC9JRXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3TsYzBQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3TsYzBQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F818EC0217;
	Sun, 16 Aug 2026 21:55:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Aug 2026 21:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931707; x=
	1787018107; bh=0HLz2220nu44BKt2ov/hAQqSq0Y4djEeSPVWO+Yzb0M=; b=D
	3TsYzBQaaGUbYAH7BJfMFzo7uSs/8igaRXjSecBc9lFXo6agtlidti//moY0ya6G
	ponbhQp/xIcFbLe8Q86xqm7vnKqiZHqv7zm+xFFL72KkRK5L2bOTFgors2KZUM0J
	u80W6cAkYaQ+XQE0+Br2KiY2dbb76vhLUqqx+3s8ulFDvvEzrH9k3BsmddIu3/Nn
	3Dm0fwag5tVN7VkInjpzaX2PXFYZFYwZncQEsIrrxvv38PGck+oLkMGBlkYQnGQI
	UCbTPw0eSA7cMkf3GN01ltOFdyLu4f4rB21ZFecHByM6rm8zw8IQe41y/bhHMRwx
	gNmzS4hi+KAPoP0NMMAOg==
X-ME-Sender: <xms:-2mCanUUSRyY6LOZs4If3Fj3SExMJHNx1k711KthnpQ1yIYdWTRq-A>
    <xme:-2mCapozqFfyYAqcV7AvYF3exOMJqC6fu91vg1vEeQqgd8vUw-BC9VlZgivLYBwcx
    LiAYd_YtNm7oKvAXuBU3Ekyg0D6nWocvt6jh7yvj9u_DgyyLYH9irY>
X-ME-Received: <xmr:-2mCajSwzAJJL7q1muidR-hpiJ9rgXAMrTvo8H9d-aG1uo2z_bOh6GfxnvstUt0_rMp-QtDYuw6bPJxYd_3DfBL7zFkcwNAJKuc>
X-ME-Proxy-Cause: dmFkZTGNmzENqalxDTfCkkFc7mFU+8/8u51l4usXC2H+kPVL/IH2s2NYJxgIYjtBYtArJA
    YWtyuDuajqQPlQd9d39HppQGgAciKWsN5vaSeS8TTvkVHVx1RLPosXGbRFJQPSd5BLLYVy
    eC1VIy4/prdxHqOKz9F9XzgS4LWYfaliKe2CMViR9dDdyGPbLM90F38TD9YW2MkJ0tIv5F
    Ml4DBCJ2CjSI2ieswFMFy7Ro4IzVcMw8i8Or1S6KLLExG4iRUFFS7PoCzWwG3m0EJF7GAr
    uN2VwdTVv1tA6XFTaF1EIrNDccscfKI9P6vDWUSZluIhB0JYi7lhYJmYYZKiGnpyDh4knY
    wsfHphzCC1qYfQUHzuIwXxXBvEqyDEkW5YeX+6pYP8VMNR/hBkKjCdkVRB6+zfG91XhNkC
    n9gbgHbSh/ZmultLMvQBWYtboa9CCSlbPqEJdxQPlqiJAm6RjGcP6KQdunB1Cf4B074rYW
    q+y0eIjjtM6loReTpoC1HA9meXym9K0/Z7SpZ/Pk63NHYC+2cwlJ9v2prbuF0jF9kNaBqB
    ItsqRXOS9YeZpVi6vWyKPvUpf392JZaKKnAQGs12BfdZMSRRYgRmlH69phM/PprmTDzb9K
    p64g+9ME+CUsWeWXl90204qeS8LIDAIl1jcrqB6QecFvFALMLMjc7ZxQNOAA
X-ME-Proxy: <xmx:-2mCaj25zi0UQ2LhZM-BHDYFOraVDS9EVTKxgHk1jaVOxJmbiszziA>
    <xmx:-2mCavBqOnn8s52-dW5FkSnDwKf0iRbb4ulDEwGZWTuEc4YIclsS0Q>
    <xmx:-2mCavhFHEQ0yJL9DKcM2eHdp3g1jYEWCBTCP7J5iqQ8J_heHiV9Jg>
    <xmx:-2mCahMpxR9wIr29G35xCQ-Q6bir6Wkv-Fu1NU4rH1kDEp-_dLn7xg>
    <xmx:-2mCanROXuMeoK6AknSKN5gL81actuRl98k3xgm7M4uGUOQ7kLZIr9QL>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:55:04 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <873207193565455585f3116bb0d4ce95b600ce3e.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 05/32] swim: Perform ISM/IWM mode switching according to
 specs
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The SWIM spec says, "MOTOREN must be low to switch modes" and "after
switching from ISM to IWM, the very first command must be a clear L7".

The ISM spec says, MOTOREN "must not be cleared until after the Action
bit is cleared". Perform those operations in the correct sequence.

When switching to ISM mode, the Mode register has to be selected with a
particular sequence of bit flips. Set q7 low then q6 low then mtrOff.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 3f92677ad127..190b2e1b5b0e 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -149,6 +149,7 @@ struct iwm {
 #define ACTION		0x08
 #define WRITE_MODE	0x10
 #define HEDSEL		0x20
+#define ISM_SELECT	0x40
 #define MOTON		0x80
 
 /*----------------------------------------------------------------------------*/
@@ -223,18 +224,21 @@ extern int swim_read_sector_data(struct swim __iomem *base,
 static DEFINE_MUTEX(swim_mutex);
 static inline void set_swim_mode(struct swim __iomem *base, int enable)
 {
-	struct iwm __iomem *iwm_base;
+	struct iwm __iomem *iwm_base = (struct iwm __iomem *)base;
 	unsigned long flags;
 
 	if (!enable) {
-		swim_write(base, mode0, 0xf8);
+		swim_write(base, mode0, ACTION);
+		swim_write(base, mode0, ENBL1 | ENBL2 | MOTON);
+		swim_write(base, mode0, ISM_SELECT);
+		iwm_read(iwm_base, q7L);
 		return;
 	}
 
-	iwm_base = (struct iwm __iomem *)base;
 	local_irq_save(flags);
 
 	iwm_read(iwm_base, q7L);
+	iwm_read(iwm_base, q6L);
 	iwm_read(iwm_base, mtrOff);
 	iwm_read(iwm_base, q6H);
 
-- 
2.52.0

