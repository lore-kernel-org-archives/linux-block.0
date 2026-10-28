Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205915;
	b=RJUq1TCi82mQhu9KAXmiS5eTIugIfARwaFTpmFXud4ZWmnm8jyYbDsC6bXnj8Y9bYyTW
	 VPd+aC6Sz4rPHmybT5kpiQcct3wDKIBw0lFaxCDKjXxcDImPVCwW7MqqlIfYJxlsAOKG7
	 zgMNoDRRQdbTqFwEdPgqHVVLAx1XKiz+yXwqqMNNrtgzkrDF8shRfgW5c0U2a0punso9D
	 LlbretIH+eO5s6FELyspAXGTKwUvosbTqIMkUvM0a2vaPrjdJzKZZA7Lf6tBP8j1izEGm
	 qwZvyO97nr/aYQIaLGNWnmLl/rYmqHxvYei3lc/SZidY/LD4u0bnLV7S/3nVbIzCVCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TPWmv3n2YGtO5IRBTspFsZtgAtiG7uii9YXnZBaNi9I=;
	b=tu3Iks8iuOb4qr1wunxUxtybAFqcJXO/TqkAWck7ml1Bjzl1/qXJZ0nC7ivGuSd4/wKR
	 5DG6qriTFRZnYJN4fda4HE3wdv00iB2/OswOiCysfuFS7AkCwvEV1z4UySNiisfY4iR1s
	 1zhJsgufHCCqa7EdOybQ6sNW41peUc9Bvuw/aFI6lTqDkFgTtC1oe2fLcF/nsdPYN+MDB
	 9ovZOWpup/QOlIbWYfIHZzdUw156v0aOnLsAxnOCFC2pANgsGo7YPbMEhjawfpY2Etgdn
	 5oCgk5S/vDn1njq/04yzHntvCFMWVQRrkWfUpM/XgPqAvGnqeSmsyllrg6xA+Klwxzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lA8Z5bz1;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E040606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E040606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lA8Z5bz1
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8490a7d6696so708960a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205914; x=1793810714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPWmv3n2YGtO5IRBTspFsZtgAtiG7uii9YXnZBaNi9I=;
        b=lA8Z5bz1vH6CPA03ZT5iE7EuyhNLaoHF7nNX+oH6wM4l74FYvI4W0uQ3vZ4XMjfST5
         h4CpuFm2JrFn7gCo3w6adJOiinSjyCYw5KztIZR5N32zzo2+oN3MSadufWeryxgAevqT
         rj8jIxQJc80cked0i8YX8aWZo8IfaXsOHJ0c6Fp//e+ZJXCiPvTaNsnspiAl5wozhR8O
         pi6Tyqr4xsfGfR9Db2Qkjf4y12qqXH0Bo2CSToZht/BidcKtTNWJpR/nX/lVpfLTA36E
         fua+gtE4lUB4AyKofu+JPpsBXSnnwL7VOpu+2O9+nbZhlbWjI5sevxQhl0DFh5ZIR+IV
         3ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205914; x=1793810714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TPWmv3n2YGtO5IRBTspFsZtgAtiG7uii9YXnZBaNi9I=;
        b=aqylBCMTeABsQDH/85CtUBz4sx0pQ3pd88LavYoUPrDFwvEgX2Ch3vJGmnlOiHOhqY
         Khhiokm67tzGCReFvtqWk5pypGlD/ylZTAlFxUHloUnYL45+n8DX0QMBd8Ljl1DplPvM
         yHJtcqn53An8UmF5p7L6uI4ekBk7//LolsTf10sre43JiQQTjFXCNLnGCkO0TqnLW3U6
         0htLVRuNpFe1dK1VY8whkQI4Lvn59D/xLiWz9aSZ1tbqDcOGiwKO64ScyBPlBsn6BMr/
         0jq0ihKWkwPTslmnfcNBPXW8k2UMBYj8q/7ef03FTubChLNT0mXbUS+NnmxDiAIHHSTA
         NBBQ==
X-Gm-Message-State: AFq9FYK+GaxwQ13P3EKYbHRQ8aSZDTFCDpM4J4FUJNibpxRvnG+Si/4v
	u5v3voGyyVshdmVzn6hyjbvH0tPkGcprBcB0CGVBg8CcsvUgAINYY2coMOkWLk7K4X0nzuIKtJX
	2HcRZT7o=
X-Gm-Gg: AYBFou1jvuwwm8YwRgTNDrqvnI/4nCZe+QpDzoHw+pC5PtlaImB7/AwY6RZGQdoC2lx
	Zlu23xn70m/vupSO3smm9ckoRln/NixARMkNL010gsQrdDDrwZdjZjd8RGSvRtuGRmM1mgijXBL
	fVE2eCyoHEiLTQbTk7nUokgTmc8yqYfRukpqK27Yrm21NRp9LAhHGjokqdWbeUAoo3eQBmG1/09
	3f19uzEJFfhBT9vtHiM4tKyUf0dfbbQeA9yqzl3icQQLhJ4Ygv1uRUxT1oeQ1ZjCswV3KabfK1v
	ClHENxvew8c4hDg6nBUFFDrsSFy4zupIPtQatefCV00h0B7ItV5S8bPF+AkPyEWDDf1+6mUmWH9
	90KBnZ4l67sVAfwn2wST09/RSZ2AFyIC7443yInBEElRq8okNeXae9t+WfwA00akQuuMUDKqzy8
	64tEMHGxmCxqyi0GLkqojLn2I7Ya2g7hAPafFhG7jZATsocoZPfSuw7pXsKWqMv5E3C5BcKYx91
	IE54jpVFy1yo6J/Obl1miNWK9dnnetKvg1YOBRBizXs0YSJv1miWc8qRl6tsV9ZW4Ku7bxvLLcg
	9RoWNe0cAMlSf81zh06sCeeGF55jpwMvQrXNWABY3OMVkI9iS3GOl7ULN312W5G40WI/6VRW/Q=
	=
X-Received: by 2002:a05:6830:25d2:b0:81f:1790:6ad8 with SMTP id 46e09a7af769-85ab88ce00amr2902528a34.31.1793205914437;
        Wed, 28 Oct 2026 09:45:14 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 46/98] nvme-loop: delete the controller if a reset fails
Date: Wed, 28 Oct 2026 10:41:49 -0600
Message-ID: <20261028164415.1262013-47-axboe@kernel.dk>
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

If the reconnect of a reset fails, nvme_loop_reset_ctrl_work() tears the
controller down by hand with nvme_uninit_ctrl(). Since that was split
from nvme_stop_ctrl() it no longer removes the namespaces, which hold
references to the controller. A reset while the target no longer accepts
the host (allow_any_host 0) is enough to get there: a sysfs reset hangs
in kernfs_drain(), an ioctl reset leaves a controller stuck in
CONNECTING with its block devices, the cntlid can't be reused, and
module unload deletes the controller a second time and hits a
use-after-free.

Do what the other fabrics drivers do and call nvme_delete_ctrl(). The
delete path quiesces the admin queue and only unquiesces it if the queue
is live, which it isn't after a failed reset, so unquiesce it
unconditionally before destroying it so a stuck request can't block the
freeze.

Fixes: d09f2b45f346 ("nvme: split nvme_uninit_ctrl into stop and uninit")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index fcb1f8186fdd..93ba6357a850 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -422,6 +422,8 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 static void nvme_loop_delete_ctrl_host(struct nvme_ctrl *ctrl)
 {
 	nvme_loop_shutdown_ctrl(to_loop_ctrl(ctrl));
+	/* Left quiesced if a failed reset has left no admin queue behind */
+	nvme_unquiesce_admin_queue(ctrl);
 	nvme_remove_admin_tag_set(ctrl);
 }
 
@@ -485,9 +487,8 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 out_disable:
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_delete_ctrl(&ctrl->ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
-- 
2.56.0

