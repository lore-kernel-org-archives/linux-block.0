Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B82580EA;
	Mon, 10 Feb 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205621; cv=none; b=XMbLfJF8fXvYCAxGui2Dpp6yUwW+lV4A5FFSFQgBCV7oMZK86UFA5wgRCUjKqnd4MhkYO7quz9znPe4yRYj0z8cmYlCOBmF8teyz2vdPXox+kxV8WFUuk0dUO+CCS8uSmuzCTScxmgvTPpK1e1lpKUQujwhsEazYLAKL/McLKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205621; c=relaxed/simple;
	bh=pInBy8YX1VZfoKLrPNtGqsHJ8GKtyDoFXM54Z975PS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=PNhuki2V2t6PumqEwCEfQ8yCMxRTe4TUdbmi8cEjBV68c//71dMr6gKiVaslmSvgLWn0EYnVK69lxe6/7Pp0U4llKOxttXPAKmam/0BABy7jRjj8WgNM9izLNu0Vpn8N/oH3JNa11/VNtzpp61DTFtzJomNOaNaB4h4CzqJMaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id dc734ee4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Feb 2025 17:40:13 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 17:40:13 +0100
Message-Id: <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Max Gurtovoy" <mgurtovoy@nvidia.com>, "zhang.guanghui@cestc.cn"
 <zhang.guanghui@cestc.cn>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
In-Reply-To: <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>

On Mon Feb 10, 2025 at 11:24 AM CET, Max Gurtovoy wrote:
>
> It seems to me that the HOST_PATH_ERROR handling can be improved in=20
> nvme-tcp.
>
> In nvme-rdma we use nvme_host_path_error(rq) and nvme_cleanup_cmd(rq) in=
=20
> case we fail to submit a command..
>
> can you try to replacing nvme_tcp_end_request(blk_mq_rq_from_pdu(req),=20
> NVME_SC_HOST_PATH_ERROR); call with the similar logic we use in=20
> nvme-rdma for host path error handling ?

Yes, I could try to prepare a patch.

In any case, I think the main issue here is that nvme_tcp_poll()
should be prevented from racing against io_work... and I also think
there is a possible race condition if nvme_tcp_poll() races against
the controller resetting code.

Maurizio
