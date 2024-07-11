Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456F15F40A
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706118; cv=none; b=gbzzahzDZTwLObz3SL5LRP9dtlxkjnU5Hmi13foTR9rohmGAHsOwG951US8aNCMGrGspmq0OfQeIq5zkEvT0UcDFYwunHEvoCT8BqO6VtliYLCIU86BKESPAZi4ZjV+Lpqdm9mkAEbRDm32AVm+OyUZP7W5iGv9cbe8t22uJnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706118; c=relaxed/simple;
	bh=40kWD81XJdY9xQJpbXnMdMYAhOXtA8D1XXNW9kJAXNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhKmnRlzIh6KkFUj6RKK6MJMsRgTjsQ9Aqt1f2HCnwkUsdLuTeE7E9bFJhg/4A7fkVjabmuH2OYCOxBVJ6YcnTvRjsk7Lrt67V7gl9aaEWq3Cqu6QTeSH6JXxXWX1XoEAC7aBWd2osPRZEb2GTJcudXgQMUVR7TPA/2ozmIKf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uQXzofrv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jl0eiumj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gKgmfoaI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T0jEtMkP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQXzofrv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jl0eiumj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gKgmfoaI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T0jEtMkP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD78E21A58;
	Thu, 11 Jul 2024 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720706109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
	b=uQXzofrvu0irluB3uQuMgllTgYyclFr6Fql4smwII0P7bt9v1cdlcKcvmCpQE0NzlmPNsT
	4udmNt0z36RoGkibYPAZd1HgDTj07QeIyOJmKnDHg+hbcyHmSHiwy6nlgGh7SGNSpL+QMq
	91yrNNZkPYBmabrsVzaWNqb4ULAPmJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720706109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
	b=Jl0eiumjCjaN9ywfzlpDi2Udpg6Oi8txSgK7v2KA0e0XCoPLqLBef1EZLaUb/I/8FF5Bcu
	T5XHQ343LvqDd5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720706108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
	b=gKgmfoaI5xomgPuDnPh31crtTBtoIXW7hGq7okPRigthlOI9UU+VfgasSBrkG9oZM3WBM9
	o7mBfClmXL1qLowA92TYD4h3itF9Vp2sZTlPzQ0YLTdBZ3Vsi1aVBhhLxAUK+0n+UaOmvY
	gyoz9TEHACjdgiRsyRRJxsu3UEG0s1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720706108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
	b=T0jEtMkPqex6CSGkiDhVlLxO2eDBe+OqdRZ04OP6nx10pM5rj1AHzAsBZ3IX6ZG2a3LQxe
	/r4xHbPxbJ36c3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B71F8139E0;
	Thu, 11 Jul 2024 13:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id omgoLDzkj2YJBQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 11 Jul 2024 13:55:08 +0000
Date: Thu, 11 Jul 2024 15:55:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: Li Wang <liwang@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
	Cyril Hrubis <chrubis@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LTP] Request for Modification of test cases
Message-ID: <20240711135507.GA84439@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
 <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <20240709224650.GB214763@pevik>
 <IA1PR10MB724000DDC9B27E375CADCFBA98A52@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR10MB724000DDC9B27E375CADCFBA98A52@IA1PR10MB7240.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REDIRECTOR_URL(0.00)[urldefense.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.cz:replyto,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -7.50
X-Spam-Level: 

> Hi Petr,

> > -----Original Message-----
> > From: Petr Vorel <pvorel@suse.cz>
> > Sent: Wednesday, July 10, 2024 4:17 AM
> > To: Gulam Mohamed <gulam.mohamed@oracle.com>
> > Cc: Li Wang <liwang@redhat.com>; ltp@lists.linux.it; Cyril Hrubis
> > <chrubis@suse.cz>; Gulam Mohamed <gulam.mohamed@oracle.com>; Jens
> > Axboe <axboe@kernel.dk>; linux-block@vger.kernel.org
> > Subject: Re: [LTP] Request for Modification of test cases

> > Hi Gulam, all,

> > [ Cc linux-block and author and committer of the change in kernel ]

> > > Hi Li Wang,

> > > From: Li Wang <liwang@redhat.com>
> > > Sent: Saturday, July 6, 2024 9:13 AM
> > > To: Gulam Mohamed <gulam.mohamed@oracle.com>
> > > Cc: ltp@lists.linux.it
> > > Subject: Re: [LTP] Request for Modification of test cases

> > > Hi Gulam,

> > > On Sat, Jul 6, 2024 at 3:48 AM Gulam Mohamed via ltp
> > <ltp@lists.linux.it<mailto:ltp@lists.linux.it>> wrote:
> > > Hi Team,

> > >     This is regarding the change in kernel behavior about the way the loop
> > device is detached.

> > >               Current behavior
> > >               -----------------------
> > >               When the LOOP_CLR_FD ioctl command is sent to detach the loop
> > device, the earlier behavior was that the loop     device used to be detached at
> > that instance itself if there was a single opener only. If
> > >                there were multiple openers of the loop device, the behavior was to
> > defer the detach operation at the last close of the device.

> > >               New behavior
> > >               ------------------
> > >               As per the new behavior, irrespective of whether there are any
> > openers of the loop device or not, the detach operation is deferred to the last
> > close of the device. This was done to address an issue, due
> > >               to race coditions, recently we had in kernel.

> > >               With the new kernel behavior in place, some of the LTP test cases in
> > "testcases/kernel/syscalls/ioctl/" are failing as the device is closed at the end
> > of the test and the test cases are expecting for the
> > >                results which can occur after the device is detached. Some of the
> > test cases which are failing are:

> > >               1. ioctl04, ioctl05, ioctl06, ioctl07, ioctl09
> > >               2. ioctl_loop01, ioctl_loop02, ioctl_loop03,
> > > ioctl_loop04, ioctl_loop05, ioctl_loop06, ioctl_loop07

> > >               The main root cause of the most of the test failures, is the function
> > "tst_detach_device_by_fd()" where the function is expecting error ENXIO
> > which is returned only after the device is detached. But
> > >               detach, as per new behavior, happens only after the last close (i.e
> > after this function is returned), the test will fail with following error:

> > >               "ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long"

> > >               Similarly, some other test cases are expecting results which are
> > returned after the detach operation, but as the detach did not happen,
> > unexpected values are returned resulting in the test failure.

> > >               So, can LTP maintainers team change the impacted test cases to
> > accommodate the new behavior of kernel for the detach operation of the
> > loop device?


> > > Thanks for highlighting the issue, can you tell which kernel version
> > > (commit ?) introduced that change, then we could adjust the test against the
> > different kernels.

> > > Thanks for the help. The patch is already in queue by the block maintainers
> > for 6.11. Seems like it will be merged soon.

> > Thanks for your report. I suppose you are talking about commit
> > 18048c1af7836
> > ("loop: Fix a race between loop detach and loop open") [1], right? The
> > commit is already in the next tree [2].

> > Kind regards,
> > Petr

> Yes, this is the one I was talking about.

I tested few ioctl* tests on  6.10.0-rc7-next-20240711 and indeed at least
ioctl_loop02 fails:

tst_test.c:1652: TINFO: Timeout per run is 0h 00m 30s
tst_device.c:97: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop02.c:54: TINFO: Using LOOP_SET_FD to setup loopdevice
ioctl_loop02.c:65: TPASS: /sys/block/loop0/ro = 1
ioctl_loop02.c:66: TPASS: /sys/block/loop0/loop/backing_file = '/tmp/LTP_iocEm3iz2/test.img'
ioctl_loop02.c:75: TPASS: lo_flags only has default LO_FLAGS_READ_ONLY flag
ioctl_loop02.c:81: TPASS: Can not write data in RO mode: EPERM (1)
ioctl_loop02.c:87: TPASS: LOOP_CHANGE_FD succeeded
ioctl_loop02.c:88: TPASS: /sys/block/loop0/ro = 1
ioctl_loop02.c:89: TPASS: /sys/block/loop0/loop/backing_file = '/tmp/LTP_iocEm3iz2/test1.img'
ioctl_loop02.c:95: TPASS: LOOP_CHANGE_FD failed as expected: EINVAL (22)
ioctl_loop02.c:54: TINFO: Using LOOP_CONFIGURE with read_only flag
ioctl_loop02.c:61: TBROK: ioctl(5,(0x4C0A),...) failed: EBUSY (16)

I'll try to have look on the fix.

Kind regards,
Petr

> Regards,
> Gulam Mohamed.

> > [1] https://urldefense.com/v3/__https://git.kernel.dk/cgit/linux-
> > block/commit/?h=for-
> > 6.11*block&id=18048c1af7836b8e31739d9eaefebc2bf76261f7__;Lw!!ACWV5
> > N9M2RV99hQ!KE2XvdHTkyIMJkkCr8N_14cJzjuRkBzr-YGp-
> > gohydEw7PVXY_4jdiz9xQIfT41XGZq2Albr_sIIVdRfUQ$
> > [2]
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/
> > next/linux-next.git/commit/?h=next-
> > 20240709&id=18048c1af7836b8e31739d9eaefebc2bf76261f7__;!!ACWV5N9
> > M2RV99hQ!KE2XvdHTkyIMJkkCr8N_14cJzjuRkBzr-YGp-
> > gohydEw7PVXY_4jdiz9xQIfT41XGZq2Albr_sIGsll89g$

> > > Regards,
> > > Gulam Mohamed.
