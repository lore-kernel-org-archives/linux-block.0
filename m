Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6432ABF6
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334696; cv=none; b=ZniIsHvNRNP+YTh1O+UgOlHS3T5YLjJRaFn68iWsyO8rIYkzeJUJyQdGYFgXoOhp1Ml+KOjZG62PU9EiHDq0GbVBEwWcTMgQt44Mbc6mG2RD4A39xUuoeHpV5L4DdKOb7wlmf67gJXt+RqacLzWy60C4oIQve45pQghJYyS35vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334696; c=relaxed/simple;
	bh=MuFoqSXPuLC7mZdpb7+pS1mI6Pzog4fHqbrI6/r2Fik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnjMOmKRxnSOzIvGyeTmYjKlzJRAPZ8yAbEp8HOKlGCWZVJUY/sfYiKG+GYQzXlUBztH03MDosDjlgMa1SsZVZhWJMmrYatZFVfP5bjub+wtWQZuRyRFJRpjhX9QTkb8oHvh9kxxQgLOqwgcUbOmxTAILPbc6yDBWmRbmGc5t34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJWYU+6u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPWcoa9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJWYU+6u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPWcoa9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
	b=XJWYU+6uD2TNlbVBS1FWSfq/vP8XVoyGeNQVA2MIuhO/W4T8uQBNHQgULFu1ufsrLZrJlY
	lFTx9xa+7BzUc6E0ZglUBSgSsLJ1mcbujDT0vhlLqJzytcH4lFSPmNaTFKhsd58bsoLE/y
	/U0BTvNl50SHvZA1e3jAbGdy75xr+Ms=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-_YQWG7ieOxmh4ySD--jM4A-1; Fri, 28 Nov 2025 07:58:12 -0500
X-MC-Unique: _YQWG7ieOxmh4ySD--jM4A-1
X-Mimecast-MFC-AGG-ID: _YQWG7ieOxmh4ySD--jM4A_1764334691
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-787ee7b3ddfso22825337b3.1
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 04:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764334691; x=1764939491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
        b=WPWcoa9K2JrOd9FDfgVkzocSG7sIh/Sb3C9vxn/L1H6MGGrIBNlnWd/ZCJ0pHJL1K2
         Evidr0CTr+HE8pVUeTKfSXLZuQpDrERIbsMyI3sxa+pcP/2M5IulrB1iBVr1uKfEFQ9J
         u9m7Q+NUZkJXnkQwDgWe1CzoD9ZNnQSCVW9UlhQBdeww3TckJu00QyjYwemY8O/dIOre
         gVRG2NC95/0Fx+4M1fKiWpOKaWlSSPRpSXTw25Y75Kab/VTH2P5H/pnhcOwcaRhTRwHM
         jFIC/IySLQO86vdb/ma9VqciHHcNwo55Si+W6YOgi+DZfOxt6HMmwRwnC+4jmTRAYEQI
         UdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334691; x=1764939491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
        b=eyuoLdMN72ClMBt/FAyNtWJDs/AOJ/FmusDP+XC2bAIh1KmoOMtNSf2kjyHvJNQpt5
         0Hez2G2yohpS3ZEnf0woU4M6x2cJAh6S/nW+6PeeHHf00qRHAEQcyKc1T4V8o/MO9LSJ
         /uw9DL9AAvkoWXIXwUvRFI1097W5vxw+uiUmeejkWDNRtSbIeVd5T0hDjKXTqt4PZjSv
         tiVycqvsWW1eTLqCcIait2pETprf/HSCDNbSxywCj1v4o/rD8enKi8tdzBJ5v7DhKQNR
         Z4qaTBH306+AkkmIApIRL5loI5oIMqTkLzo/jCGk8inVaTH6QjF+mz4uEK+SvZAt6wNf
         2PGA==
X-Forwarded-Encrypted: i=1; AJvYcCUKP2lT0hBqbwlbW0s6Gktc1zIodIJZBU7Ikj0mqSLxU1O41CUJcPc/ZC0jHj5LnLH/6ZTKjmSJcQxLVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPT9SGXjNtdo/dP8LGXIL8y5mAtKiwTUzSjNguG1hnfg3DRzIk
	zLEZblH+lthMmUy6dq0kPmzxAeqcdPUAIy19ygChT0vJ6ykbbOB+4l+buJ1wA4NwBD4einvmoLR
	0VDTxTTXEb4ba0/y96YByCZP2T6A7Fb+Py7cI5ixu4mVE8+nrla+lxt1o5aOHqKFOWW43nJH2PI
	0pUlHc8+/Sn42gvBXfe5gRG3Rc0FV3fYQtqi0WPlU=
X-Gm-Gg: ASbGncvb/ANQHrk4158ocRYSLj8BLbYnJ5SOh0qjFQFZ67mY3vu7xEDCMr5zD/dccky
	ab6VgeItaB4ODiDIwf7bpujzszsfCMU9/QNsbDvzV5GJRkq6svPJet4BdvT4K5ExV2F1RCgviq7
	VHybkWCxk0T3Ls85p6XL2FJlGgPfdqfPkHpZzLmv5K/3PAOBhoeslrfggl1gHSC/w3
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id 00721157ae682-78a8b47f539mr225392517b3.2.1764334691006;
        Fri, 28 Nov 2025 04:58:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6o2vx3XDXGg+LlkIovRC1qPDpHivJwIyySPFZW+LOu2PT9QpULnJt3ZozP3PJjgQPuJtToIp2pCOkRf4ONwA=
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id
 00721157ae682-78a8b47f539mr225392307b3.2.1764334690627; Fri, 28 Nov 2025
 04:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-5-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-5-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:57:59 +0100
X-Gm-Features: AWmQ_bkpqINzOqnBww77x7L-xnpoIyN1fhsiEmRMn1madN6s7Ak0j6O_sI0bIl0
Message-ID: <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:33=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Now that all potential callers of bio_chain_endio have been
> eliminated, completely prohibit any future calls to this function.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index aa43435c15f..2473a2c0d2f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio=
)
>         return parent;
>  }
>
> +/**
> + * This function should only be used as a flag and must never be called.
> + * If execution reaches here, it indicates a serious programming error.
> + */
>  static void bio_chain_endio(struct bio *bio)
>  {
> +       BUG_ON(1);

The below call is dead code and should be removed. With that, nothing
remains of the first patch in this queue ("block: fix incorrect logic
in bio_chain_endio") and that patch can be dropped.

>         bio_endio(bio);
>  }
>
> --
> 2.34.1
>

Thanks,
Andreas

