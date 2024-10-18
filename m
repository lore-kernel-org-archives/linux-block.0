Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007242A97
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262447; cv=none; b=GUfYtAO3YkL21s96wb4wRbtE1UWVnap9IKpUToR5ZO8/A+zCeEPoihuzAXj3m76huXyy825Nbk1FQCzCnhhpjj4pvjQTGcVOsjlJ1n7gt3wmx7187HEiH6TJBrNxtGLWCz1JhpupAZvfMwTLnap2ysJ9RVio2QmVapmBptkwo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262447; c=relaxed/simple;
	bh=JVrCoboDiUiYRLORxxPe9PdtamvYplW3bwRbxTchpLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGSzg03xeSRtnFPCWDP9s6FYZzuxeX0M1LbqWnVGD14AwCUavVWU/gdJibMlV6v8lnMsT+1a1DZYHi6NkBLPApYmsIcUYc1g90Jtxj7LhF8MQT0YA8GyewZLJa+XxqvrtxmPDJfJ1hsPESR3q7aQo8fyZUvvzaJprSTj8VzX6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.currently.online; spf=pass smtp.mailfrom=is.currently.online; dkim=pass (4096-bit key) header.d=is.currently.online header.i=@is.currently.online header.b=vZOu+pcI; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.currently.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=is.currently.online
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=is.currently.online header.i=@is.currently.online header.b="vZOu+pcI"
Received: from galatea.uberspace.de (galatea.uberspace.de [185.26.156.241])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id D6EEA17F83D
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 16:40:34 +0200 (CEST)
Received: (qmail 5142 invoked by uid 989); 18 Oct 2024 14:40:34 -0000
Authentication-Results: galatea.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by galatea.uberspace.de (Haraka/3.0.1) with ESMTPSA; Fri, 18 Oct 2024 16:40:34 +0200
From: Leon Schuermann <leon@is.currently.online>
To: Ming Lei <ming.lei@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, josef@toxicpanda.com, axboe@kernel.dk,
 linux-block@vger.kernel.org, nbd@other.debian.org, eblake@redhat.com,
 Vincent Chen <vincent.chen@sifive.com>
Subject: Re: Kernel NBD client waits on wrong cookie, aborts connection
In-Reply-To: <Zw8i6-DVDsLk3sq9@fedora>
References: <Zw5CNDIde6xkq_Sf@redhat.com>
 <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
 <Zw5b1mwk3aG01NTg@fedora>
 <CAFj5m9+x+tiAAKj3dX_WcFczkdSNaR6nguDHm9FXuYjQHd8YcA@mail.gmail.com>
 <Zw5nMQoPrSIq9axl@fedora> <Zw6S6RoKWzUnNVpu@redhat.com>
 <Zw8i6-DVDsLk3sq9@fedora>
Date: Fri, 18 Oct 2024 10:40:32 -0400
Message-ID: <87bjzh4gpr.fsf@silicon.host.schuermann.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.469622) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.569622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=is.currently.online; s=uberspace;
	h=from:to:cc:subject:date;
	bh=JVrCoboDiUiYRLORxxPe9PdtamvYplW3bwRbxTchpLg=;
	b=vZOu+pcIQRAx5WkNzV/4eDch58/ygHrwolw4/Vc7wUw4U1NBItKxlamBHM8z6x2FC202gUcPQi
	DwDeoAFGo9GQFdRokVEZKAF827gouJDlk6Jc9VBIQZTdQoAWTmb9kHXPyf76ZPA45Um8tcEowBXC
	M2apFw6levChiNXRcecWXR9Mp87hGbWtJTVUzQAgmsjGmXK6yf7bwiDH4dFshr+ph0ENa4VINXjD
	OwBY078dr2UH2U61NZeZsaG69JpK8tyA/3EzuNhajj33Hfw8w43ZOheNMdzs7X/RMGiESsjSa0LW
	qbG/OmsP3lhzMCETVA+G4ph5kx1OQ4xCgOfslIx8QCcbyE+hDxZYtkbIdKWyHYmM9x3QCbXEIKYH
	n3Dofl/5yp/3qiG8NQBgor5exwtUWfuqBO62UDLafebHOSlwqYlylvng9BXy7sY+odx5slCo+enl
	ArWHLCYyGllWajrgrAsazeAKUJWioj2AmG3qQHX12fE0OYxRNBrb8OGlnarvNwrAKTw3rxA6BHTx
	8++AuKdtgXwAnfwDLDFW/mQQv4H26/uqzbXlK2OxFp5Te9HkhixSkrib3wRLR2XDDNBj23p30jwX
	GnnfsZzjzK7atK8fm7aWxcxmfoGx6wnHEPlYOsBRtlRfMFLFwA2jisASMSJE9Vg/mmYRQLftzByT
	Q=

Thanks for CCing me on this thread. Indeed this seems to be the exact
same issue that I (and Vincent Chen) reported in the other thread [1].

Ming Lei <ming.lei@redhat.com> writes:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 2cafcf11ee8b..3cc14fc76546 100644

I can confirm that this patch fixes these issues.

Prior to this patch, I managed to reproduce both the "Unexpected reply"
and "Double reply" bugs reliably via a TCP/IP connection between two
AMD64 VMs on different hosts, two aarch64 VMs, and an aarch64 Raspberry
Pi 5 SBC connecting to an NBD server on another host.

With this patch, at least in the AMD64 VM setup, it survived an
hour-long stress test using the `stress-ng` command from [1]. Also,
sending a SIGINT to a process actively using the disk often manifested
this bug. I could not reproduce this faulty behavior with this patch.

I'm still working on backporting this to and compiling the v6.6
Raspberry Pi vendor kernel and will report my observations there. I'll
also try Ming's v2 from [2].

Thanks!

-Leon

[1]: https://lore.kernel.org/linux-block/87jzea4w2n.fsf@silicon.host.schuermann.io/
[2]: https://lore.kernel.org/linux-block/20241018140831.3064135-1-ming.lei@redhat.com/
