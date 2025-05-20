Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A515E8B;
	Tue, 20 May 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725371; cv=none; b=oml/f93yc8rkjKVieE7yL4stEoDgwIgnPTJgqrFjPFJtVLBCiarkGOd62d1lORf1P8WofJfyrRhaBMWfpSh9Zewn9kZyMVHBwuK6G8W8qDU2EcZ5YlaccsA2XCDgZEbUJuZXZV8SVqncIesO/N6+nd/JliKoKgh+OYcUXbS9/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725371; c=relaxed/simple;
	bh=64nSeznQ/80kI+TqqvrHQheS4AVHuJSHiUdaas+H0vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I96OM57U7npA2eqOFahsRaILiSCSHfnAQm5yFhqmGolauqSTN5jr7DCoCLb9Vv4IFagNXO9d3Ja0IYS9CST/nwzJiaLsTYsptu+5AyHlJBoQfRuoKyPYRPH3rXVNvmJgyoCWP/HGN1eQWUj8FJQbzrU2pCcj3a079weyZ1x8xmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvTl/w2w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvTl/w2w"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acbb85ce788so1073315566b.3;
        Tue, 20 May 2025 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747725368; x=1748330168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDIRhWdKVMpUu59ujm96cXSr76HpSQ4ZrAeN1Auu11g=;
        b=gvTl/w2wdlDybYmfvU13lSRNZPeyAb4DEtZLlfvC5/TX6IH33Z8lwpVEE1XqmLV+wC
         6aRxgYl9/YRbGCBnrmnG7MOCYORpNO38iPlYQkmwaWIGqEyMKYSw5Fef+0A6/ZE309SD
         iC1K3s5IA7T1+k58nulHjJJ1QYhKwIknEFwQTMMY6mDELYrgicR0P9RxnlJ0ncsEqt2V
         VPwvK7Kzcq1QBYN3OWngaYD/XE1WMjHvJ9TYw03WIaIfSCAXZl3Xlr8zdGri/Kg+tAId
         XcFiWj6tRALV6sBMbKAue3hF2DkbMRXKDXi2jf9zrGVDtKMgiti3QQHz2sknCS5o8iy5
         /wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747725368; x=1748330168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDIRhWdKVMpUu59ujm96cXSr76HpSQ4ZrAeN1Auu11g=;
        b=XtFA/wau7J8IpmeVBpi6LwZGLbAN1FKFGJrKihQFpAKuKXCajzZa19cG0nmQy2dRdO
         AbhohQX1uHlCQfTgiumhXyONfYz9uBDmvoe4d7maUnAnVfRfXzF3/Sw4QUTK79+JWOdU
         /Mzlj3qKPh4aZ/uEihPc0qU9eLGgfxquaZi6EjP+9U/wacHImZrDsVd2DnOUxfp34i5x
         b94g61k4v0YQqny8WCVuKFVMG52xxBlcKTTkOFaup/zJ+G6b39FqY6AkA0D3rMc5Omyf
         auiULMDU2PFuFBXIuoFa7bGIP89LH8XIFnAdNgzQhaV4FS8aAWTE45ClolCJwT1BxVc6
         xtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxYdfQX937rzd2MSiNrNia8Nk56CHdxjJo78KanXcNXIW+py7HB0dk8/OJ8DZvrOPk/8SoCCtdTtoZldYo@vger.kernel.org, AJvYcCWyuKUzHeHlbWp+sx4cmy6k1l7vpzOjbohx0HkcFFlwmWXXApm58aZ5KDrMW26wqP1w8SUoTCGfLyiMmg==@vger.kernel.org, AJvYcCXosmAn/VMG4GtjiUmBH759mdzNiLO7HelDcGkZu3k2x1Zk4+udCPIX/owyZ+zIaODLr11xVicW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxats+M+64qKMfS/IqrE9JjdPITo/ZkwmzKJezQ2OE0p8Pm+7y3
	JuiBME/MyDeMqTvR0SwbPgbfOYS3e++vw5P8YRvYk+Hsq0CsqWXBV+YfjPGspA/x
X-Gm-Gg: ASbGncsPCC6lvjpB8YyR6TYSHr6Q6O0+tviSVdKIb6dl7s6/1b7Ad5N/yEq3JkXvYEP
	e1BkZPvFlF2FW49rTEMBz/1bxVSJ3MP+a+WoH5cDUdhttO/wsOO0mRsueRPhiTHAzkSwqfy635c
	+NvqphNrG0Pheyp5o/zaAW5eMn6HRSNyYDIitXS3sa6izso/YRVzXYIdzZBeQDxQJeN7V/eFzcP
	O1zbTCfvtdRsD9CaBVqjzlKRXMj5KTpXXQwJQWTL5hoaIXspcQD8WIo87qe092JxEPJfGvBxC7X
	R1SZu3wKigNM7KURnYAw/qeYTSvLEOLHo2/jCM0R8GkJJoiErwUv6wmZ6X7a7fxh3qdLHDv69FD
	wLKE2vNHk
X-Google-Smtp-Source: AGHT+IHVOlAW6lgxwfSXJ2mOzRf4cxrSKL/D38SFAUPj/n/z1oZNclDU9+lGnv4dlctwse3NYQjUmA==
X-Received: by 2002:a17:907:1b0f:b0:ad5:5293:f236 with SMTP id a640c23a62f3a-ad55293f282mr1046955066b.3.1747725368115;
        Tue, 20 May 2025 00:16:08 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4c9e62sm685303466b.155.2025.05.20.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 00:16:06 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 7942BBE2DE0; Tue, 20 May 2025 09:16:05 +0200 (CEST)
Date: Tue, 20 May 2025 09:16:05 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Christian Hesse <list@eworm.de>
Cc: Roland Clobus <rclobus@rclobus.nl>, Lizhi Xu <lizhi.xu@windriver.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	1106070@bugs.debian.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [6.12.y regression] loosetup: failed to set up loop device:
 Invalid argument after 184b147b9f7f ("loop: Add sanity check for
 read/write_iter")
Message-ID: <aCwsNSEoxfs4DOvi@eldamar.lan>
References: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
 <aCwZy6leWNvr7EMd@eldamar.lan>
 <20250520083438.295e415a@leda.eworm.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520083438.295e415a@leda.eworm.net>

H Christian,

On Tue, May 20, 2025 at 08:34:38AM +0200, Christian Hesse wrote:
> Salvatore Bonaccorso <carnil@debian.org> on Tue, 2025/05/20 07:57:
> > In Debian Roland Clobus reported a regression with setting up loop
> > devices from a backing squashfs file lying on read-only mounted target
> > directory from a iso.
> > 
> > The original report is at:
> > https://bugs.debian.org/1106070
> 
> We are suffering the same for Arch Linux. Already reported here:
> 
> https://lore.kernel.org/all/20250519175640.2fcac001@leda.eworm.net/

Sorry missed that one! Ack, so let's continue in that thread (worth
looping in the regressions list though?)

Regards,
Salvatore
