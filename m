Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604421;
	b=ZxavdFSB9CyLCVAkE41PzTuGpef4R32wADIiDZOUeEiQEPpm9WLsrHQ72H48FRL7Z/Rn
	 w2ml174xQ7F5vBxpcAzCaNvUe6t/YZZXZOWSlsHabMp4x3U0cpC+aZUFZiH/pu9/quEV1
	 g/QUkLV6U+PU51j/oNyS5EzJuZROoZ9pACbNWjw12HEXaIyZhWYYUtWtAeLSj4O3G4rOB
	 waokUnxe+FLe2ej0GrnvotuCIR+R8VcWIvyze2/AJjVYoB30t3AsSI3DprTw6A4uJwv5j
	 XVvZbAD65gOiqtix0F0QnWExzXudKWcZIgCnsCDaTNhXvgmR1IqeZWJ+yrgbBp/sEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604421;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=niVKfKGMJajn1QCLUQ+zCFe/OI3DBmDpsp7OHxA2kaBJtsuVHyBUFPwBBJG0rEPXa7x0
	 qUCyBpmGssyNM8F/cRM16E9hS7tW7Que1FVTp9am9zcrcRuj/icE8NFW+ng18U3DgaX9O
	 RHkFHq5mRVduL5Dsf+B+sjEJhpxHHjkEc3gG71DQveVgSPv/W4Mj/RyUNWoCcfQQLAXdM
	 4bhWNxNnUjrZXDQY8JRq5YzKsuTw+fZvjhhvN9ltXs7epOEmJ67vT6y3qqUJReTH2oWW6
	 nq8oTByWjsyyMqunZDKaXmT2sLibGZSvvwiFiEk9dwD5rVZ9vAbljQsYmhts2zQBzcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nMt8BHjk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="tg47q/4A";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nMt8BHjk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="tg47q/4A";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876F606A324;
	Mon,  2 Nov 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8876F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nMt8BHjk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tg47q/4A;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nMt8BHjk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tg47q/4A
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0D541F788;
	Mon,  2 Nov 2026 07:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=nMt8BHjky/1S3YlOjl184PVLOw65SCzlu4n73GFxSTVyupFfIGsS3VqtuQJWBGZ6gyI0NT
	XVEHCJKEzsW0pz4z1z3NuWBLYtg+8+UQETgXeqwb7OEiJEWe/hPuK9S/zj9F7bYG08G77O
	Q+ysKX66LokrFu0L6P09u4g8D3/wsUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=tg47q/4AJwq592NmqX2E0MwXUjLzXsl+/I0fHmMcZNh0cuTBsSi0NUXMPOEbfufoYhKzRh
	vNp4CMc0n7chf0Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=nMt8BHjky/1S3YlOjl184PVLOw65SCzlu4n73GFxSTVyupFfIGsS3VqtuQJWBGZ6gyI0NT
	XVEHCJKEzsW0pz4z1z3NuWBLYtg+8+UQETgXeqwb7OEiJEWe/hPuK9S/zj9F7bYG08G77O
	Q+ysKX66LokrFu0L6P09u4g8D3/wsUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=tg47q/4AJwq592NmqX2E0MwXUjLzXsl+/I0fHmMcZNh0cuTBsSi0NUXMPOEbfufoYhKzRh
	vNp4CMc0n7chf0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4371E134B3;
	Mon,  2 Nov 2026 07:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBfCAEI76GpfbQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Nov 2026 07:26:58 +0000
Message-ID: <6e9e6f78-4bd7-46f0-bf57-5c227a65a69e@suse.de>
Date: Mon, 2 Nov 2026 08:26:57 +0100
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
Subject: Re: [PATCH 1/2] nvme: remove namespaces in parallel
To: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
 Nilay Shroff <nilay@linux.ibm.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
 <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Level: 
X-Spam-Flag: NO

On 11/2/26 7:14 AM, Qiliang Yuan wrote:
> nvme_remove_namespaces() removes the namespaces of a controller one
> after another. Each removal waits for RCU grace periods in
> del_gendisk() for the namespace and for its multipath head, about
> 20 ms in all.
> 
But that isn't changed by calling async_schedule_domain, isn't it?

> Deleting a controller, such as disconnecting from a fabrics target,
> thus takes time proportional to its namespace count, over a second for
> 64 namespaces. Scanning had the same problem until commit 4e893ca81170
> ("nvme_core: scan namespaces asynchronously") made it add namespaces
> in parallel.
> 
> Remove the namespaces through an async domain the same way, and wait
> for all of them before returning.
> 
> Disconnect time from a target on the same host, over tcp to 127.0.0.1
> and over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
> boots per kernel:
> 
>    namespaces  transport  before              after
>             8  tcp         170 /  171 ms        85 /   91 ms
>            32  tcp         628 /  628 ms       294 /  293 ms
>            64  tcp        1201 / 1308 ms       533 /  550 ms
>            64  loop       1988 / 1913 ms      1283 / 1200 ms
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>   drivers/nvme/host/core.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..18948c2ba218d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4716,6 +4716,11 @@ static void nvme_scan_work(struct work_struct *work)
>   #endif
>   }
>   
> +static void nvme_ns_remove_async(void *data, async_cookie_t cookie)
> +{
> +	nvme_ns_remove(data);
> +}
> +
>   /*
>    * This function iterates the namespace list unlocked to allow recovery from
>    * controller failure. It is up to the caller to ensure the namespace list is
> @@ -4725,6 +4730,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns, *next;
>   	LIST_HEAD(ns_list);
> +	ASYNC_DOMAIN(domain);
>   
>   	/*
>   	 * make sure to requeue I/O to all namespaces as these
> @@ -4759,8 +4765,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	mutex_unlock(&ctrl->namespaces_lock);
>   	synchronize_srcu(&ctrl->srcu);
>   
> +	/*
> +	 * Remove the namespaces in parallel, as each removal waits for several
> +	 * RCU grace periods.
> +	 */
>   	list_for_each_entry_safe(ns, next, &ns_list, list)
> -		nvme_ns_remove(ns);
> +		async_schedule_domain(nvme_ns_remove_async, ns, &domain);
> +	async_synchronize_full_domain(&domain);
>   }
>   EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>   
> 
Other than that it looks fine.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
