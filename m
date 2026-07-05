Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E91BC08F
	for <linux-block@vger.kernel.org>; Sun,  5 Jul 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783245751; cv=none; b=PO2p1PI6SpvDU4cASLwfwEPmBangTTvSthZNyFSYPzK2PrifOrDVbZh+LdLY/EzoMPtdjesTBsrEExGpapO8XnQVEJPoUQGryKgAq2d/a7TUfKOga9JaFaHfNwOkt0nrmlN9DlNMiPCUbPbFYs21sHzTs5Z8E47A3FAhepVccOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783245751; c=relaxed/simple;
	bh=yzvPQSNoglOkROzTkgdF2ri4FeOBblQ3Sl+BLD/Ep1g=;
	h=Message-Id:In-Reply-To:To:From:References:Cc:Mime-Version:
	 Content-Type:Subject:Date; b=ZfFmeR+/SAh4aVKpgrb+AYCwBcGV8UZLi+vgHjRU5SIgc+rDysgldCExDJvjD0i8OZtS6c+mBqmsoIHmAmj4vZq5Uorwxn58OsffcYWIMtKUZ+zJ5RL6ZKPhpWN9YhBOw/sQtKC1mymnRItZxZ41aj3BV5fDr5XAayxmapeBq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=gk3Dfo/K; arc=none smtp.client-ip=209.127.231.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="gk3Dfo/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783245741;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=yzvPQSNoglOkROzTkgdF2ri4FeOBblQ3Sl+BLD/Ep1g=;
 b=gk3Dfo/Ko5a7eb+MToZo8ES1JwM+J4NSuIfIMDxzDAk+HbgVOclEraOnwfiJWz4lFvX/1C
 fq/BelbbxywTDOwcEcQMYbrIvOJ104JicN5d8yQ63dbQMJ2xgsXOdqItZa/YmeoWAZVAg9
 LFm/6otRqpgwB0X3XGAQwV+y/b4u9EcO5WgjKWVSqXcqi2MJ4ao48O3iY28yRb0a81nGiK
 u33Gbkn4eekth3VCTqKl+xaoIpCPdINMOvh2vXa6PAP5MvLrnU6Bhc9KC+P5LUc74JQkNn
 5r6Jk1HsrM3sBqaE+z5pSuuDwxLbjb8VM4bisDeM8Z2Bv8cU/Ln36Mk9NmbBqg==
Message-Id: <913d11fc-0fb8-4111-b995-7fe7e893025e@fygo.io>
In-Reply-To: <20260625084458.4171890-3-yangerkun@huawei.com>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
References: <20260625084458.4171890-1-yangerkun@huawei.com> <20260625084458.4171890-3-yangerkun@huawei.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a4a2bad+88e11c+vger.kernel.org+yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Sun, 05 Jul 2026 10:02:20 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] nbd: replace socks pointer array with xarray
Date: Sun, 5 Jul 2026 18:02:16 +0800
Reply-To: yukuai@fygo.io

Hi,

=E5=9C=A8 2026/6/25 16:44, Yang Erkun =E5=86=99=E9=81=93:
> Replace the krealloc-based struct nbd_sock **socks array with struct
> xarray socks. Each nbd sock is fully initialized before being stored
> into the xarray via xa_store(), ensuring concurrent readers calling
> xa_load() never observe a partially initialized socket.
>
> Convert all array index accesses to xa_load() and open-coded for-loops
> to xa_for_each().
>
> Signed-off-by: Long Li<leo.lilong@huawei.com>

xarray may not be good idea for IO hot path because of the overhead.

https://lore.kernel.org/all/60f9a88b-b750-3579-bdfd-5421f2040406@huaweiclou=
d.com/

--=20
Thanks,
Kuai
