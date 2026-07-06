Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BE1DED49
	for <linux-block@vger.kernel.org>; Mon,  6 Jul 2026 03:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307762; cv=none; b=A5P+GErJSTR00pAS8sAzgfpFuWNH5xdZIrZKW68KRmvpyrxkL2vxetaPCgHB1sgsbxGVoj/YlDoE+WKseiLdToh4Waz9TQF0PJ7kWj3KKpGvXzF954oeqiN7aE91rWnpcMr5CEKjq1Yr2geIYO4P/OyagADyufUZywrv9jUQkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307762; c=relaxed/simple;
	bh=2JrOu8ZYb7tHM+J8eIgn/teiRpLN+8jSh9WWl9nAN4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NrGgGuGaXTvf77eEhY5mr+qijmcpRGNzX8gI1UCMaI6oGmVnYIyjG3eDwHdUkjemw3ZMEmuHQ9H+5n7JLBFyNSRG3dxNPqjGYaA3R1Rk4YaVP6byZaJODh/7BZcAcUGUd510FyKGSOOx8pJ+zTNMMFwWIEmdOFPmLAwrTYMN7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdlTEJtp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdlTEJtp"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eaa7b5e31eso20261886d6.0
        for <linux-block@vger.kernel.org>; Sun, 05 Jul 2026 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783307760; x=1783912560; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2Lmo0Z9LtR3itZCUsud8f61jOwZl96l9I13KLRvA0M=;
        b=fdlTEJtpPT4ZvgGgVfe/2ku6akqaPyx3D51U9jiUF0nvXD5dLD+R0urlmsRLECPDsN
         brsOYB2ZXov9FfedDK7uqHprawcYnrd/RSuJFoPv9KTzp6UCX6l8/BkgAa1F+nmmuRiA
         uDaZtNCsFQAbOf3OJlChQcdCDRpecYNkjq7lH3k0JpJgN/E190QGVoP1vF6e+R/1tpNz
         u6RgMGVc6ClCk4aeBoQ2MHH5YQWmeN7XLRXMXb2ZJytxCMeg6ZeTA84/uPz++vBHtQqb
         4WD3miKyPGfWuQCz9JSs3QjkQrW7E5UEARJVmryGpj/HXOTM4pm/84zUAkre10tZCJPq
         KGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783307760; x=1783912560;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2Lmo0Z9LtR3itZCUsud8f61jOwZl96l9I13KLRvA0M=;
        b=tSVVtv4vj0/PxK2FUTk9PyGYU31DMeoL6L1sQN18Ykb8FxC3XYQaT/FIYBZI0L1cH5
         AKSq6JrDq+gmybDgsh5nOLSzIdW+Ax+JWqA/ipSSPD8MXERlL3N0E904FtSWhsdEYD8T
         0I5BBHg0RDD6rCG3i+LioSm80KX7UoxxnJFPppx9J39FOxJG2jjN10MrLQI3rWr7zWZL
         5ufdH4Ca4UsWNt9XmrmfmVDryOo020N769EkQMkD4yEJqztDsf6IX9KQpVR7IsbYjB6s
         0mSa6Ml5ZfSA482XhPX4o+xWFW1X/ifEt4VaCHps+Fkx0dkIBpEve02pKBoCp8MWPP/9
         zAtg==
X-Gm-Message-State: AOJu0Yxemy+Frp/zpdJPZJJDVtmzgjw/0EviV9jebvTCM89/GE/wJcGC
	F32UOdRVoBl8XXN5CQ+jpf8TBO57W+I4eVwUVN690lv8XcG28vNV1wGuQDzgQQ==
X-Gm-Gg: AfdE7cmYuLqdNFyV6soOJCl96uAcU4c4//MTdpeiqHHo7cJr0v/2LoJEn5gbKsJrbsn
	1lOgpLTSI3xLjb+UqAM07QE9HK8zmTrdluH5nFaNYKsMd1Fc0p4nAafqEwxJZzVjiMLWBz0Y49z
	AIFk//9kXawJWJhZz1EL6FRAexZm94wbr+y174jiMMdOkrwNFEbv5/rNSP/zth5n5qeK0Rt1YRr
	gTkG4Z+B0UpezwVL++GIu+iETogJLzTzDwdN+dvuvbqzM1sQluZLy+nKqBkm5llC5MnBZV0ndx3
	502Yk8onjw3BGUT5cQ3A7G4B/+CuXGYIlQ272RGaIjRjPTVMgjoDgpqr/l5WlQsKmR7z5nqBb8i
	sCoCL5XYtmoAesEXYuENQ/iraoo0IgyFvriT73A7AcEs1b3aGH2+vtxli6FPA9kuhUV5tuH94fR
	2/je+VwXIO7Fm6EHJ2XAJ4XU61nl5TcnthRFv6HGk28JockPAOUN1ZOhtQqCnMAhOEKV9u8EPRn
	B8aSi0ReRAIp+gQLGGY
X-Received: by 2002:a05:6214:5902:b0:8f1:fba2:d4aa with SMTP id 6a1803df08f44-8f5bce7ca6cmr177079776d6.16.1783307760406;
        Sun, 05 Jul 2026 20:16:00 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f013f05sm123047226d6.16.2026.07.05.20.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 20:15:59 -0700 (PDT)
Date: Sun, 5 Jul 2026 22:15:54 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [ANNOUNCE] ioutgt: a generic userspace storage target on io_uring
Message-ID: <aksd6ruHwN6bVVKe@fedora-laptop>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've been building `ioutgt`, a generic userspace storage target on
io_uring (Rust, Linux >= 6.11); so far it implements NVMe-oF -- NVMe/TCP
and NVMe/RDMA to an unmodified in-kernel nvme host, mirroring nvme target in
userspace. 

It's early, but it passes `xfstests(./check -g quick)` against kernel
nvme-tcp & nvme-rdma with `ioutgt`.

Single job fio test shows that its perf is very promising compared with
kernel nvme target on mlx5, follows result in the repo:

	https://github.com/io-target/ioutgt

Feedback is welcome!


Thanks,
Ming
