Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A3D389E19
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847220; cv=none; b=A3XT/pCfBoj+FkqsAZB4k+kqJDZ7KH2ekAeHczgoTPg3vHsX2/Wm8ruZWdC1xFG3XzDyEO5k7S7TC00cKKILslb/FWLHj7z3oI3bVI2mxOUaSVGw3/c87U39wHVn4LYGcUmDu5izYZ0o6iIPDxLyc6ESs49Lmf/4Af1CiFAUGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847220; c=relaxed/simple;
	bh=oN4Vc+WWGg13cog0JrZa3/y60qOQ3wjh7m2o8Xh1cjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0Tm9YMKRtIfWsRp4fRT+6AFlbG7FOjApI/c8Mcx7wct9/0d84ZS5DSo2n6ZyvL7cE/Vo7W/e8ZSP+bweVGaKHOyxKhY+bv0rdVOW3QqNSNQLrMeO50p39RseXR6INxy32JvbrrNhbP+BBUbEO0IPAV4v/gXkd4fkc5sAFRgWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mn6/T6Pc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mn6/T6Pc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mn6/T6Pc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mn6/T6Pc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FCE633759;
	Mon, 19 Jan 2026 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768847213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yo5da4CB1u+Ak7PIMIs7KS17fraXjYMbiuLt7XzwC9E=;
	b=mn6/T6PcV7P1aQVgMviLM3lY+Ko7ybi8NpvcwVzTT+USfprbit2V3NHqE1W05e/Ifn/Yyu
	DTJlcWzd/ZRrYHUuGswvNdKyOUBuSIxE2h89IWgmA99LCDwhtoTJn/HOIh+bUjte98kqXq
	m3q4THds8Dzrvyo7ZdkkFv5XBOXaPGI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="mn6/T6Pc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768847213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yo5da4CB1u+Ak7PIMIs7KS17fraXjYMbiuLt7XzwC9E=;
	b=mn6/T6PcV7P1aQVgMviLM3lY+Ko7ybi8NpvcwVzTT+USfprbit2V3NHqE1W05e/Ifn/Yyu
	DTJlcWzd/ZRrYHUuGswvNdKyOUBuSIxE2h89IWgmA99LCDwhtoTJn/HOIh+bUjte98kqXq
	m3q4THds8Dzrvyo7ZdkkFv5XBOXaPGI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE36E3EA63;
	Mon, 19 Jan 2026 18:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NJcHNWx3bmlOaQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 19 Jan 2026 18:26:52 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-block@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 3/6] block/floppy: Don't use REALLY_SLOW_IO for delays
Date: Mon, 19 Jan 2026 19:26:29 +0100
Message-ID: <20260119182632.596369-4-jgross@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119182632.596369-1-jgross@suse.com>
References: <20260119182632.596369-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 4FCE633759
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Instead of defining REALLY_SLOW_IO before including io.h, add the
required additional calls of native_io_delay() to the related functions
in arch/x86/include/asm/floppy.h.

This will remove the last place where REALLY_SLOW_IO is being defined.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/floppy.h | 27 ++++++++++++++++++++++-----
 drivers/block/floppy.c        |  2 --
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/floppy.h b/arch/x86/include/asm/floppy.h
index e7a244051c62..8d1e86687b98 100644
--- a/arch/x86/include/asm/floppy.h
+++ b/arch/x86/include/asm/floppy.h
@@ -29,9 +29,6 @@
 #define CSW fd_routine[can_use_virtual_dma & 1]
 
 
-#define fd_inb(base, reg)		inb_p((base) + (reg))
-#define fd_outb(value, base, reg)	outb_p(value, (base) + (reg))
-
 #define fd_request_dma()	CSW._request_dma(FLOPPY_DMA, "floppy")
 #define fd_free_dma()		CSW._free_dma(FLOPPY_DMA)
 #define fd_enable_irq()		enable_irq(FLOPPY_IRQ)
@@ -49,6 +46,26 @@ static char *virtual_dma_addr;
 static int virtual_dma_mode;
 static int doing_pdma;
 
+static inline u8 fd_inb(u16 base, u16 reg)
+{
+	u8 ret = inb_p(base + reg);
+
+	native_io_delay();
+	native_io_delay();
+	native_io_delay();
+
+	return ret;
+}
+
+static inline void fd_outb(u8 value, u16 base, u16 reg)
+{
+	outb_p(value, base + reg);
+
+	native_io_delay();
+	native_io_delay();
+	native_io_delay();
+}
+
 static irqreturn_t floppy_hardint(int irq, void *dev_id)
 {
 	unsigned char st;
@@ -79,9 +96,9 @@ static irqreturn_t floppy_hardint(int irq, void *dev_id)
 			if (st != (STATUS_DMA | STATUS_READY))
 				break;
 			if (virtual_dma_mode)
-				outb_p(*lptr, virtual_dma_port + FD_DATA);
+				fd_outb(*lptr, virtual_dma_port, FD_DATA);
 			else
-				*lptr = inb_p(virtual_dma_port + FD_DATA);
+				*lptr = fd_inb(virtual_dma_port, FD_DATA);
 		}
 		virtual_dma_count = lcount;
 		virtual_dma_addr = lptr;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c28786e0fe1c..4422bc57a4f2 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -145,8 +145,6 @@
  * Better audit of register_blkdev.
  */
 
-#define REALLY_SLOW_IO
-
 #define DEBUGT 2
 
 #define DPRINT(format, args...) \
-- 
2.52.0

