Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8F35675A
	for <linux-block@vger.kernel.org>; Sun, 31 May 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780228623; cv=none; b=sPDg9OlKxjRNUM22CLcAtiKiRoDtsdGuCeD5oL2un8yFJAWusng+Sdi+lZU2qU65p7Y27Iq+Sy29sdytObvfE5JIW7yxVMj6DnxsjtpNp0QkNTZGAEFddQZ+qSjDn3bcn74fbIaBClNUOuAme7FdLHujmQsw66WSZnKtHbl7SwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780228623; c=relaxed/simple;
	bh=PFVkuc9ck+YfNbC5wFv4eYPkxXj0IiFN9MYa2xxF+cE=;
	h=To:Message-Id:Date:Mime-Version:Content-Type:Cc:From:In-Reply-To:
	 References:Subject; b=HEjT1SQpWmkeF93hQP4GaCxfqI5VE3epTQcXcyr1gVd0lzLY2oCfw2Tugfucd57Hcx2UoVrXUyMS5zj9L+/2eMgxIQ00dj69ynmY8kljSyQUsHHm3trAX/KpYhAt7luXnG8uTFwWUfIcuO1spEij6AfbHLH5NNj1y5Cf7S5qkNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=CdnAVSQI; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="CdnAVSQI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780228614;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=a1yFhzOs94Gff6VzLiMSxnIhsi5rp4kxTwNggMas7Z4=;
 b=CdnAVSQIr8gALxQdwdIyZ1b69qpLYZ01bBVU9amrOPvKEN51Mes59yZHA7/URvSuqzAPHJ
 wiISor17F9MDw83fLy5BN8gdiMIVaZceSQQpMTwSs6PSjDlI041HxeuAvpuPw/5rKbE7KA
 hzhVT+p6/OprTq0qrRlmcaPKZSqbWq3O9mqQzMxjO35Usxetem0JowC8veubAIEPI9xypg
 x5N6nGB/QY96zUwS5zbRTXQk/5cnQFlCoZm6QpfFTaCBFejsGcQ0PmTfQeFPndJsrCAc1x
 LW6YyqvKkc/jstpJTqnG3kH4peCUQJhPRLZXVsQ3GNcTlbWZrGRx2tc9lpWHLg==
To: "Ming Lei" <tom.leiming@gmail.com>, "Wen Xiong" <wenxiong@linux.ibm.com>
Message-Id: <5c2b1ccc-f443-4f8a-bbdd-77e9b739bd90@fygo.io>
X-Lms-Return-Path: <lba+26a1c2204+765654+vger.kernel.org+yukuai@fnnas.com>
Date: Sun, 31 May 2026 19:56:50 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fygo.io>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.134]) by smtp.feishu.cn with ESMTPS; Sun, 31 May 2026 19:56:51 +0800
Cc: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <jmoyer@redhat.com>, 
	"Gjoyce" <gjoyce@linux.ibm.com>, <wenxiong@us.ibm.com>, <yukuai@fygoio>
From: "Yu Kuai" <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <aho5HxLsWMEpbUg2@fedora>
References: <338169f719c77e4afe58f42e9760349e@linux.ibm.com> <aho5HxLsWMEpbUg2@fedora>
Reply-To: yukuai@fygo.io
Subject: Re: Observing higher CPU utilization during random IO fio testing
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2026/5/30 9:10, Ming Lei =E5=86=99=E9=81=93:
> On Thu, May 21, 2026 at 02:44:22PM -0500, Wen Xiong wrote:
>> Hi All,
>>
>> Our performance team observed the higher CPU utilization in RHEL10 compa=
red
>> to RHEL9.8, observed the similar issue in upstream kernel(v7.1-rc4) as w=
ell
>> when running FIO random IO tests.
>>
>> System configuration:
>> 47 dedicate cores
>> 120 GB memory
>> PCIe4 2-Port 64Gb FC Adapter
>> FlashSystem: FS9500, 12 LUNs/FC port, 100G each LUN.
>>
>> Random IO tests are more CPU intensive than sequential IO tests due to
>> several factors: more context switching, Interrupt Handling,  cache
>> Inefficiency etc. We found out the following patch which caused the high=
er
>> CPU utilization in rhel10 and newer linux kernel:
>>
>> commit 060406c61c7cb4bbd82a02d179decca9c9bb3443 (HEAD)
>> Author: Yu Kuai <yukuai3@huawei.com>
>> Date:   Thu May 9 20:38:25 2024 +0800
>>
>> block: add plug while submitting IO
>>
>> So that if caller didn't use plug, for example, __blkdev_direct_IO_simpl=
e()
>> and __blkdev_direct_IO_async(), block layer can still benefit from cachi=
ng
>> nsec time in the plug.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Link:
>> https://lore.kernel.org/r/20240509123825.3225207-1-yukuai1@huaweicloud.c=
om
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> We reverted above patch in rhel10 kernel and upstream 7.1-rc4, saw lower=
 CPU
>> utilization when doing the same FIO test.
>>
>> The patch adds plugging in __submit_bio() in block layer, maybe cause
>> performance degradation:
>> - Random IO tests have less merging, flush overhead.
>> - More IO scheduler interaction, forces requests through scheduler inste=
ad
>> of direct dispatch(direct dispatch to hardware queue)
>> - Poor cache locality during plug operation
> Yes, it is expected to see regression on QD=3D1 workload.
>
> Adding inner plug for caching timestamp only is not good from plug functi=
on viewpoint,
> because only the outer code path(io_uring, libaio, ...) knows exact IO ba=
tch size
> and can decide if plug should be used.
>
> Given 060406c61c7c ("block: add plug while submitting IO") doesn't provid=
e
> any performance data, maybe it can be reverted.
>
> I am wondering why not move the timestamp cache into 'task_struct' and ge=
t wider users?

Yes, this is exactly what we did in downstream kernels, the time is cached =
in task_struct
and IO completion also use it. And this is probably why we don't see this r=
egression.

>
>
> Thanks,
> Ming
>
--=20
Thansk,
Kuai
