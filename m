Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E64352C39
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161397; cv=none; b=XaSDr8w/Q5QzOgfI4JgRU1nPB77T0FJ6wQ4UoQJN75BLu3gReeGHok7S6RFjni39gyAS97h8hh/ItHEOt3tcF2AEFJF8kw8ThofNmLVfg2Fgnwc1aaE1xWC9SvIS0SuPTTnn82D4h78rhj/M3L+4+37ZcfAnvv9o5nPANccG05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161397; c=relaxed/simple;
	bh=QHl7x7hOeSAon2QJW6cSB8X7QgA6HF5XK1F2xB7PV18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YRFld8K+7wQJQ5DChH2vMGY23KLZ0rC241+e+bWLr731q7MY4l//d/KO8R3mcy9mBGMB7ujcbzlp7Fb+tMCGCOx+bSFbfzjBP/vtmU6+U0FGrHH6Ubnm9PFOA/ZYPYU6yiSmDA7KJexGFsZgYSdUTua7ljehE/A0fa1YKWNZMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Sx3fkkWV; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Sx3fkkWV"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e12fd71984so4143212fac.2
        for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768161393; x=1768766193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGVfI0/8+u4L//09+zks70nTh/iqSyXGMYjvkVqtgSo=;
        b=Sx3fkkWVBZHHJM9n3IWzYWTNAd2N+/izn1DcVhnV+Wmjk4Rghjlq3gSRADQ7AQeeqz
         oacE+X2y/0yWzZ8ASy63UfQd38q0z/m8SJHcXKoEMfA/HAeONmanViEoJYDHnrwVhN3K
         gnsmAhviinhaWy/CpHl4EYjKOcvuFM2nLLcNB5geM3geKuJwq3oXV15i2cw3VzPx2iOh
         pioNQsvF5/2eufmkwAYVErcunNfUqi0F0w2GKlHqt1TEk2AP59jxSjgCl8btmv02HYvp
         tYshpkcVVox6fmV6u8IVBo2OiZ/ODgsZt98nDLVUtUIeCGbxmfBnNOyqZwBZo5EBDsor
         27WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161393; x=1768766193;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGVfI0/8+u4L//09+zks70nTh/iqSyXGMYjvkVqtgSo=;
        b=JuKeBqH5YyAlr7ftRcq59vgTqW53lxH1a4D8R5gWnRGallqXMMfXB3PhbbpK+pzDTD
         CbIUn3O+h+5FkIkYu1l9k0WYs971S94Nj7WHVZPtU1IeGYPfdUpyZzev0+0pWbTO2sl1
         0SY67cN8IXLDAU2pSHuwUmSrZCJQrzW4bzbczglSqz8s6VbfWc5wWa60VjPpCFnUQ51f
         NWPhkVEIxjwUR91Ak/7fs75pujUoYXKK5Yfl4D0BX/IDT98S6jV9WPN7pw2/bydAatWl
         pfX/2QRpr3itdpRAOI60YmlWXVWYrdBeHCHdUGyPfD4YRZvMI8Ds0OgiQ+CLlWFAEIn6
         evuA==
X-Gm-Message-State: AOJu0YzRsesKz5AWFYzuGJGBAyYq2cYVIukRRCtkAUvwWmQeSn7X4bah
	EZKBU/LE25ewqBTGLsBtQcqYzYFS1Q4kUqxFDM3Fd9aQJiPAZ8OzdBvzODr6vKMCvuo=
X-Gm-Gg: AY/fxX4Fr6EEGJKLJ3bH6hf/Rw6NgH3T7+o4QTnEl8ghaXCd2vYvrK/ybPAX38NfIB8
	I4b0881JiNxrp+Wsumh9BrJ1NwYbkctFI11yz5HEWdcveRnoGXxT39gVZBoiyxrEOdX/zsbd6ND
	lVmoQ5JyKsiw18qsxmZhz5jLgyBMh3LY2Vy83Vzt2bW6YsM93JNyyQy7mAB+euX2zG1vi78jsiq
	HmQuqL8TbWtq3P7gKdra98ApwD44kEOpzZajiNkSzQJtod+AoPkq/P1xd7Z7v4bWsMxpy6f0hyx
	0JtJzxcBJ9eFfD2m+Bpo2FvfesQDSJOY0XlZLPc+Yd+VMcH1TfVrxfFf3HZFRXzQ61oOMd8U9pq
	2MuPdNRgYn7WeT9cBp0hHb3682w5mmYMn9SYUbeDr3Ay6N942i2tdYub21Z1GvplJdVbCSS+yzM
	iV06gFdbk+p6BTAQ==
X-Google-Smtp-Source: AGHT+IGBtFi/oNMknJ7q23MRiHrgmzqkvOyQcIAGMR95gDlAmxm0egBAU8gy6B6FNAE/n6bQHA+jKg==
X-Received: by 2002:a05:6820:168d:b0:65f:674e:f1ca with SMTP id 006d021491bc7-65f674ef243mr4958633eaf.35.1768161393624;
        Sun, 11 Jan 2026 11:56:33 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ccfbdcsm6306629eaf.15.2026.01.11.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 11:56:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org
In-Reply-To: <20260109060813.2226714-1-hch@lst.de>
References: <20260109060813.2226714-1-hch@lst.de>
Subject: Re: move blk-crypto-fallback to sit above the block layer v5
Message-Id: <176816139201.218180.16174213874094266429.b4-ty@kernel.dk>
Date: Sun, 11 Jan 2026 12:56:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 09 Jan 2026 07:07:40 +0100, Christoph Hellwig wrote:
> in the past we had various discussions that doing the blk-crypto fallback
> below the block layer causes all kinds of problems due to very late
> splitting and communicating up features.
> 
> This series turns that call chain upside down by requiring the caller to
> call into blk-crypto using a new submit_bio wrapper instead so that only
> hardware encryption bios are passed through the block layer as such.
> 
> [...]

Applied, thanks!

[1/9] fscrypt: pass a real sector_t to fscrypt_zeroout_range_inline_crypt
      commit: c22756a9978e8f5917ff41cf17fc8db00d09e776
[2/9] fscrypt: keep multiple bios in flight in fscrypt_zeroout_range_inline_crypt
      commit: bc26e2efa2c5bb9289fa894834446840dea0bc31
[3/9] blk-crypto: add a bio_crypt_ctx() helper
      commit: a3cc978e61f5c909ca94a38d2daeeddc051a18e0
[4/9] blk-crypto: submit the encrypted bio in blk_crypto_fallback_bio_prep
      commit: aefc2a1fa2edc2a486aaf857e48b3fd13062b0eb
[5/9] blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
      commit: b37fbce460ad60b0c4449c1c7566cf24f3016713
[6/9] blk-crypto: use on-stack skcipher requests for fallback en/decryption
      commit: 2f655dcb2d925b55deb8c1ec8f42b522c6bc5698
[7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio page allocation
      commit: 3d939695e68218d420be2b5dbb2fa39ccb7e97ed
[8/9] blk-crypto: optimize data unit alignment checking
      commit: 66e5a11d2ed6d58006d5cd8276de28751daaa230
[9/9] blk-crypto: handle the fallback above the block layer
      commit: bb8e2019ad613dd023a59bf91d1768018d17e09b

Best regards,
-- 
Jens Axboe



