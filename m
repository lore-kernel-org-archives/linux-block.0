Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06002C181
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092772; cv=none; b=n3pi2geecr9ugwEXXdHrAEsr5avh2wiqb192sNQRQrb5qzKN/efMARplb0KI/xL/doJVLdeGiwJ3EDpl2MsbGem7KZ8xuBzb2Z34WvlPD5pCLKmVxKmULfWBx5lX5zfd3tvQ9CLY+Xwk03oZ/bRhxmLmyqYDllXkJEGPsg1Er8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092772; c=relaxed/simple;
	bh=Jz7yQGu/R1sslHSYnWigGeAaUrqXaUiXdzOCi9hGpuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOYhIvLu8eXSrUiYrg8Wsr+qZpTpYBVrWbqE9u/N2e43S+Rb/fxjGcxnFGX6X7o8MZsLGvaSOwFEhuvR+qRCV0CXUvps0R/5iX2wTWicmvwA/0aTlLi+pC3rqzNw6Ppgng9ifnHtQlZzthinTFF2L0VcVSit1cgVlKbvvV7XWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=sQI/i3Nm; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="sQI/i3Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782092766;
	bh=GTi82fa48ZAdHtNIVE+MeEaCXBGvzEeerzWekigHzoE=;
	h=From:Subject:Date:Message-ID;
	b=sQI/i3NmCidxPtX1P3iMz5Mqv+hWDFTYbhG0D+VTCGcvVTOqOB+KtTvW56x1S4OJo
	 sge3cQs5kIww2ghBXBDJYU60u6coMTyER+ymx8131faTNceTyre6SqJ174cfSDUos5
	 Gv/+yqFAgGechhQ7WYV3pxaiNrykEOMmf2h/tdBc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A3893490000179A; Mon, 22 Jun 2026 09:43:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5437756816665
X-SMAIL-UIID: B2E31ED7DF9D4DB2B4EE62DA31D18A37-20260622-094339-1
From: Hillf Danton <hdanton@sina.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: edumazet@google.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Mon, 22 Jun 2026 09:43:26 +0800
Message-ID: <20260622014328.115-1-hdanton@sina.com>
In-Reply-To: <20260621235255.66015-1-kartikey406@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 05:22:55 +0530 Deepanshu Kartikey wrote:
> nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock is
> held at the point of reclassification. That assertion was copied from
> nvme-tcp, where the socket is created internally by the kernel
> (sock_create_kern()) and is never visible to user space, so the lock
> is guaranteed to be free.
> 
> NBD is different: the socket is looked up from a user-supplied fd in
> nbd_get_socket(), and user space retains that fd. A concurrent syscall
> on the same socket (or softirq processing taking bh_lock_sock() on a
> connected TCP socket) can legitimately hold the lock at the instant
> NBD reclassifies it. sock_allow_reclassification() then returns false
> and the WARN_ON_ONCE() fires, which turns into a crash under
> panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
> against socket activity on the same fd, as reported by syzbot.
> 
Given the syzbot report, if you are right (I suspect) then Eric delivered
another half-baked croissant, and feel free to cut it off instead to make
room for correct fix.

> Hitting a held lock here is expected for an externally owned socket and
> is not a kernel bug, so skip reclassification silently instead of
> warning. Reclassification is a lockdep-only annotation, so skipping it
> in the rare racing case is harmless.
> 
> Reported-by: syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6b85d1e39a5b8ed9a954
> Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 3a585a0c882a..8f10762e90ef 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1246,7 +1246,7 @@ static void nbd_reclassify_socket(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;
>  
> -	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
> +	if (!sock_allow_reclassification(sk))
>  		return;
>  
>  	switch (sk->sk_family) {
> -- 
> 2.43.0
