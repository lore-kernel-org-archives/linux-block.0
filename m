Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E105DDA9
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173295; cv=none; b=JhuhW/pfGTQUS15xbCF8eDBJSoO+UnTMTLNNrM59djfOi7fJJz/UdY5WBAjub9TH0O2qdUTHMChUA3uOeDnIYIRh9nyW5lrEg6vgFkB3LzUawUgdPaNPO8Ug9JggEUAtuOZ1UjfjSEcKSh0MhPGEpglOXbQH/TiUFM+9pGocj2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173295; c=relaxed/simple;
	bh=PqTjO2ASxjZaeen2RgZHa5sQ4D8/Uz+DBAq66qrmc7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZHVYSs/NAGfcD1nM8v6LWfXgeoPsFFIDxfFM/3kru3vcPx4Ktp04/DfLpZe8NwBSDrSw66+VDUDrOFfqKaj8N2fxrf7uI+gI1eX6BY9nXANNCTZbzZtjgUjIiP8zCRirvu9Z5tW3yf0uQ2smo2AvJAEAvXGydt6F63iHthp2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=RQPWPzoc; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="RQPWPzoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782173293;
	bh=TGbKe0rLiVFtfF8x61Slen8x7rOyc4kXlQ0/hTsWQGU=;
	h=From:Subject:Date:Message-ID;
	b=RQPWPzoc8Ve58fV8yhkicman8FuP75m8qRSBu/r/SKPrHh+gVSODZqELVHeNnOCIc
	 HrowR31putc1JSKXYDyyTTbk8VJETIKKGHJamDYWOpIot8El0CPNHHnWW6W4T8YUKn
	 Tmnk3d40rw2HxM00J8rMC/huUgYQ/dn7sOdFxrZM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A39CE43000021F7; Tue, 23 Jun 2026 08:07:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3099096816379
X-SMAIL-UIID: 7D25E323B6B64CEC92756238E0BB1098-20260623-080733-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Tue, 23 Jun 2026 08:07:10 +0800
Message-ID: <20260623000723.135-1-hdanton@sina.com>
In-Reply-To: <CANn89iJBomCNpwzOiYHmmPf0i3KQGaqoiKh6VFeM6NHOQaCn3Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 01:18:10 -0700 Eric Dumazet wrote:
>On Sun, Jun 21, 2026 at 6:43 PM Hillf Danton <hdanton@sina.com> wrote:
>> On Mon, 22 Jun 2026 05:22:55 +0530 Deepanshu Kartikey wrote:
>> > nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock is
>> > held at the point of reclassification. That assertion was copied from
>> > nvme-tcp, where the socket is created internally by the kernel
>> > (sock_create_kern()) and is never visible to user space, so the lock
>> > is guaranteed to be free.
>> >
>> > NBD is different: the socket is looked up from a user-supplied fd in
>> > nbd_get_socket(), and user space retains that fd. A concurrent syscall
>> > on the same socket (or softirq processing taking bh_lock_sock() on a
>> > connected TCP socket) can legitimately hold the lock at the instant
>> > NBD reclassifies it. sock_allow_reclassification() then returns false
>> > and the WARN_ON_ONCE() fires, which turns into a crash under
>> > panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
>> > against socket activity on the same fd, as reported by syzbot.
>> >
>> Given the syzbot report, if you are right (I suspect) then Eric delivered
>> another half-baked croissant, and feel free to cut it off instead to make
>> room for correct fix.
>
> Nobody (including you) caught this.difference between nbd and other
> sock_allow_reclassification() callers.
> 
Nope, actually it raises the question -- does the deadlock still remain
after your fix without the lock key you added applied?

> What was the "correct fix" you envisioned exactly?
>
Frankly I had no evidence against your fix a couple days back, but now I
see your lock key approach fails to take off. And the correct fix is to
erase the incorrect locking order ffa1e7ada456 tries to catch, more
difficult than you thought so far.
