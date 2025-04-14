Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FB28936E
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637248; cv=none; b=G3LGm65hMH/IoNQ3zcpD4uXWQH5qPQSpPZAWtnrZbPTRqZ/Qee568/TmTcF4fDRUnelz6VAVMQMMzaeZSzk0Ce8czTpOyuMv1bJjzWknDWTJZ7fyF7dTQFkYDal76xWQabjnEvZfjHhL2PiOqGsKQDgfzkCWe8Q/V7RkjWIb/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637248; c=relaxed/simple;
	bh=YsF3n9pMjB+H9cBFX9Ut43zGVnrSXD7izxLnfMrU1e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAoMSXlGWjwIfY9cmJUVjgBCPyYinIsCDEui8zA3AbFSsl+a4+MQFrneo2/7c5wCNKy0S82J5CFgZCE8ADbEL/Ub/6W/j8wqYzXuOlClLM9SvlIyyVYf80M3BHy+uyCJtW1peFBn3lWNb6oA1HDvEK3icaFMjzrwahXhxbIuEJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eY2Ls3DO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EXSXSMS3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=plL9FqEB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iL8dfw7j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eY2Ls3DO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EXSXSMS3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="plL9FqEB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iL8dfw7j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E14461F83B;
	Mon, 14 Apr 2025 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744637245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQAswdNX2zA4HbhXkzwmrcygZ7OSsJClYP1qML8B+1k=;
	b=eY2Ls3DORKO6q/rtZRVWNE1hdKzfW8POWQW5t2061N/cR8cOF+gLZHsmDvkspy/sXiJQ2t
	IZqSgagkFsWkllnMmCwNPpk3G4znGbqfeKAVuIBlOuszQG4Q/jI7ei13WgdUaVMFAXAKDA
	LRD1RtB+8ktqPqfUbF0cOgQPx1vR1uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744637245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQAswdNX2zA4HbhXkzwmrcygZ7OSsJClYP1qML8B+1k=;
	b=EXSXSMS359Ox3BwJJCcmBHNGlSwrPX7NlttR1hMg5cprcRq0nkA9YQe12JgKJfm4DDW4a2
	wlxL82REBOomgLBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744637244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQAswdNX2zA4HbhXkzwmrcygZ7OSsJClYP1qML8B+1k=;
	b=plL9FqEB4RG+SR4f39OuOhhUDN2/QizDsd0ifO8XcG9kJGd8/SZnDiyyXJr6w12uQUUHo8
	Pfv212B1AbytwLc8HoOEpWLxA1ZKai+TD7FyV8iH5vr7LKX4M0zYbo6lIZm8clmQAQTHRr
	2th2grCwp/oqV7Xc4bjyl8Fn4wWZCVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744637244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQAswdNX2zA4HbhXkzwmrcygZ7OSsJClYP1qML8B+1k=;
	b=iL8dfw7jbygnUuKCntS3cCk2MaPQuGJp/W8oHQXtu9dpAdLYhX+fcG9l6MkztRTb0Pqgdy
	kjOOP8+lVyAbvADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D20DE136A7;
	Mon, 14 Apr 2025 13:27:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3CRpMjwN/WcVfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Apr 2025 13:27:24 +0000
Date: Mon, 14 Apr 2025 15:27:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 4/4] nvme/061: add test teardown and setup
 fabrics target during I/O
Message-ID: <84be67a8-f406-4ed2-a8c3-6d7b3ae86b94@flourine.local>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
 <20250408-test-target-v2-4-e9e2512586f8@kernel.org>
 <x3nhda5qyj4o5qf5uiohzuulyimlef4x7ov3itx77ghni5s3fz@4hpttpchyj2v>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x3nhda5qyj4o5qf5uiohzuulyimlef4x7ov3itx77ghni5s3fz@4hpttpchyj2v>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Apr 14, 2025 at 12:18:05PM +0000, Shinichiro Kawasaki wrote:
> On Apr 08, 2025 / 18:26, Daniel Wagner wrote:
> > Add a new test case which forcefully removes the target and setup it
> > again.
> > 
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> 
> When I ran this test case for tr=loop, it fails.
> 
> The out file is as follows:
> 
>   $ cat ./results/nodev_tr_loop/nvme/061.out.bad
>   Running nvme/061
>   iteration 0
>   grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>   grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>   grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>   grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>   grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>   grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>   expected state "connecting" not  reached within 5 seconds
> 
> And kernel reported the "invalid parameter" message:
> 
>   [  888.896492][ T3112] run blktests nvme/061 at 2025-04-14 21:11:18
>   [  888.937128][ T3158] loop0: detected capacity change from 0 to 2097152
>   [  888.949671][ T3161] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>   [  888.997790][ T3170] nvme_fabrics: invalid parameter 'reconnect_delay=%d'
> 
> In the v1 series, you noted that your fc-loop fixes will avoid the
> failure.

Yes, the fcloop fixes will address the fc transport failures. The above
failure is caused by the same issue as in 060: the loop transport
doesn't know about reconnect_delay, thus the requires should list tcp,
rdma and fc as valid transport and not loop.

> But the failure was observed with tr=loop, so I'm not sure fc-loop fixes
> will avoids the failure. I'm wondering if this test case is for rdma/tcp/fc
> transports only and suspecting it may not be intended for the loop
> transport.

Yes, this is correct. My test script listed only tcp, rdma and fc, so I
didn't catch the error with loop.

> > +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> > +	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
> > +	for ((i = 0; i <= 5; i++)); do
> > +		echo "iteration $i"
> > +
> > +		_nvmet_target_cleanup
> > +
> > +		_nvmf_wait_for_state "${def_subsysnqn}" "connecting" || return 1
> > +		echo "state: $(cat ${state_file})"
> 
> The line above needs one more pair of double quotations to avoid the
> shellcheck warn:
> 
> 		echo "state: $(cat "${state_file}")"

I didn't know this is actually allowed and even required. Sure, will
update the patches accordingly.

Thanks,
Daniel
