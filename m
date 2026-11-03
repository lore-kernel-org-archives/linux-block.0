Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716277;
	b=fGFz6v0CRepw5+LUaaoFo7m7cIv1V+5U+O83x/pilFOMqIMa8YMqAPpB6vXJvdrNC+LY
	 /Gb03zYVbbYUpkQIoH8ud6dRr/o1rcFTjNP9FtNvTSd7bVNTJYBuYNbbZq7QYwp6moRCw
	 Bv82vkIUNqjhLnrHZHSzF+zrVY4j+iqikqfFuA/5RDtmxoswF5mA7TSVduKig/szbXi3a
	 RCGvXbllvrAGOonoWdYue3GpbbxVfKzC1MN9pseEhIy/29+c/N3nh+6fwQ9ne/4huTIeV
	 5WfAmB7zDksXXF4sRaFL0B88PIvF/ZaiGWd/rBpWNAoAysuzkuryLKJvlkc5clRYU5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=u9ZaJd6aju36DuDO9RJNLklXVPiZP2FTMqXACefRn38=;
	b=ClDNx4UMXYxcBXMCson6d6oW2UOwaIIZdmim+SmFKWG4g4phu/Xobvct+w6vA6eV5ccI
	 kV5yGTxaK5Lcj329C4cTYJn9wRkd2BL7rI18fQGv/iNH33XMJuXRO2VjbwxFMp69Pk1/B
	 8pHEWzGT5rKXtEOyUYmn0lFdrE+8HiQrfw05LfFJb+RXWD7X/Tb4grJxq9L4+vuyrL/xA
	 1l0BZUE0MTCEwd0CzjfPN82f9RpPJpAtF9HTorT/0u3ZoNDRZyjDWynpcaxT9v06TrH7a
	 PkSFanXZ4mCi4sSO6d3/88tvtDEF6Ig3tbOTBAWQE7Qp/1rQ2993KM1rl96YDeTaQzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JT4Dgk3D;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15A6082BCD
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A15A6082BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JT4Dgk3D
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14394530ec6so5585308c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716276; x=1794321076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9ZaJd6aju36DuDO9RJNLklXVPiZP2FTMqXACefRn38=;
        b=JT4Dgk3D/jhsxfk4IrhfbXwkMOuRTkVIgKEXssrb4iJvOgCDN0aH73b+2eGWqnll+U
         WpXXntpnlnTazTxY5oldBR594LJpDvSFT2I2ZS0uBNFiMZyXkx3XAkivUO1rbp/du3wd
         lgRSIVa7Q+0AjehCQxfMczoGAUH42Wz3YYMHC6SyJ6GlYROvocU39RFrCIzeCb6nK9j/
         ncCrxKF2CaIEK3iv4ueec50dEqPtjLW5RE41XZ80/iGeoY4vMHLl9EeB9DYnWyo0c59m
         AXfN25Adnrk5KuTQpFQTp293D1gmxhvJsRcHHSCTkoGuMjGow6iZ9h/Jyl0Xp6v0UCrX
         EKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716276; x=1794321076;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9ZaJd6aju36DuDO9RJNLklXVPiZP2FTMqXACefRn38=;
        b=BxNT3OKkgUut2VuLxH7/ns37zyFTkyI2IUPh8wdKjREqbZC99irszdM/gSPN05E0Rb
         dMJiuXqvupI7SsAaM+W1T6kefbSQaP8NuR6RILBZhY7QgIM+KhHwICZncIQLF2XX3AON
         9ViV/mN18TEJ9Z5AAabt+yIqmLXp1QKeKu23Ukf/4HhdlvLfu9ur3KyH+nPNL8qCap09
         5k+AYzoaRGMYx8VZCeuZWWK52bv9YC4c78961xN/cU4yKoRzRmEzBZc7nVgtmvIZYNzy
         WBWI8iQsKeMlY2mimjodNG4MM3qNagFK75Kvwg54/vHVAfmJtHddkvXhFUsCs2AeoP7m
         z5Qg==
X-Forwarded-Encrypted: i=1; AKwUvBz8jKh8uPgLee3eWWB/iAtAVXm9xBRmJg2yo1a9Uv460HEvTu73J5s3PoGOu1YsOGYwFCXO3TeeSNo+Rg==@vger.kernel.org
X-Gm-Message-State: APuU4Z85PS0LLNy0vlsrSaGCmFL/Ki5vY4qebNhrUKEkvWWiQtT7F2cN
	1TPw3R4kOuwq0mfcSEdcsgc95nBheaxpKES7pV+XV1Zx8mGGRbQQMxTeheVe5Qxj/OPQfj4mdWA
	dwaE0CIM=
X-Gm-Gg: AYBFou02hUDe+HlmBVexfgKNZR7/6TrSo0DYF+p91g5RuXqptBujCGYQ27UQho/eMMk
	WHUpCcXIZtppGFWG4CdD1wFkCWaf5kbMjMJeJ7kE79zd3x15DU4XnSwM5++Cd2cdmzmLjfsH7J4
	yoMv9RKvDkQTrqr0Xa5ZY5V0thW6uvyE41xC5yEdZEijhAKdjb5+FoePC5TExTKAeo6Zh/gdVr6
	guHo+t0t7p/LjiitAY1rTsJVO9NGqvTfoBSKgn1l4UElRVEtTS3awTxd+p3H2kp8A9n38TMIAPi
	mePQd16Vl338TkNOw31kE5v6HNd45o8+FB31hg3kObUuSJZT9xIruTkQK8fV4iDaq+JMK8fbuZe
	+Gcpgg1L2Ol6313Mh/gTXljPN+A+E+YT6jgDUm01FSq/9SMPot0r3qcxlRzZU9z+IKMjstjcwN2
	eRYGm9XcdAP79/zdXehDv3WQnXKpmhKLHpt7TfVtWcHyiRLpZ2E9mqX3pvTbhO95B3ErpbClQMD
	y4EAJ6dWUQgN54RkwoRY2zKoLEZNDiC3NoRGaMun4Vrbluq5UbN1CTHi/HIxI63KuaKyrF8L4O2
	YdPUZMQTQF9NDYADphfUdMtrZ4hhGvrjuOLFK+7eprYYz3xJZP3wU30+KLQa88FK8BSlqRxRkB+
	FFPUkuSnIo+RZ
X-Received: by 2002:a05:701b:4287:20b0:1a8:b566:80c2 with SMTP id a92af1059eb24-1ac5d889488mr19713490c88.17.1793716276188;
        Tue, 03 Nov 2026 06:31:16 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, hch@lst.de, linux-block@vger.kernel.org, 
 shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261031221737569WQ3bg8y80Ht7JdTCWwlkL@zte.com.cn>
References: <20261031221737569WQ3bg8y80Ht7JdTCWwlkL@zte.com.cn>
Subject: Re: [PATCH] zloop: fix the error code in the blk_mq_alloc_disk
 message
Message-Id: <179371627516.3691261.2270107097490778251.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:15 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 31 Oct 2026 22:17:37 +0800, shao.mingyin@zte.com.cn wrote:
> When blk_mq_alloc_disk() fails, "ret" still holds the zero returned by the
> preceding blk_mq_alloc_tag_set() call, so the error message always reports
> "err=0".  Save PTR_ERR(zlo->disk) in "ret" before printing it, like the
> blk_mq_alloc_tag_set() and add_disk() failure paths do.

Applied, thanks!

[1/1] zloop: fix the error code in the blk_mq_alloc_disk message
      commit: 703f6aee8d8d1cb6227af56169be6b1dc4d3c4d5

Best regards,
-- 
Jens Axboe



