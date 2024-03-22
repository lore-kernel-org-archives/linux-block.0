Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C94437F
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110956; cv=none; b=R9Q9ifGMXfhvt/smQjVPJnzvTIKwFQ+eWmRGD4tthMwMQ7lASTWXBzvHLGI/XbZu0iEO2obUp+JuuIm5oOXslthqGv6PNw4yjEpRsGrI3IbricqEq4Zd9mKLpuRqW3O4ucjZSmSQM64mZmBb14dLvkTWjnsT9Q44vX7olT286OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110956; c=relaxed/simple;
	bh=/kG92/l7UCk+AqTDO+H4ePTb5XrFOaY9OboWTIiqWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1BjwvMEWR26cR5R0VAtZhpIPOMxDc3VB+P/HiAe7x7s8GskWhDFLeN2/LMlzXeH6Zkm1burVvFJ0WyHXAqqsrktPFMoB7BsObJicCWHK9GnaQ2sL852O7n1fd/Q2qqyA4Uk5Kox7aeB+OaviBqaotKOAP0kIV5EHdBaKrmSzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rQRAmZJz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o2T7Xp3r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rQRAmZJz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o2T7Xp3r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rQRAmZJz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o2T7Xp3r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rQRAmZJz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o2T7Xp3r"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0231D34E63;
	Fri, 22 Mar 2024 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711110953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=rQRAmZJzY3fwxGjvDrquxX3GkrKzxE28pBuiuZGdVlAHyAZNPR8VNUUTgdZ1EgVQXDgfkT
	PjF33yR2ELNmJfUWWA8E6cSpQLOpj0LBaGiu4uU7hVzk6tsLgzfhrmsGrj3oEe+8LSN2ok
	2Q0hwEEpMywF5X374r31DUgGfcKgBtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711110953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=o2T7Xp3rPVodkaOMTnOdIUlPIar6ENp/+0RenuEqykRkMKwjPo6uKsuIhg31JZoTiDVDqc
	QnSb+TK/sB5a8qDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711110953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=rQRAmZJzY3fwxGjvDrquxX3GkrKzxE28pBuiuZGdVlAHyAZNPR8VNUUTgdZ1EgVQXDgfkT
	PjF33yR2ELNmJfUWWA8E6cSpQLOpj0LBaGiu4uU7hVzk6tsLgzfhrmsGrj3oEe+8LSN2ok
	2Q0hwEEpMywF5X374r31DUgGfcKgBtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711110953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=o2T7Xp3rPVodkaOMTnOdIUlPIar6ENp/+0RenuEqykRkMKwjPo6uKsuIhg31JZoTiDVDqc
	QnSb+TK/sB5a8qDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3D6013688;
	Fri, 22 Mar 2024 12:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UWI0Nih7/WVFAgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 12:35:52 +0000
Date: Fri, 22 Mar 2024 13:35:52 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 00/18] refactoring and various cleanups/fixes
Message-ID: <xjfhvzsare7kki2rjjjrhzny6efmyqsvkxjhkscvgad4w6ozni@4646fc5b2bg7>
References: <20240321094727.6503-1-dwagner@suse.de>
 <25uxq4piju5fd5ya56wmlcsmihd6ddqbohv37xpkluqsvosorm@fvrrs53crtwj>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25uxq4piju5fd5ya56wmlcsmihd6ddqbohv37xpkluqsvosorm@fvrrs53crtwj>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.86
X-Spamd-Result: default: False [-0.86 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.50%]
X-Spam-Flag: NO

On Fri, Mar 22, 2024 at 09:38:16AM +0000, Shinichiro Kawasaki wrote:
> On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> > While working on two new features I collected a bunch of patches which I think
> > make sense to review and merge them indepenedly. And I got a few more ideas for
> > refactoring and cleanups. But one step after the other.
> 
> Overall, the patches in this series look reasonable for me. Most of them are
> part of the RFC series for the real target support, so it's good to have this
> series for separate review.
> 
> I made some nit review comments on the patches. I will do trial runs after v2
> comes out. Thanks!

Thanks for reviewing. I'm updating the series according your feedback.
I avoid sending 'ok' to every point you made, because you are right
every single time :)
