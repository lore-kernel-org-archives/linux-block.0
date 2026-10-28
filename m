Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205885;
	b=elMV+IfxjxLRG5Jil1+QO8scsp270TCXcsZBCo8hjQ1KhqxOXl8uzAbIBIdrMEs5mJjS
	 CVls4HMqpl5YlXLkBaF/hjhKQa2bhsm0sWBoBzNKg618hPZDvXm6n9OImMg2aEPuEyRid
	 /w8SE4BzApz1x4PZP+RkM5geRxEF+Buho/7AqJ9gn6zvTJT08XdzCU368oZQA0yGXKMQJ
	 dvN0DETzVIUAIzpbbFt055i2fFFeZJ7yxZ8ujTLT/Xt+PgeKp/OaKLYhCWRykNqHWmEaK
	 IViR0FLaahPzYnfMA8AS2hrTfB7J4P3tyfEMSt12oUqfQR94TM7WLQrgZC+5pSW8ceA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qVvhVTQ9IoiGdTrk+SIM2l0I61oYlow/ZwYyrMI5KTY=;
	b=bD9TPFjpPalIXrMFqPtXZpdDRipLcMjpJDeKSjc05KGc4cIL6fSHSz54y6FNS8dy9Lby
	 QxK6j003Vwb2FBRF+Y7gpk0Ju+DH37b7UknviDjPF62uFCv6J1B1bAZxPhOIRPianPD4K
	 jz0PmVndRloHgkLD2oKYmwAnGswl+qGZLlFgKilJ/OWn5Ch71lZciZkPo9sfTOAMPeK9d
	 tOiErcEeOrj9pcVHFpu2W0rOHpML1Nc9HZmoPewKrqkG8qUQWAagDa5yW+IkWfw9JqAqr
	 EcMRvQeE5pBTyFfehabJYaasqPtckIR+hxsG+Jb6m3C0GYvcD8Q2qvfu5f5H60QsJ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=acrvwQXT;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532D606A324
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B532D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=acrvwQXT
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-843ea301d60so849225a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205884; x=1793810684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVvhVTQ9IoiGdTrk+SIM2l0I61oYlow/ZwYyrMI5KTY=;
        b=acrvwQXT1kJ/JHgNwOFi7qOuDZ7voJV9lwT8CO7v87v3bNiweE1EIwRG8ctveEARvP
         YzxFxtssAXS6JeTmPomjOwitIF5BOSY1MwNZhn8RQTEbWCZps51ko8Ns+EGe9J1mDWR+
         e8EFI5DrUGbyQtALMi1qMUgHsQQrI3gpF+RnupMWEM0QonkcIkuAHtOQQA9+5DpQIkbB
         JxUSF/2n9MIzbRzhhJEapDt99why+S8cIz2uQoWu0aCmch+ezuC+uCRmOnw6rYc3cNYO
         cYWrPUTEflMANAG43H0PrpVGUayJTsM2ad6WOI8jPKAu+9vOwMpbfOMbPbIG7Az3wQL2
         m/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205884; x=1793810684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVvhVTQ9IoiGdTrk+SIM2l0I61oYlow/ZwYyrMI5KTY=;
        b=2SyVruH4zGuyiOlgaaWjJ8h9zJil0zfMnm2VTKNA5QEQBqJuD5rv2VdQQoMmJw2IHn
         u6t0OWsFwRg5fwQfi1bA4JVQYJcEqsueEXpK3Y3HBf/yAydOBjIqbgKCogL0w/J3IDhL
         mOmdYwJNBK6/EykxzFhy4tQ3PisLliwkCBnmdRSBpbaIvq6VLXGUkFzAaOFU3swtc+eN
         6ljlCEXG51ZmoMABEXndHPOmhxxi/lRYkVZDGVDeBFBS/v1sZmxBgkD3QA1k7XI2OlyH
         RbOJmbzFEy3HJsTbMiqBGvayL+UIOlR8yLIV6v4MtCEc5D0PBgZmKXmzdFU+YV5/ZVAG
         HKcQ==
X-Gm-Message-State: AFq9FYKVrCsCj4n9/Un6GUAg/mN5tv8bCFx5ry88BA8z/9GhX1MpjokZ
	rurg77CnW4u3GBh65rF/AWMiqHyrWhKWsuhxV/wVLqbMIzIIqUgGc5QjJe0Jw15SA70FgKF7J96
	rVOy0/i4=
X-Gm-Gg: AYBFou3cScokivu5IejDolnricTz58aHy4a8XvW7yb5OVZu9CFKQb73t9vP/9y/u2+u
	YXOisgunqVNkanNJcMV0GxPmgEAtgB1W3QDwjk/TlZ8nzVD7s2vgqcm1x8VlGsRDsJYpGMc46HB
	g81xJZUi4N//nHlqjRJX6JUFGsch8pftwPlmv7zMiLD06Udnt8f6N1ok0VGiOrTf4ntkxutjbpV
	zbJpsI9nMOnDogVOBAKunS6epz2BEQib7nc/p5o3gN9N4TV+8vO1HCALHexI/EFozWadHYDzAWe
	4RJcJYfRt0fzRfFd6lT7cqqqTDfPqZOmOefnaFBxn80PtyKMBCtiyFXK/B7VfTqIP8BJsC2gTYm
	5KyR1F6gBpzx8Jo38EMdrkg0wqiGX8KGf3h4YDgVYD9VVlKJERse6cIpLhRUXbKP1lbiImVdKCY
	UrSOC7rtW8i1NaeZacCBG4mIhKhUQTLeLpRW+Deuwc/aunTckKPbEBKFtZns2ygFpQPPjO9HwFK
	yNrfgUaZXGb3CY1kVerOhgy9qtxr14gApb8OlwIYa+6uZmpT2+WudPAlas4k6yXsq30l7FZ/CXn
	fUAXmfEMosUlK+HCoXUH3mBRH7ccZYsRbtUPbTZP889JDDjUxogLGvmZ06iTEC7hkztfJ9OvmQ=
	=
X-Received: by 2002:a05:6830:411a:b0:843:d5ee:5785 with SMTP id 46e09a7af769-85ac0038ca3mr2929373a34.12.1793205883832;
        Wed, 28 Oct 2026 09:44:43 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/98] mtip32xx: don't mark the disk dead in the irq handler
Date: Wed, 28 Oct 2026 10:41:23 -0600
Message-ID: <20261028164415.1262013-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

mtip_check_surprise_removal() calls blk_mark_disk_dead() from the
interrupt handler, and that takes bd_holder_lock and calls into the
holder. Only note the removal there and let the service thread tell the
block layer.

Fixes: f55e017c6420 ("block: add a mark_dead holder operation")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/mtip32xx/mtip32xx.c | 35 +++++++++++++++++++++++++------
 drivers/block/mtip32xx/mtip32xx.h |  3 +++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 113bdb868c46..58dc0d63df32 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -130,7 +130,7 @@ struct mtip_compat_ide_task_request_s {
  * return value
  *	 true if device removed, else false
  */
-static bool mtip_check_surprise_removal(struct driver_data *dd)
+static bool mtip_device_removed(struct driver_data *dd)
 {
 	u16 vendor_id = 0;
 
@@ -141,14 +141,34 @@ static bool mtip_check_surprise_removal(struct driver_data *dd)
 	pci_read_config_word(dd->pdev, 0x00, &vendor_id);
 	if (vendor_id == 0xFFFF) {
 		dd->sr = true;
-		if (dd->disk)
-			blk_mark_disk_dead(dd->disk);
 		return true; /* device removed */
 	}
 
 	return false; /* device present */
 }
 
+/* As above, and tell the block layer. May sleep. */
+static bool mtip_check_surprise_removal(struct driver_data *dd)
+{
+	if (!mtip_device_removed(dd))
+		return false;
+
+	if (dd->disk && !test_and_set_bit(MTIP_DDF_DISK_DEAD_BIT, &dd->dd_flag))
+		blk_mark_disk_dead(dd->disk);
+	return true;
+}
+
+/* For the interrupt handler: the service thread tells the block layer. */
+static bool mtip_check_surprise_removal_irq(struct driver_data *dd)
+{
+	if (!mtip_device_removed(dd))
+		return false;
+
+	set_bit(MTIP_PF_SR_BIT, &dd->port->flags);
+	wake_up_interruptible(&dd->port->svc_wait);
+	return true;
+}
+
 static struct mtip_cmd *mtip_cmd_from_tag(struct driver_data *dd,
 					  unsigned int tag)
 {
@@ -715,7 +735,7 @@ static inline void mtip_process_errors(struct driver_data *dd, u32 port_stat)
 		dev_warn(&dd->pdev->dev,
 			"Port stat errors %x unhandled\n",
 			(port_stat & ~PORT_IRQ_HANDLED));
-		if (mtip_check_surprise_removal(dd))
+		if (mtip_check_surprise_removal_irq(dd))
 			return;
 	}
 	if (likely(port_stat & (PORT_IRQ_TF_ERR | PORT_IRQ_IF_ERR))) {
@@ -740,7 +760,7 @@ static inline irqreturn_t mtip_handle_irq(struct driver_data *data)
 		/* Acknowledge the interrupt status on the port.*/
 		port_stat = readl(port->mmio + PORT_IRQ_STAT);
 		if (unlikely(port_stat == 0xFFFFFFFF)) {
-			mtip_check_surprise_removal(dd);
+			mtip_check_surprise_removal_irq(dd);
 			return IRQ_HANDLED;
 		}
 		writel(port_stat, port->mmio + PORT_IRQ_STAT);
@@ -784,7 +804,7 @@ static inline irqreturn_t mtip_handle_irq(struct driver_data *data)
 		}
 
 		if (unlikely(port_stat & PORT_IRQ_ERR)) {
-			if (unlikely(mtip_check_surprise_removal(dd))) {
+			if (unlikely(mtip_check_surprise_removal_irq(dd))) {
 				/* don't proceed further */
 				return IRQ_HANDLED;
 			}
@@ -2492,6 +2512,9 @@ static int mtip_service_thread(void *data)
 
 		set_bit(MTIP_PF_SVC_THD_ACTIVE_BIT, &port->flags);
 
+		if (test_and_clear_bit(MTIP_PF_SR_BIT, &port->flags))
+			mtip_check_surprise_removal(dd);
+
 restart_eh:
 		/* Demux bits: start with error handling */
 		if (test_bit(MTIP_PF_EH_ACTIVE_BIT, &port->flags)) {
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index 0963c07b5845..1af2c75414a5 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -134,11 +134,13 @@ enum {
 	MTIP_PF_ISSUE_CMDS_BIT      = 5,
 	MTIP_PF_REBUILD_BIT         = 6,
 	MTIP_PF_SVC_THD_STOP_BIT    = 8,
+	MTIP_PF_SR_BIT              = 11, /* surprise removal seen in irq */
 
 	MTIP_PF_SVC_THD_WORK	= ((1 << MTIP_PF_EH_ACTIVE_BIT) |
 				  (1 << MTIP_PF_ISSUE_CMDS_BIT) |
 				  (1 << MTIP_PF_REBUILD_BIT) |
 				  (1 << MTIP_PF_SVC_THD_STOP_BIT) |
+				  (1 << MTIP_PF_SR_BIT) |
 				  (1 << MTIP_PF_TO_ACTIVE_BIT)),
 
 	/* below are bit numbers in 'dd_flag' defined in driver_data */
@@ -150,6 +152,7 @@ enum {
 	MTIP_DDF_RESUME_BIT         = 6,
 	MTIP_DDF_INIT_DONE_BIT      = 7,
 	MTIP_DDF_REBUILD_FAILED_BIT = 8,
+	MTIP_DDF_DISK_DEAD_BIT      = 9,
 
 	MTIP_DDF_STOP_IO      = ((1 << MTIP_DDF_REMOVE_PENDING_BIT) |
 				(1 << MTIP_DDF_SEC_LOCK_BIT) |
-- 
2.56.0

