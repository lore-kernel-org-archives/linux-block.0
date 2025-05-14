Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CF1EA7D6
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262040; cv=none; b=f1ADGG/lMcQlhtGpnPThskITQrmOeYP+PkhmMw3s441g5kOfhh7y6DxuuQ1h8XzUAqfwJYnc1cVwMP0L0daEpOcQqnra89PC6QTyouyPGKadvD0yQmrePQnvz1jdFAVUKE7audZJS0GOQxfZ8d9RcLxbud+ubZ2vgtu4MGtGuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262040; c=relaxed/simple;
	bh=lVu/mvmpN/FHogkSUMMEiuwAufUrxcktiR/7YV9Kjk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRqca8lAloAkDBIL+PobU7sO7ENp+xg4NImtI/BARZxKHGdj8tFccw4BqMStTe6Rv8ldOdZ0MCzoJY3lFCjiHum8UBcLZ6H7AtSo15O1vd9HPDnn7BViZw8HnGtxDg4TVt7113pikkpgz76evdbVjtXUlsZQOa//xoOd2sWP+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=WGuAunvL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="WGuAunvL"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so240907f8f.2
        for <linux-block@vger.kernel.org>; Wed, 14 May 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1747262036; x=1747866836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2PndMj4mpe7tAQgsJWM027dP5YcTE80wQVpszoi90Y=;
        b=WGuAunvLUbpLIe69aSVlFusv102jjB6rk8sIGjSBMSgZc7561GOyp2ksSIup2+QWQO
         Rsw018XuFfwRHoftahUpZIh1fZT7ddIT9J7PFkEtyozbuLoQKpr9e69PpBAyi23/iJyG
         /5gGYDw8bpCMOyIp2uO97a3ZbVPQobSiItNv2ZnagptqZHX0J+7kzgHqtGwobs2Doale
         8Tiw3eXdmF1SnX8XLVdCWjv1yLMK/SH840bUPKee7GElIlmRxQZRSo8yrgdENJkP8bb3
         SBDEcvJeQNMoiXc1GOSSjOo6rETIEA9Ole6lgswV8HlSPezLui23ndTewu6KYlETBT8r
         UJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747262036; x=1747866836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2PndMj4mpe7tAQgsJWM027dP5YcTE80wQVpszoi90Y=;
        b=nBlVGNeGe4EyI8tt1eO4lHmse1xpslAu3nUYX8z743oyY4+0YtKpuLd/LLnmogOZSM
         BQmjT/3WXI8E20MIuPwxcWsRVSjCpBnzbn0w95SLZm0+MEmRMA8ypTQbbdk7phroJiLT
         zsRrMkp64ragCcpxL/6siJ5xItS33FLaRcyI/kavsajTCdfsGcKWaN1yF9A52zCHScwH
         WaH84MPNejkt4sYTFBbYeNV3LsqxV/+J8pMN8xQuiV5NFZffwCNwGHmTssmJhWY4RZnz
         R86TrADXPheOhGnUHBqKTO28dhDPmhHDpJQ4o3fu4GqsMZlmFUCZeHaYeX8TMJvR/w1N
         6yiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvBTmiBWf3ejLdzjvT0j1/zgtSYcssH7s33Wh8whw+1zTNyrKMo/PjPrk8BjRpGbhjnAyNWJb/1ImUUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymzm2FD4WPoYjORza2CMnLVw/H9tvZYE0rjAL+euyk39iZHq+O
	ECENAMDFAMsBz45n3xnREpuEEiG50B+CUmwhR14tkDswhbLVozyzMK0XnIYo/n4=
X-Gm-Gg: ASbGncszrd6QMd5ByYHzUArnzP/uYj4jfB4Y9PfKPSmj0/Q72sPHfcFUpMQZS1ToMuG
	DaYof8NdAbRZ9Th301eyouOp5JqiYs6kpvwLB8u71206/qHcplUWn10pofMujRGSXK19R5PO24d
	50uBc8+OPvsIf/qQoHzR7FQTHiYpjqTT1ZbztRz1Z7Kvo1emKbk6tyZbP8VkDc8e2gFpioLjOZD
	XOPW2FaHOf/ZyCHKoepiVzfOychHUS3xjT+ueQTbPR7wudyrqv2cHfmci4t4E8cPeA2gDPWEn+q
	FuJGn19fXG/LFcNAm57IsYYhnAS3yHce+DAsPmPLZRAxmdwEOLyS4GDv933sEyYoMLNcu56su2x
	B7yn+SbB15BdeEr4j1r4ibUX3lftpTcISBzfIbbmbUAzIclvUfNBM
X-Google-Smtp-Source: AGHT+IEYoW3Orx1uFnSSmL8X8UcuSYJ4R2xSjZJtM6XytlKsXQpMH2p741e1LRWs7x3TtWZwVoC0KQ==
X-Received: by 2002:a05:6000:2907:b0:3a0:830a:3d63 with SMTP id ffacd0b85a97d-3a349693050mr4987483f8f.9.1747262036038;
        Wed, 14 May 2025 15:33:56 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecccbsm21066994f8f.32.2025.05.14.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 15:33:55 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: phil@philpotter.co.uk,
	linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: Remove unnecessary NULL check before unregister_sysctl_table()
Date: Wed, 14 May 2025 23:33:54 +0100
Message-ID: <20250514223354.1429-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514223354.1429-1-phil@philpotter.co.uk>
References: <20250514223354.1429-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

unregister_sysctl_table() checks for NULL pointers internally.
Remove unneeded NULL check here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://lore.kernel.org/lkml/20250514032139.2317578-1-nichen@iscas.ac.cn
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/lkml/aCURuvkmz-fw3Nnp@equinox
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index b163e043c687..21a10552da61 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3677,8 +3677,7 @@ static void cdrom_sysctl_register(void)
 
 static void cdrom_sysctl_unregister(void)
 {
-	if (cdrom_sysctl_header)
-		unregister_sysctl_table(cdrom_sysctl_header);
+	unregister_sysctl_table(cdrom_sysctl_header);
 }
 
 #else /* CONFIG_SYSCTL */
-- 
2.49.0

