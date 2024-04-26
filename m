Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F113AD25
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117385; cv=none; b=mtE/Fehk+KZemX/AX/xrqcy3FLbv96ZM8TAWj2yuscsrrbViSkZ8tAhzP3Htbh0QCEY7cU1KCsYniSpfWiImyq1HJ9PJlk1z1wDFdlAwPGCgAmoOhOtElqpyHFlk5l5dn2kVM0EVdOQEq7IcwojZsL1a0ZdUvJNVnUKDMsBTbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117385; c=relaxed/simple;
	bh=VQQoZinrx6eF8/WDvV2KmIFZfObV9J50L0ifIq/ItLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngArgMtSFtXnEFqeSrMzCoECPbii0QkpcAH4833axJQVLvmyv6rK13AX9aTSpqbsCpnHHx4eWP0h9e9rSyfHcTvqwMvp2M0tkpH+RJGo0nYVqYvgTRcKuzNdsG+rCrAAEE/5EVCHQKGqePds7yBhm6A3+D+ceq6y8/d6QTfhhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kt+7sc7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kt+7sc7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714117383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0zKXVFJCbYZIWth0JI7Xe1cYyLNrp8DmC+q7qeKe/Y=;
	b=Kt+7sc7gHc+5srv93KznngIO7CgfcU83zcZaRPr7ZdLhqr2E6WcErIcjkiHCEpNJWy0aZm
	oR2KN4LhWYA9grAOLZD22M7xbo3cPPapvPQQHyff8dMDJPefGW8HLLRzi2tOQkkeh9caYg
	N9Yus4g+TH1tSb7crBf/ijxvTuKh+oA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-7GHh5ZavPOm4g4_6QXN9ng-1; Fri, 26 Apr 2024 03:43:02 -0400
X-MC-Unique: 7GHh5ZavPOm4g4_6QXN9ng-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a2f7048a7fso2093048a91.2
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 00:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117381; x=1714722181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0zKXVFJCbYZIWth0JI7Xe1cYyLNrp8DmC+q7qeKe/Y=;
        b=qlgqtDKFzSdealcXnqowTbh77x/sZO5n71pPydmt4ZZsR7sl8KIxlzgle/E0/6Ug4n
         mUpWx5GpMP2uxmEbGUqjyfapD9LLyfu0lhDy9pADW5QkF1ArWNDNEKxHzZx8S8i0sOSx
         c4dlaztZnOQMrg7esdinhB6q88nF2UPPK9cc3hdwGsk2eD0gBedtIya6Tw/ATA+Yr+EX
         Leoq7FQZZGb5CCx0c/6+eKcQ61AARW4CX6cvdfrf05BfUIgeSU2jbgmCrdwBKDVpqil6
         JTfoTMbAfwmleACHFF0UndiXc/jpdtv037mAF49EdgJo71AQY7CDZe48n3ZHuRIMeKkB
         CugA==
X-Forwarded-Encrypted: i=1; AJvYcCXXfXZteq9W3VwIrKWAr9wMadbTIYdezIn70LfRgJQbn1tXhcW7d8OtZseIjadzWkowAtOniShy1D+Go5ZrCIoqYgkyhYZxApeKCxs=
X-Gm-Message-State: AOJu0Yzgc+pboR0VazoYB+eDOJoMcwoONTLlbC0Md+SyPdTM9izW3l54
	EzWl8wBjQrsE3fScKZJGhghB1f7eiRUt4ctkfBLtsMxVIVUo0MtXyc3f+XI7Cz2wCbI4C2MXpzh
	Cq3es1TWD/qoLDafuSJzOKOxpKEUrn4ommxNQ5L6Kq5wpIem4WAMq4Vw/Q6m8gPynCAdCI3nC2a
	9zoxdvXcjZia/eKkPONr5/Zzp4tkc4BSSRT7mHjpyibdFyahBv
X-Received: by 2002:a17:90a:4302:b0:2a5:d7ed:2d18 with SMTP id q2-20020a17090a430200b002a5d7ed2d18mr1989062pjg.20.1714117380726;
        Fri, 26 Apr 2024 00:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyBnxZ/9saxfnK2TeyNk+eigRd67lzQ6tJaldej98QINwsulEYKbul+7eP9T9HCJWgodFpXgG02QpD3gmVLcc=
X-Received: by 2002:a17:90a:4302:b0:2a5:d7ed:2d18 with SMTP id
 q2-20020a17090a430200b002a5d7ed2d18mr1989049pjg.20.1714117380330; Fri, 26 Apr
 2024 00:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5fec079dfca448cc21c425cfa5d7b291f5faa67.1714046443.git.johannes.thumshirn@wdc.com>
In-Reply-To: <e5fec079dfca448cc21c425cfa5d7b291f5faa67.1714046443.git.johannes.thumshirn@wdc.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Fri, 26 Apr 2024 15:42:49 +0800
Message-ID: <CAGVVp+UyW8a8MNeet66UWUhgB0+gBWCh=_wbN=18tpbQO6_EKg@mail.gmail.com>
Subject: Re: [PATCH] block: check if zone_wplugs_hash exists in queue_zone_wplugs_show
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:02=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Changhui reported a kernel crash when running this simple shell
> reproducer:
>  # cd /sys/kernel/debug/block && find  . -type f   -exec grep -aH . {} \;
>
> The above results in a NULL pointer dereference if a device does not have
> a zone_wplugs_hash allocated.
>
> To fix this, return early if we don't have a zone_wplugs_hash.
>
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Fixes: a98b05b02f0f ("block: Replace zone_wlock debugfs entry with zone_w=
plugs entry")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  block/blk-zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 3a796420f240..bad68277c0b2 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1774,6 +1774,9 @@ int queue_zone_wplugs_show(void *data, struct seq_f=
ile *m)
>         unsigned int zwp_bio_list_size, i;
>         unsigned long flags;
>
> +       if (!disk->zone_wplugs_hash)
> +               return 0;
> +
>         rcu_read_lock();
>         for (i =3D 0; i < disk_zone_wplugs_hash_size(disk); i++) {
>                 hlist_for_each_entry_rcu(zwplug,
> --
> 2.43.0
>
>

Verified the panic issue was fixed by this patch,

Tested-by: Changhui Zhong <czhong@redhat.com>

