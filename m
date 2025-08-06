Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9931DAC95
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461390; cv=none; b=Ib74XvY+fQzuul0L4TWLcbzEuOUOg+bgwUcTyignd3Dv/rJQ8e+b9Roogu6ia/yRAFd+zcUsoHGpmP1GfxUVheJoK5LXYh4xD7HOh4Jg4jBKRUI/x5L1HkgBH3vkcwOAspEtDBkUODx8gMQh7H7S1jmbWYBsjVIwfsRA06842g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461390; c=relaxed/simple;
	bh=OyQvVwYQVFh6bXujaPjnXB43FIQZtx+UKk9GUHSiNwM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=A8J8h9ivS0ixYuc3UIBWd9RQQDkcZjH9frZ2I3fIvNTDY8tkHgGigBNHyBnOUEXP/zn8zO8ZtVVNARdKbYkbYsxTavPuhrjWKoaBO5vTljpwlgevzbcPzcdt0K7QWbegRw9y4nvDJ7osCADskQC+lTwjOPeXbv6uK8seMhGoEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 800faa01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Aug 2025 08:16:26 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 08:16:24 +0200
Message-Id: <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Yi Zhang" <yi.zhang@redhat.com>, "linux-block"
 <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com>
In-Reply-To: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com>

On Wed Aug 6, 2025 at 3:57 AM CEST, Yi Zhang wrote:
> Hello
> I hit this issue when I was running blktests nvme/tcp nvme/060 on the
> latest linux-block/for-next with rt enabled, please help check it and
> let me know if you need any info/testing for it, thanks.
>
> [  390.474378] Call trace:
> [  390.476813]  __switch_to+0x1d8/0x330 (T)
> [  390.480731]  __schedule+0x860/0x1c30
> [  390.484297]  schedule_rtlock+0x30/0x70
> [  390.488037]  rtlock_slowlock_locked+0x464/0xf60
> [  390.492559]  rt_read_lock+0x2bc/0x3e0
> [  390.496211]  nvmet_tcp_listen_data_ready+0x3c/0x118 [nvmet_tcp]
> [  390.502125]  nvmet_tcp_data_ready+0x88/0x198 [nvmet_tcp]

I think that the problem is due to the fact that nvmet_tcp_data_ready()
calls the queue->data_ready() callback with the sk_callback_lock
locked.
The data_ready callback points to nvmet_tcp_listen_data_ready()
which tries to lock the same sk_callback_lock, hence the deadlock.

Maybe it can be fixed by deferring the call to queue->data_ready() by
using a workqueue.

Maurizio

