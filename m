Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD06FD8
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722752; cv=none; b=XAkgKs+B+qVyB48E5PGKTsXTb4qAb7X/9Ikj5HabpBFgXvXm0BadwRsIf5cQHXVkpTjv9yA7GT9NKdlyselKvEkpOBlcEhfMzyj3ECrP0rOQvIjsd3A19zpAmx40/xlTeQevs550ETdx4F50UHp/aS9Q/Xko3r4Ftv5Qnxx3xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722752; c=relaxed/simple;
	bh=HtlE9CXm2RrfpyaifobwcUUkH/b2AAtBndUMuNl7CCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+zT8F84ZVhxOpWkP3Q4o6RQZM5e0WVW7YZV4ODhXfxkeO9gE1ew9Eko9L12oNkvKAy6ziJ13Xb2uIcJUOHUoAOUkPsRPBdWMEZF1j5dS+eiI34ac+ioTcdvixdqjfhlj00ZB6mueOGD8DClHE5Ql4um0NHBF+GD/X1z3PprIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b4jzCwwX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZbhrGaJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b4jzCwwX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZbhrGaJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b4jzCwwX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZbhrGaJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b4jzCwwX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZbhrGaJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B21A21BA6;
	Mon, 12 Feb 2024 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707722748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=b4jzCwwXJT7hBC5MnVWhX7Q/yv4WESf8k92tWy5MK+2G8qQfKkVuFWuKVJHBvOTm5RVupE
	eN6kHqoT3thDYHROCCjg9fl6mRyeUVdXLwVwg+JJtVf3fD8rhMq9XtklyD8ESoYS1YAyR4
	J7K3A+dF2vf7c/Ep2LifS1EJ2Gg6XTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707722748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=QZbhrGaJmZwOkg+Kq+2T+4BfrYyA6JWEjFlVT+3K3ooBZTnk+WeML5m0b0e0nK/a8M2awi
	ONI+7IyCasnu0bAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707722748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=b4jzCwwXJT7hBC5MnVWhX7Q/yv4WESf8k92tWy5MK+2G8qQfKkVuFWuKVJHBvOTm5RVupE
	eN6kHqoT3thDYHROCCjg9fl6mRyeUVdXLwVwg+JJtVf3fD8rhMq9XtklyD8ESoYS1YAyR4
	J7K3A+dF2vf7c/Ep2LifS1EJ2Gg6XTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707722748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=QZbhrGaJmZwOkg+Kq+2T+4BfrYyA6JWEjFlVT+3K3ooBZTnk+WeML5m0b0e0nK/a8M2awi
	ONI+7IyCasnu0bAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D67313985;
	Mon, 12 Feb 2024 07:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bM/9DvvHyWVxYgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Feb 2024 07:25:47 +0000
Message-ID: <57d64483-6567-479f-b063-399bed1efb72@suse.de>
Date: Mon, 12 Feb 2024 08:25:46 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] block: decouple blk_set_stacking_limits from
 blk_set_default_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240212064609.1327143-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.24)[72.91%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.33

On 2/12/24 14:45, Christoph Hellwig wrote:
> blk_set_stacking_limits uses very little from blk_set_default_limits.
> Open code these initializations in preparation for rewriting
> blk_set_default_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c | 11 +++++++----
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

