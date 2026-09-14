Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03A35E1A3
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357212; cv=pass; b=PwTuPTPMUmEDv+W70NXaBHVQfHHYPqYjiSDBCoLX7KkuD2OaCrecOYK/EacjAe3jH+pm/u1udHoYd0r4YBuq/5Ec8TPnJ/mbIO7DXiRAh7JIGAiwQ01YcCWcnOcHKzMix2fhGBlYz3TwU0eOpyk+iy46l/aKvlObFNvuvYilVfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357212; c=relaxed/simple;
	bh=yziNckEhRGkggQoCrQ2nxB5wdZ0jc2JKNlTSAQX/xu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzo5We8n9lWtMqUZKtjlPEFcoRwglGmse9IA/aDU6QjiKQCVdSUuEqMj0bHeRy/RUQVzbQUgWm+W59gjeU1snULFE+HMqNi4OFQ4jKrx/Kw41aME/aBGOQh5vQ8XJoRa6Yp7INsQMF9725isS40Z9rp6g2LgEWNcI31mEGTEqBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7VFnW01; arc=pass smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7VFnW01"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d903e972efso13166755ad.0
        for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 20:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789357210; cv=none;
        d=google.com; s=arc-20260327;
        b=GlEaUbZ5OReNF1wNBJW8/34SJPYleJ3Dce8MjOjytKSzDh5y9cGOFxMIt8s6Ts7Thu
         LzD9KzMijJGfmnxxZUywcd2b5AHDlTyQGo463urIXMXqD6XRH96OUabV7rmdQ6pX56Sx
         X8RkWTT0HoK2o6FtWtdxkSNvcRQ151pPHX/hWzlBaVEtU8XJKFsdIPmEHhHLbeQrySkW
         G/dAK+yiSreCbtarnOpKfrmbVhuN8Lf6lYm3ZDT7bmAZKAzlokHy2RYjOweH3gR+/ux4
         NtpInQGOWkxcT+QeP8XOzeTNN5+6ni6jjo8ieAzXMTUl+lrCPgiweo6fZLh7N6ixWYey
         +URQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rwCcanvMInS0El4LP3pB67YdlYsqQN2ifMO5mhOOHlA=;
        fh=3CT+42fAsHFtmpNBaJ6yDIKMB1NHSi+K85x5RPpD55U=;
        b=JqcVjnBVIut8oyarddgrggv9I/JHvqfKWocFR8loDBc5AGuYozpw2wYk8s/GpSdjIa
         8zzsY94/avmjJCtrTJt2QPheJ5j4akbrpOkpDR/SQ5eg26nd091njPRjf3oReTjZXR5S
         LTIGwf7xOUZLoO5AzPqHowzVuzf8rv7iMYNduoOrGtH2sgmLhURgMJpQdaUNYzRKHM32
         eRJpWM8v2vIgj1o748DxkFski/936uy584h5x5hgVrBIXakLNtYF9g9jUNw+2OLMyprE
         KtlLnffiRT7mWDaUBiJWQBJdsGtJJFjvsC7FXGPpRwAm2s4jzvkaPShYqpBl5Al0QDaR
         Z/sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789357210; x=1789962010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rwCcanvMInS0El4LP3pB67YdlYsqQN2ifMO5mhOOHlA=;
        b=b7VFnW014wnJQtDBmJvvEANTlJ54eWPwQUjQO8h/EweAj36AMRvOjNCpWEFcyPh+9o
         JTDhhakv2XOb6cAA04PGZhzK6FBiVRn5nqKIJXcOQtBfq4G0RQyEcucnKL9gdRhCS3Ja
         P6H+CyRvys+fehMmTe1DPSnNGzQSi0RNiOLUx+sl/a+fL7akySj6ZQNwwPki18xFBeto
         DgX4pUQ/dE0o1TScLafaDaFqT9nfnKSlk5Hcy1ST7/WT3mnmZx8HPTDphCzFUCTnwUdB
         /zfgY5NUOGdZauM6woSiIbBbBYPPi8vsYRG1IevCGijQxszRyLbZzxpioL1fIDO8RJgS
         WGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357210; x=1789962010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwCcanvMInS0El4LP3pB67YdlYsqQN2ifMO5mhOOHlA=;
        b=ot0JDlemEVs8u7eTUhKlFDrjXyNTAuT+CwK5AB3Yppb93qDuhCN7A9WZ8/99DohBbk
         Dv7vHZL7HoaKHyNP9KL3ErrzXG7ZpqjLWNrH3oBaAifsjDWA7O8dWpJxf7usx7GiYVZL
         I3ronBCtEH6viplYP8NGkra4ft9HkvZyLRX1818psNbUkgn9W57OaOYaDhPqbVzGAeS/
         cQCmQuNrZdgJE6AjXYvqOh4hCwBzsfuezVe8SfZTs/mVksEqL3PbvTQNpoJJFHT+pvbK
         jmscWtMenfh0o4nrszAxJzNOLQ/2WlsH4CbJOukkDwGn14Wt2PJhrtKbie/LM1HJkU/N
         6lCA==
X-Forwarded-Encrypted: i=1; AKwUvByWGvfNuPz6ItqkyXRSKCDHMyZUedPHUpB84QezkxDzjer0fJhmBPIPrAocdoNFVusBtSwafrdyPfhIyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mCsbvhp+yYMdUOi/I6pV7RpWtAUKT2s6eB718bY3VksTPIyKOO
	HyfcaDtZaS7zrJpD5bhorczHpHvQtcItw2S96ymaUbWREBZ2Sggqkw3Mq/ZwtEvepK2N9eVhqdT
	BkEhASPUysY6SKtfVh4o6pZrlKCkHKEY=
X-Gm-Gg: AYBFou0h550VrVxIDwaKYPixax0UQN6+V7heTOB8IDMckNHICM5F/va0UibU0vuTOLh
	0BzJ0duH/KSB2Q509LUPcj68QSzSz233UwSNe7NrrE6pbcR6McP5RHd1qyqn6f73uJsJ3lAQWzC
	545mxkYCtZ8idaJopq9ZFWstJcP5YplZ+J7hfxkJhix6BSchDammphGNW5usYacFS8ryGCHrmHY
	maX/xZLEAhG7XDpQ5wyM3IV7+vi9o65TZzlcb0YqLUlQOdhwOBlIii1vN6NM0VqcgNyQp8P323G
	XrVVKhO8Psmu2XLKdd1q4CeG0po5W7BgrT3jA8oJQRPMkXq/9ST8h7TJX/H1XTzyAI2bfMuIrJC
	/IQ==
X-Received: by 2002:a17:902:e74b:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2dd6c5c32b6mr16832815ad.5.1789357210164; Sun, 13 Sep 2026
 20:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812130335.60354-1-mzx199711@gmail.com> <cover.1786782832.git.mzx199711@gmail.com>
In-Reply-To: <cover.1786782832.git.mzx199711@gmail.com>
From: Zhenxian Ma <mzx199711@gmail.com>
Date: Mon, 14 Sep 2026 11:39:58 +0800
X-Gm-Features: AcwNN1XrtItlfvyrqhOpEXJnNWd5UcTlVET5J_mOEVi7N8IumaHnV5MWgplIfSU
Message-ID: <CAAth02CeZqm+D=kPHZ3oEBVti0sk8yFuoSOteu48LY+GX9mg7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] block: avoid redundant flushes for O_DSYNC direct writes
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, 
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,
Gentle ping, both patches have been reviewed by Christoph Hellwig.

Happy to rebase if that helps.
Thanks, Zhenxian


On Sat, Aug 15, 2026 at 5:07=E2=80=AFPM Zhenxian Ma <mzx199711@gmail.com> w=
rote:
>
> This series removes redundant cache flushes on the O_DIRECT | O_DSYNC
> write path to a block device, following Christoph's review of v1.
>
>   Patch 1 skips generic_write_sync() when the direct write was already
>   made durable by REQ_FUA.
>
>   Patch 2 stops setting REQ_FUA on synchronous O_DSYNC direct writes to
>   devices without FUA support, relying on generic_write_sync() instead
>   and avoiding per-bio POSTFLUSH emulation.  Asynchronous writes keep
>   REQ_FUA, since they cannot fall back to generic_write_sync().
>
> Changes since v1
> [https://lore.kernel.org/linux-block/20260812130335.60354-1-mzx199711@gma=
il.com/]:
>
>   - Split into two patches per Christoph's suggestion.
>   - Patch 1 tracks need_sync (default false) instead of dio_fua_done.
>   - Added Patch 2 for the no-FUA case; asynchronous submitters stay at
>     parity with mainline.
>
> Tested on Linux 7.2.0-rc7 with a Seagate ST20000NM007D (fua=3D1), 4 KiB
> O_DSYNC direct writes, mainline vs this series:
>
>   Sequential: 119.7 -> 7497.0 IOPS
>   Random:     156.1 ->  666.4 IOPS
>
> On a loop device without FUA there was no regression, and async
> O_DSYNC direct writes were verified durable with fio verify=3Dcrc32c
> (262144 IOs, no errors).
>
> Zhenxian Ma (2):
>   block: skip redundant flush for O_DSYNC direct writes
>   block: only use REQ_FUA for direct writes if the device supports it
>
>  block/fops.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> --
> 2.43.5
>
