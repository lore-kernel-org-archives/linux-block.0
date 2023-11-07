Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7A31590
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ue1+wLQ2"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E03111A
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 07:15:37 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-671188b2d44so13735456d6.0
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699370136; x=1699974936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg4S+iVhN0rUMVVADxU0vILU9b9jVJPj9okuexhI30g=;
        b=ue1+wLQ2GbPHyHRQinwZxkazEkLaj8CFlWrc0G/M19QVkSVDhAYprNB9gv6jktR20Z
         ShAShNLjp6U0JYTa+oOuMCH1ghh70b7Yc1d/wK3r+wyKjSVcpixqwmCCj9R81BDELWr5
         Gl/Y8NTdUfcy42T7Yl/e4gKHKhQNbWTgIYYTHxLlJ+GIB5TMB/8jCq3F38/mz2LU2hYG
         ed5SPhbsqJt3JiTtqCEAKn3kDR6kkBlNoCo68ISDV1Io01x4WuKvdvCXNEE2trGNoIzp
         kUlTKGEtJoqCEYQEbNDQg8QFXbaCBnHRLspUQJtHcRfuhkLEEkUxj0n0P9oImrEMNWUd
         uwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370136; x=1699974936;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg4S+iVhN0rUMVVADxU0vILU9b9jVJPj9okuexhI30g=;
        b=V6JZc3otUg1QgI15IqWRXZXyQ+Oe4YP+2bQjTK0G70NOCH7+Cdmu3DSXJjA9h1v6lg
         EF8O90ia1lfVkuAfbv6nRmtufg2Fl9cKQXEkfYvbftwYvLFOY8bHM7H49xX6z4Sf2IG3
         Cmun4eipGY+wIyqJ57BQ3vBfElLp68ysfRSFy4Ra/XBADagSdxqNHV6kc89GHw7nJ2Tj
         Cdp/TOcXLuu9LZbfPrw8C58xE5xtTfukgsvQV0aQ0Z3gFlg4wPDAfyWR3DmxRNrj6GTx
         XiJcxLZBuw/wFm0Pal3JCyVh9U7/FFFZ5mpYlFL3qHXkoyQgL03uO8o5a+Tj1FF5rZxb
         m9zg==
X-Gm-Message-State: AOJu0YwTb6QLF+lbu1pPo75VQ0mpAMTMdw86gfiCmzXgXb6fSuHyCIBL
	wWp83gl71zzgc5xEibe791YEuw==
X-Google-Smtp-Source: AGHT+IHDuUKEORbj6lEnJjXGuGurwm6i9VyeFSTXBHFrMNOF5jjb4rAbhSi5DROMGeR+2/gsXs8Zyw==
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id kr24-20020a0562142b9800b0065d048625c6mr33120510qvb.3.1699370135987;
        Tue, 07 Nov 2023 07:15:35 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c091:400::5:f968])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b007759a81d88esm4215667qkf.50.2023.11.07.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:15:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
References: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-core: use pr_warn_ratelimited() in bio_check_ro()
Message-Id: <169937013415.545643.10559344267374227650.b4-ty@kernel.dk>
Date: Tue, 07 Nov 2023 08:15:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Tue, 07 Nov 2023 19:12:47 +0800, Yu Kuai wrote:
> If one of the underlying disks of raid or dm is set to read-only, then
> each io will generate new log, which will cause message storm. This
> environment is indeed problematic, however we can't make sure our
> naive custormer won't do this, hence use pr_warn_ratelimited() to
> prevent message storm in this case.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-core: use pr_warn_ratelimited() in bio_check_ro()
      commit: 1b0a151c10a6d823f033023b9fdd9af72a89591b

Best regards,
-- 
Jens Axboe



