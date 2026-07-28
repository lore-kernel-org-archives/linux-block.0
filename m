Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78052F25F3
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206865; cv=pass; b=tFQvs4tetbH+MHh3GytOBCjEK8PJUFOfrGPGMal/n8NZ2m9f54DbSht+JVgcJXCPddpgHWXuWdk0/GpFgj4SG/8uxjflQRTUVX+6ufMmhVC6QvdypbBGmwPNi3ld6926O4WDCL3piI2R6fsP7QcO4B3DVtS7jaNkKlyqz0ViNb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206865; c=relaxed/simple;
	bh=0S6LZzWblhk9cBc+1RzRJZvyWZWMFxKZQyPBnlnlXMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6ZNwTW8ukCaG8ylXgbXBkho6qR2Z+oxECo9xD2crYBGwG44me2k3KBUCD9GP6Os1n10XvTbdUAUF1gHQtfuQijk9DEBF0Shvfd+I/tuxa3TCXTAEAewBp6lMhe9kzD1dlyUxhvDjlzOaY24YB0Jl3I1wLGaoLfjcPs3FAp6fGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNHKmtVg; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNHKmtVg"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4583b1703d3so581854fac.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 19:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785206862; cv=none;
        d=google.com; s=arc-20260327;
        b=lT/x5c9ZjeSEr0VwOgE1bo71URjYGwCjPSWrS/26QP7C6ub+nFg6l6FgK0R48/JvYe
         nF/tcAlcQG/dNr3Oy1dJ8mxFQugFNDaxbhjdDTjVzOIcTJ67vYF70wqrIic/XQDDJLhJ
         OCzzU/QhSks22Ij2BCecbLBqG25pnu4J8xUVTYre3hmsLo63r+mX8WP2HC9vNgoSJJqK
         7tOcoIpOnj5Bf/wVtq9Jk0QzZZ2EV0pqhH0zcbB++r/4NUEiNsryt+xxV06yPzo2y4ru
         N8vNQc4WT7+BUQY3Ka+Lvet2sOEMyKKmqjXkaBBrBIGjn1cEAtdCUhCjYBLls7FqGw5S
         i4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i7boabVg6sBibLwOJmy91FtsLB8zy1zkhkDJExToXIw=;
        fh=h3o+7K0vZ95+fUfYrpharBiwsh0DNOmPYnDCb1e/kmc=;
        b=p9XJb1B75EmfBt7fnCtkbqKC/EhKs5RqX+yJMWRzHoabg9FuIZpIBhJK0KEylexkTv
         J6ogHasXSWU3CsgYqSjjhInpGQyWZyieYC1zH634QCy51/PUQUUimW7JeJwWX4w234Ug
         HPgCVhWZEvhvE7DLqatim2Fxph/6XGFhbli+AYz8pJpH8Un27c1F1CyvwfuHUwLccWk9
         5gsPCzjm4chS4JNYojKoi7scWJw1T4IZl1AjZvDrXRRI/vyhKjH8ancGlG64OVip0tia
         mIDk/ucARTXLbfd8WZfEb44XyRiYl4dM3yoJkkLjjLHmcEEuyfpizwnl+I/kn0MBlXwC
         F98Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785206862; x=1785811662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i7boabVg6sBibLwOJmy91FtsLB8zy1zkhkDJExToXIw=;
        b=JNHKmtVgWgId3lVLvTX/SsOnmzG1yM2e2nlkrzUtKdg1h4xyhgiD0n8Iqih3731SQa
         hbAQ14nVH08+ln7u75FHoe1JhmyObMhpXFaLO7FzgkTIYqmfy4hldgL3R84kusXXSLmT
         abu2SewcS9j4LIN5ZBI9kksC4X5q4Tblv/mxHXe/f18cXSKyLu1aCyc7NgxILgSd1Ks2
         obODfFJ0Ond7XZwHTy7EDepO/8coMqvUEqTPDsEDYhkmfrhR700VoTMhM6TwU4qSiDrq
         /+tl9uoHgtad9H+jEH9wQVEcGCxCSMr5LS0fvlUeamV9Zb0r9LaHflFcWzrunF+NpgQb
         afoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785206862; x=1785811662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7boabVg6sBibLwOJmy91FtsLB8zy1zkhkDJExToXIw=;
        b=dZczTe3n4r05i9HTRkzDpPvDQhKDnBwl4V17IJBnWFv6blmOtRyvQwi7SmG9GaEi/I
         +60gFjVy0pv5MysQZIwOs0237DK2D//dPsbgmtnTWOl0ekPuwQjaWT5K/r+8arCJNio7
         76ZkWuH6v0Q9MOa3xAMBc3dziOxDGJ9FrEempWeou1wL/EA2Qf/VjjDHRby+koQmAyBF
         UZSzzuv1vAmo6o4TB/jzy3YARzw5sCrL+SJdv5QgsTNtPYSfJTIKvPT84142M1cPhBRZ
         lMLy09PlG+We83Z3Ew2VgeKfTBNVS7azH67Q6SVgEAfS7HGHA5w5mcUhS1UDIELHY4Zv
         hheQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsECSrD1PX608YDG1gbDvP60ntdRCe57Uwy91PJBsDdFx19G0wuRu0aBZhkctVoWejG0iAMN4nxZREyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XhzRezAfCyidQmgA0eM4SH57CLxnQ1wT5nM5G7BvlY/Wh3Xv
	usy2EAA2fvu1bK85IOhFKZSkoI4pZ9LkgMvg3qsxzxMDz08Bo9qCYbFstoneXvMfunlMXEYMFWF
	IdZDbbGAYQFo0iEEGSV0jzPAujHX23ZU=
X-Gm-Gg: AR+sD11YETmpmu0IIQKd066jd1aUEovVbXLBqxSqtOAkKyyH2KK4r/CENNGZveftFnM
	3SONpbb3YUvtLyq5irM7fR9q9YwNucU+Wnpb3EViJZpCXeTDHqDzRXuAMyRvC4yWnfW4saRQvXJ
	sDLVeBrQ2vwlRsv3p0UbOtTIqVxNUo6YBCrjL7ufwJ9h05esdDsQgE4ck468xVI0uLf9ZXimleT
	w2JBnp+3njTDnd/Vu0c1c2wjESPKCX7rEelv55f3E6GVazzeWSsI8+94Am5552d4xpYcWSOUzKO
	VCCIygoiKJCx3ENEpe1VywqwIyw5Ao8KXxMlZZDRdufw82+GOgS9Q0h9fBHcmw==
X-Received: by 2002:a05:6871:b22:b0:456:f7a5:384c with SMTP id
 586e51a60fabf-4586cf02eccmr340830fac.25.1785206862543; Mon, 27 Jul 2026
 19:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727162450.2921500-1-csander@purestorage.com>
In-Reply-To: <20260727162450.2921500-1-csander@purestorage.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 27 Jul 2026 21:47:31 -0500
X-Gm-Features: AUfX_myI3bbtqvS-Pb1eBONxxQzAWhnKQ5EdmbLtbDVEliZndPVY3tNVzBBD6dk
Message-ID: <CACVXFVOaA_k+TCmeyrjguW5StdDb=zQsTCXWMBQ7QiNX1wuDzA@mail.gmail.com>
Subject: Re: [PATCH] ublk: remove WARN_ON_ONCE() in ublk_unmap_io()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 11:24=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> io->res is set from struct ublksrv_io_cmd's result field, which is
> controlled by the ublk server process, without any validation. It's thus
> possible for userspace to trigger the io->res > rq_bytes warning.
> ublk_copy_user_pages() already limits the copy length to the request
> data length, so drop the warning.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4ca6ec738c93..4f30644756df 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1492,12 +1492,10 @@ static unsigned int ublk_unmap_io(bool need_map,
>
>         if (ublk_need_unmap_req(req)) {
>                 struct iov_iter iter;
>                 const int dir =3D ITER_SOURCE;
>
> -               WARN_ON_ONCE(io->res > rq_bytes);
> -
>                 import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, =
&iter);
>                 return ublk_copy_user_pages(req, 0, &iter, dir);
>         }
>         return rq_bytes;

The change may be fine, however access_ok() still can fail from import_ubuf=
(),
so can we consolidate ublk_unmap_io() a bit?


Thanks,
Ming Lei
