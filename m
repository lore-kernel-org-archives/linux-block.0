Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FA374D3
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194870; cv=none; b=etDRAev1iZfmhLBlrKVFGm0yGt2IqLbbgFpGfbz20wV7d+XhveStDbQ4shptPfydqRC/4f0/g92BhyQaRFYxk/OjQbzlMoFmSoG+TjE69vGgPg/DIVBeP9AWwkUglNcVcOm+L3kPX9mj4RuDlx00KpzD0GY8rNMM69giCFwGJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194870; c=relaxed/simple;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHnfY/uIf59rV1RkgAN8KwV+G5BypfWk5XgrqdH3lTvOZaeoA4n1z0SI1j2dU6numkMODO2CovskNxCYMgZhgmRwZiYMFMbtvjZN0+Ze2UHNEpDoxiVyO+QFjWy6uqKHavSCFQsAHRwtm3eZnI/8vHfNG/x0kf6CNaW4+uqvk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzMbKuAB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+O9ZL+i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzMbKuAB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+O9ZL+i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzMbKuAB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+O9ZL+i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzMbKuAB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+O9ZL+i"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E08625C1BF;
	Wed, 12 Jun 2024 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718194866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=OzMbKuABKKp8eEenmZY3/W/U/R097LIAnM/aC/M0ga4PDa5apls60PdPk3yV+7SfGBeknp
	ObyMPdxTvDs5wCG05SrnZgzERaFieT/vptbO8ozavosVC1sUp0kYjlkQGp/JmsHatAosLg
	oGpnH0BM7UwxmT6k8qGUDj0X3GfGUKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718194866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=g+O9ZL+iTX4Bi64mmZS9gp1uRrOKmfIBRPC0Af/KmDZG+EZX8a9EmUqoIEgBvKZG0JJa+l
	F61tkGcAyoJ/a6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718194866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=OzMbKuABKKp8eEenmZY3/W/U/R097LIAnM/aC/M0ga4PDa5apls60PdPk3yV+7SfGBeknp
	ObyMPdxTvDs5wCG05SrnZgzERaFieT/vptbO8ozavosVC1sUp0kYjlkQGp/JmsHatAosLg
	oGpnH0BM7UwxmT6k8qGUDj0X3GfGUKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718194866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvX6rH0pkljDUwUMsIyxIci4p1n6qg/XubZcJ1g3AwM=;
	b=g+O9ZL+iTX4Bi64mmZS9gp1uRrOKmfIBRPC0Af/KmDZG+EZX8a9EmUqoIEgBvKZG0JJa+l
	F61tkGcAyoJ/a6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D62CA1372E;
	Wed, 12 Jun 2024 12:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nG5BNLKSaWZYJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 12 Jun 2024 12:21:06 +0000
Date: Wed, 12 Jun 2024 14:21:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RFC blktests v2 3/3] contrib: add remote target setup/cleanup
 script
Message-ID: <36n7xm55qnlht6mc6n7qgqneugzbepsqcrq22lspalqxfsar3j@l4uukejcfupf>
References: <20240612110444.4507-1-dwagner@suse.de>
 <20240612110444.4507-4-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612110444.4507-4-dwagner@suse.de>
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.79
X-Spam-Level: 

On Wed, Jun 12, 2024 at 01:04:44PM GMT, Daniel Wagner wrote:
> +# blktests calls this script to setup/teardown remote targets. blktests passes
> +# all relevant information via the command line, e.g. --hostnqn. The interface
> +# between blktests and this script is 'documentent' here in build_parser
> +# function.

I just had an offline discussion with Hannes. This script is setting
up/tearing down the targets on demand. This is fine for a remote Linux
box the soft target running use case.

Hannes' idea/requirement that it should also support static setups. E.g.
the admin setups the real remote target and provides the ns uuids, which
test should run against (this is very similar to TESTS_DEVS). Thus the
tests should only operate on ns uuids and through this script blktests
can ask for the ns uuids.
