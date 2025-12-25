Received: from sg-1-38.ptr.blmpb.com (sg-1-38.ptr.blmpb.com [118.26.132.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46725D216
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655889; cv=none; b=OsrJZMdbHTDbJM8OkuABdiXMeKhj8Nfx0kK8PeSPqAHWVXzLoAWUztvgQ5rWs6NbTuFNk0J6glKm24sBIJCznMAb9lNPDDiGxNVf03vxwJ9AJvsbEKpR5YFfaU3ShVkBTyT3SLvL9msUWU/mOb0k8kz9iidtEZygNrcExg0kHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655889; c=relaxed/simple;
	bh=CE1+eYlv3FtiD3jIDMxQBfmwirtxEXdxnNTVnf0L/50=;
	h=Mime-Version:References:Date:In-Reply-To:Content-Type:Message-Id:
	 To:From:Subject; b=jkA6SnUZIug3DzstowOm7rpZdcDCTXJTbfWUsun1nc5C+q4xbeJYSTwmt8Lmo8+IqJMFPZmW4P5wmq8c46rMt/wuAEzD4az2VE7GXx2Ig6q4mUAnDxc4qJVnELjAXl+eD76uwi1fMlfZd7pTmLAWIgaulb9gam5HodtT3mDLTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=oGHOV2xj; arc=none smtp.client-ip=118.26.132.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="oGHOV2xj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1766655047;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=wsor6s5FUGPt1YmMXehxOSLz+2NyqQ0ERhRS9GPmpS4=;
 b=oGHOV2xjtM8LJWnc6egbiwQrdbrFVYKk0KM70wYWKKBHWbgstni9nh53MXcFDtSS77eJ/s
 osC3WYHRsklQiXbfAf9tXcG01Yv2Gfs46HTRWm2I1ah/xG+i7yo54VSzZPJfmv6FfgZ19U
 sZGK2PHCAI2ccP6SL7/B/mjR4KCCqXaWQVnpHyGtB4s7/ZYBRj6wz/NLDS7g8Otsj0AseC
 EZNXP97niKbgcFRX1ArKPmV63cwPVQhPC2TWhYEq3HTrJYFS3WpLb13UXUNIMmAcY0Yiqn
 DtXK035hVnHFUxFCfGgboWOW1D8d3XfJXgnda9oBc0HnJBuLA/39lagW/NUABw==
Reply-To: yukuai@fnnas.com
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251214101409.1723751-1-yukuai@fnnas.com> <20251214101409.1723751-6-yukuai@fnnas.com> <fcdc91ae-8c41-4978-8271-df10c4931903@linux.ibm.com>
Date: Thu, 25 Dec 2025 17:30:44 +0800
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Thu, 25 Dec 2025 17:30:45 +0800
In-Reply-To: <fcdc91ae-8c41-4978-8271-df10c4931903@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <a03985f4-5ccd-419b-9e04-dcc02dfd6e55@fnnas.com>
Content-Language: en-US
X-Lms-Return-Path: <lba+2694d0446+00b231+vger.kernel.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <ming.lei@redhat.com>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v5 05/13] blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static

Hi,

=E5=9C=A8 2025/12/18 22:52, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 12/14/25 3:44 PM, Yu Kuai wrote:
>> Because it's only used inside blk-mq-debugfs.c now.
>>
>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>> ---
>>   block/blk-mq-debugfs.c | 4 +++-
>>   block/blk-mq-debugfs.h | 5 -----
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 128d2aa6a20d..99466595c0a4 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -14,6 +14,8 @@
>>   #include "blk-mq-sched.h"
>>   #include "blk-rq-qos.h"
>>  =20
>> +static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
>> +
> The only caller of blk_mq_debugfs_register_rqos() is blk_mq_debugfs_regis=
ter_rq_qos()
> in this file. So if you can move the definition of blk_mq_debugfs_registe=
r_rq_qos() just
> after the definition of blk_mq_debugfs_register_rqos() in this file then =
you may avoid
> above static declaration. Otherwise this looks good to me. So with that c=
hange,

Yes, this looks better, I'll do that in patch 3.

> you may add:
>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
>
>
>
>
>
--=20
Thansk,
Kuai
