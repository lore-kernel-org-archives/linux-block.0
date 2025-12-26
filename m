Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD695464D
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766765556; cv=none; b=dkJCZxLPKjeWvCWik4YK8gx4gsBnlyqLR5ylUyxN55FzEIFO+L2gqrJUipWmcqLKBbyydErgn9ZkSYBupC4EhNu3wZxOJa2E9ojS2MRkG5VByUa+rrlZDOn3odC3NLHr25J7hXQVk/nBxbymHSXmRl2kiyz+c3IZ6aCmpcoGtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766765556; c=relaxed/simple;
	bh=GrF7+TdMSvVYDb+7UIbVZ2eRHLk3l+RXmfkU5nmOm+c=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZWcXcnm0+aKAR9dxJKPQeCp8XgFymHiM/KWxMNgeoUXxIDyKb9IU+D3OC13bhcfZy+25sJbLhYE66I9QylS3NmU8s/i0gx1WVP7pZwNpF1wFqnrIzj3C82F/Vpbla2uT7tv/H8dDj4X5evLwHcLb4uQ4I8Qr5lU0K7DUsY6QqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ikXMBZDE; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ikXMBZDE"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-459a258561cso1186249b6e.0
        for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766765551; x=1767370351; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7E8eTD8ybNtwHejmf3cksDdc3c4tT4lrwbCTkie2ik=;
        b=ikXMBZDEoFcuHISH6Jc7UCD8OA7xtWpsNTBPPZfwuVsOQlgvIU1d33lwX9JJoeeVOk
         zFSDYeJF1gu1HBCM7uJ2/wDMgsY7Z00Kt7qPltHV3fGXkJs3znm1FdNyDlKh1eoffJwu
         J41qMC2Aq5zT7aq21xVl/wQtOuPhLqCWOuEuG0MYDN/6tQSDlDhhndkvRO+y9vVKmjZp
         Hc6lbENNV+wG3SyZVyiYdruT9gWTh45j944DrBHvTZqflKXqu6/NnPDNuXXMN+sCOPuY
         4MoGZP4ITz+i0loYxE2B0DFybfrHx+IKHLdluYiApautb4BtRqEdxoN3ddcyxaH9JxZe
         Dj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766765551; x=1767370351;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7E8eTD8ybNtwHejmf3cksDdc3c4tT4lrwbCTkie2ik=;
        b=uUBgJpgatAGRarJRLTEq2gX5i+yQEgQ5R/PiujvKGJQJ2r0r0HLT5kFj5t1t/5Tnqc
         rpUlGgYPgosuZJP3FTE/ovptnpszMuvengSfYkA/QhhJFgW384obmZtvkNnMKYMFpdq2
         /0G/9yua3Nr/UxyXcReVczIxZBe3fQMqXMoka5SK1DFa4B85KODv6pdz8AqMms4ZUjRn
         uW6fDN95O2qs/fTPEyVSlCx8euoqR9Vt6baPBWU6vEolcoXr6oYSfVsX5c0RK7lnSaWa
         6v4gV7A8/yHv21Wt8c8yEgkXTqfpqdSX8dDJvczCt3GJy3KTuD90jin14af418UOxchb
         QMpQ==
X-Gm-Message-State: AOJu0YzUvM8pgpKRFgmM8eYkyEexSezUBa8j5LAxzNoPyCeO+sR6wuIG
	t4YSXpLg/Kc0feXQOLV9idaVC0kaIOsyeidueFzx4Vd+Nd8TPo1rNWkO+2JRCBHNtOVoI991JPx
	uIDBF
X-Gm-Gg: AY/fxX5bcVQQbe0xMpBS5uweIp9Xi/CsJUkwdyuw8fqibpDcLAFGOggt9+hYEXsuw3w
	cBl7Zovhie182rlqXbwhp8LX02U54lxO8e4Tth6EOoSuELGHcLMyiAzvONBlfhosL91RI7qvKJd
	MrT3BHzwdVkVL80cGnSbvdxKiMnBM4cP666XTwOA9LLaguegb7ogF+6Jmrhq9/zqbXmUr6g7uh4
	Gh9DzhS4Z3pBtncvTQ1hRiUOISi3ZzxdcGFHhi6qvAvDsdI4OatXayevxfH7VWhd2mRQwIBSRgP
	Ksk2YaXS2GtyUeVLlfBIjDVE81+ZfrERxKBA07pRUSJ4C7ibdL8xzgD9uJX+lN0+fWDrM3YDqPI
	57cpyuGw7UzY1NJVu9V8uQ1OT+EPzWsDd4e0CxIXxkCdxeonAlOuh3j2SNqaFtyE/k+mhzj25Jp
	ue3c1TL29p
X-Google-Smtp-Source: AGHT+IEOEKFANSVQcZTrd7XONyrEQvo2uCyH4pQlzhHzZQtVAzK7MNNvxvLXLbbNU3rXXYPPrLeekQ==
X-Received: by 2002:a05:6808:1205:b0:44f:8ccd:c489 with SMTP id 5614622812f47-457b2256e3emr10701927b6e.25.1766765550807;
        Fri, 26 Dec 2025 08:12:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3ba440asm11117489b6e.5.2025.12.26.08.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 08:12:29 -0800 (PST)
Message-ID: <b136d4fd-a686-449c-b2db-71952cf29ac5@kernel.dk>
Date: Fri, 26 Dec 2025 09:12:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.19-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Two minor fixes for the current kernel release. This pull request
contains:

- Fix for a signedness issue introduced in this kernel release for rnbd.

- Fix up user copy references for ublk when the server exits.

Please pull!


The following changes since commit af65faf34f6e9919bdd2912770d25d2a73cbcc7c:

  block: validate interval_exp integrity limit (2025-12-18 09:51:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251226

for you to fetch changes up to 1ddb815fdfd45613c32e9bd1f7137428f298e541:

  block: rnbd-clt: Fix signedness bug in init_dev() (2025-12-20 12:56:48 -0700)

----------------------------------------------------------------
block-6.19-20251226

----------------------------------------------------------------
Caleb Sander Mateos (1):
      ublk: clean up user copy references on ublk server exit

Dan Carpenter (1):
      block: rnbd-clt: Fix signedness bug in init_dev()

 drivers/block/rnbd/rnbd-clt.h | 2 +-
 drivers/block/ublk_drv.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Jens Axboe

