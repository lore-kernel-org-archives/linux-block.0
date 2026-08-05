Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5225357CEC
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919011; cv=none; b=HtyAIsOEUihaOlopuDadhSACsKg6ey190zFFwk5LUQV5J76ICAl/xX5+BZWyZzxet+qsjWiwTZ7iPjc+EM2+n7w8Cf2QfZUVsCHrunn1zb0yHCUTa+DefbP65hjNXxWxll2RTrxMihU17I7gqg0KhhxQIK3Kb21dOPYcogv4mVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919011; c=relaxed/simple;
	bh=Kn0vV4pmcI8syr9mXMdF1RJRo3kht3nfvId0qSAAI4c=;
	h=References:From:Message-Id:Cc:Mime-Version:To:Subject:Date:
	 Content-Type:In-Reply-To; b=l8HjQzoHB+2Dp2IBQlTeqaWLs3WBy3KK1oSOUfc0r8PjxFfpeKi7St26ljKzNXFQH6HPYHS6SuwyRvFikI7PPh5vNgAn++6lqRZIjvMK95ZxpKVMtmvnwGj3hfr3+jfWCs+nq6Fk8jU6SoWcyARlGPqkV4njnfRS+XHVc/FyJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=XpFHrxqO; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="XpFHrxqO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785918994;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=xcr8rBiqdCL71e/sCMJPWRPbxuLwWDDEoUiB+OuQ7ts=;
 b=XpFHrxqOwPqlYTzP2khlPa6P9iciy0ly87z2tN+eV5qXj1HuiwE7nc++YxHoNBRYMkWRgP
 CCAppTLttu0OR+Z4YaVWkZ2eVV+ZvgZM9QV/kY1cYTG48Q1Gy+AdkhWpIy3DxnPjV3lqqG
 alSzYZ++ONE6Ns1Eq74vp149ExgglsRZuiBITa+lFq+ckCtRPRLcnfInt3D3yWZk9zqfhN
 1DCwioZY5gPSF4MJVMqybx4P0yIgl43X2zUhy/V59VfiNHNg/RKhaXUQJ3sWTw0Jgffnht
 pfPMA/vKr9zdUytBE3T8fhJDvqRE2APlz8K1jHfDsmtwd+PukStuDuPkOiCpYA==
References: <20260805065843.3332859-1-yangerkun@huawei.com> <20260805065843.3332859-5-yangerkun@huawei.com>
Reply-To: yukuai@fygo.io
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <d9a0c2d3-a17e-4520-a7ca-d1a14a14ddc7@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26a72f611+8e9eee+vger.kernel.org+yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
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
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Wed, 05 Aug 2026 08:36:32 +0000
Content-Transfer-Encoding: quoted-printable
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v7 4/8] nbd: remove queue freeze in nbd_add_socket
Date: Wed, 5 Aug 2026 16:36:27 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260805065843.3332859-5-yangerkun@huawei.com>

=E5=9C=A8 2026/8/5 14:58, Yang Erkun =E5=86=99=E9=81=93:

> nbd_add_socket() kreallocs config->socks, which a concurrent reader in
> nbd_handle_cmd() could UAF; commit b98e762e3d71 ("nbd: freeze the queue
> while we're adding connections")froze the queue to block that.  But the
> freeze costs an RCU grace period on every socket added, and setup adds
> them one by one.
>
> After the previous patch, nbd_add_socket() is rejected once nbd->pid is
> set, so it only runs during setup.  There the capacity is 0 and the
> write cache is off (cleared on disconnect by the preceding patch, and
> re-enabled only later in nbd_set_size), so submit_bio_noacct() rejects
> every bio before it reaches the driver -- non-zero-sector ones via
> bio_check_eod(), and flush-only ones via the !bdev_write_cache() branch.
> No I/O is in flight, so the freeze is unnecessary.
>
> Signed-off-by: Yang Erkun<yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 9 ---------
>   1 file changed, 9 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
