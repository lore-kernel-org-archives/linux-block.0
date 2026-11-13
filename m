Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794557484;
	b=1UrQmGkmsvx9a/dqcxnmsX6Vtn7r6OmkeHxMF3tcH5kVaXsAR+P/fcjKORlFmsdRy5LN
	 JvVs6cpgDD5yc0dO5VBRtavf+4aqM4YXdFFYzDVd4NdClqW3pSdA65/glAJUD6clvJP4u
	 XPuGP2/zACG6Ec7dDEo50l7BBpzopgPa5++iQW4p1Ub4aRlYXYoRWiKKs6pN1OgdCrBL8
	 NvmePFCPzEfEGmWHnQU3QeJIH6FUuUNBTGR5lALW7uytqv6xDweUsledZZxZFojRouELO
	 DuW5Hu54tQsmiuyK1OYoQAcaJ0ZKyJ/CryKXYg8zvg4sWd3xJldpSyDDTon/S2ii++g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ky1fNcYST3cXVSIleurQJpPQOjWYx5UwkSzn2L6E/3w=;
	b=yaas3T9N/TnmWFmZlkmbe2ATWmKBOPeidE0xTA07UPpAJHcXvOd0tfDo4uNNJQGg8BzU
	 23CjoQGnCof9LA9pGGKw584xXtvZG7Q9qeTbBeg8VMdjHWDYQ8AuQtuyfV7VFBprvbh/S
	 5uqlm4lXdZZO68T2Jn7bFzZ33EQjmqoKQ7spuBGd8lBPGiJ1UjhTl7zdUtciFpqi4Dofx
	 YHNnK6U9xV+zO5TkN+DoigkCAD04gBmr7vKy6/RgQWSo/k/KD7lag5PvsUOC9VKK1u6ll
	 Jwx1HV9etX6emVbaCnwyeUs78N4kgbAeUWFbDCWdKC9rH0yLOXpbEdK3bncxAjaSbrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=RoiB4+Uo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE2606A32D
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 08:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49CE2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=RoiB4+Uo
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2af2ae1258so11758066b.0
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 00:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794557482; cv=none;
        d=google.com; s=arc-20260327;
        b=AHxAfRjgMSID+IBx8Ole7bLAWcgHniWCPc0kXTW+WzMc4expIgMwLOQkC2Of7MCJN6
         tKxluaOThCqFs6kkhG1xSaLPAkkVksLAt76DoepvJIfu+8blz/8V2NPr3iiXkZra0V4G
         3ZEwl89BSCeyri6cHF6Wn0p5zn5JS9IDLl5kmjAWcMfaheUcUeasQ1Z5Vk6blYWUo5Vb
         Xbvk0tvVSY22YCExoS0avZjmFJP30JkOso9xlV51xxlVSkNu1D/FEng7Ye96yted3xTn
         YQ4SmgcDnqCMNFC01cLam/FFlZK15SFk0cXwfbk3jA7LOTYqtgjOnwXOBWi/bLSuHL4y
         fqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ky1fNcYST3cXVSIleurQJpPQOjWYx5UwkSzn2L6E/3w=;
        fh=Zlz+8Ms2UIByTpW+APlFW/1/j1U+/0EmmvSy6SpQHoE=;
        b=kizzVPLjTQM+cUTbBojnLFYeKR/qra0VEsObdnScB4jtcSGv/aymOhpgpeTDwx7qW5
         AEjX7UTAtNlOZDsBZinRpC8NwbEuFBvCyeAJubYH+GaGj4r6xzN7yaIPTKejxYtRPa+L
         xkBcWFQo+bC+ZZNouqlqcKksegrok9F0ZKqt7hxOVlcRHpNsKvXCiaNd5myS1PBb8Y/2
         8uerfQ8HDmNH1OmI+y13rbnV7iUsXKgkWnsh4hwHC8/bk1ISOlExB/SrjS0M/ucE3eEk
         TeVOZUU5A1zqkw5wiZ0CPiZBpYQdAHKQ5R6b8B+NDTh1TCU3V87b8T6KRdm0K94Mn8wE
         fW4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1794557482; x=1795162282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ky1fNcYST3cXVSIleurQJpPQOjWYx5UwkSzn2L6E/3w=;
        b=RoiB4+UoGSczVUtmvGGqpCMRdVCJB7IYCoFNsDaXMTFxQglY8TD9+u00qf9xfVBLTM
         OVUgTPCC25F+Ez/mrvl6dgpMVGIzbBpmJ9drIsW6Q8/HCtCMvvdBsAbH1cmmbBkAF/ye
         4GMeoWkKO6XKgzzBCJu6ad8YOym0QKOKJf3Zd+oceBCFSAeoiLl68MzvSGU54u3HPl3k
         MJ8UxTZ08ogM3OjhlkTAwNiK0rv1R5b5Q+EhfIIQ+lcA1+vQFiumEDay+FpnpOKcfrhe
         W/742E3xH6z0ccxiwYHGJ9YgELqSd1U/kuJHlJo7Wk7kF45PJ/vt5MNigvWAn4elvSAx
         ODNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794557482; x=1795162282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ky1fNcYST3cXVSIleurQJpPQOjWYx5UwkSzn2L6E/3w=;
        b=F//y9ntClFJsmyy6r7MAYxGEjhb77OFhnRG7wECt3u8PAa4o2XF0MFWPN9Fc4Kigip
         umZ8Isq7cNuNtSvpSI+PBKCjO9eh+hCsvbJeu1rfdHsqspmceLfIRxpLY6HXVDLI70a3
         2lMG1h7j6WmMTXaFS+RjCik/zlVw+WtyL3TK+9CqIGukztdG9MQOA9sJGP5h8wXkDt8B
         VdWhvlRDPAYXUYQtjwBsn6vXZlrjN3eGoVP/D+2fnazUdjUU0yXlQfzAVNx66gbkINBD
         14GWstDFtmbKylWL+oyFl++FB6peA8XWVLAYMnftGFU217LiZav5TCY1ownemgb9/k9B
         78Bw==
X-Forwarded-Encrypted: i=1; AL+hErErxaBfV1stmdPn4QtrCpAq2jV9VMBu12jl03Xy1bXLWdSGeGoGWf2HHrViYjfmFilaPdHtD6V8YKkRZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xwRt7ZT0K6wsKsHYTtQQPJR+3qS0GYYpLlMps+EK93WgjCWn0
	N/fVdegKWsGTElHX5IQ4pJcHDA8LecKNuQMjK+1OqskHoNGMrCxaZ1artC/0X3U/hxDBJf08yIg
	2+n4pwocgmWpSo4zuWpA4zPIslkmwGsC+YKrYhBSDHg==
X-Gm-Gg: AYBFou2pGMHrtLRGP1FR+wnP5biGB/eeewHiG/2ffpCsVlDUuZnUHSVCIlBdeTYh+7X
	yYuKAcFHs6HgZY1AZJIMu93Droci08K6/FZ3i2u5+Y/LLwGXdt5zhdHtqw2lLui9bTmFDy+Vbzc
	6rGtoOUwvog0Hls52t6Av6XVSSDPx+EnK0Khzpe23IOsxG9kVSnUL13op4vMsXztG1s2RY25gAI
	F8LzRsJ7LUh6UJoI0jyKlzVY/3YoLzkafJ8ETgEs1zyBQIjPw2M8/i+YLjXDN/1GniI4f+pyT0B
	F01jq2PhCUQNDRW9sXAQPru7qmBuxhiVq2B/G7rbIAmZ2Nv5kcEcbWmYt9dchJZIOQvVKGD9PA1
	U/75xtNJymZckBCWYneLNa5hQWC27/k5EsGJOHtN8VE6+a6Tck5sdRKkizZ16du6mv36Rdg==
X-Received: by 2002:a17:906:f183:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c509642ceeamr126451666b.4.1794557481497; Fri, 13 Nov 2026
 00:11:21 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112134700.372702-2-jinpu.wang@cloud.ionos.com> <202611130354.oOiDWpa1-lkp@intel.com>
In-Reply-To: <202611130354.oOiDWpa1-lkp@intel.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Fri, 13 Nov 2026 09:11:10 +0100
X-Gm-Features: AclHuK_ijeVtZl53-Nr24xIboJn-g0mWRkSzGcLkYkpL9J_f9DfqfuDTwKSOTUg
Message-ID: <CAMGffE=bCVxcuDzUdGk=btfu-bdHhwofHQ6qkgx7UmQTpvSyhQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] block: suspend bio based disks around queue limits updates
To: kernel test robot <lkp@intel.com>, sashiko-reviews@lists.linux.dev
Cc: Yu Kuai <yukuai@fygo.io>, Song Liu <song@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>, linux-raid@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all

I will fix the __releases(&disk->queue->limits_lock) annotation in
next version, will wait a bit if any other comments.

Thanks!


On Thu, Nov 12, 2026 at 8:18=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Jack,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jack-Wang/block-su=
spend-bio-based-disks-around-queue-limits-updates/20261112-144659
> base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> patch link:    https://lore.kernel.org/r/20261112134700.372702-2-jinpu.wa=
ng%40cloud.ionos.com
> patch subject: [PATCH v4 1/2] block: suspend bio based disks around queue=
 limits updates
> config: arm-randconfig-1002-20261112 (https://download.01.org/0day-ci/arc=
hive/20261113/202611130354.oOiDWpa1-lkp@intel.com/config)
> compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 1=
b1fed44d3dcca649a9877915d57c3357a98124e)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20261113/202611130354.oOiDWpa1-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611130354.oOiDWpa1-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from block/blk-map.c:12:
> >> block/blk.h:680:10: warning: releasing mutex 'disk->queue->limits_lock=
' that was not held [-Wthread-safety-analysis]
>      680 |                 return queue_limits_commit_update(disk->queue,=
 lim);
>          |                        ^
>    block/blk.h:681:9: warning: releasing mutex 'disk->queue->limits_lock'=
 that was not held [-Wthread-safety-analysis]
>      681 |         return queue_limits_commit_update_frozen(disk->queue, =
lim);
>          |                ^
>    2 warnings generated.
> --
>    In file included from block/blk-sysfs.c:14:
> >> block/blk.h:680:10: warning: releasing mutex 'disk->queue->limits_lock=
' that was not held [-Wthread-safety-analysis]
>      680 |                 return queue_limits_commit_update(disk->queue,=
 lim);
>          |                        ^
>    block/blk.h:681:9: warning: releasing mutex 'disk->queue->limits_lock'=
 that was not held [-Wthread-safety-analysis]
>      681 |         return queue_limits_commit_update_frozen(disk->queue, =
lim);
>          |                ^
> >> block/blk-sysfs.c:909:3: warning: mutex '(kobj - #undefined)->queue->l=
imits_lock' is not held on every path through here [-Wthread-safety-analysi=
s]
>      909 |                 blk_disk_resume(disk);
>          |                 ^
>    block/blk-sysfs.c:897:9: note: mutex acquired here
>      897 |                 lim =3D queue_limits_start_update(q);
>          |                       ^
>    3 warnings generated.
>
>
> vim +680 block/blk.h
>
>    675
>    676  static inline int blk_disk_commit_limits(struct gendisk *disk,
>    677                                           struct queue_limits *lim=
)
>    678  {
>    679          if (disk->fops->suspend)
>  > 680                  return queue_limits_commit_update(disk->queue, li=
m);
>    681          return queue_limits_commit_update_frozen(disk->queue, lim=
);
>    682  }
>    683
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
