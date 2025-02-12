Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867781DDA1B;
	Wed, 12 Feb 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360859; cv=none; b=m23tL6SQ7AV86TLg679UW/e0X+kww8Os7T6yMGTv1xv4d/30B9wW5oW/Z3mAR8aAcJ4lGS4og5fMidlTjEYEUdTt1j57Or+tDvrOsSDeEzT6tOh6rWu0qiN5bJay2ltumSQLno47GCC2nVTmKuyWDpbjo8iDkA0x3Mqau9M/+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360859; c=relaxed/simple;
	bh=3FtJRc2IltoMj+mCq22wPBFnDdU2IMjYKEhIx6mDmDA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=l/N4FN/riX3lyE+NzqYU+bGDmG/Wiq017Vomo67XeyBJus9Vv6LCP6PJfCFH5xykquuHrZDG+RGH8+7Xt6laWANjl3AkjSn86MQiZV3u085G7Ugdhq7XatMRC7YidJWO+tC5v89Y2GhC/lNVvdOW7q3OXSYY2q+o9O2fer95r/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 25b47fee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 12:47:34 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 12:47:32 +0100
Message-Id: <D7QFYOJVX22Z.CU0EL0NHPNS8@bsdbackstore.eu>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
 <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
 <D7QC8AQ7J89A.32TNPSFWV1VNX@bsdbackstore.eu>
 <202502121747455267343@cestc.cn>
 <D7QEA7XPBML4.1R0M64OD4BH43@bsdbackstore.eu>
 <D7QF99BR5YYA.2CXBBA5RYACTY@bsdbackstore.eu>
In-Reply-To: <D7QF99BR5YYA.2CXBBA5RYACTY@bsdbackstore.eu>

On Wed Feb 12, 2025 at 12:14 PM CET, Maurizio Lombardi wrote:
> On Wed Feb 12, 2025 at 11:28 AM CET, Maurizio Lombardi wrote:
>> On Wed Feb 12, 2025 at 10:47 AM CET, zhang.guanghui@cestc.cn wrote:
>>> =C2=A0=C2=A0=C2=A0=C2=A0Hi, Thanks.
>>> =C2=A0=C2=A0=C2=A0=C2=A0I will test this patch, but I am worried whethe=
r it will affect the performance.
>>> Should we also consider null pointer protection?
>>
>> Yes, it will likely affect the performance, just check if it works.
>>
>> Probably it could be optimized by just protecting
>> nvme_tcp_fail_request(), which AFAICT is the only function in the
>> nvme_tcp_try_send() code that calls nvme_complete_rq().
>
> Something like that, maybe, not tested:

Ah wait, this won't fix anything because it will end up with a double
completion.
Ok I am not sure how to fix this, someone else maybe has better ideas.

Maurizio
