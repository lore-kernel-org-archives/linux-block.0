Received: from va-2-17.ptr.blmpb.com (va-2-17.ptr.blmpb.com [209.127.231.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA403EB10D
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919061; cv=none; b=hZ58YfUquNpxPUZeve+uQ74wV1h7fnd7u9rhltjyTOivIU43hSzdfoLjVa8txN+E2gNOz7OOZ9jhADqOINpfHow3QSWWppc2np+1OvlODOTk6JkI+PJbfSOGAWNsT4ZMUNUwc+84loTs3Byz2dOSw6fZFt+quFbpI1Ap7ANAH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919061; c=relaxed/simple;
	bh=Cf49hHQQcJff94/bXcaHRIxkffYTsOSyg1qMSqMXe0o=;
	h=From:Date:To:Cc:References:In-Reply-To:Subject:Message-Id:
	 Mime-Version:Content-Type; b=QULLnRQN1fE7l/IgarRCZ8hQc/PzQEGV3wWFdUnxc4bencF+f9TH4t2bE2XHNIuAVH8Xw+a4baRaOqQLcd/5E7UG/nwsXQSVR+QOzhj0ckcBC7pDC/LNTV7CsS2d2ijX3uuMoaJ0xnWDPE5SSl64gH/mKgr5+9Wj2kLj2negG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=WAFftRXH; arc=none smtp.client-ip=209.127.231.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="WAFftRXH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785919055;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=pIkrT0FrIXOo/d5RjI0+338scV/xZb53ZWxxqbZ/etM=;
 b=WAFftRXHV1ffc/A93+Kpeh8D0N6etQH6Ssfpyw7FWh5JRpzOpRu2u6s+R9I6jAz7vifgIJ
 iUhkA9Idg6lHyFYUmyZ0DQpTDrD2JZlobz5PwbpZycNhybhSlQiUXBjt8BUsmFSvOb6M4L
 /poNm+UsrEjCKKPlISNttJBg6aTVaDFNFHi48jv+/JhSZYtKbnla3KYtFbdyYUwwTLnuft
 78t8+A0svVwVY3OOF8G6Wzxye2QRFWxReOHKNAmUNR78j7KURuyjLQ0p5gZgP5dlmbepAr
 dQFlnL/8+NwkaA9Iawro7slzFw4pfwLu8WZrqztENhCPfhQoyV9B3w5zhs7qeQ==
Reply-To: yukuai@fygo.io
From: "yu kuai" <yukuai@fygo.io>
Date: Wed, 5 Aug 2026 16:37:29 +0800
X-Lms-Return-Path: <lba+26a72f64e+62daf9+vger.kernel.org+yukuai@fygo.io>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
References: <20260805065843.3332859-1-yangerkun@huawei.com> <20260805065843.3332859-6-yangerkun@huawei.com>
In-Reply-To: <20260805065843.3332859-6-yangerkun@huawei.com>
Subject: Re: [PATCH v7 5/8] nbd: skip queue freeze when setting size at device startup
Message-Id: <4db0dcb6-334c-44e9-9da3-a5aab136fa09@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Wed, 05 Aug 2026 08:37:34 +0000
Content-Transfer-Encoding: quoted-printable
X-Original-From: yu kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8

=E5=9C=A8 2026/8/5 14:58, Yang Erkun =E5=86=99=E9=81=93:

> Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
> added the freeze to keep in-flight commands from seeing
> torn queue_limits.  But at startup the capacity is still 0
> (invalidate_disk cleared it) and the write cache is off (the previous
> patch cleared it on disconnect, and nbd_set_size sets it back only after
> the commit), so submit_bio_noacct() rejects any bio before it reaches
> the driver and no I/O is in flight.  Drop the freeze by checking
> capacity and write cache state in nbd_set_size.
>
> Signed-off-by: Yang Erkun<yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
