Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CA43CECE
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380159; cv=none; b=t5zFdCP4P6VF8ZIDHrdKAd2vhtGCo1iSsQxQVzBSu2njGJVl053Udk3pJ/pa5S4SBY9EmDNP3ZX+xohyu3w87eSpyzWvJjllW2ZWaI1iYmSn+8HvqmrslAw2M+YroifsLGIP8I/QLMd+8Id7gAlJrG96+AyfTOHjJQwaPub0zRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380159; c=relaxed/simple;
	bh=Xw6JrOW4oIynUFKatYAcJ+5so1pJMukCsL4il7OGdZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLlDl7QAuQ9LkYzEHHL37Rw7NdpvlXckL3bXZeYXiDUkULGXVZoSE0lm0uYhNuAWtM+7rnaJLOpGh6H67rmxAzGeZhl/kWDCILubpPFlhCfPfMaXxnmiSh46jWQT4YF7SJBTcbPse4VeCChcmIwnf+XMkmu1CKUHE/snVRJYCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LrJiEgzC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GHCvsexU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LrJiEgzC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GHCvsexU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LrJiEgzC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHCvsexU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LrJiEgzC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHCvsexU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C5705BD4C;
	Tue, 28 Apr 2026 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=LrJiEgzCHMQlHEynELA54lTWCczrINwWICqMzGFTArcFe6uLWsABVGzVUyvGUVsVGqJVD7
	8p2ziuBY2+ZmoB0ZRgVjB3Hy2bT6jRb2sRNhRmSvcCYJxHczIe2EV8joo22r51tP90yU7O
	cDViJJHNjmPWoemIzFxPSu5Ipna7f+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=GHCvsexUbM1Bm+j+FjdUPu5y+/sAaROl1OXHSagBKGAIBY69z8s5IGw9KgXwqXeJZ3NjLG
	x3VEw9Nrk8E/kxAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=LrJiEgzCHMQlHEynELA54lTWCczrINwWICqMzGFTArcFe6uLWsABVGzVUyvGUVsVGqJVD7
	8p2ziuBY2+ZmoB0ZRgVjB3Hy2bT6jRb2sRNhRmSvcCYJxHczIe2EV8joo22r51tP90yU7O
	cDViJJHNjmPWoemIzFxPSu5Ipna7f+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=GHCvsexUbM1Bm+j+FjdUPu5y+/sAaROl1OXHSagBKGAIBY69z8s5IGw9KgXwqXeJZ3NjLG
	x3VEw9Nrk8E/kxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B878593B0;
	Tue, 28 Apr 2026 12:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7UaZATWr8Gm6PAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 28 Apr 2026 12:42:29 +0000
Date: Tue, 28 Apr 2026 14:42:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Message-ID: <328010ad-0d56-4f5e-a37a-e25914da08b5@flourine.local>
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
 <655129a4-de84-4c10-9e55-f75143684b7c@flourine.local>
 <2512cec3-31a8-4703-a50e-85289c860d25@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2512cec3-31a8-4703-a50e-85289c860d25@oracle.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Mon, Apr 27, 2026 at 01:51:17PM +0100, John Garry wrote:
> However some of what we want to test is still based on timing - for example,
> if we set delayed removal timeout to X seconds, we want to ensure that the
> gendisk is gone after X seconds. So we need the X second delay. Currently X
> is 10, but can shorten that.
> 
> sound ok?

Sure, that's sounds reasonable.

For the gendisk removal case, I'd suggest to monitor if the disk goes
away within in a time limit instead of a simple sleep and then test. A
busy system might take slightly longer than usual. The time limit can
then be really high.
