Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56982EBB81
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503355; cv=none; b=sh2Z9+H+FE5FAzekH9RfJeq7aN9bfxHucaJlfabxx9NrPQmibraEKDrsxzgK1ktioEh7TJ/TQbvn1UBQQzO/LzJEKyvqkRnLNjSbQd0S3YXtyMDJXIJ8LxLfiF+LpWBPrOFIE3MfNmHW5n8/l8DIEljCNKF7AY04fOOXoIieXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503355; c=relaxed/simple;
	bh=XlrI6HhhtbWfgJbooDdHmqfLWjFtEhdvpyOBSP2EF2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN2HnsWkt3KoB6dypigZQIkHc9NbdsUGck/niyqSSfN0x8+FB1twFPrh7bc3Xock6FFLuAGkSR52sui4FMbcPddeCXNZgmHCIoMvKE4bhetIpfHz2XCwuTyVrXwX9RBVAP85nBrGgTS8T+C6GiY2iylzFFAXKJzukJsw/BIWQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJwLj6cX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJwLj6cX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760503352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlrI6HhhtbWfgJbooDdHmqfLWjFtEhdvpyOBSP2EF2o=;
	b=WJwLj6cXMmXNKif6u60sSwWsRM4fguDWwyqlUVCd6lQJfyPqdA9rOKniHiC5em6EDMhAEk
	P2s7zWVx6odjvwmx6rbnte0HtsoKwGtPBYry8zSEOpA+yYM8tJ28Sh5sCbdcjVJZo6LCC4
	BY7/k6j4gIE/ppg3Wtp8R5Q1aopEs8A=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-aLpGHAjsMhyrLIQZLXDcPw-1; Wed, 15 Oct 2025 00:42:30 -0400
X-MC-Unique: aLpGHAjsMhyrLIQZLXDcPw-1
X-Mimecast-MFC-AGG-ID: aLpGHAjsMhyrLIQZLXDcPw_1760503350
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5a6a9eac6daso4680572137.2
        for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 21:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503350; x=1761108150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlrI6HhhtbWfgJbooDdHmqfLWjFtEhdvpyOBSP2EF2o=;
        b=ZOZKOVqTdWwXAIdj+e7pFJsYRvk7HsJEhJjknl8IKxaUFpJ55Zg69d4Oommnv/HoAg
         gN1zW19uw3b+sqzAZ8mFuNjsiRm62qAZT/kseKYIUDLCXy/Sam9URuy2mNZ89x5DsNdq
         3Xg8yL5Zh3oeNxbmkAg4VbD5EJwcDdMEYzFM1VZ2+oGOlDEcYUfhFSYfoNKVuA1gI9OU
         MiEdR60aW03NKgDmG+CNyQoRk2PpY7bOilLOH2ZHN6nBcqRpc2oEnNUv4bDfCX3NewGW
         ZnWSJltoLVazlmfyGVehbB2GynPSHD9g0ZcDvepPBgOiO19/wM0at3twwHmkQRbteb/q
         9VGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp3r6OIjt5O5fPcKYfY6QAvyvZs/3Kv1Zdu321Ru5x6UAc6Qyt/jXs4RRWBGJtjuYyMeXqbM2PjBa/Og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpx6Blk3SS7KYQlBCSC/i6hPVxndSnCbBDZogD8wKAtRN/XbcQ
	rCIDadMuWKKlfJoaqdQMP61IEg7AzIs8eYwQFSIs9ZDv96XNmf0T3+3bzvSgI04LJC7E6N1XPmQ
	57xT7tcWg1RlsQCFWAslxOM/CTbXrmOH1NseeNd+BPYk8eEW7Oj9blBZ4KI+WdsK8BVOYEpDn+p
	oa9qM/5zE0UmukXHnDrOtM6YqG41Et0qlaYkSvVus=
X-Gm-Gg: ASbGncsgDrMoFYVqspWKL0RXs37p2/ptNR9yKy+Rk27/Qutdxj/I0yEYxZbTFXLRyQ0
	EjW4IRDQvkn4ZY6WC/WGwkbNJl7Mt5tTAKt5u7HtGZWtFcOlbpO2Br0QX3G45m1mgwJmOW/sCCw
	WoZDwA3a16apc2tbqGO58omw==
X-Received: by 2002:a05:6102:c09:b0:5a3:6a6f:21ad with SMTP id ada2fe7eead31-5d5e23c174amr10189034137.30.1760503349751;
        Tue, 14 Oct 2025 21:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4rjxBaTTEZrvj5fOO/WyoesgQ179mnAgeRxlqs1rJ5f0KtvHDy/D2hvLV24ZHbjLRkLcfHElafKu6I26lT2M=
X-Received: by 2002:a05:6102:c09:b0:5a3:6a6f:21ad with SMTP id
 ada2fe7eead31-5d5e23c174amr10189029137.30.1760503349462; Tue, 14 Oct 2025
 21:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014827.2997591-1-yukuai3@huawei.com>
In-Reply-To: <20251015014827.2997591-1-yukuai3@huawei.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 15 Oct 2025 12:42:17 +0800
X-Gm-Features: AS18NWDMNfscsxWtef_AfIWEBNofmodLju4tSwf43IMYgd8sSyIfnLFrLBKq46Y
Message-ID: <CAFj5m9+gw4LpcZmKWntih=zZC0Tuo8jYqE_Z9bYcFM8apPfbBw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()
To: Yu Kuai <yukuai3@huawei.com>
Cc: axboe@kernel.dk, clm@meta.com, nilay@linux.ibm.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
	johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:56=E2=80=AFAM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
> blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
> before q->nr_requests is updated, however, it's still using the old
> q->nr_requests to resize tag depth.
>
> Fix this problem by passing in expected new tag depth.
>
> Fixes: 7f2799c546db ("blk-mq: cleanup shared tags case in blk_mq_update_n=
r_requests()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

