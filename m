Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6337BE97
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705160; cv=pass; b=h1yMglld2fc3PyenB1Vjh77VxrERz6EZTndrNK5OVAJ2dF7o0sGCt9Xmty3rcPl1VjhxMZzh4QE+BS9BoZVDGYDNCdAB5kPl2wOoH6EiZpQRLII1SIdpGWfSoHhw82+XhYT9Nc5359PvT2G2W2o0JIxNAwbI15svLhgDuEUibdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705160; c=relaxed/simple;
	bh=MHrfbGTX7SnnaJt3XzfDILmJLUtBzYOKnTYQ2e1z3NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVRttiie9VaB9Z1fh+5sQJYNfuSOM9rca7yb2HTVaaQ0lZay65sqGiawXMSHirciRhqBDz/y1v4iPkNx5p2aPqITc6j1Ef7ADFApkFltUyblQpOb11FgHV9fLySsaf5o5t/PeXz2eGcaax0NBx+d3wmF0xPRiSAH5pLvAVysgBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MumMBsKq; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MumMBsKq"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-505d3baf1a7so304741cf.1
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 02:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772705158; cv=none;
        d=google.com; s=arc-20240605;
        b=Pye6aEgSAGX5OhnDsIr8khMVGtXC1IMopkVDwEqb/wE/5I6wgR4J3cy8FZhn3H4RI0
         bKX4Yv2KoKcwlqy/ox87PfVlWatyEMR+pMd6aXrC0d/OI9frO5zdFOqjnEUkcmLMtCLA
         fUKcLdC1llU+G7LUWkCPCBX7Oqh6g5dmBOtV+kVW52jN2vXFn12ziTm94Yyn2aa2R23N
         joNq/Fh04A6aObGpNPlbIgVeO07A70OTeTNp1UYIXRGPyv7WiEaxPkxJqOfgz14cAmaY
         KJSoT+l6aWJVN+EKfmEFkUzSToUBmHjTf2baBSd1HgsrnEqqo1Hq1H/9MnIKChpBilso
         ygmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+g41L0ssohQDj8n8fJ6tCf5S39BQY8N7v69ggSq4hs=;
        fh=c9gEW2f4u1do76E06CYPJjFBkHHAiA3lcg1mDS0hJTk=;
        b=JLWy5BH/2JLsI74Vu6MyMVHKM9RzasH9AY23ce4iXMl2Cmqa6MRX4ryb6SuXRxNW5h
         VkSlVpdH26/TO+LZdCxbCdGdJhf2QMQ7jV3eVjCVLEdwiZh3XAXZ6q6E5GXVjCHw2tVv
         jPlcZ/ZHgoBBaYqUOXgG4YK9sTVQ7M369lhyfanyK0mdsE07zng+zYBChEaeKUdBDrOS
         YssQtgpT3g0kRcPG+NwLWvvGrvplRdyQoP4cuMzwXAY8x/pvL5RjI2ls8FOq2c6v3wzR
         iXqT/4CTlzWpmfPCl4rabvlqwcE0Q8W6/Jm3mC/yyQbg6QgaTF8MxHnv7qKZyKtD9qev
         yLtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772705158; x=1773309958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+g41L0ssohQDj8n8fJ6tCf5S39BQY8N7v69ggSq4hs=;
        b=MumMBsKqAMseMr4IpSxzgM2V+PLDPamKCd8iGjWd3tc2FoOkoc7ce8GOvACgz4CuOt
         cYpGQQFMa66SsopaEJg37foPT6c/s6Iytq8Khx97eBhjTKUbLPFXic83UJgEusMl/xDi
         U9SxCrM07CBjixVKMtrsf21XuLPXBGUfvKTTVdsEgy+uyhd7sM8+zvmaJmTyQjM1jNrJ
         lCXDHwQhXIwwBt9kG8YlAWx2lcl6BvbSPD1MPMz0A8r76rUxrhvd4SN4rOFejEDMBxV7
         F37QZe94WUV1/GTq0ZVVPkgFZlNpZBUknsjBoILTi2pe5d+60ah5hLwhvNBbw/PF27EY
         pIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705158; x=1773309958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+g41L0ssohQDj8n8fJ6tCf5S39BQY8N7v69ggSq4hs=;
        b=BnsFiWRlqugIG6AVSGTZk++5w5S3T+UdZHznNcHQA/52dMvrsfxlHz4egAwOr0ZWjN
         pyIlLM6GNoEsOkeh1jHmEfOjPEr/xojJWe/vUra3RMRSDKCG4MwUl2l6zTkniSGMDXfG
         AWoAWBMjxqLZ8brjaC9u+agECdVxV5bOLXYDun8Vq9IAe3jlqGBd/LH2DG0ulQoW4h5p
         hf0C8KJtKdgyHV/Y02ccXvj7cyPCjzEMebXXFvHsTf0jPfkS3qpuALXv2ubOGeJxbQzi
         bM1ls+3ERJoemToiM8LANKy7zbkUV1+Jl66pykeF8bWnmit+yBjI8CnMeKX9wVM7IcfM
         dVig==
X-Forwarded-Encrypted: i=1; AJvYcCW2DQQXWUjlW9exwRcNANcq9wXE0cKthaeIR7FPlHaSsa51aiWyRf9hdXPvgDOlF2gg95MwSaQqSERgLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VYip4+VRhBHAJXjLH8157DvjgypKfwYxoTVVVb1NEdEl9i6+
	Pj+Ed5noy+nNwqzMUn9NpkePEZlRbOe85LWUy0qAKv5DuH5kzctlBhzMCp/scURnlbKLSHhW+/c
	0ldWs6+MEP5yVIge/9mus1K06LA9X7d2zhxQ4mzSc
X-Gm-Gg: ATEYQzz0+YKRSXMx+5Rqdaa1fCAWV5lxVMDmG5pQ2+vi+K9klx4kv97td2lRdE/ICpP
	+rjlqNVDBn3JGU7tqK/D1fPXg/K4TCjuWnK6qG0hmka1VqQMVpErciPeFFGGGvM+GjBg1m8CV2c
	5Iiqi2WtJXbct0za4IZoACwO8GDdmkrVUmjeNoRTns5QDUDgjWIDCAZWjOWqgkpTjdBvxzppypp
	zYbXc3dsnvK12cdamvmw0PyESuj5LrSqUNgyuyv6NRa61JVl4bQn6q9yZBmPooY8EOOzPXJx6IU
	/oJ7hjnrl4iVQBm6qqTj9SusjDHA35uS9rlcTcS0P+wnOmJS3jKmHotVQvnlFAzKIb/cDvR9yq1
	sHPn8krihex3BxjLfoYF2DPUxLfhQZod6NUl+c3gTMNYQ2/TOJefKvNMVpQ==
X-Received: by 2002:a05:622a:1991:b0:507:35b2:6b9 with SMTP id
 d75a77b69052e-508e789aec2mr6977561cf.7.1772705157664; Thu, 05 Mar 2026
 02:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305021619.617481-1-senozhatsky@chromium.org>
In-Reply-To: <20260305021619.617481-1-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 5 Mar 2026 02:05:19 -0800
X-Gm-Features: AaiRm51mCLv4tspe-LWl4ePlymzT_ZYJEBCBG4LmtBoD7ujo4U4hnyv72lvhXA0
Message-ID: <CADyq12y1r9G9WZd0ODY1OhhHMzjELQeqp5nORc2rVMsbKXfMBQ@mail.gmail.com>
Subject: Re: [PATCH] zram: use GFP_KERNEL for post-processing slot allocation
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:16=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Post-processing slot allocation used to be performed under
> slot bit-lock, so gfp was restricted, then we switched to
> a sleepable slot lock but gpf still remained restricted.
> Drop that restriction and use GFP_KERNEL instead.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Brian Geffon <bgeffon@google.com>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index fa38d26119ec..6a6fd08a5a15 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -297,7 +297,7 @@ static bool place_pp_slot(struct zram *zram, struct z=
ram_pp_ctl *ctl,
>         struct zram_pp_slot *pps;
>         u32 bid;
>
> -       pps =3D kmalloc_obj(*pps, GFP_NOIO | __GFP_NOWARN);
> +       pps =3D kmalloc_obj(*pps, GFP_KERNEL | __GFP_NOWARN);
>         if (!pps)
>                 return false;
>
> --
> 2.53.0.473.g4a7958ca14-goog
>
