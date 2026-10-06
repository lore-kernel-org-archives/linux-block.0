Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBF36B06A
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791268312; cv=pass; b=LxfS7xWZ6OLbN8O0Fe68dvUuDw2iS186IMhfKGGOCIyz8HS/wfVBQTpgR1O/4VSkDU2l3/zXgOZZ4xynpy0+cTNIMf6wzgRRd4i5Ucdwx/wfS7eF1FcvT5jyJcgASVzFU1rZnW3qnpLPw8XHcNPsTVKyjG03zqcUuKmkmveXgQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791268312; c=relaxed/simple;
	bh=+SmgQsUe1v0xQf8oZhSIGd87bFGAkcSEGRXbQfh1wgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnqYvGt/e0jD+QRfBB9YRvaM0dDUkLLV2vi/xkscv+nt+hob53+cG+R+vBsugJXR/LCPlBo+hbsrkTGJfISaoLI1cI8UNqCtwhh9dS6XYdk5E6R9BX+W8KIkDlDQHRS4cYvo9nbmJuqCPGDlAR64ZJDWJqVcdcY0sU+KvEXB4fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhEKmfoM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhEKmfoM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533202fe429so161431cf.0
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 23:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791268309; cv=none;
        d=google.com; s=arc-20260327;
        b=HCJIho43GznYtZHSVVckRq9R51Pk9WYPW44dqdb6vN//FQF/69V8aAg/LJtYoUwSFX
         MwBbIuuhA5L+WSnH29jVEX7nto1vEGLPyhlMelkskI5clVSP+97Yx+6iDD4/1ahOZEKX
         0NAoLulJ1Y8J1SQvHQbZIw9ginUPZxvbUJZLNOu069eC7UPqgo02CmxmcUd3E3zn7JG3
         8ad2IWbgWHFQHIub5mtmmKue5+oRD+sYUzPBz9jMF7TLDDVyhZqO/ZKUu4shr5zCmYGg
         kg3fZ20DHRLv5AGzLcWofTeJ98BBAehOGEgoAW6qXPZl8ob4etseqW6SVb7kbozVc1Wt
         OPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/qMNv6LWR2p5Dhoh0FprqlZAOF+nV46g7vnoxCUDTw=;
        fh=kku5LBLM/vfVFl3FtnyTGbG/BX0SAsdjFHpO3ByfFZo=;
        b=IE7bFsC8QTbwCyfc5xXGdjzMNhcRrsCUSd7JlPmHeRn+c+DeSP6HDmkTWyart7/B16
         BOnwqFES74sLpHYDDvJR1yN5ucPTZm4dgK0Ebri2XzDtgTJTbEqoYuTvkO4AWv30KnZM
         LH321EvecVUMHWdDWCvU3ZZ9dHgappm94E5KgnIWpClsRqQIvf0fu7mQK+ucWXtVDGnu
         dK9VwFEzeDj8tydkdx5PxgefgmWZZ5CpyefuIc14bhYCv15+CAsD1ZZRIWB66nbG0wcL
         VcPC7TNE7jqfCx68x8zA1ytEIH92X/9vKgQG3i8LYoX2zFSeTKwpZWgVwDuN2MKMmbPI
         Q2ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791268309; x=1791873109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/qMNv6LWR2p5Dhoh0FprqlZAOF+nV46g7vnoxCUDTw=;
        b=NhEKmfoM1aRhp1hpFYXbfTuV94q9SvdKWohjFKijggTRWXs2d+sa+NCWg/tHNUjwQF
         MFT9l1cF7+jwQd0SsaMPR0EMy8yBrH7pVBjo9O5eVCkAJaG7erTAoBFZA+DP3Qj/gcdh
         RLNKuB6hDXTtjeCryIuMlFinT5Y8xZgjqdLRqGFjfNlqwKIAQTnqni8Cld2J3kv/quUc
         F1lFYPLAAJnCgSZggw/mlo8u4mNbkKzzcUN9Odifu/ojE06BfNWWY1sifz/TXwOhgyRT
         O2fElUIiO9Qm9mX+XB1fSq1OakQN6RHRWhGIi5dtnJmWivfueG82DGhRZU13fy48x8Rg
         6aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791268309; x=1791873109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/qMNv6LWR2p5Dhoh0FprqlZAOF+nV46g7vnoxCUDTw=;
        b=IImNRfod24CADqIF8LwHdMWZyJFGgqQX2GCMSRynkrykAzL3K0z0gJqqLScgdW2hJg
         vVyA9EsnuULP52eDsMwwZIb4RGa1IIiEqlnCpfjDcDiTnimcYPa3Y+6rxnOIrni/EDjN
         bpMzMvvvgOs/2KkPZVCDIe+LBjW490zmlTD1OPSBiEu2MUnogFXnqAu6eV2S7KkdP84J
         UpjWeMpI9OSZGjxvGQFTnAtwUgM8JdetxZnKemPmWKJUfhrA83qhrUvNNnMA8aG9no2R
         iRjm2K4Z5h0XXpdA4Bfp5y5uIKGlQBqV0hv4VzoI+baxxrGmTAAcaxMgJFmzHZkf+k/5
         rrXA==
X-Forwarded-Encrypted: i=1; AKwUvBz9bQa2osuMU8q0JjOR0xteSdTZd5d6lwSsl/wv+eQZHL2GoX7GHCNbRd3gCJiekyXANZCedfddVtDoOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lerhWoeA9SJiJD5kYMmIMmYyq4R2WP8aDjphYAWk9HSrcKadBZ
	d3XiuywZPejQj3ShTkpqbgAstXTkQ47cXvgD495XDlvKHaMYpZL4KZo3ICcPd68xM4gU+wMrre2
	ZYbxsGsuwqAfQOwJVAqdSWXEazW5i9YJm6F8medpc
X-Gm-Gg: AYBFou3Racf6yKDtaaQehS4seZZTtmxiIeLC54f992wrOZRoNPiSSMKThr8jzDspEwK
	kB2LFAiccdVm89e4nEnQT42aSl+KWEungQCg851AeSyZrt31ntjlCt2Nn/6nG4o/23Tlkiior8K
	1PkFmRUAFsmNifUy19k2XS8o61L6f1NS4sqSyAeZIFKqpx5pAWTzRxEHUOuvKF3qhjPRFXDDxXR
	YTr0wl9IPr5evmNIhC9gZqhx1402RRCKhKgano4uyND1VHlJ0elZ4/rg/vW1i/SApHiqF7clEj7
	Yo2JEGfXbRpKSzV4L7kalFS2VQbkLW9uir7NQlJGUrZ6H9X/9bXFszYG7aVs0l8DtoDsFDVQ3Z9
	YHIJiwPvm/hZrPkx/H9bP+6j3SxwIZuOwdFtTU1v22zj8izu/prWM238r2QxivKacH7kBuyBxZi
	4Yv/npmb1edqrPBlh53sqWQJF3QlQ=
X-Received: by 2002:a05:622a:60c:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-53540678576mr9157571cf.4.1791268308385; Mon, 05 Oct 2026
 23:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005122036.718976-1-senozhatsky@chromium.org> <20261005122036.718976-8-senozhatsky@chromium.org>
In-Reply-To: <20261005122036.718976-8-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 6 Oct 2026 15:31:11 +0900
X-Gm-Features: AclHuK8GDz4mlY-X1mZLOSHDZHkzlHRRhdhy6_5gaDfAVaftmiXzawHiqYiSonY
Message-ID: <CADyq12wsysqxEy_7wms1TyHVXOvpmS88WoO2_N3_Cgnr9vF9Zw@mail.gmail.com>
Subject: Re: [PATCH 07/10] zram: zstd: do not use kvzalloc() for zstd allocations
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:21=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> When a dictionary is configured, zstd allocates all of its memory (C/D
> dictionaries, compression and decompression contexts and compression
> workspaces) via zstd_custom_alloc().  zstd_custom_alloc() uses
> kvzalloc(), which falls back to vmalloc() only when kmalloc() fails,
> and kmalloc() rounds such sizes up to a power-of-two number of pages.
>
> For example, on x86_64 with a 110K dictionary, switching from
> kvzalloc() to __vmalloc() reduces allocations from:
> - CDict (level 3):            512 KB -> 400 KB
> - CDict (levels 12+):        2048 KB -> 1552 KB
> - DCtx (per-CPU):             128 KB -> 96 KB
> - CCtx workspace (level 3):   128 KB -> 84 KB (per-CPU)
> - CCtx workspace (level 14+): 1024 KB -> 764 KB (per-CPU)
>
> Use __vmalloc() for allocations larger than PAGE_SIZE (and kzalloc()
> for smaller ones), which is also how zram allocates zstd workspaces
> when no dictionary is configured.  zstd_custom_free() already uses
> kvfree(), which handles both.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/backend_zstd.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backe=
nd_zstd.c
> index b367049f131d..7a8b5ff186f2 100644
> --- a/drivers/block/zram/backend_zstd.c
> +++ b/drivers/block/zram/backend_zstd.c
> @@ -26,10 +26,17 @@ struct zstd_params {
>  /*
>   * For C/D dictionaries we need to provide zstd with zstd_custom_mem,
>   * which zstd uses internally to allocate/free memory when needed.
> + *
> + * zstd allocations (C/D dictionaries and contexts) are large and
> + * long-lived.  Don't use kvzalloc() for them: when enough physically
> + * contiguous memory is available it serves them from kmalloc(), which
> + * rounds them up to a power-of-two number of pages.
>   */
>  static void *zstd_custom_alloc(void *opaque, size_t size)
>  {
> -       return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
> +       if (size <=3D PAGE_SIZE)
> +               return kzalloc(size, GFP_NOIO | __GFP_NOWARN);
> +       return __vmalloc(size, GFP_NOIO | __GFP_NOWARN | __GFP_ZERO);
>  }
>
>  static void zstd_custom_free(void *opaque, void *address)
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
