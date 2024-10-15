Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955C1D1512
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993719; cv=none; b=i4qMAFjsyIbk072pZdTa2UxZWVI9xcESu81scXcvNGn/P+RFDPNtvYWDy3vxCFD/J371TUROmnYVBmQ7gAxjtImA6GtUTevs7RMoMLdRo7sUSbX1clx91uXOyoXnjS5D4dCTXV3eSFd1EbHpIK+EwHKsLDPs7jRG9iSo3E2jPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993719; c=relaxed/simple;
	bh=5STNNMU14LlGt3mb7eHEV1o3zKU6ofipwX6azD8RTmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT+aVDSHR+5LapipODN4U/Isrxx7BeBDomEnt3tmrTfPj/oCI5O9x9K/UbH7QTq/6/JwC6PjAlagloFv8uv3UyUvkeKPh7n0MdkKKDAdVEGIRM+ez8sNuBE9Ol1XGsqPWra5/8Rcl4S1DEyDFfwyvSDLeyXDnfu0/NQh/JQwBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiSRnmhv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiSRnmhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728993717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU8cdLwyvTrF+rHqLCsTDBJ07XOTLiGXwc0WAS/2LmE=;
	b=FiSRnmhvimm7PTVXjzvmBMc2aY2qh6mgBvNGEK5XcicPmjduH/7n3LiXVHiWs9fgFR13N6
	M4uKF5fcywE9ZaGTlJXAI3wEjoIi9+kZute2zAh4V8uz1cjdQ3nZZ2neFRPVZLzGiTh2bU
	G8rfRyO7jgpCqmvcCtwstBfhWhrtcPI=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-hTdZ9ZPxPnayyf_XuZuAcA-1; Tue, 15 Oct 2024 08:01:56 -0400
X-MC-Unique: hTdZ9ZPxPnayyf_XuZuAcA-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-50d55977001so495060e0c.2
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 05:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728993715; x=1729598515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wU8cdLwyvTrF+rHqLCsTDBJ07XOTLiGXwc0WAS/2LmE=;
        b=FfzmewHs21Yw3SE4qwScOgmsvAZK8U+VriAZBhCGJI518RAltZaCJhcUUNGl4f7wFg
         YobQZW01hygM/VIuo5gu28x6e9RC3PrilPk1/0Wy7VS3JuPeOJAK3Cyyuzgv9Ij+JAeq
         hm6/KqCDUPSLXt2J8RY7mmSpxqk0LZ3o/nJYrHv15eU809pjCP5xujHmu1SEV+jvFZdk
         QlkR+cXkdYtYK7Id1Akyys4XI0YRr68g98lvy3eF5CQUlIxYqUqCU8wwocAKAz9YbcDX
         JjlptOqEk77gYSjyCQ5N9qxfY5azRDoTQv+C/0VtGChGDwcu76PQ33Gcq51UYogO7ptS
         6F6g==
X-Forwarded-Encrypted: i=1; AJvYcCUj/YiWIY/tA+3OcKO8ZwKkepXSe3apc9ENATqbaJo9GYTD0n/oswQ1Gp06yWKwF3LjqzEWRIRjaJD3JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4AoXY5rjJd3EmzvmYHbvr5AGFnQ0MSWhR5HDdPhS/RCgaO6TL
	jxgDVwUuNOeXotUMbRIDoIrRsryWlg2FrW6dqFg6lBsuJE9liOopSuUA4Bs21PjwCYMHRaJmV5y
	+JSqJRAyHIG3lPT8G1AsuPzjh85TJQLDDqnPabP8QtXdlTjv6ARDDZ30vUe+J8dVilIJQEd4bdI
	dkFuRr+RujJW2iD+TJrcmibcAh6Bkrt4Pcc/E=
X-Received: by 2002:a05:6122:1806:b0:50d:66e1:826c with SMTP id 71dfb90a1353d-50d66e18bc3mr4635256e0c.11.1728993715044;
        Tue, 15 Oct 2024 05:01:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY9moZmYa4OxScIx+qlWeWary99ll+sUXMmuoKJvUOuDyTsB1cplqv8slY88hUZimrfDZiaEvs4AQrit04Tbw=
X-Received: by 2002:a05:6122:1806:b0:50d:66e1:826c with SMTP id
 71dfb90a1353d-50d66e18bc3mr4635183e0c.11.1728993714514; Tue, 15 Oct 2024
 05:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zw5CNDIde6xkq_Sf@redhat.com>
In-Reply-To: <Zw5CNDIde6xkq_Sf@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 15 Oct 2024 20:01:43 +0800
Message-ID: <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
Subject: Re: Kernel NBD client waits on wrong cookie, aborts connection
To: Kevin Wolf <kwolf@redhat.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	nbd@other.debian.org, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:22=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Hi all,
>
> the other day I was running some benchmarks to compare different QEMU
> block exports, and one of the scenarios I was interested in was
> exporting NBD from qemu-storage-daemon over a unix socket and attaching
> it as a block device using the kernel NBD client. I would then run a VM
> on top of it and fio inside of it.
>
> Unfortunately, I couldn't get any numbers because the connection always
> aborted with messages like "Double reply on req ..." or "Unexpected
> reply ..." in the host kernel log.
>
> Yesterday I found some time to have a closer look why this is happening,
> and I think I have a rough understanding of what's going on now. Look at
> these trace events:
>
>         qemu-img-51025   [005] ..... 19503.285423: nbd_header_sent: nbd t=
ransport event: request 000000002df03708, handle 0x0000150c0000005a
> [...]
>         qemu-img-51025   [008] ..... 19503.285500: nbd_payload_sent: nbd =
transport event: request 000000002df03708, handle 0x0000150c0000005d
> [...]
>    kworker/u49:1-47350   [004] ..... 19503.285514: nbd_header_received: n=
bd transport event: request 00000000b79e7443, handle 0x0000150c0000005a
>
> This is the same request, but the handle has changed between
> nbd_header_sent and nbd_payload_sent! I think this means that we hit one
> of the cases where the request is requeued, and then the next time it
> is executed with a different blk-mq tag, which is something the nbd
> driver doesn't seem to expect.
>
> Of course, since the cookie is transmitted in the header, the server
> replies with the original handle that contains the tag from the first
> call, while the kernel is only waiting for a handle with the new tag and
> is confused by the server response.
>
> I'm not sure yet which of the following options should be considered the
> real problem here, so I'm only describing the situation without trying
> to provide a patch:
>
> 1. Is it that blk-mq should always re-run the request with the same tag?
>    I don't expect so, though in practice I was surprised to see that it
>    happens quite often after nbd requeues a request that it actually
>    does end up with the same cookie again.

No.

request->tag will change, but we may take ->internal_tag(sched) or
->tag(none), which won't change.

I guess was_interrupted() in nbd_send_cmd() is triggered, then the payload
is sent with a different tag.

I will try to cook one patch soon.

Thanks,
Ming

