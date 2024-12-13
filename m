Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA101DEFD2
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092356; cv=none; b=um/x3KQDiVtmeri8zZAhvI5FaCHxmoaIDA53pBB8GwzqRNz9TtRjpfjg4oRsNqgRluxizVqRB5XeGw8NQEWpW/mbBIndyHjkVjE9KhCz85/W/Y2xX+9OQz+SrOCGfQbo/1Xh/uF4jcyLaOcq3FjXsDxjP6zWqmfPHZ8fURuE6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092356; c=relaxed/simple;
	bh=+agX/hxnK7PsbXVWPwKhiB1V054xuEENK8nIoWK3fi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/mNVk2yJexUwx2ST3nPpbUXbcwqef8Q21Q43J1jygyOw4VKncJJXaEQ+CV6PcQGj7fL4juNMpGyy9rfhdqGBp9b+7Ksb4E9dCcg41t8lbiGjzvVuS6wpXnjPVBU9i3R4W3lUlm60j+E4nyg/dnWH3wsanIzLz3CFDDKyuDEaiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI/cWOQS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI/cWOQS"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so2925539a12.1
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734092353; x=1734697153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rswNLiWFuDKiW42rbnE3/FFvogIGFwro7QX3xwapVa8=;
        b=ZI/cWOQSTK7j4jTHtoeuwX9Lb+TTFgPctFxAljDqcqJJdejmoMXhJrrdZHRmEGK9x+
         F4dQZxd3p2sLGblz6ghca40YOLqTyK3h15sJaOQ6ii0zZMQm4c4ShqymyH6RH4ri6eKl
         kOZNPGAfnRFZEXJjuxUzKr1E90D9Ki0qaMTiDYN1nqfq9Fjjlxd2ddSaUbiyYsU0z10C
         Ij8a/AvyprryOGojNbPzulITQGxaUUOii5FEoUSsHoHFPsCvH8h6QVHj92tu+TZYS9Yw
         0epvuWXhOpJIpzQttx/C8mnurNpx2oGBUH2JrpIkYcBaAoHvu3aLbmbtRdL0Le4aQBBo
         lG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734092353; x=1734697153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rswNLiWFuDKiW42rbnE3/FFvogIGFwro7QX3xwapVa8=;
        b=F/B1Cd+3sqCUFE5xQX9BV52ZITCLMOlrGcKvBiWD9z91C/RHcX7tpTl9+iYTzwX1RC
         AO1sV0JLUdSs/vHF0OjjVNSYdCpVoPZgIl+aMHxkatyWz9WKLkwSsCNwzGCjleEKRgdO
         7RNHxHwQdJ5jUKocKWmsLbXE34Ke7qEf/cw41R/oGsVA8l4bPtMCwK2cT2gkvssacN/j
         Ix8cVMMjGgUJ/4XGOTXSlGfLMcQadzYmLKlYFRRop5I3agPOp5vi6t5std+iQa7VJU1u
         D+bvAm+YSKYVKNwtPmEmswlKAhMH8do6V1wGRAuoitdv/2+X2DtoxsQKayN5o/REFHcT
         E+5w==
X-Forwarded-Encrypted: i=1; AJvYcCXowCV+LY960tcKNfOGhVnepBdXWrjvzwXIfuNWGvOVcH86n2L/oG0bw+1Z8mMfXBcwR/l3w5hWkx4NKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxztkHQklrtxduR5exNd5poZN/L2NkdviBayUiVNUTRdE32YQ1s
	b3CjNCbGvRjVuUAJqOXKxKciMaZutcbPrEDRUCk4TrrHx2FkzvzybXQLItYIuUNXQR5TifbKEvh
	XFhA81UKI8Wfj8TgVXlLi50S65brHS/+0NN3c
X-Gm-Gg: ASbGncvnE9hho2XqKlw9SxWCy+M17wig+s2XAlbJ5Cc4X9WO6aiFg9K08FziSzU/yX5
	rAc8ssdGC2scV0i/yfK3ARS4fOV2TBKzYDas5MQ==
X-Google-Smtp-Source: AGHT+IGRpkdDBASQbA4W9W4t1BgK2dSzLTzvJG9Vc9UhANfCeYe2U4Z/qo2tMOoP0ps7OytKBednRAPV6i81BAZBwaE=
X-Received: by 2002:a05:6402:2790:b0:5d0:b51c:8478 with SMTP id
 4fb4d7f45d1cf-5d63c3158c3mr1721305a12.12.1734092352701; Fri, 13 Dec 2024
 04:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675b61aa.050a0220.599f4.00bb.GAE@google.com> <675c1dc6.050a0220.17d782.000c.GAE@google.com>
In-Reply-To: <675c1dc6.050a0220.17d782.000c.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Dec 2024 13:19:01 +0100
Message-ID: <CANn89i+Zm_0a5jqtsL5m-S4=E06mdQXA8RLaFEF75Y6umFWxpQ@mail.gmail.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
To: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
Cc: alsa-devel@alsa-project.org, asml.silence@gmail.com, axboe@kernel.dk, 
	clm@fb.com, davem@davemloft.net, dennis.dalessandro@cornelisnetworks.com, 
	dsterba@suse.com, eric.dumazet@gmail.com, horms@kernel.org, 
	io-uring@vger.kernel.org, jasowang@redhat.com, jdamato@fastly.com, 
	jgg@ziepe.ca, jmaloy@redhat.com, josef@toxicpanda.com, kuba@kernel.org, 
	kvm@vger.kernel.org, leon@kernel.org, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, miklos@szeredi.hu, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	pbonzini@redhat.com, perex@perex.cz, stable@vger.kernel.org, 
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, tiwai@suse.com, 
	viro@zeniv.linux.org.uk, virtualization@lists.linux-foundation.org, 
	ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:43=E2=80=AFPM syzbot
<syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit de4f5fed3f231a8ff4790bf52975f847b95b85ea
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Mar 29 14:52:15 2023 +0000
>
>     iov_iter: add iter_iovec() helper
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1742473058=
0000
> start commit:   96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
> git tree:       net-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14c2473058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c2473058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1362a5aee630f=
f34
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4f66250f6663c0c=
1d67e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D166944f8580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1287ecdf98000=
0
>
> Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
> Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Great, thanks syzbot.

Patch is under review :

https://patchwork.kernel.org/project/netdevbpf/patch/20241212222247.724674-=
1-edumazet@google.com/
