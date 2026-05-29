Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D730E838
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036589; cv=none; b=so8cnsRKuN9wvxySF9c03FlKQl9naZ83JB4qA0oioD1cbd5LPjAcp3o3sbpVtz5Hk6LdIzmGGd2kPeBA5dJ0Mr+otr+UF0zTaBaV/SY1nSMEGJWkpkA53x8h0UKwDF9IWEfXEzG2Eu11f0utJ4LSO9j9g7gi5lvFTIzvlxVwM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036589; c=relaxed/simple;
	bh=zqjDQMQ83sNXm9fS1eNSruyqGnPRVRs76ZZstt6TcZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFA1eqGtscDnUvfd+LSosGn4husfcAMBg+IyoZzkSEc+AwMO2gUF6ycWsLDRZl3RqkO+qA8jaGX/loOeCfWwX7pV6VReQUwNoURhGW4Hqma9htZXXrmWeE6tqeYuyaC4Cvelkro2vMaM8LqwKstBAm6f3rTVXvwrXBdmPCJW710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XQLW8ih3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XnxjtEGj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XQLW8ih3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XnxjtEGj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XQLW8ih3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XnxjtEGj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XQLW8ih3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XnxjtEGj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EDDA66F47;
	Fri, 29 May 2026 06:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+Dz4QQzf1oYNefLxg4PHL1KawoILMt0T+ZRQcTAek8=;
	b=XQLW8ih3fqdqlBdLZq9Fg0fG53JP77aG7m1wYnPYPCtw+vbJDH37PqKSzF9eEF0wcwq/Uh
	SR0b2clHOM2n4XPNymXgLkxi6FXLjXvofW5C9n6qX8kAmYS6R5itWVeSgnnxdvlGy8gj5T
	Qus09VqgyIdg8pqaKJRbwery1JP4XUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+Dz4QQzf1oYNefLxg4PHL1KawoILMt0T+ZRQcTAek8=;
	b=XnxjtEGjDCS8FNuZy/ZjC4a2k4wNM69hcki9+Kewohd5fiLi3Hxo67LKA88yiyOiQTiwNH
	N+IyTU4XiP3/CdDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+Dz4QQzf1oYNefLxg4PHL1KawoILMt0T+ZRQcTAek8=;
	b=XQLW8ih3fqdqlBdLZq9Fg0fG53JP77aG7m1wYnPYPCtw+vbJDH37PqKSzF9eEF0wcwq/Uh
	SR0b2clHOM2n4XPNymXgLkxi6FXLjXvofW5C9n6qX8kAmYS6R5itWVeSgnnxdvlGy8gj5T
	Qus09VqgyIdg8pqaKJRbwery1JP4XUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+Dz4QQzf1oYNefLxg4PHL1KawoILMt0T+ZRQcTAek8=;
	b=XnxjtEGjDCS8FNuZy/ZjC4a2k4wNM69hcki9+Kewohd5fiLi3Hxo67LKA88yiyOiQTiwNH
	N+IyTU4XiP3/CdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 595C15B1D8;
	Fri, 29 May 2026 06:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cuB8FOozGWppJgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:36:26 +0000
Message-ID: <19881d58-1414-4ef6-ac85-8e95f142f543@suse.de>
Date: Fri, 29 May 2026 08:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] block: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <e4d44af70627b83fedadd9501609a2eec5d21ec3.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e4d44af70627b83fedadd9501609a2eec5d21ec3.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,acm.org:email];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,suse.de:email,suse.de:mid]

On 5/28/26 21:45, Bart Van Assche wrote:
> Now that all block/*.c files have been annotated, enable lock context
> analysis for all these source files.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
