Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028AD2931CB
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519066; cv=pass; b=OXL61LMV2HbX5NLsDZAVHdwQ/iPRBbXrkZJqxUno3oAmoFqpphaKg3UScJ1xD5lPxM9hNTtvLDezjfyKFQXXZXR4MVV781hAs3QoeDhTOSesnAuzDsC60PXiM8YqT3j3MfrQwkR2MEx/okaiTZYUWVvxtTFYo1zGUI1T4W8SKiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519066; c=relaxed/simple;
	bh=lyc02VtQIZxhw/NaQxlFiomk5M1MRIsJ/0DiRUUBSzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuCsPao8+lEAXwNGHT4AzVBWcUBs1dxs4V7ZU5VVPoA8+aEnxGY7ysIb0JCK8z868xp5UToL/vV0Ta6JcxMCTa7G/O/RV+JElhTEKpTG5JAtcasLNNsfs1m86hZ8awuZ+CRQlx2Eb7AKaKe8ALLxxBMyw96JIPhqG3V8h1efzbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH9u2seC; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH9u2seC"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a368895so251139b6e.3
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 17:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789519063; cv=none;
        d=google.com; s=arc-20260327;
        b=fomsHtpTOzmhokHT0ZCsvsXnc4NFQF9det+olEwyrNCTw4DoFzPsMCkFLdEuzz2aJS
         9dWZ1hb/gaWHDTut8M5pwc0LIwdO+D5kcfgR5fMu/JrKHzX/0XIabS3ar05o1Cz1KvCX
         P8f1Hjcev0SCBgW2LyS2pRej8fI7Neo+NGKHiJzcRibh0NzxuPOiSWvfDNByu2HI6EKq
         byYZkP/k193HYByAphFCcENQVH5ZA1WwcyXNapGy078VbfjObR6QNMNJbln/N6wnkdFv
         /9YVvTnCgiKFYS55gben32Hva2h9ZvNit5DwATaGaeaHaKESAULmn6AmszMZio5DxuSr
         z9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DWeROdCeteC+h1bv3zClbfu9jEolgnytmK08OqnLrD4=;
        fh=25mFMSRqiK0cyjj/AUiwSoA0xabx/5VvVRa2GvPQzFI=;
        b=p/pYUt5uIW6RqU/ngtDlfM4fG+2Yk8f2Pcsbk8gwcXx9Bs0iLtFoOiykC2A9M/CGny
         I1ztdceY2zqhO2zrkspsg4oDifM9mbTBFNIPUTi0LbHgRugwm/ddgdzIN3ZbgrDqX14S
         zBNCHlv1udjsAADY5Y5Hq+30PQdg+s3ZDhYDLG1s0p5Xr2XT5EOj75mhfS8ha9AXQMNz
         8BDMV/bHQVKUO1hxD25ba96ULrcfszxd93+Nu71nIQFArs6EORn67Isk4f5aoGboJFZZ
         P7EB1r1SedsXSB7B6HftuaXS8sZvTBDrGZExxf681dOsbdf2awALzMLoD8af2ZB3WEoZ
         QcxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789519063; x=1790123863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWeROdCeteC+h1bv3zClbfu9jEolgnytmK08OqnLrD4=;
        b=lH9u2seCno1Pu6lfoz0hNUo9rocBd2SKeqrIpiV9yF8XKajrD7l5Qj2zHH61/c1H8E
         tb7WqJJ87Iwwd07f+zMB0DYvPhsS2A9gT06KU/ZF57XnQRu8NIYEvmLKN6h9JJe/aN11
         dhtN28MtoLyX9n/ojEgT+9CACwK/O71bZYRxtEhbsGddaHzKBgnUWwhkOJzK3lgnDDtO
         zn+WNPGved0U32aaFGe7Ewm3AtUCc6ZQaEvJEERZ+6A13zGY4j572jqDDD6H8zXy9EA4
         u2OTZhI8frBYy8nQyYWrLOAwhRfpEX1Zwwarkg11BHrNan6g4LO6jjb9kpjG3mluSwyQ
         wZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789519063; x=1790123863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWeROdCeteC+h1bv3zClbfu9jEolgnytmK08OqnLrD4=;
        b=fzF1Lz3Tvh06KkQsfaIzpLItb8048kIsEhTqYEy/Wm4iE875nLjlFPcUnAJXQt+HCf
         QX4EDxt0XT8o7HlD7jD+sSOwQ+V13XmBKSCWdbiQGl5E/Kscwmn6PBOy6dJ1qGsxs7EP
         IiDBbry9xr0bL/2omQNPJ8yRiy18Kw03nBxO/fuhqpeorL++WqMKBUpOENEe6r0NYEMG
         qmcNObI1vMIfkmi6HfWqVoKMG178lds+HgBWa8IMz4MePtmnI6CNoueHu06iW+l3jKuc
         nmt/xNIUoYDJ6vDnbuaPzopBUbj+giKngXFV9c6TZkpayfnUyUowetvpiDgoC+1YeM6m
         nb8g==
X-Forwarded-Encrypted: i=1; AKwUvBz8oqXzj1hhubIpWVKtuaKDHpdOcX8pAj4W//Zwiu7uR+l9htXtN/j899EZbQDbmFG2Unn0zk9xa85Arg==@vger.kernel.org
X-Gm-Message-State: AFuF++l/VbCfaD2VXDIrVWwbNWh4btjQ5p9dNLqrGTwfyxMGl6Q1RK4w
	m0Q9ltxwVu1zxpUi3q+FldaOPH+dHNf/fvxwR+24QnzqIXe1vyG4bFVp4zr0ybIk6+WnUKNvhws
	qvq5xx5sGgFYwsfxXR1DSzXrsLLLFvx4=
X-Gm-Gg: AYBFou18YalsH7HVMPuDEccDS2Rlyxz7Y/1RZot7gVbaykpCDrsFeCFVhO+kJZVtuU3
	ovTmudmsQAhW6lxBE20mcDB7/YLiMJk/tmDKWVtguVikcrsKbou2t0LtW2uPHQkXtBM+3regHjH
	tdk8wjsMGBctODfweh9h7OLFGPryWRjN/WppXvC08+Ml2I4pwY28xM2lOsLC9zy9kGjWFi8XDgz
	W5mbKgOkMzeEtO2dFHKDx1pHUhc3RTHJil3vUsSSLhcPkN9CA9Ef+EJSkceVSsbZsbuYh7Y0SOT
	pDsQVr95TU8MQo39LcLPCWFukBgj1X35cAsQHcmh3W3BtEyLrp4+Ue4eYKZ63SBfPtihxY7D74r
	V4gXaRkiyf2sdAI7nm+zxGWwS7ex1/vo4u8IGF7Mqycz/qFrmIhHLlpw=
X-Received: by 2002:a05:6808:1782:b0:4b9:a8ac:47e with SMTP id
 5614622812f47-4ca4c283485mr938132b6e.28.1789519062807; Tue, 15 Sep 2026
 17:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915200107.3522560-1-arnd@kernel.org>
In-Reply-To: <20260915200107.3522560-1-arnd@kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 15 Sep 2026 19:37:30 -0500
X-Gm-Features: AcwNN1WN6n5VaFsDoH3kCwWcr9SYOgDUJLo2q6b2SsGwG9_bgzJWczNA720qB7k
Message-ID: <CACVXFVMBZemmYjFYYo-E7mij6R6aqNbQ2iAQiZ+P6rqhKxUQsQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: reduce stack usage in __ublk_shmem_remove_ranges
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, 
	Caleb Sander Mateos <csander@purestorage.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:01=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The array in __ublk_shmem_remove_ranges() is one kilobyte long,
> which is really too much for an on-stack allocation, as can be
> seen with a frame warning limit of 1.25kb that otherwise produces
> a clean build on my test system:
>
> drivers/block/ublk_drv.c: In function '__ublk_shmem_remove_ranges':
> drivers/block/ublk_drv.c:5573:1: error: the frame size of 1392 bytes is l=
arger than 1280 bytes [-Werror=3Dframe-larger-than=3D]
>
> Maybe half the size is good enough here, so try 32 entries.
> If 64 entries are really required, the array could be dynamically
> allocated, but that would risk an allocation failure.
>
> Fixes: 309e02dccf64 ("ublk: avoid unpinning pages under maple tree spinlo=
ck")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I have really no idea if the 64 number was significant or just chosen
> to fit within usual stack frames.
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e7162e..6fe85aba32ce 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5531,7 +5531,7 @@ static void ublk_unpin_range_pages(unsigned long ba=
se_pfn,
>   *
>   * Returns true if the tree walk completed, false if more ranges remain.
>   */
> -#define UBLK_REMOVE_BATCH      64
> +#define UBLK_REMOVE_BATCH      32

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
