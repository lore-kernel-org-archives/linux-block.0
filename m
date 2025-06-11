Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB225BEEF;
	Wed, 11 Jun 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644449; cv=none; b=rTti1o03uaRc5DHQJdJN016qdmvOlweCIB7O+XnLA3NGKV4mzft+zTtO8u2PZiD27LpWcfwShqpMlIFK/RNIEpT6UY9be0LI/WJrKcMzbHEerJTB+deK1kGgTY6ESWLcE4jQAvWrbHMEvNZR+j5uLsMuW2xgjBH9Uqgc4ohY4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644449; c=relaxed/simple;
	bh=IHppgvzI4syY64UndWNyNk/lcgm8Qzoj/IK3X0IV+MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogd9hLs9WIHrECdjcDY+YXBicax3nSMXPJP7dYBK/0iRBAw0GxiaAY+CrhOq24kje481nvptl+28SWe8V/lGnCIWecqCiBFVpFmGqo6VkIeimHvUEPpSSC5mAt8JyhOn9WQPWusbL28Nf269KhI7s+Aoj1NIqBQQNuWqYy0WuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEeo1Wvu; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEeo1Wvu"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so20000755ab.0;
        Wed, 11 Jun 2025 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749644447; x=1750249247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBvjnZ90Dp0F8XMlzbkh5jxvl8CN8DeTIwQ3MbTjXNw=;
        b=IEeo1WvusE9pUMCLPFN2VyqSorod6YrW/VbVZ5LR1WpvYFJA7vP+VmpcSIAbFfPaef
         OAUKCqrctO9GbUoyghtmtvORy3y8cALfKu28OQLzekN4w28bkM5TFgAUH/Lsc/njbvqj
         HbK+9S2GNGUYydUV12SNTujdNFNK+fqas5MjUNfDZM7b0mShV7sgQrc9ndLZKzDWa7hn
         GY1TL29O8NOsc5VHClWsY0NbaBGt2QGAbSFj+9ERkVjHKUGN3SNh9daXDraXZqgB0Ynl
         cehDieUwxbJWrm83qMPJHVVdwS+xbUnNq01siSjE2qOYY1MKy0VvSVSqC6OexNOFI9pB
         z+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749644447; x=1750249247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBvjnZ90Dp0F8XMlzbkh5jxvl8CN8DeTIwQ3MbTjXNw=;
        b=EFE4yxLkoly99+AT1vbzwWY5Bvg53A13vaVuw8oCMr8U0XV8BfBzUE1sx94Qog59FV
         Jo1O7T/547FS8+l3nDneCsnj/d3cwOau1H/kcO9koGokYBW7PyYDli6vDVeoyPy96SO7
         hcLWbHGQDH/o9esTqcLdqXRvQW8UrvX4ux+sZD+u+bJMOzWYUoEwVvgSpcdojAINcYTB
         2ebJjtIbYnjnnB9oz4y5J49NnyrS5ykFI/RgAr3LP4IPNJ/ZtmjOVAveBuQ9DRoS0BlM
         sNyWtMclR/4oDuosjd1NFzdDoqSPs949dL+dNLsoBj9BIR8FX+ByvTMFFM3stqrxQfGb
         8miw==
X-Forwarded-Encrypted: i=1; AJvYcCV7nGxvS+3TqfiojeRvkucrnnUGJufhAK63WVofip8LWprKTxDzcxIEzUhHpsLbG+sOHrDIeWUYcBYzGH2v5oYhUQL5@vger.kernel.org, AJvYcCVdDQbrxj7peOGybuWEM30UgIHnuHbqHQzoVkivANKuXLBqSHYa6hKq5ggkPMXBGsheO8+ja5dU+LFHvUH9@vger.kernel.org, AJvYcCVhK2BmvK0pvfbYoKYKeILq4kAI7Udle5nWqVgY+9xMkq3qmDoya4tbTox11zVjoj8p9uZFdJqrb86iMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNdkTbvDWQEN/cY5E/RVMyZUPjoaUDdyh6PbPbKRrrX8E88IB
	LzUdrVYwO7njBL3Dkm6/ePJbYBf6aijpbxvaMIFySI6tt368h+B1tzLYxYF3Z5P0k2S4VN4Wc8Z
	KJ2Tj+B0Jo/3P529D3RqhWlBv5CfNH+Y=
X-Gm-Gg: ASbGncu1sPRi3dC4eYIjYJR6lhPV87VGr21hpMNTV+U9XxJCWwv0bW7E5nKXNqr+Dl9
	BP1pcEuFRm3pQ/NVS6cso9AC1B9ChNaSfjux5PZRAKC40uVjaW0QtLq2ZBKZ4RLsEmCg6XBKTDw
	5ArgD7VNUETYg8REGjmEFEFne8vmcGLZZ1EunpAv4CNI4=
X-Google-Smtp-Source: AGHT+IE4k8M34kH1+0to98qZha6YDCpF10uoPuQmWlF7JjAoPYaJi/BRbveOdyY4jpVv3FoTiXKBp/TgaddM4ZbrpUk=
X-Received: by 2002:a05:6e02:1a6a:b0:3dd:f1bb:da0b with SMTP id
 e9e14a558f8ab-3ddf423ed49mr34966435ab.7.1749644446692; Wed, 11 Jun 2025
 05:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610004844.66688-5-kerneljasonxing@gmail.com>
 <202506102340.uo7QDaVk-lkp@intel.com> <CAL+tcoARvQVgd68HGoXXiK=+RSH12WQ_rc47B4rgtt2Eb05c0w@mail.gmail.com>
 <20250611170845.8f88347e3cba51cf15a01b21@kernel.org>
In-Reply-To: <20250611170845.8f88347e3cba51cf15a01b21@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 11 Jun 2025 20:20:10 +0800
X-Gm-Features: AX0GCFt9o6cS486F4_y9iaF71LRoSu0_FvAk5vs2fQpwxofQ65dX1xlkNYbdtGU
Message-ID: <CAL+tcoBDJty6o_-c4__P=BES_uP6emO3TcuUTrFCJ92j2wNWPg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] blktrace: use rbuf->stats.full as a drop indicator
 in relayfs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: kernel test robot <lkp@intel.com>, axboe@kernel.dk, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:08=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 11 Jun 2025 13:15:40 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > On Wed, Jun 11, 2025 at 9:42=E2=80=AFAM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > Hi Jason,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on axboe-block/for-next]
> > > [also build test WARNING on drm-i915/for-linux-next drm-i915/for-linu=
x-next-fixes akpm-mm/mm-everything linus/master v6.16-rc1 next-20250610]
> > > [If your patch is applied to the wrong git tree, kindly drop us a not=
e.
> > > And when submitting patch, we suggest to use '--base' as documented i=
n
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/rel=
ayfs-abolish-prev_padding/20250610-085150
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-b=
lock.git for-next
> > > patch link:    https://lore.kernel.org/r/20250610004844.66688-5-kerne=
ljasonxing%40gmail.com
> > > patch subject: [PATCH v4 4/5] blktrace: use rbuf->stats.full as a dro=
p indicator in relayfs
> > > config: arc-randconfig-001-20250610
> > > compiler: arc-linux-gcc (GCC) 12.4.0
> > > reproduce (this is a W=3D1 build):
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202506102340.uo7QDaVk=
-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    kernel/trace/blktrace.c: In function 'blk_dropped_read':
> > > >> kernel/trace/blktrace.c:421:39: warning: format '%lu' expects argu=
ment of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'un=
signed int'} [-Wformat=3D]
> > >      421 |         snprintf(buf, sizeof(buf), "%lu\n", dropped);
> > >          |                                     ~~^     ~~~~~~~
> > >          |                                       |     |
> > >          |                                       |     size_t {aka un=
signed int}
> > >          |                                       long unsigned int
> > >          |                                     %u
> >
> > Well, I suppose I will fix it in the re-spin after receiving more
> > comments so that I don't need to quickly respond to this minor issue.
>
> Please update the patch and send series with my reviewed-by on 1/5.

Sure, thanks for the review.

> BTW, size_t should use %zu.
> Please check Documentation/core-api/printk-formats.rst

Thanks for the pointer :)

Thanks,
Jason
>
> Thank you,
>
> >
> > Thanks,
> > Jason
> >
> > >
> > >
> > > vim +421 kernel/trace/blktrace.c
> > >
> > >    413
> > >    414  static ssize_t blk_dropped_read(struct file *filp, char __use=
r *buffer,
> > >    415                                  size_t count, loff_t *ppos)
> > >    416  {
> > >    417          struct blk_trace *bt =3D filp->private_data;
> > >    418          size_t dropped =3D relay_stats(bt->rchan, RELAY_STATS=
_BUF_FULL);
> > >    419          char buf[16];
> > >    420
> > >  > 421          snprintf(buf, sizeof(buf), "%lu\n", dropped);
> > >    422
> > >    423          return simple_read_from_buffer(buffer, count, ppos, b=
uf, strlen(buf));
> > >    424  }
> > >    425
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
