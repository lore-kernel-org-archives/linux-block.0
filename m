Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D5175A73
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219493; cv=none; b=GHZ1BYS5YXbC7gtwYNC6o8Luv6meD/NjERafymHUHpJocyuGbk0pbpbKDOvbxbLRdkGSsWZmlT3+IjvBmtAmgDdyRRjOL3sBrtgfBh15aWnobDRKQDCyv6jvtIvioXYq9HcisTQ2CDqgovaZFEKDMoxMDEIJjHwzZ6KdFBABku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219493; c=relaxed/simple;
	bh=X3liOk9yZgJezFY9fDr3liAfHJRTIRoXelVGQ7Fa1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjqgpPse1CFsNSkg5tiiV1Rs+7ov9waDNqk6mSDRBAjxMh4G8bFyXlAgymZ6E+Jx4mF+ZI8aSu/kxGQgXiWe6d+RqBchR5yK4Nnrygrz1omCKl9orTHGIf3Qixce4dLFux2kO4mBhi4i9y5W6Ue7k4/V5uwMWrYB9brY9uITr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Egcp9fez; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Egcp9fez"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3598df39444so6682443a91.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773219490; x=1773824290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ9YPOX9t2sxcFSpbADFI8bYkVlP59vwzwTpmleR2NY=;
        b=Egcp9fezDM+JFYM65++X5XLFOUPYewiuNcG/Dbdp4+P45hCwsyYP+aRC9PzQBCFv1p
         S0WVNdibFHi6w65dzQvluCK+oMgV9mSqITnTktJn9OEZhKPGytqKyJOcQjvAn+X1i+Td
         tE2rARg3c7dCiUTHyCRS9HYP1PhYl/u8oGgPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219490; x=1773824290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ9YPOX9t2sxcFSpbADFI8bYkVlP59vwzwTpmleR2NY=;
        b=xD4csTiKOpfR08prTSXgPu/2rdqsVaSNZ0H4F147E6/J4BNTMAPhx69rJnSrPWkj4S
         wjDLvtQ2ZDQh1KZhDJQl3klzP+qQZH2xChDEVFjALd5qAWNdncC8r8f3Qgnea3CjR1NZ
         cE86SdoDDYAWFmlszrZUFfNsMY0FQAtftTyAC8Gyf8m7jgL0T1kt4hCLmRqlNyjw+OvU
         3aKdBMr3vsr9y4SnTT3+jtmmM+YbCv4SDfRT5gc1YT1WCx+RmlS1tf1yBtAx4Ycd/Lam
         hkgVdaBKpURk2WiYvxJT7UHxrikJgYfuLj3ufZVfFw/Ocs+CcWkzR7Ob/XervYtHl4Z5
         TGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUDYzjONy5ePAN5gMh8n2GPAPbCqc1UDBMnWbe1uOJ2MLpIMBW8NQf8d2mC5Peuu8uLtxgYlOdqwROHBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPY95GXbDaHpTNhLNCmKFqqA2btSrcgmtakJAEdvrTdf+iZAP
	EIu9WPzpRfH1CYALr2K12Bovw2F7wAdCy5MQmGmP/8jXlj/dJILQGX2Ga4vUQQQ61A==
X-Gm-Gg: ATEYQzwxdaNRyvRRuyMWJvgEjjSNpOKeivSTdayj/JNhFnu6Ilaaj+v2E+l5hj+A1Ov
	sYx0NqDjeEBmOVVMQ5gd8tyV/LpXdbtIxutx17FZ69UwIPY2N/yVrurk5Wkm6MDrmq6EN4XMP5S
	GxN3g5MW+wWTkaRY4xI2cvLjmS42cE3Q/ysLkm6oNNkjpnUHjiM89wauL8KFflOi5EuHlgB+xrA
	KefohVIxoDNV1qfIMxl+maA0fdNJF2M580u7intFc5Qsp8rk0t0pNgNU32/DHe8x+dYGLpiDM55
	ayrYOekZXN5apsTCEkIHhVhTEcmuhimJGwnF3gGVSdVIuzlYyq1X/fNcLebyEUNUUbNgTfBwVZH
	bZQVLjhHo+/0Ulnah7IXoJ3tEhPeD3MC1/0EU4fyDDLHmgf9v2aBIQvYnwPu7qG0kWn+JMQ6x8J
	q59E8KOoB23sqetNIMMtIy5GdEO8K1lEsKJL+PGvDdpj6JwT3eK9UUDq7xGTDFsvo=
X-Received: by 2002:a17:90b:3506:b0:359:962b:b032 with SMTP id 98e67ed59e1d1-35a01389138mr1643288a91.35.1773219490333;
        Wed, 11 Mar 2026 01:58:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f01004f7sm5205758a91.0.2026.03.11.01.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:58:09 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:58:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jihan LIN <linjh22s@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH RFC v2 3/5] zram: Introduce zcomp-managed streams
Message-ID: <abEtQ6ULdxhBdkkG@google.com>
References: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
 <20260309-b4_zcomp_stream-v2-3-7148622326eb@gmail.com>
 <aa9tz-EIh7kOF3RM@google.com>
 <CALmCz4rfM3graGfnrMjXwg+5W5gUrq2g0ycPwRbkcRKsL8woyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmCz4rfM3graGfnrMjXwg+5W5gUrq2g0ycPwRbkcRKsL8woyw@mail.gmail.com>

Hi,

On (26/03/10 21:31), Jihan LIN wrote:
> Yes, the acomp crypto API can cover my user case. However, per-cpu
> streams can still limit concurrency to num_online_cpus() even with acomp
> as in mm/zswap.c. And simply replacing them with a global idle stream
> list leads to a significant lock contention regression, as tested by
> Kairui[1].
> 
> Would it make sense to try using per-CPU stream first and fallback to a
> global idle stream pool only when the per-cpu stream is busy? Happy to
> help with the migration effort.

That's a good and difficult question.  I was not planning on
re-introducing an idle list, wanted to keep things per-CPU,
the way they currently are.  Hmm but our per-CPU model doesn't
fit at all.  I don't have any good ideas now.
