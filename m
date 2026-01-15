Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527522A4EB
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466952; cv=none; b=dJmxGHoMcpkFB9fDta3peyW5vO5JY1ex9CicLTAXtMyxxuEZWxE7mhSzfARojKoWpP75pSWJxYx+gUsuT02ndDOewi1wzYUe9e/kR0Tbpe449m9drVjaoLxXNr3Z4RS1BT+0uVkt61L0JQgsXbX86avizOTSWVjD1cbpk5iHDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466952; c=relaxed/simple;
	bh=DjVOIUifmh6NM2I/E7/zNycX5vsGEUeskp5h0rgKAd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVupzqmxB0gI/0Y5SCiLxXfn/6uzBZS1IildYC/Bqok99bipGHTaZf5tgnxkMJKHSUbHyeSlcYhNBL4tfeAgCDnSt4DUadQZawTpRb0ZbNtQW1kLTh9vdlDnnwldUZgYSFyVj6shcPAtkf+NHYtS8Go1FJVT5/DFyHQWbbrnAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RlxkA8Zf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RlxkA8Zf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RlxkA8Zf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RlxkA8Zf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C43D5BCF9;
	Thu, 15 Jan 2026 08:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768466947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19SEqM5XbA0cekSTgHS01uLyO8gPh/sGxoARr2qzA7w=;
	b=RlxkA8ZflTmZU2IPwwg/yzPOh09EwcBlp7bGJCvuq+PKaKl7rEtyP5KaDDHEi7C4xyCI4F
	JPyF8ojkwj6JmIqygemuHyrqPQe1oH1OUfeecJlBRnToXmUBOHvLxHlibF2J43LUArjImB
	YT+aMOjYY9qxGaINL9sVajZiJ8hYHEg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768466947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19SEqM5XbA0cekSTgHS01uLyO8gPh/sGxoARr2qzA7w=;
	b=RlxkA8ZflTmZU2IPwwg/yzPOh09EwcBlp7bGJCvuq+PKaKl7rEtyP5KaDDHEi7C4xyCI4F
	JPyF8ojkwj6JmIqygemuHyrqPQe1oH1OUfeecJlBRnToXmUBOHvLxHlibF2J43LUArjImB
	YT+aMOjYY9qxGaINL9sVajZiJ8hYHEg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8FE93EA63;
	Thu, 15 Jan 2026 08:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VrG2JQKqaGnmIAAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 15 Jan 2026 08:49:06 +0000
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
Subject: [PATCH v3 2/5] block/floppy: Don't use REALLY_SLOW_IO for delays
Date: Thu, 15 Jan 2026 09:48:46 +0100
Message-ID: <20260115084849.31502-3-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115084849.31502-1-jgross@suse.com>
References: <20260115084849.31502-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

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
2.51.0

