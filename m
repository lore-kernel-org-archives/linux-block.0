Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2332F616C
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711057; cv=none; b=mlx1WzpbyxoZEwhGueOyavw6N9KLZSpBgoYClGtdAhpjymyZrTptew8X+5LJal7xCA5/004qYj3+qvlWuGNMIzs7zNg4aVQQE4DMYf5oNep3VvwZ1jVapCK8LL+j/U/SrUq0qLyMq+QJrkkHZWFk5MTXuhvEun3caTzytB70cnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711057; c=relaxed/simple;
	bh=nmwT9PdFl6YqpHIMrLm5d2ykpuwlVh57f0Qkw3upFsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7vl3IDyPZ9d3/AeQusQunIthEHPC6f5c1pfISJdDAXjW2ikAB33QZTHMrZFAJCaZx96k+Q4Y7vJnAZy7xvvMwqbI4rpxN8kpSSP9hNkNIKielA/5X/Mq6Bwv5+GtrXhnlwl+i66X0QUhzTUhVqM8QS2w2duKTBmUyfRRjbfW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rzkc1QEG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cD/0121Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=apTtJHgf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0HFFqhLB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rzkc1QEG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cD/0121Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="apTtJHgf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0HFFqhLB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4EC720EAE;
	Fri, 21 Nov 2025 07:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763711054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsCxjeXE1rBrqccQpZvQF/zKGW2+sRbJZgEftDug/HU=;
	b=Rzkc1QEGcYWSAdiUwyBeuPMFMURj+sGKizQ350rvIRkDe1DvSCYem8lVQfVqHVsxRJshqL
	OJ0eB3Am7tynACqKwzVzU29gpsKDaHfWcZLw2/mnMQMxS1sVeu/5dHzDX5J6zm86djganb
	r7zjuG7ZrETl59ub9FgrCU8Jwqr+nU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763711054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsCxjeXE1rBrqccQpZvQF/zKGW2+sRbJZgEftDug/HU=;
	b=cD/0121YKeBxdKcebGgFRa5C1yHihYoV6w4/do1uodBIzFO6zAVJsJRxY2xnvCboB11JaF
	9xEfUwLXqCa3tQBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=apTtJHgf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0HFFqhLB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763711053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsCxjeXE1rBrqccQpZvQF/zKGW2+sRbJZgEftDug/HU=;
	b=apTtJHgfu7m2IWGsDaZSdiBG/2bteprYxcqaxl+9Lbtcrtw6NEgW2hiqCk5cd2sBm9PJFb
	JvHfXfzQ6ozRIdHBSv1Bh5AdUPOFzeSgmGPtjrYJfwi1Ca/RkHB5914dtkgG9igBeOY/fn
	78cNl7xIyNceKz/AdEz3K/GNwroHJ8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763711053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsCxjeXE1rBrqccQpZvQF/zKGW2+sRbJZgEftDug/HU=;
	b=0HFFqhLBnxJo9SZWm8AezDtD2hX3b9WzVddjd57dT1f8ND5zx8ua/BQnNckmbD6yr40NoQ
	GFxOgEqV+FvCaHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66EDE3EA61;
	Fri, 21 Nov 2025 07:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LQMUF00YIGmPEAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Nov 2025 07:44:13 +0000
Message-ID: <e281da57-caa0-4e36-8ff2-80175bc43090@suse.de>
Date: Fri, 21 Nov 2025 08:44:12 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kernel BUG at mm/hugetlb.c:5868! triggered by
 blktests nvme/tcp nvme/029
To: Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <CAHj4cs9Ez5f+SsHMcbYVeKGScuL9vq71i57kRgu2KneRtXRwmw@mail.gmail.com>
 <05281713-80b3-4199-8e76-672e84fcc33e@kernel.dk>
 <CAHj4cs8+Xgz1qgf3H0sDMFhVAmzb9EsVmuJoRLBOgP7bQymodw@mail.gmail.com>
 <CAHj4cs_4-5g5oW-Wx7KwceALy8F-Ku4cxQGMZ88ARpvZN4HRjg@mail.gmail.com>
 <CAHj4cs9AUA94ntY0uhDDAmoWTMA3kxpSCArKG9MHcgkVASJfAg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAHj4cs9AUA94ntY0uhDDAmoWTMA3kxpSCArKG9MHcgkVASJfAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B4EC720EAE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

On 11/20/25 16:18, Yi Zhang wrote:
> I did more testing today, and found that this issue cannot be
> reproduced if I don't set the nr_hugepages
> 
> https://github.com/linux-blktests/blktests/blob/master/tests/nvme/029#L71
> 

But is the inverse also true, namely _can_ you reproduce it when
nr_hugepages is set?

After all, there seems to be an issue with hugepages, so it's not
surprising that we don't see it if we don't use hugepages...

Cheers

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
