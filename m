Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A562DF143
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319114; cv=none; b=uBSV4nOZ7vwDKnrrJEm4wPDjOgJuVhUNxpA4JbmVGhkeJ+y2I1fdnB8cMIG8w1GrxXuuBbzzonAQfM1H40myNF5jxRi4vLCxYby9RM/9EJaVP3SiVZaRfMutZDPCjXe8FSGeYWv8zGd+8MdWGYjE7032osBnOvY3lXdzcOVUOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319114; c=relaxed/simple;
	bh=mG04EOy5shg0G6MHF6boM7DuHGiLByU6HW/XuA5FyN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFHxOEcnoOoKBJpa11T6Nw7diOrUCzclymNQiQLS/PdG26KAvoceaeQysrAgNCib+DesD9Z14yba1VspuqkHAkyGJu6yxCN36taE9LAmuMog9xx/mNDO/Xqca9mvNw/s8vT4WNBHAuu5uQRipsjZaldS5JS+njlNrVYLAd1H68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC2IxDOR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC2IxDOR"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed9c19248bso13961971cf.1
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764319110; x=1764923910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++QMIe2Gzi7z7FeXSAmSiuqg8P1uQ1lVTlMI6i3m06g=;
        b=dC2IxDOR0WeEmPZSlsUxwDLBGMsc+fIeXUYA+M+8wTeUPkh4BpLsVKWiIWaKfxtLNj
         s30DMr23fbEbBnmdth3SK0f8HTjXmqF+jpfglihhy6alcBMQrRfCQwWecd47M5pFVdI/
         UaNo6JCtvgYcDq7wVEFMYbujCkDcBTDPlacvfh1hsifnN4b8UIzOuIgib4dpdhUTJJbG
         2+WU1qaSortVni3Vwgk8eNvqX3pBqtlrAno69ovaRZ5lCGSvCGW7IcUP7pQpFuOWuyB3
         rVhw+SFUFjSr/dXCy/9Eo2Wo7ImEm0q7EpnxaFhaTiOJ4U6PHqK+EswOoX5dW4cRWPYp
         bnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764319110; x=1764923910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++QMIe2Gzi7z7FeXSAmSiuqg8P1uQ1lVTlMI6i3m06g=;
        b=Awx+ktO113Nf41fR1lRqMtgkOapxxNwqMIRg6aaPtJ4CEmeBoitP6sETwLOAX2QZI0
         OOrzQPfpCXTPatIsqjR5zaZ7QkUTg2FO9w8yFacv6ptDOJtzjOrz1roIH1Bw0oHinFmU
         cA0IT0PUwyUXZlDGwMUKRcSRpJfPwvfFoKb+Pk01CnUVlr2/BF42T/5JvqyKoKLY8YA5
         vqC5Jl4TPlAOosUWEMNUSy74KHbDFtAzbsC/e0BetkJZ1FNXxxSgfb0aESlxCYUP7urO
         Xhwy7lP+ZcQlPgTajyBJjodnbi1jJy+tM/lw+ocgs4Lwh9iyIDHOg3q+TTgmz9JaPCjj
         5Rvw==
X-Gm-Message-State: AOJu0YzsdL/nEzUVgDaeW2T6Yv1U78DzKy5csaiPC4cJ5Y9A7mxEkk0N
	VJL2OKjitp02fUnfc7AxkWztNVZ7uTNVWrZtmU1noVp8al0mjeyfhkTwST9ptxCTABgB1KjHrJN
	zC26vWpIsw1wWChP037BdLvgL/TQX63I=
X-Gm-Gg: ASbGncvKkCFyFBq5kvwZtPFyV0GiuQJKqhZrctsyWAfOT0I/aXXfDFESNPliOhzplGb
	4wVCOqbXt9Mtn6AGNtPt2lVQ/wDuqBFsekAVf3VLl06PonElLWFiY4/maMNFoEu527QKs7+WGTd
	CN8puVK4XDlciRBtlbA7stHfOdwoLGLelt5jgOsgiYRKflnHUqVsnBsNGk8l4tvT/wiP00c0Inb
	G6x6agut83H9WR55lfO7bW2iGWYAm+XkgITMFUaMAoGgy7xR4D8JLV4MRSiEZW4mZnPrr4=
X-Google-Smtp-Source: AGHT+IEfh/pR5dVEp+MyGlS6Z0E5USpuJd+WqXIzQcqzstZI05ioUW/B3ey2i9/MpvyCwVsDk2BTTIWfhdBYNOpApmc=
X-Received: by 2002:ac8:5a4d:0:b0:4e7:1eb9:605d with SMTP id
 d75a77b69052e-4ee5883f99cmr321417371cf.11.1764319110284; Fri, 28 Nov 2025
 00:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 16:37:54 +0800
X-Gm-Features: AWmQ_bkmQmYK3DJQjInSuzOGjciJ8sGZNWSCY3EbybUAu4bZJ47LIxlxmcK_q9w
Message-ID: <CANubcdUgYpxBqPrsOnFpGJK8S9DM46DT6hriu4kDckPMVzc-Fw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Fix bio chain related issues
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:32=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Hi all,
>
> While investigating another problem [mentioned in v1], we identified
> some buggy code in the bio chain handling logic. This series addresses
> those issues and performs related code cleanup.
>
> Patches 1-4 fix incorrect usage of bio_chain_endio().
> Patches 5-12 clean up repetitive code patterns in bio chain handling.
>
> v2:
> - Added fix for bcache.
> - Added BUG_ON() in bio_chain_endio().
> - Enhanced commit messages for each patch
>
> v1:
> https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.c=
n/
>
>
> Shida Zhang (12):
>   block: fix incorrect logic in bio_chain_endio
>   block: prevent race condition on bi_status in __bio_chain_endio
>   md: bcache: fix improper use of bi_end_io
>   block: prohibit calls to bio_chain_endio
>   block: export bio_chain_and_submit
>   gfs2: Replace the repetitive bio chaining code patterns
>   xfs: Replace the repetitive bio chaining code patterns
>   block: Replace the repetitive bio chaining code patterns
>   fs/ntfs3: Replace the repetitive bio chaining code patterns
>   zram: Replace the repetitive bio chaining code patterns
>   nvdimm: Replace the repetitive bio chaining code patterns
>   nvmet: use bio_chain_and_submit to simplify bio chaining
>
>  block/bio.c                       | 15 ++++++++++++---
>  drivers/block/zram/zram_drv.c     |  3 +--
>  drivers/md/bcache/request.c       |  6 +++---
>  drivers/nvdimm/nd_virtio.c        |  3 +--
>  drivers/nvme/target/io-cmd-bdev.c |  3 +--
>  fs/gfs2/lops.c                    |  3 +--
>  fs/ntfs3/fsntfs.c                 | 12 ++----------
>  fs/squashfs/block.c               |  3 +--
>  fs/xfs/xfs_bio_io.c               |  3 +--
>  fs/xfs/xfs_buf.c                  |  3 +--
>  fs/xfs/xfs_log.c                  |  3 +--
>  11 files changed, 25 insertions(+), 32 deletions(-)
>
> --
> 2.34.1
>

Apologies, I missed the 'h' in the email address when CC'ing
hsiangkao@linux.alibaba.com.

Thanks,
Shida
