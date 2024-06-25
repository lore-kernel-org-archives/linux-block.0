Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D616F91A
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327718; cv=none; b=r0ikud28YWIOQwY+s6U75zH6CLj/BKF5vTbbTa4J9ap08l/qj+ki2YqqF7F/8jD5/20l0m1raamafBxWEncOjDxTgsbRedlNzLw0SLzUEBnaE7bxd2BQtnPPEb9fEY5bc9CYB5BhBBrY92gek9WemXk68Isdk43TfVfZT6w55ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327718; c=relaxed/simple;
	bh=C0mrL+ZXJ6RRw3q098areJ0Xl0+mL4T0nEj7A1MRTF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTsBZmhqt6Y2zJhlQkYMO2I0oqNqe+cIYtbT2zURjH4bcWsSK7kxxWY/zEXJ3g5LdcUuMTEDD/Q8I9Q1+6q3VvI9o28LG9BqZyb5h8Bsq6A4FxhYy5QzllYnE1L16OpPQJxhu2xT6/WEnJeOtBsQ1YeoFjXO8nNKTtMx0g24lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yqyj9Thb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j0FrsEWu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yqyj9Thb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j0FrsEWu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yqyj9Thb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j0FrsEWu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yqyj9Thb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j0FrsEWu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D39A421A76;
	Tue, 25 Jun 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719327714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=yqyj9ThbWIHHEO/eC4VYWWJJmsOJdccIVDMxJyeQ0T/Lr4pFobpiwYGN7ZoUzHcPsYyzDl
	Om+4fGjFnPQO6i3WFnTCy318gTQBcue9DqXr/anKiqGmBoDUHbxriDCLc1hfbkvcmC9knI
	qN4lKhoUPiBoASr0PIBC/rxwZhV6qhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719327714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=j0FrsEWu1Xcf70dRtbcije90VywZHgqFgCrtMdWLSYRCXoDZCNN5UQalc5MNYPXHU1AYk8
	W8b0Y/cSsvdyLHDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719327714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=yqyj9ThbWIHHEO/eC4VYWWJJmsOJdccIVDMxJyeQ0T/Lr4pFobpiwYGN7ZoUzHcPsYyzDl
	Om+4fGjFnPQO6i3WFnTCy318gTQBcue9DqXr/anKiqGmBoDUHbxriDCLc1hfbkvcmC9knI
	qN4lKhoUPiBoASr0PIBC/rxwZhV6qhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719327714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZDIayh6/TZRdInMusXNeKuRzRsJ0NplLQuSxJFviw=;
	b=j0FrsEWu1Xcf70dRtbcije90VywZHgqFgCrtMdWLSYRCXoDZCNN5UQalc5MNYPXHU1AYk8
	W8b0Y/cSsvdyLHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C59721384C;
	Tue, 25 Jun 2024 15:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hIhAL+LbemZqNwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 25 Jun 2024 15:01:54 +0000
Date: Tue, 25 Jun 2024 17:01:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
Subject: Re: [PATCH blktests v2 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Message-ID: <wgza656pr5scdqiaxi4vekoffp42jvzao5kcxy7zptdgwstyik@zfcgftuzn6pf>
References: <20240624104620.2156041-1-ofir.gal@volumez.com>
 <20240624104620.2156041-3-ofir.gal@volumez.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624104620.2156041-3-ofir.gal@volumez.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon, Jun 24, 2024 at 01:46:18PM GMT, Ofir Gal wrote:
> +#restrict test to nvme-tcp only
> +nvme_trtype=tcp
> +nvmet_blkdev_type="device"
> +
> +requires() {
> +	# Require dm-stripe
> +	_have_program dmsetup
> +	_have_driver dm-mod
> +
> +	_require_nvme_trtype tcp
> +	_have_brd
> +}
> +
> +# Sets up a brd device of 1G with optimal-io-size of 256K
> +setup_underlying_device() {
> +	if ! _init_brd rd_size=1048576 rd_nr=1; then
> +		return 1
> +	fi
> +
> +	dmsetup create ram0_big_optio --table \
> +		"0 $(blockdev --getsz /dev/ram0) striped 1 512 /dev/ram0 0"
> +}
> +
> +cleanup_underlying_device() {
> +	dmsetup remove ram0_big_optio
> +	_cleanup_brd
> +}
> +
> +# Sets up a local host nvme over tcp
> +setup_nvme_over_tcp() {
> +	_setup_nvmet
> +
> +	local port
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	_create_nvmet_subsystem "blktests-subsystem-0" "/dev/mapper/ram0_big_optio"
> +	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-0"

Use the defaults from blktests, e.g. ${def_subsysnqn}"

> +
> +	_create_nvmet_host "blktests-subsystem-0" "${def_hostnqn}"
> +
> +	_nvme_connect_subsys --subsysnqn "blktests-subsystem-0"
> +
> +	local nvmedev
> +	nvmedev=$(_find_nvme_dev "blktests-subsystem-0")

here too

> +	echo "${nvmedev}"
> +}
> +
> +cleanup_nvme_over_tcp() {
> +	local nvmedev=$1
> +	_nvme_disconnect_ctrl "${nvmedev}"
> +	_nvmet_target_cleanup --subsysnqn "blktests-subsystem-0"

same here

> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	setup_underlying_device
> +	local nvmedev
> +	nvmedev=$(setup_nvme_over_tcp)
> +
> +	# Hangs here without the fix
> +	mdadm --quiet --create /dev/md/blktests_md --level=1 --bitmap=internal \
> +		--bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
> +		/dev/"${nvmedev}"n1 missing

Instead hard coding the namespace ID, this should be made a bit more
robust by looking it up with _find_nvme_ns.
