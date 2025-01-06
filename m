Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F021DED6A
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174371; cv=none; b=MgCrXe5tpN3GO7sjHGHcfVIHLR0yPkv7YB4YFpQgOvCvzNUzbKoDILs8kR/c0wQOjD4agl0dvk7hQul3n0MdW1mjLz0tdmvEUcBm/Wc0gZLwUPuaxZxzse1EiZEjB5xvV0e3gZjtESrEkWX0y9PCFuHnX6bdhPblFIXJFqkLqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174371; c=relaxed/simple;
	bh=abhxetlHFA/fzQepQyckJfJHy3o34hCpPThf5JkI8lY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ocB1Rv2bGLP+j0WDZcUbd9NS/z7iM0/xCtEmOxLT5HVKCZq51/IFiM2J7YdbsxUCp64ZmSk3Q2hqIRrFehoZAiWP/B00ot7WO5Q7cBVZ7UMgvn6j/fl2sBrLqmg1Q+V8YXBay8j4bXVEw6o/fyJz7z2QcSy5+2drJKHvOz2aVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aAtoEeTq; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aAtoEeTq"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844dac0a8f4so1074577839f.2
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736174369; x=1736779169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBZ4AOeWFFW8Dd9C0Ka6etVGn5iXgyom5RPzMiqZSs8=;
        b=aAtoEeTq5obuontLvhlqn9e8D15DBaKS63fho6WE3eChKIPNqEq5dRPsk92RWLLXq7
         Gq7FCW/+3Y5W626PsHYWrh5zU6rmdYQtmot0ipC/e/dAKIcQNeH30Lz85/tVQWo+GziG
         lt1zSqBVWdeqWYzfiX+9dreLUzBPiYGsIMuFZYJKwO2mcaQ19dyaw8FY6PDwABPAM9fZ
         TReqwGZkrhxcZcqx6TfqyspMoizjLRXhiid87we7HuviTieKWC+poY0BP63avR7o0Xtb
         7kkhFO/D1cANtfGCzgOw5V9SI7fX7x6u0wk6f+o7OQ/6dAicC0BYxZM5Ny0V1xPKyW2x
         lPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174369; x=1736779169;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBZ4AOeWFFW8Dd9C0Ka6etVGn5iXgyom5RPzMiqZSs8=;
        b=voERAbaqb2uIIj8tDN7bW3QJ1o+Gsgck7mhtbC2C8Ygu9vI/vLfDJ53gJQ0ZZ1+gCb
         Togu7OAuKarXcDTSyjA4m2jYn+3AktguOeFNCACBsJAWmaxQHpOdLc7iNj07MZcAvzee
         C2DguOAYlkT7VvacClZuFjDvfikd8UuD17Fr5dHLT/VJHDtLeLlGr3iRWy5cqBHVdniz
         LjabHO1NVTGiGCrgMmJpVvvoNmHkfj5aQz0W11NfAYafnTT84QYChbQIwsd+wZByb7TP
         fkk0JZ08TD04YMf5gH0g2Iqewh3tT7kTCRwHDg+HZQ1l/i4DlBNtsw1rnEnVsJ0FZxbp
         XMfQ==
X-Gm-Message-State: AOJu0Yzl4a7Ub5aFkuI6YB/BJrQOaL3ro1lXsJFfjE7ioeSABFlLb4vm
	C5QcLSIkSEt5cye4WbmgcB80kOPhCDPUZ+F5WA8mCgLRL12kL6+i1ECYvy0eeHs=
X-Gm-Gg: ASbGncvdfyYcWI9FacxdHOQ5klOi6U9oIjKFmDBZzn6PdAwYxu8Wz7llVKVbvIswNCu
	k8cRgh7dqRDE0AgE/PNKRccficVK6E+fD9wY8ptQRqWq6l/IxxaknYqYh2KSiTKYgc+23G6csJG
	atkXVJFIJ+KVIzOUIOYiU9r5P2/yRbs3wnnzPRcr/u3uDfMRDoilhXo8CLsHHmMuSrlWYJYX7ZK
	ZSD05BvKs2qU+9viyrdENHnkLnVK29BiivmS84SlC83yEo=
X-Google-Smtp-Source: AGHT+IH1FLG78kLDcI08xTsYvucTGiTZynt+yZ3VkITuEG9P6/zBcgc/TiBADuCwXEDnvjNSsx0EwQ==
X-Received: by 2002:a05:6602:1551:b0:844:debf:2c8f with SMTP id ca18e2360f4ac-8499e7d2f5dmr6473585939f.14.1736174369322;
        Mon, 06 Jan 2025 06:39:29 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d7c8308sm879002839f.7.2025.01.06.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:39:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20250103092859.3574648-1-yukuai1@huaweicloud.com>
References: <20250103092859.3574648-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] nbd: don't allow reconnect after disconnect
Message-Id: <173617436792.57123.13624319333213614661.b4-ty@kernel.dk>
Date: Mon, 06 Jan 2025 07:39:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 03 Jan 2025 17:28:59 +0800, Yu Kuai wrote:
> Following process can cause nbd_config UAF:
> 
> 1) grab nbd_config temporarily;
> 
> 2) nbd_genl_disconnect() flush all recv_work() and release the
> initial reference:
> 
> [...]

Applied, thanks!

[1/1] nbd: don't allow reconnect after disconnect
      commit: 844b8cdc681612ff24df62cdefddeab5772fadf1

Best regards,
-- 
Jens Axboe



