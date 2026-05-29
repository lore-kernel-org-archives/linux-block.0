Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5D343893
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035836; cv=none; b=udqKG/GQ1YXcJcOIjTPj8i0lEqn1GiSW1udvkdAypLxQE6bB8xDYHNxeBIvpD7SNelRVdYJXUwL1ulAVbVovILEjHUYaKDeH9DIU59YXuJiNfd/tqp38amKKh+QKuZRx/N7JOX5BugDVm5ttcUZedSSRh4kGfj1iDsURQ+zmw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035836; c=relaxed/simple;
	bh=EhPcis2lkoPShzVQXQW+q3B5nw8UD4DJfhY5CItjB5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9/8LBbRWIqkO9CTC6PCOcC635Me22j1M1ZiuvTDe0zc/VM4MVGNbbvcb5O50k7Zjj/a8ZzXyfqm1B9EEHyQQ31qt2XwZtYLALQun3XzC9vBTRjD72BfscSqPm6qS499y/iCSFblfxS2In7xbZKBz5lCCzt5YLyvJVuHBRjzeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dCGWw9qo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O1ToWnqb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dCGWw9qo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O1ToWnqb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dCGWw9qo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O1ToWnqb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dCGWw9qo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O1ToWnqb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9360C6AB98;
	Fri, 29 May 2026 06:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/4TIgEjyZ0CtdAvBxzQ0LRAtzK6IDYNJ1S+d/9qD6s=;
	b=dCGWw9qoNkmdyIc/1e8OfPeV3RNbvAjiu4VrkrsXZnhtEr01OyQAE/569dCbWmMECocHAj
	lR06kXrIg5WsRF2K6a6pAAN4VQzVqMyblHCTo6JTKTEKrrulcLGKl1eCiXvPcfsElVj1o/
	z0yHEEmqA9hvFQC8gAFDVgI9Uk26aYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/4TIgEjyZ0CtdAvBxzQ0LRAtzK6IDYNJ1S+d/9qD6s=;
	b=O1ToWnqbEzHHZOjreU2phi7HOgIN9gKJtngAWctgoPaRc0ypqAYx1viVsF8n5WAJum9Zk5
	AKKFKY9e6pvqoXCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/4TIgEjyZ0CtdAvBxzQ0LRAtzK6IDYNJ1S+d/9qD6s=;
	b=dCGWw9qoNkmdyIc/1e8OfPeV3RNbvAjiu4VrkrsXZnhtEr01OyQAE/569dCbWmMECocHAj
	lR06kXrIg5WsRF2K6a6pAAN4VQzVqMyblHCTo6JTKTEKrrulcLGKl1eCiXvPcfsElVj1o/
	z0yHEEmqA9hvFQC8gAFDVgI9Uk26aYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/4TIgEjyZ0CtdAvBxzQ0LRAtzK6IDYNJ1S+d/9qD6s=;
	b=O1ToWnqbEzHHZOjreU2phi7HOgIN9gKJtngAWctgoPaRc0ypqAYx1viVsF8n5WAJum9Zk5
	AKKFKY9e6pvqoXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DD3B5B1CC;
	Fri, 29 May 2026 06:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vFmJGfkwGWqKGgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:23:53 +0000
Message-ID: <f38b2d16-f40c-4d24-8a43-8c1e9374038c@suse.de>
Date: Fri, 29 May 2026 08:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] block: Annotate the queue limits functions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <ecdb2e97d3824a64292be86eacdf87684cc9af85.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ecdb2e97d3824a64292be86eacdf87684cc9af85.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,lst.de:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/28/26 21:45, Bart Van Assche wrote:
> Let the thread-safety checker verify whether every start of a queue
> limits update is followed by a call to a function that finishes a queue
> limits update.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/linux/blkdev.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
