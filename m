Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3024338F
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690117; cv=none; b=Pm8XyISYB6IDy5Pykp/dgjuKUf3txG/dPdN2QUTogHKvhZg+WsHeRo8rSyyTNrdU0kbM052VdeiUvKyfHAsA6WEoGDq/iMOLdrkmVBuxYudjkZdegQkb+9TVgAowvghh+S8u3dzifCS1Im0Ec7jvip3IEnayqiyjXIDsSfQIZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690117; c=relaxed/simple;
	bh=+qp1klWv+x4IOOwqhFckbtaaE8dkPlFlSIKi9XLSLeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBmNKYGgljBgVtTHVaxSbxROzyXQ1EeS0hOKyl6uyZF8cq9zHEi2Qtx0k8l3oNRGpLfb2d+zmZ/Zb1oGGaJgBmRzwFOuj6ZE3bB76Qns9xmgk183aYQSm2oYkowO+YeF/XljLp5fX5+v/2y588P9aDXBgkvv5iu+smJtm1Nj3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nH9ToF73; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nH9ToF73"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1383083b3a.1
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763690115; x=1764294915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cRcbbQEo02KH4rKMcz4LZIg4tF9mtZw5O21Ocz75yQ=;
        b=nH9ToF73+6jG6kcuypVwtXS15OchbZFgH2oWd81SQq1bHBqeY7Q2OpvLiCqYomsPQs
         vKY+sEfYtbzwDQAhCvMozADJYGOFuHV7gxZUExLnmOHyqlJi1ZTurme25oxB8NxgOcFF
         WmLcz4mSHeIzE/9MNEiH7v43eIgNEHK0cq0kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763690115; x=1764294915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cRcbbQEo02KH4rKMcz4LZIg4tF9mtZw5O21Ocz75yQ=;
        b=s9IH8+3AQoWWIDEpSddkj2CiXsF4pGYIlFVXf6tjQYDEfHnJ+F2gTiF+UbubrZbDe3
         iO9tb/SLzlrfXbSXBnsSKGVFORV+bA8ans9ITfuXegSTGmlbvk6lC8Ktz/T5sZRTD9jD
         ePkaXqawir5wiJbrxhS1DpbhoyPD85Moz/po+B0BBBgZtNGcC1ioRhADY9RpPxnkZ8EB
         B186cdbTZJQmrNoC0xjRpVcGDvt3J2nievKI5jMO6k6e4A1287hP+1SPdo7HcSiPm3lZ
         wXb77N+xMeeBImXw2JHg85npQidyaWmRPyUhtrJOU7mZeySKktNe22SbS14K52+OgCnz
         bOwA==
X-Forwarded-Encrypted: i=1; AJvYcCUsl5y84czLdmRWcukahGQhhHlEq+9wAvwk9EIX7tTs2F5SoQBYgE74pmnt7AfBYDjA8WUGl8lbyAvjCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSApmap6QlPp5yNsnpVkSwZPjQmcgFWPbeUnQx8vC1FVhrtrZ
	GpBChRXoczqa2+cribOxsZURVA9uhsRMO81t9i0pCFHMWX6HYEpQCHWpDnTiPBqngQ==
X-Gm-Gg: ASbGnctk119hSEeFDychH+HTX6rH7kRuqCSyOycSpPnrnWhPMN1bClXQ7x+Iu8GvkqA
	RpSjXQcI565F8RB4SpYXsP+6/eVzCVunEkxtVv6t2LvypDssjByItx/cH7moC7TwSnBSWqtXyKQ
	MpJXmLqmeEw0lnNiaZhqfAX9Nf5NkslYYNr2Eoi9pcO/3O+dl1v8LR9tRhwVnItmgc+059VRmF/
	zbM/pIlH0OS9gMN/aGdXiSX/4O2YZrmv+bxobkBD1ZPs81KtVc00X6lLg6RS2ERl15VT/Q0X+XI
	E4oRuiMFzBcst/od8Lb8zS9joZRSJNT+fnlIFjh7qp+iGJyVmhenFAYOJ3mTEk1MkvTu58VsaE0
	aQYroLX4f1M9whF65QQ6fB/Q6Whv6djf4mDWhDZZZqBZmdUjOlqunkJW1ZHBIFYSBd/2Ej8OP0p
	XEnqZ2rFbjVMWqD+U=
X-Google-Smtp-Source: AGHT+IEvvkY/BeYS5a/KZXMhWOVlpWXxEj6JWJCOYUYmnHxLc5zFggPXEr/viHMNnTU+HaR8K5bXkg==
X-Received: by 2002:a05:6a20:5483:b0:343:6f53:e97 with SMTP id adf61e73a8af0-36150f2e004mr354483637.48.1763690115547;
        Thu, 20 Nov 2025 17:55:15 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed37ab3fsm4187857b3a.22.2025.11.20.17.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 17:55:15 -0800 (PST)
Date: Fri, 21 Nov 2025 10:55:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCHv4 2/6] zram: add writeback batch size device attr
Message-ID: <birguuoazoxjeijvnnxjlpv2avd5cgptf4cylmdaj2a2sdhhem@svegzn74fjr7>
References: <20251118073000.1928107-1-senozhatsky@chromium.org>
 <20251118073000.1928107-3-senozhatsky@chromium.org>
 <20251120171738.84516c55e4aaeea0bf3b7725@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120171738.84516c55e4aaeea0bf3b7725@linux-foundation.org>

On (25/11/20 17:17), Andrew Morton wrote:
> > +static ssize_t writeback_batch_size_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf, size_t len)
> > +{
> > +	struct zram *zram = dev_to_zram(dev);
> > +	u32 val;
> > +	ssize_t ret = -EINVAL;
> > +
> > +	if (kstrtouint(buf, 10, &val))
> > +		return ret;
> > +
> > +	if (!val)
> > +		val = 1;
> > +
> > +	down_read(&zram->init_lock);
> 
> down_write()?

Indeed.  Thanks!
