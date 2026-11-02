Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604163;
	b=HzuJCamVjVYlMKFCzTQSuezDhoTscflWAYhsin3t3X0MplYwf6zN2HFvbnbABRRj4gnK
	 ulohS3TmVVp/4GHUUD4B3lZwMtopKaDUXToTBw8vyMUkishKdaDVLlFnNrYTDBeLI3X7I
	 KP+RrGGD+wF6UoLcYxE2mPnTylzr0dQcUlsvPWkavhTLxzgPAXCXIgzzLTE3XlGH8MYj5
	 r8qJIFQLLWNzbh9ssoVduaz7Ega/icTXC5LtpUevxm8Q3SWNVGxtTzUiSHH0mKMhO8yWU
	 vWm2xxSvA3id1y4TRjST5Qg7XcrfQcrD30D7ibaWZ1CPGVbgPqXlcAR1FQsINCS1Xng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604163;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=lxjewwj2nxYhKCWZW7nt6HgiTVdnylcH/diTEvdKaKQ=;
	b=E0ZFqDmnWmGx0QEv08YqhL50RX7CelWjV//nhw9vuwKB8NswBijaxPmgR1aiibRZSwn0
	 gsJQMu0juvSGm9qDoTl6JU8fXXp+IpsLV6mJQUSWP26QsV7KbnnCuMTAQhm87/37BxhJM
	 x4p7u1XQQlyAjoTd+YwSmCjEH/Otz4GWzPIV6KO/i4kzz//B96T3Q7N6ca+PlG7pVtwTR
	 FGuOyq0196RsZmK+AlpeMy73ZrbJKSyncDOwfUDTK3wCVkDZhkZBYbWlVUaXwnYD+m0Tc
	 ptwTYZ+s1uDmyecHKo4B65Qy3tKP+XhF9OTGSyL2hAD8KKdNnFRwLxYXUraqR5p2Tpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="R0m/Aesq";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DcICn4YV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QbVhc5Jj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BIxYawek;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BD606A326;
	Mon,  2 Nov 2026 07:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685BD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R0m/Aesq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DcICn4YV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QbVhc5Jj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BIxYawek
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7021222012;
	Mon,  2 Nov 2026 07:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxjewwj2nxYhKCWZW7nt6HgiTVdnylcH/diTEvdKaKQ=;
	b=R0m/AesqnG9DKR345fWFJNOFYRbzM24Wt+rBwgSKk7OfA5OnXuYerfzjtdCVS4/DmpbGMQ
	EnAQTeSGz3zYLn+PLPcytQb2YhzgI3A5mYB7/lbiCYb+rFSFV61dKJkbvF8m1Qa0BZkmRv
	w41mtdu8FnUE07EWaRtHns2Rtud3ZCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxjewwj2nxYhKCWZW7nt6HgiTVdnylcH/diTEvdKaKQ=;
	b=DcICn4YVTRmeB1aVwFJT5w6yd1In8QGRbM/UaJk7mfxXc1Kvd7wmJeck4dYji7PfhrZ/yi
	cKHpg23zP+CZluAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxjewwj2nxYhKCWZW7nt6HgiTVdnylcH/diTEvdKaKQ=;
	b=QbVhc5JjDTjzg2e/Eawtw9TnAdGbuPDj7kef936rNWbPwhFQS40ZOJIpfCZBf7tKVYnXSD
	XLoW/jusD5zUAndsZ3Qz96PM82exDwOJ+aklFhghg9z8uGnMTPY7Wa5lAOI5aZmRqk07Z0
	R6iVt0RD+hF1V7XtuuHQ9ye1ylmA2iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxjewwj2nxYhKCWZW7nt6HgiTVdnylcH/diTEvdKaKQ=;
	b=BIxYawekxBqW7x7jBjPAayK6AObsZJuYw9YDvYCDB7rI7syejyW/cLZCvlPByQ5F87jSQa
	qIC6m6lCbqEGpdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C1DE134B3;
	Mon,  2 Nov 2026 07:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EnDILjg66GriaAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Nov 2026 07:22:32 +0000
Message-ID: <a8fe2167-1fbc-4618-ba2f-170457d9c10f@suse.de>
Date: Mon, 2 Nov 2026 08:22:32 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: set QUEUE_FLAG_NO_ELV_SWITCH under the read
 lock in del_gendisk()
To: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
 Nilay Shroff <nilay@linux.ibm.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
 <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,linux.ibm.com,wdc.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.79

On 11/2/26 7:14 AM, Qiliang Yuan wrote:
> del_gendisk() takes the tag set's update_nr_hwq_lock for write to set
> QUEUE_FLAG_NO_ELV_SWITCH, then for read around __del_gendisk(). The
> write lock was there to wait for elevator switches from sysfs, which
> held the lock for read when the flag was added.
> 
> When several disks of one tag set are deleted at once, as nvme does for
> the namespaces of a controller, each write lock waits for the other
> disks to get through __del_gendisk() under the read lock, and the
> deletions run one after another.
> 
> Elevator switches from sysfs have taken update_nr_hwq_lock for write
> since commit 4ff58d6bc9dd4 ("block: serialize elevator changes for the
> same queue using a writer lock"), as updates of nr_hw_queues do. Set the
> flag under the read lock instead, which still waits for both and keeps
> them out.
> 
> Disconnect time of an nvme controller that removes its namespaces in
> parallel, from a target on the same host, over tcp to 127.0.0.1 and
> over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
> boots per kernel:
> 
>    namespaces  transport  before              after
>             8  tcp          85 /   91 ms        51 /   47 ms
>            32  tcp         294 /  293 ms        75 /   70 ms
>            64  tcp         533 /  550 ms       115 /  124 ms
>            64  loop       1283 / 1200 ms       185 /  204 ms
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>   block/genhd.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 10ca8b4d6eea7..5afc60bf139e6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -781,16 +781,6 @@ static void __del_gendisk(struct gendisk *disk)
>   		blk_unfreeze_release_lock(q);
>   }
>   
> -static void disable_elv_switch(struct request_queue *q)
> -{
> -	struct blk_mq_tag_set *set = q->tag_set;
> -	WARN_ON_ONCE(!queue_is_mq(q));
> -
> -	down_write(&set->update_nr_hwq_lock);
> -	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
> -	up_write(&set->update_nr_hwq_lock);
> -}
> -
>   /**
>    * del_gendisk - remove the gendisk
>    * @disk: the struct gendisk to remove
> @@ -820,10 +810,13 @@ void del_gendisk(struct gendisk *disk)
>   	} else {
>   		set = disk->queue->tag_set;
>   
> -		disable_elv_switch(disk->queue);
> -
>   		memflags = memalloc_noio_save();
>   		down_read(&set->update_nr_hwq_lock);
> +		/*
> +		 * Set the flag under the read lock, as elevator switches take
> +		 * update_nr_hwq_lock for write.
> +		 */
> +		blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, disk->queue);
>   		__del_gendisk(disk);
>   		up_read(&set->update_nr_hwq_lock);
>   		memalloc_noio_restore(memflags);
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
