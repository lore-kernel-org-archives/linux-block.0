Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B93DB334
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211829; cv=pass; b=oZmYQI3DE/4WGB5sxll0oT3t/hzGM34xD30iceAnnyMF2NMN3JK/+T2WnQ4RY5go0VgCBouE+wqHzJITESyEpeDKd2OCx9WtpK+6dLhhTFg4cjooKYkTya/OfisssA2L2yUhHUyJTJcuQUFMX0O6qsBnqNUy7V106l03xHJaTGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211829; c=relaxed/simple;
	bh=7gkvuiDElaYKKD7N6WpKQ7gsyRhM7wHYaXNapde9ApA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvdzqLe/N6SaKUVtbUsxr8yVy2rMH9/MZUGknMMsB0eWXZYBnoWqnCh434Vapc67T2IE5rg+XHKPZhuHISv/jqEDmB7jQpBybZuPp8dyh9IemLtVkGFAqhdKLGQD19BovVNMin/8IUDK/W0hkyj6CRdIVs++hSDQHRggk7qvxqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=THKKGU1Q; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="THKKGU1Q"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69489e55b15so145120eaf.3
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211826; cv=none;
        d=google.com; s=arc-20240605;
        b=ClioobjWNZ8BAoK8pe6uVoa5saVQiWQ6SfhU+9h9hUTtWXbqKgYcY/ekr/koNH/z2u
         88Skbxn10tM/58LofFuoCobKDtAHvjfyVZoXx+y9s8820AldnM7rmWiqTBZjBFXJWQZQ
         0m7KbLb4mnXPQWePWyULjC7rB2Lb6Zv9MK6/YsFiedHYEpYjnQoyuILFYezXanYdstMf
         a6rzk7Z5pG01G1b/5OgzYeF1hguPn+fR/YPU2pAbb9KsOylyul+l1zSlVqj7bMfNBO8m
         IGJzUhZa0hQ53P3qz0C2RnTnD63U69laqYpWVx0TaqY8AZAYpNDxHyk4bl8X+7Lszkdi
         ZJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BO3tk1HUsrHMlVLjdJPUmFor8Zm4KHh+N/ip+lC/DLk=;
        fh=W2WDN24dtoI9Bp3xqL9QGn0TFtf243F1MfDZnhNAW/8=;
        b=OEZ5GyWcc901/IYc+vj0FJklvcqMepglLPgf9PsEh3ktWpBjhxRfWIZKEZ3P1mJJNl
         pQR9SjAYkiBrJ/mD7ocu3VKW9oqlnSo19PJQkKrC5KTKYdJSWFvnoXMC53UwUNagFaf4
         WuOdgrCbSPTNsEIjw/KqFKcIAn1zP+wSsDYV2Xk8zGSZztVHmCCnHhuX8zvI1MnRzXUy
         hej7Up+iG7O0M89XfvISM5zzxSdu0JrpldJ04NVIxPkZj+jjW3zh6Wzdu8mZcA+oV1xA
         FT1XX/tJAglF5TgtdxnA58HZkB9qsx4+Cq3C7J+3jBbFZO/PqKUHspZd9EILUJDkP7DV
         8EQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779211826; x=1779816626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO3tk1HUsrHMlVLjdJPUmFor8Zm4KHh+N/ip+lC/DLk=;
        b=THKKGU1QkdPnzxwBu02UFYH+vh3Cpx0mQNKHa3/JV6FF8DsWHC88fkvA8WezpVNHG6
         aPZmP5aPmwOsutYGnL5QAOXwLrZMIY7NPzIAGii2WpST5Z0dLTD2xjJcwnbkgRkSxuq2
         Zfl7pnWY0/mKI6GtxGu+OjATibXdX1elYd+g7fzi+OrvGc+UvrcL5F6Lplv5X9kJobIY
         tDrIhrC/cyqrNzLcFuqigdeel5EqAb94E89o2dZlpXu82Ra/yga5SkpGT6w72hBJZwqg
         5yIPaHdDg+ncvox5SkZ8lHaMyu7lVpWgxaBNqey0PhHxGU5wMKvZfKQknbJamEAamPxW
         w45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211826; x=1779816626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BO3tk1HUsrHMlVLjdJPUmFor8Zm4KHh+N/ip+lC/DLk=;
        b=OV5Y/IQhhyOB64ltuE4rhGAepWQD9/mQw7eGZy9Q01ce/Bfc4dgkrB8vgXhcP6zhlp
         k0imyEx9s9W7G8Io1mv81dJhIymVTwyN4eb8CBTOL+9WxgV0lR5p6Lr3v0/BrtrN2KF1
         JumzLvom7cGEBdAGeCFeqD6UIGAuRY2+IgeTD4nGFlYn/YZ/MZvcp7TsBSRR9iLG6zK7
         OueUGX/uTn4lqQ0+sudDIasn5801mtwpu+4qgvS53dYeHhLgQ8RW+GVGL9lRPCN1IeW3
         1PNZDiDpnh6knJiuRXNdvqlMisUCTE4MD0O44snG7ah5CDuKmEXea0V2PTBAKZgeMwKO
         sLaA==
X-Forwarded-Encrypted: i=1; AFNElJ/Lf3CyEyrJmSkZfAkwxdbJ6VeL560Y5sLkiRg/zxrHqXXbd8+IksF8Rc74pBZw8Efhziis1ypa5gh1lA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1M7bvRcgJQWvRO/9my7jgx6+gc3Xv1oRhBRd3RiVlbt+gk6nI
	js9+KorTnFiUtmWrgETBTdiPICwEdZtZsZdmcEakaaPf74vttNqZ6P8QLYioubOFE447dWznC9W
	RpsyU/nWMNkz2JpAkooQZ9F0Pqjsrkn/oKXMMY7WulbMvTgHtshVJii4=
X-Gm-Gg: Acq92OGXZmCfKaJlbX/BNLVuW5sUVOGVIB5F30crZUnYZYqbn9qIjizLVqgC5c4OUw0
	9QnkSnGdtWCDt98hZHS3NQ6FxkK52ncAFRWSF2pZxaqIfqDVlxnmD2P2X8eLBMbOFFdqVQ9IWjH
	q7+12CWH8JejI68cg3BSDf10S79LruF4IFNtXIxBomRJy4zh0inp/BBGaYXbHO85Ei8BACQFQGf
	NAF/5nPXa0Otx7YGo08vi0kq8AF4i8NfLmEIKGX30iOJdoT7dOav6EQQOmqTERq2oxDRx+Th9Kn
	W8H7YCUK/xxMbxu62UMUXyf2pbpT
X-Received: by 2002:a05:6808:180b:b0:479:f928:44dd with SMTP id
 5614622812f47-482e55aa13fmr7127510b6e.1.1779211826010; Tue, 19 May 2026
 10:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513182924.1753582-1-csander@purestorage.com>
In-Reply-To: <20260513182924.1753582-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 19 May 2026 10:30:15 -0700
X-Gm-Features: AVHnY4IdielbYchZmLgL1L_n9WgVYxRpcXUHu8srIr6nbv0PX5Kc5MQ0-lP0oXo
Message-ID: <CADUfDZqnHaNCT7Y9GqmAKZn+2oXVEfXCa3dPL4JYLtue7c0GOg@mail.gmail.com>
Subject: Re: [PATCH v4] bio-integrity-fs: pass data iter to bio_integrity_verify()
To: Jens Axboe <axboe@kernel.dk>
Cc: Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,
Gentle ping on this fix for 7.1.

Thanks,
Caleb

On Wed, May 13, 2026 at 11:29=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> bio_integrity_verify() expects the passed struct bvec_iter to be an
> iterator over bio data, not integrity. So construct a separate data
> bvec_iter without the bio_integrity_bytes() conversion and pass it to
> bio_integrity_verify() instead of bip_iter.
>
> Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v4: split from series changing ref tag seed units
> v3: https://lore.kernel.org/linux-block/20260417015732.2692434-3-csander@=
purestorage.com/
>
>  block/bio-integrity-fs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
> index acb1e5f270d2..0daa42d9ead7 100644
> --- a/block/bio-integrity-fs.c
> +++ b/block/bio-integrity-fs.c
> @@ -53,21 +53,25 @@ EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
>
>  int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned i=
nt size)
>  {
>         struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
>         struct bio_integrity_payload *bip =3D bio_integrity(bio);
> +       struct bvec_iter data_iter =3D {
> +               .bi_sector      =3D sector,
> +               .bi_size        =3D size,
> +       };
>
>         /*
>          * Reinitialize bip->bip_iter.
>          *
>          * This is for use in the submitter after the driver is done with=
 the
>          * bio.  Requires the submitter to remember the sector and the si=
ze.
>          */
>         memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
>         bip->bip_iter.bi_sector =3D sector;
>         bip->bip_iter.bi_size =3D bio_integrity_bytes(bi, size >> SECTOR_=
SHIFT);
> -       return blk_status_to_errno(bio_integrity_verify(bio, &bip->bip_it=
er));
> +       return blk_status_to_errno(bio_integrity_verify(bio, &data_iter))=
;
>  }
>
>  static int __init fs_bio_integrity_init(void)
>  {
>         fs_bio_integrity_cache =3D kmem_cache_create("fs_bio_integrity",
> --
> 2.54.0
>
