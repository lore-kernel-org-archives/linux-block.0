Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C22877FA
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192619; cv=none; b=ivuMvXecLl3cOO+FrqXbod5ui+HwWMWuNrPxsqshVhFFpxxE0ZT3fFlnCqF6Y46lcP7+H6uQMq3FJGNrHokAgPBCo0VQJS+J5D4A2hmHspvavxUzeI7ilGl3CDOoaxztqLwqpWKcfrDraVskK8dJ3v8NfZrjfriUrgC12bX6l/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192619; c=relaxed/simple;
	bh=WD4UPgWwrp87c7JvBmxtXsetEVuHqNKEul4WKe735JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2oTSuoBsuWzEAXyY3dVhf6JXhKilMDvliUQPpQYRzISlNI34qPEdNssVH1ZaKE9TqeTIAQTXn4FkASYdJLr/XhZICjQz1cNX1sAS1U+4tQKPmk4/IxMqL4KxJSg5Yv5lVp7IDBHdt+a0ThL5wtJr1HlJQJX98kmsBt7rfQGswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VywL/X9X; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VywL/X9X"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-87c32f46253so84149739f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753192616; x=1753797416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjmFlUiMS8WhvA/SoS60Dh4RJFEn5lp/yFwJABcPh+o=;
        b=VywL/X9XlLouPHqv4vY9/WsyCGZBjKEdSwRdltghOutRBpeDDfsizJbgrlBN9jDVqu
         H5xgN2/NtYPf0kt7fzAn/NtH3fR3ymSAnoSwFx7p6dd76I5+/kmwEu0xsRtzsxLajfvh
         78HxqmC93Psx0g4wmFsVeC9lw3qWAVOUVPLRsp0HW1Q7e3Ihvr8fh/HhwWqtSBp/Ictp
         kS+wClNzeGGLUYpWcc68wGSRlXjuoalINKMjDy7tocN3aimOVX6NFxxpXJsMNkYh7LJJ
         B6FWCrXWC4Gw1FKszlm1bz9g6OeXMXLwFDzwE4ApB0ttB7KwyLAuJqsbF9TN6ymqEPA5
         bSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192616; x=1753797416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjmFlUiMS8WhvA/SoS60Dh4RJFEn5lp/yFwJABcPh+o=;
        b=B9ewk0avQXZWL1L/fW+Wd1kgD0qbt6yIvLjtwZPVoZG/oMKdWoSoSrGt0iZ+pWAE7+
         lqsxRVX0CC4B0cftn4/ZjSzAkqWZ8cs3U/lsX/ttnSizFijnfALrXHrbfd+iN4/Uu++V
         tSVLuTDFOPiZLqBSkDb2mQBjgOs5/23vaqL3QWlHYyaj9hyI+AdY0OGQVYjDnsHaOjkW
         0TqUWTiExDU5cInc7NqpqcOKwiMDyRrGM9k6gXwxuWM2pyb3XUgDaxPEdky65VfMo04e
         LGcUAey1KaiCj46KRrV1QY2Wo0SKYMTEhcwCn7HIZiesbtDjLHuPMzbO/DukcJoiVe5M
         LuMA==
X-Forwarded-Encrypted: i=1; AJvYcCVu0cV/ICc82eu/2bFUYhbK2nnuVQuf6zbuiHsaC1Gwlor9iUQJBFdS+2AqhZmaWLEyuLNmKMavhrGz7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhvtJM7RPGDx9ECjryrEwjaYDGvrBhMXwaBG04a4FC/r6qHQB
	fTdIUTsyrkyIG+ymvc9bVQS5p8IKTiMp2FhHt2Hx/n73QlRcWWWKCTQ/azMVSzK22lc=
X-Gm-Gg: ASbGncvLJZ3QZCmiJptvqqqcJai1N+oja17bm2Mt18wxZjVfTTEV3JWZ55xfjEq0+Yy
	ifpP2SZ4V2FsyldWYjOWQ+JxdOhfVca9YpJHufa369JNURYfDQCSpjkDIOVatvhAp9a1iESS2mg
	5Im49LwKMHmr57JCmnmX+361C8H5C0wQeN0YQhzVATK+kr33+6bejWBxNxDCAH/yHJco0p8/5ut
	lmcv3AXj1y6dnLrSgC5rxxWQtNSBThan85Z6uzpkl9pedJsvKDXSqvr3mJXaHky4vMtLBd96eWA
	DeCwlZousCNDDT2zbWTjgT9Mj8aA846RmqCY4NkBCl8+64dyUwZsZB5+q4RcVwy/EfllsLFuMvi
	Dw/FhyQF+UBNlitRWHNIU+ZIbUkpi7A==
X-Google-Smtp-Source: AGHT+IFDr+fErNv5tH7IdOj2j7uUgenlIGzMOgYCLt1qeLE9jnEGv4AQM7YVl9je3Z12CEdDAW/qHw==
X-Received: by 2002:a05:6e02:1fe4:b0:3dd:cc4f:d85a with SMTP id e9e14a558f8ab-3e28d3b88bamr240624905ab.6.1753192615551;
        Tue, 22 Jul 2025 06:56:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca5f843sm2502681173.129.2025.07.22.06.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:56:55 -0700 (PDT)
Message-ID: <62b5f680-5d54-48e3-979b-8d09a876130f@kernel.dk>
Date: Tue, 22 Jul 2025 07:56:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed several coding style issues in the efi driver as
 reported by checkpatch.pl:
To: Dishank Jogi <dishank.jogi@siqol.com>, Davidlohr Bueso
 <dave@stgolabs.net>, linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Manish Narani <manish.narani@siqol.com>
References: <20250722121927.780623-1-dishank.jogi@siqol.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722121927.780623-1-dishank.jogi@siqol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 6:19 AM, Dishank Jogi wrote:
> - Moved assignments out of 'if' conditions.
> - Removed trailing whitespaces.
> - Fixed indentation and spacing inconsistencies.
> - Replaced 'unsigned' with 'unsigned int'.
> 
> These changes improve readability and follow kernel coding style guidelines.

Will only cause backport/stable issues. Please don't send checkpatch
fixes for existing code, it's for new patches only.

-- 
Jens Axboe

