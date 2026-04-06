Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12118AE2
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460143; cv=none; b=CI3K8Dhfgl6sJBAtBIrp08A6nE3p+8tWseeCcFKfNflj90j/jxKbkaVYSXGqZkPs9BjaXONVgHy+315HA2zN14NQOw+k9JR/kJfkRIsiKYhZWo/3nps0HB/wyikn4MeIFe6Gzc2LfZM8KXZ/09SkQtZRvH+/ah3U69xroVbxza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460143; c=relaxed/simple;
	bh=eUX8Cph1zORth5ZRKpKw14JpU7wGmqp36up2RWDN9R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX7RkUZqg8eL7+V/eb096HpDQo4iqGthSyo1ReURUifVKJHmrLHsDrFiUkCfYlMx8SWek35WS7UwFZ1GybOnK6JeKniRI76U92w6xho3MFPC0kFijxtMrvG8u8r9YmnWWhxyjP0Obdfv8a2O/9pq3r8yqMtxrA/flomWjKKBt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QrtFQWIQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c5IRgAfQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WEzZq1L5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sH2Eds67; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QrtFQWIQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c5IRgAfQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WEzZq1L5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sH2Eds67"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E364D5BD28;
	Mon,  6 Apr 2026 07:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775460134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWRft+NUtARNTuNfYPDKwdyPYc5TUAjun2hyj4kISVc=;
	b=QrtFQWIQxCrY0Tf5fPpLD+fIeWLCj8hpA+ESqps2yvAjRn6jkwO2Bt2A2T8VBFVvOHHWRA
	8xH0eRJRLvgc+lMW3EoqiCxGSEJPvs/yYr5lwyPja5EMiLV0rDv/eJ1T1FoRCveyMCvDY9
	8R6U+HT4jb33ulo4aIrOkW9M+PvBLcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775460134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWRft+NUtARNTuNfYPDKwdyPYc5TUAjun2hyj4kISVc=;
	b=c5IRgAfQ/XO23vq4SXq2QUAaJ5eE1MdxL6S3lxUFaVP6VCWyrZyEObrQGFLLBx4QclqCDD
	j1CDoXEf77TMzHCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WEzZq1L5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sH2Eds67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775460133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWRft+NUtARNTuNfYPDKwdyPYc5TUAjun2hyj4kISVc=;
	b=WEzZq1L5vrYSV6kxKFc8w4ul0QEJv1/kVUYt3JNB7Xp1LXfAXLn3ASEPwqsNTCe68hRofq
	mpe2FsKT13nKZL9LA2urZMp5ibAeJ/EgH1tXR3XORJgIQI/5aePRUOE1lZhHI4OQQklZ4g
	PCNf0U+jgqLiZ+X+HeqZv0ejt2d/Y+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775460133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWRft+NUtARNTuNfYPDKwdyPYc5TUAjun2hyj4kISVc=;
	b=sH2Eds67V5HDmraC7gW47vYnnCPQN2eGM35xxRKrQmysAFzSPPDpfULiAz0I0RpOLZ5G1x
	pG3OStxrO+n6IPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 869F24A0B0;
	Mon,  6 Apr 2026 07:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 23AMHiVf02koWgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Apr 2026 07:22:13 +0000
Message-ID: <53aec093-5494-4b4b-a103-bc166381f236@suse.de>
Date: Mon, 6 Apr 2026 09:22:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ublk: reset per-IO canceled flag on each fetch
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 "zhang, the-essence-of-life" <zhangweize9@gmail.com>,
 Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
 <20260405-cancel-v2-1-02d711e643c2@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260405-cancel-v2-1-02d711e643c2@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.972];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[purestorage.com,redhat.com,gmail.com,kernel.dk,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E364D5BD28

On 4/6/26 06:25, Uday Shankar wrote:
> If a ublk server starts recovering devices but dies before issuing fetch
> commands for all IOs, cancellation of the fetch commands that were
> successfully issued may never complete. This is because the per-IO
> canceled flag can remain set even after the fetch for that IO has been
> submitted - the per-IO canceled flags for all IOs in a queue are reset
> together only once all IOs for that queue have been fetched. So if a
> nonempty proper subset of the IOs for a queue are fetched when the ublk
> server dies, the IOs in that subset will never successfully be canceled,
> as their canceled flags remain set, and this prevents ublk_cancel_cmd
> from actually calling io_uring_cmd_done on the commands, despite the
> fact that they are outstanding.
> 
> Fix this by resetting the per-IO cancel flags immediately when each IO
> is fetched instead of waiting for all IOs for the queue (which may never
> happen).
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: zhang, the-essence-of-life <zhangweize9@gmail.com>
> ---
>   drivers/block/ublk_drv.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3ba7da94d31499590a06a8b307ed151919a027cb..92dabeb820344107c9fadfae94396082b933d84e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2916,22 +2916,26 @@ static void ublk_stop_dev(struct ublk_device *ub)
>   	ublk_cancel_dev(ub);
>   }
>   
> +static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
> +{
> +	/* UBLK_IO_FLAG_CANCELED can be cleared now */
> +	spin_lock(&ubq->cancel_lock);
> +	io->flags &= ~UBLK_IO_FLAG_CANCELED;
> +	spin_unlock(&ubq->cancel_lock);
> +}
> +
One wonders why we can't use 'set_bit' here, or, rather,
convert 'flags' usage to set_bit().
The spinlock feels a bit silly as it's now per-io, and one would think
that we don't have concurrent accesses to the same io...

>   /* reset per-queue io flags */
>   static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
>   {
> -	int j;
> -
> -	/* UBLK_IO_FLAG_CANCELED can be cleared now */
>   	spin_lock(&ubq->cancel_lock);
> -	for (j = 0; j < ubq->q_depth; j++)
> -		ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
>   	ubq->canceling = false;
>   	spin_unlock(&ubq->cancel_lock);
>   	ubq->fail_io = false;
>   }
Similar here; as we don't loop anymore, why do we need the spinlock?
Isn't WRITE_ONCE() sufficient here?

>   
>   /* device can only be started after all IOs are ready */
> -static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
> +static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
> +	struct ublk_io *io)
>   	__must_hold(&ub->mutex)
>   {
>   	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
> @@ -2940,6 +2944,7 @@ static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
>   		ub->unprivileged_daemons = true;
>   
>   	ubq->nr_io_ready++;
> +	ublk_reset_io_flags(ubq, io);
>   
>   	/* Check if this specific queue is now fully ready */
>   	if (ublk_queue_ready(ubq)) {
> @@ -3202,7 +3207,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
>   	if (!ret)
>   		ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
>   	if (!ret)
> -		ublk_mark_io_ready(ub, q_id);
> +		ublk_mark_io_ready(ub, q_id, io);
>   	mutex_unlock(&ub->mutex);
>   	return ret;
>   }
> @@ -3610,7 +3615,7 @@ static int ublk_batch_prep_io(struct ublk_queue *ubq,
>   	ublk_io_unlock(io);
>   
>   	if (!ret)
> -		ublk_mark_io_ready(data->ub, ubq->q_id);
> +		ublk_mark_io_ready(data->ub, ubq->q_id, io);
>   
>   	return ret;
>   }
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
