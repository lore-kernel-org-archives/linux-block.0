Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C61F4E34
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477178; cv=none; b=EJg0A/guzdu+iPkkGrky3C4o4tD7pmHZVIE6WnhgcrS1fGy7ektegsqAWh2hXXWrqms/vKWupgs4R9cYX9xQS/iCs1NTyO7Obxb6sU95I3rScOtbHGiYWFJKURKOD7EvIoBx0ZTNe8KjgHSNUazlK4az1ZPWseC0cuLIOHrPIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477178; c=relaxed/simple;
	bh=67b15+vXgtH7djbm2PkMHJCfhrwoxFNecNhdy36wp4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfMJwlyEwCYgWqHlpKKAPT5IEiyImMg9BnaEY6WDRMFN0RE/XnXhvn5YJf+jcjjaYg3cBp0gk2Y4jXvcO6vNKBCUcR1xf9ghwVp8vWwbyDABfVChuZ5tQ+PZpm+MP1xg9YOK5U3Eq5e7bNo0aJUWevqQt0+VD9xmjoY+3FPrzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WIdV61Mz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=deoYtUMZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fRj9lWwE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LVcu835S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WIdV61Mz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="deoYtUMZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fRj9lWwE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LVcu835S"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5A121F38D;
	Mon, 14 Jul 2025 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752477175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKw+ltgRBSaTBIAhP3om4s19d/uYtSLen7+nRuqpo8o=;
	b=WIdV61MzgS6sKTWaM3Eu+FOkxjLfTxIIF+abPZbFbu8qI9zpp+RuFcFfsrgpUMczK2bogi
	ccU9BttYsFFKXKDYQiIpiY3NhC220UfGMuVDVBgGedwO1yqvnivvEoMXzI32p7wjfjdDUf
	qhS+7MOm6XwCLSq4GrczMVIlxhUnTfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752477175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKw+ltgRBSaTBIAhP3om4s19d/uYtSLen7+nRuqpo8o=;
	b=deoYtUMZaC2rX9Nor6QvQ1QkP3pd8ZzI6RC5G+9NhxIS9V2xYeUpwMhtXXJ4qths01Pp9p
	nwkgEHl475ZrqbDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fRj9lWwE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LVcu835S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752477173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKw+ltgRBSaTBIAhP3om4s19d/uYtSLen7+nRuqpo8o=;
	b=fRj9lWwEwyC6xPn3puqQK1Q5FY7LL5GtPYxxFbkuAJTI5Upa3UQL03wndrL4sfPRvs4vol
	X2FCypN8yHCYwCbU6Vf0w0K1KuIWBjVhz0DdHqnZ38CihBb44MxjGESgWHpuNXua8tMbDD
	hY6b7q5A6it3zUrmTzKqsTkYKThQjn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752477173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKw+ltgRBSaTBIAhP3om4s19d/uYtSLen7+nRuqpo8o=;
	b=LVcu835SEOjD9xlf/y1PB6w+J6VU84YgbrrTL9mZNL0KSN1Bi83ZVwKcVDSRAGA1gDwulr
	LhoOicQGepuvYoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98C26138A1;
	Mon, 14 Jul 2025 07:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lfgIvWtdGgbFQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Jul 2025 07:12:53 +0000
Date: Mon, 14 Jul 2025 09:12:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Alan Adamson <alan.adamson@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	Yi Zhang <yi.zhang@redhat.com>, Bart Van Assche <bvanassche@acm.org>, 
	Gulam Mohamed <gulam.mohamed@oracle.com>
Subject: Re: [PATCH blktests] loop/010: drain udev events after test
Message-ID: <ce654347-ec66-495d-a7e9-551bd6b4a002@flourine.local>
References: <20250714070214.259630-1-shinichiro.kawasaki@wdc.com>
 <auydt3njlbdh3ths3hzyiew46svwxxtd37dxzjbeyoqfk5n533@mpm2seuds26o>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auydt3njlbdh3ths3hzyiew46svwxxtd37dxzjbeyoqfk5n533@mpm2seuds26o>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B5A121F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Mon, Jul 14, 2025 at 07:09:39AM +0000, Shinichiro Kawasaki wrote:
> > --- a/tests/loop/010
> > +++ b/tests/loop/010
> > @@ -78,5 +78,12 @@ test() {
> >  	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
> >  		echo "Fail"
> >  	fi
> > +
> > +	# The repeated loop device creation and deletions generated so many udev
> > +	# events. Drain the events to not influence following test cases.
> > +	if systemctl is-active systemd-udevd.service >/dev/null; then
> > +		systemctl restart systemd-udevd.service
> > +	fi

Maybe adding a warning if udev or a 'udevadm settle --timeout 900' would
good when they system is not using systemd.
