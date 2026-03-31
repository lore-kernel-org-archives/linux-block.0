Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A140DFCA
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935923; cv=none; b=DxM69cjLueasXN6vZJU6HkoxPnglHD0vM+Z3I0krm3S1FBhpOzlwQl3xzFSH9fG4eB5EWbcMAYCsf+3sgP3xovbfNkzrv8Zekemf1lT11M1gYKaYRFm65B9xHWw7ShMbyKbrq3dmlLLugODx5V1REVLgFceO+lhGpuW+kakN5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935923; c=relaxed/simple;
	bh=SypVQSVxi5XtQW51gLDuEakKT6HxcKdTC7Kv+CrbHA0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DqXY1eI8IbYzIuUD+qnw3f6MyUwRUXrF+Ut7CGYVjWTTtm94ZMFXlqaJ0qTngCQrNrLckCzh20VWgpRSV8yqobAClwDYjs0Czpxu0WFMkVYvCCOaT6ZVnW7zCSkiowEZ3ctpOpcM6cL1lJA31SVx40Vx4GPofIbwtzpjqbMYCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cS/9fG2W; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cS/9fG2W"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486ff201041so51635925e9.1
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774935920; x=1775540720; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PV+pClYWl9n9dOUQFJPU8EbBwTvdv7sBmpGNoz6Ln18=;
        b=cS/9fG2WQbq81NpCu/oQniw8w4wroO1jajXvOp2SAOE0BMt4M4MxVt3p7tTP+ku5Tv
         kJ1hjRSe2XsCEsfDeojn5yChnNVDH/ZGRg/REY861ZIataIwwlDK3uOEtRWK5dChat2P
         yuLGZU9ywn9nq0h7jCiwExxzMkhz0wS429s41EslchR9SSF6qczLibgEIbK7iDh0Nuqf
         KAbZbZyhrXxmwEw1CDtxilbKmsWmQfuoZlrUQbtv6h/arltvr7aFpPp8qSJ8iwPrpwdZ
         cy045qHDSdo3iWmh9hD/xR8oZzmEUWZjnGx9Tt395F96KWufOpFCqLZS44PkIGqH9vX5
         dNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935920; x=1775540720;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PV+pClYWl9n9dOUQFJPU8EbBwTvdv7sBmpGNoz6Ln18=;
        b=ZFPHBBrqJU/7VcPNpL8hrFtQu+kbe9bkNI8NOAAwoWzMDbd/eg4W580/ki9CbpBous
         uKBjFXwu4TVEOG7ElmjyKOtzcQ2B4Ghx/9M+8AjQMk/TfNFHK3iU9MCApRstT/7ecwEh
         HLowrdtQhG+risSZUOwnzHIlKTAn7ucjOrmQHr7XF48M+MedHUNww3yvjlzWIWE01PPP
         /6UWEyl05IE0MpEuxe85Lzb+K4uhzsxYSuy2S+tk5ZYFkQJz7cd02rpju0d6pZOHPod6
         DIxGV9PIHv4F/GpzKz8my7q0z7Jr/5yTUYxa07yd4wr6eoBEh/fzEql/H00H/Wrj1Sja
         97YQ==
X-Gm-Message-State: AOJu0YwYfZ3hb0yDag9QyWUCKsdVJPAnL6blWgNLxoY6YHXu0E599tHo
	R8e/ZpBcAZ/K9GZ6eQiP5wY2G+N1ZVc8qDCjAy4tt1Mm9uay7brEdGq/A4hv1Iy/gbaTL8RasXn
	5H9g0naA=
X-Gm-Gg: ATEYQzy+/Q+Gv35zIewhEoH16rZdqNLQDJj48VgdKftBkXyUEkjoQLDZLMXmyQS/pHj
	bEoBGL1l2mBpDkTumUBBlO/c3GK+TfQZ3A4mf0WorkdjixgNIrNnTosU9Upz/wL2CwmiXhwTlE6
	YWivQIXJEWtsvP5+tFOVyPHaoENU0UZVef4iyXhjq5GuEema4xXRdjcItIcc86zD9iBGLLQIK3Y
	g4uvOd5OzwboEUWjIfvA8mXYKEwSMIHYK2niMrGCdDy9Mnwt3cUJdd8X0J/1zyCfJ6yYUad2ZIr
	AV7WG/UiZrfn3HUeNFbiLULONluunX6Ezz3M9AdLrTxKFdeNUs50/QbuAActV4xXOlTCG0zZDtS
	pZAVDbdxZhml1lG/1JLvrnhk2qoBcCegAS7jE7BdWm07BEwACJYXg/wMy/jFQSlb6l7kNmmJEKa
	skYjjWEPJRjXkLJ6CcHJ43wqP9F0cIlDSXgP0HRKvHH556dOcXqrU=
X-Received: by 2002:a05:600c:41c4:b0:486:fc5f:1ab9 with SMTP id 5b1f17b1804b1-48727d8410cmr167946465e9.14.1774935919750;
        Mon, 30 Mar 2026 22:45:19 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242676e13sm102522115ad.28.2026.03.30.22.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 22:45:18 -0700 (PDT)
Message-ID: <92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com>
Date: Tue, 31 Mar 2026 16:15:14 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 minchan@kernel.org, senozhatsky@chromium.org
From: Qu Wenruo <wqu@suse.com>
Subject: Super slow subpage IO on zram block devices?
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Not sure if it's a regression or not, but on the latest 7.0-rc kernels, 
the discard is unacceptable slow on zram devices, if the block size is 
smaller than page size:

  # uname -a
  Linux btrfs-aarch64 7.0.0-rc5-custom-64k+ #7 SMP PREEMPT_DYNAMIC Tue 
Mar 24 13:38:13 ACDT 2026 aarch64 GNU/Linux

  # getconf PAGESIZE
  65536

  # zramctl
  NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
  /dev/zram0 zstd          128M   0B    0B    0B

  # time blkdiscard -p 4k /dev/zram0
  [ It takes too long time that exceed my patient ]

After a reboot, if discarding using page size (64K), it finishes in seconds:

  # time blkdiscard -p 64k /dev/zram0

  real	0m0.024s
  user	0m0.004s
  sys	0m0.011s

I understand that using block size smaller than page size would cause 
some overhead, but seemingly eternal is beyond my expectation of "overhead".

Is this a known bug or something else?

Thanks,
Qu
