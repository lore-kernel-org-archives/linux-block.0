Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2519467
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558414; cv=none; b=N7Ex3FMtMTVSdmBy1sH/pA6Zy+U28VpQkC6Sa5UctYnfYBVBhp8CVRCmcpaMZWFipuEduhSThLg40uej7IIl/6+Rg8NUqtkIap5IqaOXroFFlTmbgHBIysCqjCR4uP88iJxLK/fjqY3lz6IPfqun/MWrz8MbilfcpHFrvgL5jQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558414; c=relaxed/simple;
	bh=QXkc6ICjU3udzzx+eJ8q0NWKxcGr/kWxtTrWIwyAzCQ=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Level:
	 X-Spam-Score:X-Spamd-Result:X-Spam-Flag; b=K6XLvKWVtiRB+z3jE/RTJ7QgO/aRaXJsaLUDjGZrZU5BDgVeB2Pn0CR0bAS6b1ka5DcgOjzAXx4BkLW9vdm71hVhS552bL1B3yTb8QnqKbK9pbC8E1uvlCkujCPHcNvcYDuBrEXi0SW3rao+KUtRHmCVKbTHC+zAV2ZLb5FWhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qDd1ExSb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CogyaDWY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iz2GHY7d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M+2Eokzc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qDd1ExSb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CogyaDWY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iz2GHY7d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M+2Eokzc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF7061F461;
	Thu, 18 Jan 2024 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705558409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd8+L+8Yu0wsGCdgXw69NN+YaaLD4Hry2qPw8jaVvHw=;
	b=qDd1ExSbzEgMI7eLbdHII6NfWVLRpUDtoqTdFuP/0+f7pFSmBlDWHYJzq6NB4B1yq6OYca
	Ze5Q7SEVTqxxygtyeJw83oM6TqGTpyt6kgGqo7RracjYcp86Lgn0EWNNy+T0oZlgX1QR4L
	a3Li7yGWtELMMGZIkCi5UiG580L31CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705558409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd8+L+8Yu0wsGCdgXw69NN+YaaLD4Hry2qPw8jaVvHw=;
	b=CogyaDWYSMO7YgYwcnZFCQ1D8hjLVc/3gWvP+rGrPLelD0BucetU+4diPVe4V1ZgKaUpXt
	QoGmSPxpMGkfLfBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705558407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd8+L+8Yu0wsGCdgXw69NN+YaaLD4Hry2qPw8jaVvHw=;
	b=Iz2GHY7deR7xmA8F0FB9caeJp71wR5AiooMbosGK/XJ0+7XbwtRLvkRC8hSuh8C1PNN4om
	hJUhxSLzwlEDTvXZNbfkUt06gS22Q0AE86IbDzhHTTN+1pmFOi//a/qI/sCZiZpHAyDwue
	bDen7v2nQGZ6arp/zXAW90cDaWto3rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705558407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd8+L+8Yu0wsGCdgXw69NN+YaaLD4Hry2qPw8jaVvHw=;
	b=M+2EokzcjSp3if3RM3H6qaIShwcwsGfTceIRuZ/GN5mJGEOnWkRkS4Mgt0puyilODzjeb+
	hQVtvTY5AtKFN2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E49F136F5;
	Thu, 18 Jan 2024 06:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J7yOIIfBqGVPAwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jan 2024 06:13:27 +0000
Message-ID: <a3b8e644-0085-494f-a16f-f1ee11ddf1cb@suse.de>
Date: Thu, 18 Jan 2024 07:13:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Remove the hctx 'run' debugfs attribute
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Gabriel Ryan <gabe@cs.columbia.edu>
References: <20240117203609.4122520-1-bvanassche@acm.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240117203609.4122520-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.89
X-Spamd-Result: default: False [-1.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.60)[81.83%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,columbia.edu:email,acm.org:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 1/17/24 21:36, Bart Van Assche wrote:
> Nobody uses the debugfs hctx 'run' attribute. Hence remove this
> attribute and also the code that updates the corresponding member
> variable.
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Cc: Gabriel Ryan <gabe@cs.columbia.edu>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-debugfs.c | 18 ------------------
>   block/blk-mq-sched.c   |  2 --
>   include/linux/blk-mq.h |  3 ---
>   3 files changed, 23 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

