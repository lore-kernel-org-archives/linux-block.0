Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE1155757
	for <linux-block@vger.kernel.org>; Wed, 20 Nov 2024 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072536; cv=none; b=QXABX/KJEF6fX0tKIGevq6g1AKfUpGy9ktJUl7Dh2grn3hMUsxEFPrIachDxPzixjkalc94ndo8hOahu1EvNfQ2Zz3KF6/JEl1sKDkwjgXZkjLw6kCIyMByY4VTNZZe1jGkvPrAw4v2T2YP0OIBTSUMJj4hODBk5eI10S3aqFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072536; c=relaxed/simple;
	bh=QYBilDzkSkb1abEzANyeRxgYDytG7KjEI9bskxW5MZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUtw4OgoLlFsBdi2S/GfkVvQqDounRxnfzLFHIRg7FSnmuQmE4RlViJA/SfEgi9zQGIskBv9HrmuQ9eBJTwvlKwUqhWZL5JkCPRfbJdhnLVixN6e0fUgXahC/iQ3DCmg8Bg4cgfvF9VujDQSX34XGcbtRXozwElQY8fMLp9Trak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hvi3dn/X; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hvi3dn/X"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso1346411b3a.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 19:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732072534; x=1732677334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZSva+QoTVrzF7+bpQWC+3EfbJTYWWaNpUIOffyDhLA=;
        b=Hvi3dn/XAmTNYe+8vH8ukkVnKxZT+d7BMrNIDTK4D8c7NBzlf8uu38QD5vNpd6mKql
         wBStoRmb4ecEwfHJIr8A+3k+MwmShhyELPnycSNN1vsvLo4otjzWmmYZumO5xpMLku2F
         nopBWMSjiXKqyY383d/IXcllHMqh4ktEdrZfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732072534; x=1732677334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZSva+QoTVrzF7+bpQWC+3EfbJTYWWaNpUIOffyDhLA=;
        b=g/Dkh3Wz28YLOE9FJITJ1qgwR/a2lMsqDS6ofwO3GwDVpTahgu5z3UMws43Oh7M8xx
         /CfkTtZFAk5hBTRHFah32Vy/YpPxzWgEQMQFM+MeB3FUf2rH+kpbK370nu/h/EEE1Vdx
         Gyul9rXRl/cu5zf/+52OZk3215gQ6jf0HPForRgQ7CnoRSdUw15Qr0aMh1t8maO4fjAg
         eQMi/akzPGR2a5QRsUdR8Z9rwB1wlChc2Ol9C51g9z9pqwulUep8/kTxF2REy8DEqBWo
         zm/GCkF9Q6xIRLGOOSOhZjT6thfrFnFdk9bI1jKtUCAw7tvpP6JPe/cr82fpk/gf4xnl
         unLA==
X-Forwarded-Encrypted: i=1; AJvYcCURXYw5iKgy+tNoEOhaATG/OaqLsCtwR187svfUPGVDSzn3g1veHBNflm/HrSF6ntWxk/3og2awWnMn7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEL/lSobvM2IDjuGEN6GrO9EqPv9axHOz9Oy8ljkbpfxwytRe9
	4bkWunc4cICgEs9/l5uFydOudPVhfDxWhkstwPIkRPBfFudatrw/XxHNibVIDw==
X-Google-Smtp-Source: AGHT+IFoBDOvjfjxm45eiDb4JEPWT0CGtuUdJ+ZNfMLgP5G2wdqCKEPQK923zWmyBPd4CEQnJkbjkg==
X-Received: by 2002:a17:902:fc8e:b0:212:3f13:d4d5 with SMTP id d9443c01a7336-2126c11226amr11032255ad.27.1732072534058;
        Tue, 19 Nov 2024 19:15:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21232eabc04sm37897005ad.155.2024.11.19.19.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 19:15:33 -0800 (PST)
Date: Wed, 20 Nov 2024 12:15:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
	terrelln@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v1 0/3] zram: introduce crypto-backend api
Message-ID: <20241120031529.GD2668855@google.com>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119122713.3294173-1-avromanov@salutedevices.com>

On (24/11/19 15:27), Alexey Romanov wrote:
> Since we use custom backend implementation, we remove the ability
> for users to use algorithms from crypto backend. This breaks
> backward compatibility, user doesn't necessarily use one of the
> algorithms from "custom" backends defined in zram folder.

Sorry, no, we are not adding this for a hypothetical scenario.

> For example, he can use some driver with hardware compression support.

Such as?  Pretty much all H/W compression modules (I'm aware of)
that people use with zram are out-of-tree.
