Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033540B383
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822315; cv=none; b=LoeWTiIP8BZESTfVrhcrV5cK+A3uoKU+e+xCg0vnbf2D9my+/fugOW0C8gGkjmuR+BoUc8Owba0i/SYlheKVvFfLdhA76RwG1ZIUV21J7JW9sZULgVZcYY6iEAA7Gif/4dU5q47MHLDidgMgOvI6T0ijHJCbvYsnFxTjMCIrdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822315; c=relaxed/simple;
	bh=YK0UnB2trBFGcSgg6qnnZ2rvLVSSHSSTN5BTBsmgcvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmypJeXDZud6YPNdRfZQ/Topyo1hdQSFh19oY8puGaHrEFMHkQ9jVG5flVOoR5wgUtXnKPJ1TlMlV9Uisz59Oh5EhMTp6HCr7Vix9s3Ix2bWgwsMiw5GgC3Md/8GOqCP6mHApPta3FUY9yliWTorh74vWEOgp1ca98WRMZLcg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LwRXZpJ+; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LwRXZpJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782822308;
	bh=QQyh2nC/4NGFvtsANqCnlaM6CSzqIRdJ8tB/XxgHJdE=;
	h=From:Subject:Date:Message-ID;
	b=LwRXZpJ+nKIibBaQ6hOmq3ZQTo+bKOuczXjgJolVzeK50ovdrPwvwvXpC/QGDWKLl
	 Kc1YI7Iy779TGXcJV3cvIv4GxxXfklJ1RWxTZ19ofuoKLG9EDDR98JzCw7bZDIdpUC
	 uRuQt5Xb8ikIohXpDoYfhsAWHPv97O6jyEqbjJgk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A43B5970000594B; Tue, 30 Jun 2026 20:24:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9825056685345
X-SMAIL-UIID: B3B0E47636B64BB6BC3652F5649B4CBE-20260630-202457-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Tue, 30 Jun 2026 20:24:43 +0800
Message-ID: <20260630122445.314-1-hdanton@sina.com>
In-Reply-To: <CANn89iL-RTVME9qcUSVZW6qBEkVh8suw2pcLMCh0WM1fTEz6Jw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 00:19:45 -0700 Eric Dumazet wrote:
> On Sun, Jun 28, 2026 at 10:29 PM Hillf Danton <hdanton@sina.com> wrote:
> > For archive purpose, syzbot report [1] where udp was not invovled defies
> > what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
> > circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
> > are different, this is a false positive."
> >
> >
> > [1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
> > https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com/
> 
> Why don't you send a patch if you think one is needed?
>
Good question. It is a long standing tough issue, frankly more difficult than
I could cure it in one shoot at the cost of a couple weeks, particularly given
the rule of thumb -- delivering half baked croissants, HBC, as few as possible.
