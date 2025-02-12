Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE320551A;
	Wed, 12 Feb 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348612; cv=none; b=Jc8tMbHHcJ7BY0xluQf5igxMWnRW/gE66Y5Kq6VFz9Wr5hO4g3fPCu8K4TZjE7mLswA7azWmFCo0+zbQ0+90IRZo91m4nM3dSwxxB9xcRS8tyrlRTD7A9CN84G71jfcPzDTS1P2v7bo+Bj2Wrsh1Tsew/Ks0qxno2/qHKi8dqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348612; c=relaxed/simple;
	bh=U7FibLmnbo459XjlNA7JSk7O9RTrKMRxetmxEmNH7I0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MheOPbvVwevFsWL4RI8wyQHAvuoQaal95ay7Blh80ignaptHbUs+vHj7reVTOPgewhhAQs7Prz9S+qgklfouHY8LRv471qa2NRCKSWgirAc3hEIr/g4XWMrIue1UbH8tb+cwjVuuJWMHAxrNC4wfJFTZYEaogNd7qB90SIYjYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 7d8026c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:23:28 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 09:23:26 +0100
Message-Id: <D7QBMEU5WL4L.2FI34UVHXCDC5@bsdbackstore.eu>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
 <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
In-Reply-To: <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>

On Wed Feb 12, 2025 at 9:11 AM CET, Maurizio Lombardi wrote:
> Hello, could you try this patch?
>
> Concurrent calls to try_recv() should already be protected by
> sock_lock.
>
> +	mutex_lock(&queue->send_mutex);
>  	nvme_tcp_try_recv(queue);
> +	r =3D queue->nr_cqe;
> +	mutex_unlock(&queue->send_mutex);

Well, reading nr_cqe like this is still racy, but should be a minor
issue and not hard to fix.

Maurizio

