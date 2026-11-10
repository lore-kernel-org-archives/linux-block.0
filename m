Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333320;
	b=IekKegb77oiymp/2vg6aVKg5CEXrpaxfo8ZL9IuVyVW2+d0I2HgPLuwP3/qrAPz9UT4A
	 fGu6fw1JQokTGPR/10t7hHP3FFfwNtdKviIE8FN3Tw/P20p0R6d4KqUI3q5bMQkwE4w7G
	 1qGb5+A9tmO0K+SvWzvVABofxjMyCA/UvPr80VzojHwA8WImw1jNZWdiEZFjqt2TN15aQ
	 q9mbc09ro6K+j/Q1OIsFPe1uZ5PaerbaO8JMMyFYL/BdxYsz5hHYg1+ILwps5E9FtDebR
	 MV3p2no42AqUFaOklGDJyyXiSl7DzTG9hBGItKXbMOKsU/EbIBkEKpnn/sMJDnqZIRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=H5aIR7GM7jF71ICZGcnmJRpWwPiNZxHyJtzFYIH9Kgk=;
	b=06qqA1gHwIlSKvWIVvvwmLeecp0Ip/fqd7oSNfWQ225RQrUjEjksqHRI8Gfjc0HQkgTx
	 YfYpBPaq37XJxWWKb0Gsh8jnyWs8IqsNN2ynpa4NH6PcZd2lhqALZlV5cgeL+p7MxR2rJ
	 okuzaOwDzzKGvOa9qyBy/Bn451b+tg9DIq2WQLxWlvaXCYr3tja1N7uD0/RcBFygFvRnN
	 hWzOfLzD7ih8VvZJBjwfyGsUbcyiTMmyo/30mMNbdyurZAYY9VCAp8FhiT2tzOsnkaHJb
	 f4A4LgLgyP0nZfxwz4W2BNU+HS4SG7XphQTuTjYhLjHpsl5SjKZfm4aVRrGatPiY99A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="d3C/eKtc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606D606A200
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 17:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2606D606A200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d3C/eKtc
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3aced9804e8so20255601fa.2
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 09:55:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794333318; cv=none;
        d=google.com; s=arc-20260327;
        b=NU18/o3YEik4dNK91283SNIvo66se0eBSzfGDClPEEvGwI6JhRgK+deVlUJvwQpvBP
         kML/7eiZs81DRuo1Loy9HAz0uby+63mk9H+CvCY74VQXDBo6OYzw88/7Czu+/GUQLMd0
         myOfzWFrAoRLBMPExFEwhPkL6p3Z7UBqZvMDbJ2+3+flwNrjTCTCTOd7nkdAo5EnNBEv
         uhF81NBk9vVzoebXvwqDvP1qiiA2kavorPPNoBfvwUaoPAmT2qXAs1a419SI7yLRpTZd
         gFOoIxSlK37R8rQxfunh8WfRWUJJHA8igyu/2Vk6hPtfxsmT253ggUHUx2SnUn1ihiaa
         uC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H5aIR7GM7jF71ICZGcnmJRpWwPiNZxHyJtzFYIH9Kgk=;
        fh=YuOHbxLLV1meCjsY6nAi98YUP37v5ClokKEIbdfxTj4=;
        b=aT5oeKDTXmEV2K6e6MAoHINOTa7klJn14+f5L5q8yXT9bvhHawts7Tb71zfAVKlRzn
         zUh1X/xNw1OaCRqJqh1YD1F1h5rw76iCeAzCAcesZ/rkWwX8r6mFwwhp1PLYp940x2qN
         PfzZo8e2bVdfanknBlf5bSdFEQffIR5zhLhR2z0htix3SAwrv0hotnPXYOHF27KBvAtg
         LJEiFcTfBz1+29soN1I29GAMVYwP3MNqQTSXGXpJFQITBHqn/xrn/ownwKrvJUBZiHCd
         t4DDgKSjNSvagMbagDnnwK+bw9bLjNixsl95h+ks6Axz43dnfdIKmzyncjY0Pj84woM2
         MbFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333318; x=1794938118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H5aIR7GM7jF71ICZGcnmJRpWwPiNZxHyJtzFYIH9Kgk=;
        b=d3C/eKtcj1uoOsgm8ifX7T2+HrV25xHyvQQPbG7F0Q/U9m3pCm0GCIwDJR/2Rrb0jP
         s49aXyaSocjXW1o54VrfB+aIL4+xFRxSedRWGvok8n9DPY1v0PHQET/jCDuAaFWovyGb
         PkObqLxukwzj7awlfYqs8VgRVWKMuvOJ7xGxUceg5jp0G8C0LJd0Z9U4zkg1wnO6t0bI
         /PtjilH24I+NB/GiyCVwMxzPMH4PbYuYnJ1ymtvjFGefvYlO5+wDJFI5f7TujqXVtWTL
         LXPd3fGySTQdJu0a7aQ7dxaIejXay/m3mqf9dNxGzRf/6AzGDyzlxVYDur0rU9f3FUm5
         v5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333318; x=1794938118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5aIR7GM7jF71ICZGcnmJRpWwPiNZxHyJtzFYIH9Kgk=;
        b=IhUJBFSvWymtCLrSBE6Qt/nIj795zJqUw4Rj43uNazk1QDfUzGbpDuKozzqW4c5nwV
         Pf3r6S5qeMKoKpS4DAKU8NUaFJ2HSf70tsFO1LBNQjLg2R1MHGyDoQxebxna3bK7kg3X
         3WsX4vEiHVtH7AQfSNM7OCNoe/bWTEXoL+ZyPl0STQXO7EG/kDBgLY0734MBmvx4y4eK
         VKpJehnhqpYDaox+1XLaOcYexCsLZ15BQU8i2BezbMQrB48oI94O8KmKTkrFRvexH9Sp
         gS5AqmQ/NlF6cFU0YIgpVh1S196trTJOMK0dKNXQupjQ4QWoUDZYeXX1FXt8F+fn9xiL
         XRDw==
X-Forwarded-Encrypted: i=1; AL+hErHslYGZJsVdEAG4M+npGcTDlgbY5HFQIMIWw+aKQazpfpT/7Y4FolX8K2GG6hr6dhPr4EAhOEEQGfPykA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/esgjOD1Y7wWKSAkGTJNZ40ZLgglOWR24vV50XwffWYLVAWyQy
	gTv1R0ckMXmgMxqfeb0Crp9GKjh5KYQwnylw+ich/FuYV5C+36M9hVfrye8aMMm6z8MwOdG9Hky
	ynbozz3w0EnmmO1IfjMWlmeAABzR8RCU=
X-Gm-Gg: AYBFou1kGmH5UVwxHi5A1QrwvJYPzKiO/piy1ROs3wPKzZier6ExYFjO1Se5ooeToJl
	Snuku4b5KBq8JUpLWvYWiaEarIGGVj1J4Rq7AZCYgv2U4vpAtTwTIOGunWAZCRDOL174YlPTGoI
	Gr15Lv5vg0UWF++OiYgqq8GqpbRluFCXzfkXXcBuYSqdC3F1bA05IZO2yIojlvBwRkmKPfI0y/W
	QFMyp4rGFpxvjTfVNWlUP9wIIFJ4Ler1q/+qF4LSDlFUAFYSSG5dbrsIf45NtwozgtFCN8Ktx9m
	lxUFXoTT22oMKZG93Rg+w4/3OtyFKJq638xMqFbj8o4lXj64EQ5shgjKUEgus4mVfd/efsg2Sns
	ZW9Ti6qou8uSe0sVxEUg1x6v1X3Krjk35uEC5lwp7M7tPJ94XT2UY3W8dmyYsMN78cJdIZs7lhZ
	RcLMj1i2qRpAmr75NL6+vSIWPG42HTCK6JItnPLQQP9KjMuIhO5Ra0
X-Received: by 2002:a05:651c:a344:b0:3ab:1207:bd2f with SMTP id
 38308e7fff4ca-3ae096160cdmr7384251fa.11.1794333318160; Tue, 10 Nov 2026
 09:55:18 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org> <20261110054836.1515030-10-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-10-senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Nov 2026 10:55:06 -0700
X-Gm-Features: AclHuK_-YWO9U5znFV7lB_KSdDYEIcp41HaPLmU_TnbiEvQvr2rPC4K4fEQZSco
Message-ID: <CAKEwX=PO3frCWftPnbdpoP+in32PFVZ5O9o-7AiNFovwXMB8iA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] zsmalloc: embed struct zs_handle into zram and
 zswap entries
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:49=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zsmalloc allocates an object from handle_cachep for every stored
> object, just to have a stable address which compaction and page
> migration can update when the object moves.  Both zram and zswap
> already have per-entry structures that hold the handle, so we basically
> keep a pointer to a pointer, which costs 8 bytes per stored object,
> slab alloc/free on every store and free, and one more memory load on
> every access.
>
> Make struct zs_handle public and embed it into zram_table_entry and
> zswap_entry (their sizes don't change), so that zsmalloc writes object
> location directly there, and remove handle_cachep.  zs_malloc() now
> takes a handle pointer and returns an error code, zs_free() resets the
> handle.
>
> Since compaction and migration update the handle in place, it must be
> naturally aligned, must not be on the stack (zs_malloc() warns about
> both), must not be copied, and must stay allocated until zs_free() or
> zs_rebind_handle().  zram recompression allocates a new object before
> it frees the old one, so it uses zram->recomp_handle, protected by
> ->dev_lock, and zs_rebind_handle() moves the new object to the slot
> handle.  zram recompression is the only user of zs_rebind_handle().
>
> This saves 8 bytes per stored page, e.g. 2MB per 1GB of swapped out
> 4K pages.  Since handle is per-entry the memory savings scale.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
