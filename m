Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06462309AA
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523691; cv=none; b=TLstNA6ExlWYsAKbnQblvnAknr4/7De/WN7qL5gGx5yn3UHCV9Pt6DCLx0r1eZUoGFjI6N2Z9iCV/rVQRkq/G/lyAnKoGyB8XkAS5wyB8cD+JtL2wpgLm4U4OLwKU05yC82c8I8LMUudxz2XJsYokQ75MagUEixSwuikj8xH4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523691; c=relaxed/simple;
	bh=qzC+lGL7EH++UOq8QNHetUErviEIDwfxlbcdJesnEwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ+oiKfo9mA6PXr/UXxSjX8A7sE6mob5dizCcrBhOZNVy+SCjFfU8F2470S4MnjG5GA9IyKWtbeG1o5hhNrkOcM2y+RvzXtM209P2XGQN/Kp65dvd0yk636to7Qj4d4/oTlOBiTtbD/FHBbT9rA6UKqN7NH0gFaI4uWQpum1Nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKgUBuTe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKgUBuTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740523688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaBUGZoK9+1So7KWTYrLf+zCW6V1rwpWUPmzcKAgRM8=;
	b=eKgUBuTe8K/YqG/swrTAjBPB7kfJZ2sgoQGrwh2lLudfPU/RYFe4uYyRoLfNXPcssHnpbT
	H5i8i7YzhjIMjssJHpu2jFtb23UB1hkqEVYeKvyw+iuarZhofXmLiNk1sGt3+9pR7iGGQz
	vfY+du8jhOk1IKl3xSbgkCOki6+xyIY=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-VEddU_j1PKOaLxLx0EQqqg-1; Tue, 25 Feb 2025 17:48:07 -0500
X-MC-Unique: VEddU_j1PKOaLxLx0EQqqg-1
X-Mimecast-MFC-AGG-ID: VEddU_j1PKOaLxLx0EQqqg_1740523687
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-520f35491b9so1293669e0c.1
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 14:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523686; x=1741128486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaBUGZoK9+1So7KWTYrLf+zCW6V1rwpWUPmzcKAgRM8=;
        b=i2z0FaWDfeyD2WOMPoMAOLook/+5jyPSuA8oeb2gMxVIZwFUvDa3KZhrBwb4tW4k4C
         Z1Yits448mulvCFVIBAF0XxvLBqGzYcKcKxuOiWDHnsSdDg+BYuzVQKl1PuuNgTxJD4S
         u/BOXk+zwteKhoAbVxXg8jupKBl4zYPESOg09o61zvqdXKyjriqJlsyI5qjZ8jvJfoY5
         sjwtzEKMm09QjTRiFemCPvbJjfniipYLuyzkxH2VxYg9COT16N+QABrSY/ThVvHQkPcM
         jBKbvDDvhRC9Y2J5f8iAEOyQniBzGwz3VDNzROdSQ1qvYUNMNpxIR2g2UEZOHKeQQ+Ng
         wZzg==
X-Forwarded-Encrypted: i=1; AJvYcCV10xNdv0wgUqrg39dMfRhKkQlp7IglMCFp0laeqqEe/TGLz2w4ugwUKLaIQc6VL4ziDyUF7Ur0fJJXzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWqXH0T+s5x20crB0YaRQmxZZVKunJvZTmFRCzTYqcuvHcI9Bw
	wC7znXOE0K6w4D1XT9i2mxPUgVHo8tNySfzrbEwFmbf5xISxJJH3cSkK3xKYgtwrTONMsWHDt7/
	BDudNaT50lhW3+WH4We5GdyJJSqCfUqk01xv5wITnG3pV/eC/vBjBg6O6GIJkWjG/6dZvGqXLgO
	+99HaC2sjqjR7kyh8kH0aTRHKoWCI2sLen9qE=
X-Gm-Gg: ASbGncsFMdgAoQ83HW9N4EN6SV8Qc98YhwqWQS4BXwriW+QgshZxi0QaUndljh1LMTT
	6QKAB/wb+1VWEmEbBylh6Jkehd5kKTh6BEF22uVV5qsDjBaD518FMhGzCZ43KI+xl7WJsnrfoUw
	==
X-Received: by 2002:a05:6102:508a:b0:4bb:dc3c:1b49 with SMTP id ada2fe7eead31-4c01e3030aemr662880137.22.1740523686727;
        Tue, 25 Feb 2025 14:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhzohP7hrmisIZ9DUcY5fYiv3GQVUmjgxILxbMm9KgVtGWNa6Qp8fKJpRYI6dfcb5oS1RZ+tWx8qH96oDNcDg=
X-Received: by 2002:a05:6102:508a:b0:4bb:dc3c:1b49 with SMTP id
 ada2fe7eead31-4c01e3030aemr662865137.22.1740523686411; Tue, 25 Feb 2025
 14:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224213116.3509093-1-kbusch@meta.com> <20250224213116.3509093-8-kbusch@meta.com>
 <Z72P_nnZD9i-ya-1@fedora> <Z73-rhNw3zgvUuZr@kbusch-mbp>
In-Reply-To: <Z73-rhNw3zgvUuZr@kbusch-mbp>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 26 Feb 2025 06:47:54 +0800
X-Gm-Features: AQ5f1JrH0V1OM2iSAYX6FGpKLPOiKMppIW2w-3AO8cm6eSMwxLQgJoSa4g0JnHE
Message-ID: <CAFj5m9KA1QUS-gYTRdpQRV4vMBcBE_7_t22YDrCh21ixgQMcxQ@mail.gmail.com>
Subject: Re: [PATCHv5 07/11] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, bernd@bsbernd.com, 
	csander@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:32=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Feb 25, 2025 at 05:40:14PM +0800, Ming Lei wrote:
> > On Mon, Feb 24, 2025 at 01:31:12PM -0800, Keith Busch wrote:
> > > +
> > > +   if (op_is_write(req_op(rq)))
> > > +           imu->perm =3D IO_IMU_WRITEABLE;
> > > +   else
> > > +           imu->perm =3D IO_IMU_READABLE;
> >
> > Looks the above is wrong, if request is for write op, the buffer
> > should be readable & !writeable.
> >
> > IO_IMU_WRITEABLE is supposed to mean the buffer is writeable, isn't it?
>
> In the setup I used here, IMU_WRITEABLE means this can be used in a
> write command. You can write from this buffer, not to it.

But IMU represents a buffer, and the buffer could be used for other
OPs in future,
instead of write command only. Here it is more readable to mark the buffer
readable or writable.

I'd suggest not introducing the confusion from the beginning.

Thanks,

