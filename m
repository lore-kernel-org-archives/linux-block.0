Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF415A791
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413767; cv=none; b=aAgbNjzCqLemC2jN6bC3NavZBKnFTDN7LYhjAl6mIdRidO62L69dB+3b+2dmku6jMbs5JUbRj/bgMYX1UxdjjJxG4UbqZpZl0SQB/5nd8YEqRIiggmngfMlBlZHj7gAKQxQsZwGCes/fh5TS8Box2nHC3pfBrHPa3cv2v61E/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413767; c=relaxed/simple;
	bh=z6fQ1d1ptnzXM/nfrz8/P0pH/GQdGdoK2ItK2uLdLBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJJybqNg6dFdoDuw1hM/bbA3k6MJV9CKOwBDCTylWBr0DWw/HJcafn9U1TrzhmHK+y7+ZJuf3XCcRs6C46WRDjoYL0htCkiV8CeE59H/8uUB2g0vs/ZtqjcfWeyXGS52z0AtspvyQisJxoMZSflOt6XL8XLOuib+9fSlnEp/YEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eaz4fksE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bH10qrIL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eaz4fksE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bH10qrIL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eaz4fksE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bH10qrIL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eaz4fksE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bH10qrIL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7AE51F850;
	Tue, 20 Feb 2024 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Nc2n6CStQcdiGFJyyVVyZNn6auAJVQMW0BFqHIGWow=;
	b=Eaz4fksEg2vSs8d774BZ2YmvgLD+aIZPkiy95NNjHT5f0WU5XXzbTbys3ng3xjS4xE4fCD
	UKZLsmkoeRJ5pcOpt5DXbmacATq7PwUBUnv/hAQ0anJMRe4vtDP8Y0Fs1Q2OeI5FTXMzG0
	wGy7+B9ElA3Q3b66+1Eya66ZQTCIi3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Nc2n6CStQcdiGFJyyVVyZNn6auAJVQMW0BFqHIGWow=;
	b=bH10qrIL4NqpdBl7H0wUYUXYHWAR+GLH2cnspbSJPe1NNssDUalzHwzjQSIP1oKfij4aXx
	IWznJwEpqLQ4/cDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Nc2n6CStQcdiGFJyyVVyZNn6auAJVQMW0BFqHIGWow=;
	b=Eaz4fksEg2vSs8d774BZ2YmvgLD+aIZPkiy95NNjHT5f0WU5XXzbTbys3ng3xjS4xE4fCD
	UKZLsmkoeRJ5pcOpt5DXbmacATq7PwUBUnv/hAQ0anJMRe4vtDP8Y0Fs1Q2OeI5FTXMzG0
	wGy7+B9ElA3Q3b66+1Eya66ZQTCIi3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Nc2n6CStQcdiGFJyyVVyZNn6auAJVQMW0BFqHIGWow=;
	b=bH10qrIL4NqpdBl7H0wUYUXYHWAR+GLH2cnspbSJPe1NNssDUalzHwzjQSIP1oKfij4aXx
	IWznJwEpqLQ4/cDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5804D134E4;
	Tue, 20 Feb 2024 07:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGQfEURT1GUpRQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 07:22:44 +0000
Message-ID: <c7f5fa32-2100-4d6a-8357-004629b9449e@suse.de>
Date: Tue, 20 Feb 2024 08:22:43 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] null_blk: remove null_gendisk_register
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240220053303.3211004-1-hch@lst.de>
 <20240220053303.3211004-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240220053303.3211004-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Eaz4fksE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bH10qrIL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.90)[99.58%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,lst.de:email,wdc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.40
X-Rspamd-Queue-Id: A7AE51F850
X-Spam-Flag: NO

On 2/20/24 06:33, Christoph Hellwig wrote:
> null_gendisk_register isn't a very useful abstraction given that it
> doesn't even allocate the gendisk.  Merge it into the only caller
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c | 41 ++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 25 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

