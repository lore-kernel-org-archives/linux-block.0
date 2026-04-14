Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17C33F5B8
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210552; cv=none; b=oJAea2WSDOXQ1bsah82cGpi6IEpLVThFmtbIHzsjHMiyHrwFwRTJtg9aDsc3jWkYo5X8WzPCgd8W27cet57Jg/wsqQ5UVLjPF/t6kLshK8WFEbfLFOQwu0T6lzk7BKXgRP2/5G1ijVQzaDTkvKX/Tb8FRG4v9gPOmS6V6VSG88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210552; c=relaxed/simple;
	bh=t6ap3hp2vWlX1xqsGYc+C5ZeRJOlXaYEglZGq8Z5lxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT3e4tvNblpoEvYAd3JUdnN+cVOYLktWeZ2K+mNrBEk17DBVcZlLoZIDU1UezagIemSVlIXCUDGbxOZ4zoxIO1c6gGgYXSKFlLN90zMLc/NKeGTS8tEa3rInvbr3x9UCUJmaEb/uXpyZR+fKv6es/cMtmO9FAD1jtAKo7THjcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSn3aIXG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSn3aIXG"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d72875729so1990460f8f.3
        for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776210549; x=1776815349; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJ8x8xR48CmS5hLf24KF5gUf297dGoG6cMflRnDvWCE=;
        b=ZSn3aIXG5LeBlvbbm961IRWO3AxYsn3KIT7pg3Ci6cEsu1u6bGk1VpgH190q7tOVdU
         H+mFqe6W1mNEZ6XJM1p+9hTt3rTuMy76WgjPc4evrLbSxYzpYLbzSQYd/LP5c/QzgaTT
         uttaVp/D3TClANRX1m5/Mth4auV2c2uZ3alwUcTOVNplHTyROT+pPa8lEwIz1ob688Q/
         L21ADJUBbUAAjcwMwhVnl/DrHOoL3OyWEp+b5XmS3Po0tG1uCWx/sS55SIswVFaqlaXk
         sRhJggGRLsm5GJSe2p4ef0TPEvI/i0BMXVOlRx6VxLlJAT+cgjyNeyEITwO+8nZLgvBD
         IvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776210549; x=1776815349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ8x8xR48CmS5hLf24KF5gUf297dGoG6cMflRnDvWCE=;
        b=SaFGqZ47hG+T7Wh/zGt5WS2rHkrPkiPvu1LiMb6vVuYJkBDi4C/GOrOt/yPgVaEiNI
         LRmYU8vDqCyCD+VvuchWDd6pGsX+wP0AkUBg/K2E7HhflQzL9x1RE+Q8UBuGLFWHlacL
         q636teteR6kIU+o8UjWfjOpuFqngZvI6lapB+uENT6GOO/CMQsmno8zCTphvEhx2JYor
         N7BUHwqoEYJlxs5hffIqkEHO/EaGku9OxjjQTgUw/Z3ZYfIgI2NYYkv1jnkC3pwf9dNG
         ON4QDVkigwvaxf2o2dyFuK0hrPVpcp/Gwph5BFKeT8z795Azo3qTgNA/pWCsA70j0Cg6
         o5kw==
X-Forwarded-Encrypted: i=1; AFNElJ8aSfR8g5s60rKkALyOsLfNYDfqls2NrFqUZLOzEs4we5XhG1vrYE8Rqk12A/CgC2Ejd+CWV26GSQ5QTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6Z2Gy4COZgxbH6QaUWELivT9qbDr6nKy9oLotqMeIrRU69Wu
	ifFWJC/FaBy2QE1HI+KXHf5z3phfgoc/0iJI2W/OCIizNoOchk0FlsRp
X-Gm-Gg: AeBDietmYrLxmgR5Dh0aznxDhNfu6c+vXJoo/9S3BzMyZjUq0LbEKwx+i8yTiH7Qub3
	hrte3fUQuB3bVNjgRrjDpC30S4oJrmOleJ6nKJuLCufJRbJXvydLtCYXO5C71XWCbUNgvbrCR0Z
	M5dmAQYnHNB9YVKY6kxFjCj7wF7OQQRGQR2w7oB2xW+eJWFuoHLKE0sEeVRq5S5mTzYePlZAtBt
	hFJHwIioF2Sh9wBffh41lrHDuf/Fr6AqR54cvnohIOKMakFo/zAswTNJEQOKDmCVGGw862qjZi8
	yFgON66Pa2LtKWfAk0IACp1qYWOc0trnfYPRMC6TlmSDnSuGgFTszTSRXLO38LHERRXtU80r9od
	fnS/pnmpdFZbGZy8IOlX2fKde4MwwC05s91zVVr/fj5b+QZ2mktd48e66EDPUtZgqSGOHi2sgKs
	tSiWhoJS6YlNE43QIA1SEWUnKFewqWstB4z8cJu9ZM+wHenmJ8dFnxU55RqEfQ3bBLfPd5S/DHR
	e0MHVcr
X-Received: by 2002:a05:6000:2dc4:b0:43e:a69b:d804 with SMTP id ffacd0b85a97d-43ea69bda0bmr5821111f8f.29.1776210549308;
        Tue, 14 Apr 2026 16:49:09 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5fd6sm58043f8f.24.2026.04.14.16.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:49:07 -0700 (PDT)
Date: Wed, 15 Apr 2026 07:49:02 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/7] ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB
 buffer support
Message-ID: <ad7SbiqAtlKlI5xh@fedora>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
 <20260409133020.3780098-2-tom.leiming@gmail.com>
 <CADUfDZr39RaLObyXg9sijCOpLF4K2+TZH3ygGiCVxO8aAqwTkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr39RaLObyXg9sijCOpLF4K2+TZH3ygGiCVxO8aAqwTkw@mail.gmail.com>

On Tue, Apr 14, 2026 at 11:40:36AM -0700, Caleb Sander Mateos wrote:
> On Thu, Apr 9, 2026 at 6:30 AM Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > The __u32 len field cannot represent a 4GB buffer (0x100000000
> > overflows to 0). Change it to __u64 so buffers up to 4GB can be
> > registered. Add a reserved field for alignment and validate it
> > is zero.
> >
> > The kernel enforces a default max of 4GB (UBLK_SHMEM_BUF_SIZE_MAX)
> > which may be increased in future.
> >
> > Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> > ---
> >  drivers/block/ublk_drv.c      | 9 ++++++++-
> >  include/uapi/linux/ublk_cmd.h | 3 ++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2e475bdc54dd..ada9a2e32ea9 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -63,6 +63,9 @@
> >  #define UBLK_CMD_REG_BUF       _IOC_NR(UBLK_U_CMD_REG_BUF)
> >  #define UBLK_CMD_UNREG_BUF     _IOC_NR(UBLK_U_CMD_UNREG_BUF)
> >
> > +/* Default max shmem buffer size: 4GB (may be increased in future) */
> > +#define UBLK_SHMEM_BUF_SIZE_MAX        (1ULL << 32)
> > +
> >  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
> >  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
> >
> > @@ -5351,11 +5354,15 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >         if (buf_reg.flags & ~UBLK_SHMEM_BUF_READ_ONLY)
> >                 return -EINVAL;
> >
> > +       if (buf_reg.reserved)
> > +               return -EINVAL;
> > +
> >         addr = buf_reg.addr;
> >         size = buf_reg.len;
> >         nr_pages = size >> PAGE_SHIFT;
> >
> > -       if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
> > +       if (!size || size > UBLK_SHMEM_BUF_SIZE_MAX ||
> 
> Should be >=? Otherwise, LGTM.

It should be ">" because we do want to support 4GB size buffer.


Thanks,
Ming
