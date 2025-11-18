Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0523EA98
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470560; cv=none; b=kHZGYs26q4yGqff6zdsrYH/+bMVVCosX3qhNV86yNqMY8TInS3PC1HgC2EIqwtPrXmRW6Yz4nUSPa0EvE6q4F1/pSWSXpTdhQTbXyAxTNxpHOtuiTzRGMr6vsZ2p9jwmxeYtpzFxNNiDJEqlBBQh4Dm59Cr/vpMKYYJ+V4WlCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470560; c=relaxed/simple;
	bh=lmIU4dJ8YNpHWVTMmfiND8CwlczZGnQ+nZ73SDmDCpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmGyRGcF/U2LpU+ZWR5sU5BO6Ou+iSj2Awb/BObyQ6EryGisxIaLlMPvFff3zFE35o2T6jJrvjLfvpsF6ndNLgBBH+FYezHFU0w11uLz+c4lsmQqktmT86ylvkUdNPBrQiCnI7tI49ZFoETvYzQmr/TibOYmIVWGhrKui7/Tp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUxC5c5K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+TtFDs9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUxC5c5K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+TtFDs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763470558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Fc9QzHwqwCPN8psk/oOw+0uctePk68TJ3HFsDWmmro=;
	b=XUxC5c5K7lFUeraNBdaC4xmleZon2BODNkaOHuoO+MB/Ydv3EUEvzkT/f7Kc5ylPtpnXzO
	XfHEwwj6vq7PoVzzqJwRqSjWwLil9zneh+iLYB63fPtpZ5THsvTagKtlRoLVOS502CPgcF
	FadGolyQO99Iuoti/bjhU4Tj4/Y3cZY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-mzY_pQ9zN-GfHy-Tt0o-7Q-1; Tue, 18 Nov 2025 07:55:57 -0500
X-MC-Unique: mzY_pQ9zN-GfHy-Tt0o-7Q-1
X-Mimecast-MFC-AGG-ID: mzY_pQ9zN-GfHy-Tt0o-7Q_1763470556
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5dfc0924900so11643790137.2
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 04:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763470556; x=1764075356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fc9QzHwqwCPN8psk/oOw+0uctePk68TJ3HFsDWmmro=;
        b=e+TtFDs9JCYVRaC6LmN6X9VHdwDwBTRuyDG3JrcM532+qI/ni8wew10K271EWpfR4J
         cDeNTaCqyfoGRshkzdyrKEuPlRC5NZ6ye/a5hkmkxFU3dNsrYuxySce7IQyC28QW+mtT
         JcpT4rha1n8usBpne69lwfC6keSs6/W9RcxpzSJ4vAtwUfLlwyL1WHBSLUSICIdVU0gb
         qi4JAPEErLxnSrRwixKAlhY97ep5B3od4Xn9FMMuRNZ7S9WnlULEC5Ztj269lNxb0o9+
         MYC9HqzxyUeEVwxuSWIBkfxKheU50AaL/UN361TlIiOCG3sfBgjFyCMudkyXwDpNoAW0
         dHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763470556; x=1764075356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Fc9QzHwqwCPN8psk/oOw+0uctePk68TJ3HFsDWmmro=;
        b=Q5leoFRSCVNnGinBroGgliejKteJrWv0UkG2yas60QLoX37psZqhj/O1qL4EQQCFl9
         rJsNDD8bJCTGsQLyqdUrhj6o2W6sIhmRV0dINgOd2xgYmNgz3b4bL3gsXJR+/GjIv/H8
         Nzl6e4OxdH1xGlhEVkYT9E7ad1Q5Fqmx45QZG4OKH/ASmE5HF0tewPmOHMdRbxPZvAwO
         HAhNpWyAslxcp1cwZDdYSKYtssV4F6Cf6EovEu/Gla3fSxIEK+oHxwoh4oKVboDmKn5G
         zp/74ti2IO8IdJ/KRKOWng9hCxYKqBJxaT/XGJ+LfVJHnowB8a/Thn2A7dcAt/cpTsaa
         hjrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxQ0uhEEBmRcrNT98ROIB5EpYN/KcsbXKbF9icADNE1U8Jd1OJwaFCCKmcZTgEdzjNMYxVKWPahI7aSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+91yAMohMsaWXOyY+QvXkAm3GiLoj8k7ON42lspKDA4G5MRIn
	nvmFLJmKJYkD4OyWo/WlVdEpe44oX1sxIO5bUKwhrMlieupXTqdoNrShw/mCnOlT2M1diNPocHO
	+wI/O8wCQkC67VAKY2w9iITtseKB9/dCsEIdPzKKvsvIiaGsHAp37oM87OBMopt6xilevhhYgGR
	nshGeYFQjZSJvEGcbfW5SdW/CJ5U7HFZTJ3GE4zJU=
X-Gm-Gg: ASbGncumfYCB70avDmsRwj0L3g6RAyjmGogd7PFHs70+bW0RX7lx2xZC8MXquj7DL+Q
	x9zBFS+EciuxyFfkrlOKDgxr7OiV7ZTEnb7asIYI5MuSEG5dthoHFc3mOYB/T68br5RKoXjUSuX
	thAdWlLeEkpj1b2kHnoFaPpnGSSLgc7Cq3PpTRKhKM8/ysv8E7WrdoKvTy
X-Received: by 2002:a05:6102:f0e:b0:5d5:f6ae:38ee with SMTP id ada2fe7eead31-5dfc5bcd631mr5861778137.37.1763470556396;
        Tue, 18 Nov 2025 04:55:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGggoAwNLD7qoBxaLa9hRuYfYH4dkVq/JJ8RpPcw949GPP/ke6lOGR0gxRJ+LgZCGTJ7HGV2cjSg32NhHTTDTo=
X-Received: by 2002:a05:6102:f0e:b0:5d5:f6ae:38ee with SMTP id
 ada2fe7eead31-5dfc5bcd631mr5861773137.37.1763470555989; Tue, 18 Nov 2025
 04:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015110735.1361261-1-ming.lei@redhat.com>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 18 Nov 2025 20:55:44 +0800
X-Gm-Features: AWmQ_bkMXSxdfduGkjESg1ynruIWs4HY2ohtTvtSrm3enUkgrPdfO3Ne2r9d0t0
Message-ID: <CAFj5m9+UFxDg9=RwiHd5v2jhHaCcpRd+nLF6S3QhTy4v37W2tw@mail.gmail.com>
Subject: Re: [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hello Jens,
>
> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to=
 queue aio
> command to workqueue context, meantime refactor lo_rw_aio() a bit.
>
> In my test VM, loop disk perf becomes very close to perf of the backing b=
lock
> device(nvme/mq virtio-scsi).
>
> And Mikulas verified that this way can improve 12jobs sequential readwrit=
e io by
> ~5X, and basically solve the reported problem together with loop MQ chang=
e.
>
> https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@=
redhat.com/
>
> Zhaoyang Huang also mentioned it may fix their performance issue on Andro=
id
> use case.
>
> The loop MQ change will be posted as standalone patch, because it needs
> UAPI change.
>
> V5:
>         - only try nowait in case that backing file supports it (Yu Kuai)
>         - fix one lockdep assert (syzbot)
>         - improve comment log (Christoph)

Hi Jens,

Ping...

thanks,

