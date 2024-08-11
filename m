Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5BC6AB8
	for <linux-block@vger.kernel.org>; Sun, 11 Aug 2024 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723341824; cv=none; b=M+nkB4pS4yXdPrdi/0jY+2BwVYegRe3XR4ZELxBxOXoK2FjDsO/jamSfaNKwa0BJBU2zd42imQ6CPtOUmEty0MTyqHJpj1/cqUAYc/MiIVhASk0nD8iNhWghjm1GQ0R9Pjxvh43QhmqHkFTmCV/yhQirallr+i3WIzSkc0n7rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723341824; c=relaxed/simple;
	bh=ot0EAQwbev+udmLqRWxI4NRSmQ8yUYXZGnybEZsxokE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V18VjbiTFIRyLEl2vo7T3/tfY127yphwyLDa1OSo+8sfeshIa4boPBCpSIGTL36EPvvhVjvTyZtjBt6FHQuOMxN0kZfTMur3Q5hA0Fn/QylFuxUhlUMrCu5qQCNX/uJvchWiT72dcQ93XkKP2IWQeC6IRUAoEvCrns1uPF2x3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9CFp09V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9CFp09V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723341821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot0EAQwbev+udmLqRWxI4NRSmQ8yUYXZGnybEZsxokE=;
	b=V9CFp09Vr/ITSy7QUfxxrvbsqVQBLsSjL+sIZrxoItV24TpGyCvhIiD7NGAFzEfMSC8B69
	FEFIxkTK6N0/4HY1DMxdW/sP9BFFXE1wCLO1v/PYyFtm8WK8APbS/S7wLMsQKRJi7m16wj
	44YSXOorWLBGLcpHHFhw2/zCIVJ4r6Q=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-WWghZBmJPa-pdPgpTU3mhg-1; Sat, 10 Aug 2024 22:03:40 -0400
X-MC-Unique: WWghZBmJPa-pdPgpTU3mhg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8407b0b7b3bso83499241.0
        for <linux-block@vger.kernel.org>; Sat, 10 Aug 2024 19:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723341819; x=1723946619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot0EAQwbev+udmLqRWxI4NRSmQ8yUYXZGnybEZsxokE=;
        b=KqLBM9gvVjKvJ+VdbyS57dpjWJjliysle9w12rb+Dsqze0TbjZ7ilrOumCedRoIjY3
         c1VVy1RfsV2wrJXJxv6+wcSFjY4quhOvp+Eunv7CdtGj2JwUUzK/D3j6mfqHMFWcHKoa
         6c1jMuv+4wMLbtBb3zXXgXJPFn7YCFVTcUXBZ7E00cfQdV75Vbu594s6YK33123Z/zv3
         ccEUM6pEzt7ZG/nikkQq+yzfRO7iqoRYksxgYmgSEHFJ63Y7QVIjAE0alxoRsPMwNWN3
         fLRO0prdKJYnI3Ry0DhjdVk44IdA7luXq2sEYUPh9buIYOkk0X+3gaqOgKaXkj/GcuQw
         koZA==
X-Gm-Message-State: AOJu0YxI/Uu83KDNY+xhwzYwN6ip3+zw5Ga6Uc5cW6v3wIq3ZGXA6Zwy
	Qlwx/0fo6qolUJMyFbnfd7YccsGQdPoC/vY6UmCwnhV/9XY/wad62JgGjU8z4RiOeCHBfpi+qvZ
	YCp9OU3yY2lyoadESHj3FnFFZepwTLRk/8UVZomzr9SbxLTAgSOvA3WvmmleTbgwrWklJBFdGH0
	0v8nvDQ3vB3zEV2lJekzNIN3mXG29fzOqJVxOYKT4XdMY=
X-Received: by 2002:a05:6102:440c:b0:493:c75f:4c71 with SMTP id ada2fe7eead31-495d862d753mr2582462137.4.1723341819581;
        Sat, 10 Aug 2024 19:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlYdU14+Jr4JJ7pDFc8cm44paW/AG1Pbnrh1K0z347jIy9MgkZJX4YqDhP1+UzPylEpu2xo9szvioKVJ0mVoo=
X-Received: by 2002:a05:6102:440c:b0:493:c75f:4c71 with SMTP id
 ada2fe7eead31-495d862d753mr2582460137.4.1723341819330; Sat, 10 Aug 2024
 19:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810040239.437215-1-ming.lei@redhat.com> <7828bf84-ad8b-4fd5-b55e-0cd3fc320fc6@kernel.dk>
In-Reply-To: <7828bf84-ad8b-4fd5-b55e-0cd3fc320fc6@kernel.dk>
From: Ming Lei <ming.lei@redhat.com>
Date: Sun, 11 Aug 2024 10:03:27 +0800
Message-ID: <CAFj5m9LavduSW2zF29RvmJjPc+tm1CJVU_AGeuQr0sPN4SLoRg@mail.gmail.com>
Subject: Re: [PATCH] ublk: move zone report data out of request pdu
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 10:27=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 8/9/24 10:02 PM, Ming Lei wrote:
> > ublk zoned takes 16 bytes in each request pdu just for handling REPORT_=
ZONE
> > operation, this way does waste memory since request pdu is allocated
> > statically.
> >
> > Store the transient zone report data into one global xarray, and remove
> > it after the report zone request is completed. This way is reasonable
> > since report zone is run in slow code path.
>
> Oof yes, that's a lot better. I think this warrants a:
>
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
>
> as that's a pretty big waste, especially when most would not even be
> using the zoned support.

Indeed, the patch itself is easy enough for backport, will add Fixes tag in=
 V2.

Thanks,

