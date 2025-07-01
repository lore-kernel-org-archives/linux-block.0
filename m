Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0E269AFB
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378117; cv=none; b=nfBXwKvE+Jo5vaV+GaqQN+FzJlBtGQphcsZeYtNP2KV1tMxe3WoT7WEtNxRPiExhQiyPrCiVxHbb98iDumlv58th6mMXGiKn2kSVnTB4alcPTBjiotmL1WW+nrJ1EWIExxZ0TAYtolGxeBr/PVgojjsb33Dfd6RkSbsHg2JjOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378117; c=relaxed/simple;
	bh=6F3b4MZoG7mZ54cDsjb+4J1391oqB0RJ7h/kq5eAK6g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tOxjGMkFfVOw2C50/xZJc5H/xhD7hAwckUwQYPZVpczZ5umeXoJOk56ANj9tlq5+3HFuVQlHfKN4gSPXZCjc1NL5DzTU0o5LHVvjel48d8qzTpKLTNo9NwBRNkRagscagfzcpEWVPrrsUA/jhPwPLxNSCvEblHwU0741CXsO49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KRNUAWJJ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KRNUAWJJ"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-875dd57d63bso237037439f.0
        for <linux-block@vger.kernel.org>; Tue, 01 Jul 2025 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751378113; x=1751982913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV7FRyn/qDKhPYxjQjJlV2OtqwnrY631kCHwF3JNpwQ=;
        b=KRNUAWJJufecQ+jfrcNTYc8LazX1wAmM0eURR6Mxohkn8YqZsGrzUgJgcxLkEq04SO
         1P/92MMK/VzBXd/xlPTuCaCcXkpFNB+Y4ajRQCVCoxc7O4ZNVHE0xcTJP3383KZtNJuv
         8Nq7Ald5IQ35Qh3IseZfNeUt/pE9JPGE3QhyuqG/dnreQ3UQ9LTerAnnVPyI/F5+VPIV
         wzT3QGbsSnEt8oZqDdvlNEokux7VWzRXrUu30BnvKjQct01RkbO8dEYkgKwy6MC/5jHV
         uZdQ5Km4w1e1T28Y/r8+gMpbYaOcCB9Hsb2U4Bkxr+LbK4oiTDIalXrREifDEPfSa9Wj
         xPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751378113; x=1751982913;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV7FRyn/qDKhPYxjQjJlV2OtqwnrY631kCHwF3JNpwQ=;
        b=L03h7TQupJYVilLhQkzA+85A5MldgoKElbiHvhJATKl13N+VPLGYC09fJO/bPflDWw
         3imHbaJBOaqnqko4OA8OF3vkcQNG5gEtA0Cnc8IUYyBQBcS/CAt4lMFfcJaZd5FNjPM3
         TpY8+HOLZsC/gUOYuiCP2fApjdrgiTyCFrZ3LGkPNn3zvMHvjYbvrIt03sgGKLldELEa
         7LBpz7EikDrjZevPsoi8ud0JSR5Zdl8AP1RQv1dS74lKany+zKGhrDdn/k+FQ9ratAcX
         gReQlXe3wLtR+E/We9fa61B+YQFTOGW4YWdXlc5zhoUZDSnXQMcE+P4YQR+cSD1AvzKf
         7ctA==
X-Gm-Message-State: AOJu0Yym6eOzzeQZsENj0WT8ze9/R9V4nSMydhheDwe2mLcMaHlyVV5e
	mctpubZErfPUAPOk0m8avfDyYq0Tbour9zuwwznqJ1TrPTY6KnHIMJi+hExbsrH6tnSJDgktpiB
	TprYG
X-Gm-Gg: ASbGncuE4reQNflxnHb5LBW/2vu+/KtIJ8Zz+upJQR2N48AGvwy5FnxsiQ0gUG5+ePw
	guJoamUmZWkQa+5bcVCyIn9vd1UWokWnOtA7amkCscgqchXLcvwXcK3zhwYtBT0xlZ9xjv2nXHi
	yh+AK67kNfxsYTiwqv0hFdV7Vx+Su8TvSV9waSF9wHffrmCv/4SAo658CUqPQxa+5mX5cTYiaJh
	P+08y1OLsdGqXP+23VVKP4hpalFapXH12ZxV49kx8w1ZG5aQgOGe+hG5h1sJsJhRaWrHDtL7OpZ
	7UDPABzfV0htEpnfHiVAnzxFwLR+prUxTLVfvWRN4REfFHSbsY+1GA==
X-Google-Smtp-Source: AGHT+IE6cpin2Ae+2K+3M2sqGu6WAjtlrFz5JoixHbBqKe9psLgVjm3KcJs4qPogHMhWRJC5Ww4Gpw==
X-Received: by 2002:a5d:8608:0:b0:867:16f4:5254 with SMTP id ca18e2360f4ac-876b90eb847mr363403039f.6.1751378113268;
        Tue, 01 Jul 2025 06:55:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87687b3ee95sm229373239f.47.2025.07.01.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 06:55:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Changhui Zhong <czhong@redhat.com>
In-Reply-To: <20250701072325.1458109-1-ming.lei@redhat.com>
References: <20250701072325.1458109-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: don't queue request if the associated uring_cmd
 is canceled
Message-Id: <175137811230.315700.17821411323538524577.b4-ty@kernel.dk>
Date: Tue, 01 Jul 2025 07:55:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Tue, 01 Jul 2025 15:23:25 +0800, Ming Lei wrote:
> Commit 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and io task")
> need to dereference `io->cmd` for checking if the IO can be added to current
> batch, see ublk_belong_to_same_batch() and io_uring_cmd_ctx_handle(). However,
> `io->cmd` may become invalid after the uring_cmd is canceled.
> 
> Fixes it by only allowing to queue this IO in case that ublk_prep_req()
> returns `BLK_STS_OK`, when 'io->cmd' is guaranteed to be valid.
> 
> [...]

Applied, thanks!

[1/1] ublk: don't queue request if the associated uring_cmd is canceled
      commit: 01ed88aea527e19def9070349399684522c66c72

Best regards,
-- 
Jens Axboe



