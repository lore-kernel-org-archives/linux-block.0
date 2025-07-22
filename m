Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364D8F40
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182058; cv=none; b=X2YWqsQz7ONGx/At+tnmCc3S038CwNOPKNpkJkl6P0GxYySi4hgvCFFjaRYirCs9Cp8p8kRUZtNEN9M654IsmhXZLIxTnzhXOu9+5t8dl2OQmWja8scObxg4vWSDlh6EpKpqfcdrzH3aXam4yJcVNigjuLHtaNhT7oWmXrYR50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182058; c=relaxed/simple;
	bh=aHhUwbPOUVytjz/JqFm59v1d8/zHlaDMa0Xn/Simv/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anN0U3Tnf2dZbfVhvBOcrwkuWVNOzlqCmhhzwvmO0q3slEzO9ruwC8FQ3l8j+sV63zr6RBClDpEUL8bYcglnwy3aREDmEHluYkDY+CGqwwCiccSKvg/3PXrW8k4XP5Y21bopEoWEcmJzC1FSOTSNcFLYFGWHgucv7fzSQianWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X+v2ARMO; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X+v2ARMO"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4218ecf4565so1328160b6e.0
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753182055; x=1753786855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IscIK1wlVZGQe2iZsUX5uf2wnmdFCseBw88jV5THu0Q=;
        b=X+v2ARMO0AxXM4xii2hoTl/aT2zVF7m3vrgXUdJg3xvL5qIl11k/P55CXTH0l3UYL0
         E9CzM0XTpKcsfyHICQfut9a27qa+O/+VEHlp7g9bshxkAtBmjXQ8ZzgspfKapFTTrYTP
         SBCPXqpXBo+YVaHcQZ2e7HVnEHhG/LFA4eYLyXi1DQ0nD9dgjWgxcWfDkdVtaAL4dWKv
         Mc5qZ9ZuyqXPXvj5obEmcFoPBxP77ijNJRQo3IUIMfqbQCdLHJch3QnxGzA/D1Fht1QX
         4q5mIca1VXgzWeK7h13qRZdiNg/TFMawkh3S8KwnYemTtLmxMl7guxl7IA0D1HEMwWma
         j3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182055; x=1753786855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IscIK1wlVZGQe2iZsUX5uf2wnmdFCseBw88jV5THu0Q=;
        b=j9BHxEQOYNo94qYrOm5rkSJKqSFdtX1pwv8549p6ZtyZOxKof/fUOs3ny1yfOOnRqO
         W/9w9tlzGiQvNVeiXpGnBaaF99v/CiH0Iu6V3bxx40LGwsND195n/NMCx/whcen8+UAZ
         eC+9eENp5KbXElc/PBT1fy4oMDBZigGDHKM4hBLW2plJpKzpOgowdXJYagyg3jUmrqWO
         UXlZOFUuMCdGIjiRfavJkiG65XdyRDhJ4pk8pqOt3edSRWo30EO6GQ5oF1pV/tB87EP2
         1kNl6qxdnmNw0HEd/r9NQ6+guwTsEM/TnD5qwuHKuI+O9V3k0rWLneM+aQHYxFw6oE8z
         GkJA==
X-Gm-Message-State: AOJu0YyGepkKZ9xG/vpxEJolhai4bnghAex01ygU+63TLqVJRPkaUZa+
	Od4edVWJCcVTnGZmgwu/KUTyKgsIrL8JoN0wrsXDHiEG4lU9PJoU7QcYnYk/GWlTz48=
X-Gm-Gg: ASbGncuJOM4EXHnb2cRSOKJIZBNfDq02w1yk6fa74z3kYmNcMW/TtYxzRXOAZR9zVIy
	DEa0ttb1dI57dRBHjgRPjElBVMORr5659NPWfeJWA+0XSuAL0xX2aDDLpwjcQ0ShWhBkuDHOJjc
	kqTX1ftHHzGaj3O8JCJLSQ9nv5jDRaNGDUiH7e1cL146niDNqiz2//1E5EAtgvNwRx5Pdj3d7xC
	47i8X/q1bKgBDXwvHI5Aw2ff1WwR63HAK2AiRemOf0eVWpYB6QwaXcvTiRfAvLeDFkNQ/0ievnq
	xUYpKMmsTyXpWoqaSVclnDqUGMF3RGPVdSP7UMnGxrwv+lCxi2oz3a3Gppdyi2dE82P0fbfA2q4
	4qW1+MEEkcdsZQ2fsous=
X-Google-Smtp-Source: AGHT+IFH4hszfKlcjmM+E3XIs4bLTiqNr1FYs1W7xInjOCarQV1lzVre1IXTX6N3/REntXzT+XM54w==
X-Received: by 2002:a05:6808:50aa:b0:408:fe75:419f with SMTP id 5614622812f47-424a785ca2bmr2214448b6e.13.1753182055383;
        Tue, 22 Jul 2025 04:00:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c7bc643sm2397742173.27.2025.07.22.04.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:00:54 -0700 (PDT)
Message-ID: <e4bc2fa4-5137-43b5-b11b-4a9ca6519b54@kernel.dk>
Date: Tue, 22 Jul 2025 05:00:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
To: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com,
 anuj1072538@gmail.com, hch@infradead.org, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com
References: <CGME20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e@epcas5p4.samsung.com>
 <20250722091303.80564-1-anuj20.g@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722091303.80564-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 3:13 AM, Anuj Gupta wrote:
> The blk_get_meta_cap() implementation directly assigns bi->csum_type to
> the UAPI field lbmd_guard_tag_type. This is not right as the kernel enum
> blk_integrity_checksum values are not guaranteed to match the UAPI
> defined values.
> 
> Fix this by explicitly mapping internal checksum types to UAPI-defined
> constants to ensure compatibility and correctness, especially for the
> devices using CRC64 PI.
> 
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")

Where is this sha? It's not in the block or upstream tree, presumably
it's in the vfs tree due to it being an fs commit? In which case
you should probably CC that side, as this cannot be picked up on
the block side.

-- 
Jens Axboe

