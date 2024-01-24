Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF59F51B
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077338; cv=none; b=IGOGm3nPhLrzIEC1NfQA7Q4nrXqZXdCKE8b3JQ3bK8g3LaHfBuWHfsWHxoOOVF+ydiBcnVjoR7O6zwEiERQCGqU4h/nAYT6b3CTWwn17FutZClZ9jsiOrg3SS9dN79emwnpLA6W2VlQg5s745bxG8kw4KlQbjmrNPm59VCoHnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077338; c=relaxed/simple;
	bh=+lQUL7x4CPANCLqQZ8PyIRNSQuMXLnDjUqBu6S44uCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0Vv2M1MMPVLE3XMP+uIqGMQUteF7MQJkdK6+hD9TmZj+cb2gKMgdbRg5cXaR7h9zrg3iOW0S7CXG5qqzR3S16ZMip+wQGU1AQf5SwE7o18UVwjQa7FZ9NJqiMZ5pTGEcy0berkpMJBiif6Nm8MZryIccBZGv0Jv3Th9P/7NIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ely5o043; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=885pKEiK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ely5o043; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=885pKEiK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ely5o043";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="885pKEiK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ely5o043";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="885pKEiK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 963191F7DA;
	Wed, 24 Jan 2024 06:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdTG//UURW0Tm76K8/pHUSRYv3J6daCmoACYCnPbnFY=;
	b=ely5o043kg9frOcS7rjIIngVngLw7CJ+yYMVoBKqPb8/IYB74KrtBwjXKwjo0xXXdfZnHj
	VdFnzq9nDqJnkExOd1emuL9IaE3ovi59icRjHe4ScSaJ6xHbyztaPsD9JjTzpV6V8qlZgs
	/INVX10rwkF3IBtq75ExniYQKnwvDDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdTG//UURW0Tm76K8/pHUSRYv3J6daCmoACYCnPbnFY=;
	b=885pKEiKioWVwHjjCJ2hv1Z+3IGoNVmjCDfWfdkM+aw/UY9GRw9HkvVSmLammMAmsRk9M0
	zyf1ikcPDE12t7Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdTG//UURW0Tm76K8/pHUSRYv3J6daCmoACYCnPbnFY=;
	b=ely5o043kg9frOcS7rjIIngVngLw7CJ+yYMVoBKqPb8/IYB74KrtBwjXKwjo0xXXdfZnHj
	VdFnzq9nDqJnkExOd1emuL9IaE3ovi59icRjHe4ScSaJ6xHbyztaPsD9JjTzpV6V8qlZgs
	/INVX10rwkF3IBtq75ExniYQKnwvDDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdTG//UURW0Tm76K8/pHUSRYv3J6daCmoACYCnPbnFY=;
	b=885pKEiKioWVwHjjCJ2hv1Z+3IGoNVmjCDfWfdkM+aw/UY9GRw9HkvVSmLammMAmsRk9M0
	zyf1ikcPDE12t7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDB4D1333E;
	Wed, 24 Jan 2024 06:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oKw0LpassGWZSQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:22:14 +0000
Message-ID: <6358ced3-a44a-4c08-aa32-4f3276562042@suse.de>
Date: Wed, 24 Jan 2024 07:22:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] loop: pass queue_limits to blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-15-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ely5o043;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=885pKEiK
X-Spamd-Result: default: False [-2.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.04)[87.60%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 963191F7DA
X-Spam-Level: 
X-Spam-Score: -2.84
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Pass the max_hw_sector limit loop sets at initialization time directly to
> blk_mq_alloc_disk instead of updating it right after the allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/loop.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
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

