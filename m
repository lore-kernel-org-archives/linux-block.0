Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8A1448C9
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403549; cv=none; b=prYQEIFW4H9Cora2aTiJnirkzOVLPdderWCT4EHHIVbmB3YeqgGcjPLXIENxiVSAoI7QHeFiGU2SYrJGBAJ6EBwks5mhfOidypq2RkGVfgvQM1FKuRDCz3f+CqKyGV3m3TLxGMngVSJqrT7dI3W1+knS5SL15FIXB+5addTZK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403549; c=relaxed/simple;
	bh=F+8BO+nL9tUeStijZ7/zk/oJIQiMAzjjqxNdJwAMyPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J49g7blaDAvBYGigxXLT9RgvZk3+SzB4XVOK0c6jHgeWhOSpix12nZi32MAtTsGDWxKn+qe0nLqcbWHDqg1bjZTVWT/PmAPaSlFM2rrS8ZbgWAsGvISyD253VkZRStR9cu5bHM8ljeW4192wbfxQuaw42vNmNOPx1y2SEK/Nv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vb1ByTTP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vb1ByTTP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b22b785aaso36011b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403546; x=1722008346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y45Z0aWbIeprdMq8sDDAIFPdliCDk9r0AJWqhvLPYw=;
        b=vb1ByTTPLxKjHfH8XpgmL11fKEqFYvkc127ugyWhdLdK0VPruuRsvPvtBV09QpkweU
         cqEJaSWBnQQjvkQetqHTAB7tf4jYtI0lA3IjWkq+bCuVFYYzS3GRxKMmIeHHDqqJ35km
         nV4y++FZFo58B043HWPkOnSDso2TKPZYExicmEx18Lrl09uhLA5S1ngnwqD4FmDzuAgp
         KlifUS9miesxVMawuGAShzgszHZcAIKC1GPYyzdYEwTO5PXTRxZWOEs1cfX+k7kWuktl
         NF7qrzR2sEifkgXaO8AcyazPZ1S0J0XHArp7VPdrO5yrs5tSoYYPa4RFGySegRpQ7iqs
         cmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403546; x=1722008346;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y45Z0aWbIeprdMq8sDDAIFPdliCDk9r0AJWqhvLPYw=;
        b=YKvIUvsSbJk7vJk9OYWmmjgY0Qz0vvhwtSVHycpUrodA5zCvZJazpWLcq6JMZFlTnH
         //BNuLJf2U3ACxB1zR4pbIvfru2ceQzloBzlKRkOphoHKc9xAg2LB07WS6kqEH+67ESY
         z8Pz2h8+PurgyzLGhsKjB905pXAuqPRbg0MGF8swdcxicEMGrQXEj6+9HOk3Ghgsv619
         ByU5YW3IElaYgiSMQviJWnWBFk6s43gW15AJ03MfMu5dPLq3dty/0q8o+YWwmJDoQNiG
         BjUi+8nhM0CO06c2SPIZDI+LX4vglKVvv5V4gYVdj9MzrMitBP/WeuEgL+ZDm4PgzRzH
         KCGg==
X-Gm-Message-State: AOJu0YyG8BY1OoRF2SkbJTIq0JXYFER0fFnCBqEyI3hkKtRxTjogxQr7
	KV8Yso6mlhkynj7Wne00nzjHL+OKa44WuMVsbwob/BPlf4wNw3Zvv9W4zfSPdAg=
X-Google-Smtp-Source: AGHT+IEjRqRmzclUos+dFxnPhen++ZHfL43eH/uNmW18o7F1OMwvwdKgrvgILJUX7PonpmivtolN8g==
X-Received: by 2002:a05:6a21:6e4b:b0:1c3:b106:d293 with SMTP id adf61e73a8af0-1c42287e800mr274401637.3.1721403545947;
        Fri, 19 Jul 2024 08:39:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77353847sm2969930a91.33.2024.07.19.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:39:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hexue <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240718070817.1031494-1-xue01.he@samsung.com>
References: <CGME20240718070823epcas5p14445a1ab8f8bf8a496405a1424ea067f@epcas5p1.samsung.com>
 <20240718070817.1031494-1-xue01.he@samsung.com>
Subject: Re: [PATCH v3] block: Avoid polling configuration errors
Message-Id: <172140354394.11595.16629364160282327340.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:39:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 18 Jul 2024 15:08:17 +0800, hexue wrote:
> This patch add a poll queue check, aims to help users to use poll tolls
> accurately.
> 
> If users do polled IO but device doesn't have poll queues, they will get
> wrong perfromance data and waste CPU resources. So here adding a poll queue
> check, if users do this misconfiguration, it will return users that device
> does not support this operation, to help users adjust their configuration
> promptly.
> --
> changes from v2:
> - move check into block layer
> - return -EOPNOTSUPP instead of print a warning in io_uring
> v2: https://lore.kernel.org/io-uring/20240711082430.609597-1-xue01.he@samsung.com/T/#u
> 
> [...]

Applied, thanks!

[1/1] block: Avoid polling configuration errors
      commit: 73e59d3eeca4feaf0814a077df8ec5edc53ccf77

Best regards,
-- 
Jens Axboe



