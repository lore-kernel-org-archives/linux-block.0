Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EF20010C
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472634; cv=none; b=BWYwK0+fxV7/+klIV1PEnvrxSBKo/lksc0LV5iI4QCYuKDmJULq/IMIUrkOeDe0VYbj1hNiBGMR1XSuuKj0QAxEcRkW4Ey+0EUeV9sWSRqYWHstmIXir3hS1PCH+HVpAoxHp8L2LVwX56661iASp/c1abe2lkuoKgsMG5uALDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472634; c=relaxed/simple;
	bh=8S4xk3UNc30oO/ZC+rmu2KXHHe6BdyCG9OqISMyVig0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nMEJXMZ/sRnCRN6YudY4gFcIyEojgNY5pe1AwCcEkuna97oVrIajiz4BevAEtz9YX+Q+q0BJCxnavNRz1mECSHpu8KUrX7//2yga2MMYi6JIxt3NJh69kvw6Do8UhXF9O5NySNv64mKiDDF+jEjJbeMWiYA9gaiRQN+H7AcX7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 7ac53805 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Aug 2025 11:30:29 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 11:30:27 +0200
Message-Id: <DBV8N24PJJZG.1Z9C2I6RSKFIK@bsdbackstore.eu>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Yi Zhang"
 <yi.zhang@redhat.com>, "linux-block" <linux-block@vger.kernel.org>, "open
 list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com> <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu> <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu> <DBV53ULYUBX6.1ZBU5KFWA2SHH@bsdbackstore.eu>
In-Reply-To: <DBV53ULYUBX6.1ZBU5KFWA2SHH@bsdbackstore.eu>

On Wed Aug 6, 2025 at 8:44 AM CEST, Maurizio Lombardi wrote:
> On Wed Aug 6, 2025 at 8:22 AM CEST, Maurizio Lombardi wrote:
>>
>> Ops sorry they are two read locks, the real problem then is that
>> something is holding the write lock.
>
> Ok, I think I get what happens now.
>
> The threads that call nvmet_tcp_data_ready() (takes the read lock 2
> times) and
> nvmet_tcp_release_queue_work() (tries to take the write lock)
> are blocking each other.
> So I still think that deferring the call to queue->data_ready() by
> using a workqueue should fix it.
>

I reproduced the issue by creating a reader thread that tries to take
the lock twice and a writer thread that takes the write lock
between the two calls to read_lock()

[   33.398311] [Reader] Thread started.
[   33.398410] [Writer] Thread started, waiting for reader to get lock...
[   33.398577] [Reader] Acquired read_lock successfully.
[   33.399391] [Reader] Sleeping for a while to allow writer to block...
[   33.418697] [Writer] Reader has the lock. Attempting to acquire write_lo=
ck... THIS SHOULD BLOCK.
[   41.288105] [Reader] Attempting to acquire a second read_lock... THIS SH=
OULD BLOCK.
[   93.388349] rcu: INFO: rcu_preempt self-detected stall on CPU
[   93.388758] rcu:     7-....: (5999 ticks this GP) idle=3D9db4/1/0x400000=
0000000000 softirq=3D1846/1846 fqs=3D2444
[   93.389390] rcu:     (t=3D6001 jiffies g=3D1917 q=3D4319 ncpus=3D8)
[   93.389745] CPU: 7 UID: 0 PID: 1784 Comm: reader_thread Kdump: loaded Ta=
inted: G           OEL    -------  ---  6.12.0-116.el10.aarch64 #1 PREEMPT(=
voluntary)
[   93.389749] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFT=
LOCKUP
[   93.389749] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/20=
15
[   93.389750] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   93.389752] pc : queued_spin_lock_slowpath+0x78/0x460
[   93.389757] lr : queued_read_lock_slowpath+0x21c/0x228
[   93.389759] sp : ffff80008bd6bdd0
[   93.389760] x29: ffff80008bd6bdd0 x28: 0000000000000000 x27: 00000000000=
00000
[   93.389762] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000=
00000
[   93.389764] x23: ffffb1c374605008 x22: ffff0000ca9342c0 x21: ffff80008ba=
fb960
[   93.389766] x20: ffff0000c4735e40 x19: ffffb1c37460701c x18: 00000000000=
00006
[   93.389767] x17: 444c554f48532053 x16: ffffb1c3ee73ab48 x15: 636f6c5f646=
16572
[   93.389769] x14: 20646e6f63657320 x13: 2e4b434f4c422044 x12: ffffb1c3eff=
5ec10
[   93.389771] x11: ffffb1c3efc9ec68 x10: ffffb1c3eff5ec68 x9 : ffffb1c3ee7=
3b4c4
[   93.389772] x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000fff=
f7fff
[   93.389774] x5 : ffff00112ebe05c8 x4 : 0000000000000000 x3 : 00000000000=
00000
[   93.389776] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000=
00001
[   93.389778] Call trace:
[   93.389779]  queued_spin_lock_slowpath+0x78/0x460 (P)
[   93.389782]  queued_read_lock_slowpath+0x21c/0x228
[   93.389785]  _raw_read_lock+0x60/0x80
[   93.389787]  reader_thread_fn+0x7c/0xc0 [dead]
[   93.389791]  kthread+0x110/0x130
[   93.389794]  ret_from_fork+0x10/0x20


So apparently in case of contention writers have the precedence.

Note that the same problem may also affect nvmet_tcp_write_space()

Maurizio
