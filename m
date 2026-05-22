Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52684400DFA
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458773; cv=none; b=mhDrr8pWZWzPSZ7D9MB9wxkajCfnPsHoKN/1VEi/cSiIfIu69DN/CWnC7OWJNltRs5wn+xdBhV6ogFoH+SiR/9HTan67IWBq0Zlloj6aE/SBQZKK4o3wZndVvyRZ1OHzSTB7mngI/mIhrBM0bqGisCXQ3HFH2VYiGXJrspxC5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458773; c=relaxed/simple;
	bh=IcnTnFuI0vWkNCUnuWmsEET5RUKwSbkhpdD5I7XOIeI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tLzSs6F5Oj74kHjupmd2UYJkGGifcq1ql1hWFAJT7LwEjvnimrSm7giRYJY9V6wtfAlQkufy8oovJJbpIVqaCRhNhb3msvB/yftJDIIy21lL23Y5uuvmBJqDVVPAup8aO4P3ouXXzYT9Tiy0yY4XsMCcSSwL7sJoktmpwYLJ3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MsUwDjDX; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MsUwDjDX"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-47c7b282d73so4789985b6e.3
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779458767; x=1780063567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14D7crjoMCq1ue5AFib1jrESDXBq9dwx0uxUfeRJWtQ=;
        b=MsUwDjDX3xA55uiLCC3vVkXyR0/5vkWO8gKDNBSSXKjXXufpJonxCIdZcZXlHc4fFt
         1J8eX6UDXtMoDV6mCGzXjDyWLK36pER/UxRMf/ihBw3oFbmtgC2WEYi1C8S0jwk1wOL4
         ZSi71N5ILYs1tSpvJM2kmBEvsq9oKJ058DxtgbJcKvZiZQOyVjM9RT6aIrn3XmcY3FeL
         bqWKU3NQbh/LQMyJ/Wp4sbk3Ae3KaKPKXLBmf3f/9DEYsGq/w+9O9DVnNloShDUpSj6n
         qCS5PSgsTgTXaI+sU1ynW/1jqVJoI879hQLKOsFN2ybRYj+CRsCAlp4IKUbv8Rxedr0C
         0Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458767; x=1780063567;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14D7crjoMCq1ue5AFib1jrESDXBq9dwx0uxUfeRJWtQ=;
        b=frFpM8yQHYYIuxoMOVYN7i4wy0qUWhAxO6ltT90KeBPAiUJDZY5NhYwE5am6QF7XQ5
         68rN0V2gSN4+jlQNBvXYAnZruDrVirdpjqxOq5XCAaXyJXU1y/Dodc/58Rq3PRyAYnBy
         cxe2rWcq41/MP+9Up+XuzF5zuzfgJ6mtki7Ec0OUsmTyewvycYRK7Ly+/8u+kBB9jAVU
         44efpi/dRNh+dHrv//dwuVQ6aKtVGD+tk5FQze6xTJwbcwFeU6JrGRuOvi4jRe8qlxJT
         suOzGkokHD/UDyWUJtgUjzFIrAQUEanhnyqEZel/BvwipnNkpSWivRaDxW6iykmrdves
         9pQQ==
X-Gm-Message-State: AOJu0YxNIjuxOReWfoCb+deF/ZeyJRgLqHIkoSLgOz6IHzb70V4KzHYe
	tOl2dKxr6radsOUlZjeI4ZbNVikZT2QrmV+XRdnYypvQ9R0qlRmdvjoGFMxu9FxE42mDXoE3h6N
	HTnv8
X-Gm-Gg: Acq92OGez8ygPQc9DFBY8pbg2e/IJ7Gna0lQiYL96xj/Zqcvl1ZDjnTAFb0sNAL/+rs
	6sFnO8+aRcoLgQUoRJv+ZI9bHfZ/l+5pAGZxEzM5LApjDf2Usun3BH9GAot2FRj2eCPkdGOxDM6
	ic4GYZGnIU0zMAb4JyCsHS0uSL5TeppJG2qoKFSmKkDMUwWC5fBmlizmhRfNcOgVtB/mABRvD2A
	fbtMA3Wd3Qy69ySnkauJEMIBa6kSsDKrqBNK7VzcdHegtp0eIEZxA1gy60yVh3YIW0TMOf7c68Z
	jBYYlrJ/dxk9hDEtavsuRfirsp6CR+PzNUWl5OyZxNTa8y51SXg+bLI2uEz7+5XseYf7BQEIywW
	hwp4pKadmqdowVuqlVHcm2k7enhOzd9rcmubIFJ3zEDnvlL0FV90lJZIW1ADqT0KU4L7TnepDYM
	TV4y8Q3PFfUqv5laXiByO/nNJPn/dlRAySqOJD1y5Hb30+BNh4L1bBxjhNvNBvkzUXWhT31Zsa3
	kE=
X-Received: by 2002:a05:6808:c1cb:b0:46a:cb96:d2b7 with SMTP id 5614622812f47-4854a424f34mr2199081b6e.35.1779458766650;
        Fri, 22 May 2026 07:06:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4855476ab77sm554972b6e.17.2026.05.22.07.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:06:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260513211846.1956810-1-csander@purestorage.com>
References: <20260513211846.1956810-1-csander@purestorage.com>
Subject: Re: [PATCH 7.2 0/2] ublk: optimize ublk_rq_has_data()
Message-Id: <177945876516.102352.1619443189946586472.b4-ty@b4>
Date: Fri, 22 May 2026 08:06:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 15:18:44 -0600, Caleb Sander Mateos wrote:
> ublk_rq_has_data() currently uses bio_has_data(), which involves 2
> indirections and several branches. Introduce a blk_rq_has_data()
> analogue for struct request and use it instead to save an indirection
> and NULL check.
> 
> Caleb Sander Mateos (2):
>   blk-mq: introduce blk_rq_has_data()
>   ublk: optimize ublk_rq_has_data()
> 
> [...]

Applied, thanks!

[1/2] blk-mq: introduce blk_rq_has_data()
      commit: 999722b34441b4ab65b7ca7fb16dd4b62fc3c354
[2/2] ublk: optimize ublk_rq_has_data()
      commit: 5995e751d2612cd8254cdf9c1155a96bbbb2d509

Best regards,
-- 
Jens Axboe



