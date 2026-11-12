Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481902;
	b=3xy8IDsLhGedM8QgyGPUM1uj57fhF59S65/IsxeMrZlQTDiAC+PqC/SbK2VuJ5vCAdCY
	 1LEpJUsESXYZ6juvDTzzM25UtygJcRb+vqWB/f0WpLjGRVT5IquWL1yzZDaj8ReKrUpMi
	 C1aipV9yD94nkJR5WI3MAqzEiWVpZsb9Nty4DYjDkAO3te1hc2ihFhoHTOF7nnbolh2uw
	 brF3yLDRBfjqsrLu2+CxWLrdNhxKOGdg6xyDSQwUBACAwYu4X7wTnMObwiuVdTOqC48Ri
	 sJC8TPjy6BLriKYVCnDECjEg4JbABzaDDSl8mw5pEyvr+I50BJeo6YKUdnT/lPh2xvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f+jGuGb1qkK7jSM3drmVQfuryQok7tFfCPkS9qY3leo=;
	b=yvR1rNrPFNlqgmGaPQP2vjg3W88VYdOnSeDdu2Z+/lC0tHbXFSDLlBE/yVCWCvCVX1LM
	 qDhjc7G5XsfZWHZNiSAqgA+hh0keByQkNYy/HnnE9eXNFrtOai6e/Fky8CFXnckov8/FK
	 SWsc7Ze6VrW/MkaQn5+2u1aG7IggyungZHtgwN/YLWrEUcwadjUGa7/bnr2HL5s0dONVx
	 n0r+aJQlhNUk+IZsYl5ibeqj7zkbPhy93+Y/VI9SWXVRGImvglQFRT0ZBVumVCmcBf51A
	 cz1VYvQpp4tF2asmgjH+fbym8Ikt1QNvqsgYcCtP/wuLPQ+q1LJjiRO81uz9E7gyeaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XO8Zx/M9";
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D2606A31C
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 11:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 506D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XO8Zx/M9
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b308fca7c3so41618207b3.2
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794481901; x=1795086701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+jGuGb1qkK7jSM3drmVQfuryQok7tFfCPkS9qY3leo=;
        b=XO8Zx/M9pgKkHWbWAsPy0iS5nA3/oaY/fdCIIx9lZQuF/3RsuRmqm6A+wxa6qZq1KQ
         OXvAnnjpRC6L3m41Mwn42Y2AuklJdosCTFt6pyvDFpLnx1fKvVo5odS/RT/5cu6PVV+y
         BfuqX07e5L87OH54/4nTytI7APytMn9CejB6Wh2LzvIH03q/fJbkHTCegepIC9wmQN3e
         kWFhSWDMnqicU0IEN2nCBOL46bMYRPRFqJIaInLX4qfOaiZm689RgMRTXyY1wInM6E9F
         rJgk4TqesyKIaBd8EAmaidEjaMce4dbffOAo0gyy6jV6II153N9bE2KsKILRzVDtuMgn
         dFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481901; x=1795086701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+jGuGb1qkK7jSM3drmVQfuryQok7tFfCPkS9qY3leo=;
        b=q7eJ30KHKiWKWn93kqvDxh+V8uTXFmqeNlm6idB91XqMI7+VqB51ZRERfRFFLgc8O3
         8nEIaUFHjPy75gZkHLi84f9u3XqFjPsMgbODGY2kDoYHz7iM/AjLRPgm/I2hMFVisOBm
         iG++R1dFfq/ho0xweOAxC5+xIsiDOoWMPdsGw2jk1k4z8SjYaK2Ebr4woFgfUXGKD5tg
         LKzQa5T6sBXVwkYWA9v4QL9PVYkPHhaf3f5yI/ZiOm2K94BLcF1Qaa3qx+0Rnx62ZmBY
         iMw7OcEOxayYxFV2bHRwZYmewjGcWlH1OdngZllnDaPe7ryx460n7gU0gDG67ojAXaqb
         2ieg==
X-Forwarded-Encrypted: i=1; AL+hErGsqUv4s5ScEN90sFtinr6uXgQAbsIKpi4z1/iOprEsAQv9dHbXI7kG26LJKD8H8aav/Nd7aZ9GR2JTQA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+pxYKXdWe5s1lzzqbncTi0sqWzvWcQ8gSE6qt3JryIlmxeYHe4
	I3yFJOLInPZ/HmzY8lK+9+I+OjNgGkVbTW8mDEER3ocLcpgqvEjGdPF7
X-Gm-Gg: AYBFou34jzw0y53wQrn8qxXO7vBiCPI7+42GuzO35ovmIIgkmEvHOpXQ2epLUz8+c9X
	XxUUsoSXV2s/y1TUmvJWETeOwy/nGvxswtwMniS4KojMkiktLaDuYXKv+G/1a3r0N5agh8Pp/wI
	FZxeZwa/NAzK2j+huCShEH/oTsuUMaEImtE6fKzQvanf0GOW7nzldkHku8/sToHnFEBA1XRhmgb
	UfeTDhqUgrzrA/H3mjXBXzV/tYvJTOAxlREntmlrKy5gdY0Dri9apEt100JdVMMtxsd4bi71v4M
	pj3H5eoqA4+RoCdV4yTwJ6dZ7AeSTyEbkDQ3ySiuop5PqERJYReg4RFGjoGeRpLRuP2YLwSKvz1
	9s4m1qdc0dFkzNmIrUBP2D6giGH1rCm77VbV1cnkODXsl9RAb8O0scmM0S297qf/fqduDJkBXUi
	PkkWrF2t42Tc+qQF1kDGfWd9UGknhLfA14dl7e5gbucGJo75XDILFnKgawEt7XJ71mF8qXSWywZ
	9Iqs/wrvSlc4kReGRWY9s1+FehuUkYfOBOvKzDAxdHXnChFtdjaAXJUksxezGYyZrWQAc54fygy
	niKFCRj6e3LBkDGJGoLEELNIZ9CtG5wRTvkhHkhDDysyhPBuI/+wEsmTeIo15VeWGCZezDYZokx
	0q1aM4wxXNVUZ7eJzjGpz33N6LoWVv+E=
X-Received: by 2002:a05:690c:c10d:b0:8b3:4022:d81b with SMTP id 00721157ae682-8b3a7d8e436mr35968017b3.4.1794481901382;
        Thu, 12 Nov 2026 03:11:41 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933d1047sm66813717b3.19.2026.11.12.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:11:41 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: hdanton@sina.com
Cc: bvanassche@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com,
	trintaeoitogc@gmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Thu, 12 Nov 2026 08:11:28 -0300
Message-ID: <20261112111128.261395-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261112001319.463-1-hdanton@sina.com>
References: <20261112001319.463-1-hdanton@sina.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hillf Danton <hdanton@sina.com> wrote:
> FYI reclassifying sockets is also corrupting memory [11], so can you fix
> the corrupter before reclassifying again?
> 
> [11] Subject: [syzbot] BUG: spinlock already unlocked in corrupted
> https://lore.kernel.org/lkml/6aec63fd.5f5735a5.290c1c.0003.GAE@google.com/
Important thing to do.

I'm not a nbd/net specialist, I only get the "fix possible circular dependency"
bug to resolve because this appears in mm subsystem syzbot.
But, I read this bug and see that is a race condition between inet_shutdown()
and sock_allow_reclassification().

How IA analysis say:
"""
- Thread 1 (runner/shutdown) calls inet_shutdown() -> release_sock(sk). Inside
 release_sock(), Thread 1 acquires spin_lock_bh(&sk->sk_lock.slock).

- Thread 2 (reclassifier) enters nbd_add_socket() ->
 nbd_reclassify_socket(sock). Right before Thread 1 acquired the lock,
 sock_allow_reclassification(sk) returned true. Thread 2 calls
 sock_lock_init_class_and_name(), which invokes
 spin_lock_init(&sk->sk_lock.slock) while Thread 1 is holding slock.

- spin_lock_init() zeroes the spinlock and marks it unlocked
 (SPINLOCK_OWNER_INIT).

- Thread 1 finishes processing in release_sock() and calls
 spin_unlock_bh(&sk->sk_lock.slock).
 ... 
"""

What lead me think that when Thread 1 try acquire lock this would must be
blocked to acquire this lock, so a spin_lock(&sk->sk_lock.slock) inside
nbd_reclassify_socker right bellow sock_allow_reclassification(sk) fix this
bug?

```
static void nbd_reclassify_socket(struct socket *sock)
{
	struct sock *sk = sock->sk;

	if (!sock_allow_reclassification(sk))
		return;

	spin_lock(&sk->sk_lock.slock);

    ...
```

thanks,
guilherme
