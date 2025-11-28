Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B072FD671
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323723; cv=none; b=tnC0kqkLUSnLbfdQmeDZ1pVL7r/8v4b5qzIO9HP0f3lsbXvRKeH4++QCNZv9MQmQtxD9GGHLeeoRt0RrDrM46UrfHsHd4GuhzrVCSuW41WLluc04WoebNG+AWcozj7cZtQhSkkAXcOHquMEeuODQ9Mwf/J+aOEh4oTQZshN+zOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323723; c=relaxed/simple;
	bh=MSLZEJNbsm/1l1SBPaGrfg4CO8kqaTS3nEpIKS6lp/c=;
	h=Subject:Date:In-Reply-To:References:To:Message-Id:Content-Type:Cc:
	 From:Mime-Version; b=Zu813M5ipJlSY16T+HicUZRf2u4R7exSeekWM5z6bi3Ymrco9dMR9d7ydfQc4IWtKpf/E1dCQNR1jBub+w0ALE8in3/fcQaNHr7AJpv3iU5POnD7AmGFS9LjRm99P1iqdIyCul0JwLIxZOTArl+2xuAhy4YuA+2VI0vOBTJWndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=smWfJ5D/; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="smWfJ5D/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1764323702;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JDOMz3mKd7nGDmIX+sMUNUG6EFw4a0oI0snxBtINnCo=;
 b=smWfJ5D/CzjMIiCqJ9BySSShVk7UkMM55fEWaRv2F4Jn/55jtqhgpU7H//Lg3AOb4d4alc
 Cs11afd2yBt4VykYCt2prsJq0Q1RquemX4/TpQCdcLROQ7BVzfrv/cZx+SQgynu14JZFja
 v8KbSzT3mlbci1+NrTL/19/ppk6653AB3AzG5Gv8PQ3HIYHFF+J92lhrMcwTCVVCpsRmk9
 ENkL2UWjk3n7HYE0nXf6DIHDOHt+dV9CxgUgPaowpooV7RmOn7Knu3D9KrLiYuqn7aaRGU
 /yoStXAqj3srdk1RiDw3cx5gJE44QhbRG2SgCHSUhaAA0TB/fz8Y5ZEC6CyIWw==
Subject: Re: [PATCH v3 0/2] blk-mq: use array manage hctx map instead of xarray
Date: Fri, 28 Nov 2025 17:54:58 +0800
In-Reply-To: <20251128085314.8991-1-changfengnan@bytedance.com>
Content-Language: en-US
References: <20251128085314.8991-1-changfengnan@bytedance.com>
Reply-To: yukuai@fnnas.com
To: "Fengnan Chang" <fengnanchang@gmail.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hare@suse.de>, 
	<hch@lst.de>, "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <7dd622b2-b064-4209-a74f-9084ab835cac@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Fri, 28 Nov 2025 17:54:59 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Cc: "Fengnan Chang" <changfengnan@bytedance.com>
From: "Yu Kuai" <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269297174+538657+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Organization: fnnas
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2025/11/28 16:53, Fengnan Chang =E5=86=99=E9=81=93:
> After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
> an xarray instead of array to store hctx, but in poll mode, each time
> in blk_mq_poll, we need use xa_load to find corresponding hctx, this
> introduce some costs. In my test, xa_load may cost 3.8% cpu.
>
> After revert previous change, eliminates the overhead of xa_load and can
> result in a 3% performance improvement.
>
> potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
> avoid, same as Yu Kuai did in [1].

Hope I'm not too late for the party. I'm not against for this set, just
wonder have we considered changing to store hctx directly in bio for
blk-mq devices, are we strongly against to increase bio size?

>
> [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.c=
om/
>
> v3:
> fix build error and part sparse warnings, not all sparse warnings, becaus=
e
> the queue is freezed in __blk_mq_update_nr_hw_queues, only need protect
> 'queue_hw_ctx' through rcu where it can be accessed without grabbing
> 'q_usage_counter'.
>
> v2:
> 1. modify synchronize_rcu() to synchronize_rcu_expedited()
> 2. use rcu_dereference(q->queue_hw_ctx)[id] in queue_hctx to better read.
>
> Fengnan Chang (2):
>    blk-mq: use array manage hctx map instead of xarray
>    blk-mq: fix potential uaf for 'queue_hw_ctx'
>
>   block/blk-mq-tag.c     |  2 +-
>   block/blk-mq.c         | 63 ++++++++++++++++++++++++++++--------------
>   block/blk-mq.h         |  2 +-
>   include/linux/blk-mq.h | 14 +++++++++-
>   include/linux/blkdev.h |  2 +-
>   5 files changed, 58 insertions(+), 25 deletions(-)
>
>
> base-commit: 4941a17751c99e17422be743c02c923ad706f888

--=20
Thanks,
Kuai
