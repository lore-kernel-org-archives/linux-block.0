Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5D3EFFCC;
	Thu, 16 Jul 2026 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197089; cv=none; b=nwegnOSbkVJdQxlNwpFBVTaeuHX0l/UzD1NXonUus08pidPpq+dMEGOTAQf87IJsi27Kyl0aDCc1J40jlFc7kpQydiqPDToawbUYKuugIzLHAdGGT6rEpAdMrJkH67O0iXlX3SCbftH5IKTpex6B1rkr0vBB+qGcfCEN3TmOyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197089; c=relaxed/simple;
	bh=iLVg4c9ES52y618/8/2BU3H5JNM5H1yEofSQ7HN70bo=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=SgCXfeNb4uUsIIHj//ZuDEJyXPUzmWp1Lt2rlMNeiudKFp6wP0h/mgFbKj0PnDRsceYqtw2TFZhLJu3xCnd5BRsXUGTf8Mssch716uJZw5ypkv2QL0xVAQfYVkf70WDacXuUuJKu/uq/6EhBvkp0mevxQK3hlHKCB1jU1k9xPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyF//DAv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyF//DAv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77B921400037;
	Thu, 16 Jul 2026 06:18:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197085; x=
	1784283485; bh=f13TDbiJGrkIoRyznIbBBmax9zFyYrrEPd5qSt7wLl4=; b=S
	yF//DAvv/89SMoiPF7m8UGbRLj9USKipwbSF8K6l3KjdGxhMMFVjm+ZjZy8lG8TP
	dzUYJccBD6cZFTnVsMEeMDSp5RjUhxiQexSHmd4ZsXJy0VEqwR63WH/yDGfP17uw
	z9ctaQ1cJ/VVrqaG0XIluwu4kVw8HH0iRUkcP7292K/g/mji88pNx92tEvFFlQC6
	nz7zZEU8PpBxpf0HLuajwDUzYUPr8ngSnWn1USlfbzYKiP4pPNuwLB3LP/jFtOnP
	w7+7ooSioPMfWtLlQneXrk06Sshae1htLWgvDdeR73U+U0VPPGJFl+J/bLPkujEW
	pQ+AI/Tq94SAgT1ZGqGRQ==
X-ME-Sender: <xms:3a9YagQNjMqZWMI0_DDntHHmqWcshyzEUJX9Y-LHJCD6jXtWHBYnrw>
    <xme:3a9Yan2CUNvHPeBq4nAdL4PVcV_lqFV7v_hNkLaVNK0rGCo_zz8YFe5J7BRE-fotr
    -PjGlYtzcpEipLyrhsM-8nkhbLmtfZAgR-aNaWw4DU_Wu4cIJiMz15R>
X-ME-Received: <xmr:3a9Yats4mtvdBSx5ek5hiuXHmSklzBB_Wbher1p4hSmjiYm2_Duinjb95TB7DekEivqEug5y9M_cmIHJteIxdFzjPjE6Qn0QjBA>
X-ME-Proxy-Cause: dmFkZTGJkyjVOqFWTFhhW3dcsO1Ex7OYdMI79TXIQddU4mRizEzqsOJMGzE6pOE5iEVdoS
    jAUlbhtBqJ47/vKlxSs0UHEL//dFM0BebfKWkvvXkAD/mx/YzSw7Y10zK4cgjpg21Gl4u/
    Ih40PNtFHUjN1oJvnARUeNW6S+M+NdObhGFx0HW6uyyDqJn6sMoFJhULBM+IWKeK/vYv9w
    n94h4o5L+kqAPuH5pDiWBbUyCNHQcv+3p240nN+oOS15/la73DFvraHYv0orTYEFUJSyGw
    DTByq+ETxzBkZeAoi9WwYzeHvtGk7SXgt3diFkOa4ezDtHEFDl8OazNc+I2fRSD9Se3OM6
    SZESdjiAl7fmJDkZaA1nbce3U9K0JxWNrQUTU//p1qsI5pVv4mW8OOpoGYb9qS0ALS/9HK
    Jb2mx/TU93cgX2Z72jgNdqzoxDdS3hpLlajN/G290RvwqvtBIbL5yuu8JETgij6t3ZDq2A
    +qdONmPrsV6/kwZU3qGHJCvwksxmQiJXpsZHosCNElBoy0KR5x/7fWFh9eei/gLoNoyWNf
    keibHdU82xmRBxZMBNkHdfabnRfymbUZkhmk3Uak4wkFBI4xRQKfZ+tXcqJpJcl6tmIIfL
    sl4+2QRboTSAhB5sIL7+e63TJAe2AjG1PnXLNlnFD/frKp9DWjB+d19MEcug
X-ME-Proxy: <xmx:3a9YaljyC_LbFdLLZXw9dh2fT09VqnebfH5SkKbMYdvJmvHagTL1tA>
    <xmx:3a9Yam_9fRePJsealzGIKb0sPVi-2_2Z66tImSZf746IIm7m56Emfg>
    <xmx:3a9YagvAk4s2ybG1t30j2zn1X0TrmX5LGFq1EafJ_WYgpnCE_iM7Ng>
    <xmx:3a9Yaio11egdYX7cdzL1Xgr99XYbPdZSbZP1VHrrhFLyYG47Ybyqiw>
    <xmx:3a9YahAFUWd0JuHvKlJx1xfshVvkcSjt-EZBWQb90vbu0NkgZ20TJNnw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:02 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <05ab4a40a3fc2fb8e80c2ad0e73d0fbc853c95f5.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 05/31] swim: Perform ISM/IWM mode switching according to specs
Date: Thu, 16 Jul 2026 20:02:15 +1000
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

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index f9c59282b81f..7499ff250ca7 100644
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

