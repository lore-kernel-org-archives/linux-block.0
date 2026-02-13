Received: from lf-2-32.ptr.blmpb.com (lf-2-32.ptr.blmpb.com [101.36.218.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB8450F2
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770956603; cv=none; b=VH7/HUR0OeQlZvfjJ7o7dt5oqISMdrbu+oay48k0XVBFueMxLrdIdr8GhvXRGuibyObfLPD/FEPxDOoKVPd6lydKtXJEb/DnVJi1qGOxCjUYUBB1QaAaP5U2GhaXqGl5W+xHUOKHTsHmb+7iMF3UuDnHFTU1aJbz+nGEJLTGCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770956603; c=relaxed/simple;
	bh=vnI2EwY0aYjtueepJB2owejzWOQGYSlo3u7P0AqTyQM=;
	h=To:Cc:Subject:References:From:Message-Id:In-Reply-To:Content-Type:
	 Date:Mime-Version; b=ADTGPF9RrbKVEsOmbsUKxTFeR3ZYhupF0Tj2sfgHjdhDM45NYclAK67iTZPkjJOnluRuCxj2No7adPUGjEw6d8InbsC1aD45x33vD4VynpGLSutlS4ax1OEgooB02rRN1SyLYUBz3NY4k25wblPrK639JPjqBc9XM9AqbtEh6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=IpqfGXDb; arc=none smtp.client-ip=101.36.218.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="IpqfGXDb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770955691;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=vnI2EwY0aYjtueepJB2owejzWOQGYSlo3u7P0AqTyQM=;
 b=IpqfGXDbA+XaHCYs+nvIoenLCVxVyhXJbGPR/SaVzGfucK5lcQXwNgBLfgmtM6hjA0WkVG
 7JQeI9k+Jcb4gXn4BKVdy9Wzq0/Kl3u4X9g5MUFf2gDzh0Hq/NPHbtevaWsHJ/qOhugiNZ
 IK4si996dTC/guK37CCoNemDZjboyU2S44WJ5uH/DMAn5eHiSepTaPJlKuCmpnDfEtZyZy
 5VmRrtgRuePicf/TUqyE45PDYiz+GOO9tD69chYdwWYrj5VBTXScGrzLVk9ICGfnPIa07U
 iwbDYXquqHP9myerxVStLCTS6NtQIZG1HRWCuW50t30X6H2UMyoqpAmq9HDang==
User-Agent: Mozilla Thunderbird
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Jens Axboe" <axboe@kernel.dk>, 
	<ming.lei@redhat.com>, <hch@lst.de>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Yi Zhang" <yi.zhang@redhat.com>, 
	"Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] blk-mq: use NOIO context to prevent deadlock during debugfs creation
References: <20260212080135.1673063-1-yukuai@fnnas.com> <88a12e1c-05b6-44de-806e-06a8e2ff7c0a@linux.ibm.com>
Content-Language: en-US
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <f3653533-4af9-4bcc-886d-7fb7b7015034@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.132]) by smtp.feishu.cn with ESMTPS; Fri, 13 Feb 2026 12:08:08 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <88a12e1c-05b6-44de-806e-06a8e2ff7c0a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2698ea3a9+f61e99+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Date: Fri, 13 Feb 2026 12:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Hi

=E5=9C=A8 2026/2/12 16:46, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 2/12/26 1:31 PM, Yu Kuai wrote:
>> Creating debugfs entries can trigger fs reclaim, which can enter back
>> into the block layer request_queue. This can cause deadlock if the
>> queue is frozen.
>>
>> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
>> to detect this condition, but it was racy since the queue can be frozen
>> from another context at any time.
>>
>> Introduce blk_debugfs_mutex_lock()/blk_debugfs_mutex_unlock() helpers
>> that combine the debugfs_mutex with memalloc_noio_save()/restore() to
>> prevent fs reclaim from triggering block I/O. Replace all raw
>> debugfs_mutex lock/unlock pairs with these helpers.
> It looks like there are still a few places where ->debugfs_mutex is
> taken but the code paths do not enter fs-reclaim. For those cases,
> it may not be necessary to wrap the critical section in a NOIO context.

I agree it's not necessary, however I also feel it doesn't matter.

>
> Perhaps it would make sense to provide two separate helper APIs: one
> that acquires ->debugfs_mutex and also saves/restores the NOIO context
> (using memalloc_noio_save()/restore()), and another that simply acquires
> and releases ->debugfs_mutex without entering NOIO. Callers could then
> choose the appropriate helper depending on whether the code path may
> trigger fs-reclaim.

I don't have preference here, I can do this in the next version.

>
> For reference,
> blk_mq_freeze_queue()/blk_mq_unfreeze_queue() vs
> blk_mq_freeze_queue_nomemsave()/blk_mq_unfreeze_queue_nomemrestore()
>
> Thanks,
> --Nilay

--=20
Thansk,
Kuai
