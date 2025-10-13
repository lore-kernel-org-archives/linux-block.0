Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46F2F362E
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343986; cv=none; b=DxLeSzuIjcNfo7A9GCaUh+83H32I87UO+xJ5g/y9F4YGWn4naaH/kwt/vugeKdm+/VqQFH7rwXe+raKZtb/pYf1/2640YLrtahZuztC64WOcDB5XP+VAX/Mxt3fu42McjdY+rt9HGRZ3N2rQSRlRr4NkZZfQB0GJQVCl20drCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343986; c=relaxed/simple;
	bh=aeTrMwmyr4idjATE535SD4+VwHKBvnF3DmVfBmeSGIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpxfyRLpPjpuAaDlzBnk9+mJ2jE5+bUqYs7uG910c5z3ICBxLHk4DfwWAuCrKM69gVIiNQKvFJNaA9Vr/MsV0jv6agVt0kC8+DCHZ/kzUUq0Y4kSvmkr3KTxvU80V8wMHSt0EuTTszPF315+Z1HvDHSfHi51z+nDtfV7BtCim6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evINQi4I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evINQi4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760343983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9h2lc52spfsqI+nujAwhGun9J88DEF1peaurIn3jpI=;
	b=evINQi4IcyDz3fBL4CzS71mdZYAh+NCUSxAQqsqS2U54pk0Vh+LU+GKNVLNSfWA1ylDuv/
	bvU9xoSNZpiqkSQ/YgE5snas2lXwnSLSzPL3On1AQj/5uK49FuG1XDnNeccmqC+NObtHzh
	LffbIUZf+sThPVma1li24p9LC9MTTzQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-x4dQTfOEOue5j0PsAx2Rmg-1; Mon, 13 Oct 2025 04:26:22 -0400
X-MC-Unique: x4dQTfOEOue5j0PsAx2Rmg-1
X-Mimecast-MFC-AGG-ID: x4dQTfOEOue5j0PsAx2Rmg_1760343982
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-930bc148794so1648700241.2
        for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343982; x=1760948782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9h2lc52spfsqI+nujAwhGun9J88DEF1peaurIn3jpI=;
        b=WSnk6+ZmcHTi2v7qCd6EiuyffjBB9iApB9DcSmHeDQrMQH3E3YavUUktLUvnuU770J
         keFGzOa8iavl/wANxuYnb/G+aNjiN44vbM9Atc5kdkLKFxJRjkxfDdLOIne1f1AuRI9k
         mh0xeUNYq7NTlk1vw+OWgLH1pKEuxIyzq03QkBU/J2BAFKHqsTMYjwf12j+K3UNnYb2K
         fcHeU4c/gYRqtwMkSfVBsh71tX94RtQ7DAcpxXJxFAa3bUDjsBzxvjfl6DN48qXdPPpo
         p96jDLhMkXjdY29/p11Bdu5ScDUNt+2Z42SkcKRfJZneHwjYwysbbrJ766tnSI16/I/s
         V4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWhTjbwGXPGN49v2rgGDDM+jzkpoijMbBi911l/zksNZlm98gMOkoJumvtuVrXyHlejZ3Vapbrqco0tA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YzMKGIp86i2Xnn0rjqiSK3vRMYVXtpmnrsRAdAidHMOmuM4Y
	CBpKhAIMFR34WPprQcoG55FJ46Lhom8sc/nr1J3GT26T2d2H9qSdVmSij4jh9e7Lpu71OV/wJoK
	FazGnjC0UqYW7RwyLHGXerlp8VIXINaIDdNz+yBs7jjL+HtM6YJVlYgkrhLpOR53ouuteNMVv7k
	KrWMveVf0cvCfLkMm8DHgaZYzz6mP9IyPmYYNKNho=
X-Gm-Gg: ASbGncvPMgs2vDNTG2YFfnQM9g/mbJFERcCDYIsYK7EHFS5s1PSRF5Os2J0hd+GGZk/
	CCeTMSXFo4atvt4gCNSzy331HIyuGox4OKHOvD9x1Q4CjTrtKtr7VkMymnJFUdxE7/UE1G58aZt
	/WMN4Ov9+o8eiC7SCdwFq2qw==
X-Received: by 2002:a05:6102:8399:10b0:5d6:bbe:fe00 with SMTP id ada2fe7eead31-5d60bbf01ccmr1298634137.10.1760343981911;
        Mon, 13 Oct 2025 01:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqxQ3r8mKG19gkUS7w6zdeOC2dbsppCKLD7LIyf0aaxI4o4mEw27yhWt4MDd3wyBHEFiKHvB7PUDNAXpEj720=
X-Received: by 2002:a05:6102:8399:10b0:5d6:bbe:fe00 with SMTP id
 ada2fe7eead31-5d60bbf01ccmr1298632137.10.1760343981594; Mon, 13 Oct 2025
 01:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928132927.3672537-1-ming.lei@redhat.com> <20250928132927.3672537-7-ming.lei@redhat.com>
 <aN92BCY1GQZr9YB-@infradead.org> <aOPPpEPnClM-4CSy@fedora>
 <aOS0LdM6nMVcLPv_@infradead.org> <aOUESdhW-joMHvyW@fedora>
 <aOX88d7GrbhBkC51@infradead.org> <aOcPG2wHcc7Gfmt9@fedora> <aOybkCmOCsOJ4KqQ@infradead.org>
In-Reply-To: <aOybkCmOCsOJ4KqQ@infradead.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 13 Oct 2025 16:26:08 +0800
X-Gm-Features: AS18NWCWxgbBN23g61iYzMfQYeFdjbQ0IHgI_c-2448u3QBnJ6IKRiHfJ5F8vfs
Message-ID: <CAFj5m9+6aXjWV6K4Y6ZU=X9NogD5Z4ia1=YDgrRRxxfg6yEv5w@mail.gmail.com>
Subject: Re: [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Mikulas Patocka <mpatocka@redhat.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:28=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 09, 2025 at 09:25:47AM +0800, Ming Lei wrote:
> > Firstly this FS flag isn't available, if it is added, we may take it in=
to
> > account, and it is just one check, which shouldn't be blocker for this
> > loop perf improvement.
> >
> > Secondly it isn't enough to replace nowait decision from user side, one
> > case is overwrite, which is a nice usecase for nowait.
>
> Yes.  But right now you are hardcoding heuristics which is overall a
> very minor user of RWF_NOWAIT instead of sorting this out properly.

Yes, that is why I call the hint as loop specific, it isn't perfect, just f=
or
avoiding potential regression by taking nowait.

Given the improvement is big, and the perf issue has been
reported several times, I'd suggest taking it this way first, and
document it can be improved in future.

Thanks,

