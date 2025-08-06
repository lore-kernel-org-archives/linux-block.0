Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0120297B
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754462664; cv=none; b=YnHq4mGA+G/onE5ONcqpu/k7eFU7OFQIaz7Xl8s2ItpbMkUV5K7zbwxCtawPrp59v8TkO244AOkLwYHd39iz7qM/BSTUqy4i1sz2gUSp6PM1F1gNfjO9vabJV7n/A7ee/XE6FfHc6KNkaEhUM/G00nhXLxQaFAG2cWzNZyL9N48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754462664; c=relaxed/simple;
	bh=TKVLeGga4ERqio0t8GPfT2uuX3qFqhHR2Y5CjNmVD+c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JUBKGYyNydaE0DD7BplRwNKxsZXIlT+JEKF3MHxLI5QojQbEmfT3LxPzwO755TM1roKv05wKrDaOWoKVqFqrkOmnKhcC97q4sleUeMg4Gyn9K1xWkQr5E/1xfZrdfJJ1eS76DxfydEpp/9xb0t5a2Zq/2sUTLAPujbROKxFUxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 27d2961c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Aug 2025 08:44:20 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 08:44:18 +0200
Message-Id: <DBV53ULYUBX6.1ZBU5KFWA2SHH@bsdbackstore.eu>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Yi Zhang"
 <yi.zhang@redhat.com>, "linux-block" <linux-block@vger.kernel.org>, "open
 list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com> <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu> <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu>
In-Reply-To: <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu>

On Wed Aug 6, 2025 at 8:22 AM CEST, Maurizio Lombardi wrote:
> On Wed Aug 6, 2025 at 8:16 AM CEST, Maurizio Lombardi wrote:
>>
>> I think that the problem is due to the fact that nvmet_tcp_data_ready()
>> calls the queue->data_ready() callback with the sk_callback_lock
>> locked.
>> The data_ready callback points to nvmet_tcp_listen_data_ready()
>> which tries to lock the same sk_callback_lock, hence the deadlock.
>>
>> Maybe it can be fixed by deferring the call to queue->data_ready() by
>> using a workqueue.
>>
>
> Ops sorry they are two read locks, the real problem then is that
> something is holding the write lock.

Ok, I think I get what happens now.

The threads that call nvmet_tcp_data_ready() (takes the read lock 2
times) and
nvmet_tcp_release_queue_work() (tries to take the write lock)
are blocking each other.
So I still think that deferring the call to queue->data_ready() by
using a workqueue should fix it.

Maurizio


