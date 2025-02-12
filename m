Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BF207A2C;
	Wed, 12 Feb 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356121; cv=none; b=i7GcD2BD89co7A9GSLKUsNsbhF99U543tXSEt4NJry1VrIJlXMucfjbFEum4+LkJPiGGw4+kH4IO7x49pBhrT1N7vD4QICopYoCj+c9nxCP5VkuVCHjjYl8eLv6AS7paEe9b5vcz7qgW57SFSFuy8g08dc0DTstN+Z4WfNnvq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356121; c=relaxed/simple;
	bh=mVjnLn9E3sfJKDIcyN7wAZ/FXjiM8y8O7MiQKQj5kCw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=djIu6mqyWF3sXDqrsTcqC8Rn9PbxAm2Sa8O9oaWFdhDBec8FxshRyglL6avnEsUpCCttfB5+WcjcFBvGu6Kk8hK9zLj4j8UuShtisTolmSTXgauBLiVK/+h8CWceY/h9zNCDzBXQQoTlVhiWVG6PAMGyxVTDfDqnp/sL9o+9f9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id e97734e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 11:28:36 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 11:28:34 +0100
Message-Id: <D7QEA7XPBML4.1R0M64OD4BH43@bsdbackstore.eu>
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
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
In-Reply-To: <202502121747455267343@cestc.cn>

On Wed Feb 12, 2025 at 10:47 AM CET, zhang.guanghui@cestc.cn wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0Hi, Thanks.
> =C2=A0=C2=A0=C2=A0=C2=A0I will test this patch, but I am worried whether =
it will affect the performance.
> Should we also consider null pointer protection?

Yes, it will likely affect the performance, just check if it works.

Probably it could be optimized by just protecting
nvme_tcp_fail_request(), which AFAICT is the only function in the
nvme_tcp_try_send() code that calls nvme_complete_rq().

Maurizio

