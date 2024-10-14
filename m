Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840391AAE25
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915311; cv=none; b=YErfpjouH1eGA3ocW61A2Xs7uXfNS8w/6JaLMmcor7cg3b5NIATKtYRqPzlABijtvKBoNqWChPecVdRbEraqMoJfY639IJ12hdNH6shH+GixIPX2S7j8Tt0DWiMVyHxUNDMxasBtlm7lJ5o9L1395/4vNLlkLcuUe5ehXh3OPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915311; c=relaxed/simple;
	bh=lo2UneFWwbc1KlyHxZ+Z2ZBmjJyjJuQVz8HtHHBF9C8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5arvtmr9eclSeYTFiPZ68+Bfl2fflgI/dARFwQLQMHxLcS3TDcKLgouDgc0IlZhAWtp+pNTjTeKSRo950t0n+0qVJ8bXMLAh2SPEQ0EmR5JgC3m+yG1wC9+hqa7dvM9WpZMHCNe6FolVX2se0CEGx9hGaxsiyIzn3pCiFwz98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.currently.online; spf=pass smtp.mailfrom=is.currently.online; dkim=pass (4096-bit key) header.d=is.currently.online header.i=@is.currently.online header.b=hzZ5p9xr; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.currently.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=is.currently.online
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=is.currently.online header.i=@is.currently.online header.b="hzZ5p9xr"
Received: from galatea.uberspace.de (galatea.uberspace.de [185.26.156.241])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id DA9E91813D6
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 16:07:31 +0200 (CEST)
Received: (qmail 25999 invoked by uid 989); 14 Oct 2024 14:07:31 -0000
Authentication-Results: galatea.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by galatea.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 14 Oct 2024 16:07:31 +0200
From: Leon Schuermann <leon@is.currently.online>
To: Bart Van Assche <bvanassche@acm.org>, Vincent Chen
 <vincent.chen@sifive.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [bug report] block nbd0: Unexpected reply (15) 000000009c07859b
In-Reply-To: <162da790-2824-4090-97a0-564c15ac793f@acm.org>
References: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
 <2786c4cb-86ad-42bb-8998-4d8fe6a537a4@acm.org>
 <CABvJ_xhqBRXPLvVDmKg9Jub7hc6vXE02S=iSR7RWW-a8UtU7WQ@mail.gmail.com>
 <162da790-2824-4090-97a0-564c15ac793f@acm.org>
Date: Mon, 14 Oct 2024 10:07:28 -0400
Message-ID: <87jzea4w2n.fsf@silicon.host.schuermann.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1)
X-Rspamd-Score: -0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=is.currently.online; s=uberspace;
	h=from:to:cc:subject:date;
	bh=lo2UneFWwbc1KlyHxZ+Z2ZBmjJyjJuQVz8HtHHBF9C8=;
	b=hzZ5p9xrAWA2bstnwzgWRwhTx8tyeWPYg1LhsxXi0GZTf68x9NyYvakE8z8k2QZewCOUdwqcrd
	FmJ7mX1vkamCq5JHbhFRrLfBdvsuzY/6NzC9kOysmuXl9ClO+ln6z4tEgHZPmYBeSiMKcLtC66+X
	9y+bezpFEPK2R8gqUV6rP0P54p73wrzCnYQSDFauRwQzKKBH6xtZ555S0DKsrNplVuh5Sz1al6vR
	Tn/+GpP8H+VkNpVJWUOko5jwFw/pQH18Li9d0Ao+IJAD+AtIGHxLIzc2MrL7sjodjbJ5YHlJFCJk
	ZWjxjTt1ER8aBDgu9n0hx54Ap7MI/7dcfsQRkkZBFy3BtoJfydf3NP6oBKMEFrCVjjljXSbdYgTu
	EMr7X9GzcRGFUS2BQp7SQ2voDXFhAefn/ZEl87EsnCYUinCl4apzGhyfJ+xSeZTAWRyEGL70vGJ6
	uUu4zjMlSmCrqvW4KwSmfZrsP/bF7vY56mpCOr3I8KLqYb8o6/vdXEutVbhJn7VbUSYpNhLWLLAY
	fidsBvqdSYUZMIKvPGnKn+Y6ouyL+A1SnhpHR3jN48y4Fiqv7GdbFvke+Fakh1K4tQKn9xXQZh2a
	rwxkw9gmch4rxdom5RUQvGIyhqM6mI66VMPAWMyXJ4wf8QMsXym33+ZjzCc/ibFRt6QBCSe8N/AO
	8=

Vincent Chen <vincent.chen@sifive.com> writes:
> I occasionally encountered this NBD error on the Linux 6.9.0-rc7
> (commit hash: dd5a440a31fae) arm64 kernel when I executed the
> stress-ng HDD test on NBD.
>
> [...]
>
> [  196.497492] block nbd0: Unexpected reply (15) 000000009c07859b
> [  196.539765] block nbd0: Dead connection, failed to find a fallback
> [  196.540442] block nbd0: shutting down sockets

Unfortunately, I can confirm this and the other "Double reply on req"
bugs and pretty reliably reproduce them among a variety of different
configurations and devices, such as

- an AMD64 VM running a vanilla 6.12-rc3+1 6485cf5ea253 ("Merge tag
  'hid-for-linus-2024101301'") with the Fedora 40 kernel config,

- and a Raspberry Pi running its vendor kernel (6.6.51+rpt-rpi-2712 #1
  SMP PREEMPT Debian 1:6.6.51-1+rpt3 (2024-10-08) aarch64).

I'm testing these NBD clients against both the nbd-server package
(3.26.1) and QEMU's qemu-nbd (v8.2.2).

Key to reproducing this issue seems to be high CPU load caused by the
NBD / filesystem / networking stack (so, running on a high-bandwidth
connection with a server that can keep up), as well as an SMP system (I
am testing with 4 cores on both AMD64 and aarch64 platforms).

To pinpoint the issue, I enabled the `nbd_send_request`,
`nbd_header_sent` and `nbd_header_received` tracepoints while triggering
the following bug:

    [    0.000000] Linux version 6.12.0-rc3-nbddebug+ (root@treadmill-nbd-debug-4) (gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3), GNU ld version 2.41-37.fc40) #1 SMP PREEMPT_DYNAMIC Mon Oct 14 01:07:12 UTC 2024
    [    0.000000] Command line: BOOT_IMAGE=(hd0,gpt1)/boot/vmlinuz-6.12.0-rc3-nbddebug+ root=UUID=944ab680-e1ab-49d7-a580-dfce30985180 ro consoleblank=0 systemd.show_status=true crashkernel=auto no_timer_check console=tty1 console=ttyS0,115200n8

    [  +0.011557] EXT4-fs (nbd0): mounted filesystem 8998d2ee-2045-4708-bb3a-0fff335c437f r/w with ordered data mode. Quota mode: none.
    [Oct14 02:36] block nbd0: Double reply on req 0000000015334b0a, cmd_cookie 193, handle cookie 187
    [  +0.004639] block nbd0: Dead connection, failed to find a fallback

Looking at the reversed trace file, we can see the offending header with
cookie 187 == 0xbb:

    kworker/u17:0-121     [000] .....   103.672786: nbd_header_received: nbd transport event: request 0000000015334b0a, handle 0x000000bb00000042

However, some 11 events back, we can see that this request object was
just sent with a different NBD handle/cookie:

    stress-ng-hdd-1119    [000] .....   103.668096: nbd_header_sent: nbd transport event: request 0000000015334b0a, handle 0x000000c100000059
    stress-ng-hdd-1119    [000] .....   103.668084: nbd_send_request: nbd0: request 0000000015334b0a

This new NBD handle (0x000000c100000059) never appears in the trace
file, perhaps because the socket was closed before it could be received.

However, the exact handle of the offending NBD request was sent 49
events before it was received again:

    stress-ng-hdd-1120    [002] .....   103.647257: nbd_header_sent: nbd transport event: request 00000000ae03f314, handle 0x000000bb00000042
    stress-ng-hdd-1120    [002] .....   103.647244: nbd_send_request: nbd0: request 00000000ae03f314

In fact, all other requests in the trace have almost exactly 50 trace
events between them being sent and received again. From this I conclude
that it is mostly likely that the handle of the _received_ offending
reply (103.672786) is indeed correct (0x000000bb00000042) and
corresponds to the request 103.647244 (latency works out), but it is
mapped onto an entirely wrong request object (0000000015334b0a), or onto
a non-existent request object in the case of a "Unexpected request"
error. Could it be that sometimes a request is prematurely marked as
completed such that the queue tag gets reused?

I tried a packet capture to confirm that the trace outputs do not
diverge from what is sent on the wire, but my capture node could not
keep up with the amount of traffic. Reducing bandwidth makes it harder
to trigger a "Double reply" error in favor of "Unexpected reply" errors,
which are more tricky to correlate with traffic. These missed packets
cause Wireshark's protocol analyzer to choke on the pcap.

All in all, this smells like a race condition around the NBD blk_mq
management code / nbd_handle_reply function to me. I tried to trace
through this code, but I am not familiar with the locking semantics and
conventions of this subsystem. Unfortunately, KCSAN did not yield any
promising findings (apart from a bunch of virtqueue and other
filesystem-related races).

I will try to investigate this further over the coming days. If anyone
has advice on how to best debug these issues, that would be appreciated!

-Leon
