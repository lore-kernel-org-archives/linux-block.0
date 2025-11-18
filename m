Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B82D8771
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763445419; cv=none; b=C5YOzmz31bcpNy907domuQdFOwP9mh7wQCZia2gV/E6IwCGLbZ8kj6Xx+UC5rTKMXdMe4tJ6lcE4q71Ld8IE38ci+swyOQFaKvgG8O9K06ogoHimkIvgyWDtltOWQWwzle6+kbinSxWg0fNYUh/8din0VBfcP6PbyIq4PZgIhe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763445419; c=relaxed/simple;
	bh=+TTOWBmVVvGm0ThWj7sfk68OK1xH45hMceJ4QiV4yo4=;
	h=Content-Type:From:Cc:Subject:Message-Id:Mime-Version:In-Reply-To:
	 References:Date:To; b=jcTgtU83lhdipnT0m7gTeDUKBJNd4/K7LtlYZKMEPohnT2SkzBInquLL3JRvqoWPw9+/yH5zuacL7Hui6b67IS7BYoAAich6Gv3D3EWJeGDhtmVadHa2eLmt0sRN9QzRT1JwhBVlV8eca8IHQLEdFmhyJiHML8fgAymMOeXiuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Eq9hN7Db; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Eq9hN7Db"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763445405;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+TTOWBmVVvGm0ThWj7sfk68OK1xH45hMceJ4QiV4yo4=;
 b=Eq9hN7DbXKT/3p10GoR4gnnSwFB9NnHzePd5zMoYQEDf1WUFl1Cn/ZH/zA2Vmfg8hntTeH
 +kgSgNFxbMkT4qoM14RGMsbwsa+g/rhQ8LoNgNV6VvTdEvD9WEDKIJhUiZOGzj2cV9wN/D
 JK8Hpn50WQ22H+YYI601RPXMy8ifPG3FVNFssVJyxK9zbjYwT+MRo1r3Ix0k0h4omJCTcL
 Xmxc+JA6AOOZ5l+p845WK8Wozs+xZQhgZrAHXAaKAIa32t0MP5ZomAwqwvBD43/aCZVC86
 KkL1B5L6j15MBU/KlmP1F/Vb3kc3oQaJnLG5Dm5Jb3mem/CtdDjdbuZAXvRQnw==
X-Lms-Return-Path: <lba+2691c0a9b+69530d+vger.kernel.org+yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Organization: fnnas
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Tue, 18 Nov 2025 13:56:42 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
Cc: <nilay@linux.ibm.com>
Subject: Re: [PATCH RESEND v5 2/7] blk-mq-sched: unify elevators checking for async requests
Message-Id: <16e817ab-7444-4da8-bc92-38fa13cb407f@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <d6073899-710e-450d-9907-1a7a69a4a87d@acm.org>
References: <20251116035228.119987-1-yukuai@fnnas.com> <20251116035228.119987-3-yukuai@fnnas.com> <d6073899-710e-450d-9907-1a7a69a4a87d@acm.org>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fnnas.com
Content-Language: en-US
Date: Tue, 18 Nov 2025 13:56:40 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Bart Van Assche" <bvanassche@acm.org>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Yu Kuai" <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2025/11/18 7:35, Bart Van Assche =E5=86=99=E9=81=93:
> On 11/15/25 7:52 PM, Yu Kuai wrote:
>> +static inline bool blk_mq_sched_sync_request(blk_opf_t opf)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return op_is_sync(opf) && !op_is_write(opf);
>> +}
>
> The name of this function suggests that it performs an action while it
> only performs a test. Please consider renaming this function into e.g.
> blk_mq_is_sync_read(). I think the suggested name reflects much more
> clearly what this function does than "blk_mq_sched_sync_request()".
>
Yes, this sounds good.

> Thanks,
>
> Bart.
>

--=20
Thanks,
Kuai
