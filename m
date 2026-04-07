Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3D3CF694
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580545; cv=pass; b=DBrOjg3X+oFn3PjZLF8rd5cUrUL+DypyHKllkSwuGOR0TOLHtrrun8U9eNLIuoXOZbjp4OlqL40e9HmWuqMIhzTOhFL46oUwAKC8MZi4Dy9popL8eJVgOYIsrD87PRZfw2RkQQnLdjryS8N4OuHhtr6bz5Z4IPS0EV7Ek9rrgjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580545; c=relaxed/simple;
	bh=nvKu8su4QhAoCTShBYhb8X1jBL0vWh/vW/5aUOBwMVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH3exDMmrCU0e4AnLpks+cfRE0XMezLtJpGUst/v2b/LDovqz1jsfLyZIsf4ZtCM0N6uDqdOlHj0kuLZocyCzoE/mqKj64e+FAEJ4DV6YmtY4b/aeh+jJYhCO+6LK0qEEpSQHcscmIcdJpYw1j8W54E28ZnKnRTlMx+BIERk/IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eFq1jPuB; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eFq1jPuB"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6828cffbcd4so164000eaf.0
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 09:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775580543; cv=none;
        d=google.com; s=arc-20240605;
        b=cTIBIjnvpI4FTN82zsbkK0v4RkLN9AJ4FdxEGestXsQWABzxTEFAksqnIcY0bYN/V9
         OcN76sdDGdJvfSZU3C3MHwBrKXVOHEztZNqeEygurh/AcKM5m0kDXHJ4nHN13y/RxsVr
         UNzzdqeiP+3Wn8q2fdeoETViBkH8Iujle8LckF5bBGGIrZGb1pzwmrcLfCNDga1jAwFA
         LYDAjPboNwDMXKPzffPKk7tXgy6FLEJKT8C3gl2KJQb5rYg1UAESD1nxhkIvPESpvnNF
         f+/Bce1/DdT060XXRQUdU18zzGq0zybTJhb9Hu0FJTNtx8+u33gF8b4FkjI16VgDajiO
         aunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lazOyKwXnU60c9GoYfvLsxP7atxxk5CZ7DnVJNd+0g0=;
        fh=mg6AhV5fE67poHI+3Dkut942JE/37lLTvbzm4Up8zyI=;
        b=EY+2+DBjp80cUNC9agwRxkve8PsC7DjU0QyvySNLzDCeNqZTDTcAFqMxLV1d41tryx
         AMwcZ0m3NYvD3lLj2avOGg0Lzp7HKzXMwkHa7+VWmehWN1cII7jH4AOpkvULy/3+PGXT
         Vy6lEVhiSQT3T08sh+fX3JSGiU0EfZnisVefaouB7q1zkEmn2R7Ikhcu3Iy8EQOuyQT+
         oSNIVi8wgM00h5IUfTIMICFVo9HNlaA66Mo7NPIlJD82/Ob9SeVCZeiDeC8hYaUh5sQv
         5V+boO75oMBS1/sRRhMnx+f8RhGyCFOzruvOfGN/yHT/OgEe47LqT1ER8g5y7GGQ3imW
         AdAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775580543; x=1776185343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lazOyKwXnU60c9GoYfvLsxP7atxxk5CZ7DnVJNd+0g0=;
        b=eFq1jPuBo9/nXQu8b60SkzvJFVvLT/scrknaWk9UWNYCfgUBW8Ti7quPN9bDkfYgzN
         uDYU2CfoHdsBOL6mFDdh6tOjRLDJVT4p4QnVuQtN4Rw2haHQ62Stc+nymwh80Iqa/kwD
         sprpBmnP8iXMOpqYmkP80fJHHI0Ggke/VCUn4bHfmT2MMqGcu+j0lgDmkCMHMLG2DC10
         pfntEZI9ssUP6X7W8vdJxWpACRpfEKDp9jDutQ5M0bqoJnaK/X89rYIe8hekZzGSwm6r
         PiZcOILwEoNiHXFnDRT+L7WnUlPV6/w3YlaNcOTnfC31pEw2w81UXDH228q4lbhIPBSv
         TQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580543; x=1776185343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lazOyKwXnU60c9GoYfvLsxP7atxxk5CZ7DnVJNd+0g0=;
        b=VOqd7tvH120xz86jE25VZYwaM21rEXhSTZPo5tJ2W035NJe6MX8VYrhlV/hJ9Dyn09
         5n9M0rTf8uczSJ0UB9fxG2o4s2yFMuJLG1PccHyvRv8F93/ZKkCGLk5Aa7vmcRzNwzJ3
         V/QW3l0ZWnR7cvuGyRDb9jMf2g0IbshRH2/vbRnBCwTY7vzV06B3LFEJmBrCp7Klht4m
         KYFEDbYKZU7u09KOdaKSSAgKBP0x+JLYDe96qbsKXG+VkOMtyn1cePfreE60V3NKKx0J
         oxmQpY1FNgonUIW5In+PbNuD4x71dU7xeO4OYKqEkzx6URaZcP+v3N+i6iHlK9ve3Tfm
         jjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVITpQcQgtvO2LLlTGQzDxg1ITCLArmOwJSbaTd1Oi/bBf+y0NQ++LKrGEmNoLmUbpIbwA4zja+hwO7Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLljwhlK6vAXq0EDm8NM8r26JCPh3C6xhr6aH0NOYO69RCVfFV
	3JL6NN3FycvARAQhbmmQb2LT2m3wKmQdZ831HNHiG8iYSOCdnisg0B9dpGJpzdmlySXgVT3cWKs
	lGZ/jzhZSFvAPEZ6qGD5nQS+GEfyU6JatUpsNdZGKig==
X-Gm-Gg: AeBDies7TaToHYag0ikG6+Prr4pYjtrtniasDJok4hzcqVToI7VDqHJQl/TlmiqPa4z
	3El1drhq1//pv97TyqvkwZq45lW4vfCm+u4Yrv47uzUYb+jvPTAqYzCaE1HmmLpKZNnhbIhkQWc
	46FjPn87lYChBEToArwVEEJUcC538NqAQ81GE28nXsHrOnTO7k0CedTuoBwQBVHuvcII78NyTwH
	G7GM1ON4d80RZtqhvnl0VbpUZOOL7BA58k4yzt23VtCEPe0oJC8tfn+fASWTKJytc+ZkOvk61xa
	FnirgDYH
X-Received: by 2002:a05:6820:858e:10b0:67c:3021:908a with SMTP id
 006d021491bc7-6821fa67067mr4123248eaf.3.1775580543405; Tue, 07 Apr 2026
 09:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-3-csander@purestorage.com> <adNUE67FpIGF_x7Q@infradead.org>
In-Reply-To: <adNUE67FpIGF_x7Q@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Apr 2026 09:48:52 -0700
X-Gm-Features: AQROBzCt_NO9LdYduvYfMd8GPp7cOALx7rkbussdP1UbmbwnR15kmHFzXdPpfAE
Message-ID: <CADUfDZqHyTDO6aYed+mtChU9m3iPgW=hghwfifuCV8Z_CzxoFQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] block: use integrity interval instead of sector as seed
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 11:35=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Apr 03, 2026 at 01:41:05PM -0600, Caleb Sander Mateos wrote:
> >  void bio_integrity_setup_default(struct bio *bio)
> >  {
> >       struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
> >       struct bio_integrity_payload *bip =3D bio_integrity(bio);
> >
> > -     bip_set_seed(bip, bio->bi_iter.bi_sector);
> > +     bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sec=
tor));
>
> Should we simply switch bip_set_seed to take a bio bvec_iter argument and
> lift all this logic into it?  That feels a lot less fragile.

Perhaps I'm misunderstanding the suggestion, but how would that work
for initializing the seed from struct uio_meta in
bio_integrity_map_iter()?

bip_set_seed(bio_integrity(bio), meta->seed);

Thanks,
Caleb
