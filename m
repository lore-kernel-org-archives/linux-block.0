Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08224C83
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542830; cv=none; b=mR93VXPWLTBbZe4T3p4xCoXPRE3XN4WhaS3NZnJPevExDavNt73cYsC7RvMZFYfU4xUVHO1ZaEBr9AEa97Uv9iBLXoEspz5ltN6RaK36EFXU++RyBQI3bXYhiS+5jKrklX5L7umbN2gtmsgXMaFM1hh8aHE+VwGwXxlfG4tLWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542830; c=relaxed/simple;
	bh=+110KUY/xR4mN9EPy2VveR/SqdtfMuUoBJeg1u4C3tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+tfiN+TUkNCTuxKTVRPDIEsfcURCR6z6amSCh07XBfc2h+Up3dm5GjY6kB+gI1R0kes/K2g4erj67AOI6ycqbayx3rokb5KibSdgtAQ9mQurz2G4xPIRfBOFvid0/4YmFafwaThsMTiH1Opuf/2O3jmZfs/Vz/AG250fYmU9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GD/V85Ai; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GD/V85Ai"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22403c99457so3560285ad.3
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745542828; x=1746147628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgVKQefSPO6v/paTmlYFEPshSYpszOpPFJZJH+sNyKc=;
        b=GD/V85AiTR+POsbB2qW2YQ3H6l5tbRnMJgt1XhMjrb2owEiXdr4WxWPfr0i0DqZeVf
         9V9dIAFm0CFjPbsc41O7AmSEipxShdwATrN1+WKiEgwicIRSHrPFXTHGrEEB4d10jWNI
         33KZQjh8Gv4doz0edPUPF+K64kNkVoXhDVS2phAhsuZ+xgz6v0KWNi1N/IxyP080wTq7
         81FtQuL7M9xRFy9nNFQMG5+wBJTQHsDrBvrwEx4npe9LL5NuQG2Gror6p30ktvLMq8Nb
         pq+Tlj/pwZ7VH07KaVZM4tu6AiCb9GLTV3wDNY1kJM2uCcwCL4lIhorOVAGkLXPMYdhN
         K+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745542828; x=1746147628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgVKQefSPO6v/paTmlYFEPshSYpszOpPFJZJH+sNyKc=;
        b=QyZprKSkUuZMtYdWYdqIcO/3O2lu4+oohO5um2Bpde2kbGeVUBmHapYtjfHXeCgbYp
         GIgANB1oyjpPlG9mT0pkYY+hw4TKPt9gqLk4epe7XnUc6yMzcaEvEhiMpn7jNQjPYlOd
         LesNckLCt0DmwB0JYjay7up5MztqJkuVrgvQ2TLXFzWzJYgAAEQs4O5n56uM85/FrAmW
         N3MccH2PqBhYEoYfTYDLN+rvMa99Z5ehCRyNS/vDuqeKcddFd7G/jVXq/KErSN+zkRuj
         s5OetYGLdIYd18HAHzl5S6UYuI6vNj3zZ66vsjQhnJ3Y80qEoQd1HV4SSuQzux2Bhi3/
         Zk6w==
X-Forwarded-Encrypted: i=1; AJvYcCUwPU20vaYgSFQbMMO0JYQWa/tsR3bS4xAup6MQxkrn7dJzwitBqu6OmGomC/qeg8cEYChgLbCRKRIoGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXXNpMVbi+ivGlNt5AcP1b3/Ml4DvewSGZRlIfFFUtfz0/W9D
	ksB/gfZTh/UegzqvK/eMm5I2ZSB89wZX78yE3G/zj+j5jyYuUVkOI+xvHboHCKCPANkh4MsCVW6
	AFufQiqJfpmo2il8IEcRVKkgD3HslPrAcdM6Vtw==
X-Gm-Gg: ASbGnctJZPptWSiA+ylsCuyJcJMZrPn6rZdbnhq0kYerF/FArYzwVYtO7g6Ak3qgPu7
	cO4SucZtBPcwC0brBpuTi2m7y/JluwgxPtcvvdgP/V0m6md6YZEYOq5v5RiDe5RGkLCB2vtY7pn
	XQyh+g4y2YbwiD/zdwSbmm
X-Google-Smtp-Source: AGHT+IGCb4UYqBB8ozaTmvNC2LbrKC8acJbrLTqjrzO9z4hNn35hiWgqpQh7i/O7NLqRTJ/YYJh3Itk7bz6cJYtrTBc=
X-Received: by 2002:a17:902:d483:b0:224:e0e:e08b with SMTP id
 d9443c01a7336-22dbf155e64mr2476255ad.0.1745542827993; Thu, 24 Apr 2025
 18:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423205127.2976981-1-csander@purestorage.com>
 <20250423205127.2976981-4-csander@purestorage.com> <aAoiq1AsoD-k_kp3@infradead.org>
In-Reply-To: <aAoiq1AsoD-k_kp3@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 24 Apr 2025 18:00:16 -0700
X-Gm-Features: ATxdqUF2Kg7I4OqvugG6rzIUHrQVccl2R2M4E_rPalYCcq-E9ht0LATbrfNqQKQ
Message-ID: <CADUfDZpDg5hXeShhd9GX70uVbqv7RU+u-grf7S8j2qdgFXDxYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: avoid hctx spinlock for plug with multiple queues
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:38=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +static void blk_mq_extract_queue_requests(struct rq_list *rqs,
> > +                                       struct rq_list *queue_rqs,
> > +                                       unsigned *queue_depth)
> > +{
> > +     struct rq_list matched_rqs =3D {}, unmatched_rqs =3D {};
> > +     struct request *rq =3D rq_list_pop(rqs);
> > +     struct request_queue *this_q =3D rq->q;
> > +     unsigned depth =3D 1;
> > +
> > +     rq_list_add_tail(&matched_rqs, rq);
> > +     while ((rq =3D rq_list_pop(rqs))) {
> > +             if (rq->q =3D=3D this_q) {
> > +                     rq_list_add_tail(&matched_rqs, rq);
> > +                     depth++;
> > +             } else {
> > +                     rq_list_add_tail(&unmatched_rqs, rq);
> > +             }
>
> This might be moe efficient if you keep an extra iterator and never
> mode the request for another queue.

Sure, will do.

>
> > +     }
> > +
> > +     *queue_rqs =3D matched_rqs;
> > +     *rqs =3D unmatched_rqs;
> > +     *queue_depth =3D depth;
>
> .. and I'd return the queue depth here instead of making it another
> output argument.

Okay.

>
> > +static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rq=
s)
> > +{
> > +     do {
> > +             struct rq_list queue_rqs;
> > +             unsigned depth;
> > +
> > +             blk_mq_extract_queue_requests(rqs, &queue_rqs, &depth);
> > +             blk_mq_dispatch_queue_requests(&queue_rqs, depth);
> > +             while (!rq_list_empty(&queue_rqs)) {
> > +                     blk_mq_dispatch_list(&queue_rqs, false);
> > +             }
>
> No need for the braces in the inner while loop here.

Old habits die hard :)

>
> The other caller of blk_mq_dispatch_list loops until the list is empty,
> why don't we need that here?

This loop does continue calling blk_mq_dispatch_list() until queue_rqs
is empty. And the outer loop keeps repopulating queue_rqs until the
entire rqs list is empty. Am I misunderstanding you?

Thanks for the review,
Caleb
