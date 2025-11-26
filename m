Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71433DEF7
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174047; cv=none; b=fuJCPnUY3RVkmbgtn9INFkW8i1Bv8HGQqZMASjm0TXLhj/pYBI81ECvvdacs+Z35/qIZfE2BgRzaKek15B6FoRF/3d8UitI3zcgsKWBIGr6PSb7tqO66KRRzSGl8+mcTiYNeqv1ZepzeREPjZ1SDkkRzg1vrjg1vz3sKeUAqPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174047; c=relaxed/simple;
	bh=7HVe38fGf9O0P+2M/aGTe3AqoeP1IVHjJywuyxqp+YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boJS5jsWzHeXcHaOXxN9rKKN/t6ussvJ0YrP8c8Zsl9vJPWwKltd2tTIWk6JcVQfHXsK4eFEwbBXSk7ANYBg9DFIXth/ZiSbPKqitNQNJNi20j174F0+Guv0L/mqHoT1Qp+LECNHpnPj+tYp+MeJ4W9WnbpCQSH/WsnS/P2XfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l0zC9X77; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l0zC9X77; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l0zC9X77";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l0zC9X77"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBECD5BEC2;
	Wed, 26 Nov 2025 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764174043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6NZNgwK7uASRwAaTsoHBOWL98m36NgtcvOr7XBJKRI=;
	b=l0zC9X77WtSe+c5FbHImlnHMtbOibieEEfMRboxeXFi5BU9T27zN8fuGdXK1uSAf3ULU+V
	PyU4c+g3ACt9WmH8gHSUXl3I58wrqKvnvRSBre9A8SpMA8Xino0Snw40OjxvJaIOZZBMZ3
	l8UsEYOmTkcMChn6NQ/hDRsk6koxVow=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764174043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6NZNgwK7uASRwAaTsoHBOWL98m36NgtcvOr7XBJKRI=;
	b=l0zC9X77WtSe+c5FbHImlnHMtbOibieEEfMRboxeXFi5BU9T27zN8fuGdXK1uSAf3ULU+V
	PyU4c+g3ACt9WmH8gHSUXl3I58wrqKvnvRSBre9A8SpMA8Xino0Snw40OjxvJaIOZZBMZ3
	l8UsEYOmTkcMChn6NQ/hDRsk6koxVow=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 863573EA63;
	Wed, 26 Nov 2025 16:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6F1NH9soJ2kELgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 26 Nov 2025 16:20:43 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-block@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] block/floppy: Don't use REALLY_SLOW_IO for delays
Date: Wed, 26 Nov 2025 17:20:17 +0100
Message-ID: <20251126162018.5676-5-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126162018.5676-1-jgross@suse.com>
References: <20251126162018.5676-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[]

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
index 5336c3c5ca36..cda36a8f9a05 100644
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

