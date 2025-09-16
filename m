Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B82C375E
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065022; cv=none; b=vDM9Z8xVn+6QsvLZ/4uUqiiaDaE8DMxyAWP2s6eOKl+x38BGX1TPKODThd43+0LuUWRZflEPcwpvnPe+sp2MX2RceudOYwUqj8qrKtU+JKjOoxqmZaB8Lug+XLknqrrXRB1L2OXZSEv7bHcPTPCh3BKxUAVZNR3wU3uZEl0CqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065022; c=relaxed/simple;
	bh=giTIA+oN2GPG2AJcIuFo/Yqay6xFcr7uFNP4OUqU5dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQzHjommDFF14LkLRb/Po6k2/0y7XaYYWepgmVH8uxyJklve+OnRPslhJ6G0RaUvPIgFQtKt/ZyoZWEBw3M5kB4Mccvbn5iAbpMeBNOcHddRc8Sz3MUyZdFIcJv2l+WqP/1jGK5rtmFePY/5CdJC/M1lnT8ZqEKxa9J6aulK4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asyUZ+iC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asyUZ+iC"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b79a332631so39443521cf.0
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065018; x=1758669818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ3YjBHZupiI/fSqsW54w4BEZGVyy/jiIbt6znTHb9g=;
        b=asyUZ+iCHTL//+nR5gSFuJOruC4HPynL2kaTddk7PctWZ9pBCFj1rLQuo1AHwy7TR1
         fRPl3uQNKVDDIgVty2+JobV21FKfGq1F9Vo9nZaN8FLPIV7BMB6ue5fNLgNN2yDrKFZb
         hBDWXJGnaNoy+EAjno5WK7YvdOvXf3+jVe0G9YbZRa9R5cLkNcke/d6dTGrfyPj4XavA
         jv+5Y6N5gGz4o5ZTbrvx4a/EOUQrw96Ni4xSC94Ryef14V7gFonveI61b87xn9ukf1F1
         gQChejVlUnt52ZtsFiJ9IQ3sRoC2TF+l1XDUolQpdP/wkHblopAY71s4WS/3hmLSuDBU
         3x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065018; x=1758669818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ3YjBHZupiI/fSqsW54w4BEZGVyy/jiIbt6znTHb9g=;
        b=wR8L/qevveJMkLYoqN8ASnNMxRDrsNwG/Y527s5Q3Wtl3CwRVpUfQWdQZW6kRnSzUZ
         a/52tHzcN7JGU+K69gwys9F+7F+JHa17LOTF9aJSX42xsi4f+4y1mXDBvMwuA96IC3p5
         caw1cR3mLqKxcXYli8zviRiW47wIUtAvUC3E4BbWhCLLS1SjFB4qOs1TwQe8lBsk+6px
         G9Wcsjbl5bQT9GaExBnn38K79O8JeZbZqcjANkcxEDnomdgEhhOpYVB7q6qCUEo05Zh/
         vYTsDv8L0/ZL9qtCNaMWC6uwkI3gflYGO/srNc2U8w72SKwtQiMUwfFywTGBbw+UAX6s
         ggxw==
X-Forwarded-Encrypted: i=1; AJvYcCV4RAlzlEYUe/AQbmWDpjhskGdxST2P1bdtom2PeKBP0ujWr/9OLwoFzcvaeuuSy9S4WpgUEF0sn3pcwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMTtxb18rIXxW4ZpAklr68bScx2nGJpU+Fh/g66ypZ8N8BqDY
	NmFiLEuAMrPNOJfIK4p7e2MzWnP6GCqdVjMrgCyViykFXQP1EPrdMOBtWKLi2VHSskwo3UmsNwU
	cHBOR81YFc2VhBRxVexitFP6r/OhruAE=
X-Gm-Gg: ASbGncs5tkj81hfOII8PxJmt6iecKt6d6sjyqXGQ4Gw3C4UMhRoscYN9fJbLSylRml4
	aQoBYsjeZKC06Wa2P+cMdmemDdAJ1j3NSKaEKab31de4rKIpceqnrHVvNaQSrzH7cTYECjc6aFI
	wAtrKa3uFBr/jEDWZCk6ud1IBtxtTxuJtPaJP7r9C09zRMTJ/vYcVt7iC7rMGrlSHUORUr1gT/w
	tR/PIGYqBPlU5nV/zBTCPhN6Pe3LtYph1cydBVHpy1GuyE7is4=
X-Google-Smtp-Source: AGHT+IGKNa7p053KroFdDHY8BCrv3xAn02NwZmDseFgEiIugEgF/oIBHgUVbXPtDWUz4HmAdeW9tnpZMVTofJgWdSvM=
X-Received: by 2002:ac8:7f4a:0:b0:4b3:f0d1:bc0e with SMTP id
 d75a77b69052e-4ba66e0cbfcmr3622001cf.25.1758065018571; Tue, 16 Sep 2025
 16:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com> <aMK2GuumUf93ep99@infradead.org>
In-Reply-To: <aMK2GuumUf93ep99@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Sep 2025 16:23:27 -0700
X-Gm-Features: AS18NWBTxeNfj7HS1GZNQzeWa7wYyaeuCFdkWQy1IIWJ1KkRr7vB0nVtSJ8Auok
Message-ID: <CAJnrk1a6UYzY=t-RJtoifxfkXQe-bKMhOnKtnvoP-X1fkPvb6g@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:44=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:19AM -0700, Joanne Koong wrote:
> > There is no longer a dependency on CONFIG_BLOCK in the iomap read and
> > readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
> > allows non-block-based filesystems to use iomap for reads/readahead.
>
> Please move the bio code into a new file.  Example patch attached below
> that does just that without addressing any of the previous comments:
>
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index f7e1c8534c46..a572b8808524 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -14,5 +14,6 @@ iomap-y                               +=3D trace.o \
>  iomap-$(CONFIG_BLOCK)          +=3D direct-io.o \
>                                    ioend.o \
>                                    fiemap.o \
> -                                  seek.o
> +                                  seek.o \
> +                                  bio.o
>  iomap-$(CONFIG_SWAP)           +=3D swapfile.o
...

The version of this for v3 is pretty much exactly what you wrote. i'll
add a signed-off-by attributing the patch to you when I send it out.

Thanks,
Joanne
