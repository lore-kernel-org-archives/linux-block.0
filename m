Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205979;
	b=ZRquAk6CHVvvZ+JF3nCrBdJd75Imu5OOOZQ/oVa0IL2dfMtbvB+4tcmVaQ+Xtk37YoYO
	 r0Z3atNY9fRXVMfg/9vzzLDc1mOmMVoMw9eHTYHjYnO7NRpxZ+lG+xXWOM2aC5K0seBpW
	 T5cm0eNJhWUXj4yp6O7oE6AfNyczwB3J12ZDJRj8CH1xUmGnrBwLVUR9rB+P7AUlV7SN5
	 AIt9MS4u+18HoNkCz3W8zUsIxsQbX2knBmtAJzvtFLoR7kjDsNUYqd+XS6EAydm/Iv69Z
	 64Sr7AN0FkkItmjWTJhYt1KA3nRT4bor06D1vCJI+8GzJkRQSpIAHeyytBTQ3DTnnsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y1bk3hauGmSlVbbzTKUs6ZWOzx+ReD4F+CcFEDKQX6A=;
	b=2WPggBZ/TIUYQU9pohFaChvU9v0T49NeK9lg8rQ/wPrwLb4ab4xHU6e9RSHBtIDcnAoY
	 Sp/jwQM/A8xy8jqlQTdGrJKGT7qIp2lC5JWI1g1Mdv0XRVtVv2diKWqEu93cMyiq6E/4E
	 EknHW2NJBLpv5jNhZ6UEPwIJ+lwQKmW6bmLrM8Ubdaea7iYMR4XOxTqtSUxGFRX08aMNj
	 xxWv04tDNssiEwO8lk074fwjBAE3NS6ZhBEdelUktx/paMOfr7DhesniwXSWneLacm8eD
	 3AxvzEmuswVZWlfJrHGlMvzat0SGJ84qr5soC+9AfBXkOh3/cZzpeTjCh8jRKFtNsiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kXJQWLIF;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46360A261D
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE46360A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kXJQWLIF
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-83bbcfba0ffso911133a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205978; x=1793810778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1bk3hauGmSlVbbzTKUs6ZWOzx+ReD4F+CcFEDKQX6A=;
        b=kXJQWLIFpD5Nsx6x4rXVEufZJ7Bgw4knS+PMYq9J/5rvTETexWthvhedXPaDLDOEED
         kv/TKmPmcDme9DbpHUJzPRfzqFFutX9hFF1t9dUyuFoOpYKf+wFj+K4BCAs8tcymXOP8
         sOORwoP0Qes551mtwxH5cr0VLbhXRkw7/KsjEBAN9PSarhVh90xbLUwzzv0siAAzzXwK
         zh/inoy3DsRnoHryAEtj93QYEraJ9AmZu29dUh4Md2MIbA1lI7E0ij1lmwpSD2RISDgP
         Oe2y9w2hGK+9RWBLeKtIH0GNQsT3xzS6zVT3tU6UgEupL0kGqafv2F1p/bgVZOXqSecn
         Zgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205978; x=1793810778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y1bk3hauGmSlVbbzTKUs6ZWOzx+ReD4F+CcFEDKQX6A=;
        b=Cdq43P36z1tbnzyUom1iKJBy0KBtZDTXoVdoa0k+6GMsJSAJvBn2gaY0vaFbBIkqr7
         i8cesblK+VTff+G/DqPTyQk5Mo5/+pd4YAPsKeRRGyqxoUbB4p8/w98IflyKbmDDHoNp
         I+DxB00NM568vLH6Kj2x2iSFWpkni2nVGmYvmOsvmZ7XzYYOW2CCgqVtm7pkGMBoCznn
         8y8wH0agjBapQpRqNlqP7EIfk5jSyw6Xn32HuMpMkePk6yOANjWOD9g0OfvDnMCt2Nic
         FaQUt5IgMvGQJhDLxKcDieppW9yvUa+wVHsMCbQmzEvwMBZPGUy8z0817ZBDPjlVDMsP
         ihnQ==
X-Gm-Message-State: AFq9FYIFUhDqANqAty77PZc5YuEz6NbXMC7rq7JX4SOsCm52d4rMI2bK
	wIw3Xj71+x5E4QuWE2LarwMksWUd1VXVRuVPgEL9VHAvEEXCWBrPfqPsGUDFKG1Ev0Zo0PsaJNq
	jeuB68nE=
X-Gm-Gg: AYBFou0D7wt46CKV1375+Kjptza7k8+fkUroF5KmUc6keSt5u3gwgOyxaOHx+GXnjq3
	DQxmpJolPcTx8Bnh83sf9Vga80YFFlC+4SqMc5JJt86cdv3u55cADQOO/hnkp9S9t6KMvOET4pQ
	Mc/6l/KQW0CHHBG6TeP8iAByI+7FV8i/i73jwpkalRsrsjKZ4pmsZY0p/9pHfQS1p/PATAp0lYD
	hQrfH4ceY2ZvbPKt/JhbJOZQr8oQLdfmYCRAc4gsWJ7hitcfmjtXm1+X3AEvf/ZlaQjOxA7Tv2K
	7b8URPY1GcXelUlssPxz4J17nm+OWhAJ+7Wb0cusDaja3duDB4TRnzhVDIC1O7ioGGQ+aquGiBE
	3yikJNfzVxc4+fi25fT4Fp36MoSXzsTnsrq33dFFHhltNufsmLj9C0pbwAaXZQ8dEVijVInUjwn
	i87ngQdtHqP1VDJjDj8FcqVIDi5iL+M1UpzEb6+w2t9iKkom1ej7m1Ua1Tti23VxIWFYM7G5p+f
	VQFGZ7aYK1Lzi4zS2fO7BopKVRgnl6lAWUaDR3woo0c7gusKYZwPRPRh/jvp5QbXrBTbnlCO4n7
	lHUf473ktdNUAJOw8sgJHqrz3F1Yi1rBrWjLHZkZ6w7t98Z0GnasBwaxQCM0n8rnIdoH4kKbbA=
	=
X-Received: by 2002:a05:6830:2304:b0:80c:d30f:97a with SMTP id 46e09a7af769-85abe8bb687mr2574281a34.27.1793205977633;
        Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 93/98] nvmet-fc: only send read data for successful commands
Date: Wed, 28 Oct 2026 10:42:36 -0600
Message-ID: <20261028164415.1262013-94-axboe@kernel.dk>
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

From: Andrea Parri <parri.andrea@gmail.com>

__nvmet_fc_fcp_nvme_cmd_done() pushes the whole data buffer of a read
to the host even when the command failed. The buffer comes from
sgl_alloc() without __GFP_ZERO, and a command rejected by
nvmet_check_transfer_len() never touches it, so the host receives stale
target memory, as much as it asked for.

The tcp and rdma targets only send data when cqe->status is zero. Do
the same for fc. The ERSP then reports fod->offset, which is 0, as the
transferred length, matching what the host checks.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
Cc: Paul Ely <paul.ely@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index eecdffefa24f..b95893adae36 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2487,11 +2487,11 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
 	} else {
 
 		/*
-		 * try to push the data even if the SQE status is non-zero.
-		 * There may be a status where data still was intended to
-		 * be moved
+		 * A failed command may not have filled its read buffer, so
+		 * only push data for success, as the tcp and rdma targets do.
 		 */
-		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
+		if (fod->io_dir == NVMET_FCP_READ && fod->data_sg_cnt &&
+		    !cqe->status) {
 			/* push the data over before sending rsp */
 			nvmet_fc_transfer_fcp_data(tgtport, fod,
 						NVMET_FCOP_READDATA);
-- 
2.56.0

