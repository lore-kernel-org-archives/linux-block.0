Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA12DB781
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305007; cv=none; b=jvuTiY7VYe8QmKjfVVtRnn2qLddB6+WTJJryQbKFFCo+71GmscJ4gAMgEiSiX/SfS1QDQ0e0okbqm00DQODnrNdT9mpWkaSBJBnGC0c9W9B5pJiYyBMa7joVYSldNezyLmY2QtVKd+o5uTJLOY9U6HUhrlN7Fx14jQtAseAJxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305007; c=relaxed/simple;
	bh=1wS2Dp0j8j7U51hcsEcED+6qZEgOqRZvoSwj5zOBI+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qspm4NAlpRQvbSgDEYFYwlzC3gjHEwkMPNFeAPkmLr7/r9wCEqrFrzASgsXyTZ2wK2baWJGB+VofB9zyVJo1GeEeB+WIw8slGy1P6e/TxsOzjyl3C27sliFDSUFCp33I5sGZR+fqmoZSBbJ4ggdjYG/ijAczZSssBZ50JnKKuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NdQ49Otm; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="NdQ49Otm"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a116bd18ebso638321eaf.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782305005; x=1782909805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vBqNWysPNQvqkzsE4GQXCpY5+Q5GT/QhxmkZJrUXw8=;
        b=NdQ49OtmMM6pTd932PgSzQLVlQLQia8eFx+1H4eJV+FY5ycGnb4e391PH51FCCO9nH
         tXdBfux67ra5F0bf5duaGfi6R6UDw8/cA5JFdDfuu5mbFvkB+TT+TaVUx95lCYEKBfNt
         yPpioPJ/yNsEWOpZd31galaxrw9F+dlq76DnZIP1WCl21JUVPiG87mzpC0VioHrA18Nc
         /tHqbEPoYT8jGENF/wGUf3RicpBZzGbo3/WZyhHqp8w42gKMqqN9/VCuShmYARsU7G0X
         /KZat0YH00vALmDihnkwflZLb8iPcu1NlJu/G99LUKCH3+VH4TdRtUCLSlojvS1jGlkW
         /Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305005; x=1782909805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vBqNWysPNQvqkzsE4GQXCpY5+Q5GT/QhxmkZJrUXw8=;
        b=CXLCtc/m5D0r3SPGxEepnYimEWeS/FlkAhXmh4feY40uwlut5xbbVnvgZtLHQQdEsN
         3UkfFWXX9qywjRZy4JkGzzj2N8yBcZ83E9OPRIv9r1cUcWvAA9yJZtT3OUsKSUfG2kK1
         pFSs3PlRXBsuNnBrYyclH27kzDjJxd6UiI8J+kMZnZfO7vyCbRWGHq4voBPdIgujeczZ
         oAR/yBW4DJs9gsorafHswyoH8x038xdOrfYbuTyeZq1ctb1tFDclJfyAjecbtmm9UIXC
         T+DlXX+dGXy3PECMOj7O8et/0giOH75HyhiNGm1lerln8C6l/EVDzkXoOwIZwF0g9cK3
         24JQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C4sieiNGIqR1zk3G205Ewxf2uv6McdfASzgGfTHIgrmR1I2hlTweomw5emtApTZip/uaUyFfRx8zaTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyUa3P6L7ANgdJ/Fh0pzsMYCuD9PZ5TekGDRG9tK4IXSNwg+IT
	CSkwzhW9E3suVwKncd9vBndB/J3O/5/U0XaI/lRIkBtVh9SnQQPO+ZhDuxwMpLwMqE8=
X-Gm-Gg: AfdE7cm1P+ZTKpEJDsU8K0dEOe0RME+pEfqSrn52SqxwOWXMDEJvHn5SjGTDinC78wp
	LkBx/ptssZSsw4c/G4+YgZH/hLIJv+NDO8iePuzXENcZqfkxI7jiGN/SHDxf2sIC9cYQM3NZVex
	WzE6gO4YN9bHedr1gEIcm8yRBlk6rXSyjfXBmjr3NA795Nht3YAaPny7KcBUQodKZfJMi14DGvu
	o8LIzgkSsLvL9MVTfrPXNFfgRW8GESON62zvLdqZobOaKWbdVnKxALrdXOKw55KVhB3LtGyLdKk
	l7zF+OjI5HS8PGQUhZrMybdAwqxTMkTzBq51FIZUT7XlcDVjLj5HnBC2mu2aIzzA+SbLxKVJ/vZ
	oIgnZF1EavpXTUDOjy6gTO1+YG/Qstw1nyqFbyeZk6hkIgF6nbJdeJj4hvMDG7hmE9fs0tZ7ZeL
	AijGo7ZJAaOam83FwR1oeRJDAHI7TFcQpiG5nNcdBl+igZ9Hiwcjk/WPmbt+CaL17uuBEw/gk=
X-Received: by 2002:a05:6820:2110:b0:6a1:20d6:ccd9 with SMTP id 006d021491bc7-6a123020da0mr1995384eaf.49.1782305004833;
        Wed, 24 Jun 2026 05:43:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0464a6sm10164438fac.15.2026.06.24.05.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 05:43:24 -0700 (PDT)
Message-ID: <34d48fb5-4952-4a48-b92a-f189bc3edd0b@kernel.dk>
Date: Wed, 24 Jun 2026 06:43:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg
 paths
To: yukuai@fygo.io, Yu Kuai <yukuai@kernel.org>, nilay@linux.ibm.com,
 tom.leiming@gmail.com, bvanassche@acm.org, tj@kernel.org,
 josef@toxicpanda.com
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
 baohua@kernel.org, youngjun.park@lge.com, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1780621988.git.yukuai@fygo.io>
 <1c739fcc-5132-4cb2-bf34-cec94de26509@fygo.io>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1c739fcc-5132-4cb2-bf34-cec94de26509@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 12:57 AM, yu kuai wrote:
> Friendly ping ...
> 
> This set can still be applied cleanly for block-7.2 branch.

Not sure how you checked that, because patch 3 very much needs some
manual attention to get applied. I have applied it now.

-- 
Jens Axboe

