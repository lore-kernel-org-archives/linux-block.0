Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED63FF8A7;
	Thu, 16 Jul 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197097; cv=none; b=Z5SZIBFVGhg+kp3c22zq4XRAOMhEEvabsWPOsuUCcb8lYPpLYT5zgZ5AKfHIAJLgxDn7GElQOCogYfG9ks+MHxZlMZW4wdJZ+Vks4Sh7yVPW2NC845Z2MKq+o6kVJEkFcgwDKwGF4bZIMI7mqb1WiQUGrWPy2ISQqwOOaR+7k4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197097; c=relaxed/simple;
	bh=28c8uZwGK98f5adSXHmg6QBbVhUqw83ZA06zVeosYG4=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=A2inEPT0US/qj66Wu4PjkCRucBFy59TKCZvvbSu+z/nIjzqmABZRtZrHle0L5zMJPh+gK9hY1gXKhfaqVslHGRmAfVhDfEthibgykLYLf5Jnhle4yI5R0DtlhYZpxqvsJQx2e7akSL9yQf3M6+mxvSzy4dDzM96CVMwBTGYjeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/7A4XYL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/7A4XYL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 72C06EC018B;
	Thu, 16 Jul 2026 06:18:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 06:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197095; x=
	1784283495; bh=6D6KxxYGvFnY9YiOVAP8n6HbGiDoUSm1zflM6UzzrVA=; b=g
	/7A4XYLqFTFe7VSkpKsq9A3JbPYvg5sCnsvzejlOhgEOsgRuRnuZOxcLF6uW0ONX
	vDyBcdKkLtsf1eKm75lzum9615P2RYladrV1HstPTtf4Kmwn2CCNW1JyYe6bHZ/o
	9afcwwgRwtfM30KfGP9v5nz/8bPEBSQ51tD0zniMC0T4aERdFN+oMe4mNMqVUh7r
	TlChE93VILFmdbtGHt3oGGwVpngWovqj0rm42FiIsxl6ilGs6Kf/AO0ooPlYBYy0
	n7cvHtzQ4WshMH73fzmCULI/MkhN4pFze0YtYCgyjRs7oiqtCG+qva+OIpGN71Hr
	yN04xOpsI3/YJ1ls9AbUQ==
X-ME-Sender: <xms:569Yas9fLsOKbKocN0aAj9dtRNriyHHpa6W_Aau2AGfZ_dxgW5fUGA>
    <xme:569Yauwk9OvMTNMk1B6p_zCShxeYUtkifYhywRhcyQeMgOiZTI2HVxGB9juUJ1-lR
    ZYykGz06GSBaq4jmmRrhCjBCxBVFraCoCpLZ4N7H-GzN3K-91xTm-k>
X-ME-Received: <xmr:569Yah4civUs4NAbjVLlB6n-5kj4EJa1SKMBBAaCluMDabJQZAH7qDgclDdnzUDc0Pk01a13tL8-_o_suJhNtZGe3AudbXkX_ag>
X-ME-Proxy-Cause: dmFkZTGS6ZY5pWCItkgy9Xukn2zcuewFxo8ZHHN4pRvLqTF9Ej/jkXu4Mnxg+8SVH62C9Z
    NdfHOTAcoQsik7u3NMaqdaj/Sb4GyhvEyXqxfPz1ORC+VOfUwL7xO6EixFaof20XPTjQoT
    w0gMCsjiGcBL5Sc/2+7W28zCMKgBMJ8o0m6Z5UnNj8t2Ub59pnmCGLWOBXXFwHGukKnjg9
    oPwii2VoGp9LyZNtBuP22Qc33o2tx6mCHkKvSggiUEwKtN1s+YoPNk4J+4iDvPQupo41VS
    yjh7oZu4qBQRwkQZnPNtC4Habjb6Lk5fCXqzalnvP7SEl72bFlt1OaIxxzE5VmPVNQezEu
    ED0MLmCkewjiBdKPOYP+dNoY5Qs8Q/ivSsDIvewJ8hbiYKcC22NL8ZSEOnPY6wA0IsNbQY
    rT/zKdliFLGi0XG1ybyYpYBTrv4N/LY5mV3helEl3rro54Rewd3FF1xG7/djrvEghnJyTO
    wp+nKfcgJgaSzw0v4ZbuLLAzm8N1F4uoZ6c9HawHUBgyXJsZDmDAsolOdVpeWEPa2CpTHD
    JSMxJyhgOMCFXT2kYEWJ3BwLlD5I9Q8tvF166bb7n8fQzu9t1oJiPDRrpR0+UOJo/wSPHr
    Iz7GiNlqiVBCsqwiWBCs9VXt/N93BnOUCQyzAqVBwtsoiRP+s56x3sR49pHQ
X-ME-Proxy: <xmx:569Yat_nIR-MqrK0-X6iP5uMHFU-91HA-n9Ww8giAXepSwSpxdLhYA>
    <xmx:569YaurR4m6rELejTv916WmZwHxJzs27SXBLt2-4dt60ofLFfDM6NA>
    <xmx:569Yamq6zOOXZNmbYVAYZmqdjCvgWCB3SSMTNlTIpeeBvasEquPraA>
    <xmx:569Yap0pndti1Ge0orm7GiMqjNb9EAhrZWGJUMaIxzxFVEPjL_YVgA>
    <xmx:569YarvaOUsYJxfUC4CbtaxvA6baL61AY_sh7vdDF5fzw1bSD9p7b2bW>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:13 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <e18df7f66a9159421693b3e95fc6805b3bcc90e1.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 06/31] swim: Configure parameter memory
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The original SWIM chip has a 16 byte memory to store parameters which
control read/write timing. The SWIM 2 chip retains the last 4 parameters
which control write pre-compensation, but omits the first 12. Hence
SWIM 2 can perform reads without any parameter memory setup but SWIM 1
cannot.

Configure the SWIM parameter memory with the appropriate values so that
SWIM 1 can read too. The parameters used here were observed in SWIM chip
memory, using Macsbug, while MacOS was reading from an MFM floppy disk.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 7499ff250ca7..481fb1e63ac1 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -796,6 +796,17 @@ static void swim_cleanup_floppy_disk(struct floppy_state *fs)
 	blk_mq_free_tag_set(&fs->tag_set);
 }
 
+static void swim_set_parameters(struct swim __iomem *base)
+{
+	unsigned int i;
+	static const u8 mem[] = { 0x18, 0x41, 0x2e, 0x2e, 0x18, 0x18, 0x1b, 0x1b,
+				  0x2f, 0x2f, 0x19, 0x19, 0x97, 0x1b, 0x57, 0x3b, };
+
+	swim_write(base, mode0, 0); /* reset parameter memory index */
+	for (i = 0; i < 16; ++i)
+		swim_write(base, parameter, mem[i]);
+}
+
 static int swim_floppy_init(struct swim_priv *swd)
 {
 	struct queue_limits lim = {
@@ -805,6 +816,8 @@ static int swim_floppy_init(struct swim_priv *swd)
 	int drive;
 	struct swim __iomem *base = swd->base;
 
+	swim_set_parameters(base);
+
 	/* scan floppy drives */
 
 	swim_drive(base, INTERNAL_DRIVE);
-- 
2.52.0

