Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F33171E5A
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876084; cv=none; b=mT0SpmqY9iq9Odw++RANwenhcGwZNUoLIkAMGVeLneS52qxNrgiCdzriMnzH4hBsuWX8DxwfUIlwMBCZEX06x0cHe1qyT3r5gbroy+KzbWl7ayps4Zdmkf/Tj2258Re++Rdj7yXtKhi0nHt+wKzn/xTOLiL6MTQtTETVAo/VghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876084; c=relaxed/simple;
	bh=DI0FuyC7oBeJ90AEQbkWngaG0H+McxGPasgTP/AyS/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKfT4p6psdE/rIakL9y5zuj5jU2nguP9jHRp+/M0Q5bxqe8riqqExo0gsH+bZBeTSqiqjf617UQ5Hbh9IGgLBMRCOtGQedzyVuf0gfEEwoblT7s0d/Spjwsw2GEeC//nbT+44xa+vyoPVBor2Am/k1nucLNZNjSihG4Puxognls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MHsQjt+R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DNyiPN4Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mYwBDBez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+hiw7bNs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MHsQjt+R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DNyiPN4Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mYwBDBez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+hiw7bNs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F063A1F7AB;
	Mon,  9 Sep 2024 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725876081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=MHsQjt+ReDNfsgsi06k3PtR0GkEfDNf5vFKZYDkfWyNdqQN/feDhRzB7p9EkMKO6/Utoni
	teNYgxbFpfErWEIVE/yp6j64GglvW5LuckGh+D/GjgtcWGORWZbpDXiewwhI0rqYKeY0qY
	i6dz/t96GlEThMrZIupJWNefJOfPuM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725876081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=DNyiPN4Q9PQKzDshagegD7ELH/Bd6npbbuooBckzO2Sc62R5FoxYVWCLfzM7Jg+iXWrd9f
	7so0YSHyY0s8viAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725876080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=mYwBDBez8aVLaUHcRRYRxN9jJmAk9z/iMpSMMfaNy/7ArK0Dd0/iZTxCZYhaQMNjCqSpco
	jW+mws3L6lKQHIA3fsDhrOkNz9lozqYz6dznQTR2vDN7PBCeH9JZwdByzzNmOCidCogQ0b
	547SzIqT42LpnQYw0Y/VQ7KYHz6jzd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725876080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=+hiw7bNsYZnHo9J1+ElYGCaJyMVTy1P/h8ULN4TIZVDJRE+CSsSJvlFNonJjLero2kZBw+
	cidwyd0X4XoAJ3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6D2813312;
	Mon,  9 Sep 2024 10:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1bwEMm/H3mZPDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 09 Sep 2024 10:01:19 +0000
Date: Mon, 9 Sep 2024 12:01:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v3 1/3] blktests: nvme/{033-037,039}: skip passthru tests
 on multipath devices
Message-ID: <80e98949-875d-4754-a70c-851dd0549b41@flourine.local>
References: <20240902142748.65779-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902142748.65779-1-mwilck@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Sep 02, 2024 at 04:27:45PM GMT, Martin Wilck wrote:
> NVMe multipath devices have no associated character device that
> can be used for NVMe passtrhu. Skip them.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

As far my bash scripting foo goes, looks good.
For the whole series:

Reviewed-by: Daniel Wagner <dwagner@suse.de>
