Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44725392C
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486784; cv=none; b=HnSTFr0+R8Vt0ZXAzrOUWltE4tVmTcJ4vsX5ovfaGNeBDoUlXwSbE4EHQ7s8GEKWE7h5lnIZQ6/Mr8e+i4L4MrTgjK/wB9USQQZDDqCF44uNSoYbP9m4tom0COb6MHmWVqlaJInBMfNkBrH1npaTlNzOCONaV2pTkOVzL71Tr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486784; c=relaxed/simple;
	bh=fNTmw2fBuD548RFxUye8NfcsGZKy4gYCOaELXJHaOOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCPavEra8MLArpd1DOjeDRQJzUrqqJ7BhVeyj5QQm6Qx0D52IoqiD8/CxH24JEDWGG75iTquLqrXjJFac/rIQQn4y/tlM3s/TbTgalLGuSra0MCxPrwWDc6TxizbXZaZsh9pFgFzYHRbuVQK0lurmPzMt+NVOCUHumE1S43aDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuZ95ZA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuZ95ZA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755486781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxP4/8pUHKOzQChgnbfSSvo+Fj1kOBX1r6KKSDodaO8=;
	b=ZuZ95ZA2v3aSC9p2yAVUTyK7Z+VWDRUj7pM6O7oO4cZuyp7OFW/aeUc+jaPfO9AQ96E0Wx
	GC3Pc7JwMyrH3vVQNRI1rB116JWXXdie3IT+P869+reH8NkEM6zUhEz2c5cAwYMzymgO9h
	NPwMj+X7TeCHJ70xyHxCci/bqE6jPOM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-CQd5PPWCPHiYlrXgmR-SCQ-1; Sun, 17 Aug 2025 23:12:59 -0400
X-MC-Unique: CQd5PPWCPHiYlrXgmR-SCQ-1
X-Mimecast-MFC-AGG-ID: CQd5PPWCPHiYlrXgmR-SCQ_1755486779
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53b1757cfcfso2000021e0c.3
        for <linux-block@vger.kernel.org>; Sun, 17 Aug 2025 20:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755486779; x=1756091579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxP4/8pUHKOzQChgnbfSSvo+Fj1kOBX1r6KKSDodaO8=;
        b=j3y1vXwE1AO3HLcVvIrPX/Dw/4bWmSU7WobtJc1TQ0fQ8q+X8jXnIuAecg5VJMnE0Q
         On8JaHiLJVWBailtCMqygHmjxtj8ho75vNdz/9mkREvBH9uiC3zDqmXka4JYnHcj7AR4
         RCw0VC5yrceVZS5XbsdJafqwaXVv+S/SFTC+glkFMs1FyhbG3JjsvOZmBWAzJ7qmqLUo
         k68iW0+3Pif8TISrnzKX9uvdukP0OJ58ubGLhCo2UkEg8pGiJo56Y6MzlCnl9mQBi8Fg
         LCooltfZAkWhxBiquqnU4xiO3P7vXES9DdMha2EeAGdGYEE2aktdGJYk1/VwTmcPO3pT
         BXtg==
X-Forwarded-Encrypted: i=1; AJvYcCWNPSzf3M7Uf6Qfe5iV5UxZvofl0jl6v5k4WmclmJmQG8BXpD/8ZAaFjcQwEs0gEuMBPsocepZ9aRb00g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtDzn7QCqSVJhdm+Wp7Vpd4dmZFwA23dUdN6H7OQyVWNzQlCu
	X3ADP36GAWkHcw9EfvpLJTI5j+A/JUPex8OgzT9X5CZiBl9LMBTtR9BdazPGLztRQK/xVTMcXPm
	UauNR2HGJl0wk3vuU2asPBgj5v0IW3gg0JFzKm02Lviu9s++q2uFI7k/cPjh7ktF3lwvkD+ON3+
	yj5H+WVbPKKBMYKB0k4Ait+6mryap/tN0CpOHdBFg=
X-Gm-Gg: ASbGnctExe03qobZwiDzYslx3yAFgSaZFsWgWLsz1oXpuRB0fbZKYfIKVNXJWMbR+ki
	7x/W50+hebxdHY9iGo+MJh+YYzLKPi98WJ0rKcPE2UEqzTKTcr1HlerJYSbEAhWoJZomsDMn1m1
	/pcmu5X67gUBeUHLX8AkAcuw==
X-Received: by 2002:a05:6102:2ac7:b0:4df:8259:eab with SMTP id ada2fe7eead31-5126d027f98mr3387482137.19.1755486778974;
        Sun, 17 Aug 2025 20:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWsK8UrKTDkdR4i2/n1OFDGnu1OhTpAxLc5OsSgAw6h8ie0dKEQqEUFX1dVqBXMdHohFVdBVowlCJLnw8kGQ0=
X-Received: by 2002:a05:6102:2ac7:b0:4df:8259:eab with SMTP id
 ada2fe7eead31-5126d027f98mr3387473137.19.1755486778504; Sun, 17 Aug 2025
 20:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com> <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
 <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org> <aKADe9hNz99dQTfy@fedora>
 <CAHW3DrjPEHX=XmPCQDBLJoXmnjz3GKsht33o-S6tH-tNb-_WQQ@mail.gmail.com> <aKKL5nL4gf2bnXUd@fedora>
In-Reply-To: <aKKL5nL4gf2bnXUd@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 18 Aug 2025 11:12:47 +0800
X-Gm-Features: Ac12FXwf8fc9hFman4MiOzTae05viaZPrSxfQiwQzelZ0-I9UaKM7qnzU6vE_P0
Message-ID: <CAFj5m9LOsj3dUYX5qHSGxekFMGTonsSxSoRczUO8jr4DW3wtew@mail.gmail.com>
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: =?UTF-8?B?5L2Z5b+r?= <yukuai1994@gmail.com>
Cc: Yu Kuai <yukuai@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:12=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> On Sat, Aug 16, 2025 at 04:05:30PM +0800, =E4=BD=99=E5=BF=AB wrote:
...
> > one line patch for this merge window? just fix the first double free
> > issue for now.
> >
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index d880c50629d6..1e0ccf19295a 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *h=
ctx,
> >                         return -ENOMEM;
> >
> >                 blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num)=
;
> > +               hctx->queue->elevator->et->tags[hctx->queue_num]=3D new=
;
> >                 *tagsptr =3D new;
>
> It is fine if this way can work, however old elevator->et may has lower
> depth, then:
>
> - the above change cause et->tags overflow
>
> - meantime memory leak is caused in blk_mq_free_sched_tags()

oops, looks I misunderstoodd nr_hw_queues as queue depth, so this single
line patch should fix the double free issue.

Thanks,
Ming

