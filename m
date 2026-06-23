Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8E1D5146
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175528; cv=none; b=r0GuXYN5DE5XYmSIra8jGpdraF+D7E5w4vatAHGEivh0BiJ/aAUzCe3aE5zqtU9Gdh0Ne6YkOhZ6BIIurjRXUS+GRpFTqWjHC4XZPKRydb9jQ3bM/ptvH7OSn6W2UVWCDp5Zh26Ai0r2T9dhCxOoH3SUCVJnoTraoyl7oW3eVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175528; c=relaxed/simple;
	bh=TBlMC/6ipN0ztiR+wR5M0zG63VDi28vd+iXPGuLt8YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo4Ucjq46oGEQfW2z9TgBsarxxhQ7O08PdMQdbTEqBAYG7doWEj7ZmPzusXVgZuVNzA2+MdyFjjIt757sbz2FClqYvzuwGqqIFhXgdRHLaAxH+YjX5vsT5hP14Hy5cmuiEoCTB5zJJes6eDoIk68nITAhpPoWZR8obNxLBpkHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=f6XXzGT/; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="f6XXzGT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782175522;
	bh=TBlMC/6ipN0ztiR+wR5M0zG63VDi28vd+iXPGuLt8YM=;
	h=From:Subject:Date:Message-ID;
	b=f6XXzGT/g1b/ZYrYqpb963mg6Pph9O7K8EdV8USsAtcXcwqtctFmL/LMCHD63Hmvt
	 Ci32wQX9jkojovg8MUaIpGtgxc/zPAT/cO8mDAehUIQWqOhdosQexF3gY9HOr+OIlQ
	 ECVoMx0tGjPEzYEKLPLiECWyDnfaqzAzAocZpWfA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 6A39D715000061BB; Tue, 23 Jun 2026 08:45:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4748724456880
X-SMAIL-UIID: B58136ECF32A43DBA052AC41868A9B6E-20260623-084512-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Tue, 23 Jun 2026 08:44:58 +0800
Message-ID: <20260623004500.151-1-hdanton@sina.com>
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
In addition to 50 syzbot reports, your fix has a Fixes tag, no?

>I suggest you send a patch so we can discuss it.

The deadlock existed before ffa1e7ada456, why is a chance left for your fix?
