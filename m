Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591415854A
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789432; cv=none; b=fvrKkXD4Z0To6/mCU+vOHZGAf/nNxXBRcIRg9YeRnyqtmUL/xYRJJ+eTCco2MYR/+py+xUzkmDJb4MDDmO8ynDduetcc5XZk6kUW7NQjZLVxl7cPkCpCFHcb5sJGHRz7OEXbocSk/azj8u5wjMDz8ZdynFPLJ2lvEmusv58mEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789432; c=relaxed/simple;
	bh=kC1H1HmO8U7oHxgMfVCQTUtV7ITRvNx3I31XfNRGICY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sW8ykoNIM4VUOs1cGrckTsTjWFl+oMRJEH2Yz1IprXG/rBYr7WBErSyseCwjAZzxeOXl9tWN30tLW6uxLwH198MTqCWFNUe4lNoCyITKWJRX2OeBh1b7xfSg36SOVlvCAK4JS6V+h++IS2HGW5XsU8dyfHJkvbtheFNrdKJIW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ro35v9WG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro35v9WG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732789429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkmr2+feEdXbr/5zJeyhstbFoivj8FethD26ke+CuOo=;
	b=Ro35v9WGCszzJp4SHsuCKT1vodeXePYgt5Y0kPV+rNcE6TLS/3g/68lZYnSGlLe3Wb3hn0
	XCFMUv63GerGyODJ+rMrY6UJHxR9k8ZXQjyvZoxSyS72Ck25ysdsWanvoQ5s/eqdh3GG/c
	DVkkodUbzogIb7dlWpfrj3FJFP4HYSY=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-6_y1BmCcNoOjdjXZmhvVNQ-1; Thu, 28 Nov 2024 05:23:48 -0500
X-MC-Unique: 6_y1BmCcNoOjdjXZmhvVNQ-1
X-Mimecast-MFC-AGG-ID: 6_y1BmCcNoOjdjXZmhvVNQ
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5151638fda1so1031124e0c.1
        for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 02:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789427; x=1733394227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qkmr2+feEdXbr/5zJeyhstbFoivj8FethD26ke+CuOo=;
        b=SjJ/qwNdd+x7jO9RKYzU6l60knfp0assNGIrmNR708K7qSb8gK9jzWH9WodpfevzPF
         M7SctehpkD6JJLt2ScDHlrGTF8dFR8ggC81fk+WjZfiOZNRB+Adtomj0WrwLMpAKX0XA
         DQyfDphcCPlHGg5TlNhSudnwyY5c5s9u0u8l6j//kWtimOU37zTiX+ykF/epBZ74wFjv
         F1JrWBpbVY9rlQ8TZe1hUACehRPD04Ox+sBuKlF1jXs2q/NZ1VpzS+FsfdNuZm7OSDi1
         PJ/Av6HaZ6yvtsTebscBsnQq4IxOQZ+aC2cprnmBzI3S3UrB8N+m8J8yXx7Bz2ZuVaCJ
         +zKA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6d0nFSzO554z9xDjIullCdbX9TGb3fy73zPsLYte1R7gvsYdDtoICWy1P4q77GcAC1LoEHoYXN9wgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUIGrc90WqXedQKisXqDm76pJR0sL7fC2k+ehOpzEukA3hdHV
	mFQX5xrQk5KU/VOK6Y9ZisPenqJNOccW9yWku+DgywwsohEPtuMh10FUQXfUUTOq+eRZTA/ARJ1
	kC45Dwu1DAluuTSSLOrvJ0Mnelf+g4GlulhD7nWh+3xcukvt5XCpa/RkBiI6FqHSsrXVkQkmagE
	em3FJOaipoFBHB+pJzQDdE1f4YS1rFQZMskNQJnWxT5AM=
X-Gm-Gg: ASbGncsgzE7SJ1VnXLc36yU2mKNkIpEAJrtx9lC4IbTeqh8nbYdAeqr97ZRHs1pt/k9
	XvL+Cz65k0FbFLLZwSCE97cuAxDO3LA+p
X-Received: by 2002:a05:6122:65a4:b0:50d:4b8d:6750 with SMTP id 71dfb90a1353d-5156a8309e6mr2727687e0c.1.1732789427218;
        Thu, 28 Nov 2024 02:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMk856e8hanKU5TDNtQvKVA2QWMrLrb8D8m1njaV381GFpzrIstv+PJq5rExSvXOUD77BVDObiKd74qmeLiII=
X-Received: by 2002:a05:6122:65a4:b0:50d:4b8d:6750 with SMTP id
 71dfb90a1353d-5156a8309e6mr2727685e0c.1.1732789426967; Thu, 28 Nov 2024
 02:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128170056565nPKSz2vsP8K8X2uk2iaDG@zte.com.cn>
In-Reply-To: <20241128170056565nPKSz2vsP8K8X2uk2iaDG@zte.com.cn>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 28 Nov 2024 18:23:36 +0800
Message-ID: <CAFj5m9LLPEfph+U-0n3p9YeXg8tOeBD2fdZe0HheYVFSsw68xg@mail.gmail.com>
Subject: Re: [PATCH] brd: decrease the number of allocated pages which discarded
To: long.yunjian@zte.com.cn
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mou.yi@zte.com.cn, zhang.xianwei8@zte.com.cn, 
	cai.qu@zte.com.cn, xu.lifeng1@zte.com.cn, jiang.xuexin@zte.com.cn, 
	jiang.yong5@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:01=E2=80=AFPM <long.yunjian@zte.com.cn> wrote:
>
> From: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> The number of allocated pages which discarded will not decrease.
> Fix it.
>
> Fixes: 9ead7efc6f3f ("brd: implement discard support")
>
> Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> ---
>  drivers/block/brd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 5a95671d8151..292f127cae0a 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -231,8 +231,10 @@ static void brd_do_discard(struct brd_device *brd, s=
ector_t sector, u32 size)
>         xa_lock(&brd->brd_pages);
>         while (size >=3D PAGE_SIZE && aligned_sector < rd_size * 2) {
>                 page =3D __xa_erase(&brd->brd_pages, aligned_sector >> PA=
GE_SECTORS_SHIFT);
> -               if (page)
> +               if (page) {
>                         __free_page(page);
> +                       brd->brd_nr_pages--;
> +               }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

