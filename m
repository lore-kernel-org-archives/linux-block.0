Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357629;
	b=ueeRylb8YiYVjSpGcyH9h0IdATMHc3xEUiGEB6bc1T/xBBNpgp9/Ilpqyo+tDnrVk34t
	 OoNMxU3TVyN4rXE42uZlfIFmgOCrGf+VaX2DI9KyoJW92af49LADncqB2WqEZKTq6KQHo
	 n1i2d8wP+yvZLv5aITEGqLFcaCKBE/AT2VaVeg1KjX6Rh5F5KrmQ31lo85jthb6Sris0s
	 kw7ls3C8iC2K4Pb4CeKwBePlhuDwgS5+yvYhbjj1vMmVFiYS48NesoAIMjDHDsIDVVlci
	 3A1pMFPnaMwTGHkzwsm2iveWBkv8/hEThi3jsy3ZWRfeVuIMikPV+oiG2jIEmeadbjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iea+cKs+9SRn0f7ya3vvcLTwUK2Ejys1AxFgxCV/XPs=;
	b=ytEiu0YaZtS+PuWrv6V3bJqkbIFsy4SpSs/1Qx3EmSTfKV9iWYqUskbuYWcstsayKmI4
	 34wgK0uOOvsA2JFm4f41+2pwZboj1S4/8MK7/2NwZRUtxpCDXqHi6I6/iNUdYqjZkVFtf
	 IA7E18s5zMsIuR7HYbvrr3YbMpI75E1KiaY0qAEavLxBGM5c/5gRuXLZwbF16r0/9SsaX
	 xpDORX91nkLF0UL2R4dbVXloUSif0CYmZ2V28ve8p/VS5HG8zyStQkNvYXfe+yWuNoArn
	 Icm0ABzRq14ttmyBldMG+PpYomWglgfAOD0WDR73JwwKLIAtTPKc1Diq3JddTuiUP/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rgGFzJ6o;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589A606A31C;
	Wed, 11 Nov 2026 00:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9589A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rgGFzJ6o
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jPPnR6fm8zlfftt;
	Wed, 11 Nov 2026 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794357624; x=1796949625; bh=iea+cKs+9SRn0f7ya3vvcLTw
	UK2Ejys1AxFgxCV/XPs=; b=rgGFzJ6oFiFhSsXSB20TqPVGrg5q5NQEesc4DNQs
	VSxtmhphMCt7og4aQ0R9x5APR85lSZtvOibBMQ6jr4SsHP/Da4k4SGD3q1jjIxMr
	hYY4NpfF1IgiK1ZJiSn3AyK/LtTPPaZqSoZQM9AEc4wzZgRNZOiBnP9XKQi8pROC
	0ZMc/VQF5RtUuAGp17HXSa72LsskMynyowCuh4uTFn8u09Q0ujVLCG33hCRhuWgm
	vAZevPXnQrYQ9JNrIrZaxKPFf3BW2LEcROIHrltOqtrdfZGaE/HwLxcMthfta9PD
	JZsAE9zFDn53GErHtA3MKBOP35Gl5m5LPx03V/Ew6fQhTw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cjNtGs3iPHG8; Wed, 11 Nov 2026 00:40:24 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jPPnN3CqzzlgyGr;
	Wed, 11 Nov 2026 00:40:24 +0000 (UTC)
Message-ID: <99cd5aa0-4afe-4796-86c4-926273e72a6e@acm.org>
Date: Tue, 10 Nov 2026 16:40:23 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix circular lock dependency
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, josef@toxicpanda.com,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org,
 syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
References: <20261110215723.199948-1-trintaeoitogc@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261110215723.199948-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 1:57 PM, Guilherme Giacomo Simoes wrote:
 > Subject: [PATCH] nbd: fix circular lock dependency

There is no real circular lock dependency here. This patch addresses a
lockdep false positive caused by the missing socket reclassification in
the reconnect path. Please change the subject into something like
"nbd: Also reclassify sockets in the reconnect path".

 > instead of the NBD-specific class leading to a possible lock dependency.

Please change "possible lock dependency" into "lockdep false positive".

 > Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
 > Link: https://syzkaller.appspot.com/bug?extid=d7d72f3d467710442af0

Please use Closes: instead of Link: for the syzbot report. Has this
patch been tested against the syzbot reproducer, e.g. with "#syz test"?
If so, please mention this.

 > -static struct socket *nbd_get_socket(struct nbd_device *nbd, 
unsigned long fd,
 > -				     int *err)
 > -{
[ ... ]
 > +static struct socket *nbd_get_socket(struct nbd_device *nbd, 
unsigned long fd,
 > +				     int *err)
 > +{

Moving nbd_get_socket() makes this patch much larger than necessary,
which makes reviewing and backporting it harder. Adding a single
nbd_reclassify_socket(sock) call in nbd_genl_reconnect_sock_cb() right
after the nbd_get_socket() call is sufficient. If the reclassification
should happen in nbd_get_socket(), please move nbd_reclassify_socket()
up instead of moving nbd_get_socket() down.

Additionally, reclassifying the socket in nbd_get_socket() happens
before it is known whether NBD will use the socket. If
nbd_genl_reconnect_sock_cb() does not find a dead connection, or if
nbd_add_socket() fails, the socket is returned to user space with the
NBD lock class. While this only affects lockdep and while the
nbd_add_socket() error paths already behave this way, it is another
reason to only reclassify a socket once it is really being used.

 > +	/*
 > +	 * NBD sockets are used from block/swap/writeback context, which can
 > +	 * already hold locks that fs_reclaim depends on.  Give them their own
 > +	 * lockdep class so that a page fault on an unrelated userspace socket
 > +	 * (sk_lock -> mmap_lock) is not chained to the NBD socket lock.
 > +	 */

The description of commit d532cddb6c60 says that the problem is
fs_reclaim being triggered while sk_lock is held, not a page fault
(sk_lock -> mmap_lock). Please make this comment match the actual
lockdep report or leave it out. The description of commit d532cddb6c60
already explains why NBD sockets are reclassified.

 > +	if (sock)
 > +		nbd_reclassify_socket(sock);

"sock" can't be NULL here because all code paths where it is NULL have
already returned. Please remove the "if (sock)" test.

Thanks,

Bart.
