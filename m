Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16684197A76
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562941; cv=none; b=I9eVFPC4uZ8Q8uGR75vaai/8l+yLjdx3LHVuy4FN9wdOoEWXk6Y8AGgx0HO03CAyuFm4e2t1YC2zfPuVIQIdHmwJ4RUEb4t+oUgf3SQRAEzqTyze2OegN3kVnhUWwRqtAQouDAstAY43xppnrrgW/k4jikw7Fouew0nvuJGeNJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562941; c=relaxed/simple;
	bh=KDslSu05lJ4w+n22byDm4oY+NolR27PcY+RtotVCcWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBurZ50iGWUUwDn0ZQ1suAysAuo2JOrq02l3pJNg3gH1Yy/SURiSQE3taOp3TJP/QILFTHZ/y91zG4DzOPNXFmXwU0f2McbZpEYHjcX0uAkzxEQgXTHqimUsOM4jp/sW+FvGpXW6rgrBZAlJ6ODY2maUXuIGfLrVnaBM0OxXqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sx42cjN0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ABZLscAJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sx42cjN0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ABZLscAJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sx42cjN0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABZLscAJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sx42cjN0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABZLscAJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1857321174;
	Fri, 25 Apr 2025 06:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+L70/L7FLd1g1c8L3xaxlm6IqcIj8osAVA/gocHN7w=;
	b=sx42cjN0d/lGltE4ZZLUwwvtkiGri1R7sFOt7nxaL0lTMdJjXs4IXeslJtBQZNWw6ygGP0
	BjQaR8zgmypTxqJQmp0bcO9Mo9l9cCo9iDn2Nk5Af+ji32JfG2h+p6qKSpU3b+nwExe42P
	YlIgT0nUGyBGCSvxgmloA4kWljjZeOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+L70/L7FLd1g1c8L3xaxlm6IqcIj8osAVA/gocHN7w=;
	b=ABZLscAJ8twQoQCSUszXG3j29uXle+OfyuBabnw5kRuo0Jbp5k+sRJLXjc6yTDXuN75rX4
	CFNIdZZB2X4vwLDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sx42cjN0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ABZLscAJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+L70/L7FLd1g1c8L3xaxlm6IqcIj8osAVA/gocHN7w=;
	b=sx42cjN0d/lGltE4ZZLUwwvtkiGri1R7sFOt7nxaL0lTMdJjXs4IXeslJtBQZNWw6ygGP0
	BjQaR8zgmypTxqJQmp0bcO9Mo9l9cCo9iDn2Nk5Af+ji32JfG2h+p6qKSpU3b+nwExe42P
	YlIgT0nUGyBGCSvxgmloA4kWljjZeOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+L70/L7FLd1g1c8L3xaxlm6IqcIj8osAVA/gocHN7w=;
	b=ABZLscAJ8twQoQCSUszXG3j29uXle+OfyuBabnw5kRuo0Jbp5k+sRJLXjc6yTDXuN75rX4
	CFNIdZZB2X4vwLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4AFB13A80;
	Fri, 25 Apr 2025 06:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6dJaLjktC2jjYAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:35:37 +0000
Message-ID: <b1a92b00-f593-4500-be51-ca6c10973399@suse.de>
Date: Fri, 25 Apr 2025 08:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/20] block: move blk_unregister_queue() &
 device_del() after freeze wait
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-11-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1857321174
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/24/25 17:21, Ming Lei wrote:
> Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> for unifying elevator switch.
> 
> This way is just fine, since bdev has been unhashed at the beginning of
> del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> with kobject & debugfs thing only.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/genhd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
