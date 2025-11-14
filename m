Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611D330314
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136708; cv=none; b=e3AtYZn6hLJdWhmkYvdlNWqUmkAaG7N6iBIIdsC6nHd4FLApNXdqGIe4/tKcg8VmHZ/1yR+0bUUYt/qel/bqrD7wHrPJERK8AMpxtJ5RJ/M4/QqXP878TB8yDRRmyrtTwy+5oS4QDP/dZo74kpK1xo84L4nGX2N7zGl9rTIrlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136708; c=relaxed/simple;
	bh=hcDVSQ3xOH+fL5WuMivJ0+T4lf9wumAuv5XLtSU0MtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZjwWYYKA+dqKKVeZPoxPa0TsyqIHX09u4iPO6VH56eETVl1FO1bGTjs1War4SDRUsMnsE0WounDipu5RKcBdD9Z4SnIiUFERL7fHKBMTb4EhAjqbVuEd2ZV6MHXnXLdy57aoDvudpBIllqx+FakfsLUUfNi1oNZeK7FmeL+YVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JXe6wmRM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JXe6wmRM"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-43346da8817so12007805ab.0
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763136705; x=1763741505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSBB4O8sF5cwhfSvtvRB+XJsQMLGT/JwGMqj+Q6XTTs=;
        b=JXe6wmRMvPbK+xCUrc0rFWiYCN0ZbKocvcbb6TnlWJaBt84iScC0L2+EjvGfxtU/kH
         p2tGghQbQrLYS3XkAqmYY2ewTG9XnxRRAwGMYeUdfpbCE+ZasoFE8SbbqBgswzln/x5X
         QPf5qJNCozcLsjW1U6EQYpz0Mcwe8GMsfX3C9z4gVENxC121Wpkt4wnTlpJ9S7EgiuyV
         0+xd1q7+zHZxb0OqrLurT5BSMCN13za4+dlbozrhyCpUJjNv5Pisf7qugVwbU0d83D88
         LB/1Ad1Sh4wykswkMRncKC3K1Uso1u0IgV/60aYEB61nVeSgOQq5cZPUe7uFXRJ+UrJi
         TizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136705; x=1763741505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSBB4O8sF5cwhfSvtvRB+XJsQMLGT/JwGMqj+Q6XTTs=;
        b=cl2iKsUoh+8dEUWp4qtGhopAbMWRNoa1tpo8w5fDVlxDufFIgtnGTDu7xXUZX9OcZp
         MVd8BKoMMIAt88zb+Ycrdtm5CTeuvKk+sRC+eGbZC0iTG4hDCHM+/nok8BTfqJSobHYN
         BO98FnhvaD4XSOO0JoWYGYTLqBZYMGFstVVbjdusAjrdrcqd3PklTG92n33SMLwvm2Pl
         qpQ0KI/7htcfqSTaeLrad7iwGhYLxgd6BdLZdIGVptoppYojuslJk1HTByI4V6UoWVLc
         DlrxaNY/OZp3aIQlRpa6mGVPYI/Vzu0suJhetkqJltpVZhmzX0i9Tr8saxofpOjRYm65
         l8mA==
X-Forwarded-Encrypted: i=1; AJvYcCWOaf40mqG158Tibl8DcJKggMWeDamIDd1e9+Lbt7TxVk5eAh6H0Xdjylm4Fkj4GBM2OQ/4su97LNT6lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfoUvXHK8/atdNdbTV8sJdYVmDahO7oF6tDB3jA0sQfhPKCdK
	QL3Yj4YVR4t6xmNApuYvdkf45FltHkvpqb3BFRbVTieWVnoczS2r2IuF7J8DKLmDd3Yxkn0qbXl
	a07Fe
X-Gm-Gg: ASbGncskM9RW0ObGCkDVC+0IueG1xlMMe7/dcjkiKxSJ1Yp6ec+/7JSUkkHwwrCmJOW
	wjGYnFu4UvgynR9V1YleP0fjIe9MY2HppwLhxLeOqGouAPWhlf1w/aLgq0x9Vs6BPGC7VMPPoDz
	WAf4pEg27dj3wHZcYaY18jzkQ0s9IZSIBwWSIqkMJzroNxUNWLpONGmPXTXFYZ/+AymffiFBy5Z
	1zgFsvUJgZXVkQzZrqUTtlxd6TQhTz6kH1S3uz5rJL0cxSeeYauqW4FQxP4vWIZJsbaJB0+8vkJ
	3TN1ZjYOtWzQTPg8LrTLWFm1STpHuHC4jJn1e3Ed6gcWLsa0Y7elq55rJrR4n1cOyncFJPpTilW
	b0DhblGkWC1qP3ngxq/B8l0k80iWCntLr+DO5oODNQefTWiKuSn1eAXMWuoPmWgaXtJG6XrGgyC
	X15/6dzeno
X-Google-Smtp-Source: AGHT+IFu47AGTHdolL91DYyh/BTj56/vJAxUsvxGAnlsi8n4+ibCIR4czVHKKE91AAzDZwVe4XRuHw==
X-Received: by 2002:a92:d310:0:b0:434:96ea:ca1b with SMTP id e9e14a558f8ab-43496eacc97mr3604185ab.19.1763136704839;
        Fri, 14 Nov 2025 08:11:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434838c24a1sm27926125ab.15.2025.11.14.08.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 08:11:44 -0800 (PST)
Message-ID: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
Date: Fri, 14 Nov 2025 09:11:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
To: Rene Rebe <rene@exactco.de>, linux-block@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com>
References: <20251114.144127.170518024415947073.rene@exactco.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251114.144127.170518024415947073.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 6:41 AM, Rene Rebe wrote:
> For years I wondered why the floppy driver does not just work on
> sparc64, e.g:
> 
> root@SUNW_375_0066:# disktype /dev/fd0
> --- /dev/fd0
> disktype: Can't open /dev/fd0: No such device or address
> 
> [  525.341906] disktype: attempt to access beyond end of device
>                fd0: rw=0, sector=0, nr_sectors = 16 limit=8
> [  525.341991] floppy: error 10 while reading block 0
> 
> Turns out floppy.c __floppy_read_block_0 tries to read one page for
> the first test read to determine the disk size and thus fails if that
> is greater than 4k. Adjust minimum MAX_DISK_SIZE to PAGE_SIZE to fix
> floppy on sparc64 and likely all other PAGE_SIZE != 4KB configs.

16k seem like a lot to read from a floppy, no? Why isn't it just
reading a single 512b sector? Or just cap it at 4k rather than do
a full page, at least?

-- 
Jens Axboe

