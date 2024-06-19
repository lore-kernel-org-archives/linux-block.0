Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7138136657
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794773; cv=none; b=cl04YdD9b2PjOJRnxslgKUJGbewCWJEVfy6ZJMkedO+0fJcFB/yQcUOdM8TB9gSmJavbGzxKFBZOGnby5qFE2t4QuvIjM1gWjsJhmhLGfa+onCVXrhBqbQCjAD8mTUkEEcXM3EUR0MnS4HAduorp/2tBPMQ0sEA4PmM7wXyJvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794773; c=relaxed/simple;
	bh=Lm+er9XC0fTTRHiRzADLvbC9e+tUr9iNHge8fPNKgBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGNDCDmJqemRPotDhw0azoL7Uopkx2j4dL/UPd30M712fK23XgyHAtzm4JAMLYR090EDwg7eUsbLQxjUFMmfzrv8S+E5N6LVK5LBukcuy6SBC5CgBwWrrAwE1IvDBWH2iFKxoWTlBFinHaW6OY0xWZAkuViCFP+nuvc2y2oQFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oE4FWtH4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TYxVnxaL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fqP3iTAo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t0G4PNR6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oE4FWtH4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TYxVnxaL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fqP3iTAo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t0G4PNR6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFC041F828;
	Wed, 19 Jun 2024 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718794770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=oE4FWtH4xAmH6XnQAzUwvTBR3kAMIcxHgAUefmKqwFpbJVc+xwlekRUuW8fGsUIr5mVOaS
	BmpH448EbUEkwRSjk+z7/MAXe4LHe1JQPHGvQ2Dy3bQE/6bLpQ0tydnOIL+bHjQIW8N4eG
	n4v/7uOF7+EhpqDHYKXlnLxzavzzCp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718794770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=TYxVnxaLlgSI/Jifyg+5ESD4z2OBnJv/ep15o3+adqhoWBPYTAEYWoveyZXcH0A7QSLuzU
	LeFEC6S0BlC8CFAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718794769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=fqP3iTAoxO9hvXrjQZI0m9+ptbb/DdZDQluBeaoRNsdomJUb4VdqsK8m1zLpqlRDiLZVei
	eVzyhZ9BUHzVeSAG8tzI7CXjkGRg2GyuXPodwEnWnelFuyKQfyZsGE38Fr34lxjt3A+Kfu
	rDHQMFn8207wR7j4PplqNeZGbkmVjHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718794769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=t0G4PNR6dEudrzk+TKp8qk9Cq7rnuGgWHtc5g6yYAdnVNJY0YhdMu06kZI3OqZuXNb8wb3
	imRgrlgZQn+XNDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE59D13AAA;
	Wed, 19 Jun 2024 10:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9/0CNhG6cmYtSwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 19 Jun 2024 10:59:29 +0000
Date: Wed, 19 Jun 2024 12:59:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org, 
	sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, 
	venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com, linux-block@vger.kernel.org, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 blktests] nvme: add test for creating/deleting file-ns
Message-ID: <b4itgwyvsk6xhlgccleshe2v5dmyqwh2tkualueotqdz3ljxef@lfrrwqcofuuf>
References: <20240619104705.2921801-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619104705.2921801-1-nilay@linux.ibm.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, Jun 19, 2024 at 04:16:40PM GMT, Nilay Shroff wrote:
> +	# start iteration from ns-id 2 because ns-id 1 is created
> +	# by default when nvme target is setup. Also ns-id 1 is
> +	# deleted when nvme target is cleaned up.
> +	for ((i = 2; i <= iterations; i++)); do {
> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
> +		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i"
> +
> +		# allow async request to be processed
> +		sleep 1

This looks a bit fragile to ensure all request have been processed. Would
it possible to wait on a state?  E.g. something like

  nvmf_wait_for_state()

?

> +
> +		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
> +		rm "$(_nvme_def_file_path).$i"
> +	}
