Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4E3AB287
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314961; cv=pass; b=mMvfQLtXXmIONXPx349Yg52nxez3epG96RCLKms7d9chl8w1ktaQIWfuk7FOY1JOfQMZ2q8bu0HYS8u58dR3gEHMLvSl7J/bKTLfhl/v3Mm1S5x5++lbwKvLzGJB8v38ol2DAt1HWPboaiGoSV9ehxmj5dD+9LIx1YVL4j1MCPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314961; c=relaxed/simple;
	bh=jyE3z3FxyZ+vDX15Jpa7UTJq6W5M1FOUR5oMLRe3vMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8hrQG7PhRo2LFlThXtUmUkmgcR1OFAaESErI3UKDnC4A/8Xx3zZUcSPdjyfFPhDQCWTk3rRqDBdsTQRu+n/fl2lz1qDyCZBQSp0INTFhd+s053BqmNiQ6JQNPRNNv02stG1lXgMeQYJcbz+Zjcpj5j2mg3qf+JPZz89cO5/Wxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ln/LWcaI; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ln/LWcaI"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6cbc3faf5so155225a34.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 08:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782314958; cv=none;
        d=google.com; s=arc-20240605;
        b=CC0/OHiXOrN2ZhZmhXhByNmNuYpu+cQk2TZb7ph8Ext+B2gX2HtWTP6g9ENK5X7xLQ
         V48XQHu0JhuLx54L1f4m8z+lDpkH2ekPP15pxSyUBeRfEXBaZx44vYlLomvEhP+S00Hc
         HhBKbrbvWp9NQn7Wpcs6kZEWzIA+EftcNh3wPo6fnsxEIAtPP3dkI55cc8TirhRRWx9L
         BZNJ+yuv28hBG0721Rmt5Tk+qC8RULMNBIa7Xtca9GsbvkfXSTUlIZ2aLvfumJ2pfbZ+
         i5OZvLD946NLaotPDDEs4N2eiPnj0LPLiNoSOd2Z0vCaGM6KnRxQNAH1IgE48v8BZQxf
         vP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z01jZhoJucab47dyJ+TPYyBQLB/FjMWfcxPJhLpLm54=;
        fh=Y6KD+Voqo5oS5Ox5mlnaEOjuy7G0BfAgvdCqNxwny1Y=;
        b=gZOp7cHbhxYMFXbJwxr18H4nkGU1GSv1nNgzdbZR9mvz7jU4keMtwbW15tfnm2ZPdU
         46vaP4XCAW5jTQ5dZQ/obwwpRdMqK1QyarpOAxlDIxiO0OcPuoUfIdAmrCYMr3MIJFEb
         ZCUZ6Xs6I6kFEl3Ojarpp5tl8+vVBQpv2cJI0DznDxLjI/lJ/z/KLckIR9ocIZrEF76L
         woscDhN2lo6Xy5hJ4PVc8ENuVkDb9YGQ0KHNfkMxZ21XOWpA2KcixDdmnkB1Dfm+UAmr
         eIbX18UrVOBci5a/2+x6ehebSIExwvOMCjc/h9Ex5DvNkfbFqT8Mi/Os88igOy4AufRc
         vrzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782314958; x=1782919758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z01jZhoJucab47dyJ+TPYyBQLB/FjMWfcxPJhLpLm54=;
        b=Ln/LWcaIaPiGzL7QtZTp7EcG4LTQK/X1ket7C9ogkbHxzlv5PuViAH5c8SC5Nwp7xE
         bfrNpb1RrOrfIOMPY5NTTwB6s2cGkclJvlc+QtrBrwkCA+RirHtEZcF2cV4QPN++aEpq
         6o35zmXVrEWIa0Jcx6B1nzj4fcww//1CASty4tPfnZyHtL0iOG774QjBsFmVIuNYXmLv
         DFEoVnvvpTErzvx10sR0EmXybl8xGlDaCQXTO/FKj0wQ57F+MLg80XX6WESaXdubvj5z
         FNRYkK8w69nR4jHqeCgT6mBsN0lZIibLAaiZauLDRAJxsw8je1oMvbJ7kLIauR+ZhTKW
         7rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782314958; x=1782919758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z01jZhoJucab47dyJ+TPYyBQLB/FjMWfcxPJhLpLm54=;
        b=Db939y3ZGwtAUnyPBFgVOru27W42XngnV0axKRZGw2+9KEJm2uwqGwGYBP8BvYcKnt
         qymdAK4kO20YKPQ0qvtGbx2OZl9AblyvHvlcJ8prK9tjN0tOwBU+bqkM5q+HAMb/0wC3
         M5KUzsOzajzMgt0nMlCiuw0awHGa8apt5mbmqKtvEpKsArFkwp1Zt+39EpZUSD8LBDCe
         b4JnthzcBQSS8VGAPhXs0EWTZMub25XDtmHEwl7wOHFwg9k9anndKhHQDk/Gs6MvoF7b
         Iz4uFmuamt8TX0T2ugklQs6eWfi64UThiq3VKQAJbHRAOFrbuz6MWmOOfGNcG9ZebyGC
         +r0w==
X-Forwarded-Encrypted: i=1; AFNElJ+UEv1SQglHSrs5wsMNsTFL603wOrWdUGA9ObWpEyOC3AmRuMTmg0+EsCzGDKyfO+1D/44SUoE75Ex/CA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMkneve5zL4WPxuNUmAU9+XcZZ6QbFXQAAeia5kcHPRZHGfyh
	Q3md83l7g1FgYifIdyrSotmzqJ0100gSGHi1dVy09qkGCEqa+XWj0Bwd23wVW9CSEAeGh+mJIUD
	HnGPWUWeh6mm/JZgvqL5VrdNgHzomKinN5F0NBF6qQg==
X-Gm-Gg: AfdE7cksaqckjjeNcsepe9BoQLtf3kQqogOfIbvynDfFggbggYhxbjdaUlFc76fL2wX
	jWY7VopjxP2moKZpeaObJxrvUaZHdSIBk+Yx8H47q1g7txZPRy4hQUdBD4rjs/1Xm+942NOrrdp
	XpTXw8e3W/EhoqKuSkxK8F9DPS4DTrhEEVq4YxTzqu39uRKVhw5qP+zE0EFH6fTZXKy3g5AXbKl
	t8m/1szg0o2wRoCliLaP7RWmQpe1dsmO95w/mpr4lMplAvg+LftSR/kXYpxTAc/b8LvSIkh1w==
X-Received: by 2002:a05:6830:82b4:b0:7e3:f809:7984 with SMTP id
 46e09a7af769-7e93c26c950mr9888059a34.1.1782314958152; Wed, 24 Jun 2026
 08:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624080014.1998650-1-hch@lst.de> <20260624080014.1998650-3-hch@lst.de>
In-Reply-To: <20260624080014.1998650-3-hch@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 24 Jun 2026 08:29:07 -0700
X-Gm-Features: AVVi8CfWtLvZxdC9loVeRz8O4FMo6e3BWbRKhzvIcpt_40w92euZGv-mYgCGB-8
Message-ID: <CADUfDZo4hysS6qj=Z=dEzVk=DQe6D7-zTFODLk8RGTJ13RY5uQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 1:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Otherwise zone append commands will miss their integrity data.  While
> this works "fine" for auto-PI, it break file system PI and non-PI
> metadata.
>
> With this XFS on ZNS namespace with non-PI metadata and 512 byte sectors
> with PI work, while PI 4k sector formats with PI work only when Caleb's
> "block: fix integrity offset/length conversions" is applied as well.
>
> Note that unlike regular writes, zone append does need remapping as
> partitions are not supported on zoned block devices.

I take it 4-KB integrity intervals don't work due to the lack of
remapping for REQ_OP_ZONE_APPEND? Sounds like we should come back to
the discussion about cleaning up the ref tag seed and remapping, then.
I never got a reply from Martin on that thread. I guess remapping is
necessary at least for partitioned block devices, but we could skip it
for non-partitioned block devices if we initialized the ref tag seed
correctly.

Best,
Caleb


>
> Fixes: df3c485e0e60 ("block: switch on bio operation in bio_integrity_pre=
p")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index a53b38cf8a1a..b23e2434d80c 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -38,6 +38,7 @@ unsigned int __bio_integrity_action(struct bio *bio)
>                 }
>                 return BI_ACT_BUFFER | BI_ACT_CHECK;
>         case REQ_OP_WRITE:
> +       case REQ_OP_ZONE_APPEND:
>                 /*
>                  * Flush masquerading as write?
>                  */
> --
> 2.53.0
>
