Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B817BB6;
	Wed, 11 Jun 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618979; cv=none; b=iLZmsoIdOCH0s7/DlshIFWHYCEOFHY+7wMxUE6YCJeg/1WUfNAzV6IRHvy1TLPRW4qz+spFXo8bhrVMT32cJU/lQGn/mNEi8/QAIlP5Y8pVrreJ/jxydSmh6BCg869WGgMeLcx8iGX1/TMbWLVbre1GHYaDq/Xzi0Lr0U1LbSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618979; c=relaxed/simple;
	bh=wlCPxC6nysb+Pxhesmb97fuUGPr/QfECgPqmZ3FlWjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwIQwDJWug/8SzqK871jTkH20Ep8nq7FgLpjOlot10/3W/+rp8Pn4x9xfDGKLp5NgysDxgVz+WPJpwgWu0MxNikID0faTWd/Ww6EL1Ygms3J26VUTBM+Ao7rHUMtKTFUx/HDKZDy4aY5P85JgRGpRcZAwpa+u5iYQZ3Lr+k/Nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpUZ9M3/; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpUZ9M3/"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddc5084952so25050545ab.2;
        Tue, 10 Jun 2025 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749618977; x=1750223777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZesgBl46zE6tXS+j7KyjhCxsxKgNitfmh/eZ0BBEw4=;
        b=WpUZ9M3/19VqiOhKB245R6IS8uqys4jDlXbIbRTHMwbRrIHQxNflRyE/sGquaFSaBY
         g5ryNRRr7gyEXs9/f6AnNAWDgTEytjlHInSZomkIJTlrZCnMfPQ3dXTCLiYws6J9XcIH
         4hndLa6z35hAXMxMO24s6wD3UDoEBXY8ZoINVcn7cIVoz4c/OBOSwzp7Z7bo0GW+c0bg
         Le0/heEwRLJVlj4gV/6r/eUoIt2i/Qs7BbXIxazbHt23R/6xPViH4Gg5tyTllzTzCBS1
         yGW1G+b/OwLo+/NU8pAA8Ngzvc/YQa43A6flOoWHzvkmwGShjtxhrwJpnDEkzhz9v58i
         dDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618977; x=1750223777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZesgBl46zE6tXS+j7KyjhCxsxKgNitfmh/eZ0BBEw4=;
        b=Rn7Ab5XyElLKIBx/k4/Zyly9PzeuM10G3S8dwPqpBlbf+/CLG1RiEUhgN6LsGGjEG4
         L9CFV+k8mBZ71WJrgR2HQmFY1t6B5BT1V4AzFXmhv9QX/QQmTtm6xjUm+IYmK08hPccr
         vdZvAK3jO51ItL5dYuIHILK2Vqbn0Vv7uk/6BNrhtfKAro6B+T/6159FgJd+pH0ATE7Z
         236H13LKUd/nfZVAHeX7CxDpT50iBVibGNQDh/BOODp0yOK0AWBAQZMphHyEEN2uzfh9
         PUHmZxn+tOLDz8jXBhmeuEpb/iNUG70Y+OU8x44+8/olQBbwfeaHqGvzJCBFjzKwJsrB
         kXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbggO8V1hktwbw1PGOFLAD4pivr2lvKhSZYkCoBgZRxv/OCzmB4np7tIfQnDQwxk0HAwbiGinYZBWY8w==@vger.kernel.org, AJvYcCWdlrcnyxH+IkBn4PFQEOI0+FU6ZhWeTWKKCgSUsoUp9mNH4Mf5C1AUDNTGKUV6dCEKvvfe0cP4xvMD03nJL2Bq0U6A@vger.kernel.org, AJvYcCXFCt4imfUqgPV2YeN4p40/IHOhcsCUea+nW4s+ipmtTLfs5eNrIVdjxzjA07Pk+qTY9CcjYISxsmM7lYdH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nPeVk22FPeVew283FGibTNMtenDpMGUF3lWbWWXCymJ20N0Q
	qnElL3qABP/EuUob2D2RH+Q5DbNPgciV0kWmOabHUrBYNt0sA9b3idxmEqc7vWw5ILL/jb6RON7
	xvZPM0nye7Z4goq/oNuwOBcZAfzf2xmc=
X-Gm-Gg: ASbGncs6PzIlUU5Fivw+k1rgi9dvpoz8+8qxAUxXVzd2Rl/lm6ydJJ7PcWH2EKtSv0v
	pcgJVZUTbZ44mtaIPd8Mj6PoRZdzD/GMJFBtFhWlfgeMI/ux8e7UMw6fBbEScXO+aRGgxgdDGui
	i8e//nLmWznfRvpLwU7/vSwrDBcuSf/yra3BOmYvMl5Gk=
X-Google-Smtp-Source: AGHT+IHQ182d3wwKSf9DtAyyoa6zoQyiigAylXfIEGJY0yChHhYFf6EZGcBQKjg3qJXH0CODyAvyDT8qQD7k3JAMoRA=
X-Received: by 2002:a05:6e02:3b07:b0:3db:86fc:d328 with SMTP id
 e9e14a558f8ab-3ddf4224b37mr23369385ab.5.1749618977137; Tue, 10 Jun 2025
 22:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610004844.66688-5-kerneljasonxing@gmail.com> <202506102340.uo7QDaVk-lkp@intel.com>
In-Reply-To: <202506102340.uo7QDaVk-lkp@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 11 Jun 2025 13:15:40 +0800
X-Gm-Features: AX0GCFvLGUUBleBgjthzU8tNmG3C8w7G2enscnE2vmODxHCKzCz7BeEkbxQED_o
Message-ID: <CAL+tcoARvQVgd68HGoXXiK=+RSH12WQ_rc47B4rgtt2Eb05c0w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] blktrace: use rbuf->stats.full as a drop indicator
 in relayfs
To: kernel test robot <lkp@intel.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:42=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Jason,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on drm-i915/for-linux-next drm-i915/for-linux-ne=
xt-fixes akpm-mm/mm-everything linus/master v6.16-rc1 next-20250610]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/relayfs=
-abolish-prev_padding/20250610-085150
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block=
.git for-next
> patch link:    https://lore.kernel.org/r/20250610004844.66688-5-kerneljas=
onxing%40gmail.com
> patch subject: [PATCH v4 4/5] blktrace: use rbuf->stats.full as a drop in=
dicator in relayfs
> config: arc-randconfig-001-20250610
> compiler: arc-linux-gcc (GCC) 12.4.0
> reproduce (this is a W=3D1 build):
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506102340.uo7QDaVk-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    kernel/trace/blktrace.c: In function 'blk_dropped_read':
> >> kernel/trace/blktrace.c:421:39: warning: format '%lu' expects argument=
 of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsign=
ed int'} [-Wformat=3D]
>      421 |         snprintf(buf, sizeof(buf), "%lu\n", dropped);
>          |                                     ~~^     ~~~~~~~
>          |                                       |     |
>          |                                       |     size_t {aka unsign=
ed int}
>          |                                       long unsigned int
>          |                                     %u

Well, I suppose I will fix it in the re-spin after receiving more
comments so that I don't need to quickly respond to this minor issue.

Thanks,
Jason

>
>
> vim +421 kernel/trace/blktrace.c
>
>    413
>    414  static ssize_t blk_dropped_read(struct file *filp, char __user *b=
uffer,
>    415                                  size_t count, loff_t *ppos)
>    416  {
>    417          struct blk_trace *bt =3D filp->private_data;
>    418          size_t dropped =3D relay_stats(bt->rchan, RELAY_STATS_BUF=
_FULL);
>    419          char buf[16];
>    420
>  > 421          snprintf(buf, sizeof(buf), "%lu\n", dropped);
>    422
>    423          return simple_read_from_buffer(buffer, count, ppos, buf, =
strlen(buf));
>    424  }
>    425
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
