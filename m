Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78633262B
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090380; cv=none; b=NHnNVjxWyl/MuTE+gYP1iGHs5idph9YVa4/t7UzrcEqupS8L4e1Ry0LIjm/Du99OdHaYhdGoL7wAdi7RxP98sp5E0wg9nksXBT0YHQ7lZzey/NPIXeLnwGQMtfICleZ9bVjX062XdzAb6og9YbOrvYcJCXXuCtziLUwyC6AYIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090380; c=relaxed/simple;
	bh=rnKxrWOjKXqj9c355UP75BYy+gEpLiXB6sdrH3IBDQc=;
	h=Subject:Date:Mime-Version:Content-Type:From:Message-Id:
	 In-Reply-To:References:To:Cc; b=jKSTlZriD/H02paxl9/Una8EiZfYtNi8zqBKSAfMmkpFhLKwPf5xujRq4ijNHrA8dBwFyie1kKry2gTBwNgPMLxsvLubSrqwiOx11yJr5hTciRZwHoQ4jIo9/o4yIj92cBLNOtaWf9jd3vN7HE1f1bLV+OomyLyRSXu/7NDF700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=CgzcKVoG; arc=none smtp.client-ip=209.127.231.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="CgzcKVoG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1786090356;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=GMUnD1C44aJAVaU6J6KgGOtm7mD3DGQAze672X2mOAU=;
 b=CgzcKVoGn8Nx6vye68MP2sYN3cwPs2e+3RwD7dEHPN5wpxDin4ogbSb2/Xj1JFYBz9R15i
 d3TgTZIv4GJHeWqarnz4DQgYlyqodrxw4Q2fEWRuAZWmiL2csXImgdZWR45SaHpKecTBXf
 8nvZ/OoglmSAtgtG5DKhg1J5Y7nYLf8zsIsl502dOQIWzmdRE4PHKyz7GG6ydZdT28RW6z
 8nN/L5S0/cRX23PPpmBWouNTiSyt7a4Ev/VDyOC3/xMFv019vSsWW10JMugWF6weHpnuhd
 X0ehKTL4/gXiqq6Oo18PQzULt4siFjfhgF4TRkn/X+NXyvGQWWwOVF/l189mtw==
Received: from [192.168.1.104] ([39.182.0.170]) by smtp.larksuite.com with ESMTPS; Fri, 07 Aug 2026 08:12:34 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
Subject: Re: [PATCH v8 8/8] nbd: add pre_defined_connections module parameter for pre-created devices
Date: Fri, 7 Aug 2026 16:12:30 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <b75f1941-1083-424d-9bf9-29f1fa63f88b@fygo.io>
In-Reply-To: <20260805122930.57647-9-yangerkun@huawei.com>
X-Lms-Return-Path: <lba+26a759373+dfcccc+vger.kernel.org+yukuai@fygo.io>
References: <20260805122930.57647-1-yangerkun@huawei.com> <20260805122930.57647-9-yangerkun@huawei.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fygo.io
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>

=E5=9C=A8 2026/8/5 20:29, Yang Erkun =E5=86=99=E9=81=93:

> blk_mq_update_nr_hw_queues() in nbd_start_device() may cause a queue
> freeze.  The previous commit addressed this for newly created nbd
> devices by setting the expected nr_hw_queues in nbd_dev_add().  However,
> when reusing an old inactive nbd device, the queue freeze can still
> occur if the old nbd->tag_set->nr_hw_queues does not match the new
> socket connection count.  Inactive nbd devices can originate from two
> sources: loading the nbd module with nbds_max, which sets the default
> nr_hw_queues to 1, and the netlink method, which sets nr_hw_queues
> according to the expected number of socket connections.  For the first
> case, add a module parameter so the default nr_hw_queues can be
> changed.  Users who know their expected number of connections can then
> prevent queue freezes on pre-created devices via nbds_max.
>
> Before this patchset:
> real    0m2.195s
> user    0m0.005s
> sys     0m0.022s
>
> After this patchset:
> real    0m0.090s
> user    0m0.004s
> sys     0m0.018s
>
> Signed-off-by: Yang Erkun<yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
