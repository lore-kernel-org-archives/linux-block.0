Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267900;
	b=RwRYrdI9Yf1OVGwyVPqveI0PE+RPZqO706bucK5BPkmR4yQ8PQUgMkCuZkNnai70tac4
	 CAqCqQlb1WAMYcivanq7kNdq4Kn0i+sVgHZ+qkcCR17+EhCD4htcMnJl4o63vqzBAcij6
	 hgqLRYdGFV488CtfQ0IyPyocXNwPXl8YR8IUW77TUbCq0VrGTrHVlvv95dNrdxN2sLZ5c
	 IkWsF3tVR91AKDWJ/yaK9Ge3sn2XwpL6xSy/05rYOynn2MGQHJgH7RZ33E1jXsWwhniDU
	 oXQtwJTlcVgGPVEKPAKK7bN806TnFprL+R/HI+r6NSKKzZ/GKswmUuxoNDdiZM0VQUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267900;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=GWIYdhJfa1Yl/RWgfowhWHUiwqk1B6XQrhx2ks122NE=;
	b=gDN+q3zKFMbUE4S+XE3cTyHlRqJaj3zq826s3JqBzx4Iu/kF2CFs78HbAVlME12ZkZOt
	 jvKxNMLxDikYcUBZeQ8YggrWOFJGlyc83HuM2SKncg0A0h1YlWUBErnsxRE1hry4K53Jx
	 /jduneIhAIAfC0O56raZdYgawFCDZwh0OmuRVGmA/dNYjAPw86TOyIGD8zG9Ptn6pk8UR
	 CnTwn8RVNs4L+sqBMvqx8XGtNJn+t5M8sC/8MUxh/XtCp68BV02UrjAqqE8Qz40GGkvOV
	 cnwJKPW2bd7SbnjRr6c3op59Vk4yc47Fd/T/9kILXQ9kuWKJHvMfS2AbZndEbSfvzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=J5vtT0zy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qyvDpLeH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=J5vtT0zy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qyvDpLeH;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C76606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=J5vtT0zy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qyvDpLeH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=J5vtT0zy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qyvDpLeH
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49B7F221D2;
	Thu, 29 Oct 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWIYdhJfa1Yl/RWgfowhWHUiwqk1B6XQrhx2ks122NE=;
	b=J5vtT0zycznGZ7QwzijRE0wWQvQmouPjo20w3N7W6WI9diO4kxBdAz3JEceRk2dX9mL3mX
	cO/EqLDArF87efpmpM0u7UjswGmnbIu1LOpDbL+Fgc1jBA/VoXsdGUhk0ads3u4GBGm5yu
	zd3a4T7F41u6g0PqtpjM99GsPjHzfvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWIYdhJfa1Yl/RWgfowhWHUiwqk1B6XQrhx2ks122NE=;
	b=qyvDpLeH3lyTsn/oFjyD5NsMp9PWaYmlGyFv74Gbxs8hZDELir5tYgrGjCr7dXdcIvc1/0
	M5Fl2A8IjltQjMAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J5vtT0zy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qyvDpLeH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWIYdhJfa1Yl/RWgfowhWHUiwqk1B6XQrhx2ks122NE=;
	b=J5vtT0zycznGZ7QwzijRE0wWQvQmouPjo20w3N7W6WI9diO4kxBdAz3JEceRk2dX9mL3mX
	cO/EqLDArF87efpmpM0u7UjswGmnbIu1LOpDbL+Fgc1jBA/VoXsdGUhk0ads3u4GBGm5yu
	zd3a4T7F41u6g0PqtpjM99GsPjHzfvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWIYdhJfa1Yl/RWgfowhWHUiwqk1B6XQrhx2ks122NE=;
	b=qyvDpLeH3lyTsn/oFjyD5NsMp9PWaYmlGyFv74Gbxs8hZDELir5tYgrGjCr7dXdcIvc1/0
	M5Fl2A8IjltQjMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1252613419;
	Thu, 29 Oct 2026 09:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BxxAN7kY42p6IwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:58:18 +0000
Message-ID: <87146d0b-c14e-4cf7-92ec-8891236d6266@suse.de>
Date: Thu, 29 Oct 2026 10:58:17 +0100
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
Subject: Re: [PATCH 68/98] nvmet: accept I/O queues on the controller's port
 only
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-69-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-69-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,lst.de:email,toxicpanda.com:email,nvidia.com:email,suse.de:email,suse.de:dkim,kernel.dk:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 49B7F221D2

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_ctrl_find_get() looks the subsystem up through the port of the
> request, but then takes the controller from the subsystem list whatever
> port it was created on. A controller belongs to one port and one
> transport: ctrl->ops is that of the admin queue, and both
> ->install_queue() and ->delete_ctrl() assume the queues are their own.
> So an I/O queue arriving on another port of the same subsystem, possibly
> on another transport, is installed into a controller it has no part in,
> nvmet_tcp_install_queue() writes to it as a TCP queue, and an error on
> it deletes that controller. The Connect comes before any authentication.
> 
> Skip controllers of other ports, and compare the transport too since a
> port's transport can be changed while it's disabled.
> 
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 333739f14c2b..d01f8abed66c 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1507,6 +1507,11 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>   				pr_warn("hostnqn mismatch.\n");
>   				continue;
>   			}
> +			/* All queues of a controller come in by its port. */
> +			if (ctrl->port != req->port || ctrl->ops != req->ops) {
> +				pr_warn("port mismatch.\n");
> +				continue;
> +			}
>   			if (!kref_get_unless_zero(&ctrl->ref))
>   				continue;
>   

Ouch.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
