Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637122;
	b=NKfm8Ky0+NE8Xv4DIM1yI8WC8WKk3RujklsWlb2OZCwclcVDEi+L4yBXmLLy4GjedZJi
	 o16ITZOfShtZYEtCDC7SF9XdaHK+t5UqnJtady/SsEWs4QNiWfBqHrkgQF4ITqZXjTRMF
	 KT6MPtR4YrEvvpCJ1petzZrOYVd10eHwescZZzUiuIfXiTyGx1yb7eaDatft9c6ZDKSqi
	 M+naowWYY3FY6p8rnS7y3UcxCkiC0BbGGYKB25y3jeiClZXbn9gF6yTIp4VQu8W9TMtp+
	 gz1h4eG9hO1tgSo9gDQ0qVyBjCSG8AWLNeZ2L9U96JhoBkTVceCw679SXbGhl1bG08w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gR6R2AHc7gBb5wkqmemqR+xmiUCYbQP36zxK6dFbSqw=;
	b=sEV+9DjqTiz4QeIUxwMGRo526RvqGDr+/uKioMVbZ/QIohzQpcWJAWViPyyuqjXMEzYf
	 HYsVIBxmW/5VoLAMNR2qNMIti2990H8ryBIKz3qAJ43coPfZWeIoZSYcs3W3OYfVs10BR
	 o6FHXu2v6zdfGrPbHc5ZUqHYNWaRTiBnWh6pxV/ec+OLevTxkvppuQz/1nXh5AhUtj/Ff
	 DEgziIR0WcyfrDDMfyAe1k1ui9+23LGscS1Je1bTkvaWNvrdMEMOpQBTkoAqNLIhPANC0
	 s6evRZpogtKOyujh23DKG2fRrayCC/PFK8oV+dqxgEfraFLnQtfb2Csm2kvqdjtdI1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CFouMtM2;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB048606A321
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 02:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB048606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CFouMtM2
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36681e85e87so2888186eec.1
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792637118; x=1793241918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gR6R2AHc7gBb5wkqmemqR+xmiUCYbQP36zxK6dFbSqw=;
        b=CFouMtM2xSUV0b2ozmgO28jJ6DsuuN+jq6w7L0pKXhtW0VeifZcL+VwC1/Cx9Z8y5P
         FOSFY6L26wy6hw+t9jxpVzagxEkWAsYNbHKSHPC87npK4/uVy2gbEEijD9OREpPVv5i9
         /W/GVKcj1wZDN6G1wmPPnAwWagsviDXNiDrjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637118; x=1793241918;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gR6R2AHc7gBb5wkqmemqR+xmiUCYbQP36zxK6dFbSqw=;
        b=WYIPlLoJI3kOMvMyf66QeIaF4sVcsdBLzbrb2Vgc73FRgOIzxUrZUs82EMoInK7cay
         IVoSvKpwvc+KSkvlhL1VZRF8nUBTuVzVi6bnswkvrhoksbP7D4vi19apgEqkHH/y6V05
         h2wyG454eqlkOzaT2+fca0aNS0KouCR01EVDdZa/oqtU9Fayx5NI1N1EMCxFh4n/fNL0
         m3gIHddGOLbS8owQfjbWtP61NuxbrEpXoUkMRAA53wFddhW8vr3ClEvN6/UG7yeVI7gB
         zhysbqry9J1NQQ+kP2pj0dGs22rQApfuj7R9q3W8bmRcs7Lne3O6AnyUJeRkHSEduLoc
         DzIw==
X-Forwarded-Encrypted: i=1; AKwUvBwAO7MkIIXFCGxjdzKMiJY7GR8NeLk88JVD30/qz18MJ7ASyENBmmEScqO1qKojFHBJKW4/2d7cZsrn4g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIFjJXWdPGXCv5cVDcPuz2qyq4JqvBKy5sSsU9ozEE6bPjUCFFV
	mIXgC/iYhQ3aKiBk38+OYkMIj+CPUHkndUf0ARq5SX5KXIwIsy8qlzpok1ioEF4hkQ==
X-Gm-Gg: AYBFou0q+/inYcqw8ZANXmFZGmyrPFcmsOc8IfQjtBN3DApxAH/L9Q6Dybz9xyi+AQw
	rxyXJsWSivQT0M5ALSzrj2GFuM7vsLNfEU5AiUR1jng+s2w0TqPAih61lvwpvmGxTK5L5A6K2Q6
	McEEJGJiUiynXpFF947IXWUt0+9dfTEYY47ardqYzpzVbZM4FY3eg+070HvFi3XtzjcQDSsLup6
	tqOU14yFLsLrsdnjc6lxrUY8Xyp1PhD+jGNBJbKL20rZ/zJzbkfGLFB8e3dhZR2q9tUnCt5xoKv
	+iHJh/Vs228heVwO7Tm9obCywj5/qfeWDPG0+YPXqdY+xalsscQZZynddxMarI9z/hMKOJdZD9m
	aCpdGthD3nSkKIyXJDj4SwfvGg4AHvPUc8sljjpyd6NOpHSmnfKcCt3jzrX6v297MvW5Jcptnrt
	3Z4mdeKc2zjYTmsAUwaDc6RjaGLe/u73l7jTDoN193eYcpAqNencPxsVkUKhpsBFMUj9Gj5dvpD
	8XL6P3Jlh9QDMfzc6KCmC70wV8MxiCaBdD0RdY+rxEPjbo9X0KmpQTlRyaSfI3JGSSJ2x4l0IfI
	p8DV9flTVXOSkULT5BZY
X-Received: by 2002:a05:7300:d0a:b0:361:7ab9:479d with SMTP id 5a478bee46e88-3674e8400femr7484266eec.27.1792637118082;
        Wed, 21 Oct 2026 19:45:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5145:5add:2df6:4671])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367412b24e3sm10388672eec.19.2026.10.21.19.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:45:16 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:45:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Martin Leitner-Ankerl <martin.ankerl@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] seqlz: a compressor for zram, between lz4 and zstd
Message-ID: <atl35k5lvs34BIej@google.com>
References: <CAAFOosa2WLf--T17cujJu5CUsN12NNjgTitOvno2LY7jAr1gfw@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFOosa2WLf--T17cujJu5CUsN12NNjgTitOvno2LY7jAr1gfw@mail.gmail.com>

Hi, sorry for the delay.

On (26/10/09 16:21), Martin Leitner-Ankerl wrote:
> Hi Sergey, Minchan,
> 
> I wrote a compressor only for zram's pages, as a personal project of
> mine. Before I send patches I'd like to know if you would consider a new
> algorithm for zram at all. Much of the code was written with an AI
> coding assistant, with me deciding the design and checking the results.

If this lands in lib/ (like the rest of compression libraries) then
sure we can use it in zram (we are currently not on a path to acomp).
But if the plan is to have it as zram's "private" comrpessor, then
I'm afraid I'm not equipped to make a decision on that.
