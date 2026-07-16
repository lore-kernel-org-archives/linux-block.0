Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455FC3FE36D;
	Thu, 16 Jul 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197063; cv=none; b=L9pLJolfYhJUSUMI0UMx7+Enk7ePoCZk+UvPD82+9wWhbTS1QOvDrDXC6EI+Uy851YCzXhgxP6uuz3KJeplxdz174vnZ28ROZo5LeyRXjFhQc/1FWoaWZsHjBD3jpzVBygLfOKr9gKuQc11aOiv4fyq8jaIsLK8sEmytXmQxE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197063; c=relaxed/simple;
	bh=nR8Bhkb63ZhFhNPe1jBxZd35nnVQUX18ICFPeklzAWE=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=H4SbgPKcVf4IXGZTDXccNb65Xn1MocuE9bVW+OVsLhhtngN0ONbIzcwN0LVQiTxEZmKqWLg3tXgnBhMGOmfa3OgZ95NgvR26Bgkz/Cka0a0+UWxUQvBrY0l+dMDW0k9Hi0GL98EMYO+mTDhEZNFrrpZNIoxAaytuY9eTyoLxOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5N7AFwh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5N7AFwh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D2F3DEC018A;
	Thu, 16 Jul 2026 06:17:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197054; x=
	1784283454; bh=IiHfR3dkSc8CqPCk4PrthFtOXM0/3jWdMR+ayM1o+94=; b=E
	5N7AFwhE+6z6CtDQ99wFgUKCiByUYqbulvmleZx9dXMO+2U1SESHI3EkVUqGuIpJ
	cM27oZTZpUNjNrKZsUJxuyJ6i85PSC8L53mnn3C9Xukh1cbXnQrHhkdhu4Dn7QXe
	fBdfR5mLMISA/bqYUe1Fw61oPB93Mhc2IxpW8nIPl5/vjt3pQWjvDPzqamWIS4Ed
	25ERCtM5hfd7uYBJcO0DarBa+5/nchBYqGDHkPt+OEt9UvySC1bhXdU9WF4CfWNk
	RFvGMWsN92PuOAaaIIwRo/vC4S0ukrzb5C0y397NdJ3aJ1DQGfx/HPrhXZWsVpM4
	W0yNJXEQ8/Gcm1lBJyL7g==
X-ME-Sender: <xms:vq9Yai8ymYggnEjwNGNmubJi_wsskVIsYe-Rx69rVIOKksBqGLLDEg>
    <xme:vq9Yasz38SMHIiCaUAJIWY1jbsiNdgaexGW4sSmC-hxKvpCuB2oAVG52uX_NB_rmF
    kxTr2Cj6k3-SgBLHOoF1tNzn6ZFSjglXdNHbRMO9QfpizS0GN0O7zin>
X-ME-Received: <xmr:vq9Yan4lkn4BlPNIUsE02Hy_6xi53chzM3tnlkU8eEwsqHP2ArV6gdZejCqwnlpJdgOZw37DYK_TyFXxN63HwpX4sokC0yn6ug0>
X-ME-Proxy-Cause: dmFkZTGzI2aLcpyEy9nVVRe+p1puSXyGiFuwOkegvLV5hF1dM4TwQ9ctIAc7UO1JrLgUVL
    0Qf1UAPSDFljEBGF3mzHdZTArWymB79zepl6mZFo5vgSrOnp9yRH/JuicCcCQapseF2BKZ
    S35V5lDoE7pIHzg6jF7nY2TGRyGR9cPafx1E2O/z8WUISzV1pQG4/2t4XzhoZACdQHMFNN
    Nq7h4loTYPNRH91kBxs38qBUnLLBYjud15UFH7dDX5VGb8q0WgJc4cOluX9PiVFhnJIEMX
    AMJmtz01gIfuHDmEXQvJag7YxjgvQkhDtQx8iuurB+XYNCqq0Z9xFeZZzkNoEyyM3WG9Am
    6Hl7atAw9qmbtRC2OY4dw3/Rp7ejsuCvciIQSgehihPznD/2/IrHXA3lrWyW1gxNSm3gIP
    s22DyF9PoiFPZC2mzeL/jgE6cTDnYDbjbEdK08+oV9BduB20ooMly01ahXvScdpoD0PbQe
    wbr5QwWJ3JOZRe8NHZYiqaAgXNpFDzEEfw8kIWH+cX+WZvCJolLSslX9RXq9nyVNMfcdJZ
    gACtT25C3MQFWulW/WsOkZfikOQa8xEcRiYhwk3K2o5NBkL7dNDxUcIHMrJXbizqNb8g+s
    JklbvVRfHW6wFzhcaNJ7HiudxBl1OKPionhHQ9c9M2Qu2kdxex8V950GLzOw
X-ME-Proxy: <xmx:vq9Yar8lepSLgn1Z5La85xmTWBZst-6WUiRqu4D24KLAM_KZZPdyrQ>
    <xmx:vq9YakpqjPdgD4ovkQ08aLo1FjL-8EfZf5XNsvIrMWQecgRKWYT39Q>
    <xmx:vq9YakrbaCsBhOFAvIagv8ZVXctij8x-iqx217B5zNHWBL8TsVZqXg>
    <xmx:vq9Yav1oIC00qgBG9Y2VLAeGPviUlXaFvFNMc9YMSXrFepqltVbJKw>
    <xmx:vq9YahupLKEdugOfM0zmR5s9qErI4ZhBgOIz-SMRnbUkCHWEcw7--asK>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:17:32 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <de25705b252b0a8a3f38e0ac3e21721b80f3c7fd.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 02/31] swim: Select appropriate drive once only
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Before turning off the spindle motor, call swim_drive() to select the
appropriate drive. Remove the swim_drive() call from swim_add_floppy()
because it was already called by swim_floppy_init().

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index b61e92d0e3e9..2c52a210f4a6 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -679,8 +679,10 @@ static void floppy_release(struct gendisk *disk)
 	else if (fs->ref_count > 0)
 		--fs->ref_count;
 
-	if (fs->ref_count == 0)
+	if (fs->ref_count == 0) {
+		swim_drive(base, fs->location);
 		swim_motor(base, OFF);
+	}
 	mutex_unlock(&swim_mutex);
 }
 
@@ -752,8 +754,6 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 
 	fs->location = location;
 
-	swim_drive(base, location);
-
 	swim_motor(base, OFF);
 
 	fs->type = HD_MEDIA;
-- 
2.52.0

