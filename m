Received: from va-2-51.ptr.blmpb.com (va-2-51.ptr.blmpb.com [209.127.231.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071A37C926
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670092; cv=none; b=Rrzo7rzpLyrPj5d29eYfVpTyTVG5e+W2YOjXYUUaiHfT+6sM3fsP/oDJTQc0yFOgyCZoFk+dO000q7D5Xfax883/dESbuk1w8G44/fVEukWiXiKsuT2KdPMuWDGhGk7PIqTSOtVEpYbwUqca1GcAV2BPHJADv7/mk4Pj5OsViP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670092; c=relaxed/simple;
	bh=/jfDPOlPywN/4La9Tg7jDK9wdYv8HkorZJUF1w+xw5c=;
	h=Subject:Message-Id:From:In-Reply-To:To:Date:References:Cc:
	 Mime-Version:Content-Type; b=Um8XlO+AFJRmUeqJCN96tRO4P3M+M5cgqntbeUkms68Su3o+H/tbZ+3cnmcFAxKiDAIMIN9Rt4YT0SdZLekv/XJGbxhkOLbqYaaCh6wdpgdYtxU3jhvtYlaUmFeaLYProFYQhXoWj2RgdDat9df/r38G10nH9oIi+rgPRuehMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=Bc3fqa8X; arc=none smtp.client-ip=209.127.231.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="Bc3fqa8X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785670076;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ihlRfsPOSM0uReND4oanKeryCV7yyvMe6vhP6nUWyug=;
 b=Bc3fqa8Xwyir0Xr1yZn2RtdrEMyEVkbQLWr2ZpjUlQrowIZsho4NoJkxr6WVtqLru1RzXu
 x9po7ljvvTEGK+0NhvjNsUriAPBgCZkdhCj4O6vkk5/r8kYLLsziZdBPDVRWzkgsVrQnrI
 umbPmXs4/wHxr/T3expwHyUEtkX6txj+pk1p0KmKnEscL3ahQv9NNzJj3j42VxUm1MDJee
 0/ySLL5Um8Pz5Sck3FobjVQFUOmoSDnZIYwOz66k6w8TJD4KrrjK98rDN/jZasgmQQmN+F
 /yIfY3nSj+otT0wmOa5NvidDg1hMELzQek715YEZ7PjyXuAPRSqeh+4p2mDH8A==
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH v5 2/8] nbd: disallow NBD_SET_SOCK on an active device
Message-Id: <bf15d6e6-3a1d-4140-b659-8d47f645d713@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
From: "yu kuai" <yukuai@fygo.io>
In-Reply-To: <20260730082046.3459239-3-yangerkun@huawei.com>
User-Agent: Mozilla Thunderbird
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Date: Sun, 2 Aug 2026 19:27:51 +0800
References: <20260730082046.3459239-1-yangerkun@huawei.com> <20260730082046.3459239-3-yangerkun@huawei.com>
X-Lms-Return-Path: <lba+26a6f29bc+5383fc+vger.kernel.org+yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 11:27:55 +0000
Content-Type: text/plain; charset=UTF-8

=E5=9C=A8 2026/7/30 16:20, Yang Erkun =E5=86=99=E9=81=93:

> We cannot add a socket to an already running nbd device, the reconfigure
> for netlink can only active an inactive socket. But for ioctl path, we ca=
n
> call NBD_SET_SOCK after NBD_DO_IT, reject this using nbd->pid which has
> been setted when NBD_DO_IT. Besides, it is the root cause for commit
> b98e762e3d71 ("nbd: freeze the queue while we're adding connections").
>
> Signed-off-by: Yang Erkun<yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
