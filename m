Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B041B21AD;
	Wed, 12 Feb 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376487; cv=none; b=KpKrnJpY9xfHJnz7zPg0aygjPYn66NoJF0CTXOEmEBtUtkztyrFzG0jaFN62cfZGUE4zgb4G19hwH7L1XvmGzXDxVRLbFVjHPH8iWbgN0f8MtKkL/PqWJVYx4LzEtWjzn7Y2hLLxbZtxNRbyCjDECHogALCgJ2BEteUZWHXvhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376487; c=relaxed/simple;
	bh=CGPA2diWDPRlo+xCIF3lvcfw8/qJFHHjnFL2shClYSg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=YC5fD8T2iDwhAeolr7Af0sW+Pbrvfd+qNAyX2mSPkEtZ5VxWBDjkKzryEhftLcHhnZBwH4qNQQ7+A1FVjNHtq5aCclzssjdSUnKPL+DanMQHCztoUfcX9WIXZxHoyQzAiOP/N2QuJThOr2mSnfPrAqiJ5jgZH+MxmlLlJNGU3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 2ef4fa32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 17:08:01 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 17:07:59 +0100
Message-Id: <D7QLI3PYQ877.1KH6K8K08P2IP@bsdbackstore.eu>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7QKRU1EXDXJ.K6ZXC4V4ZD68@bsdbackstore.eu>
In-Reply-To: <D7QKRU1EXDXJ.K6ZXC4V4ZD68@bsdbackstore.eu>

On Wed Feb 12, 2025 at 4:33 PM CET, Maurizio Lombardi wrote:
>
> Taking a step back. Let's take a different approach and try to avoid the
> double completion.
>
> The problem here is that apparently we received a nvme_tcp_rsp capsule
> from the target, meaning that the command has been processed (I guess
> the capsule has an error status?)
>
> So maybe only part of the command has been sent?
> Why we receive the rsp capsule at all? Shouldn't this be treated as a fat=
al
> error by the controller?


The NVMe/TCP specification says

******
When a controller detects a fatal error, that controller shall:
  1. stop processing any PDUs that arrive on the connection; and
  2. send a C2HTermReq PDU
******

And indeed I see in the dmesg this:

nvme nvme2: unsupported pdu type (3)

This means the controller detected the problem and sent to the host the
C2HTermReq command. Upon receiving this command, the host is supposed to
close the connection.

Now I get it.

Zhang, do you have commit aeacfcefa218f4ed11da478e9b7915a37d1afaff in
your kernel, I guess you are missing it. Check it please.

Maurizio

