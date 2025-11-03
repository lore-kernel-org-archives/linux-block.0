Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5430CDBA
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184934; cv=none; b=kcbbtZ5TwH6HmVGvJmrsPj1YaEHa/gx/ME97EPsf2mvPkuoaOOyeph1295RDVkpiFrd8CjH7NkoYjQOGakolBDKIIJj9rvIPJT8KB9/EqPJHP6seGqYcXapv8CD7GqwMLcBCMCm+xrHnzw8Syq2lC5zLF8vT0LeT4VbUf/8HHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184934; c=relaxed/simple;
	bh=r1Wj+lLEz6iDZYuUxloSqb4KwY7pVPQYWPbwvvKYG9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dQO0MyYcNX5EKtTvM3PxYBlxpwqbc7LCRndADneWwVASEQaZHKA6qL96q9RA5tBLcsnZU00hxfOKKTSFPaIXfTHstW1uL1IV1l/918y4K8JhVYI3wsLMaI5GOMt8E5XCOCW6srhl+xgWv0O5CU03oMtRgOxGxPUuP3cVZ+iO2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=niOvdd5+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="niOvdd5+"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4330e3080bfso14271845ab.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762184931; x=1762789731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0ZGfty/8mAewXn9BC6HcMe0Ne+1EAPTjktFM+rAXUU=;
        b=niOvdd5+yCHGkH7Gd5SlEV9xVrbtZQDwjTItLbobAyZLw3hOFeOq9DESRfE4S7Aqtz
         r/aAElkAl4RwqtGk86qqNvthPI7O1+RLldNHryxm/4lEiGg08KBEa9whzA3aHw5bHhIr
         PGhUvziteYBqkx8pE2qlfHrh95oBoUrguua6OmNyOpFRYETVvEQ1kYNnwY97JWbap6SL
         YU/ZX2rxDoHlDuYJoiKnRQV+QNeP1HT3i5hQWKm5bVCqL3ioXGdxZkUT+76Cj3gPFxbJ
         XdNyTfUTB9Rl2FSqV4D6Fke4ONfVKh5M5otsXPU4N9UIRipAQEFBtJ9W4WqhRjVC4VRj
         89fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184931; x=1762789731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0ZGfty/8mAewXn9BC6HcMe0Ne+1EAPTjktFM+rAXUU=;
        b=cL+DQ5/ik7v4xqv5SOUZpCuab3gj2/rbUPsSC5P3uoteLYHFT81uTaVi6LYT3b6yxN
         Amzw5IRqihOgOYmmf6aPF4N2xFBeBbjXx0RJRk2Ac65zD4npYcy4FDDKTxtmpPwAKi+m
         PpIch9VUO9X8F6GKdD+AYSC644kypIPQTpFPkKPqQyigzgklzo3NmR8BBBnkceo1RraM
         7Jn8vQLPQyOtInu5O0eluJMPcRSw/2XHwFHCIDrjRm27vSMSS8BoOa6Ern/E1Hgp/6WO
         FTP0sxmzJQ/p9jAgCYC9hCBO5zq+HzytE8VzNrnXqIitc5IdYSgCgBhn/Zbx0C2Nx4xN
         zXXw==
X-Forwarded-Encrypted: i=1; AJvYcCWHm5GaxEO4E8qHC9qbUDQNf4gpyxIamjp/kMk6gcxrQvBa7WSpwhWLZTKhk90Yr3xY+B/0Jgr8wDf0jA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XB2F//zco3pJhmr3JH661WOLSJFRpy/nn+rXmZdTTUaPOGC5
	IeyUL8M57vyQ+og8Ofz8uzwXMTDiap/wMIZ11LyF+MHh4UCPoZg/4oesvaFEBnWk3myDkupWZdi
	mp6Mj
X-Gm-Gg: ASbGncsHYr+FUEwBkhM2gPxSZ241gDM5pl+h7uSeLgPMLNf3twLej4cA8zbXo1qH31m
	CR2RJQj+i+ZvjlLoK8YMM1LGxtLXi+hZG9teZ9Pnn8bT7mX7ddtrzDvVYThArnn5aqLYi0mW9/h
	QaUTBjy26q1p37MaGQwPicmNrRtQRtdIeFnJ86SAWLNQZEu+PrFBpAZzf8Krrvv9nFBeuwFmIl3
	our4oxnqidnVLkpxNcyEJjLv5sujZgfG/V30fAGH5oTGDJ6JQAHRI+ynhRiyWSYfWwg3bMqnkBA
	nE9TyVERj+1zPdFkIjJ6cuTXMbtdeUhcNjDGWdtfr5x1FgLdT41jRvakf8o4vn/sEjs3bCxK9ei
	j1hhWfnwTksYv5c7o35PmiD968c9uGOjvIi+r2tw0fe34wVYB5AgoK3ybXjLe4vSw4cCMGzm8
X-Google-Smtp-Source: AGHT+IGACTiQJ9Apk97yY4E++YRKeGU+wmTLYORniFjM7Gl+FdBCmn3XAqtJmv2392D7kGtuUUfyvg==
X-Received: by 2002:a05:6e02:1805:b0:432:10f9:5e0a with SMTP id e9e14a558f8ab-4330d207238mr173707945ab.19.1762184930736;
        Mon, 03 Nov 2025 07:48:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b48575sm2821245ab.27.2025.11.03.07.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:48:49 -0800 (PST)
Message-ID: <d83a6bdd-e445-446d-9a89-5eb517893776@kernel.dk>
Date: Mon, 3 Nov 2025 08:48:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update io_uring and block tree git trees
To: John Garry <john.g.garry@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4d23b2b2-c723-461f-94a8-a90c60982bcc@kernel.dk>
 <ed992ce6-5224-4bf3-8bb3-91fb112c9287@oracle.com>
 <b083caaa-5dec-41dc-8885-8ebb34cd1781@kernel.dk>
 <2b53f0c9-3151-4f00-821e-ddae5c2c2135@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2b53f0c9-3151-4f00-821e-ddae5c2c2135@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/25 8:29 AM, John Garry wrote:
> On 03/11/2025 15:11, Jens Axboe wrote:
>>> Were you also supposed to update the tree for "BLOCK LAYER"? I think
>> Yep, as per subject, "update io_uring and block git trees"
>>
>>> that previously it was
>>> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>> (as that it what my .git/configs entries have), and now it seems to be
>>> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
>> linux-block is somewhat of a relic, since io_uring was managed in the
>> same tree. That's why the block part was dropped, as both block and
>> io_uring have development and fixes branches in that same tree.
> 
> ok, so then I would expect that this further change is required:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545a4776795e..0f7c7388bd62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4393,7 +4393,7 @@ BLOCK LAYER
> M:     Jens Axboe <axboe@kernel.dk>
> L:     linux-block@vger.kernel.org
> S:     Maintained
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
> F:     Documentation/ABI/stable/sysfs-block
> F:     Documentation/block/
> F:     block/

Indeed, looks like that one was missed, as it already used a kernel.org git
location.

-- 
Jens Axboe

