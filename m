Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1412DDB1;
	Tue,  6 Feb 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210309; cv=none; b=bqFz9E4YKIvXSfIHUXugptQH8quDIdmFBwHUKOfbO4Ncsg6qL4Yi+AdjBL4Jzt71KjTo/N+R5uJojvAU2vhHWjMvuJd3p+1b8+LC9VGOcH6i/ZckxZPVQ3fsYjUiftGxx+qxEQgtc/7j0hSCxo1pvIQXp6wemM+RtIAIK09RqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210309; c=relaxed/simple;
	bh=6Cn0EbvAQpVPxlCuWBtkPBkK6X11iXgtuISc1ez4iNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suS3rMbf2gFnvJ2gJjTiITMfMkGrqOj3fVG8b41xl38vCK/RPGUZhWfnMX8QlpEqpdzCA5muVleLVZ5jh9l4JVfdeWSO4pr64Xr6c4WzOfdGTNjaKn7f0/35y0yBV/r8HWhu/HRu+O+ZWTcDgdyXRP6tnfM+2WFDsK7GGTpBE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e8BoFuj8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gyjZ5CMm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsqeBWwp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+O2acdkp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e8BoFuj8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gyjZ5CMm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsqeBWwp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+O2acdkp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDEDA221BC;
	Tue,  6 Feb 2024 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707210300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtfFhp4YaOA3+zKQ2nkJ0A0u4dH5KkXGPgSkUaEbRbc=;
	b=e8BoFuj8Y32yDAcZu89DwmhASVI2IYPtMNLQ8K+g0sVpo//lIFRDVElNfF1iqBcAzUF24W
	X2afMENAc3iArMNMdIjlTCvwlkhzht8hhhoEzAV1jUZVOI0jYL2aHsHkXtk8M4Ipkfjtd1
	nGZlsHxPY02mlWj050GaGZjYSti4cpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707210300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtfFhp4YaOA3+zKQ2nkJ0A0u4dH5KkXGPgSkUaEbRbc=;
	b=gyjZ5CMmpelXCeV4s4Bihp8OnxXNQND+VhtGptzbKY9r04T5c6pxLDjDJUeZmfNyUvorbp
	Hd6VS+w9Np+0uTBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707210299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtfFhp4YaOA3+zKQ2nkJ0A0u4dH5KkXGPgSkUaEbRbc=;
	b=NsqeBWwpogJSa2imSjXlenOidfPomNHfVp+m+VnnlwvWYV2wITrCgdjoJLX5h3lpZmOFV/
	PhTYwMMwyrpdgOlIL3t5aBGOD1jxd3Qn4+cxSZKG/VWlZSCa5xDH0PzBgXKaVvj4YA6lzo
	nHUSog9XMgbCT1IKhazeKIU+o24gzGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707210299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtfFhp4YaOA3+zKQ2nkJ0A0u4dH5KkXGPgSkUaEbRbc=;
	b=+O2acdkpJpUE1XXLUjpc4zDVHaBixm5HU+aDEOntfhoUSbq3dL7vP6cK6soQTjD3BkwQ+3
	UoSN3qKer2noQACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0764132DD;
	Tue,  6 Feb 2024 09:04:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zfPENjv2wWWlZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Feb 2024 09:04:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C9CEA0809; Tue,  6 Feb 2024 10:04:59 +0100 (CET)
Date: Tue, 6 Feb 2024 10:04:59 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH] blk-wbt: Fix detection of dirty-throttled tasks
Message-ID: <20240206090459.6a6qpb6lug3nw57g@quack3>
References: <20240123175826.21452-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123175826.21452-1-jack@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 23-01-24 18:58:26, Jan Kara wrote:
> The detection of dirty-throttled tasks in blk-wbt has been subtly broken
> since its beginning in 2016. Namely if we are doing cgroup writeback and
> the throttled task is not in the root cgroup, balance_dirty_pages() will
> set dirty_sleep for the non-root bdi_writeback structure. However
> blk-wbt checks dirty_sleep only in the root cgroup bdi_writeback
> structure. Thus detection of recently throttled tasks is not working in
> this case (we noticed this when we switched to cgroup v2 and suddently
> writeback was slow).
> 
> Since blk-wbt has no easy way to get to proper bdi_writeback and
> furthermore its intention has always been to work on the whole device
> rather than on individual cgroups, just move the dirty_sleep timestamp
> from bdi_writeback to backing_dev_info. That fixes the checking for
> recently throttled task and saves memory for everybody as a bonus.
> 
> CC: stable@vger.kernel.org
> Fixes: b57d74aff9ab ("writeback: track if we're sleeping on progress in balance_dirty_pages()")
> Signed-off-by: Jan Kara <jack@suse.cz>

Ping Jens?

								Honza

> ---
>  block/blk-wbt.c                  | 4 ++--
>  include/linux/backing-dev-defs.h | 7 +++++--
>  mm/backing-dev.c                 | 2 +-
>  mm/page-writeback.c              | 2 +-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 5ba3cd574eac..0c0e270a8265 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -163,9 +163,9 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
>   */
>  static bool wb_recent_wait(struct rq_wb *rwb)
>  {
> -	struct bdi_writeback *wb = &rwb->rqos.disk->bdi->wb;
> +	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
>  
> -	return time_before(jiffies, wb->dirty_sleep + HZ);
> +	return time_before(jiffies, bdi->last_bdp_sleep + HZ);
>  }
>  
>  static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb,
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index ae12696ec492..ad17739a2e72 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -141,8 +141,6 @@ struct bdi_writeback {
>  	struct delayed_work dwork;	/* work item used for writeback */
>  	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
>  
> -	unsigned long dirty_sleep;	/* last wait */
> -
>  	struct list_head bdi_node;	/* anchored at bdi->wb_list */
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -179,6 +177,11 @@ struct backing_dev_info {
>  	 * any dirty wbs, which is depended upon by bdi_has_dirty().
>  	 */
>  	atomic_long_t tot_write_bandwidth;
> +	/*
> +	 * Jiffies when last process was dirty throttled on this bdi. Used by
> + 	 * blk-wbt.
> +	*/
> +	unsigned long last_bdp_sleep;
>  
>  	struct bdi_writeback wb;  /* the root writeback info for this bdi */
>  	struct list_head wb_list; /* list of all wbs */
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 1e3447bccdb1..e039d05304dd 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -436,7 +436,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  	INIT_LIST_HEAD(&wb->work_list);
>  	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
>  	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
> -	wb->dirty_sleep = jiffies;
>  
>  	err = fprop_local_init_percpu(&wb->completions, gfp);
>  	if (err)
> @@ -921,6 +920,7 @@ int bdi_init(struct backing_dev_info *bdi)
>  	INIT_LIST_HEAD(&bdi->bdi_list);
>  	INIT_LIST_HEAD(&bdi->wb_list);
>  	init_waitqueue_head(&bdi->wb_waitq);
> +	bdi->last_bdp_sleep = jiffies;
>  
>  	return cgwb_bdi_init(bdi);
>  }
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index cd4e4ae77c40..cc37fa7f3364 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1921,7 +1921,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  			break;
>  		}
>  		__set_current_state(TASK_KILLABLE);
> -		wb->dirty_sleep = now;
> +		bdi->last_bdp_sleep = jiffies;
>  		io_schedule_timeout(pause);
>  
>  		current->dirty_paused_when = now + pause;
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
