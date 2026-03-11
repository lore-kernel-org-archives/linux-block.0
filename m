Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6B32D45B
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192144; cv=none; b=roxmRr0wgCWs5Gq0fTs+WmARl1B9ZO8DmbUY90OCY8rxZXAb5T5BUQH9wY/OewZirJRnKGxQgpRUjPva2+7VfYQ2lGicLQ2obJK6qK/h971Dolj+ao97cpmoXKcw7RlfMfDP710gjZ/OxWaENPZ5R8QUIac/IkW+Fjp2/Kpq0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192144; c=relaxed/simple;
	bh=kGsy0b5KOWq5KuvAJPAe2ChW+aktGyhPr5Fvlh4msew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYyxgEHmmzOLYXLqiSCgPzGg1EIjTEl0oV8pA/z7xDnM3AAvEtIhgovt8qtH9oEO4jKth0Tgr9KWKBFJPoy23L/1dwsa8TIeIFSAlX2lVuQTSQXAl3SoGY1ULAPVrVrpU0x8qrMTxZZtOaCfYhLtD45LQqbfl0zVcJ2/Vz1b3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bI2sfZpj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bI2sfZpj"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829a27414a3so2757053b3a.3
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 18:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773192143; x=1773796943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLXe9b91umT1f2u9z3Pl/31L7d9kVUOK4uWgGsELxSs=;
        b=bI2sfZpjxLds9wsVCdqzivcI60XYSym+fd7btd7q5HHmyX8WalpaR3zh7JdqyxEtX/
         zkQIkCR8JP42u9a+U9X3J6Ms/1FXiT16YNENu6LehdCZQQT9nXFpun2hjZhSTk3kALfh
         6n47d87mh8XK8mJ3g3zvIqeZfMnt8njEToqFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192143; x=1773796943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLXe9b91umT1f2u9z3Pl/31L7d9kVUOK4uWgGsELxSs=;
        b=t5Wxar8FnvIgU9TbjY9ZExbqytlG5qE83cTNOVNasMDkKTtEt2DClbgSBUmIbkPZN9
         R0MJnkZ/OsUHGf+hjJIaYTwKlOdzOa7VjOK049IagWcr/fYsO+QrYpYVDyKQPbljoZWa
         BcTkvIqoFxtl7xetUg2FbeGNLTMgn7nEIr8lutrsw2M9vbRQWwPCoUXhA3Z1zDyjN4mg
         KR7aaa1nWB7lQ58STfg/rwMQc/TxqkibwHx+9G0h+3qMUb6hdi8vj19jn4minRL2FkLn
         C+ptag6t7WGLnxSbqpSMUV+5qw+Jx7bv4u7ITwbW9Gpo6bXnD0hy9VAQS+OiLvPaIegH
         E6gA==
X-Forwarded-Encrypted: i=1; AJvYcCXsiyqnyLfBGN1U5TDwkkpZYiO1e4hsjsamdhn4Zpg7sAlZvWD4zFEuUyZSMUcwfVvBr4IQUGlnBXbu7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2rhpNSvplE0AmP3EuJs3NJFJedy7fThGpw8h7CiOzYEgkGz/
	+029cxP6ESDC979uM8mRljSkHIztEgvwsyOJ4VE1LrXx4Nn6Cy28mzPuOX0gdQdp5w==
X-Gm-Gg: ATEYQzxgbH1tWWPNF5cZ4VJ0hl6+t/DjHjckQkyF2Eo8RKrMCOJTqoJsyjMLHKMQ+D4
	J5JsEz8HIzENQGp616FI8atH0rQONkIQO61YxqOz9u+fxrugPgAHi+sDzU+sXSzZTLI6d8j7C2n
	oiSn+xVVtoScPXMj90vS17jz/gABm9tYVu+ELdq8GlcqfcFdmkrwX9bokc2oFW0tNUdqU+Fe09a
	bOSBH5Ppnt/KYkaNe0BfS1fC749TKBiEDMQq5UpP9Ed0VvaQHx77PV2Ki5D/gZBTOOyOxiMrBvy
	ZGgW8Wn+Mso7dW/0TQPbuCnhbSNSYMG10pYAT1QJBrkGwAbFHRORSAZ68WOd+t5oEywFnw2kzdW
	mVSJFVacxJeYm1KsiHxv1NJqnmPD6DaRg+KHYv2nZ+K5LYNbCV2rLGLt4nUGt/qRQshYJdvfPKY
	OfGeH90WUQMSe0BufSXZKUNi9wLxV41Kch6UZ3Lo3yN2Asc5PqM4sxxX+O78c98EA=
X-Received: by 2002:a05:6a00:4148:b0:7e8:4471:ae6d with SMTP id d2e1a72fcca58-829f70b8b5bmr767543b3a.57.1773192143073;
        Tue, 10 Mar 2026 18:22:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6e23c93sm486974b3a.29.2026.03.10.18.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:22:22 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:22:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: zram: Optimize LZ4 dictionary compression performance
Message-ID: <abDDhHV4y68ORzr9@google.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
 <aa-1iKEWKNB0zDwj@google.com>
 <234ad9d53124461185f60b9cd2f1603e@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234ad9d53124461185f60b9cd2f1603e@honor.com>

On (26/03/10 08:32), gao xu wrote:
> +static int lz4_create_cstream(struct zcomp_params *params)
> +{
> +	int ret;
> +
> +	if (!params->dict || !params->dict_sz)
> +		return 0;
> +
> +	params->drv_data = kzalloc(sizeof(LZ4_stream_t), GFP_KERNEL);
> +	if (!params->drv_data)
> +		return -ENOMEM;
> +
> +	ret = LZ4_loadDict((LZ4_stream_t *)params->drv_data,
> +			   params->dict, params->dict_sz);
> +	if (ret != params->dict_sz) {
> +		kfree(params->drv_data);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> 
> static int lz4_setup_params(struct zcomp_params *params)
> {
> 	if (params->level == ZCOMP_PARAM_NO_LEVEL)
> 		params->level = LZ4_ACCELERATION_DEFAULT;
> 
> -   return 0;
> +	return lz4_create_cstream(params);
> }

[..]

> Should I modify it like this?

Do you need lz4_create_cstream() as a separate function? If not, you can
just move the code into lz4_setup_params() and remove lz4_create_cstream()?
