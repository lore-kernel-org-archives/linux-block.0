Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B368262D1C;
	Thu, 13 Mar 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856482; cv=none; b=RPS6yGGEO/7CeT8MRdHUE1nJyAdTgHAG1jtdD/lLQWG3bmZ+whhzRssqtVfAUoCzw1ot5v2GBjh8TWGIJLMR4tQ9LHPAUR91aoPz84TEepDlAW8rS4JomzaVaj+tnXkSMditlvQldiJt6k2EVOBrE0bk1B1xx+sUIl7o/YgznPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856482; c=relaxed/simple;
	bh=6dKxJ9dsiOX0QPDvCIPj7hxyJrK+VLs58cYZ78OfvA0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qNiJ+qVnQ67cfAGk558pe3ki6do5MiOye9rdvIo+M3rsHwqsEMO5J0cfGc7Rweu76k/BYmOkrhs1076T7hgqicakNh8jB9cl+YcB74QCrWxG9EQVcFLxKGkrejyatjnEJZU6w6+j8UUDBD28jNh1k4+mC8c+7/P75RE8gSGflUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id fd0d5281 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 10:01:09 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 10:01:07 +0100
Message-Id: <D8F0L25A8NP6.MR1S5ORJC9XE@bsdbackstore.eu>
Subject: =?utf-8?q?Re:_nvme-tcp:_fix_a_possible_UAF_when_failing_to_send_request?= =?utf-8?q?=E3=80=90=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E9=82=AE=E4=BB=B6?= =?utf-8?q?=E7=94=B1sagigrim@gmail.com=E4=BB=A3=E5=8F=91=E3=80=91?=
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "Hannes Reinecke"
 <hare@suse.de>, "sagi" <sagi@grimberg.me>, "mgurtovoy"
 <mgurtovoy@nvidia.com>, "kbusch" <kbusch@kernel.org>, "sashal"
 <sashal@kernel.org>, "chunguang.xu" <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn>
 <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
 <2025031309485746586710@cestc.cn>
 <deb1584c-67b8-4543-9017-9ca18a9ee7d8@suse.de>
 <2025031316185747646815@cestc.cn> <2025031316313196627826@cestc.cn>
In-Reply-To: <2025031316313196627826@cestc.cn>

On Thu Mar 13, 2025 at 9:31 AM CET, zhang.guanghui@cestc.cn wrote:
> Hi,
>   in fact, the nvme_tcp_try_send() failure, the target may send C2HTermRe=
q immediately. while the host receives the C2HTermReq and still starting er=
ror recovery. =20
>  so when queue->rd_enabled is false,  can avoid starting error recovery a=
gagin.


Not all targets send C2HTermReq (for example, the Linux target doesn't
at the moment) so you can't rely on that.
In any case, calling nvme_tcp_error_recovery() twice is harmless;
the first call moves the controller to the resetting state, the second
call is ignored.

Maurizio
