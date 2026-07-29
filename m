Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC470222599
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290207; cv=none; b=edVA95WbYSW5GVQGWRZVX9Ft5y/CYotXDOrUKiwlgTz1d2EuPxKRJWq0lrqMS42tae2GbOTnra0wnBJNGzkF20u0OvsLYVs2T1ra12lWRFKH6vX2PYXknvT03a4OYQQB29Mp5F5GATOr7dOl8psV1fymDNDXzBkrzQIGOMzFT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290207; c=relaxed/simple;
	bh=BETsDAziAoC+O7WZ5Awn6WeCnMZNnNKP3zEU3MxtQ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L20SM8kz0emDVBEo4idcD3D3IZ6RvPrEW9nTnGYVLQF5pYK18iqAGbLkkxdU7dOGFbZRO8azkZz9zv3ic7oqQ2OK9tNZdH7mSqmpDCv923k57BbdSIruGPXhCXL6MpFVYoGSEZ6hcvY8ADKuypjk7VIkIQoaURwIyEuo5QQRvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAWwWe2H; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAWwWe2H"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-667b0ced2d3so517027d50.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785290205; x=1785895005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ydSVwQUrbSVpK0x49Cka1T+m8lC2etzef5HLF1DxF30=;
        b=pAWwWe2H5SUmhlLJji55x6ibkhsVGab9iAHp7Zuha2ySWoboQuf9WZrvy2cQFi1dra
         ejPk+hj+8gY7+Q54c6FEio/tUBoFOE4X8ifLHqa5xZDZAnqbzX8rIkwct7hdWny40moO
         28oytOF+8MXih4QTaPPdzTzCG1P9gC6KIrASEA8HFfjbYC2PwnARMXsvHjNbubuFpUO9
         2JUWuVZi0vJYvY5laXDnJd7yQGJYiBhmjiO9j3KpFR41llZqY0ASRnD/l3nZ2P2XbIW9
         R1JF9cGBya6Bi1VjWEnKlFH5zOR4+hCYRbMWM+38vXC9cAUNLPeOqnbb5fmNAz1zYDTc
         O/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785290205; x=1785895005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ydSVwQUrbSVpK0x49Cka1T+m8lC2etzef5HLF1DxF30=;
        b=K+1fvNysFYKLOVwWskUB4xquYjC8PyHU1bZs2QOHA49ac6bG3qMG/tZQfpvw81YCLq
         TVt1HxKVCrNUE+GnnE3UYUNbCeKxlzXLXYaC2flq9YpOq4eakpk4UnzZRwz/pE2UATQz
         JVAbbV0cI/p1euq8HaUsGR2l+hwEM7Vo+YxBqYpocQgk7H3/0X/QobiNvxJZrNrq1RNH
         viH6N+yZ/pDyQX3i6TbYx3DhBWRaf2najyuJMJpDNH1zUJbCwD5w0v4pY5V4B5MpL8Fa
         Pq31kaGhqzkbXDDMuXq1zjlBIV3CusXG4CdSlVvwM6ieaAhvXpEOiOFqcd7v4ivIpIL1
         6i/A==
X-Forwarded-Encrypted: i=1; AHgh+RoPzc6h42hMx9MIBYrX11NjMLTFSbzO2Hkl5i6JyPkcotm46zDo5lpCR5KdsRDQKFRRE616p7dWMb/VUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GKknWL/XIN60NTA8qlb6FewEgSmpntfA+3+H/zKmA8cIJHtN
	3eSuNprFbnqxj/z+4mmu025llo0qXHHXA0A47VLgsYDcfmFJggClwyZfksPXZGsI
X-Gm-Gg: AR+sD12yMjPOrVQ1P1kwP1PuCVU0wb5mMHjeZS1nDKFxGsw9xlfdpl5NisfM0AOhTXv
	t6KmaYzmZ43OV7IF3+oMubghb8jVk6eAF3lHOMPzuSKOrpuD/n5AH1Zb14pqducarPhHoWEAlTr
	x0yvZP6zs5KeIU5D7gHsUox+dM/CdPcc4J65++xxqjncR7ltQpYvpQX4iNmdwAXS9umQy2uN4xa
	S5uqrxjNk6hzdl+bI8xd7AI/p4qaVKSL6qcosmiMWq1HzWBM8vw8VgNzqeD8tJW1FtlUMGCN35j
	W1Mt4OzsNK7Nf30RhOYndngGmihECKd74IS/ScAMLuSjqKDFDDttPW2gWXVuaXGqSoy8gQBp9pO
	mAL7eOIyHq5epaM5xS0Nf9kD5Qz+3rnEBLodFEQKLdSOwrdaTOYzK29IXH4Clq+eq5MyJCLvbqh
	GJrA1CT1FSzsgRMuzwcep2Xaew2+V5H31HT25UKqVS5WGSTq5HNVTp468Sj0pU3ighLR2J6EXbe
	IgGvc2Q2P5USmHzVhxDYsaVhbv2T1/iqLeHdvbbJXeupZppq7w2DltTNef05FAudmXz
X-Received: by 2002:a05:690e:250e:10b0:667:8b90:3566 with SMTP id 956f58d0204a3-66905842ccfmr1641232d50.88.1785290204723;
        Tue, 28 Jul 2026 18:56:44 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669125fad3asm927723d50.10.2026.07.28.18.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:56:44 -0700 (PDT)
Date: Tue, 28 Jul 2026 20:56:38 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove WARN_ON_ONCE() in ublk_unmap_io()
Message-ID: <amld1rIvn52o8bZ6@fedora-laptop>
References: <20260727162450.2921500-1-csander@purestorage.com>
 <CACVXFVOaA_k+TCmeyrjguW5StdDb=zQsTCXWMBQ7QiNX1wuDzA@mail.gmail.com>
 <CADUfDZr5-scDrSe6X3AVz3pX9iD8Cvri6AWj6zQWNqqqnL6jrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr5-scDrSe6X3AVz3pX9iD8Cvri6AWj6zQWNqqqnL6jrQ@mail.gmail.com>

On Tue, Jul 28, 2026 at 11:22:00AM -0700, Caleb Sander Mateos wrote:
> On Mon, Jul 27, 2026 at 7:47 PM Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 11:24 AM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > io->res is set from struct ublksrv_io_cmd's result field, which is
> > > controlled by the ublk server process, without any validation. It's thus
> > > possible for userspace to trigger the io->res > rq_bytes warning.
> > > ublk_copy_user_pages() already limits the copy length to the request
> > > data length, so drop the warning.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 4ca6ec738c93..4f30644756df 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1492,12 +1492,10 @@ static unsigned int ublk_unmap_io(bool need_map,
> > >
> > >         if (ublk_need_unmap_req(req)) {
> > >                 struct iov_iter iter;
> > >                 const int dir = ITER_SOURCE;
> > >
> > > -               WARN_ON_ONCE(io->res > rq_bytes);
> > > -
> > >                 import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, &iter);
> > >                 return ublk_copy_user_pages(req, 0, &iter, dir);
> > >         }
> > >         return rq_bytes;
> >
> > The change may be fine, however access_ok() still can fail from import_ubuf(),
> > so can we consolidate ublk_unmap_io() a bit?
> 
> Sorry, not quite sure what you mean by "consolidate". Are you saying
> there should be a check of the import_ubuf() return value in
> ublk_map_io() and ublk_unmap_io()?

Yeah.

Thanks,
Ming
