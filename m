Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A473009F2
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553927; cv=pass; b=TA7eTTwAHTnhnCClXG39qbzKJareA4pdb4mkC6etg6WKLsqaXgkMR+EylqSiEk/5QsrcnTbM9wXsjqWQUTvIH/eFuoPD0i9WU4o85y+SxbIUhwa8Q85cmRc4YULbvZyWZUYjVeXm4XbDb2m0/sGVWZL3yZfZJX5LrMKRnG30JZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553927; c=relaxed/simple;
	bh=Db4TAAnVc2T0Rf7Wc2cEY/pwtSDY+KMo+MImooH/kK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0bXIXt2+oR/ZMJgANlSybc0xZPaXlkSdQcny5FvzExTXm/zUOGt5ugafLUrKp+ryBhCBc7Sk/oIoHOuJmyB0OHnxbU+qdBAnB/HDUp7GjTf1ONJkwmjrrbS0rhxhZGD83SNnWCyIMzinP7z0zcQIJK+VlyncHm1z+m4tY9TeYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDA+SkwS; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDA+SkwS"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1273349c56bso1761942c88.0
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 12:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774553923; cv=none;
        d=google.com; s=arc-20240605;
        b=ixwAOdye/GtM+EGUXeEBLB8b9U/wovEfSWtYSB+CY0C9djPMWthSQ9rJAySbmQp/8o
         nShrqUD0R+ktOAvwhdDT+DjvtZxCtet6GXQEr4Fd9HJ3pfyZy+YgvRf8AVZUToENRwhj
         A0cAeNtcqIjfthLIoBYbL6176TBq/ZhCAjNJbJ1Ov+n9fgiT8lu9F9IBvhjOW+dVNzhX
         yw5zQ8P0ABlGBblCh78/+mCQi7XHx2fGm/EfdvW0NuZV8XqWKwytU2AQ2qYxGAnTbVh/
         GH2JhDBNPYgqaOkNPNozJjC4jnwjhWlaY3D+W2O9hJEceWa0P8oE7jG2H/ovsp7nit2L
         OdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6mCMJ7IYsFJz0Hh2fdQYOLxKjKcxltIu2zRqwDNj3FY=;
        fh=NMsIEFgw96sMojPQvcSdDOpyGZ02Flm9OhWMmlqwucQ=;
        b=M31qRoF5O8WRjGCTeQt3+q+48gnw7DKxy+WfGevRZbHvYLtqHzXS7T2HBQ+8dYI644
         JYO7YuNFtzHreCToPLs+svuzAriwbQkcc/nljqwpDnW+wYqB4OyRCgmBq3kwD+9i3Pto
         bfMDdrcPzcavdGRG/AFdqjzOHnyTow9H/zXDst1Rh9WrOzsUUAkeTpwJ7iHq5VDVmqFQ
         XcNCT9bKM914LAEz77osd31WdxzjHBKpVSuPnh2GkDw6oXYCKRIwwrgjA9Fwo9ttl1bq
         FnmWGwkwyqvj9wvMG+5UotzLs1w58738t5ViVALo5RC1Jrc+0c3cTzzyudy2dAeUTwDq
         a0bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774553923; x=1775158723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mCMJ7IYsFJz0Hh2fdQYOLxKjKcxltIu2zRqwDNj3FY=;
        b=EDA+SkwS9Skn6lYNPPcUJLgJvB0g2H2zN0O0bU6sVAOrOJEV5gJBx/H269PKR7xNZy
         t2RV9cW/kpdumIBYYfGDND2y1IYmVvqE5oEi/c1JUz9x4FFp9IepN+bDU/SFqKca6aXk
         G3w10Ot1BKwp1fvdTdA2cDt+C2CcQtuho4Ze8hPrPIbvM7yA/IRwW/tIzDCvjFVa3ldJ
         3f3H++J8vIfznls60hPlIfaEoQWcJbTJH8ioAzEVIqpx/t7Yl7Sey2GIhmA2aOW4cIzd
         rZPewUy7/65pw2oxSrqr8zhoVGE0dQK13uH+kLBXeSW2cYPKn0BtfsTf3DYGABQdV0Uy
         QVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774553923; x=1775158723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mCMJ7IYsFJz0Hh2fdQYOLxKjKcxltIu2zRqwDNj3FY=;
        b=BWI415TK4ImMQ3KmTIMDxGTFxHCx1HQ6uxEd5FuTP0ScglHuBDXEXXQEdvPgLTl7Ju
         bT2I91T9/f9HnmpUscSNxknie5bboVbTrhU9fxqFK6GMok4skzIkvcRtx5cIxQvvVHKA
         YE6kH9brGmZWsBjnCm34RfmIQQbsukhEhw1ETdfiX31VNa1MrorbSiw7AkbhALawJMp6
         r92xRhUaJRe4F3yCTLVWvYnctUv7LfOsMjpDDxWayqgVS+qM0guvgZI4CbPdzbiaYxh6
         N2OH7VseMQqY7oOqysE/5pv8ntXLfPx8xSpiVyeD0dpzgwBQ6RsoqIQSSPx9FSqOM6C9
         IkXA==
X-Forwarded-Encrypted: i=1; AJvYcCVhDE9QWm+NuV5SZEC6Fv1HDzqy32oioGZ7BfzA3W7CKmwQsZU8X1vDgvlDuTZTJNBDRSjky292fTwDmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuK3qMamOtMZ+z0WGSPz4G/wweA240HPFUxzSqnTKx1l3kW64F
	iBHIfM8mZYRYCV85YQ117qrCvyv28Sw9gxSgfJBpp0o2iY8B/ruoEggZuNYILG6/BK4/unGrt0T
	N+2uJKSIzwXJT9p7QtiCZ69FLhRbN9hUrfLz9ERiC
X-Gm-Gg: ATEYQzz6tx/wFBAVsDzadFF8T5mBMNM+wt1WA2r/X7BO2oHkVVoFaRYyU4SpQx7IXk/
	j9Xg8VgItLTaOycL/gGgfdoJWJCapdILw24CzNGZihqnKCf2JEGaHHpQT1QrD4/EEgVFthiN32C
	XL4uAUGKOon6fpzGuxJwpXoHXkeRU2yU28NZqqhCcfwxPquP6VZTWHXxRU+11LUgFAa8ZzW21xB
	gOjg9mIit6oTBwfPhkyNyKO0UoLI/1id8ozUSYGDmRZ5Rbd0/XZXgYSvh4bcfY6yYVrZr/dMi6Z
	ItEplm9fDGYpZKJSLyn+YEMGS0kcDP0DQ7ONB1FRSmLFcZbh+8sQaJDv4mKDWgIxSr25ow==
X-Received: by 2002:a05:7022:ff45:b0:128:d51a:5157 with SMTP id
 a92af1059eb24-12a96f09443mr4300359c88.33.1774553923052; Thu, 26 Mar 2026
 12:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325063843.1790782-6-kuniyu@google.com> <202603270301.kJulQgkT-lkp@intel.com>
In-Reply-To: <202603270301.kJulQgkT-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Mar 2026 12:38:31 -0700
X-Gm-Features: AQROBzC56kOOvilMQ9x7JfCrqjezesmORZsrlXxqw-kdyJdYRmxiltxnB1IbvvY
Message-ID: <CAAVpQUBdco4wFmdVFdi4yQbH38fDCNLL-SUD=udBUy8uJ0spqQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] nbd: Use lock_sock_try() for TCP sendmsg() and shutdown().
To: kernel test robot <lkp@intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, netdev@vger.kernel.org, 
	syzbot+7b4f368d3955d2c9950e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 12:14=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on axboe/for-next]
> [also build test ERROR on linus/master v7.0-rc5]
> [cannot apply to next-20260325]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
nbd-Remove-redundant-sock-ops-shutdown-check-in-nbd_get_socket/20260325-175=
457
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git f=
or-next
> patch link:    https://lore.kernel.org/r/20260325063843.1790782-6-kuniyu%=
40google.com
> patch subject: [PATCH 5/5] nbd: Use lock_sock_try() for TCP sendmsg() and=
 shutdown().
> config: x86_64-buildonly-randconfig-004-20260326 (https://download.01.org=
/0day-ci/archive/20260327/202603270301.kJulQgkT-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260327/202603270301.kJulQgkT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603270301.kJulQgkT-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: inet_shutdown_locked
>    >>> referenced by nbd.c
>    >>>               drivers/block/nbd.o:(nbd_mark_nsock_dead) in archive=
 vmlinux.a
> --
> >> ld.lld: error: undefined symbol: tcp_sendmsg_locked
>    >>> referenced by nbd.c
>    >>>               drivers/block/nbd.o:(__sock_xmit) in archive vmlinux=
.a

ah, CONFIG_INET=3Dn.  Will fix it in v2.

Thanks
