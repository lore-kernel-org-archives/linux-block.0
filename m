Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396A13211E
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565216; cv=none; b=jesS89UOCCko8U1XkjqJYsrXnYxpsvtx4oGm//KzHKN6k2d1zW/v5/Pu9DDG9wfEG0InMoCcC63d6fe2gr8w24cLbh5KP5LgnGtARrz6666N3xHi+Reb1cxe2olknKyYCAeeKaKoRLyaDvuNGtmahyx9yOBL3oSe32EXmnyB8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565216; c=relaxed/simple;
	bh=7YLyNCGyXaNDg1Gyfw1IOZszxeZvP26NuvgzS5SJjXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5+Sc0V7167J6LoRTCzbGpndokAy+2gV5otNymkROCAQzXtu96gMC+kgwugfQHaOnATmtx9YlIyRvZ3B66iRy/wIjqCKDpuYiJkS8moQ6BezIVo5zTbuQH7hL40PUbeYj2+/0xq0nL32p9xy54RSw9GZXxmNr2Egsr6H55jv86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQa7LI9i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x5Ep4bwX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQa7LI9i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x5Ep4bwX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQa7LI9i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x5Ep4bwX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQa7LI9i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x5Ep4bwX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEB991F806;
	Tue,  9 Jul 2024 22:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720565212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
	b=lQa7LI9iqnSPqkg7E2VCf+6uyVja8w2cmHvOvUFANYYN4fOp3765fdA34t1tBU/ncsZPSy
	7dR8whU8q4bvFgp5iwRTvwklKO3Kkf5qUT4nDJcI5bYlq/1iPfyAxQqXCxaMoaFFtabFf9
	/oF+jQgWLBInEoZtZojpyCdq+mgDPho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720565212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
	b=x5Ep4bwXeHfGW19p+V1JA/zLaWQuOQivqw03Hf+uOAcQjURPG96AM8MnBdzzL3Jr9Xe5xu
	XsAxdgAurzci8RBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720565212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
	b=lQa7LI9iqnSPqkg7E2VCf+6uyVja8w2cmHvOvUFANYYN4fOp3765fdA34t1tBU/ncsZPSy
	7dR8whU8q4bvFgp5iwRTvwklKO3Kkf5qUT4nDJcI5bYlq/1iPfyAxQqXCxaMoaFFtabFf9
	/oF+jQgWLBInEoZtZojpyCdq+mgDPho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720565212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
	b=x5Ep4bwXeHfGW19p+V1JA/zLaWQuOQivqw03Hf+uOAcQjURPG96AM8MnBdzzL3Jr9Xe5xu
	XsAxdgAurzci8RBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E81E1369A;
	Tue,  9 Jul 2024 22:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id okCDOdu9jWb9KwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 09 Jul 2024 22:46:51 +0000
Date: Wed, 10 Jul 2024 00:46:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: Li Wang <liwang@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
	Cyril Hrubis <chrubis@suse.cz>,
	Gulam Mohamed <gulam.mohamed@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [LTP] Request for Modification of test cases
Message-ID: <20240709224650.GB214763@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
 <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Spam-Level: 

Hi Gulam, all,

[ Cc linux-block and author and committer of the change in kernel ]

> Hi Li Wang,

> From: Li Wang <liwang@redhat.com>
> Sent: Saturday, July 6, 2024 9:13 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] Request for Modification of test cases

> Hi Gulam,

> On Sat, Jul 6, 2024 at 3:48 AM Gulam Mohamed via ltp <ltp@lists.linux.it<mailto:ltp@lists.linux.it>> wrote:
> Hi Team,

>     This is regarding the change in kernel behavior about the way the loop device is detached.

>               Current behavior
>               -----------------------
>               When the LOOP_CLR_FD ioctl command is sent to detach the loop device, the earlier behavior was that the loop     device used to be detached at that instance itself if there was a single opener only. If
>                there were multiple openers of the loop device, the behavior was to defer the detach operation at the last close of the device.

>               New behavior
>               ------------------
>               As per the new behavior, irrespective of whether there are any openers of the loop device or not, the detach operation is deferred to the last close of the device. This was done to address an issue, due
>               to race coditions, recently we had in kernel.

>               With the new kernel behavior in place, some of the LTP test cases in "testcases/kernel/syscalls/ioctl/" are failing as the device is closed at the end of the test and the test cases are expecting for the
>                results which can occur after the device is detached. Some of the test cases which are failing are:

>               1. ioctl04, ioctl05, ioctl06, ioctl07, ioctl09
>               2. ioctl_loop01, ioctl_loop02, ioctl_loop03, ioctl_loop04, ioctl_loop05, ioctl_loop06, ioctl_loop07

>               The main root cause of the most of the test failures, is the function "tst_detach_device_by_fd()" where the function is expecting error ENXIO which is returned only after the device is detached. But
>               detach, as per new behavior, happens only after the last close (i.e after this function is returned), the test will fail with following error:

>               "ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long"

>               Similarly, some other test cases are expecting results which are returned after the detach operation, but as the detach did not happen, unexpected values are returned resulting in the test failure.

>               So, can LTP maintainers team change the impacted test cases to accommodate the new behavior of kernel for the detach operation of the loop device?


> Thanks for highlighting the issue, can you tell which kernel version (commit ?)
> introduced that change, then we could adjust the test against the different kernels.

> Thanks for the help. The patch is already in queue by the block maintainers for 6.11. Seems like it will be merged soon.

Thanks for your report. I suppose you are talking about commit 18048c1af7836
("loop: Fix a race between loop detach and loop open") [1], right? The commit is
already in the next tree [2].

Kind regards,
Petr

[1] https://git.kernel.dk/cgit/linux-block/commit/?h=for-6.11/block&id=18048c1af7836b8e31739d9eaefebc2bf76261f7
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20240709&id=18048c1af7836b8e31739d9eaefebc2bf76261f7

> Regards,
> Gulam Mohamed.
