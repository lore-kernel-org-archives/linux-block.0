Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205887;
	b=AYk0QIqc0moST3X7MHhsg9SYiYY7UJRbJdxt7zlCUF6i/ArbXer1hA9x04cqRKLIsFR1
	 iSn+7xC9BssPBELjmALohkgNEMhqp2VyJwKc0dWfAdzmzqm67qY3ML81EEX8VqiyYBBAS
	 B/GI6X7iFdkfxcscOlLsC5jcngUeTYz6d7KtSefG/5JioAs+3+c99L3Ve2QKjdCuX/CJ0
	 DJuoPfBCsQNXNKch8lKxOk8K8w2vRal1xuuhSeU66xkNMGN6dCzsOmtP1dFkMDmnBm0X3
	 qk+DDR/iOhDx/2hf66GV1a9XleC5cjlF03We2Te+ekw6FXVhW2SjwK5lFQVsyK8fWKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ENP605S5QDfoRPeYS/Iwu6X2MDFIfexWHf8/L9B5HwI=;
	b=1z/ieeNYHwULdshTS4VqtVDGYxynjGO3x99cZNVkMzR+kzWN6yTgVc81kS3Xvo9x60ac
	 IKKdhVobbZV8UMWEBBHmxZFCuqftaVPG1n7RjsLXiY3pH+csBemh8B6TxKRQsJs0DXiD4
	 bs53zl8O31wiN/7Yjuz2VQYJyH09RdXqvfyBfYnL4NG1/QI9NbWgQaJAQx2qIcLL44T1c
	 x1N9zPcVR+POMx/QQ/hvl3V4S4zULLn3K82rkG+LZQ24gd1EJ4iRQV/34RLyGu92nJamM
	 cq3eKIdRuwdkdx1DqHkNetHJGGiJyf7Wr2OH7l7pNimFKoziR5xAJECqnqh/Wj8fxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JqHB5cdv;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842E606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0842E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JqHB5cdv
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8256106635eso661522a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205886; x=1793810686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENP605S5QDfoRPeYS/Iwu6X2MDFIfexWHf8/L9B5HwI=;
        b=JqHB5cdvs5p2S1OehVoBImyiBGv3h3Ye5akfOVZell1S9erkFULHDebFuWB3c/KZJR
         eEL7rjl+0cyV1UFCAH7N06aZV0lktrz1zbAqtiK7NInJZyXkFCcDNSt687Sr+Ae6IoLe
         LsBgHhrSFCgECl02BVNfohKA9dCatpBSipizxE+UxLiRe/FCslQNXJY5Lc2kCS3vzM2A
         jp+QkPiKujTqVMtY7vR04KMQ1v6Ml6I/ktVqGP9iQtdqbhNu7chiVSzaMGrkzz6G+caC
         vUX1MySzRNJA3eJw5t2vZZ9a2n5xUXKwvdLrbaA1wk2iziJFy1sGJjOEnvVwvg+fx0W8
         pKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205886; x=1793810686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENP605S5QDfoRPeYS/Iwu6X2MDFIfexWHf8/L9B5HwI=;
        b=G/u2ZDHm8OS2kpcWdLLn/gcK91Ihq8UBIMwJhhHeacyNlfsIG7jGz+5AZVLt7AmIMv
         n7d2/hCSSp3b5Mi9NFVd7t5N2iV6pKI5GFwwyO4X1B6JZk4v2hjvX/bJ3wllNcEoGWxV
         pWPerWrEEb6InZWxqnR6suX0ihR4j9XCImltC0bUmWU70S7p6NJY1ASUcFnQx10xBRed
         cThA1SHuQP9W3GJAg0Ncv3JWVIL5sj81cFokpVvler43elwbfZxxNFgttIiO5Y7e4UGj
         SoAxRM6RkVS71ky42Sews95mXyT3B+Y0qCBgcGVPzd9SHVS02GpEHQAEH17Jk3nUKwv+
         LmNw==
X-Gm-Message-State: AFq9FYLThuAUGshKCtcxWZyxmtuif41LEtE2RZrf7lbiQRxcqXmwyoqs
	BD9Exo38dz7EPfrBN0OkPpUfOs4qmSVH+a1sChOeq2PtgYAOc2Pv5656d/+5BAlAV2dU85Wd8d7
	/6xFtpS8=
X-Gm-Gg: AYBFou2zQlVB3oRZNxu7wi5FsilkMvo/dfIGW+hjvd1I7vXaqa4g455vnXpf9uNTN/t
	0fCPBKEmcAfXRWKYBLYQl3xl3rr1feSQ500+QAz+DQYzAMImCAiKYGpbivyPWxKrK/B8bocM4ta
	bXo5bCh2L7kacjNKOWl7YZza8ziL+yUizCqOEb+s/g3GuSwWm8O0rkldwQyX+sQDYFT0FQBCkMf
	UXAl9fjCfd6YGO+FMaBLlH1IE2u/pPD+uL2rgcrFNB6HOzw8ua3zKSBfbkuKdwYzlCaAFEC5t/Y
	VqLF+3NYr1/AdhKjqGEZNJ3kEWqq8RJJKCLbvTkeRVC3vC05G3X4OI06AQy3XL5mqQlHW28LM0s
	1eI/XwM87Lzx242kis04uaNrXFcSwUU/e7gYLGfeX0iKxd52D1MB3cuxEYD2K/GgkZSpipXOvml
	U1JqlNQKnpRjaT5k3irg1okz230cOxLmnfDPC2dw4mcMCsgCR2seIvM5EpOrudnVJKKP0E3GaMa
	d/4xvRD36blm+F8ZczfafU+3chLddi0D7x/Vm4rBGJYqe52nkxNW1I0O1eF0BYUORQjZgx6+JeJ
	THcyllHv7MpW9PFLWiMSHGZe1w3J2eyNXEE1iqnfLTnzjhQNLwtAWhUhBrTDa2gMz2oexSp2cQ=
	=
X-Received: by 2002:a05:6830:6814:b0:826:b94f:8144 with SMTP id 46e09a7af769-85ac14aa587mr2740241a34.31.1793205886069;
        Wed, 28 Oct 2026 09:44:46 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/98] mtip32xx: abort commands in flight on surprise removal
Date: Wed, 28 Oct 2026 10:41:25 -0600
Message-ID: <20261028164415.1262013-23-axboe@kernel.dk>
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

mtip_pci_remove() relies on blk_mark_disk_dead(), which only stops new
IO. del_gendisk() waits for the requests the driver still owns, and
nothing completes them for a removed device: the timeout handler leaves
them to the service thread, which exits as soon as it sees
MTIP_DDF_REMOVE_PENDING_BIT. The removal hangs.

Stop the service thread and abort the commands in flight before
del_gendisk() if the device is gone.

Fixes: e8b58ef09e84 ("mtip32xx: fix device removal")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/mtip32xx/mtip32xx.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index ee5b170e767c..301c3db21ca8 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3887,6 +3887,17 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	return rv;
 }
 
+static void mtip_stop_service_thread(struct driver_data *dd)
+{
+	if (!dd->mtip_svc_handler)
+		return;
+
+	set_bit(MTIP_PF_SVC_THD_STOP_BIT, &dd->port->flags);
+	wake_up_interruptible(&dd->port->svc_wait);
+	kthread_stop(dd->mtip_svc_handler);
+	dd->mtip_svc_handler = NULL;
+}
+
 /*
  * Called for each probed device when the device is removed or the
  * driver is unloaded.
@@ -3917,16 +3928,23 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	set_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag);
 	mutex_lock(&dd->ioctl_mutex);
 
+	/*
+	 * Nobody will complete the commands a removed device has been given,
+	 * and del_gendisk() waits for them.
+	 */
+	if (dd->sr) {
+		mtip_stop_service_thread(dd);
+		blk_mq_quiesce_queue(dd->queue);
+		blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd);
+		blk_mq_unquiesce_queue(dd->queue);
+	}
+
 	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
 		del_gendisk(dd->disk);
 
 	mtip_hw_debugfs_exit(dd);
 
-	if (dd->mtip_svc_handler) {
-		set_bit(MTIP_PF_SVC_THD_STOP_BIT, &dd->port->flags);
-		wake_up_interruptible(&dd->port->svc_wait);
-		kthread_stop(dd->mtip_svc_handler);
-	}
+	mtip_stop_service_thread(dd);
 
 	if (!dd->sr) {
 		/*
-- 
2.56.0

