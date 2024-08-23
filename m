Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B319188585
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424600; cv=none; b=FHk3aJD1/4qbJuaNo2QQ5Z9+vLDlMADTQn1TUwbdtkVPiBVhDbDpZ9u5YLX2irk9MRAtmbqsehvAHX6JWFr6MEhfDJZhqs2nfCDr/eSnwUx3iEGk1WaQJGBfzYkBzQs3ht+U5YOUHQS0wVuqv8Hd0jRalzDfZ/3RbV63IgbZ5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424600; c=relaxed/simple;
	bh=hZrrNY16Bo8j/J2x+PrPGlVUimFjgWNMUmkg9hdtiHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUjTfWRp7MJFCo08StVAUiZZjNTqSx8zNjN0+Op6SKBUIUt/m5beQG3s3+oklyRENuOdx65r3GXC+xu7wjv2ML+/ou1DoEnQw0J1T8UxAw71Sh9k0j4uhgvV8Vv7g6rjTrNeJv9CkHvjuFfiCR+e+hSGRQ79Ru6JD2H7nVmEBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJ5Sggyf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJ5Sggyf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJ5Sggyf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJ5Sggyf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F5182032A;
	Fri, 23 Aug 2024 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724424590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8gF0VRc9Y7rNBPRo/VdLr5wb4xFr5AtxCkwB+zyjs0=;
	b=ZJ5SggyfHyMVH4mBqAVtEuFAVR+60VKvNCDblLPKQGIa1nozRRxUQyRcbaPa+wmeXiyDeE
	aMRqwZZCByXG0RWCbY+gQM1X/R/eZ7gOfmDsOgAWYtERysfBySrKzL+2O4U/x/Fh/oZu2D
	xMaeSjmu9Tz6bfR60E577FlJcpptwSo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724424590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8gF0VRc9Y7rNBPRo/VdLr5wb4xFr5AtxCkwB+zyjs0=;
	b=ZJ5SggyfHyMVH4mBqAVtEuFAVR+60VKvNCDblLPKQGIa1nozRRxUQyRcbaPa+wmeXiyDeE
	aMRqwZZCByXG0RWCbY+gQM1X/R/eZ7gOfmDsOgAWYtERysfBySrKzL+2O4U/x/Fh/oZu2D
	xMaeSjmu9Tz6bfR60E577FlJcpptwSo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EC021333E;
	Fri, 23 Aug 2024 14:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qEbKCY6hyGZ7fQAAD6G6ig
	(envelope-from <mwilck@suse.com>); Fri, 23 Aug 2024 14:49:50 +0000
Message-ID: <2cb6f86256803af00557f07e9573331c51111953.camel@suse.com>
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
From: Martin Wilck <mwilck@suse.com>
To: Nilay Shroff <nilay@linux.ibm.com>, Shin'ichiro Kawasaki
	 <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
 <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-block@vger.kernel.org,  linux-nvme@lists.infradead.org
Date: Fri, 23 Aug 2024 16:49:49 +0200
In-Reply-To: <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
References: <20240822193814.106111-1-mwilck@suse.com>
	 <20240822193814.106111-3-mwilck@suse.com>
	 <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 2024-08-23 at 15:48 +0530, Nilay Shroff wrote:
>=20
> On 8/23/24 01:08, Martin Wilck wrote:
> >=20
> > +	finish=3D$(($(date +%s) + TIMEOUT))
> > +	while [[ $(date +%s) -le $finish ]]; do
> > +		# sleep interval between 0.1 and 5s
> > +		usleep "$(((RANDOM%50 + 1)*100000))"
> > +		echo 1 >"$1/rescan_controller"
> > +	done
> > +}
> I think here usleep may not be available by default on all systems.
> For instance, on fedora/rhel I don't have usleep installed in the=20
> defualt configuration and so I have to first install it. So you may
> want to add "usleep" as per-requisite for this test. Moreover, after=20
> I installed usleep on fedora and ran the above test I see this
> warning:
>=20
> warning: usleep is deprecated, and will be removed in near future!
>=20
> Due to above warning the test fails. So is it possible to replace=20
> usleep with sleep?

The README states that blktests requires GNU coreutils, so yes, that
would be feasible - in principle.

The problem is that bash can't do floating point math, and I want to
be able to sleep for fractions of a second. So I'd need to do something
like this:

usleep() {
    sleep "$(awk "BEGIN { print $1 / 1.e6; }" </dev/null)"
}

But the fork-and-exec to "awk" is slow. millisecond sleep times can't
be realized this way.=C2=A0Anyway, I realize that calling "usleep" also
carries a lot of overhead, and thus "usleep 1000" doesn't do what one
would na=C3=AFvely expect, either.

The only way I can see to make this work as originally intended is to
implement is as an awk script. The README says that GNU awk is
required, so sleep() with floating point argument is available.

Thanks
Martin

