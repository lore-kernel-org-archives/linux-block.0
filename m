Received: from va-2-57.ptr.blmpb.com (va-2-57.ptr.blmpb.com [209.127.231.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D03AF64F
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672990; cv=none; b=mKvHkdsSG2S0RZqe9vLpzQZ3ur/t2UWZfS7EMEvj0fZngm2o2O9u5oJM5l5RzrNLItVGRw6AnU/77pbvuE6D4F094t8yVNcVrMNBlbYAasy8ZPccdUWC+UhShsAmearZ8500PbubwWizD0EYUKK+8mdrYwAxP8vgvvlw5VwQE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672990; c=relaxed/simple;
	bh=GBP5rq8NVAyQctOEeXWPcqanOCbRl6bcK0gON5edKsI=;
	h=Content-Type:In-Reply-To:From:Date:Mime-Version:To:References:Cc:
	 Subject:Message-Id; b=ecdTSkLP83mIuZHiKPauIK+9sV1TfvgQkahsl/lWAwRNpBvrbdR1tqYZIcRPHKt/MBEiGd6K7geViZYnDCxbvk4dAhon1S5AaXOfjP1Nl5YmDvz+yCxTIsy6Rp5X8fjNyOGysiQ/D5djwuWZgomO5yKiuPMap/Cspoal3iQj4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=fNckF7Ud; arc=none smtp.client-ip=209.127.231.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="fNckF7Ud"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785672970;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=k5C5OlkRwuwrAWMHfYKV+yyp5NZQKGf1XJTtbc5fd1c=;
 b=fNckF7UdM+JxnNsUyhxvz+rWQ59KxALLBOKBUAkfGBYydvWoQmhkwvn58zg/AAoCl5Sg0Q
 lnWJUIBa31GbiSariMbGx/PGLMciAj9WVnOvIxa3WgyM4gOlv+I3Sk1HFkdzHPQEHb3Kce
 cQQUp1dITmNEdwcLfzfTu/wyuAI2zmAk8FVYmRWUTcfXL7ancJeXR2J5KBjhRrQMJ4c/sy
 s1ugaCeBXuTrLHPhWEoT1rSO7qKObkhApg1TV3fkdsJf2EXRqmGkYpOnr4KaioMwzrS7S8
 OnXP3i9FEHQ+hnV88cthWQbrZoi48DFh1Z5yT/pqQ+797ClelZ82pFrGPu+qjw==
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fygo.io
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <20260730082046.3459239-8-yangerkun@huawei.com>
Content-Transfer-Encoding: quoted-printable
From: "yu kuai" <yukuai@fygo.io>
Date: Sun, 2 Aug 2026 20:16:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 12:16:09 +0000
References: <20260730082046.3459239-1-yangerkun@huawei.com> <20260730082046.3459239-8-yangerkun@huawei.com>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Subject: Re: [PATCH v5 7/8] nbd: remove queue freeze for newly created nbd from netlink path
Message-Id: <ebc7c94a-f0cb-46c4-8d1d-e90647b9dad8@fygo.io>
X-Lms-Return-Path: <lba+26a6f350a+b63f5f+vger.kernel.org+yukuai@fygo.io>

=E5=9C=A8 2026/7/30 16:20, Yang Erkun =E5=86=99=E9=81=93:

> Previous commits has removed the queue freeze in nbd_add_socket and
> nbd_set_size during nbd device setup. However, a queue freeze can still
> occur when nbd_start_device calls blk_mq_update_nr_hw_queues if the
> socket connection count does not match nbd->tag_set->nr_hw_queues.
>
> The nbd_start_device function can be invoked through either the ioctl or
> netlink paths. The ioctl path only allows reusing an existing inactivate
> nbd device, there is nothing more we can do to prevent the queue freeze
> since the old nbd->tag_set->nr_hw_queues may not match the new socket
> connection count. Similarly, the netlink path can reuse a preferred
> inactivate nbd device, and again, we cannot do more in this scenario.
> However, the netlink path can also add a new nbd device using
> nbd_dev_add. In this case, we can obtain the new number of socket
> connections, and by adding a new argument representing the expected
> nr_hw_queues in nbd_dev_add, we can ensure the queue freeze is avoided
> for this situation.
>
> Signed-off-by: Yang Erkun<yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
