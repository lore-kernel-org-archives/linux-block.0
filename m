Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE72D543A
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710828; cv=none; b=s/oBsvAwtWi5JmVEBlwchejhuSPQDsOaFA60SzSHvHOHUsH5Wo3Qq49v2c1UrDccLXheOq6JIVJ3eu5nw8Cqeklm5seD4BJIdn6nKW76pWYFXyyzhs05sdVZOR8LyINlQvOk8VJprkeA6bxzC4aOy5AZiWNg96e9+67O5npkgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710828; c=relaxed/simple;
	bh=TbmtADMPzDyqStF9rJ3eXXHt1k2MXWg2OQhOsoklBGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMr/cikjCR0kIYx//4W2D2PGR+i5VJbmQsWGJo5bZH2+3FNeDFmJlPXNxg4EdNpmzeP48RIaDQz2OiJSLQkywv8FE5n+U33MMbC6GDn8E/IFb1m/PhwGCLx8/VO9/8guh0+DaM70H9gK9AnMZKZRqmwBU9K5HHnhedwYlbXv0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=omi7LkTu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iB5F3Fi6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bE1pThtW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SWjsWaVL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="omi7LkTu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iB5F3Fi6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bE1pThtW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SWjsWaVL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7C2A21751;
	Fri, 21 Nov 2025 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763710825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mys2BPFJCH5oizFPG/WlAUXda1ThHbvmUvInAZBoBdw=;
	b=omi7LkTugDVxF5Nnukp61nw+FMZQAQaOoqa7XtP78qpNRD4r9Ybzw1OEJ1ACJwGHJwZvfz
	GbZ4OfrrlVFFtGI9x1/ZVYSmotT3oRztURPViibmx+R59DzCqO8dn9a26iNFB2rNYqTpZ6
	4iXjNbrFweo4MulD7cR5Z6YJ4zcsAwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763710825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mys2BPFJCH5oizFPG/WlAUXda1ThHbvmUvInAZBoBdw=;
	b=iB5F3Fi69SHjwYpKR6sFrBbBQooHEkuScpG6axQAjoexyUof27UKiQmpSpnY3lFWI513Pc
	q1+OwmWTquZ1NVCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763710824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mys2BPFJCH5oizFPG/WlAUXda1ThHbvmUvInAZBoBdw=;
	b=bE1pThtWpz2gP4AFcHvq6norUiPPqN5omu6vuBS/9vFaUQOvvscIwzFUXqdvcwFffXjOhw
	sHlWYuMNhuDZYNlPcn3Nl466pZF18hi/BQaKycc5ST4BbsyiteVYHCRqN+kud4X8l4jN9T
	aXLV8mHLz1+OiKZcfI5xkjj8ozJ1xM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763710824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mys2BPFJCH5oizFPG/WlAUXda1ThHbvmUvInAZBoBdw=;
	b=SWjsWaVLit7Wd6GzMWR5aJbdWyoHw5R/GTXC9m5it5fensjPDPJe+sd7trQy3CxRT8uc/+
	szFWrUBHIAElgJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B0C43EA61;
	Fri, 21 Nov 2025 07:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G3i5EGgXIGkkDQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Nov 2025 07:40:24 +0000
Message-ID: <90c06ff6-009f-430a-9b81-ca795e3115b0@suse.de>
Date: Fri, 21 Nov 2025 08:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 1/6] zram: introduce writeback bio batching
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>,
 Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>, Fengyu Lian <licayy@outlook.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
 <20251120152126.3126298-2-senozhatsky@chromium.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251120152126.3126298-2-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[chromium.org,linux-foundation.org,kernel.org,foxmail.com,google.com];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com,outlook.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,outlook.com,vger.kernel.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,foxmail.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/20/25 16:21, Sergey Senozhatsky wrote:
> Currently, zram writeback supports only a single bio writeback
> operation, waiting for bio completion before post-processing
> next pp-slot.  This works, in general, but has certain throughput
> limitations.  Introduce batched (multiple) bio writeback support
> to take advantage of parallel requests processing and better
> requests scheduling.
> 
> For the time being the writeback batch size (maximum number of
> in-flight bio requests) is set to 32 for all devices.  A follow
> up patch adds a writeback_batch_size device attribute, so the
> batch size becomes run-time configurable.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Co-developed-by: Yuwen Chen <ywen.chen@foxmail.com>
> Co-developed-by: Richard Chang <richardycc@google.com>
> Suggested-by: Minchan Kim <minchan@google.com>
> ---
>   drivers/block/zram/zram_drv.c | 366 +++++++++++++++++++++++++++-------
>   1 file changed, 298 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a43074657531..37c1416ac902 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c

[ .. ]

> +static int zram_complete_done_reqs(struct zram *zram,
> +				   struct zram_wb_ctl *wb_ctl)
> +{
> +	struct zram_wb_req *req;
> +	unsigned long flags;
>   	int ret = 0, err;
> -	u32 index;
>   
> -	page = alloc_page(GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> +	while (1) {
> +		spin_lock_irqsave(&wb_ctl->done_lock, flags);
> +		req = list_first_entry_or_null(&wb_ctl->done_reqs,
> +					       struct zram_wb_req, entry);
> +		if (req)
> +			list_del(&req->entry);
> +		spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
> +
> +		if (!req)
> +			break;
> +
> +		err = zram_writeback_complete(zram, req);
> +		if (err)
> +			ret = err;
> +
> +		atomic_dec(&wb_ctl->num_inflight);
> +		release_pp_slot(zram, req->pps);
> +		req->pps = NULL;
> +
 > +		list_add(&req->entry, &wb_ctl->idle_reqs);

Shouldn't this be locked?

> +	}
> +
> +	return ret;
> +}
> +
> +static struct zram_wb_req *zram_select_idle_req(struct zram_wb_ctl *wb_ctl)
> +{
> +	struct zram_wb_req *req;
> +
> +	req = list_first_entry_or_null(&wb_ctl->idle_reqs,
> +				       struct zram_wb_req, entry);
> +	if (req)
> +		list_del(&req->entry);

See above. I think you need to lock this to avoid someone stepping in
here an modify the element under you.

Cheers,
Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
