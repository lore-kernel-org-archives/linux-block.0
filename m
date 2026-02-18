Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0923340A67
	for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426966; cv=pass; b=daxQWr+CgH765U3VQD4LIHlmcvdN3IwmdAho+lsKXIbAzFtDzfYLcGjs5us8JzN8RyKOP+++9tOfXX4sEJ8CTJgExlIMOJWtjf8GZT5IvlozpVOmaenNgsv+bk1Al252E7WIiT1C3ORVfW4CwdEXC3M74WT457xRWPyEJRnMTs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426966; c=relaxed/simple;
	bh=udw/ZyTsHuwFOVBESJ/+qihOlfdgJM950rv/L+IknkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEInZjUh4nlQj7bIw67NslD7nhUJSKOMbbo7Ba5yMwCixy+hjRSF9TPhmrQvpNegfFu4Haixl+I4eRiLgu/ClxPVr+fj+HLx4M5KhDEabyvZj6D5+wh1ZVJ4IjtC8kYHJe4BXPZmfaufJrk2RGCykkS0Dvld2Z4LJxAeS+xrLZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V+GnKqXK; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V+GnKqXK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837584120eso36733825e9.1
        for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 07:02:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771426961; cv=none;
        d=google.com; s=arc-20240605;
        b=CpH28x5N1sgSlhjwqQlkpGfyvHSp3CsRt99xKyvo5Fuxj3rUkvZrvR/cEAF+CR0PIj
         2iLbUB0lB8DVph4gSSnhOk3zaZeSTNieYmJtgFOAWj2SJnQzV9f6JqvyFWx6mp5thhhE
         CfhVw2sWY3bX+nBlsVD3EV9plI/K1dXNGNY/DTKsV7IFuZs/IGaiJOM5y+Z6noSpaHg8
         ATxLWR3fPDDyo9EpDVIZEEn9IGDqP8x9SDYvi8HKQQ70OlHr+Efr2PVh+nVrI5ZMcpGf
         g6vS3/xrinhOktGe93CZU7/ADkj8Iq/XZiPbiB7pMhYYd+iJG3CNFy+W7+7Hn+bCE4Jy
         L1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4f2knTNw8Y0yBkMXA6kc+4x2KQKgICuj4A91rn0T+Sg=;
        fh=pU123Ms+VTmuq/bJ4wkKpq8ejlAMpkdLkjSd6968zCU=;
        b=DbzRAjU+RzqUMwQt53eD6X2n6uKBeUAM8mGpLTT8oapJ3S9P5cmqLuIQSkc1dwhjJ7
         oN2HiElD0oZCDT1H8fNJaLr5yzo9KcW+HlPdd8oaSKRgP+kr8H8iJPG9XtoNwpiP6lza
         AJ81NQKlk8sSft+HILt/BfubJcGe1MgCP61pJEYs7zntT7Oz/3kzPeUS3PoIQbNmMzxF
         sOt8EFzcbYA3XFlx5BvOZjhvsSwqBwQ30pj8Yv3DZ7I61fIfepcxYGXrC5GpJTCM6mjj
         nW9ekloA1wSCsjgjNkcSaiPhICEPQpSRb+xg8D4gGbwSLk7FsMt+rR53RC2Nh1qug56S
         AyJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771426961; x=1772031761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4f2knTNw8Y0yBkMXA6kc+4x2KQKgICuj4A91rn0T+Sg=;
        b=V+GnKqXK60xaSJp2fZlMcxdqrWZWlyuvIxe5b7z69Ycpo06PAVrcE3DCVe/4lZrO/h
         a+LO52LcjnX8RPeBK38FQIbRW2t5p4QgITq+b/seBVc/nm8DgOLLqche7ucqkW+eNFTx
         86b98NQeX+5wShMg78VxLBTt2Gb3pkePa66IxvmX9wLJtxCSESq+Z6XCorkI3JvF8p4h
         JDybHtZvBeRBUu5TOfSx6DYsqOBLm76/FxdI0/8LkqE4wQJ6UVd2/wkTRxhETewCN9DT
         rxOCv/fQG2yvP1X6FKrQGxkEixttaZJdnZ+xExYL17sx/PL1qn8HaPZwO669LT/7rci7
         v2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771426961; x=1772031761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f2knTNw8Y0yBkMXA6kc+4x2KQKgICuj4A91rn0T+Sg=;
        b=wGsZ7IM7yxJ7IJsT/064+8Vp4AbxOXO8ZswPq3NzDKr9X9cCsyyDNUFoirV7Am1GSG
         Jtqq1LEzI6gFa5pPMB9c3pjwbRcA1ynOB+XeQYN1fFh8FCwT5GrypTtTXW4dqlpZCWzF
         Rn6kSDJ25M6njROncPdsRqflOJCOmzYm4HAG5ouIfW9Uq4y6t+tm885kbOT8e2H9UOvb
         DU0Fo3kipE60oZSlULznBHNflIs+zGVzl4b9iIRhRhN31aYt637DQ/m78uuQMRO3Qq+/
         +9xp7Vo20Sb62TJTwFjtoC2BK9vM3Ko163gxi2eNdiJmZtmgTgCjcmdra+x4AOUinmDp
         j/NA==
X-Forwarded-Encrypted: i=1; AJvYcCVvPwxNQVrwehSAO51rskyxSwGzom0fj4lJ8rkZzZwPbBWONdX4Tioa3/6hwa5spOxch46luDROJizAvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ceLDl9vPyxqKe6ga5KaCyHQv2LLKyEEnvhHuYyeokVXr/iR2
	kF5xTKfV78ldEZVqljQyEVAQaKmJsheRhNOmbHsC0w/07WamCc5zeYEe7ugllvTsQ0P3a+V7dkb
	Icq8b+UvIBv0h5lblDxej2C56ocXAuGQNcCoK0wtgKw==
X-Gm-Gg: AZuq6aLVMa90I+DjYRaF/ypFZWyuaRdXgAs9ScboQIay2TJHAK2qy0nNWsDcCYv1FRw
	WvNiSCiTt9QoWHgoWwnjf0eWVut9oG11Ma2tLutPtw4r4wMBF7zUnAS/h2Sp6Nsggs7dyjSChR9
	WorNKSN3ulRbv+yVmCRpuF8XGuEy4PvZHYUZVusrk/ZWoEaGq35l9HWQHrz1cVSD2S+M+NWCCEk
	qsog3a1GvR7AhS5DpGiBbQ2maC6Ky/B0hCnqtVJBzYI/56gJZPKxMaGgxEcgTga1hHMSHoYvQ7D
	AM8yeeYHbEUgyHgSYfssiqt4rZwhEE86CSomflncwutEppg+/nXrl8LT+C0dzdk0QZmPrmuKb9X
	ZfOlV
X-Received: by 2002:a05:600c:1c25:b0:483:54cc:cd97 with SMTP id
 5b1f17b1804b1-48379bfc340mr230018315e9.36.1771426961169; Wed, 18 Feb 2026
 07:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-17-neelx@suse.com>
 <20260208152448.3300594-1-clm@meta.com>
In-Reply-To: <20260208152448.3300594-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 16:02:29 +0100
X-Gm-Features: AaiRm50heuopm7EY7a7udAfEdRYxhS7H4B61tJOKCzqxGFffQrIvg06EGcnPVCY
Message-ID: <CAPjX3FegzEdCxfBq4mqW2mP_GDDuyS4NOQqgDThWdAHhr2tCOg@mail.gmail.com>
Subject: Re: [PATCH v6 16/43] btrfs: select encryption dependencies if FS_ENCRYPTION
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:25, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We need this to make sure the appropriate encryption algorithms are
> > turned on in our config if we have FS_ENCRYPTION enabled, and
> > additionally we only support inline encryption with the fallback block
> > crypto, so we need to make sure we pull in those dependencies.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit 0ab45d92f6f53371d87e1a302f09b56218d02546
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: select encryption dependencies if FS_ENCRYPTION
>
> This commit adds select statements for encryption-related dependencies when
> FS_ENCRYPTION is enabled, including encryption algorithms, inline crypto, and
> the block layer inline encryption fallback.
>
> > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > index ede184b6eda16..216a5707b099c 100644
> > --- a/fs/btrfs/Kconfig
> > +++ b/fs/btrfs/Kconfig
> > @@ -16,6 +16,9 @@ config BTRFS_FS
> >       select RAID6_PQ
> >       select XOR_BLOCKS
> >       select XXHASH
> > +     select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
> > +     select FS_ENCRYPTION_INLINE_CRYPT if FS_ENCRYPTION
> > +     select BLK_INLINE_ENCRYPTION_FALLBACK if FS_ENCRYPTION
>
> Are the dependencies for FS_ENCRYPTION_INLINE_CRYPT and
> BLK_INLINE_ENCRYPTION_FALLBACK satisfied?
>
> Looking at fs/crypto/Kconfig:38, FS_ENCRYPTION_INLINE_CRYPT depends on
> 'FS_ENCRYPTION && BLK_INLINE_ENCRYPTION'. Similarly, in block/Kconfig:204,
> BLK_INLINE_ENCRYPTION_FALLBACK depends on 'BLK_INLINE_ENCRYPTION'.
>
> When BTRFS_FS=y with FS_ENCRYPTION=y but BLK_INLINE_ENCRYPTION=n (which is
> valid), Kconfig will generate warnings:
>
>   WARNING: unmet direct dependencies detected for BLK_INLINE_ENCRYPTION_FALLBACK
>   WARNING: unmet direct dependencies detected for FS_ENCRYPTION_INLINE_CRYPT
>
> The build will fail when compiling fs/crypto/inline_crypt.c because
> BLK_INLINE_ENCRYPTION guards the required function definitions and struct
> members:
>
>   fs/crypto/inline_crypt.c:259:15: error: implicit declaration of function
>       'blk_crypto_derive_sw_secret'
>   fs/crypto/inline_crypt.c:317:9: error: implicit declaration of function
>       'bio_crypt_set_ctx'
>   fs/crypto/inline_crypt.c:418:45: error: 'struct bio' has no member named
>       'bi_crypt_context'
>
> Should BLK_INLINE_ENCRYPTION also be selected when FS_ENCRYPTION is enabled?

That's correct.

--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -18,6 +18,7 @@ config BTRFS_FS
     select XXHASH
     select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
     select FS_ENCRYPTION_INLINE_CRYPT if FS_ENCRYPTION
+    select BLK_INLINE_ENCRYPTION if FS_ENCRYPTION
     select BLK_INLINE_ENCRYPTION_FALLBACK if FS_ENCRYPTION
     depends on PAGE_SIZE_LESS_THAN_256KB


Thanks.

--nX

>   select BLK_INLINE_ENCRYPTION if FS_ENCRYPTION
>   select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
>   select FS_ENCRYPTION_INLINE_CRYPT if FS_ENCRYPTION
>   select BLK_INLINE_ENCRYPTION_FALLBACK if FS_ENCRYPTION
>
> >       depends on PAGE_SIZE_LESS_THAN_256KB
> >
> >       help
>
