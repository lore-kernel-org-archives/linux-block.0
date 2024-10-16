Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CB17CA1D
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097029; cv=none; b=CBLRJBGhOmhBTTggGfAf9DzFc25qLzKJ2gW0DK1jfCGUGiMMAtOhVNs/B9GYy834bbo/F/5Ib5lFH5g3QM26VA+Pup9icfKY99ieeOk3/q5NeYGqRbbl/RxOGNT9U3fFqmYAkf2lJzwPwSUW2nxrsGtSo+PswWnK7FeHpxubV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097029; c=relaxed/simple;
	bh=8XE52YPeyCsQSieffVEwzXtNrse6YXWBrOaNnkfPiy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGuQYPvM+anBDpB5kTkBkhij5sDMo4wdtZ4oOQ+9flAAd9A+n57nuc1mcS6L5DkydJjv6miDG2e1vvdjlgOWxahQ36nb+MHK/OFCWdwEUXI9Qrxnx4x94u+SZ+X6gMM2xM2WWAzaHTVvQ9U1lNXVKHmg5r7xictmD116h1aJe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cL/xGMnp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL/xGMnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729097026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXpOuCTL+LK9WWvf+v0k7qw7YjSzRXtVkTtXK7EElnQ=;
	b=cL/xGMnp11IJZkKaTNPVGq77zawbVYUuXINBdprLrHcjmB99bAmXnsKJ6HEjkcJkx4nwjh
	H2SdweC/lGTYI1A+UDJpDQ1laDqZEJoUM876Fpa0mWE8AQ8G7qkg+zjnW6ocR1sq0Df98V
	JeWwlHhaGokHgJYMu+3c3rGPDBzyf9w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-c4ZH1sVbM5mNIbCyMVUjrA-1; Wed,
 16 Oct 2024 12:43:44 -0400
X-MC-Unique: c4ZH1sVbM5mNIbCyMVUjrA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF62F1955EE7;
	Wed, 16 Oct 2024 16:43:42 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.174])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6645D1956086;
	Wed, 16 Oct 2024 16:43:37 +0000 (UTC)
Date: Wed, 16 Oct 2024 18:43:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Leon Schuermann <leon@is.currently.online>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Vincent Chen <vincent.chen@sifive.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [bug report] block nbd0: Unexpected reply (15) 000000009c07859b
Message-ID: <Zw_tMlqOPHgY4HUS@redhat.com>
References: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
 <2786c4cb-86ad-42bb-8998-4d8fe6a537a4@acm.org>
 <CABvJ_xhqBRXPLvVDmKg9Jub7hc6vXE02S=iSR7RWW-a8UtU7WQ@mail.gmail.com>
 <162da790-2824-4090-97a0-564c15ac793f@acm.org>
 <87jzea4w2n.fsf@silicon.host.schuermann.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzea4w2n.fsf@silicon.host.schuermann.io>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Leon,

I saw only now that you replied to this old thread recently, which looks
a lot like what I reported independently yesterday:

https://lore.kernel.org/linux-block/Zw8i6-DVDsLk3sq9@fedora/T/#t

Am 14.10.2024 um 16:07 hat Leon Schuermann geschrieben:
> Vincent Chen <vincent.chen@sifive.com> writes:
> > I occasionally encountered this NBD error on the Linux 6.9.0-rc7
> > (commit hash: dd5a440a31fae) arm64 kernel when I executed the
> > stress-ng HDD test on NBD.
> >
> > [...]
> >
> > [  196.497492] block nbd0: Unexpected reply (15) 000000009c07859b
> > [  196.539765] block nbd0: Dead connection, failed to find a fallback
> > [  196.540442] block nbd0: shutting down sockets
> 
> Unfortunately, I can confirm this and the other "Double reply on req"
> bugs and pretty reliably reproduce them among a variety of different
> configurations and devices, such as
> 
> - an AMD64 VM running a vanilla 6.12-rc3+1 6485cf5ea253 ("Merge tag
>   'hid-for-linus-2024101301'") with the Fedora 40 kernel config,
> 
> - and a Raspberry Pi running its vendor kernel (6.6.51+rpt-rpi-2712 #1
>   SMP PREEMPT Debian 1:6.6.51-1+rpt3 (2024-10-08) aarch64).
> 
> I'm testing these NBD clients against both the nbd-server package
> (3.26.1) and QEMU's qemu-nbd (v8.2.2).
> 
> Key to reproducing this issue seems to be high CPU load caused by the
> NBD / filesystem / networking stack (so, running on a high-bandwidth
> connection with a server that can keep up), as well as an SMP system (I
> am testing with 4 cores on both AMD64 and aarch64 platforms).

This sounds like you could reproduce the problem with an actual network
connection, going over TCP to another host? This is an interesting
addition for me, because I only saw it with local unix domain sockets.

> To pinpoint the issue, I enabled the `nbd_send_request`,
> `nbd_header_sent` and `nbd_header_received` tracepoints while triggering
> the following bug:
> 
>     [    0.000000] Linux version 6.12.0-rc3-nbddebug+ (root@treadmill-nbd-debug-4) (gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3), GNU ld version 2.41-37.fc40) #1 SMP PREEMPT_DYNAMIC Mon Oct 14 01:07:12 UTC 2024
>     [    0.000000] Command line: BOOT_IMAGE=(hd0,gpt1)/boot/vmlinuz-6.12.0-rc3-nbddebug+ root=UUID=944ab680-e1ab-49d7-a580-dfce30985180 ro consoleblank=0 systemd.show_status=true crashkernel=auto no_timer_check console=tty1 console=ttyS0,115200n8
> 
>     [  +0.011557] EXT4-fs (nbd0): mounted filesystem 8998d2ee-2045-4708-bb3a-0fff335c437f r/w with ordered data mode. Quota mode: none.
>     [Oct14 02:36] block nbd0: Double reply on req 0000000015334b0a, cmd_cookie 193, handle cookie 187
>     [  +0.004639] block nbd0: Dead connection, failed to find a fallback
> 
> Looking at the reversed trace file, we can see the offending header with
> cookie 187 == 0xbb:
> 
>     kworker/u17:0-121     [000] .....   103.672786: nbd_header_received: nbd transport event: request 0000000015334b0a, handle 0x000000bb00000042
> 
> However, some 11 events back, we can see that this request object was
> just sent with a different NBD handle/cookie:
> 
>     stress-ng-hdd-1119    [000] .....   103.668096: nbd_header_sent: nbd transport event: request 0000000015334b0a, handle 0x000000c100000059
>     stress-ng-hdd-1119    [000] .....   103.668084: nbd_send_request: nbd0: request 0000000015334b0a
> 
> This new NBD handle (0x000000c100000059) never appears in the trace
> file, perhaps because the socket was closed before it could be received.
> 
> However, the exact handle of the offending NBD request was sent 49
> events before it was received again:
> 
>     stress-ng-hdd-1120    [002] .....   103.647257: nbd_header_sent: nbd transport event: request 00000000ae03f314, handle 0x000000bb00000042
>     stress-ng-hdd-1120    [002] .....   103.647244: nbd_send_request: nbd0: request 00000000ae03f314
> 
> In fact, all other requests in the trace have almost exactly 50 trace
> events between them being sent and received again. From this I conclude
> that it is mostly likely that the handle of the _received_ offending
> reply (103.672786) is indeed correct (0x000000bb00000042) and
> corresponds to the request 103.647244 (latency works out), but it is
> mapped onto an entirely wrong request object (0000000015334b0a), or onto
> a non-existent request object in the case of a "Unexpected request"
> error. Could it be that sometimes a request is prematurely marked as
> completed such that the queue tag gets reused?

My conclusion was that we hit one of the code paths where a partially
completed request gets requeued (and then assigned a new tag when it
runs the next time).

Maybe you want to test the patch (v3) Ming suggested in the other thread
on your setup? The problem doesn't reproduce for me any more with it,
but I suppose more testing can't hurt.

Kevin

