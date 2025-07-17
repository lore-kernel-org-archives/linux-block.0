Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDD29DB76
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753800; cv=none; b=ILgmycei4fTTx2bM3dekzYaQaO34uWUpUYergTg//MBKLwHPMnIs55EzWVURIeT5QuyJbHvIfmyf0FrRJeaRJKajJDOp6NJAUoOpAV3UNm9Z8uVxhoGcq60q1AC56OV4YneFvDCTCuA1H9oMZ9hA6XNtymoYBZiLlRdUaE7AAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753800; c=relaxed/simple;
	bh=jy1nYicwP571nkfz1sS0ftJUShTC8h6ew9d+l9gdzcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tl6LBwpgMjm4LxtE97bhSCmu8PhgvSWaLy5quveSAT6aJvFk6pJ7hU+c7Os+WSQ1v8QWmLalfs9tWY1ZU6aqiiAQp6xx4YpPZwXlfKLFlCJMgju2nHkhe2WLzsRX6BZSXw34KD8Yt8/jNR9mujq0AQ4Xsn+Kqv+G7b231Hkq1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=meG3iLwg; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="meG3iLwg"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2d111fefso7385585ab.1
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752753797; x=1753358597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lumM2yQ8Yhssc9akl4RdGjzpp2HwGSl6F0XVW4q/Y04=;
        b=meG3iLwgvanPWmulsmxWgB3fV0xfW7VwFBq1gp93yVEhOIw3skz50y5PW71GB4Jhqh
         wU5rhI2vEU9WXImCDGWLM/7ZS+E0A7IO3ftSGQKYCtg1oCwuXfhYELYB81sDprE6FjmI
         L0K2yiiwoq8l6M7YuI/jSsUyfd6Zf4zRV2t/c9xlfz5lFVUQDAIhFBYu7j8aKhKDMJpz
         EyaqGrK4O9UIxAvgxdR/UXrvTsyAGEQ3DIOK+inTnxiwC96rSGqLQs1H6pTlpDoPjoFq
         Q55ULT6TRoAIuidv3+AlQ32wpGOs41wDRWfOusasyZbD/Ory7VWzisTqn22WcLe6XCTl
         irWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753797; x=1753358597;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lumM2yQ8Yhssc9akl4RdGjzpp2HwGSl6F0XVW4q/Y04=;
        b=H/DBZdvT2epx4PdWtAf1ist9GpVO992mTvVDW7wZLkPZdR59idQ8++pz2OLUQ8w18G
         gMjabhWmIBK5y7oVvtwqX+bhRWZ1HL9vn4wNEzoJd94lGpLKxgwLZE1cnnpplVagPBCT
         JZwO7w/lYDuSjnq85Jh5qRWbEbzgri3SxZmQhjOFxAGVGAoXTnRUZRlLJGIaAPIK1Iic
         lyRd2q/7kWnII+yFaHyaZjkrjQdoc5FfmH+RTIMelZrw9qzHvxo2rJN6XPMMuDilW5fU
         cGe2aOSHl/rwSFcqnODUG2ohRoQfJFGHNsEAg/x1pJ99O4fA0+RZutQih1FhHeCy2d+w
         j2gA==
X-Gm-Message-State: AOJu0YwvAg5SwAyakQFknv6FfYaCjGcdsSG7JUl8fPTxLNzdHbYnTqHF
	Cf3Pv3Gl+xL1q40lBh82T+kzq3clSpEw+O2Fkn6toYz+Pt2lh0y1VEvLnp3TMxiaU8M=
X-Gm-Gg: ASbGncugL8I3WqDH+XKyGpTlvyqDkyUQSR1P0q9mc7QRGr9gIW8DS6seiGJr/oB+nEh
	G7aUvvJ0ZRBSIqFaPYi8XgkT5DSCWOy4pELZ+p9ijieEXzgOFb+wvXjU1WVvpMHWX40GGnOYLqk
	9786qDPUussb8w3lyfaLqDLSOK9V+za+qHgmy5+mZNzJ0X8+62YScZLLsbLwTe52bNOJ+LPWsGh
	6K+wOKLdz9CyfVEfQoPIAk6+6x9XZ8e+NR+AdDnDMxvP5ERdrAKyIgxIfW8JC982D4YmLKX+dlI
	L2ft76jIdU+kFElS4i1U0B4L4MHT8RH6cktQKw0ekNQqn2JJg5ODJW416hPL0kMKGntTWVLZb7P
	+YVWQ6X+7x2gCNg==
X-Google-Smtp-Source: AGHT+IESYYPRRnwpIfIUlJmZvxU37W0TRppo3py5BUppAuu9K4QZ3AtW+Gdv9q6Kcv0H8Z/O4o9tCQ==
X-Received: by 2002:a05:6e02:16c7:b0:3df:4cf8:dd50 with SMTP id e9e14a558f8ab-3e282ecaaf5mr67232655ab.19.1752753796717;
        Thu, 17 Jul 2025 05:03:16 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620ac53sm52360525ab.41.2025.07.17.05.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:03:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>
In-Reply-To: <20250717103539.37279-1-shinichiro.kawasaki@wdc.com>
References: <20250717103539.37279-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH for-next v2] dm: split write BIOs on zone boundaries
 when zone append is not emulated
Message-Id: <175275379583.372539.3488682715732901571.b4-ty@kernel.dk>
Date: Thu, 17 Jul 2025 06:03:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 17 Jul 2025 19:35:39 +0900, Shin'ichiro Kawasaki wrote:
> Commit 2df7168717b7 ("dm: Always split write BIOs to zoned device
> limits") updates the device-mapper driver to perform splits for the
> write BIOs. However, it did not address the cases where DM targets do
> not emulate zone append, such as in the cases of dm-linear or dm-flakey.
> For these targets, when the write BIOs span across zone boundaries, they
> trigger WARN_ON_ONCE(bio_straddles_zones(bio)) in
> blk_zone_wplug_handle_write(). This results in I/O errors. The errors
> are reproduced by running blktests test case zbd/004 using zoned
> dm-linear or dm-flakey devices.
> 
> [...]

Applied, thanks!

[1/1] dm: split write BIOs on zone boundaries when zone append is not emulated
      commit: 675f940576351bb049f5677615140b9d0a7712d0

Best regards,
-- 
Jens Axboe



