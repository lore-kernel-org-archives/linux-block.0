Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C622397B4
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599570; cv=none; b=V0k8CYfkLb/gTDR50L5HC+X4iC17jFwQpMkLWqMikn6OFV/u0deRW+IB6Oa8Ze606rapub7hFNvZ9SgTFxN77/Bum0TWXJT5a5Kgd3sWc4Pe8R1yEPyzm2daLqoOza1W7KOlAwfVa9VXcvem0iV/9LBtRc5icApJEkshO91Ett0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599570; c=relaxed/simple;
	bh=tOcpGZ8f5Tb47JNS5BNoknblBrTyos3un4K9kSh6yAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ifh60kAfcdRR8e/wdtAcckVlp/SeIMV+RXlRToH/4MGurqfp+6ut7v1p/SdIoFE0dz3/I1Mt0ynYfgh6LTZQy/TGsxH20Gtt66IKv/iZ4IvpLbu02hcqPGWY9QjWGfgjIPObAvab62UTUymzah62qPT9ZAA/9p3lLPEJK+snSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JVwcPq7A; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JVwcPq7A"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d439f01698so2764015ab.1
        for <linux-block@vger.kernel.org>; Wed, 02 Apr 2025 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743599566; x=1744204366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BQoS285p3ACMznO/yhKhIxe+5v4IUlbAZzIu1YF/lI=;
        b=JVwcPq7A1wYLI6HanfRZBwxUCnBFUCgL0DDsnUb3R/6kPoICi5KThFMKUWWuXNe20d
         dvie86+AaCAFFwgbWtkm07CLw+wvm0pbpQIBlcbXpDQGncvC9WESUz85Plyj44w3w+yM
         wSpnMR2N0aQ19mXj8oeKAbdALSn8insFOIWv9nQU6DmXsmhDpgexcBnX/EHB7ziFviUQ
         /9bE8i3UBc6yg2EiP0+XtGXEs24qTx0YAnowkoJml6ZYSwArI/lQM7+yTKI78ctPQ+lQ
         A2hUxXMvt20o9JpSbTmmsrs/8QxTf6z1L8ANJ1hYsNpE6RybIKMkJObwC3Sz1EuIwPA4
         X6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743599566; x=1744204366;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BQoS285p3ACMznO/yhKhIxe+5v4IUlbAZzIu1YF/lI=;
        b=PRrk13Ok6IecGBhlbeU8nc9TwbXZRkNULGTdg1uP5VlmXYHRknjlXceepKt/oceS6m
         yMTi01P+H2ItohqbsrqlQDrzhZIs5m+OqfoIhBfPL67cVEk8R/yc3Bq/tzKKti4oWReX
         O37UXv7mAgd7cyH7XPaqJTfbgA+iV9siGPLgWaie8ifeLuzHInVD5OY8b3Xp8y2UZ65I
         sQvGoO2g/MrcNmuccXq5vw4POx43HoL0c61CplU5l1uBVBma4ncGiOQJ1zV9U+yWdopQ
         1ySjfxsLo1RqO7lCfPlX+unyCGPg3wb/9pRJTLSjXn3dAw6AplOSZkV1Q/LvpiZxZdTb
         Joog==
X-Gm-Message-State: AOJu0YxDJpoU0YqjErR2tr475z97QMwNNyaT3HPz5XmyhOM/nTu1AsMB
	3e44PPa5V8HTzSlXnJsLngt/Gy0yIqCKAtLj5NOGxEiDWRrVAyMq7gbyGYQ79flyyEdSl8W4xAG
	G
X-Gm-Gg: ASbGncs55EaeFVyje1mBjrNA5SRa3fCsxJhT/M6F9LoTsOV9RCjfLhxv/NVGXPJx33b
	4z49bsaXE+PMaGE8rVvAp2BtxZ3jlJYhltP3DckgDS9d5ZdkMT7skYEpRlqTx/PfrX/kpEfD0U7
	k3LJUb//JD60qyKWWceVsbajHIvQtBe47uZqoiY65fPrXRBG3t9Bi1sMyjIdxGQ64JTgm1/iqOy
	0hCpkJLKclY4HvSANFVJjvRV0NBEPXGw0oAZ7E6Cs/IHv89YMevwpNOZyu4+asyEtjPfyE8B3CW
	K5nQ1AaUb+PRZPN1crpJe5kmTr5hAJqoqBk=
X-Google-Smtp-Source: AGHT+IGYEtc0rVmUripwItyyW0bmRlCGHyKYzRGoLqwNlAxm5qK9125/20/ajFem/q54Yg0ZLMrZLw==
X-Received: by 2002:a05:6e02:2783:b0:3d3:fa69:6755 with SMTP id e9e14a558f8ab-3d6d6d17acbmr14537565ab.5.1743599566623;
        Wed, 02 Apr 2025 06:12:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5a6ca4bsm32985265ab.22.2025.04.02.06.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:12:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
Subject: Re: [PATCH 0/2] ublk: fixes for selftests
Message-Id: <174359956539.20480.17105268115889494986.b4-ty@kernel.dk>
Date: Wed, 02 Apr 2025 07:12:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 01 Apr 2025 14:49:07 -0600, Uday Shankar wrote:
> Fix a couple of issues I saw when developing selftests for ublk. These
> patches are split out from the following series:
> 
> https://lore.kernel.org/linux-block/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com/T/#t
> 
> 

Applied, thanks!

[1/2] selftests: ublk: kublk: use ioctl-encoded opcodes
      (no commit info)
[2/2] selftests: ublk: kublk: fix an error log line
      (no commit info)

Best regards,
-- 
Jens Axboe



