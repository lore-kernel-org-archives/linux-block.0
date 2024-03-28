Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E07F471
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668301; cv=none; b=oySY/lZAL86kVTvM1oCtCvSuAmk3VTu0bO45Dyu43ukP5CI5s/gqR3otZbnrl7sWSeDpS7r8mj3BQvsSa1rHkrH/eTQ72ANyzYwjY6WnnMAKwX4lk57DtRWK4i8NYeWukcUlcKyTgvGh/vAFLJrIqepVvRGLLcunPJ1lV6x0Akw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668301; c=relaxed/simple;
	bh=wXfg/+AxvkOnFrYF3BJt/cT/EGxwBVaS6XpJy/hWFFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4KuPZNzIiFAKv+q/KIQrV7ZM4d/KwwQmIEF9y1ZMRbRX8rrtPvYCe9KA8PZIfeSmhllZvSYNr0XjLgfKGaOcCcXrO1+Lf76kKcneYa8R4nO28BdgTxbRT674e/Pf6iAihAKKwT1IjZK6JBMFc4ZdsFwyGUKZee2lIz7xv9edrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fslp7Mww; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fslp7Mww"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cc5fdb0148so59237439f.3
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711668299; x=1712273099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qNXZWa7ff+gZO9/7qJdAv1MXiheIN0/3fR3ZzkSZyM=;
        b=Fslp7MwwrIxxIMJnOJTvA6zxB4REFHZxdCr3XoHBqqm7DH2VVCTOZWES3LC0T0NdMd
         UDjlyzUQcHrOmWC6v+KCIs7+JGgDRLoHSRSsLzDwWQ+XqjdfA/Ct5eY3TVJrycSiC9rw
         ZhcBF8Z8gXiE417zpi17qtvaVBdneGcQ3BfaLx31Ar8S/TqqrZVRKh4ikgDdgr1COqum
         ugD6FBHoRLtLN/vUoRdJhSsqBgp5SaGFqis1I4shN25SVMH8XLZ3DHdZKMJlxRSYzLeM
         YA08FETKMRCik3wPo83TqidqOu1L+I8+Ffc9WeX+lL9UM73+NLYvR0sgbKvTrPAplFnk
         7IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711668299; x=1712273099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qNXZWa7ff+gZO9/7qJdAv1MXiheIN0/3fR3ZzkSZyM=;
        b=LMmsna+H3YkV7sR6iYahpADJAvQCRpEUWAKd2VdQJIEqmGTN5CjJD0TkBzatSB+WZ6
         5vM1DRpxfPzCTmQO2Z96NK2hhscxaJ0OoP5PqgTrTBMjxrdIwZAmvTc2dqzhfR0lYyYT
         icseMid6nEUK0IYvmky4dipHug5Y6UGeRkDy2M7uSpSxo8Prgw5Vzbok6/dBWktsgs5y
         9MzbHN24aYlcudAvI6hQSFQHsapi28+GNbpnPQWKstZIeo2Z0BHjZQY5bhUV30SvjneN
         kOW6O+3mA3QmPs9mn4hyKdg11OZFQLM/1IKt7WMwQGynlnzhdS5WceyOFCRiSoaVHBIl
         RHkw==
X-Forwarded-Encrypted: i=1; AJvYcCVrsX2slMu5RU5bbB0YHaK71ZNRJYygI72pdQPUcvaPoIS1Xy6ZuWJbBn3dAbLG7ZvE7MgCjD58fG2144eBN1/ANoMKdLWDHHizoHs=
X-Gm-Message-State: AOJu0Ywp1D1hUq1tXpxIqhEr0n/IdGvG9oA1RKzs3sBef+PXzPp8E8by
	jseTUIxYdF3OW8weHPQGSQjJTRh00BefiW9UzXrkc7N66rUIvd3D4J3r54PagQ==
X-Google-Smtp-Source: AGHT+IH/359JmtRlhVfnHXRBxGMxdiBxsOXPtiJP+s9PFPDvBB1vfKbmbWpup/GqtPGDEEuv8/wGDQ==
X-Received: by 2002:a5d:8454:0:b0:7d0:807d:33dc with SMTP id w20-20020a5d8454000000b007d0807d33dcmr699533ior.15.1711668299282;
        Thu, 28 Mar 2024 16:24:59 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id x15-20020a6bda0f000000b007d06ef8020bsm669877iob.40.2024.03.28.16.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:24:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:24:56 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"Richard Russon (FlatCap)" <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/11] block/partitions/ldm: convert strncpy() to
 strscpy()
Message-ID: <a5vkpjykxex64vti4wvx7h64jthw7inc23uelol5s3beezoiuz@scl2uhf6pkl7>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-8-arnd@kernel.org>

Hi,

On Thu, Mar 28, 2024 at 03:04:51PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The strncpy() here can cause a non-terminated string, which older gcc
> versions such as gcc-9 warn about:
> 
> In function 'ldm_parse_tocblock',
>     inlined from 'ldm_validate_tocblocks' at block/partitions/ldm.c:386:7,
>     inlined from 'ldm_partition' at block/partitions/ldm.c:1457:7:
> block/partitions/ldm.c:134:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>   134 |  strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> block/partitions/ldm.c:145:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>   145 |  strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> New versions notice that the code is correct after all because of the
> following termination, but replacing the strncpy() with strscpy_pad()
> or strcpy() avoids the warning and simplifies the code at the same time.
> 
> Use the padding version here to keep the existing behavior, in case
> the code relies on not including uninitialized data.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!

This helps towards: https://github.com/KSPP/linux/issues/90

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  block/partitions/ldm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
> index 38e58960ae03..2bd42fedb907 100644
> --- a/block/partitions/ldm.c
> +++ b/block/partitions/ldm.c
> @@ -131,8 +131,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
>  		ldm_crit ("Cannot find TOCBLOCK, database may be corrupt.");
>  		return false;
>  	}
> -	strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
> -	toc->bitmap1_name[sizeof (toc->bitmap1_name) - 1] = 0;
> +	strscpy_pad(toc->bitmap1_name, data + 0x24, sizeof(toc->bitmap1_name));
>  	toc->bitmap1_start = get_unaligned_be64(data + 0x2E);
>  	toc->bitmap1_size  = get_unaligned_be64(data + 0x36);
>  
> @@ -142,8 +141,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
>  				TOC_BITMAP1, toc->bitmap1_name);
>  		return false;
>  	}
> -	strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
> -	toc->bitmap2_name[sizeof (toc->bitmap2_name) - 1] = 0;
> +	strscpy_pad(toc->bitmap2_name, data + 0x46, sizeof(toc->bitmap2_name));
>  	toc->bitmap2_start = get_unaligned_be64(data + 0x50);
>  	toc->bitmap2_size  = get_unaligned_be64(data + 0x58);
>  	if (strncmp (toc->bitmap2_name, TOC_BITMAP2,
> -- 
> 2.39.2
> 

Thanks
Justin
