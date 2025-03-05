Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEF2356C2
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185930; cv=none; b=Xm40EIqEnGxbgoSauyvR0sZlSPq4dMRVF00cTCX1m5OMM3sooNlvWq5NzXp5fc9cT/J9z8YdA2KbC42HaC4f+qTJCc4nvN2GD0pzbKMzDZdkT2TIIoNy8ztLdZqVxR7CE66Lz4jKfR9sk/3HomJ9/owx+OlhA8BR3tZ+uIAjNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185930; c=relaxed/simple;
	bh=QD3ga/c6a6dPSLCRDh0XYDvnBkS+MZ1s3Z50gU7AYl8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o347Pfb7jHSTbhL0DIT4eISGMte0kzd3jYYVjKyT/6qrU6gk6R9fGMjjsaGKvErUv5aZP3houSAghi4UzndqjFHdXhMYCRVlVBkbnA7qmlurWevf1IgSNP1HvB4kHAF/arSYI9CMo8+QEcpDeR7F8PRg0rPfoalmpPAaFB2Ox0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M5LUgQFf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M5LUgQFf"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d3e28e6bb4so49285805ab.3
        for <linux-block@vger.kernel.org>; Wed, 05 Mar 2025 06:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741185926; x=1741790726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m697LK8H3MxKU8e0ryDs2CXnNQZ/RNDmKpVLCA+5XWc=;
        b=M5LUgQFfu9grwrvTi+/8JxB3tvMmYYHfhBkUx6iN23V/CfQCjAOeUyUs3H6YKiikr8
         oyOHUZxQbE5G+d2wb10iEkjwvF1UFnNeCTKkHSTbevt+/1MK6tnadiSdhT/A15VdLNqh
         GBUJhdXVGwM5wIrsbQeGNcaE+B9JR/wC3ss5qf9Q4KNaH/C+D99y5TqpXR53cS7iSIfP
         mAtPXr8cb8Fb6AOYw8OzAV0SdZ6ObkXlattm4Zcj1P/RxPkWw0kgGXvy/owLzeS20Z+N
         bNzg2rZ3dUJo1sY41/+7tPgH5+WyQrYdqsZ9aJzQmxtIY9BOWUaaoKgDr7Q9KthI3YoV
         u4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185926; x=1741790726;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m697LK8H3MxKU8e0ryDs2CXnNQZ/RNDmKpVLCA+5XWc=;
        b=jNNqe2bTA2mmQxjRb9TtC/1XFOAQNeiGnnjB/cIT5AFRdpNCI0MvmVnSQq2CNwaNep
         DOdmFzP1M1EUnlaulygbmSYaEK8DMtUPPoT79TzG4yo8xGA4gL+Nfkb2w1BOAo4X/bfG
         62oKdLtm9ajt022flDwaDt6FHh9JntrTNpX0Vr55yu1nHJZnlM2y7h64yoDoQzB/jBnp
         aagnAaTGuH0LNfJeZ+MtFFiqBPxZYCDUXDYvrYkU97xUCpyff2HI+ephXA/99j6SL9T4
         JUSaMSE0xGTEsyrH+9A88wtSv2IMawdNfInShKVLFWrVnrGfn4xzGnXfPqmboivQT+fY
         6LoQ==
X-Gm-Message-State: AOJu0YxX/C9C9rabAeEXsZfhCjT4o09yjh+hdhb09x9h4nXvSnsuCo+z
	FLwfTiiZlD+EF/teYfhcvzz1hVU9aTAdwxAxieU4uoDvA+6jOAyznksyRTxdZLTW8yYdlsqlZ5U
	d
X-Gm-Gg: ASbGncv3KeYCcUH2TLv7/zrEu2uijaVFaZ8jJuWVTKyCHYa6AyRv9x0JLZ7CI9OpxyX
	Ox+UqhaqZQdNtddLfxQHm62NaXCMm8T6V/V5t7a1Yt+YwJ93vcTPolgKWMFJZQBPkgDXC++ZBOa
	6jx4Tjc7hbUIri253xRf3PTavDqoMjcwtmHhmc0qTAeOlbsU9FKWZM6uzBsX2IwFUIQo7ffOLCp
	EmkZH/W5T5tT9SC6Alf96NF99RDmkuBCAfbEdVl55ZOnXCw4pKzbeci/yB1QO7j4W5kia2jVhNK
	Yf42eUT4GHFPZ5cZ0OcLZ2nIkjyxn8wzla4=
X-Google-Smtp-Source: AGHT+IE+nw0PXhiFEnRRFQEatyfHWRw6QhVn7+SN+ikDIHOOsoZLnm9P9x2fgGyq567pucoW9v70Mg==
X-Received: by 2002:a05:6e02:170a:b0:3d3:cfac:ce2d with SMTP id e9e14a558f8ab-3d42b996236mr41627935ab.21.1741185925695;
        Wed, 05 Mar 2025 06:45:25 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c07b73sm3585381173.23.2025.03.05.06.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:45:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250304-set_params-v1-1-17b5e0887606@purestorage.com>
References: <20250304-set_params-v1-1-17b5e0887606@purestorage.com>
Subject: Re: [PATCH] ublk: set_params: properly check if parameters can be
 applied
Message-Id: <174118592485.8596.3723770986875822816.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 07:45:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Tue, 04 Mar 2025 14:34:26 -0700, Uday Shankar wrote:
> The parameters set by the set_params call are only applied to the block
> device in the start_dev call. So if a device has already been started, a
> subsequently issued set_params on that device will not have the desired
> effect, and should return an error. There is an existing check for this
> - set_params fails on devices in the LIVE state. But this check is not
> sufficient to cover the recovery case. In this case, the device will be
> in the QUIESCED or FAIL_IO states, so set_params will succeed. But this
> success is misleading, because the parameters will not be applied, since
> the device has already been started (by a previous ublk server). The bit
> UB_STATE_USED is set on completion of the start_dev; use it to detect
> and fail set_params commands which arrive too late to be applied (after
> start_dev).
> 
> [...]

Applied, thanks!

[1/1] ublk: set_params: properly check if parameters can be applied
      (no commit info)

Best regards,
-- 
Jens Axboe



