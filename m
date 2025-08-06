Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966581DAC95
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461368; cv=none; b=l2j2X2lYesnmbAHY1WVzl+YtZ0m1exnSMExKmLiOfxh5lE7pxCLluy0tA9m4tU/hgBs/njhl+SFMtWoy6j/s6O5qC2rgu3BqOQNMlxnBzKONid1E/blJb4PWe1enV2SkmUvSli9UUKJs6MoTSsbvRBj9+ui5WMJDk6P58xN8GK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461368; c=relaxed/simple;
	bh=dJhCdKHnurkzRS0AMGKfS7ybvZNz0tTnvAE+vUuyMYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LmF5k7+5WPNZ+qVhILDrpUzTorS0i+1oEQxzmpA7uUOszgq1tz8dDrv9HbulLuc5O9CYicWa4ZOKqlAyWthJZtgtuldjf4LYJmAk0M97iYPC4Vq6uN3SCSo9rHjBxs9Sg6UChuDkFe9u5tkfI3Yv0ti2yOdPY+xuHWKaU2TYTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 2eb86fed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Aug 2025 08:22:43 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 08:22:41 +0200
Message-Id: <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Yi Zhang"
 <yi.zhang@redhat.com>, "linux-block" <linux-block@vger.kernel.org>, "open
 list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com> <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu>
In-Reply-To: <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu>

On Wed Aug 6, 2025 at 8:16 AM CEST, Maurizio Lombardi wrote:
> On Wed Aug 6, 2025 at 3:57 AM CEST, Yi Zhang wrote:
>> Hello
>> I hit this issue when I was running blktests nvme/tcp nvme/060 on the
>> latest linux-block/for-next with rt enabled, please help check it and
>> let me know if you need any info/testing for it, thanks.
>>
>> [  390.474378] Call trace:
>> [  390.476813]  __switch_to+0x1d8/0x330 (T)
>> [  390.480731]  __schedule+0x860/0x1c30
>> [  390.484297]  schedule_rtlock+0x30/0x70
>> [  390.488037]  rtlock_slowlock_locked+0x464/0xf60
>> [  390.492559]  rt_read_lock+0x2bc/0x3e0
>> [  390.496211]  nvmet_tcp_listen_data_ready+0x3c/0x118 [nvmet_tcp]
>> [  390.502125]  nvmet_tcp_data_ready+0x88/0x198 [nvmet_tcp]
>
> I think that the problem is due to the fact that nvmet_tcp_data_ready()
> calls the queue->data_ready() callback with the sk_callback_lock
> locked.
> The data_ready callback points to nvmet_tcp_listen_data_ready()
> which tries to lock the same sk_callback_lock, hence the deadlock.
>
> Maybe it can be fixed by deferring the call to queue->data_ready() by
> using a workqueue.
>

Ops sorry they are two read locks, the real problem then is that
something is holding the write lock.

Maurizio
