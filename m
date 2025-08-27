Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD86277803
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264403; cv=none; b=VO/cBDTKBCmX0NCRdqvv3uUtV9oUB5ns+gH3wPU+VdLC2q+WCVqhbei3jAoSPAnQEV38H3FFPOsK8uyXOuEIE+PrHBp5ASpJE4j6rmWu6QoCsvCF1/jwJt8JRob40C4ayVzU2BL0go3zInuXsZKW/uCpIc6WMaY/2h69+ixeoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264403; c=relaxed/simple;
	bh=aPLKW75+adg0/YV0HGh5cTV3gO1o8TBBS+Dc+9jK/G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGT2KHlbsmaTHiDYTJRY+olqarGzHwE2qIaBSVsNls3a6Brx91woo99mre+2fWpEKp+Z7h7EghBWPZt0U28QEsj3fi7RrZk9NPK5AVaCsl7kXxU2b5IXULuUu1b301+JncnHqlmcG9X/KVe3Z53ZmzimlMcQWOKCsIjYxZmEFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpPZ7hCp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpPZ7hCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756264398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg12dc7FGsxg2cEXvFrtAlEITELVLt1bMnDwTAUgL2w=;
	b=HpPZ7hCp9Sx8JxoDem3TS1d4FvySc5fbW0WeFSGeivssbFrcKjtll+0b/BQr5LBA9NPWhP
	Db80YYD6+WsQwN+KWXFwNVZA267Zu2cQBeK1+xCFC72QK4palKW2sZwoRsjPpPQhCHQoMn
	+i/noNjmaiCpuv+1caCeKyn9hUqbWo4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-dfW0zjjYMcmFdUEX-WsyGQ-1; Tue, 26 Aug 2025 23:13:16 -0400
X-MC-Unique: dfW0zjjYMcmFdUEX-WsyGQ-1
X-Mimecast-MFC-AGG-ID: dfW0zjjYMcmFdUEX-WsyGQ_1756264395
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3365be0c13aso11125841fa.1
        for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 20:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756264395; x=1756869195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg12dc7FGsxg2cEXvFrtAlEITELVLt1bMnDwTAUgL2w=;
        b=khGgDmsOlhPjPK3cmQqfgftB4iOAen9f5En9vxWRRa8nkyYXKHklkBcsLI8VUTDCIv
         BoC+YXR9eHIVLIRX5H7wEIDHpB/1VSdkGKE4yf0JD6gytasPUS6lfuJpwaO9WVdjO6Il
         9cJTL0rBrkz9j5F9S92TWT36NnDOIf3mrGcy7C29q/h+cKjo0KZ0Xqeq4dEeShK1AjHd
         sIoLZKYom2XgxVsBjAkqV2Eo2x2aJH2TqSI/7LlN+hca3zey4E2IjGUPFSwjj2WB5136
         s8FKBcYI+Tg/WwdVU1beZNrMMDH14Jk+d2HuXW2dGYkgn/3/P25FQI3ayp4iu57vG98w
         puSA==
X-Forwarded-Encrypted: i=1; AJvYcCXGrT/mY53lsgO8rVZvllqYxUZkiuoBOeUGrlN8PgvXT5Pxtukil+ka6JK7+ATWF1JoRmKt0VhXCoUu6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+p9CjAmdQ34WedkGr9DVfRo54aLmQWCFYTqNmX2DMJJ2jyTCN
	iWcsNSkSufHnS0d/v+TpvAMk9QwLzT4vlyWpsQ6iQD0MwQKNlkBiypX7WzphSGkpifQgBLVJ7eT
	pgBnIWg64NO0O7iBLeJjG0qcoNbNozuP/9H1HFnrHZ1UYufXONqkEghniF6ldGNmLbtmwdlfGsC
	WOTgqqmHSUe/viJq7kVibUufJ1eEAFAIC5d/6efPI=
X-Gm-Gg: ASbGncv+D9s4btUJUALz5IUTJvkuQTlbcgtNu10vy+DpTKEdTxTZW6PtTjbSU076+uR
	7Bz1bvuB+Z+4HInZa7S1u4Tm7RSFF6Ac8GoMQBHzC1qyISlfWaoPNZIb/1YiaUFC4HkBPPXrf4U
	itp4xKP6cMZ97FMFy19DQrVg==
X-Received: by 2002:a2e:bc1c:0:b0:336:6739:bfb3 with SMTP id 38308e7fff4ca-3366739c241mr37467261fa.42.1756264395308;
        Tue, 26 Aug 2025 20:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwL9asrCb30GtiLU63tnVNtdXq6YLZHU/N4ALzSlaz37rXXjcT8tNliezQroDpGEELRyoE/R2PLgx6pJiOvlM=
X-Received: by 2002:a2e:bc1c:0:b0:336:6739:bfb3 with SMTP id
 38308e7fff4ca-3366739c241mr37467191fa.42.1756264394875; Tue, 26 Aug 2025
 20:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827025939.GA2209224@mit.edu>
In-Reply-To: <20250827025939.GA2209224@mit.edu>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 27 Aug 2025 11:13:02 +0800
X-Gm-Features: Ac12FXxyq0rlPWzcAsl2hibY4PT_vpCJFYSBtvC5vmWqeafX1BtyyM-a6hwPslY
Message-ID: <CAHj4cs8BWKXQfch8EXQVZLDD51uMg2yY9caOsb0b3n+uTXXaMQ@mail.gmail.com>
Subject: Re: [REGRESSION] loop: use vfs_getattr_nosec for accurate file size
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Rajeev Mishra <rajeevm@hpe.com>, linux-block@vger.kernel.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theodore

It should be fixed by this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-next&id=3Dd14469ed7c00314fe8957b2841bda329e4eaf4ab

On Wed, Aug 27, 2025 at 11:00=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> Hi, I was testing 6.17-rc3, and I noticed a test failure in fstest
> generic/563[1], when testing both ext4 and xfs.  If you are using my
> test appliance[2], this can be trivially reproduced using:
>
>    kvm-xfstests -c ext4/4k generic/563
> or
>    kvm-xfstests -c xfs/4k generic/563
>
> [1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/gen=
eric/563
> [2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-q=
uickstart.md
>
> A git bisect pointed the problem at:
>
> commit 47b71abd58461a67cae71d2f2a9d44379e4e2fcf
> Author: Rajeev Mishra <rajeevm@hpe.com>
> Date:   Mon Aug 18 18:48:21 2025 +0000
>
>     loop: use vfs_getattr_nosec for accurate file size
>
>     Use vfs_getattr_nosec() in lo_calculate_size() for getting the file
>     size, rather than just read the cached inode size via i_size_read().
>     This provides better results than cached inode data, particularly for
>     network filesystems where metadata may be stale.
>
>     Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
>     Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>     Link: https://lore.kernel.org/r/20250818184821.115033-3-rajeevm@hpe.c=
om
>     [axboe: massage commit message]
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ... and indeed if I go to 6.17-rc3, and revert this commit,
> generic/563 starts passing again.
>
> Could you please take a look, and/or revert this change?  Many thanks!
>
>                                         - Ted
>


--=20
Best Regards,
  Yi Zhang

