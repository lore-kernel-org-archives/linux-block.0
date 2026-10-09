Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65374BEE55
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542862; cv=none; b=qOygDSkHmFcDyT8Y2uddyvHctX/5Gi9s0BkRlAueb9iHgiK684OpR+1jyTmlC6E3sBtLIztgbXonj6bJG2TOn/LA4d9SVFy0vRDFFXgtZsWmqB52cW9udhvRKtkDDGDtbh6MQgEP8NZ+Hb2OmcUSHsN+9Hbp9PicCAfEJ8lZ0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542862; c=relaxed/simple;
	bh=A/Xq5TaU3pPuWRwzDX6gLicnq8GtbBKc/ksvRlwmUDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naswDzBbD0aBeMs+lbuR0shyMvvKduAuuvez2FtboU8mkHrT8za3/bvDPcCmdXtKQVODXefcaObbUGRbGWm3Uk3ahc6+AbU3gRIwaFz+t/AVbNVzVJj0dnaRXvh6X0gdkQfTyu7Ua5H53maOL9S1KUKuj5ti63JkECGErTEMwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8690079f2c1so2287267b3a.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 03:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542853; x=1792147653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+NSQ8uLG/1wxXUDITr8E/1sQJlzBYhW0Bjux1XeMx8=;
        b=uPhsxNzUrzPDV6h2bKLRToOlXWA0LWnmnZSHWt8p/nU5ZQONxdmDvF2WLqP2IKK9HS
         2NbXNkON6eDG8O/s35FMlKWYt66fuV5052PvmTlO6RGwWoPCM/5AasjU6UmptqL18Rs+
         wCkvos22Owz4FJMliTWh/6fdz7JdQXNhFE7/gUk6BA9iMixeENof5aQXofPKls9i7T5A
         TrFbH2uEGkxuupTgmn60EWsBjHbWP91cy9EFUkULLCdK82u7HENsytKw9OGswSersv9Q
         F1QUsvJipL/RDytLzuAzfA1Bh5LqhluXrXM4N/9rH6JnKnodWFrUDzzjyBpxKhLV9EsM
         4SsA==
X-Gm-Message-State: AFq9FYKlDqU7l52oIzoSADJ2IKsCJYZfd3UJQx4GCBcSi7O0/t5eEUvQ
	JNeWDBAi6aSHZLCBBCQS7T1gCG3kozu7nDpM5SvriWOXka22RG2NmT4YjR2U3uiPlFs=
X-Gm-Gg: AYBFou0tgji796kBVQL6KfbNbHfbsiITPO54jNEZKMzpot51tKpedsW7MR5zq0d0U/F
	+58XqyElVwTv9Au+LsGBk87OsJXL0tMPfKtHKWr8dZJad4aXv89FIbDmXJuOkbLIXCaqZSqaD0u
	BpjPl5Qjy/nyISe8WwV/J6P0aBq4B9ny6iQJGIb/5eT82DSo8E3eh6bXbEezLdj29eLnV+LSgnB
	7/dCOwOQsMPeoOT57e1StzN8WURZqEsCgzg05WX5ZDVFfjrKhNeiAVprIq8pgKb9/6SdxL7FXIK
	B1vbuyYGM/jWWjVbs8mjUl9b2shh8qn4pQToo2wCcC4LDqbDXydro2OlFqPUTiQTOPuYBeF/kII
	tyFS0UyPWo7EiVvedXhveAhaVRpKe9muNb59sHVB1O4BxNyZ3B45hUU2BQBG8OGnVqFl8obm4MI
	j4YGL+c2IeX34l8zCdKg4TIdNj3Eow5gnpzPCUJsy0sx8IO/55VpnUh437O+48GDi0dpdvFBWlj
	FwPx9KFRU6C6UN6Z/WNa7bdiS4=
X-Received: by 2002:a05:6a00:2e25:b0:882:7bed:3b3b with SMTP id d2e1a72fcca58-897c78d7073mr1316750b3a.36.1791542852767;
        Fri, 09 Oct 2026 03:47:32 -0700 (PDT)
Received: from white (bba-217-165-185-173.alshamil.net.ae. [217.165.185.173])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-896b68ef2easm756509b3a.7.2026.10.09.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:47:32 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>
Subject: [PATCH] floppy: remove is_alive()
Date: Fri,  9 Oct 2026 14:47:07 +0400
Message-ID: <20261009104707.309842-1-efremov@linux.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_alive() prints "timeout handler died" when fdc_busy is set,
command_status is below 2 and fd_timeout is not pending. The driver
passes through that state on every FDC handover:

 - lock_fdc() and floppy_queue_rq() set fdc_busy before they arm
   fd_timeout, with set_fdc() in between since "floppy: select FDC before
   arming timeout work";
 - unlock_fdc() cancels fd_timeout before it clears fdc_busy;
 - fd_timeout is not pending while floppy_shutdown() runs, and without a
   cont floppy_shutdown() only queues redo_fd_request(), which arms
   fd_timeout or releases the FDC later.

None of the callers excludes these windows, so each of them can report a
dead timeout handler while the driver works normally:

 - floppy_queue_rq() returns BLK_STS_RESOURCE while the FDC is busy, and
   blk-mq re-runs the queue every 3 ms, so it samples other contexts'
   handovers hundreds of times per second;
 - floppy_interrupt() checks after schedule_bh(), when the next step may
   already run on another CPU, and also when the interrupt arrives while
   floppy_shutdown() runs;
 - floppy_shutdown() checks right after it queued redo_fd_request() in
   the "no cont in shutdown!" case.

The check also cannot report the hang it describes. With the FDC held and
no timeout armed, floppy_shutdown() never runs, and floppy_interrupt()
runs only if the controller interrupts. Only the blk-mq retries in
floppy_queue_rq() would keep checking, among their false reports. When
fd_timeout does fire, show_floppy() already prints fdc_busy,
command_status and whether fd_timeout is pending.

Remove is_alive() and its callers.

Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..e354ea61f23d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -635,15 +635,6 @@ static inline void debugt(const char *func, const char *msg) { }
 static DECLARE_DELAYED_WORK(fd_timeout, floppy_shutdown);
 static const char *timeout_message;
 
-static void is_alive(const char *func, const char *message)
-{
-	/* this routine checks whether the floppy driver is "alive" */
-	if (test_bit(0, &fdc_busy) && command_status < 2 &&
-	    !delayed_work_pending(&fd_timeout)) {
-		DPRINT("%s: timeout handler died.  %s\n", func, message);
-	}
-}
-
 static void (*do_floppy)(void) = NULL;
 
 #define OLOGSIZE 20
@@ -1727,7 +1718,6 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 		pr_info("DOR0=%x\n", fdc_state[0].dor);
 		pr_info("floppy interrupt on bizarre fdc %d\n", current_fdc);
 		pr_info("handler=%ps\n", handler);
-		is_alive(__func__, "bizarre fdc");
 		return IRQ_NONE;
 	}
 
@@ -1762,7 +1752,6 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 	schedule_bh(handler);
-	is_alive(__func__, "normal interrupt end");
 
 	/* FIXME! Was it really for us? */
 	return IRQ_HANDLED;
@@ -1890,7 +1879,6 @@ static void floppy_shutdown(struct work_struct *arg)
 		pr_info("no cont in shutdown!\n");
 		process_fd_request();
 	}
-	is_alive(__func__, "");
 }
 
 /* start motor, check media-changed condition and write protection */
@@ -2863,7 +2851,6 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (test_and_set_bit(0, &fdc_busy)) {
 		/* fdc busy, this new request will be treated when the
 		   current one is done */
-		is_alive(__func__, "old request running");
 		return BLK_STS_RESOURCE;
 	}
 
@@ -2875,7 +2862,6 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 	__reschedule_timeout(MAXTIMEOUT, "fd_request");
 	set_fdc(0);
 	process_fd_request();
-	is_alive(__func__, "");
 	return BLK_STS_OK;
 }
 

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.56.0

