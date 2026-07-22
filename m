Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B753624DB
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691897; cv=none; b=NWh58LPWn+CyVpiU/RnaoCo90DjfyEqPCzcpQq6IJFO4uNSrZbzHyinzpIi/H8G9p9mw/0Vvpdw5+k6T0sF5OmM56VyTc4GX4VkBpiE+bT9PjQW8AFvCJmRUXMyX5pFEYJP3XSUFT1oA1QcP5yzdaI6b7tqpgezmURT1HrdGgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691897; c=relaxed/simple;
	bh=E7dmmcnU+LmIbXuBg4/pv0wUeDKswzuUKZorvsx2djI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8EdfIMlcXszmyGTc3VnzJphY7jEGaq6sno1WOZ85Xt0Vik9M0NZHr289dgNUxoj8J+3R7zY7dPOB/UzrYyo5GBI4NgFhyCARSQ1Evylt6QsrA8obItNqDraNDvuASQ6NvrBcH7xTGpKC+xY4qROsDvTJ6uH86b8YcxbvLPwkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqoKNb/A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqoKNb/A"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954dff6536so30933005e9.0
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 20:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784691894; x=1785296694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppOhKumLepZWu8WHOmlT34Cz/7DtUO+ziKpkk444+3M=;
        b=rqoKNb/AxLEzlXPKSSP8Uwni6kD3WgdoPQN5wEs+cmnJepmaqxscC85JbTDgZF5veb
         /2Hod0VwRNvvcZb6IXr0GbJpnB0LNSx+ZbtkvI/zoHmxyTG51Eu6ExpMaOYAPIhG7afP
         xn86fhDizSekXsvu5MtdQPZOMmOjwxcKqSLyAsFn1fzqxqoL52YjIuKPOG3xAhIH4huF
         4JAQ7M3BR//7VTJDwFrR37KwKIK3mmAd4bzhO40ywQB55BT3o5hcLKqh15MrFqPNYONC
         O1tdCBDlpVhgEwSBLYAItt0WqcLy1U9nPCLt1I82YCzQMktzMufAGBfP7AZp95pZY01Q
         eRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784691894; x=1785296694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppOhKumLepZWu8WHOmlT34Cz/7DtUO+ziKpkk444+3M=;
        b=TSF1A95Ai0aW06kQLVqB3NXJPgrhNLK6tt08cSG3SNMP9woN9IpXKGF98wj9SBqOlG
         M0FrDoW/w3/SAa1ywVbL8pcDBRJWtEYqfMT2WZyUkuqm5O+bJSrVrQQ8IlhjST+9fKut
         0WzK9NnSMtU66UDODiKG1PDwquMkcomyT8jP7MeX4lz/7NQYpFIWe+DvFYefYZj77evm
         nGaHPqrYUIBrzJaVNiRqGJ6i0YhGO3u2WhkB1WjNU1lDKrCuq8TGRAFXDcoPXZJs8l8f
         i+Kh2AGrtsi837DVSHJi1uefkVl1QT/7PpI7UDEabAv+FDzijaIFos5erczaL8RmEsrk
         o0CA==
X-Forwarded-Encrypted: i=1; AHgh+RqBqaBpJF/9inEVnmLEvXZobmlT8xnkpP5lhuLzLOEIHo6YoshdR6ioE15AxOnwZe+6kzdpb8Cf3tFPRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLYFF7l9ji3sx9NkhVjvBc87aMg0HWnxPYN/7VeuyuZyqi0DI
	0bvyy4fVqI7YQaz1O+bcvoZHhfE2fWdTfM4ctIp30pQRYuloD4864x+4
X-Gm-Gg: AR+sD11y5a1l5+d1xNBFfm4P2BmbPfAKwYQSgTCVZzjH9G6UoTHeiyAr2WndUyp6FVu
	K+3tyiyZgnkzxMcVqf7Q0VdaJXKUUBe2QBON8lwkl6ttFoTMZQGgMQLmcHK/B+Ktpwsw5XIIUjP
	dASkMI6frgcqX4r+N+muJLfxZ35/Y+5UZFIdVuRGUwVZ99IizG7xQgP2WwP1Nw5Heo/e2LR2VlO
	XLA5IkcQNN/+X917h9YiV5PSzHaEMdk2+OF4/Ff17Mai1tezFkUShPV30dXuTjVbD8dxkvwVS5m
	+7E9OCi+kBZ6k1wcVRQnkFLBSuzH7iVwPFkh2Fuvlp594MU+NDEKZurCZ5Qx0ruJ1tyZiGwV5iB
	QRHJOJXxFD4l4f4D3Cpq9xqeOuhOfDXSmZ40Y1gyTNC8pSauPne7rBQBjLT0a4Efj3kufTGJJFD
	/wwMMxfSWAkPwajTNJZ5DyHWq3lL+74hCsFK2Wu4X774zdRAowcsFSV0qgJfoppdf/jZKWOQKCI
	Hco1PnvkN64JB1kgN1U2rr2+ccp02TM4NlSfwIa8nqvcMhnQE1hsGhHoQq2JLGNl4HxEYUzaD5+
	Qr+qTe0U
X-Received: by 2002:a05:600c:1548:b0:493:c062:a533 with SMTP id 5b1f17b1804b1-4954a3e8fe1mr243623005e9.17.1784691893766;
        Tue, 21 Jul 2026 20:44:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ac57-0f01-2d95-8753-45c1-c833.310.pool.telefonica.de. [2a02:3100:ac57:f01:2d95:8753:45c1:c833])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm2068993f8f.33.2026.07.21.20.44.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 20:44:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] floppy: flush pending work before releasing resources on init failure
Date: Wed, 22 Jul 2026 05:44:35 +0200
Message-Id: <20260722034435.13432-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_floppy_init() probes each FDC with user_reset_fdc(), which queues a
redo_fd_request() work item on floppy_wq that may still be pending when
the probe finishes. When no controller is found, the error path calls
floppy_release_irq_and_dma() to free the IRQ and DMA channel, and only
later destroys the workqueue. destroy_workqueue() drains the queued work
last, so it can run after the IRQ and DMA are already gone:

  floppy0: no floppy controllers found
  work still pending

The flush used to be here. Commit 070ad7e793dc ("floppy: convert to
delayed work and single-thread wq") renamed the label out_flush_work to
out_release_dma and dropped it. Restore it so the work drains before the
IRQ and DMA are released, as floppy_module_exit() already does.

Fixes: 070ad7e793dc ("floppy: convert to delayed work and single-thread wq")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Noticed while running mainline on an emulated Acorn RiscPC, a custom
personal QEMU machine. It has no floppy controller and rpc_defconfig
sets CONFIG_BLK_DEV_FD=y, so every boot takes the no-controller error
path. No disk is registered there, so the drained work takes the
empty-request fast path and just unlocks the FDC, leaving only the
spurious message.

Verified with 100 QEMU boots per platform on v7.2-rc4, no controller
present. "work still pending" appeared on an unfixed kernel vs with this
patch:

  Acorn RiscPC, rpc_defconfig: 100/100 -> 0/100
  x86_64 defconfig, qemu -M q35: 6/100 -> 0/100

With a controller present on qemu -M pc, reading and writing a 1.44M
floppy image still works.

 drivers/block/floppy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..6cfd114d27df 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4744,6 +4744,8 @@ static int __init do_floppy_init(void)
 		}
 	}
 out_release_dma:
+	/* Drain the queued redo_fd_request() before releasing IRQ and DMA. */
+	flush_workqueue(floppy_wq);
 	if (atomic_read(&usage_count))
 		floppy_release_irq_and_dma();
 out_unreg_driver:
-- 
2.53.0
