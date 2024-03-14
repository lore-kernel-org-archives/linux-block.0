Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239E175A1
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459315; cv=none; b=l/toagJqOUS68TYT23zq2cdeU1Qt7fq8YzB7DYGJHv4RSvUcHLCvwqeBwZGlzQ2aWpC3DQyydjD7N113xE96bwVyvhoOQOnWwXgCIg38zSD1fo7JswhD/iSxAVbniDNIRfwH8vNwhDKbEtJX/ufTGAH2reAigL762dz83uyAa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459315; c=relaxed/simple;
	bh=O1Pff7eAihB48Bz8XaabnNfcFgNRo7LQ5mqmWeDX7ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkc01p1sCt7fJ5UJP7hCcDV1E/3rn62P/wgDgkhTzuA/Ka6i8n2wZKGmqrrevFQwmPJP/BX/Xz3PgcfoEwyCqfvF7cAp6LCIT5cKIqiRaA/weg5p/xqvNO1X22SnNIYCu49CnO67FkIQhS1Pj5SvHy2OZQZuweoTz052fbC75O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niDgSi84; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niDgSi84"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dddbeac9f9so11118965ad.3
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710459313; x=1711064113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6Xw2waQfNCPf/M5RAIMX7gnuEX08ICVGrEBe0UGAx0=;
        b=niDgSi84WUb0I+gFj0Ymx1udyjPwWBViN1p4EIUeRiM9W83xOU3vconegwNN//rFh+
         2MKRbnWswmVrXtcQJlWDacN1MZV35tMm/OnS0MGFyzYdNkeI/Zv3yEDXbIjRv5KzldBs
         rZjCMQAr9I3BiztAac+v2oxwKtbNatuRPgGRoSAjyyTPVxOXYTZiftw9Hy/ZSbwYeLa7
         0ol/f278i7IoZsaGciEizZ3G99SHrkbr83gDlguUqh5Z6CzmmrTBLY6wzfSlbGJvVTpv
         OoMOvspzTryReh2rcTTpI6XZbJz1ReND5KNwiQqILWnSdvEQ+u56U9Lk4FZ/BHXyPfxl
         GcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710459313; x=1711064113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Xw2waQfNCPf/M5RAIMX7gnuEX08ICVGrEBe0UGAx0=;
        b=DpWw3JdaQiusPpYrBpG9XMt7psnujx/NTFtznnb7e2v7p2EkGEKBx4Jf81SyJUt1aH
         zXwPJaKG/IU3NX5wFyj+dGpcSUiF7qyb922edRWGzkxB8OA6XYQyNwLtg3VA7nreGw11
         +vrnDKXdUjwpySRQyRXCKXQFeaEIUR7EYBIlVVDrjNcF6NqqGPrBh4OUSne1qbkqv+5X
         Bv7OmE+dxcktmcZMjN2wwdZ2B3IRzFeHYjg3UWoPz0WGQgcSAdRS7QgqAEThEd6e423O
         fuPvWxHu6vhRJxXONh+qaC29eY4WpSh76z5Nvu/Zv60GEo4CBlsVBntdD6HOLEBhBiwJ
         1LnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGYyBBT0QUcF/xuuyeTqyXLbH5gujtuRQmzW55dpVThpA5xLH5XE0doWUVQNLLU2UGEjm2/5v4RYIIeqZ0yA45DvPk6wcGMwYj0mE=
X-Gm-Message-State: AOJu0Yyr7TOE+XKVf6diAPd+0JdVXbRA9TH7GJNkkqg9G5Zdnzi+Zql5
	jncrW7E1RS/dMd9ssHfKzUwBh8POoD45tsNZ1zYSYgowvAMAJRjt
X-Google-Smtp-Source: AGHT+IFu17ZuKR7DK43CijnrmYB1eppOiMpA8+39kWpLCxZM8OpG8tgYl+e7xkSytpOsl3aA211JyA==
X-Received: by 2002:a17:903:32c1:b0:1de:c6d:ce1e with SMTP id i1-20020a17090332c100b001de0c6dce1emr4032164plr.50.1710459313262;
        Thu, 14 Mar 2024 16:35:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b001deeac592absm509322pls.180.2024.03.14.16.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 16:35:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 14 Mar 2024 16:35:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matthew Sakai <msakai@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 02/39] dm vdo: add the MurmurHash3 fast hashing
 algorithm
Message-ID: <ea57f231-f78e-4a55-bf85-c5d50e17237e@roeck-us.net>
References: <20231026214136.1067410-1-msakai@redhat.com>
 <20231026214136.1067410-3-msakai@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026214136.1067410-3-msakai@redhat.com>

On Thu, Oct 26, 2023 at 05:40:59PM -0400, Matthew Sakai wrote:
> MurmurHash3 is a fast, non-cryptographic, 128-bit hash. It was originally
> written by Austin Appleby and placed in the public domain. This version has
> been modified to produce the same result on both big endian and little
> endian processors, making it suitable for use in portable persistent data.
> 
> Co-developed-by: J. corwin Coburn <corwin@hurlbutnet.net>
> Signed-off-by: J. corwin Coburn <corwin@hurlbutnet.net>
> Co-developed-by: Ken Raeburn <raeburn@redhat.com>
> Signed-off-by: Ken Raeburn <raeburn@redhat.com>
> Co-developed-by: John Wiele <jwiele@redhat.com>
> Signed-off-by: John Wiele <jwiele@redhat.com>
> Signed-off-by: Matthew Sakai <msakai@redhat.com>
> ---
[ ... ]
> +
> +#define ROTL64(x, y) rotl64(x, y)
> +static __always_inline u64 getblock64(const u64 *p, int i)
> +{
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +	return p[i];
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +	return __builtin_bswap64(p[i]);
> +#else
> +#error "can't figure out byte order"
> +#endif
> +}
> +
> +static __always_inline void putblock64(u64 *p, int i, u64 value)
> +{
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +	p[i] = value;
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +	p[i] = __builtin_bswap64(value);
> +#else
> +#error "can't figure out byte order"
> +#endif
> +}

On sparc64, with gcc 11.4, the above code results in:

ERROR: modpost: "__bswapdi2" [drivers/md/dm-vdo/dm-vdo.ko] undefined!

Guenter
