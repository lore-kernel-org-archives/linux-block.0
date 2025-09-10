Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B871DFDAB
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473456; cv=none; b=J5y3GnUXZQzHqSSFe+AZXHEoEslOyEooo369NUlFQ85zRvCaMAT6VYz6WOwJsFfXU7I9L4j+TUdRNC0x6VtN7zPvGC05wqyKWRcZ5UR31BGT4u4CXRKsRiRk82mHhQjocS04h06L2JTvFXGNLPps3XbBHZurPa1YrRQqPvCzKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473456; c=relaxed/simple;
	bh=nhEfURgijinZhjIeDXDnCpQKyzGClfm2rB5uSbE2bUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOL2uIkf0mhaYp5NS//mioylV1/7zgfJWPvMRfI/K23c70vJO47SKEN40UDxmCjXSBOM6KDoaCVFFNkeyEFzRYocWts+k5LdGEDcGYja4hn8FooSjV3uKE1VbgMWI4xHqRerFA4kCXxrjWOgTrGQcmCiTJzr3Td2KotWdrfkioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K79SWdg5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K79SWdg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757473453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FXW/+HBhYk2zr4fhYSXPPsYBARrLzDG/6qntZFMVpo=;
	b=K79SWdg5+fz0ziSA8VLNqXoDAcTQ8dt2EJDfB8Mw4FVPUN01tte/MaebDQMPhEGzld+Ruf
	kCYFu0lDvxEJ3aEdM2MXM0d+IHuD0hiWrjxaVLiUSty3Gtj4+laAaBhhx79pmIzrMhKC+2
	2JAadEfPViwy1WxGbQG3+8pDwUZqziA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-RHq8AMxbM9C5vbJYRGJSUg-1; Tue, 09 Sep 2025 23:04:12 -0400
X-MC-Unique: RHq8AMxbM9C5vbJYRGJSUg-1
X-Mimecast-MFC-AGG-ID: RHq8AMxbM9C5vbJYRGJSUg_1757473452
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so9812501a12.1
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 20:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473451; x=1758078251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FXW/+HBhYk2zr4fhYSXPPsYBARrLzDG/6qntZFMVpo=;
        b=QnTJ9cKnXfUw2s4qz+UhTK6bhtBvTlW+J22m2Rrk3PeSqQ50UcGwLqXIT8pFUultk0
         xMAd2WdSW6fWJuFRdTk0xWK26hVIjpZZS5e3G/ikWqWVCeNdXyLD9sZKsqa/tc0hBGVB
         yS8Hh60AlYdPuJXcvwerttP2xOkGk1lBlj3jior4EOs5dRGNq1qjWMTx77a6IBmwxBXe
         +Vw9aO38ADsvLggyabdqBoBgzfOaqoZbfhQrQRzqfmWwKUsXx5gskLpkyLZHCTWPoag0
         dQ1VRiqTHi/rlc5vy5ZHOD7s4TkXWSmStDPUsV2Lrn8PfzCs1u7qx3mce++Jru90Duy6
         QOfw==
X-Forwarded-Encrypted: i=1; AJvYcCWbXJ9RscT7QkXUwwMscRITD1pmhp7RRT+s6/baMVMZPyuzLTShMiZ2d3el5y1GJlbdNb/6fhnzJrSnWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/a3KGW0nqL73YnhIT8LP+JV162WXCRI6ZA59Gm+dDUaeBhqf
	VK/7FMp4p5WrZemE+3nBA7xcU2GxPhHIAh2i4K0xbFjFFnvLmMv1cgaR9HBlulmB2vXIjHxfsgH
	6rCTH2n2yiLkfuHGuxxCy9Wv7+K32qJssQ2kIbJFQRjTV96hr4cFkcqmJp0sRf1rfVroza4rDMq
	l9QxqrLnSt8joVdgY+BVHFv8kvIAL+LoKPaJek/oI8xITYSA0fyepQ
X-Gm-Gg: ASbGncusZpLeRiQf9V+1f5BproCXcmtFmOT9zsPhUZLTCjjEX9uh5mRWQEfIvMqlKGr
	kub2HPWfW5tKZanq3Z3YqlD3QQOQ0b+TglO7v4ED7OdJjdXqW7gt348aWbWMaI7Jzb9L9+Fb36X
	CQvkeICQRPPTd3k0Gl8m7GLw==
X-Received: by 2002:a17:902:d2c7:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-25174379a44mr156803615ad.61.1757473451292;
        Tue, 09 Sep 2025 20:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoONmeblID+bbqEAMuFoJ5+Ea8yfSh04sJMH6nD19i7912llMFc2WtXUtmsm3rCCJweVbSCHScx/GFYeunpuc=
X-Received: by 2002:a17:902:d2c7:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-25174379a44mr156803275ad.61.1757473450771; Tue, 09 Sep 2025
 20:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909045150.635345-1-senozhatsky@chromium.org>
In-Reply-To: <20250909045150.635345-1-senozhatsky@chromium.org>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 10 Sep 2025 11:03:59 +0800
X-Gm-Features: AS18NWB6rxPU7nJp7LtkjRqh_fDdk-M3Q2gkXOetkwTl8ftzFeeehDhcc74570w
Message-ID: <CAGVVp+VMHxz2OAooS_t=H0tiNM9_C0zm6kn-d0DP_U14km8a8g@mail.gmail.com>
Subject: Re: [PATCHv2] zram: fix slot write race condition
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:52=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Parallel concurrent writes to the same zram index result in
> leaked zsmalloc handles.  Schematically we can have something
> like this:
>
> CPU0                              CPU1
> zram_slot_lock()
> zs_free(handle)
> zram_slot_lock()
>                                 zram_slot_lock()
>                                 zs_free(handle)
>                                 zram_slot_lock()
>
> compress                        compress
> handle =3D zs_malloc()            handle =3D zs_malloc()
> zram_slot_lock
> zram_set_handle(handle)
> zram_slot_lock
>                                 zram_slot_lock
>                                 zram_set_handle(handle)
>                                 zram_slot_lock
>
> Either CPU0 or CPU1 zsmalloc handle will leak because zs_free()
> is done too early.  In fact, we need to reset zram entry right
> before we set its new handle, all under the same slot lock scope.
>
> Cc: stable@vger.kernel.org
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=3DksN6=
EcvyypAtFDOUf30A@mail.gmail.com/
> Fixes: 71268035f5d73 ("zram: free slot memory early during write")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 9ac271b82780..78b56cd7698e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1788,6 +1788,7 @@ static int write_same_filled_page(struct zram *zram=
, unsigned long fill,
>                                   u32 index)
>  {
>         zram_slot_lock(zram, index);
> +       zram_free_page(zram, index);
>         zram_set_flag(zram, index, ZRAM_SAME);
>         zram_set_handle(zram, index, fill);
>         zram_slot_unlock(zram, index);
> @@ -1825,6 +1826,7 @@ static int write_incompressible_page(struct zram *z=
ram, struct page *page,
>         kunmap_local(src);
>
>         zram_slot_lock(zram, index);
> +       zram_free_page(zram, index);
>         zram_set_flag(zram, index, ZRAM_HUGE);
>         zram_set_handle(zram, index, handle);
>         zram_set_obj_size(zram, index, PAGE_SIZE);
> @@ -1848,11 +1850,6 @@ static int zram_write_page(struct zram *zram, stru=
ct page *page, u32 index)
>         unsigned long element;
>         bool same_filled;
>
> -       /* First, free memory allocated to this slot (if any) */
> -       zram_slot_lock(zram, index);
> -       zram_free_page(zram, index);
> -       zram_slot_unlock(zram, index);
> -
>         mem =3D kmap_local_page(page);
>         same_filled =3D page_same_filled(mem, &element);
>         kunmap_local(mem);
> @@ -1894,6 +1891,7 @@ static int zram_write_page(struct zram *zram, struc=
t page *page, u32 index)
>         zcomp_stream_put(zstrm);
>
>         zram_slot_lock(zram, index);
> +       zram_free_page(zram, index);
>         zram_set_handle(zram, index, handle);
>         zram_set_obj_size(zram, index, comp_len);
>         zram_slot_unlock(zram, index);
> --
> 2.51.0.384.g4c02a37b29-goog
>

Hi, Sergey

Thanks for the patch, I re-ran my test with your patch and confirmed
that your patch fixed this issue.

Tested-by: Changhui Zhong <czhong@redhat.com>

Thanks,

