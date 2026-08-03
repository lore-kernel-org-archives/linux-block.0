Received: from va-2-19.ptr.blmpb.com (va-2-19.ptr.blmpb.com [209.127.231.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B76390219
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745253; cv=none; b=oDMWH5O+gSHaWwF95LkmB15aeUPI+fe3nU9cd6G9bYcDBMP+zD/ELO7iO+78gj/Kle9B4mZ+Fjb01EvIpA0zKxDG8XsE4BD5CUypVYrQXRgsQF8JctsQ22vMl2XOwVHXjaV6BsbS0htuZ67V7z1sC0Pj+P8g46EBQCSO+xLcaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745253; c=relaxed/simple;
	bh=f190mQjfQj3mfbuSfvQYM1bjfG2Z/ZqbQVZiQrGfOcA=;
	h=Mime-Version:Subject:Date:In-Reply-To:Cc:From:Content-Type:
	 References:To:Message-Id; b=YLgLE5a0ro5o/j6h5txxZCZv8rytTAu45UY2/pUjPTlBsamWPuVm+tvJKXS5XgTy9/M5j/S4Uas+HE+BpGfSHG4kuthrZt8KEUqXgLcRJzuDACRVqYNT/e2AYLI+lRW6pPvnoOmDkZHQlX8j2sxRUR54XtOKlIBi7MYz0Esewy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=jIV2YHUC; arc=none smtp.client-ip=209.127.231.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="jIV2YHUC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785745243;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=f190mQjfQj3mfbuSfvQYM1bjfG2Z/ZqbQVZiQrGfOcA=;
 b=jIV2YHUCubfE/0R8rVUh3KH3KBQTHVdl2XUDPpZ/bkW1HZc1+6NAfwRoM/jobrWkUJctRE
 bguPDsWBPXvRQFcLSxOeSqTjMDvmc3e13hsAmYbDJb4QyboW4QnOi7AP2VBz2NA6/ljcg8
 Dt47SHyQI833JfS2YvxZ79V8+MefwGZlldIjR9m/yzcU3Rd25X2tauXMMF6hJUyr1/TcIz
 lhrP1dTZ7ezfX8T5/v1JI5PsO3GqV+TVAwgWh778BNhsJ870H+JZfBAT6+aLXOUZ5dXr5g
 EWScZXpLNv4fgzDzYiYAh0hsWABhk9Bc9wwZVm8APuUdIUyMvmbzfB3FwKmE3A==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Mon, 03 Aug 2026 08:20:42 +0000
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH v4 0/4] blk-cgroup: fix blkg list and policy data races
Date: Mon, 3 Aug 2026 16:20:38 +0800
In-Reply-To: <431ed2f9-9fde-4ff7-9db7-51a56bec17c0@linux.ibm.com>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhengqixing@huawei.com>, <hch@lst.de>, 
	<yizhou.tang@shopee.com>
From: "yu kuai" <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26a704f5b+2ce59e+vger.kernel.org+yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
References: <20260802112525.3933753-1-yukuai@kernel.org> <431ed2f9-9fde-4ff7-9db7-51a56bec17c0@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <tj@kernel.org>, <axboe@kernel.dk>, 
	"yu kuai" <yukuai@fygo.io>
Message-Id: <055d481c-dbfe-4749-82f0-49e330724d86@fygo.io>

Hi,

=E5=9C=A8 2026/8/3 14:51, Nilay Shroff =E5=86=99=E9=81=93:
> On 8/2/26 4:55 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> This set fix some problems that are reported long time ago with=20
>> minimal changes,
>> the blkcg_mutex refactor I'm working on can fix these problems as=20
>> well, but it's
>> complicated and may not land in this merge window. So I think this=20
>> set should land
>> in this merge window first.
>>
>> Patch 1 protects blkg_destroy_all()'s q->blkg_list walk with
>> blkcg_mutex.
>>
>> Patches 2-3 fix races between blkcg_activate_policy() and concurrent
>> blkg destruction.
>>
>> Patch 4 factors the policy data teardown loop into a helper after the
>> race fixes.
>>
>
> This series looks good to me, however as I recall, we discussed about
> protecting blkg_create() as well using ->blkcg_mutex. I remember the
> blkg_create() is not protected with ->blkcg_mutex under each call path,
> so would you to also cover that change in this patchset?

I can't do this for now without a big refactor, because it's possible that
blkg_create() can be called from bio_set_dev(), and bio_set_dev() can be
called from many atomic contexts, examples are patch 1,2,3,5,8,9,10 from th=
e
following RFC v1 set:

[RFC PATCH v1 00/17] blk-cgroup: protect blkgs with blkcg_mutex - Yu Kuai <=
https://lore.kernel.org/all/20260704195124.1375075-1-yukuai@kernel.org/>

>
> Thanks,
> --Nilay
>
--=20
Thanks,
Kuai
