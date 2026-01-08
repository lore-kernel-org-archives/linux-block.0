Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EA28C5B1
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912001; cv=none; b=LYTnDQH5KcxQ7Ildn67ZpVACPBj0HDvN7Osh77bIAM7BnZvOcAMLdjX0peP+ajTPAgnDCfS6+o1Q/yzi4vS9oOvBxDP+4JOXitheFf8hfuq6KRgJIj+GddMk5/DPaYptMtnWxd0VMaPMYX7qME6QTD9EZZiVPYfEsb47wMGzHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912001; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7cZDkabDj2ENkPjHOZwKVh1O1rL3UrXWaJa8Hh2GHeAJQFUwWn8CQIlxA9oPkxhw0UsM1GyNG+iwoqYDRUujOda/Gr1ljP8gRMPkzNe5Rlb1JnxDgkQL2IchxHgRFUqSq8Bn21GIMYLj8g6/f8HygJ8DfHuFm4vddQWyMcpmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbgZy9aq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbgZy9aq"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so6177507a12.3
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767911998; x=1768516798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=QbgZy9aqk2vWTF3AOoOaQPqCoxYmFHqIMeKqpp0LyGpZzijVwmyPhs/o+evjzVCH7w
         wKuZCHr+r2RCbO6QbDHqKVNdBJINLcOWqyd8ZlHWDSDWuhzUX1xzJ9+RHrBEDRJN6Ss3
         UzlrtGVmmTpU9t+QegvtAnOuN3FkhXpu2VM6EADugxTgXPDsLcDg149nSjautFtBCl44
         0EISw+Kn9tMf9ARygEjCw8PBBB+tugSz5Yt3exeEA32qaP2D5w+4imIv8jDZYrT3slsb
         SaRRsMc7We6RSq87eGTHuFBiKcPtGd4oLjX0HljsDxZlGSBwJgvzQhRZpnXsIXj0kU8q
         TQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767911998; x=1768516798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=U5a70UrXCEZlBDlKGuE0nEjP6tmuMKSfVqhvsEXVULlL62DWr6NdFYCxO5JvB1GBT6
         Q2QdO7OGquAGEKXY8jnSlJIRo7P8lYJyjA2l2IYrNJkn4TQaS2qo7DHlDmgDQkUbUtcV
         DgNuz36mEszqeK1KXx19V64R51dF5oj/9roaEbYnH017KvMsJwIaaYCZZMnHwlGWSYse
         BJ7c0Rng45L2pseRm3YbolHaLWU2StJDydozaKugEIVqXxGIb5ZevlQVs6jIiDj1Gnh8
         von7Lby7PrfmYtT8jKZvzjlac4oKpcOHzIwgVD6hNvtJq6HAxxINF32S+cFqCt2MHc4z
         /b+g==
X-Forwarded-Encrypted: i=1; AJvYcCVy1D2gg+0CHDQbWTc8lXnVdNvPhfW333KF6CRA/X0bLQIeG3DI0lNQ0cxO5OQ+YRJI8wVZXCcI2eGuwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uOoNajEmRxQqgaBXiJfFTNGf1HscoiH6aL7uuyvdU+vxKT8W
	0cOdnEkNzN/Hshx6PVhYbAOOPm5s+3QE+F2x+73bdNzn1sSx50wv9SewcHnUz3m32XyCfLUPoZy
	H/jti/cfZiDx0vatww18sZNm2DrwPTg==
X-Gm-Gg: AY/fxX7nGLc/adeh9DkBO45jB/dgi7s5mO3CxSBiATAKvCc6Nl34qqm/OeUq/dGT66j
	MpVZXHG9ZK5hMv+473rbF5TazYggA47ZA+lhmpjAT6I9cAUTWdylG3kg03ZDrsni3fTmd9Sjib9
	CFgxvHq/eckQvLZFC6nefVWxt7xy30zpVGwiKcCziwd8Zj8+IR1vDqtkDjeQfkUBXW0U7VaNphf
	61gl56PhDWXRw6ma8wBEo+ncbivkN8zcm+JEZUEO4mImOZ4Y1XkoP/7SpmYAhBIZZ5Dd7IzmoJm
	rHJondMFDx+BLODqGgYEon+oU5kG6TIV8Ea+5fGL3Q==
X-Google-Smtp-Source: AGHT+IGOvCDDBmwDmcHZS3ZLtEWMgsbk8YHksldlgh5+t7hmn+dGTou0rilUkLBS0AawN5vMkCkMfsAwQHKnMCFbePA=
X-Received: by 2002:a05:6402:50cc:b0:640:c460:8a90 with SMTP id
 4fb4d7f45d1cf-65097dea447mr6973619a12.12.1767911997940; Thu, 08 Jan 2026
 14:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108172212.1402119-1-csander@purestorage.com> <20260108172212.1402119-4-csander@purestorage.com>
In-Reply-To: <20260108172212.1402119-4-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 9 Jan 2026 04:09:20 +0530
X-Gm-Features: AQt7F2qutSapigW2d78mKK-K9ISNU5Mnv98Q4c-zxR6IX4o9wG-xZuIAbv3p3V8
Message-ID: <CACzX3Asj5B4LYZZ6=8aW-z-ymOg_c7UjpfotS+h=zuCiJPA1LA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] block: use pi_tuple_size in bi_offload_capable()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
