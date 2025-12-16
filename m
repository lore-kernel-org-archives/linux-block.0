Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092533D6D3
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885449; cv=none; b=Evtyp+C/5kVMhS0NJTBOTQsuB4w5I6sde54yqO5KTqhRlRGfv6Km0od00wzbJpi69int2Er6Npv4EwxW90+88lkQnPMocDrbo1NaMofqmLzS8IM6KeaSrn5xs2aQ9+ThE6ikaJ3qcxSDhTEzsBaeaTF+ozN3+ItD9oQzqQBDpwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885449; c=relaxed/simple;
	bh=V5W9BsfqANLEO8EfVRyUQ5QdGYEshmtgCO/2NlB5gIE=;
	h=In-Reply-To:References:Content-Type:Subject:Date:Mime-Version:To:
	 Cc:From:Message-Id; b=Y/0kWfV5ekA1vjsOoeOPW9LtRFkdmkDfaN5eE55OYjeTCGx3wXLbbBeLHHiTW2TwfNOV5V6pQauQ2ts5zhsV8ZGPcXZh3bnjZMg4iKuOQKuXCEAA2LW5JYKVDBcbYxynEoah1fS671/rJYtkqKmv1BvYjlPJJLMxyNWTZqqZZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=m1i9MNPW; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="m1i9MNPW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1765884601;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=50PlIfa+gIxCiu/b4xqnY1qheuIwEr+TOkLfEwdErn4=;
 b=m1i9MNPWpTu0JSf9ZuQIC0XSufF9C2WfdLkDWBG83YEp/xppIASlQ3Ivbz/tPZFvREqrVM
 d4LRAhk9hqdD9xYUoBZhlSy1Afgree0CXB4KkBP5HaeBI3R9saJ7l9A8iJSjXAC3q2+dIm
 rnbj+TDPk2PGZYWBYyFRQwEunambi9sMncgOIWAFzhgYzehUm6L2MEELj0+4J6dY0ML/6X
 /LAL0v4OkIGZmg5OTfUa8mjPyaXfHO7ht82pWxOKaKEKhaUd7/jEt6rDCpNaAr+iXi3Xsi
 emHC7ftGnPk2rO+RRBIQKSmQkWjfoeZYG6hQNKZsAnql2g5c7Rqq9v+Z3sEMuA==
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aUE8lSlWa6DnCYMa@fedora>
References: <20251214101409.1723751-1-yukuai@fnnas.com> <20251214101409.1723751-3-yukuai@fnnas.com> <aUE8lSlWa6DnCYMa@fedora>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH v5 02/13] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
Date: Tue, 16 Dec 2025 19:29:54 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2694142b7+d99a7a+vger.kernel.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Tue, 16 Dec 2025 19:29:58 +0800
To: "Ming Lei" <ming.lei@redhat.com>
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <tj@kernel.org>, 
	<nilay@linux.ibm.com>, <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <d6f37132-60ad-47bb-b003-02cf60cfb464@fnnas.com>

Hi=EF=BC=8C

=E5=9C=A8 2025/12/16 19:03, Ming Lei =E5=86=99=E9=81=93:
>>   	if (!rqos) {
>> -		ret =3D wbt_init(disk);
>> -		if (ret)
>> +		ret =3D wbt_init(disk, rwb);
>> +		if (ret) {
>> +			wbt_free(rwb);
>>   			goto out;
>> +		}
> Here it actually depends on patch "block: fix race between wbt_enable_def=
ault and IO submission"
> which kills wbt_init() from bfq & iocost code path, otherwise you may hav=
e
> to handle -EBUSY from wbt_init().

Sure, I'll rebase if after you patch is applied.

>
> With the mentioned patch, this fix looks fine:

--=20
Thansk,
Kuai
