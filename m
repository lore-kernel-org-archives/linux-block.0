Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA073EC83E;
	Fri,  4 Sep 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514314; cv=none; b=BPzqwsq/i+QEgisyiqwqUJ3JHZRRePEZt2A3Peyn2qajjEieApTgQ8TFaFALcDlAeB59GDN05fZ50d31VRJnNi1olS8+02EhYDbQCXZYdmk66X6Exdk1taeYVmvDFEADmvMJOoq+f01Emc8/Z4zpLSfSN3eBGX63GkAEajNoh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514314; c=relaxed/simple;
	bh=TRCASMM7eelgWS4DcL5aA99Epa/8OLjxiXSiA4njPe0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=E4VB3cNL5GQQQMoprRdG2Brtuz3maJHp3aPHTJDWMLqV+Gij6Spq32k88nARJuaRSR39bBDhhSPE2ANslkuK55+feGjoVbF62EgGwt7eOA95qPhH8A239gwYzg4fnNdhdoKfXvinADImfeM22lCkMhS0P9KfHd/wAxbDOEQFKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwRMd2ol; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwRMd2ol"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DE5CEC0110;
	Fri,  4 Sep 2026 05:31:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 05:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514312; x=
	1788600712; bh=RppOGoUsMSAGAcgwd3QV2Wk6AOZv4y+7OKDIjYynE4A=; b=M
	wRMd2olDQq3xL3gcG8KtxniYS4HI4e8Rr/mIV+mMkeamaUMa7ZKQZE/t48dWdEzV
	Q+bCMlYKZDpQWvWozNFOvSZfRUanLRrjqymkgJc65Y3xraedQVXHHKQqjcCWy5a2
	Ah/2KQ1urHbEGQuLkz9UFwbFC/J8zBJpTVrmLp2tPTO8E1/d6X/IpH1peF9VAID2
	WjyR59fC1njPMeGN66KX8DHI1g9gnB/2ZKPm1Gj3BbMQvByX0uUi8vFGKeQ63jgg
	oXVR8mvSchNlUaQo5fwKM8OpvhEliclg9H0467AfFmzVFsb+Px/uxY3rQTprgmKz
	515+wgLaEFsXv0QxP9YDw==
X-ME-Sender: <xms:B5Caaoq3LYzEPoljKjPFr-op4aNQeq6iOpDheqCGb2bP4jW1s10hfg>
    <xme:B5CaaouB4vOPXPB-oLM5hGpNjLY1wFupco0X7vlNfFPnh-P4X6ynI-fZBEwT_0mMP
    rfpzaDXzfisVx2juDgE8IGIXRU9VNohLOu1jRdSSt72s8vHF0ts040>
X-ME-Received: <xmr:B5CaatFl0sGc71oJHMFut6ZOovXNyLNdMQkNx8YDqpzwVatPThVT52o4JYQCx8cj17YjMFBbTC4pbGhEo9XlngpsTYSNE6d0sYo>
X-ME-Proxy-Cause: dmFkZTEAKPWJVEMqJ16jAjOL9FB/rBffUzJbSVLQHlq9+RC52fsBvb13o/7yjvGYTuY3IH
    ZNCMm3A3s3Wzl4RLMlWp0jCSYNVS7BZQKRPO2yqi1PfebCSoLOeHqK6FATWT8bd3IKpoKZ
    CEwyBEjTXEy3FLlbxSNZDKwf3xO9EeiRAKVkzcAluKXcPMqMkrDpp1BPxnn7TPE8fvHu4l
    eJtWE0FI2UehL/YEbD5REmldbzGnWmAWgAUgfm0dSu3fH37RyKRhvYbjCw4HLJaLhP6501
    B+Avisf8hlO2cQGDcAA1USTZdkjGliJjHtwHNkdXiWoCX0/+3sglem9KJOr2WDslSbN9tK
    FADd69bNJL9Ge58wn8YK9p21Qr8sRPA3zrLI0voZ63bZiLmITjqdF/rPEYHE3bFPkk4YcA
    U+STqLv5Vuph4WhBdJ7c0D7DeChjsFDG4JxSk5BHUfphxkP2ooPN8s+Capuo52aJFBsUBr
    /9AzQD4/dAS+nQpuVJdzeD33jqdHF7FTwt8MbFWBrf9tBDZ+7C2Z3txGQgXITsdXOYQR5F
    tDDZXDAR+scpDpAydaRx6wSSQA5ylDLMJU1D19CU77FhzB6ltQKC3iPXm42Oo/ZB8xpyg5
    tzWD7w+aiQMXkcrb8rE7Iyob+ouJloH17oI4nGQ2I8l5w+ZBElUiJyxWkYcw
X-ME-Proxy: <xmx:B5CaahYbJDeI9ukI12gcZmmUDW1wgmif-VhJkgT46J3JtNUJV3VW6g>
    <xmx:B5CaalUKior189q4bvvB7FEIPXBrag0inB7Sf-tP1ZHrhCPAwPwC8g>
    <xmx:B5CaavnhU7O5MVU98BYXvLQRUKLP5zGLarF7-XD_RKWGeQCKJkQ7DA>
    <xmx:B5CaaoB7hx9342qmvFbYDf9V7D0iz72vCOlnTifnuKECupKQgRxVyg>
    <xmx:CJCaalYL4jlc0lZsVnch-rLn7VkuUGgQAbNLXstGjOyT62aepmxZhpal>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:31:50 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <f5bf5b596a33a801faaaaa6dc2844c30d3ee82b2.1788513996.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 03/33] swim: Enable the drive when probing
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

According to the ISM spec, the MOTON bit "causes the Enable 1 and Enable 2
signals to be turned on to the drive." It doesn't actually turn on the
motor. When selecting a drive, enable MOTON. Disable it upon eject or
release. This fixes detection of the Sony FDHD drive.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 4721e073a874..4ddb87977fe1 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -154,8 +154,9 @@ struct iwm {
 /*----------------------------------------------------------------------------*/
 
 enum drive_location {
-	INTERNAL_DRIVE = 0x02,
-	EXTERNAL_DRIVE = 0x04,
+	NO_DRIVE = 0,
+	INTERNAL_DRIVE = BIT(1),
+	EXTERNAL_DRIVE = BIT(2),
 };
 
 enum media_type {
@@ -311,9 +312,15 @@ static inline void swim_drive(struct swim __iomem *base,
 	if (location == INTERNAL_DRIVE) {
 		swim_write(base, mode0, EXTERNAL_DRIVE); /* clear drive 1 bit */
 		swim_write(base, mode1, INTERNAL_DRIVE); /* set drive 0 bit */
+		swim_write(base, mode1, MOTON);
 	} else if (location == EXTERNAL_DRIVE) {
 		swim_write(base, mode0, INTERNAL_DRIVE); /* clear drive 0 bit */
 		swim_write(base, mode1, EXTERNAL_DRIVE); /* set drive 1 bit */
+		swim_write(base, mode1, MOTON);
+	} else {
+		swim_write(base, mode0, INTERNAL_DRIVE);
+		swim_write(base, mode0, EXTERNAL_DRIVE);
+		swim_write(base, mode0, MOTON);
 	}
 }
 
@@ -447,6 +454,7 @@ static int floppy_eject(struct floppy_state *fs)
 	swim_drive(base, fs->location);
 	swim_motor(base, OFF);
 	swim_eject(base);
+	swim_drive(base, NO_DRIVE);
 
 	fs->disk_in = 0;
 	fs->ejected = 1;
@@ -652,8 +660,10 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 	else if (fs->ref_count > 0)
 		--fs->ref_count;
 
-	if (fs->ref_count == 0)
+	if (fs->ref_count == 0) {
 		swim_motor(base, OFF);
+		swim_drive(base, NO_DRIVE);
+	}
 	return err;
 }
 
@@ -682,6 +692,7 @@ static void floppy_release(struct gendisk *disk)
 	if (fs->ref_count == 0) {
 		swim_drive(base, fs->location);
 		swim_motor(base, OFF);
+		swim_drive(base, NO_DRIVE);
 	}
 	mutex_unlock(&swim_mutex);
 }
@@ -804,6 +815,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 	if (swim_readbit(base, DRIVE_PRESENT) &&
 	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, EXTERNAL_DRIVE);
+	swim_drive(base, NO_DRIVE);
 
 	/* register floppy drives */
 
-- 
2.52.0

