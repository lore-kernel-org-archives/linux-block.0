Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03617288CB3
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588437; cv=none; b=rI+RsHPSyQ975edE6rJcXoN4mDqJYQredXzLWvplpiC3aGrTWtfQs8TG0X7m4sLtCrUWiy6DzOCFcDDZ/bEcd49IF92Zq+vsQf+tr2V0hcCDaZ84dR8SeZ1S/Y+RlHzf5CewxxtRlh+xCNgJJQn37Q3TgdcgYuCYwxkfnnmkjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588437; c=relaxed/simple;
	bh=rH8vLJjVvcnvwVW7C1WjiLzwSDdaSNBkY9KFZe2rrYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nRe23rAWRTIydAKiwc4I/gesv5XKtYlu865OBqulHNzS1jHOUeYmDMoOIDkNBJS2Gne7urgGbpozXTeMOQXl/nAN81X4raUVb5Sr4v5LDf+FYryXlQOyOu9A+ka7KnmVCYY9sX2GsO+1hmKH6ke3hN5hXW3STqUAS6qj5cS0tyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MuwcwC2Q; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MuwcwC2Q"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86d0168616aso440826639f.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752588434; x=1753193234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSLTuN0JEDOO0Mctqn4+SfcgNBW9OjaOnvJ7zR4Tnj4=;
        b=MuwcwC2QXW6c9sCH8OBl8UJcn+6+3I6luK1OYrlqhoQ53nCb2a602rMhqvGjxdExwf
         WjYayM9PnWNcWGPvbzhlm9zYS5mN4d84EbcKtTSsrjUvanV/B10xHyKU4qyA6Wq0yxba
         YNnX8xUD9a7Phnc4jZjdWe6V1XX22O0lR/So7DW2UBdmC9BCcRFxXZ0V/xiVPr0grDNd
         4Mhb3bwYGz/4/tGtSa2fy3DRicwWeennIBuWhonFHSLo7uvKNiYDcFMfxVZ+bV5Rwx2w
         HEasm+yWIxHdPATa++drA2sZ6Rp2LcEVBVwYFBm8Rwbi5RoJdsSiGDp/lV6drjFhQDtn
         l45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588434; x=1753193234;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSLTuN0JEDOO0Mctqn4+SfcgNBW9OjaOnvJ7zR4Tnj4=;
        b=uxr5R3dKQSC9U7dcJdohdA1wb64hsNHX5rBEFDt0WWXHCb+Gc8te5RUZ5SAFWtzOA0
         bEbCb/lSFp51kWfqcPNwmN58EMi08kssFamwFoN9P2W4eCToojVT5qkdIIP6NoRKYNjb
         5ZrgnXIR+sWLfPf/pIFIOrGNgGJOcIf3Q4jTnTgKA9mmUlUyZkguqaEcU3yBj6lRSzsF
         /DZFFAqufS6L+wKqBt0XvgahQzImq3l3OgGuAcORW6QVndRds23x+dfL/xulUOrt8Yp2
         /vOQadTcClp4ZhnQllx9pS/RU/B5MuBapDJaRhDos0YUV3/Z8k3vojDvrDKj/0X/WAlD
         ojTA==
X-Forwarded-Encrypted: i=1; AJvYcCUKmQBiU3FaCeHzpt58PUZmpRfc5MQyrtgAYRR+KFGWf1+eP/9Vw8D8iW6EetcmRZA2kvrzoioMqdPXqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09AFUejAxWTGq2Y6pTF5iVfvKHonaJzBHQgZhf7s2hG+uMG7V
	zRlPoo2CVHP03Wbkj5HOhxhpxW6KEl9oU6adi1fGM1PteVkiokWnMTM1vosPXeQ3ffC5r7+fBoO
	ue4J+
X-Gm-Gg: ASbGnctE2qcDikjBLvL+XxyoB3CpDjvWlQOB2qFalfltTjsZpN3zZIVGUl7RYj7yZgf
	ShaGxS/GyC52L4A/8ffe7OIijoi7/dfhKF6CNEzIk8qcLjjaBlUpr7IVADdwpHVumS8MMK9kRdR
	+i1OuVU5TiZG3ieUu1CZKwaWLSm5Px6kHIONjUfceSerM0TfyoaIJiLs0VmgrujJFoef+m6Z4iw
	OrUsDeETpu/vYZzlRKYVKGH1NkIdUmyLjK4Ha8daEwXFHzOU+6MwjL2uRfu9v5165lbfJ8ep4GH
	7rxF6yhIhM3Nn/cAt70J5wszhAiLG/wVz2Ui16i/v8SrKpH2typv4vD/9wGBWXxOB055pmo9Rye
	iYxyWEsDmTTJa9bXYnS2Qf/DI
X-Google-Smtp-Source: AGHT+IGFuhT6n4nxKQpxSPq/Cx9f2ui65THqMYwQULVwMVdZNDPsZwtwMPX05LghVHRN3ng5uSRAJA==
X-Received: by 2002:a05:6602:4802:b0:879:54a5:b44f with SMTP id ca18e2360f4ac-879786c7bb9mr1919534739f.0.1752588433570;
        Tue, 15 Jul 2025 07:07:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556535f2asm2573263173.1.2025.07.15.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:07:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org
In-Reply-To: <20250715115324.53308-1-johannes.thumshirn@wdc.com>
References: <20250715115324.53308-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 0/5] block: add tracepoints for ZBD specific
 operations
Message-Id: <175258843230.163854.17737825052338379432.b4-ty@kernel.dk>
Date: Tue, 15 Jul 2025 08:07:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 15 Jul 2025 13:53:19 +0200, Johannes Thumshirn wrote:
> These tracepoints are also the foundation for adding zoned block device
> support to blktrace, which will be sent in a follow up.
> 
> But even without the immediate support for ZBD operations in blktrace, these
> tracepoints have prooven to be effective in debugging issues with filesystems
> on zoned block devices.
> 
> [...]

Applied, thanks!

[1/5] blktrace: add zoned block commands to blk_fill_rwbs
      commit: bd116214d53c66dc7f863822af171b20c06b4784
[2/5] block: split blk_zone_update_request_bio into two functions
      commit: 5022dae76234b3fcd219e03e091fd0b829690af6
[3/5] block: add tracepoint for blk_zone_update_request_bio
      commit: 4cc21a00762b5bd4dcd743317a56c2dba500fd89
[4/5] block: add tracepoint for blkdev_zone_mgmt
      commit: 4020d22f0d08ccfc0d00a254a90250ff07333607
[5/5] block: add trace messages to zone write plugging
      commit: 2e92ac61c9012ae4bcde2838c5f57f85e4b2623c

Best regards,
-- 
Jens Axboe



