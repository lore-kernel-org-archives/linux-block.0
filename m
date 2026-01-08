Received: from sg-1-36.ptr.blmpb.com (sg-1-36.ptr.blmpb.com [118.26.132.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F852253A0
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891412; cv=none; b=YRMwW6PD5DPt8JDOCldPcFo5WzV1sgUgwg3WYqQg6Jo/P6Oh7/ft7u3R5e4qizAJ4gRr9uPb7f8KfdXOoW8AxsdJoYzGIP4aXHd/jbcJczB8wdUeq41oZkebz4RGX5o4vTFemy6VwsttKUy5dJSqBaUt/asrI9O0zDMdUOVU8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891412; c=relaxed/simple;
	bh=2HF6GpWWIyisA2XPQ0fmSGBV60z0j5ytuEfxTL2nh6w=;
	h=References:To:In-Reply-To:From:Subject:Mime-Version:Content-Type:
	 Cc:Date:Message-Id; b=YQnTJjz6+jIM0jCxZm918doN9GD/JH3GwccGlDJq0EdN2eIcHeTsLgRJzDa3nIfrG8yKFR3QKJTO/JoQT6P7BB5l7wh1zoimeBuvLvSH7yiRjShKgN8ON7xpnBHA4YZzt2eAzblyQBVJ8TBZaKn+u7WDw+arTWnH6LoRTicpHCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=KUHrbWlS; arc=none smtp.client-ip=118.26.132.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="KUHrbWlS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767891397;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=2HF6GpWWIyisA2XPQ0fmSGBV60z0j5ytuEfxTL2nh6w=;
 b=KUHrbWlSzM0W0UPrdcE5Cfimi4pvKZO6ZhoetnA3SPTenugw575CsnZH4Ce5Pr1BvvoR4z
 QoR0/xjA8Vxru2KbpZm65C6f7MW60/RJ10iRAe1mDvZ1gV3ovHoCg5cXbXoD9udHkAZdec
 z1/jhtg/JbrgB3ysmjrze8yINrHn6IseR44NfOkEmFGsOyUQ6uUNHRwTIVl+SmE0IsJBIV
 S9+FLVLtXS/b7vrx/gZIY7TdD622Ngfd58tNDOQph1Q71Vd2Ln57os9W2h+35xDX/I1GYz
 u6hnOk21uEKDPuTR13jeq2xWFXcCM2SAFGw24R+GZqOBrHPRly+ost9YRi+kHw==
Reply-To: yukuai@fnnas.com
References: <20251231085126.205310-1-yukuai@fnnas.com> <20251231085126.205310-10-yukuai@fnnas.com> <aV5L25KZkM4dvzLD@fedora>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Language: en-US
To: "Ming Lei" <ming.lei@redhat.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <aV5L25KZkM4dvzLD@fedora>
Content-Transfer-Encoding: quoted-printable
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs reclaim under rq_qos_mutex
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2695fe1c3+8e1511+vger.kernel.org+yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <tj@kernel.org>, 
	<nilay@linux.ibm.com>, <yukuai@fnnas.com>
Date: Fri, 9 Jan 2026 00:56:33 +0800
Message-Id: <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Fri, 09 Jan 2026 00:56:34 +0800

Hi,

=E5=9C=A8 2026/1/7 20:04, Ming Lei =E5=86=99=E9=81=93:
> On Wed, Dec 31, 2025 at 04:51:19PM +0800, Yu Kuai wrote:
>> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
>> configuration, and fs reclaim can be triggered because GFP_KERNEL is use=
d
>> to allocate memory. This can deadlock because rq_qos_mutex can be held
>> with queue frozen.
>>
>> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
>> useless queue frozen from blk_throtl_init().
>>
>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>> ---
> I think this patch goes toward wrong direction by enlarging queue freeze
> scope, and blkg_conf_prep() may run into percpu allocation, then new
> lockdep warning could be triggered.
>
> IMO, we should try to reduce blkg_conf_open_bdev_frozen() uses, instead o=
f
> adding more.

Fortunately, blk_throtl_init() doesn't have percpu allocation, so this is
safe now. Unfortunately, blk-iocost and blk-iolatency do have percpu alloca=
tion
and they're already problematic for a long time. The queue is already froze=
n from
blkcg_activate_policy() and then the pd_alloc_fn() will try percpu allocati=
on.

To be honest, I feel it's too complicated to move all the percpu allocation=
 out of
queue frozen, will it be possible to fix this the other way by passing anot=
her gfp
into pcpu_alloc_noprof() that it'll be atomic to work around the pcpu_alloc=
_mutex.

>
> Thanks,
> Ming
>
>
--=20
Thansk,
Kuai
