Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B293AB5DA
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811559; cv=none; b=q+aqY74zv/PFZ0RX/kNBjrMOGKKNRtbkuOdg02F+RRg24yY/0JVKQ+qPMhFfOFdQOkSNi32TUjJ8y8MhF4QRYMC1p6TmoI3BWb31LH/NImmAm5CeeCpplchHCwMxuMnUg9ZbRVuq8LmFagZP9pAzDBGA79W07MI9pN+GDmb6qNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811559; c=relaxed/simple;
	bh=wtKitjtzmd/W3pYaBMBl0rpKGMTcllyt74BBNd8mKkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc9mW0nMv3ocS8gpe8hkVpe9WM/iqEuYlGeAbgMmpLMaRQUkLjo4llCdP6NEpcQgLuJKMyTVD5YGhazQeswZGyMes+k/QMfgJyl08F3hsrYKtFcYDLS1aQjSul32kahaaaA812ebGyQ3oBZGi1zjgjSuzaE9mBUb8fHDzLtWWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hSo0Ab3H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/YR2m4Es; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eyzmpKwA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YJKsXh+E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hSo0Ab3H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/YR2m4Es";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eyzmpKwA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YJKsXh+E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 309566749F;
	Tue, 26 May 2026 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779811556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6nl9BWi2tPkU3zI7N4oxXpL8czPQn+mAF/EXe4tDgo=;
	b=hSo0Ab3H58LHEjWqMfgRMQzR6cx9naHEEYs8jTl28GXLDAAPTzJ+RgWpAB8Inz5HBnR6gh
	yhOlyTHvGWgACYVPjbO4hnBLbrWDspjF4gmIOuHioth8VEJpf1Swn21QvvcBpK0RG1MgBN
	iTpoJqRccZi3eiZWnd+MN4gxQMmeFAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779811556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6nl9BWi2tPkU3zI7N4oxXpL8czPQn+mAF/EXe4tDgo=;
	b=/YR2m4EsRcC34rZZxFOnqPWsXydVVfuq2X6V584zMoyMxort5b8tRs+a5CVOHm+1tLP13I
	sX1jnhKlNM52juCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779811555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6nl9BWi2tPkU3zI7N4oxXpL8czPQn+mAF/EXe4tDgo=;
	b=eyzmpKwAsg1tBYx3NpxDbTIh+7fbPy6+/nKD7OBN/RWtCqNKPmnkDaoNkNAwmO9qOV7/gx
	lkjXkLBPoEeSpmFr3kJV5I5BXPWtddqS3py6ry45xL3R9ioaP3oCMkqoIedL6p7QWOtY/V
	DLEvZgsNl1dBCxb1JtTR47yZcLRYDOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779811555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6nl9BWi2tPkU3zI7N4oxXpL8czPQn+mAF/EXe4tDgo=;
	b=YJKsXh+E14xhq0ajVSE8Y0rdjhTZibZwh4Vremw+JwXk9vScyR7yRjuX86f1K3Mz9nV0qW
	zoXY/TQgwxMIZjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E2405A2B8;
	Tue, 26 May 2026 16:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fiBwA+PEFWrgDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 26 May 2026 16:05:55 +0000
Date: Tue, 26 May 2026 18:05:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, 
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, nick.lange@gmail.com, 
	marco.crivellari@suse.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <a276d7fa-8ab1-4cc2-a095-e7e4c060a4ad@flourine.local>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkc91obuuiwe93nwph69c5cft)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,microsemi.com,hansenpartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,linutronix.de,gmail.com,suse.de,nvidia.com,abita.co,ashe.io,suse.com,outlook.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hi Aaron,

On Thu, May 21, 2026 at 07:29:48PM -0400, Aaron Tomlin wrote:
> Please let me know your thoughts.
> 
> 
> Changes since v14:

You’re moving fast with these updates! It’s great energy, but it’s
actually moving a bit faster than the review process can keep up with.
I’ve heard from some folks in the CC that they waiting for a 'final'
version.

Is this latest version ready for a full, deep-dive review, or are there
still a few 'knacks' you’re looking to iron out first?

Thanks,
Daniel
