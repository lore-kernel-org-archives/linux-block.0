Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC38204F79
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097791; cv=none; b=UG/B0LmyhaRl+BxXwoUpSbBK0EsExyniLjGC4/wwMROsO0tk3hWLYFV5gmjZNwc3MunETZfOGz3hj03E6WOvHTXT5YfKO+J7wxqrktTmmJmh3S7IxZlbAh8vxs0zks2rs+6eEUWY1wMg1e7UjxKLnWtUSDxB2B3tqqMfcqjLuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097791; c=relaxed/simple;
	bh=4ZJH4JC5NCAq34uANyln48ENejnGDm2pl/k7fWmPFf0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SjE9IACub29CFWgBVmMTDs/HDAWu7+KrZtGeo+DYfCtMUAxK3cSESyOnsYcwCVsg8DI5mx/blGvxhlofZxD+tdWyBTkIHD+4DsyhF8MrRfqxFdmzo9P6SQ5F9KmlMtZbMsGkOLGm6WfRkiIDIPApBFkVWmM/GDKjy9mJzPxT4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vCjXcLhw; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vCjXcLhw"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so20749665ab.2
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741097789; x=1741702589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQpKgDu4ElSZifTyTDqZ0+IWGRMDpXmTQXuBXcDTpW0=;
        b=vCjXcLhwyhZnG1fJdx6rBjmeXlELNYo2PWg4ot47bWNyE1hOU8CHyTuxFMnu1bTLhz
         yLOD549R8WYhdCRlrx34QEwRo7ix5Nhp6G1RZzEosaVsJr8uuHbPnaIlUVP3zyJiOjwI
         /bbMAOKAhKVoSx7Y0wknHOMK70UKYRercf0TBxF8iI1b8Z1MAxlcu8i2sZaX0MlnYQj2
         iJDJ4y8EZZ+ErfEUleMI0U/birsjz9998wNZkuBcaKntuomAlekU3M7aRNQD29kGbfkv
         +PEswAPx82XG60toe4CSB2pe22sezJycffXCLr4JJ2Mx3xAWY8kYLn30T3ooktprBRwE
         lH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097789; x=1741702589;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQpKgDu4ElSZifTyTDqZ0+IWGRMDpXmTQXuBXcDTpW0=;
        b=flN6RUkfYy5f8+et6u85OvbqG0ypvPeYtUQbcO6wwKXgxmQBBvaK8BIoaYZZUdO1KZ
         KqhSFM5uCHetAUewtIEWvp3/hgajZNIukqIezopPCXgsH1o1M8jAxrV7ARgEYJSrZXH1
         b6VcIBFYQr69d8Xd4kLu7N7SDkX4mUPK87WL3/fjOihzcuIyo+O4QmPIt/mjRcTLiM3b
         iNdhSSou+1UkU/2cT+4gqpr2utBy+1irqL9Wa52b8cOpcxjpkWKqopEEgIh5U12Xr/vL
         pxlavpG08wRkgqM9Qn1SpvrY5fk20d5m0+LBxwbqnV/92gfYB6Rv7ZFN5SLNsmM3NpiK
         adZw==
X-Gm-Message-State: AOJu0YwKmIbCFQI9BJE1XYIpEzUUIIvZ2mlPZ7QBl5IxssqTk5YBQZl5
	nkHWOLEF+J2b1JrwrC6UZ3VpGBxbblaCOdJlgTPQfya2lTyBo9PgtLsLEgzvigHWvvwPrEhmcsx
	k
X-Gm-Gg: ASbGncsNAPslWGNSzY5Ae5THrngyOhMzOD6kfTXrIOmGWWjVVDvXNEVIzYwO4DSfi+S
	EFl3DSldu7eIG5XBeGXNhnvYHys2QYdYhtQOlX2I6lgRsc6xSBpaGYCtjEX4aFL/QF/JH5hpVm5
	KrRtIAtI0BG3vv8bz61bApYw9HbtH1zIMc8bYEV1OSIlBOYilMpqrF7I9iYskm5WRIu5ha42Q8u
	MZCkcU6vSz+jcPpjSrv2T6919HatTxTa2dTl+OymBCwRErk9xpiNa+yfrr8rZdCoZLdXbWz20J4
	tDgo5dg6zaARMtuKYQg98exN5eFBY9PQ2ow=
X-Google-Smtp-Source: AGHT+IHkNUnCUpl3S9C1PHvycERwd5D8P8SBt8vYIem9+Og7JkxFkiM/QeSyLNjh6OnakZ8W5Fhz2Q==
X-Received: by 2002:a05:6e02:1fe5:b0:3d1:97e1:cbac with SMTP id e9e14a558f8ab-3d3e6e91255mr151065655ab.11.1741097788756;
        Tue, 04 Mar 2025 06:16:28 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f1e668e5ddsm712422173.140.2025.03.04.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:16:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250227163343.55952-1-yanjun.zhu@linux.dev>
References: <20250227163343.55952-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] loop: Remove struct loop_func_table
Message-Id: <174109778728.2730103.7622983195340534946.b4-ty@kernel.dk>
Date: Tue, 04 Mar 2025 07:16:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Thu, 27 Feb 2025 17:33:43 +0100, Zhu Yanjun wrote:
> The struct is introduced in the commit 754d96798fab
> ("loop: remove loop.h"), but it is not used now.
> So remove it.
> 
> No functional changes.
> 
> 
> [...]

Applied, thanks!

[1/1] loop: Remove struct loop_func_table
      commit: 3aab938c93ca952ebc96c85b753f2592de919369

Best regards,
-- 
Jens Axboe



