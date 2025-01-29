Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606B6A33F
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738133446; cv=none; b=MG5gsoGYW7k6Vzop3cAiWzDggmlr9NMkGpCH0G1x/FslZL/4FCCEcxeRB1g9jjwg/dBEHpY+hDrJz67k+4NKVJvl19w7ljajsdQfhiX+N5NZVpNSKXWn2K2Ut7mvjhYsyKu1WkX2z7eXy/45qSvf8qscGbU7ZrTPGtqXIjasVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738133446; c=relaxed/simple;
	bh=xgTSq2JlhkTOaz11dogGhiqoj5D5cvZvqXUpapmMCMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gy64jkmxQ3AjkQkgih18EHu5wMmTU3vYtuETkf8A8OgkRQVggroWkBDhFuXlKP+RGGk59NSeuZ5xfPOfwwQKYXroexmA+bYvzxn4y93hbPKXMougyFTPTyCOUw78xlpPhbzhx/Ps5TukOt8w/VrM5phj6XmZyXI8JICCAdDChuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gwRPflJZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=alsxOHyH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mm/vaLWA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aoiW+qMG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gwRPflJZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="alsxOHyH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mm/vaLWA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aoiW+qMG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0F101F365;
	Wed, 29 Jan 2025 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738133443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jflj/Hl4NND7Ez5JujtDQBq0KgLjP09am4mlWD/p610=;
	b=gwRPflJZLlSuR35O4giVhfdOdvp+ZvkrFQfp+I5Tl+9EdgUZux4afes1lxiMwwJqC755Qr
	kS59+oSQuoiOIQr5oc7mlnd+nVFJ0/+OZt3Tm8lZKlni7XmDWh4XonbWM14wcCtmB0ethG
	Re3BjRdu2bkAinpue7u45oUVo6MdZB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738133443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jflj/Hl4NND7Ez5JujtDQBq0KgLjP09am4mlWD/p610=;
	b=alsxOHyH38k8yLCo17C4THJFE9QdSKLSZPqgF+DH2Dk7gKvGLyKls5FD7oipdJR2S3z6Ph
	ZVizvIAdl2/CtaDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Mm/vaLWA";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aoiW+qMG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738133442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jflj/Hl4NND7Ez5JujtDQBq0KgLjP09am4mlWD/p610=;
	b=Mm/vaLWAwWVF19QZnvbTpYtOyPlIRaHn8A+JpKHUUjA8ROGa98NLSJ+rkEkJCzU1n1FH5Z
	ajtY0ix2GxIagXc7Vmyd5s60sAmBQRu5kDku9XkTf7ap7pw82zjIoLDpGSnWqMY5QsGvwy
	T0Y0sbak4ulFZ0QnMZWSIgWY/Lej4xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738133442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jflj/Hl4NND7Ez5JujtDQBq0KgLjP09am4mlWD/p610=;
	b=aoiW+qMG+fp3U8PiJbG8a0InS4C/YPdznjARxq7Fbvmj6S2E3Hnr/vUWHHL5Fpay8W90ba
	PpMXyWvxpp2GTvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69F98137D2;
	Wed, 29 Jan 2025 06:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IITaF8LPmWdJNgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 29 Jan 2025 06:50:42 +0000
Message-ID: <0838cdaa-999d-4834-b4e2-4302f36638da@suse.de>
Date: Wed, 29 Jan 2025 07:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 2/2] block: fix nr_hw_queue update racing with disk
 addition/removal
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250128143436.874357-1-nilay@linux.ibm.com>
 <20250128143436.874357-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128143436.874357-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0F101F365
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 1/28/25 15:34, Nilay Shroff wrote:
> The nr_hw_queue update could potentially race with disk addtion/removal
> while registering/unregistering hctx sysfs files. The __blk_mq_update_
> nr_hw_queues() runs with q->tag_list_lock held and so to avoid it racing
> with disk addition/removal we should acquire q->tag_list_lock while
> registering/unregistering hctx sysfs files.
> 
> With this patch, blk_mq_sysfs_register() (called during disk addition)
> and blk_mq_sysfs_unregister() (called during disk removal) now runs
> with q->tag_list_lock held so that it avoids racing with __blk_mq_update
> _nr_hw_queues().
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-sysfs.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 6113328abd70..3feeeccf8a99 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -225,25 +225,25 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>   
>   	ret = kobject_add(q->mq_kobj, &disk_to_dev(disk)->kobj, "mq");
>   	if (ret < 0)
> -		goto out;
> +		return ret;
>   
>   	kobject_uevent(q->mq_kobj, KOBJ_ADD);
>   
> +	mutex_lock(&q->tag_set->tag_list_lock);

Maybe a comment here to indicate that it prevents a race?

>   	queue_for_each_hw_ctx(q, hctx, i) {
>   		ret = blk_mq_register_hctx(hctx);
>   		if (ret)
> -			goto unreg;
> +			goto out_unreg;
>   	}
> +	mutex_unlock(&q->tag_set->tag_list_lock);
> +	return 0;
>   
> -
> -out:
> -	return ret;
> -
> -unreg:
> +out_unreg:
>   	queue_for_each_hw_ctx(q, hctx, j) {
>   		if (j < i)
>   			blk_mq_unregister_hctx(hctx);
>   	}
> +	mutex_unlock(&q->tag_set->tag_list_lock);
>   
>   	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>   	kobject_del(q->mq_kobj);
> @@ -256,9 +256,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>   	struct blk_mq_hw_ctx *hctx;
>   	unsigned long i;
>   
> -
> +	mutex_lock(&q->tag_set->tag_list_lock);

Similar here.

>   	queue_for_each_hw_ctx(q, hctx, i)
>   		blk_mq_unregister_hctx(hctx);
> +	mutex_unlock(&q->tag_set->tag_list_lock);
>   
>   	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>   	kobject_del(q->mq_kobj);

Otherwise looks good.
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
