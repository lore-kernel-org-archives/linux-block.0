Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411028D836
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995795; cv=none; b=FhPbpgpi/wI9v1am25lPS2nqs9SaPeU1tCEVosclOrgVhg6L4NcTE3eVZiatT/ToE49ZobONFT6oNL5zhOCwQapP+BUAtwZrCaHeS1igTPL23EvBJYAu5kO/F1T/djn4ZOqTMFYaPLoiuAwoJahUzgKSxyLq1FLwTY/V/EYLnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995795; c=relaxed/simple;
	bh=8sDoZPAMi7HGUy5LpZYG2e2/6rVudExsA4rLja4mlHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIReHJVoo8LAdjOv1N14KJtkIGva8Gf3pZhtzIA6pdC5oH6e0Y1nizIlqBOITa0+mKxFsOTwUCraNIJuT10fEFztm99tCcTf9uGJSlFRrXwPayQGtHGZ/q+gknRQM/rkDPjPhFU4SQJgQyJpzIIek4atfHE5zaqDvWfypSOaFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mg9ThfLh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mg9ThfLh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29852dafa7dso332195ad.1
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763995793; x=1764600593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfjvFTqZVsCNRnOOfiQNCDtSe9mdhB80/mf1pjQQ4eE=;
        b=mg9ThfLh/kwMpCrqCyUJ9MSGKUlmjY5ELAMLantD+kGGRVVCDHtIKEJ1N3IiY1rNZ7
         o0xh5NXymiarODGMTWzImYiepJljD4rY3A0bgZDU/s8mJAM1hR1Rki0mozeH5O7TfBjW
         6a8cFTn21FDX3ZajXl6mWN+Q2EO4S63+5thLjFZpFHMcMiT4a/sgQk1HRDT959fsI2Kv
         vV/aoY7z8LKjIKNBoXqD0qiegyVnsvxx9YG57C78X6iyfQIqhi4MuYsYUsZWuHmFJjsZ
         ic9a3UIo6qjRQO6udPIo2f4r6uccJvPkfugcyYmZQr2ySbKCoUl91WriAZf3bJXlA0W2
         HyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763995793; x=1764600593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfjvFTqZVsCNRnOOfiQNCDtSe9mdhB80/mf1pjQQ4eE=;
        b=EA+ieIG0oEPTLFUBGYZFGS//2feUn+wDs2FDGqUVoOiHPVJi9NBPtW/VdGlltiygx+
         NmB47zLew/D8sIKgIQB67SCla5vt2IjSDaQhRqVubXEu6JByb3f6FvDZ1Drhx6jNMLQu
         SHH8Qwc3zK2cwxxvbZXuSBMaAx/LmOBRk+r8r9KxITJpyrwtyuKgrt1PmoNGv2a0hzdy
         pCLxl+IdueOnKxYbxNe1zSoH0K7HchkP+Nn/Bgzkf9sMNu1X5IaS3/d2x9AVeT56266X
         75LhkGWcNkat+XFVUt2vNjsBEJPuugREE/+RMvLFymgWrjN/DGHDMr9X3lLaGavVj0uc
         OAHA==
X-Forwarded-Encrypted: i=1; AJvYcCWjHHHopB80A704tDB4OjityAvpmBH7PptNZ90+FpTN13FJSuHAnurzj9OO35j769dYo3y8yUlH0v3dEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VsrxIVzCdnoa7YXy6ewqzn2Xd7tUm0ze3PB7u8OlrI2nK/37
	p+wbBWLX2nfCZ+RZuAd7kL7aMpR5AcPfX+HHQSgVdTf4vBUDrkuF8bvkFonoEZFNWCZoBJIJsve
	YZs6OayTFbiqRJjNQ4HLC0sjHiqxaGN7LA6CJFPdZ
X-Gm-Gg: ASbGnctJoODLPRwj8CWzqJRr72cz2JWS/ThbCxIgfizA7t8q3QlJX/CO/B8M6cYH+7S
	u3W6XzbADjFgy5IJUqe2swlzNCqdQTEk37v5fT0S5b3qUb3sJLJSUvjjO1819knMdtzCOkFlFBi
	a4xtxHpzwvly97+vjgpCiXR8kuavSU+KpofKLNXFm6l66iderht/aceYZg75xRxlHFxoaQxEPiH
	TLXVj5DHcyFnRyAxb8VgnjhkwMrlrS6Zw/cq+4DWWQdUwM9klCKoQBGKZ4v0Yf6oGbOsfxnDNAn
	Me131V4ayyRjyrerj1SQ7hjjxsEjWGJrER+7Zr/m/6rDBoCHmsZb5j0=
X-Google-Smtp-Source: AGHT+IGRulCupwdJmFvYrXnXeObGMVRuegK6S63semZ187VZIMLLUPpXt4Cfo7EegvfgpRWvfboPuLskdmqfhkmc6Nc=
X-Received: by 2002:a17:903:1a83:b0:290:be4a:40d2 with SMTP id
 d9443c01a7336-29b7b3ce4abmr3467985ad.13.1763995792590; Mon, 24 Nov 2025
 06:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152126.3126298-1-senozhatsky@chromium.org> <20251120152126.3126298-7-senozhatsky@chromium.org>
In-Reply-To: <20251120152126.3126298-7-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 24 Nov 2025 09:49:15 -0500
X-Gm-Features: AWmQ_blpQ0OcMlCrWbn5wsAoRlcnctjr4RkBtD0LFzY37dS1vA_aR_W8k-0e0sw
Message-ID: <CADyq12xiQT+B4rUnWAgCVs1ULeJyYduOu0JVzNPuguu=5RmVpA@mail.gmail.com>
Subject: Re: [RFC PATCHv5 6/6] zram: read slot block idx under slot lock
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:22=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Read slot's block id under slot-lock.  We release the
> slot-lock for bdev read so, technically, slot still can
> get freed in the meantime, but at least we will read
> bdev block (page) that holds previous know slot data,
> not from slot->handle bdev block, which can be anything
> at that point.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

After taking another look I think this is a worthwhile improvement.

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index ecbd9b25dfed..1f2867cd587e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1994,14 +1994,14 @@ static int zram_read_page(struct zram *zram, stru=
ct page *page, u32 index,
>                 ret =3D zram_read_from_zspool(zram, page, index);
>                 zram_slot_unlock(zram, index);
>         } else {
> +               unsigned long blk_idx =3D zram_get_handle(zram, index);
> +
>                 /*
>                  * The slot should be unlocked before reading from the ba=
cking
>                  * device.
>                  */
>                 zram_slot_unlock(zram, index);
> -
> -               ret =3D read_from_bdev(zram, page, zram_get_handle(zram, =
index),
> -                                    parent);
> +               ret =3D read_from_bdev(zram, page, blk_idx, parent);
>         }
>
>         /* Should NEVER happen. Return bio error if it does. */
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
