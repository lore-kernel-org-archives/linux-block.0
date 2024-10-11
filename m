Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361B1A0AE1
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666712; cv=none; b=BUZsBCu4IcvjMbm0VT6667CQlFabrMpL+efSWef9fuPTky/Mm4i59FzPcl2sC8hIwK4zgvZ5abIne2L+VWHF8IUCk0UDLmwop32bcWWuMl9xX+0FZCyGC0/EGP4qrrcfuFF2he0aYdvuVXLMRADn+1rZZ4Xkjn+ZwS93ulzl97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666712; c=relaxed/simple;
	bh=l4ybPLuzwshIo6CiUP3SYCkZBT0nRbnqGQ88b5ZHn6w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rXlu+MtnH6crrRdEBKxIzdzyYqAXd62QOy+PxrTlKeS+fLb3TJdKqGNc/GZttcIfNLIb+eK/5Sa2I3sxHIAoOiDcOpU0GYThBXCD45HbDWjyL5/wdHsSpSqYkCCoXucceeExKRQ6pPr0bEr51mcn7O3pjXUFwuaZMUANabl2rvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lTngIVMy; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lTngIVMy"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-836d2437852so71326639f.1
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728666709; x=1729271509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sek4vbxL3f/NlFo8Be6u5iyw5TmCpBli89Nh7BpIveQ=;
        b=lTngIVMyKD+4r/aC6k/y/iuvOr7tNnx0xFCCLGmprVWtnpxJEyGlNzc056QweGBWHb
         mWrLfYWosPlZvH2gbJk0UI1zpejMAU5r53vjRiLcJmSlivegunLDyoM+LWjxdhAZur1X
         Qi4sPdYfktMHaSpYOLaZ/ZaLFsrXGVeC5q3rYGuZIpGVhOYR9D+1077OwDoM+LmuzpRY
         c9C0JnzyRFNHEJr5EDIMGiMPFOpi9KPEji2pBt5NbF9h3u9zXCodJqgsUfPGE5i2OLJk
         xUYnpJ14dXt9oWsdYD3qjinqiX5dATY8RHlrVZpol5g6Hk/9vN8Z5nFe9dOo35N5rwQH
         jrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666709; x=1729271509;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sek4vbxL3f/NlFo8Be6u5iyw5TmCpBli89Nh7BpIveQ=;
        b=Q9HvklkWyI4V+2D5p48EWaRaBWma3CMJhWU1gmBcDbQD5DcB5Z7IsqjWQa9XMaNJKY
         0NTSB101oaWcj6mBLg9biVoLyAl7TlNwK/WYaSqyiFgLtrmE8pOpEf3WXNY/xtusOPBO
         ZU+aSQYUCJPxmzVic6Urqyy/tqHk8jWVg3k2cZexJv7z0h23MIlboI9fjFLMspQXPN4G
         1Vicy9pZC63qboJtbqqHHU1yiFlJml6q9MmjbhLEHH/iWpZblXSQsSZlMvHTDHL9B4wq
         0ag7Cxm2yvxOcDSWheWoJV387BJNXMILC8tnhhAVIKuDmMkboD4zNWUZRBGp6ph4oHsq
         b3MA==
X-Forwarded-Encrypted: i=1; AJvYcCU0gGmDmx6yxZQ0WP/7yjLEnIt+WpDkbAZJGjRYmaNCWDNZ4LfgCKP9lA8G+4cezEtQ3BqREMfw38dXEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuzXa6oj3ZV6IZNECEiNe0mYNQNxAXG2HdOIwS8r+Gw0j4Bsl
	nGEpVyn5tzeyJ3ssK5pL+UCz+olvKDsAFGlSZY6Dj86RCyL7bJVMRnHDDVfVt8FI/gIpIrlUTcs
	ZDS0=
X-Google-Smtp-Source: AGHT+IFuLm7s+TM3bvNQuo9LBJxVCafKSGcTPgBInu3ziFlc6P2leOeLbuC8vpArWI2WY/La7CZstQ==
X-Received: by 2002:a05:6602:6d06:b0:803:5e55:ecb2 with SMTP id ca18e2360f4ac-8378f64c49dmr450291539f.0.1728666709101;
        Fri, 11 Oct 2024 10:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada846dcsm713654173.89.2024.10.11.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:11:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, linux@treblig.org
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010204426.277535-1-linux@treblig.org>
References: <20241010204426.277535-1-linux@treblig.org>
Subject: Re: [PATCH] drbd: Remove unused conn_lowest_minor
Message-Id: <172866670811.255755.445033429638947954.b4-ty@kernel.dk>
Date: Fri, 11 Oct 2024 11:11:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Oct 2024 21:44:26 +0100, linux@treblig.org wrote:
> conn_lowest_minor() last use was removed by 2011 commit
> 69a227731a37 ("drbd: Pass a peer device to a number of fuctions")
> 
> Remove it.
> 
> 

Applied, thanks!

[1/1] drbd: Remove unused conn_lowest_minor
      commit: 1e3fc2000035ffea0b1b7ec2423706715ab2e7f6

Best regards,
-- 
Jens Axboe



