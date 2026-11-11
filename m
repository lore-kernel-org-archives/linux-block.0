Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392374;
	b=c8vZq8wmslPmRw1xA+3JFP2RB7Q+Xr2Boc3kg3hg0G/7ysClN4ulDW3Fejj0c1xEiRPr
	 RYRsi/+2Kq4ERSCyPvmi5IGqm4RjmKSqHWalfmjrzjTl1YthY/37JbHOnxDv+zYTceDIK
	 X+rX/fEo2XtlFgylaoD4nizKhxHXabw+2Oy9tAQYbOXua9nMIz0zX1ILj9HoFzTs3I3PM
	 n2kOZp1MiZlWUEdtY1PLJaJxLUHxffnYO+gicmsVO5W7wfnTDfFtiURRLsUciD+tB+Fhy
	 Dk+nbI89eJV3by04tZru/jL4qVMHg6Hd/0RvvR1ZrpWOdwDAea6hYjjHI0feqnY9AdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lE9jVEo5zSWyYf/prYRvcvqv6Dmp8UDlLUQhNVSI6yw=;
	b=SnwQ8WGIVpqP8PEpyX5De1Z4/anmnt7pPVlgIXVwiyjw5iEyEi6B/nCsKs0PcZ9De36K
	 gSIxdgKJtGQ5Q81cP1KABWi5lEzdaziRReYWx07DLtgezK2QqQkUj+JmBhAcG8AkeJ//z
	 mKReIMRFIFDoWzbLoWvaYbDeg+nP2l9tSCOeYcWNEBdEp4077alSpYXTR364aKkCUDbIo
	 U2ZTXQ8u01Xq8KO4EdWMUWIAZgs77FIyFMdj+bjE0wqk54mXIYr4JYcepeyUiYooWj7rS
	 0VTW/UuO09nlCf6OTmg48Yqg+S9A/tpyxiwj9n4ac8q/8qHb83zUq0lVsjatERG2lNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrqfefHa;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8759606A324
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 10:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8759606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrqfefHa
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67c6f1019a3so277109d50.0
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794392373; x=1794997173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lE9jVEo5zSWyYf/prYRvcvqv6Dmp8UDlLUQhNVSI6yw=;
        b=GrqfefHazSI+MYO+mhJa7awm3yyprx/VG7buEW6yB4pqzSQOe1nLs0eSINeEYSdgQB
         ttxUH20yGU1YbASrailabWHcZJr/NvtD4zURo2LCdZ5iTYlEPx1TShKXjrKBgKI72fta
         UEXoGqResXbt1SNBX9rSoHmgh/9+r3UHck35jJwU05/d87oOHTMGgGXxKtqncs2zCk6v
         0WMHxfNk5Uj3Zy01s0i+toBWsoqt402ZKy9al4ehcn+li+01xkPrkO6Zz6B+LJrMiX6B
         tu1zm1oaLXklUDLlCHydtwaxR1UTlokXxgTf/+Lmu/eKijWmbt97dbeuDuTtH09UfR7H
         s9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392373; x=1794997173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lE9jVEo5zSWyYf/prYRvcvqv6Dmp8UDlLUQhNVSI6yw=;
        b=aUWOfRxH3hVGzYSZAN0UayEmbTH1LwIJfdrVmbuD585V+2GpNrmNdB+hZzTlDpdumk
         jdg1rC3AzCTRpqgLbeSyZAUCEtooKyfsn6kjwgonSb0c6CR5nGLBERGbhSeEqm0dnPVJ
         TZG5P3LeBQJAVvHomii8BtmUtT9Ujqo0BYVL+Iz+7S522Tn5yT8bOxaJeMvO7DqWVbKh
         IIByhV4HN27umo4ixkQ/uwpqDPHIWGYNCd4NrxjOUzzbJeVcYWECmVTat8omGIuyHHTM
         nhBnTOkED5rcDhoWogMSMo7emtVlSdNDGXZTIbi8T92nelV2plMshqXdFY2XTww2gXkf
         i4Nw==
X-Forwarded-Encrypted: i=1; AL+hErEuxXHTbSseM1Y7Bhfb9VUIu2jCxiaDb/EIVbT7UhY8AYXUsiXhDlPLjRN8yda/38y7Y5o8OEPKZOjK+A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9x+isYmz7kj5j2fMvP1ePYqhnyG064d89b2jUsmUPkU7CimyWw
	CA2hQ1y+WXhy707IWH6FY1aUHQyekJhMVA6P+DCtYySUs+gOnmL9veDk
X-Gm-Gg: AYBFou3WNaKHXHRQsRQ9oRYQ1O4WYQOEgWkpFV0gJ3T1TexhZZvxcrgyc9TwFqRAr+H
	j7QTjwQTTPW4jH7OkDajJd7Zg3kPTbPapuf64qskdcb6Am5cPaP0/ir6Ea0Buce8kWgVgQWIb1O
	+1hw3b0TIdk3j+IeYEiEtF0fP4y5YRgIIMWmylS2BNd1l3SxJHEDPv4vcmHALSmnOmbqjOPzN0b
	x5yxmpWUHj/W3R5RrnDSJKZouGxSWcCADDcBCHlvDOV0BWYj4Tx64yyuCkQ3suAz/fbtQ6RoojN
	qMkZKSv3YO3Qu4jU6lKFQlSoJ4Nm6M2y6SEt3gcfYUZ0uDq0lmuFOfAu/ErOVuPaoaPkgjSKWI0
	bvEincUFkg1ca5UlCjKrOWeu4Lndw+lDpqS7Gc+9+6NbH4VHLt5adII+uP2EoMRlCXwzZTYsH6t
	hEj1c/rf2b0CUWW20sL5W00kVwcJEQqJ9bg4E7fi3bHKZbUV6DDz40yoFa1VvZ2J+lnSCzEGmV+
	KX948DcbhoH9112vg9bQy1si7G6hKaqxMorUVKyuz8A3za25kvB1D8Q1oAQk2GxLxuaD4GEIT0T
	ike73VjNpObAZl9I19LoWkXJ/sCYDFqOQg5Fs9gMFaKon7+FBInHRvQ/R3czvV7O1XbkEiQsnqw
	V375iKjja
X-Received: by 2002:a05:690e:b8b:b0:679:8f04:229f with SMTP id 956f58d0204a3-67c68051c41mr1267114d50.161.1794392372625;
        Wed, 11 Nov 2026 02:19:32 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c58811008sm4122666d50.3.2026.11.11.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:19:32 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com,
	trintaeoitogc@gmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Wed, 11 Nov 2026 07:19:19 -0300
Message-ID: <20261111101919.215767-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <99cd5aa0-4afe-4796-86c4-926273e72a6e@acm.org>
References: <99cd5aa0-4afe-4796-86c4-926273e72a6e@acm.org>
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

Bart Van Assche <bvanassche@acm.org> wrote:
> There is no real circular lock dependency here. This patch addresses a
> lockdep false positive caused by the missing socket reclassification in
> the reconnect path. Please change the subject into something like
> "nbd: Also reclassify sockets in the reconnect path".
> 
>  > instead of the NBD-specific class leading to a possible lock dependency.
> 
> Please change "possible lock dependency" into "lockdep false positive".
> 
>  > Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
>  > Link: https://syzkaller.appspot.com/bug?extid=d7d72f3d467710442af0
> 
> Please use Closes: instead of Link: for the syzbot report.
Ok, I will send a V2

> Has this patch been tested against the syzbot reproducer, e.g. with "#syz
> test"? If so, please mention this.
No, my bad. I send a email to syzbot now to test this patch.
After tested, how can I mention this in my patch?

> Moving nbd_get_socket() makes this patch much larger than necessary,
> which makes reviewing and backporting it harder. Adding a single
> nbd_reclassify_socket(sock) call in nbd_genl_reconnect_sock_cb() right
> after the nbd_get_socket() call is sufficient
Yes, is sufficient but the if we need reclassify socket all times when I call
nbd_get_socket(), looks like a uneccessary repetitive code.
Of course, I don't know if future situations where nbd_get_socket() is called
will need nbd_reclassify_socket() but *now* is just that happen.

> If the reclassification should happen in nbd_get_socket(), please move
> nbd_reclassify_socket() up instead of moving nbd_get_socket() down.
I was have moved nbd_reclassify_socket up, just like you suggested, but git
don't understanded this very well. But I will find way to get it

> Additionally, reclassifying the socket in nbd_get_socket() happens
> before it is known whether NBD will use the socket. If
> nbd_genl_reconnect_sock_cb() does not find a dead connection, or if
> nbd_add_socket() fails, the socket is returned to user space with the
> NBD lock class. While this only affects lockdep and while the
> nbd_add_socket() error paths already behave this way, it is another
> reason to only reclassify a socket once it is really being used.
current the nbd_reclassify_socket() is called just below nbd_get_socket() call
inside nbd_add_socket():
```
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
	nbd_reclassify_socket(sock);
```

what have exactly same effect that call at end of nbd_get_socket(). I guess
that "reclassify a socket once it is really being used" must be done putting
nbd_reclassify_socket at end of nbd_add_socket() (before put_socket tag).
Maybe something like:
```
static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
			  bool netlink)
{
	struct nbd_config *config = nbd->config;
	struct socket *sock;
	struct nbd_sock **socks;
	struct nbd_sock *nsock;
	int err;

	/* Arg will be cast to int, check it to avoid overflow */
	if (arg > INT_MAX)
		return -EINVAL;

	if (nbd->pid) {
		dev_err(disk_to_dev(nbd->disk),
			"Cannot add socket to a running device\n");
		return -EBUSY;
	}

	sock = nbd_get_socket(nbd, arg, &err);
	if (!sock)
		return err;

	if (!netlink && !nbd->task_setup &&
	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
		nbd->task_setup = current;

	if (!netlink &&
	    (nbd->task_setup != current ||
	     test_bit(NBD_RT_BOUND, &config->runtime_flags))) {
		dev_err(disk_to_dev(nbd->disk),
			"Device being setup by another task");
		err = -EBUSY;
		goto put_socket;
	}

	nsock = kzalloc_obj(*nsock);
	if (!nsock) {
		err = -ENOMEM;
		goto put_socket;
	}

	socks = krealloc(config->socks, (config->num_connections + 1) *
			 sizeof(struct nbd_sock *), GFP_KERNEL);
	if (!socks) {
		kfree(nsock);
		err = -ENOMEM;
		goto put_socket;
	}

+   nbd_reclassify_socket(sock);

	config->socks = socks;

	nsock->fallback_index = -1;
	nsock->dead = false;
	mutex_init(&nsock->tx_lock);
	nsock->sock = sock;
	nsock->pending = NULL;
	nsock->sent = 0;
	nsock->cookie = 0;
	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
	socks[config->num_connections++] = nsock;
	atomic_inc(&config->live_connections);

	return 0;

put_socket:
	sockfd_put(sock);
	return err;
}
```

I don't know if this is a really good thing once that until this be executed
the user space can got a generic lock (the same generic lock of sock here)
before nbd_reclassify_socket() call leading to the same problem.
Thoughts? 

>  > +	/*
>  > +	 * NBD sockets are used from block/swap/writeback context, which can
>  > +	 * already hold locks that fs_reclaim depends on.  Give them their own
>  > +	 * lockdep class so that a page fault on an unrelated userspace socket
>  > +	 * (sk_lock -> mmap_lock) is not chained to the NBD socket lock.
>  > +	 */
> 
> The description of commit d532cddb6c60 says that the problem is
> fs_reclaim being triggered while sk_lock is held, not a page fault
> (sk_lock -> mmap_lock). Please make this comment match the actual
> lockdep report or leave it out. The description of commit d532cddb6c60
> already explains why NBD sockets are reclassified.
> 
>  > +	if (sock)
>  > +		nbd_reclassify_socket(sock);
> 
> "sock" can't be NULL here because all code paths where it is NULL have
> already returned. Please remove the "if (sock)" test.
Ok, I will fix this two things

Thanks,
Guilherme
