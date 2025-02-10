Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0C14F70;
	Mon, 10 Feb 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181710; cv=none; b=E9lySH0aeFH1iiHy0jlvZYm9F/mNuIFBfjNPQWsI3MEMbKoC5kEJXDL/YG8lvqUu9ljQUI5C0lV8lr6SQY3bXP8+Thk/icMcf78fdUgT3LfBYgdBwQl4Nn4cnr5rxMS6F4xcquXaEXwYiVdmwIKWc6rN2vsKrWlbI0GqeSkcwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181710; c=relaxed/simple;
	bh=96GvQM+rLNhGqu2cqM9zlmUkzr9OQptMOdGtCwz9Q4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sHQndiV4m4WFz+tuRMV5JQjiYkHuzMaKMniSLXQwWOM0BoHXc3ToZBXez/E2VNSnfCBBUGREDWdttWodefBrmeUuS6hVszV0qGaMwGJlNF+KB8TC1MK2vzt8V7p7ZeEdyuOqQBTualsOBd9n/n/vswZJbWEIPIF4gSpGbyQ04Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 95258b83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Feb 2025 11:01:39 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 11:01:39 +0100
Message-Id: <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
In-Reply-To: <2025021015413817916143@cestc.cn>

On Mon Feb 10, 2025 at 8:41 AM CET, zhang.guanghui@cestc.cn wrote:
> Hello=20
>
>

I guess you have to fix your mail client.

>
> =C2=A0 =C2=A0=C2=A0When using the nvme-tcp driver in a storage cluster, t=
he driver may trigger a null pointer causing the host to crash several time=
s.
> By analyzing the vmcore, we know the direct cause is that=C2=A0 the reque=
st->mq_hctx was used after free.=20
>
>
> CPU1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0CPU2
>
> nvme_tcp_poll=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_=
tcp_try_send=C2=A0 --failed to send reqrest 13

This simply looks like a race condition between nvme_tcp_poll() and nvme_tc=
p_try_send()
Personally, I would try to fix it inside the nvme-tcp driver without
touching the core functions.

Maybe nvme_tcp_poll should just ensure that io_work completes before
calling nvme_tcp_try_recv(), the POLLING flag should then prevent io_work
from getting rescheduled by the nvme_tcp_data_ready() callback.


Maurizio

