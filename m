Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E82D045
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583700; cv=none; b=kdyZUYQdZ8fYonfwChyULKt8noujN/JVUSLuyawbvWjgKloB4cQl9+Tj+WTz7dMKBoAIG2hysBKPSdZlhMCXOJbs034llP/qa6peMiwqj/PjnzlXeruurxAK3A/RCHj+vOxBc4sA7HIf5hxeKHAkYDTPUrHfFEmKNgYNeeS6MeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583700; c=relaxed/simple;
	bh=TRuhJ3n6skZiZGABNqgbiW/7gkE7i4ytmynvNlxNH+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E/QQ2zLkqsLaVXiGGhS2mSi8U+Gh7ryxs59PERiSAelDAtOBpsbzJVUt/xMWJNxrcuS6rRoZiLHmuTojpoOcJsoRNeLXlRDseBrSi3WopwohENgOz4WaNwkifQrMvxRNhvsKTYUPYMQ95Yt606z/JxKOA4FMlFgHfi0I2W2BSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OsIo4jBN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OsIo4jBN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so49391405e9.0
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726583695; x=1727188495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyAM5mz4naK6179KU+h9Irp440GNtjheU4pbgzdJ1Gs=;
        b=OsIo4jBNMCHDdzYa/6KT5HbNRveqw8F2Wsnhg1P2lSvB3MmxO15Eb5+XziNgDCEkqF
         SjG3qloewFywsb4YGFWZLP6Sf9s0ZMmF1zxNeSwiP6zrSlFN3y5YQrgdI+FdbWhzpWDZ
         5mkPMc1qoN3AJozvA4cZS6QqBoKcTjRsBhKyX9DdRJHMfDPqjVadG9E92ivoCfTDoEJp
         0kqI6cQRisrLf0ZO0INGLGP/iop3ZzCRH+ZYoRan0SYcwemFXfVG43hZQmDZdhqAeLby
         QqqXj6ZyxWrI56/H3S+vI3H3b4QHVr6d/8ZMIpzVe8neyJPH6CH2e5nhh8OQiRRDhwpB
         vLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726583695; x=1727188495;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyAM5mz4naK6179KU+h9Irp440GNtjheU4pbgzdJ1Gs=;
        b=qYLpnkj3JFGHloWpNdhLNoXd7bV8c7Ijd5lQBGTS5POAWxzIELoPEMeycqwGRIt+pg
         iAcrfRVqh/I8IRajNLHexj1eA5mOfoji01lhw9/nuLIss6R2dNbnEcevG0zdkBY488EX
         d8t5WCyxHT1mSdD0R7HT5AApXR6OnPmxe5cLblodf+LR15LngL1puryaNscYxKUB2y+m
         Yj/sDlFsEdQHkopb/jCyFNrum5hK7XatE2sRpRqkkzelspIjr8ifYzWKp9tl3N/t2Soz
         rsmps7CH5ejGsHCIL+NQmSIya/+3Ohb8XMxQ3+LCyoX3r4jot78fHkQ2y5WGaGiNgvWZ
         bOiw==
X-Gm-Message-State: AOJu0Yzh0XvwawFb1SMHHkxnM1vnE81Okd5QgoqfwR3jxa5DEuuYA9iq
	WTZO2uHHGPf8dq0adMmVgGAHaSjfnOyZZr1OJJ6/mTxfioUF0PlzNHVorPGGDJQ=
X-Google-Smtp-Source: AGHT+IEgitLdHKmMMrXeHwZ0+BcJSoYKIdBMY2E4RYqEvjQxX6evUxWSyhQP9XDAquj42QUvgMsauQ==
X-Received: by 2002:a05:6000:1042:b0:374:ca4f:bd78 with SMTP id ffacd0b85a97d-378c2cfeb64mr10884272f8f.10.1726583695072;
        Tue, 17 Sep 2024 07:34:55 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f062esm9802961f8f.7.2024.09.17.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:34:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: "Richard W . M . Jones" <rjones@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>, 
 Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>, 
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240917133231.134806-1-dlemoal@kernel.org>
References: <20240917133231.134806-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] block: Fix elv_iosched_local_module handling of
 "none" scheduler
Message-Id: <172658369407.460122.5832573165209908687.b4-ty@kernel.dk>
Date: Tue, 17 Sep 2024 08:34:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Tue, 17 Sep 2024 22:32:31 +0900, Damien Le Moal wrote:
> Commit 734e1a860312 ("block: Prevent deadlocks when switching
> elevators") introduced the function elv_iosched_load_module() to allow
> loading an elevator module outside of elv_iosched_store() with the
> target device queue not frozen, to avoid deadlocks. However, the "none"
> scheduler does not have a module and as a result,
> elv_iosched_load_module() always returns an error when trying to switch
> to this valid scheduler.
> 
> [...]

Applied, thanks!

[1/1] block: Fix elv_iosched_local_module handling of "none" scheduler
      commit: e3accac1a976e65491a9b9fba82ce8ddbd3d2389

Best regards,
-- 
Jens Axboe



