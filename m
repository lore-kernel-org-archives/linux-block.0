Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4738C2D4
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711093; cv=none; b=MMFbIQ5XLajB3eSwjCNULL/9HYFr8lFC4DvlGv3HU/494SdPwz1mlfR1OTPb8ug6kHfDdXVoTzG05UAtbBneLRuMGyJMccvlT6TxRgk1MkPbR49LFN+vidP/PWNkh5LZvvi9+f9dd3SkOEaQD4D+42zSN40vNZlmIyTh/UdfusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711093; c=relaxed/simple;
	bh=pgz8ZN3f97QTNC7ptiwrRQ4sGhDnQquLa23d53znH0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeI/dm56ACdziF8dOLRVLypSYkAb+4+JSxxhY975VYnCLlDn8llgANrLb4dRewGXYHAFR6fZ6rZOkQksHElF9woTHmlFv67zIFZoyiRxQqJ5UGhi9l476yu3dUxVWJevF55hx/CTwxg/bYTsLTAtTUoD1NHwRC0NHde+PWnP0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=UMEeK0Is; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="UMEeK0Is"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782711088;
	bh=pgz8ZN3f97QTNC7ptiwrRQ4sGhDnQquLa23d53znH0Y=;
	h=From:Subject:Date:Message-ID;
	b=UMEeK0IsgXDnnZTr7QHysR1rspnWoT3JhIGPNiHDeA4N07q3R5ccsQgDKyz7OzO5o
	 uICWh4v980blbiN4BpdqCD0DROnd7L/Vj593lFMdBT7nTG/8zz0Q99ISg82wXx4pmC
	 ZgXwNh+BZHEj6nCPM7jh7fDcsBCaZcBxvbwasaY0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A42029A0000305B; Mon, 29 Jun 2026 13:29:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4781066685930
X-SMAIL-UIID: CE2F1112CFF44E3D87F9709C02B04F74-20260629-132900-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Mon, 29 Jun 2026 13:28:52 +0800
Message-ID: <20260629052854.252-1-hdanton@sina.com>
In-Reply-To: <CANn89iLPWCo_u-8jCsDM6jjZYfESvtUt9n3xD7yuAyNNntSw6w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 17:21:53 -0700 Eric Dumazet wrote:
>On Mon, Jun 22, 2026 at 5:07 PM Hillf Danton <hdanton@sina.com> wrote:
>> On Mon, 22 Jun 2026 01:18:10 -0700 Eric Dumazet wrote:
>> >On Sun, Jun 21, 2026 at 6:43 PM Hillf Danton <hdanton@sina.com> wrote:
>> >> On Mon, 22 Jun 2026 05:22:55 +0530 Deepanshu Kartikey wrote:
>> >> > nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock is
>> >> > held at the point of reclassification. That assertion was copied from
>> >> > nvme-tcp, where the socket is created internally by the kernel
>> >> > (sock_create_kern()) and is never visible to user space, so the lock
>> >> > is guaranteed to be free.
>> >> >
>> >> > NBD is different: the socket is looked up from a user-supplied fd in
>> >> > nbd_get_socket(), and user space retains that fd. A concurrent syscall
>> >> > on the same socket (or softirq processing taking bh_lock_sock() on a
>> >> > connected TCP socket) can legitimately hold the lock at the instant
>> >> > NBD reclassifies it. sock_allow_reclassification() then returns false
>> >> > and the WARN_ON_ONCE() fires, which turns into a crash under
>> >> > panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
>> >> > against socket activity on the same fd, as reported by syzbot.
>> >> >
>> >> Given the syzbot report, if you are right (I suspect) then Eric delivered
>> >> another half-baked croissant, and feel free to cut it off instead to make
>> >> room for correct fix.
>> >
>> > Nobody (including you) caught this.difference between nbd and other
>> > sock_allow_reclassification() callers.
>> >
>> Nope, actually it raises the question -- does the deadlock still remain
>> after your fix without the lock key you added applied?
>
>LOCKDEP might have a false positive, but it will be much much harder to trigger.
>
>I had about 50 syzbot duplicates (that I did not release) before d532cddb6c60
> ("nbd: Reclassify sockets to avoid lockdep circular dependency").
>
>>
>> > What was the "correct fix" you envisioned exactly?
>> >
>> Frankly I had no evidence against your fix a couple days back, but now I
>> see your lock key approach fails to take off. And the correct fix is to
>> erase the incorrect locking order ffa1e7ada456 tries to catch, more
>> difficult than you thought so far.
>
>Which incorrect locking order are you referring to? This is a LOCKDEP
>false positive.
>
For archive purpose, syzbot report [1] where udp was not invovled defies
what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
are different, this is a false positive."


[1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com/
