Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A541A08A6
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291287; cv=none; b=N31yZK8saV8DG7rDr2qf18dWuofJ2LEios70hPZVNyyvIgJHBtR2V4f9BILb5HeVBm9nlh30XDMgO+oG10eKHoBkqkHlhN39scDBwf9/1ktCdh0JvVQCGdF8Cw1AVjAvZq3DdI/crX7v/kRYu2PRnFWk+uHQFvFBXHuxpXurSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291287; c=relaxed/simple;
	bh=EpbpJiu91CIIapTwXSIIxqqxpRcKM/sfKNVXWpD0YMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nB8LHEUcjSG8AR7kvEJPG1yNjoxw3bZHf78IZFwlkqaPZUyKuKIbUIG/bbWxt2PkFnPB09aw9iGPyyCEhPeZiGv1rajpESzhvB1oRtEi2Wv3KTTNV0mUpx9Egkg5tnLHFM3bL33erYbgy9LbqXueQtKvDIducDwKhyW0ShMj8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HDK2kP3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cj9zeO2N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HDK2kP3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cj9zeO2N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDK2kP3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cj9zeO2N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDK2kP3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cj9zeO2N"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 111B61F387;
	Mon,  4 Aug 2025 07:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRmDLYuO/hHeJLB5MJYngN3fxC8z/j+BKze3kSO0VXg=;
	b=HDK2kP3OLRFrfdYqddReJ4f4+s06dluziBnQu0cy2iAnn2dpt7AuT+s/ZORzi5QmRkGuzE
	+vJkX0kPtBpITZJSIigIpGpA7c2W8f0pCZaCMX0GYIIfXtDLYImkpwEZaigkRdrhT5YrMZ
	Sma8xW/Tv+5+Az/BycRJnIy6QV4wcEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRmDLYuO/hHeJLB5MJYngN3fxC8z/j+BKze3kSO0VXg=;
	b=Cj9zeO2NC2duO7gfOFoMtVJ97/1JOTczPQI5r9i0ZNaKRTZfiIRXEJU0/rhdzHKERBt8lE
	fMZLW2rGBlt81gAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HDK2kP3O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Cj9zeO2N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRmDLYuO/hHeJLB5MJYngN3fxC8z/j+BKze3kSO0VXg=;
	b=HDK2kP3OLRFrfdYqddReJ4f4+s06dluziBnQu0cy2iAnn2dpt7AuT+s/ZORzi5QmRkGuzE
	+vJkX0kPtBpITZJSIigIpGpA7c2W8f0pCZaCMX0GYIIfXtDLYImkpwEZaigkRdrhT5YrMZ
	Sma8xW/Tv+5+Az/BycRJnIy6QV4wcEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRmDLYuO/hHeJLB5MJYngN3fxC8z/j+BKze3kSO0VXg=;
	b=Cj9zeO2NC2duO7gfOFoMtVJ97/1JOTczPQI5r9i0ZNaKRTZfiIRXEJU0/rhdzHKERBt8lE
	fMZLW2rGBlt81gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4D4F13A7E;
	Mon,  4 Aug 2025 07:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VXw3LlNckGjVUwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 07:08:03 +0000
Message-ID: <d79dd71a-9848-4598-8c6c-fdde36c81458@suse.de>
Date: Mon, 4 Aug 2025 09:08:03 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] blk-mq: Pass tag_set to blk_mq_free_rq_map/tags
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>, John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-3-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801114440.722286-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 111B61F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/1/25 13:44, Ming Lei wrote:
> To prepare for converting the tag->rqs freeing to be SRCU-based, the
> tag_set is needed in the freeing helper functions.
> 
> This patch adds 'struct blk_mq_tag_set *' as the first parameter to
> blk_mq_free_rq_map() and blk_mq_free_tags(), and updates all their call
> sites.
> 
> This allows access to the tag_set's SRCU structure in the next step,
> which will be used to free the tag maps after a grace period.
> 
> No functional change is intended in this patch.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sched.c |  4 ++--
>   block/blk-mq-tag.c   |  2 +-
>   block/blk-mq.c       | 10 +++++-----
>   block/blk-mq.h       |  4 ++--
>   4 files changed, 10 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
