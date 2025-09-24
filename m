Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7DD531
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714524; cv=none; b=KK97gKKGI8P8ocokwgRmURvr3OSo4IBQBOrIBixN5TQQFTtjpcAfK/7+neBfetYmvVccn1PwvxBvVFaaL8Z4qJnGZA7sPaIEmj4E3y1ML29IMyPsqv8hLtnVl5XR7Q51S3MIVkQld4aFH1cQOzaMHbPjGbvcTwhtbFpKXKUjq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714524; c=relaxed/simple;
	bh=8wa1ZLHn+cg8S8nHQAlXq2ZdFV4bDju8o007GcFQZ8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OH+abDwj5ciVohLMs3OR7BnD5EDG1/mGfQnryB0nIu1Q0I99kLSzjF48dY+ewl5j5NYHPkSf1boBK/OzIjFWlmbMdE8aLT60w40YNQLIcjNDCE72NejGZN9laG+WkwMy5WEv7VYAPLJpyaRT7RaG/PD6hoqVLrHK6U+7WQwHBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=20M06Zfq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="20M06Zfq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e1bc8ffa1so22223905e9.0
        for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758714516; x=1759319316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL3pj95EhDFRWDVYUB7ZgnLiAqsYtgD7zX9Xu/MZ1Ag=;
        b=20M06ZfqgyBotXhZ6peh6krIclXZM+lwqOSZMMIqse4Z+jGqxOmURdUf23+vuHYSF6
         FHIF6GMXOrktUf1oRDC+fC4B54o2NQnn/CJ6az1n7SuyurgM3N82xv4a1qnTQF1H6QrE
         D0YfRnC0AmAanJXSK/jHnlHaRRpTUynaWlSfGi89PTEENzdnBsZSYicQlrSW65jdra8u
         g13MF1Ol5yWHPAeHZuQp+tE5LBSW3A5Rf6EzNVg7CwOMKnaiaB11BVOSW26bniS3J4fv
         XeEqLc4y0iRGs/V1o3JlEcZ9x4py8PgcZoFQ/yJoM1ms1qgX47cja4a4JV2hk5J7U+5G
         +QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714516; x=1759319316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL3pj95EhDFRWDVYUB7ZgnLiAqsYtgD7zX9Xu/MZ1Ag=;
        b=gFmwheqyDxoXGPryWT6Zucz/GCPSG9Rjf/fwNp1brhQhd9cKK0MzC2nW91nwHOAEzu
         EE05IcpobMxl874h7vieYf3+Yq7J3USE70G8p6caRE67t/2llfKINx4qNRGphooqivpJ
         1eSFcb3D/dGa5ShiKqIjwmaIJcC1+LjI7TcNuv/oYCZmrhJr2DqgIiS8KfpWsUgJLiGH
         0G2icm0/n6GMtHXpY8XFMSs7xFvbduOySaMjDwP5wnWjnWRHWflpHEe85iKMT+RkPK4K
         mkzphRqecQB7Uwcf9mZMNRE+QKU6Eai7MIMk80xNr6HUDLehRY2rilWsfZ9nfy39oHdJ
         bCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCURcRqsgRVJ5taLvmIjdjmiocdZ8k2lj8ylvLgTdjQDuHC3hmtwQqbVepchvDmErZdxZrtQAdD8Yky6pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIYndTsVOdoOcZrjtwRWPoLfjV5j4MjmO/JensFza05NsCgls2
	dbCWNnMBAqHH3CrLn9evGHThwGxL7LMzbv0WLnJ7azDrJqBTZjfqnRwewz/PUHuQmDc=
X-Gm-Gg: ASbGncu8nl6vzF/ujbszdfSYZ9pwYMJ+I2Ng0tdFzGOg6V0UqeioaBBRhscv1GffNCk
	Iv1JAYDEoKgqWzlKlVv9HHXt1xQoKwo+3v+PKXtf8wf24aH2f5RxDAI5swNzwlqzHhmenAtzygA
	OeJYnpQOmyk/ojWNRVYIC2nfiQKz3K4jffwhzQtIHy1fj93ET1J1bpFkP8YUqecFx8yg1INcuQV
	TjlyW2V8jU7YdCMid/k0VP43oihisCxW+mqJwK3v9uRTEAxGo5/Nqh4gwFmj4q0a+v/laknM3TJ
	iK/gnWbx+rb51jVV6sQk+UZDghQHh5Pwh0vjdlGC1OtWeicXpuCuKGZqotxBsIn8YMdpBeRXdG/
	oE77pKimVJlrwlK4KXA==
X-Google-Smtp-Source: AGHT+IEltzN+Phzm/vgIDV/CDKiL0LHpsqh9NTpeatvcZoFTuaa8yQ5OZWw1bFDTJZAr7bLrkq2aNA==
X-Received: by 2002:a05:600c:4454:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-46e1dabfdb7mr67404585e9.31.1758714516165;
        Wed, 24 Sep 2025 04:48:36 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm28162185e9.11.2025.09.24.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:48:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com, johnny.chenyi@huawei.com
In-Reply-To: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
Subject: Re: (subset) [PATCH for-6.18/block 0/2] blk-cgroup: fix possible
 deadlock
Message-Id: <175871451525.316144.5136709409891330252.b4-ty@kernel.dk>
Date: Wed, 24 Sep 2025 05:48:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 23 Sep 2025 15:55:18 +0800, Yu Kuai wrote:
> Yu Kuai (2):
>   blk-cgroup: allocate policy data with GFP_NOIO in
>     blkcg_activate_policy()
>   blk-cgroup: fix possible deadlock while configuring policy
> 
> block/blk-cgroup.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> [...]

Applied, thanks!

[2/2] blk-cgroup: fix possible deadlock while configuring policy
      commit: 5d726c4dbeeddef612e6bed27edd29733f4d13af

Best regards,
-- 
Jens Axboe



