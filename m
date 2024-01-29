Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04345BF0
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508830; cv=none; b=Qeg3TMaMNHBThPH5LgCgQT74l7YsklH1U1lv9+nrWV2Q8FQQC42Cv1Wjhpr9Vl1GeiEleXt7B/Zsw+Pj/dnE7Qkx3oWbn+R3n7w7W0ub1GVz1VmGsAt+uEVvOWc8+8D/u07UCA7srxgUCzVtI2U6Xj+xdV8KMV+vPPMFnrnxfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508830; c=relaxed/simple;
	bh=2/P38smWvLPUJ9FvRt6hyg5SW3nTaffVDKY3bLioVfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUze+6ZfZHc4b2IU8KwZkck+ca9uEu5LrBS7REdHDaK4/UnFL3jWEnai/ZRp525sFFZIAS/5gS4P1tq7CWuMlvdjX3nZAS696xdtEUQOalu3mKTCJjlOeK3pS5eegQIqCaCbdeY/htSq5t+xo+NjqVi3U/eEvDHr+/rCJ8KOYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UcEd7+JD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XcS+YpTL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UcEd7+JD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XcS+YpTL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UcEd7+JD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XcS+YpTL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UcEd7+JD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XcS+YpTL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 172141F7D1;
	Mon, 29 Jan 2024 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706508827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=UcEd7+JD/uB/WZz0/uicJfk2EZPIJjWoV3FMQMmTWVXn/8AB52kTnt+Cbw8v8eum8InEI2
	UK0SwcY4R12QHjvBbqMw3rTJTwiJMC5KeF5yF4uRggfn0TvBpfZfXtaH2wpxrh/Ow7K/Va
	b11tjN2HclmH63Wf3ip3gU3MgTvtyAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706508827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=XcS+YpTLW+lg5fh1KoRq3MSnSsBEYFIJnLbrw5PmEC8tgc8HudpSszbpXQuMqyhq8JI/+I
	feqXDg8HCpKrv9Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706508827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=UcEd7+JD/uB/WZz0/uicJfk2EZPIJjWoV3FMQMmTWVXn/8AB52kTnt+Cbw8v8eum8InEI2
	UK0SwcY4R12QHjvBbqMw3rTJTwiJMC5KeF5yF4uRggfn0TvBpfZfXtaH2wpxrh/Ow7K/Va
	b11tjN2HclmH63Wf3ip3gU3MgTvtyAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706508827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=XcS+YpTLW+lg5fh1KoRq3MSnSsBEYFIJnLbrw5PmEC8tgc8HudpSszbpXQuMqyhq8JI/+I
	feqXDg8HCpKrv9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8799F12FF7;
	Mon, 29 Jan 2024 06:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a/i8HhpCt2VyRQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 29 Jan 2024 06:13:46 +0000
Message-ID: <af60faa7-42fc-475a-b28c-cd11fe45d19d@suse.de>
Date: Mon, 29 Jan 2024 07:13:45 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240128165813.3213508-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.70%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.13

On 1/28/24 17:58, Christoph Hellwig wrote:
> Add a new max_user_discard_sectors limit that mirrors max_user_sectors
> and stores the value that the user manually set.  This now allows
> updates of the max_hw_discard_sectors to not worry about the user
> limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c   | 12 +++++++++---
>   block/blk-sysfs.c      | 18 +++++++++---------
>   include/linux/blkdev.h |  1 +
>   3 files changed, 19 insertions(+), 12 deletions(-)
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

