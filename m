Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF71BF50
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783463; cv=none; b=M7CB1VX7MwY3Y944ccDg8onfhc7KbwPoAqvKj/S0W6KMDgD0WCuCVHPMlW8E5RzvdBSjlJiOEWVjIW5SF9d4pMT2rwiq+QBFf60U/jSzu4UJQyNU2XW94mV4g5rOXRJ/RnDeIeivvet1FZJaNCahYRoR9pTciFs2+a93nsJWB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783463; c=relaxed/simple;
	bh=g2JEEHD17ZMM9B0Wn+6ne5pDnve4MH79EC+7rNExj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCU+gQyElXt3L8mFiXhHnSk+/F379KDbeehHlf9eb44EBMqhDorMpkovM9b08ppwl3qGGXomxpbT/vjgp9rUUTxOzq12birHY3UiCf4MbfhV7pQ3Z3N/ORH3RtIjTbc3EgzF828LTbnJEWSpOSpZgtsF2b0qevukKmqD+ZxOe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yZOIhKai; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WMM2SD66; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yZOIhKai; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WMM2SD66; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yZOIhKai";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WMM2SD66";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yZOIhKai";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WMM2SD66"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 082E61F804;
	Wed, 19 Jun 2024 07:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718783460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tscgn3+/b1xYeRbdnogyAbAzj1RxZEo+8feHfQithEk=;
	b=yZOIhKaio69OqwgrwP6UF0EEJvh36E+avLUj4XJDaxRx8SAwxdPIRF7ypTmVQWpskVITLv
	F1aaUwbYOv5aO05t5UB2W+muj+umww4spHAF/yMUjyub0NbXHJ66PtWYEaPlTHPv4CL9N1
	OS7H6yn9QNpDqr8HjJx9ogubuLPnCk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718783460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tscgn3+/b1xYeRbdnogyAbAzj1RxZEo+8feHfQithEk=;
	b=WMM2SD668tUL41S1gIHIHR/z+fPGtG08cun/OZG8MgNngW/AP3KPcLlubLWUJdoLr9eH/b
	N2jRl4dt/H15kvAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yZOIhKai;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WMM2SD66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718783460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tscgn3+/b1xYeRbdnogyAbAzj1RxZEo+8feHfQithEk=;
	b=yZOIhKaio69OqwgrwP6UF0EEJvh36E+avLUj4XJDaxRx8SAwxdPIRF7ypTmVQWpskVITLv
	F1aaUwbYOv5aO05t5UB2W+muj+umww4spHAF/yMUjyub0NbXHJ66PtWYEaPlTHPv4CL9N1
	OS7H6yn9QNpDqr8HjJx9ogubuLPnCk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718783460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tscgn3+/b1xYeRbdnogyAbAzj1RxZEo+8feHfQithEk=;
	b=WMM2SD668tUL41S1gIHIHR/z+fPGtG08cun/OZG8MgNngW/AP3KPcLlubLWUJdoLr9eH/b
	N2jRl4dt/H15kvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9AC413ABD;
	Wed, 19 Jun 2024 07:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDDOOOONcmZGEAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 19 Jun 2024 07:50:59 +0000
Date: Wed, 19 Jun 2024 09:50:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: shinichiro.kawasaki@wdc.com, kbusch@kernel.org, sagi@grimberg.me, 
	hch@lst.de, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, 
	venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.com, linux-block@vger.kernel.org, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCH blktests] loop: add test for creating/deleting file-ns
Message-ID: <gpatyu3gqzfswxishsa7juix2z2upmbrkec7n57pbgfzw56jla@lyjvwhv5dvc6>
References: <20240617092035.2755785-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617092035.2755785-1-nilay@linux.ibm.com>
X-Rspamd-Queue-Id: 082E61F804
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, Jun 17, 2024 at 02:47:22PM GMT, Nilay Shroff wrote:
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local subsys="blktests-subsystem-1"

Use the default variables instead of duplicating them.

> +	local iterations="${NVME_NUM_ITER}"
> +	local loop_dev
> +	local port
> +
> +	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
> +
> +	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
> +
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	_nvmet_target_setup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
> +
> +	_nvme_connect_subsys --subsysnqn "${subsys}"

As far I can tell this could just be:

	_nvmet_target_setup

	_nvme_connect_subsys
