Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FE42A94;
	Tue,  1 Apr 2025 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509926; cv=none; b=YKIlu0VxZOdoxhj51Qs80O6FyF3BZOZ94d349bpCf6kCP9BqTzQYk56lR/uNCCmH1tv6lCQuGz8mBitAvitzdsRcULGuegS6mUPiGW9y76QcGIHYulnZ07GUraarv5f4jEoM/N0U8GiAAWwJVt+y1nPPlDpjZGuRCfQvTMmwOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509926; c=relaxed/simple;
	bh=gkAaGi/6KaXfz/ElIKiar3CIw41j0EtK1W6A5DY6Gw4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WeoJcXkkeYKhpTQHdrglRiIv8ZQPQ9n1B9N4luUts4BO3kyeZN+Pen7VHJjrnLtufg/DOWny+QeHuV0LR43v60qTopw8dqmMjIQnX4kFmP4hZ7gDGvgycCqMV9YeCgX23ZYPMoWd5NKUnScNzA2mnYFfRW1PkGwiREWPsWeoM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (<unknown> [193.207.112.45])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id c7aa2f3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 14:12:01 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 14:11:59 +0200
Message-Id: <D8VAJJYPMVA3.284EXKCVRJVPU@bsdbackstore.eu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc 0.20.1
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn>
 <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
 <2025032817241899538928@cestc.cn>
In-Reply-To: <2025032817241899538928@cestc.cn>

On Fri Mar 28, 2025 at 10:24 AM CET, zhang.guanghui@cestc.cn wrote:
> Hi,=20
>
>       So far,  the UAF issue have not been occcurred during testing this =
patch in the same situation.=20
> Additionally, the patch triggers a compilation warning,  nvme_tcp_fail_re=
quest is declared but not defined, please also review. =20
>

Ok, I am going to submit a formal patch.

Thanks for testing it,
Maurizio
