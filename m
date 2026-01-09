Received: from sg-1-40.ptr.blmpb.com (sg-1-40.ptr.blmpb.com [118.26.132.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092F26FD97
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925364; cv=none; b=Y6bF0cRPPvgN/BsOU2L99geagCjgriy6rfusrwgbKiWlKLNo3OrbazowfDJPcU8DMKgqynSuFK8x7s1m5Rx/Mg/3IXDABEaiwl3ZVbFezxx7cfvM8NXxR4k4DaOXSCnGJy8+DMi96XDYKXgmmoQAOHUln9P2hNMpM9dYX18Ynv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925364; c=relaxed/simple;
	bh=IAEfhmmUijbWbqSReA5Z9zDEAuXJpD+w64rA23X8H5U=;
	h=To:Cc:References:Date:In-Reply-To:Content-Type:From:Subject:
	 Mime-Version:Message-Id; b=Z9vuvzUVhzI/yS1IT8uYS3+Xo2skpakktMmyylIhaKZxQO4C8Ugqly/bstfhRKdYJVDa40Q826Q6Q+SB3v6EsN48B6Ub5HJ+3FCKyEHSy9OSAT+g4DQcSRl/Atm49eCB7Nd1RxybQ8OzRms9ezL7j1Y84USN/WumXhLgftF2soU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=qE3nMn8S; arc=none smtp.client-ip=118.26.132.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="qE3nMn8S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767925351;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=IAEfhmmUijbWbqSReA5Z9zDEAuXJpD+w64rA23X8H5U=;
 b=qE3nMn8SAaJVI1t+LBUgr7KoUd0KPYRXjNY6iXocWyuqLgDNHT1RucBZKHjrT8o9olyTAq
 PSOUuzAOf9KPAiiyjbc1b0j0DYwPLYFd+vlZurQGn37JD0rg7uB1kQj6kq8tCA1vZY7SiQ
 1DHMPf4KGI3EuULUkavXf5udjr3QG6j1GU6djndldaK3fEG+38JKGlgIrqOXkkTxlROQ0H
 uVy5bXmW+v3L+Sm/SatoSMhpM5dFtl7jg4Z/nfApgmnKgHaFR5+3uOaQ6fdPl55NGb7t7o
 PhOCar0/nAtyKNYlA1omQMxchyoHU8w23m06dGU0USFFaV1ctuTJWaPrXYYGLQ==
To: "Ming Lei" <ming.lei@redhat.com>
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <tj@kernel.org>, 
	<nilay@linux.ibm.com>, <yukuai@fnnas.com>
References: <20251231085126.205310-1-yukuai@fnnas.com> <20251231085126.205310-10-yukuai@fnnas.com> <aV5L25KZkM4dvzLD@fedora> <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com> <aWBliob1SiDv9NZa@fedora>
X-Lms-Return-Path: <lba+269606665+78e90b+vger.kernel.org+yukuai@fnnas.com>
Date: Fri, 9 Jan 2026 10:22:27 +0800
In-Reply-To: <aWBliob1SiDv9NZa@fedora>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Fri, 09 Jan 2026 10:22:28 +0800
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs reclaim under rq_qos_mutex
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <f1e4273d-707f-4245-a2d0-2ab13857c22e@fnnas.com>
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2026/1/9 10:18, Ming Lei =E5=86=99=E9=81=93:
> On Fri, Jan 09, 2026 at 12:56:33AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> =E5=9C=A8 2026/1/7 20:04, Ming Lei =E5=86=99=E9=81=93:
>>> On Wed, Dec 31, 2025 at 04:51:19PM +0800, Yu Kuai wrote:
>>>> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
>>>> configuration, and fs reclaim can be triggered because GFP_KERNEL is u=
sed
>>>> to allocate memory. This can deadlock because rq_qos_mutex can be held
>>>> with queue frozen.
>>>>
>>>> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
>>>> useless queue frozen from blk_throtl_init().
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>>> ---
>>> I think this patch goes toward wrong direction by enlarging queue freez=
e
>>> scope, and blkg_conf_prep() may run into percpu allocation, then new
>>> lockdep warning could be triggered.
>>>
>>> IMO, we should try to reduce blkg_conf_open_bdev_frozen() uses, instead=
 of
>>> adding more.
>> Fortunately, blk_throtl_init() doesn't have percpu allocation, so this i=
s
>> safe now. Unfortunately, blk-iocost and blk-iolatency do have percpu all=
ocation
>> and they're already problematic for a long time. The queue is already fr=
ozen from
>> blkcg_activate_policy() and then the pd_alloc_fn() will try percpu alloc=
ation.
>>
>> To be honest, I feel it's too complicated to move all the percpu allocat=
ion out of
>> queue frozen, will it be possible to fix this the other way by passing a=
nother gfp
>> into pcpu_alloc_noprof() that it'll be atomic to work around the pcpu_al=
loc_mutex.
> The first question is why blkg_conf_open_bdev_frozen() is used by io-cost
> only? I hope it can be removed, then the dependency against percpu
> allocation can be killed.

Even if blkg_conf_open_bdev_frozen() is removed, as I said above, blkcg_act=
ivate_poilcy()
still freeze queue, and later pd_alloc_fn() will still run into percpu allo=
cation with
queue frozen, so I think problem still stands.

>
> Thanks,
> Ming
>
>
--=20
Thansk,
Kuai
