Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150A363C5F
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892530; cv=none; b=HCTGWbeZruXVRA6bHCDnB6G89mZoooj7+AmN+pPGL2aLaOhbebvWgbV1TtUPWI7OnZqIIMfXInvvPAdPhmWtzHFAbnbEQD58jVxPbLclqwnPhjOejsmEgibh8P70hTSUm1xF0DDB0SbbSRQRw9Sd4susiF+vQw59c6lmTrobgnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892530; c=relaxed/simple;
	bh=DjVOIUifmh6NM2I/E7/zNycX5vsGEUeskp5h0rgKAd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6eSeS9kkXu/vWMAOfMA7rFC8fJi6XAP/sOdBRzsJjAARXT1+oWZM+S/us7BRFp7AfELCHoVNu3nMsY3wXAUS4wcT+4A6mSj9EbdvwNY12uIcda9MCPAvkMVPfGN1IkHXHaZpwFbXQRagAAzY0v6AwHYLxED6oRDwvn/P5GF56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB3FA336A1;
	Tue, 16 Dec 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C13E3EA63;
	Tue, 16 Dec 2025 13:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u3fmGKxhQWmTHwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 16 Dec 2025 13:42:04 +0000
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
Subject: [PATCH v2 2/5] block/floppy: Don't use REALLY_SLOW_IO for delays
Date: Tue, 16 Dec 2025 14:41:46 +0100
Message-ID: <20251216134150.2710-3-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216134150.2710-1-jgross@suse.com>
References: <20251216134150.2710-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DB3FA336A1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
2.51.0

