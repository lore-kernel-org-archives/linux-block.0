Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C952741A0
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727076; cv=none; b=SJNA/4INw7bgX0FmRhBSQfWIMNv/m27FejgfBeZn9P+WDT32GWWGS1J2sqqLW9z7gR8ffnE3rcXtl5jVhrL60oeZ496sqrNGpCX9TG6ShCWdROeq8RzFU8WeyPWRPab1a/WSiP6VNElDKYApqYgBx6SV/C9c1BrjkbuqIwhr5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727076; c=relaxed/simple;
	bh=nXstjd4ItHekk0udMnRLkBVlr/G3XuDithUDU1TF7mE=;
	h=Message-Id:Content-Type:To:References:Subject:From:Date:
	 Mime-Version:In-Reply-To:Cc; b=YfMdmiPE952gj+fX5iEH/mQ4mF7EAj74o3ISyzDolMYY6psWB0vRWfLL/dQy1hotJKW1oJHIEA4XNRU8JiGrOc7JfIh2M6g35lM00xZUhlKcFzGRUkaY6+6B/7CSSoRwrezR8Qslu/70x1DUfWRM/X/ndFr2K4fU6RGldgsZz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Yuih6Zp9; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Yuih6Zp9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763727062;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=QwkOA2koGE90E7w4lnLeFMd5ishqRMNh3TsD+xSj9xs=;
 b=Yuih6Zp92OPEd/UV4nkvrr6SSBxyziEtE657q3MaDLXZrxP10ceNuQWkO32GjG0Qs2z6vb
 6GGqHIiCHwpkHZCwGuYK8SEzN+9BVXgQ4t/0nvAPMwABGATZQaXEh7MmJ9uQ+p4TgRDmKI
 9XYEsLDInCM4/+u5gSHF2/zOswr3z/pj6HAHVTzar3oMTQV6zYR97CtML1ywXV73Qf4VOW
 YrOp3s+Icsfho89nNdyRyYCcO1OvbKgLe/TW9893eYi0FURw5pVErLrjE1YnnJpBk/Uas2
 KaKqloMfhS4zKOi9GTmDUY3/3cZcDJ86+G1JHbooTd7W7edBTmu/YkRiRM/Xiw==
Message-Id: <1ef4ebf9-db99-41d1-882f-e81f60a4d846@fnnas.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com> <20251121062829.1433332-4-yukuai@fnnas.com> <010b72c0-b623-4f9f-b6de-267d5765960f@linux.ibm.com>
Organization: fnnas
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+2692056d4+fe8afb+vger.kernel.org+yukuai@fnnas.com>
Subject: Re: [PATCH v2 3/9] blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Fri, 21 Nov 2025 20:10:57 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
In-Reply-To: <010b72c0-b623-4f9f-b6de-267d5765960f@linux.ibm.com>
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Fri, 21 Nov 2025 20:10:59 +0800
Reply-To: yukuai@fnnas.com
Cc: "Jens Axboe" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"Tejun Heo" <tj@kernel.org>, "Ming Lei" <ming.lei@redhat.com>, 
	"Bart Van Assche" <bvanassche@acm.org>, "Yu Kuai" <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2025/11/21 18:46, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 11/21/25 11:58 AM, Yu Kuai wrote:
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
> If you define blk_mq_debugfs_register_rqos() before it is invoked
> by blk_mq_debugfs_register_rq_qos(), then this change becomes unnecessary
> and can be avoided.

In fact I do this at first, however there will be compile error because
there are still others symbols involved.

>
> Thanks,
> --Nilay
>

--=20
Thanks,
Kuai
