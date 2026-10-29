Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267705;
	b=LWQJLH34tMA9UpXx5VQvcNw7edkRIePKXz8fW8b9fQgCWiM8olZ1xaY2ezLWXGVbHelQ
	 z6UHfWAcy1zLHkgxhBa6m9I7rM9RNzYPUBsDdRWtAOsVQ/pltDd6/8b9H4vcyZ60+QxKp
	 +8EEZ/W0BQfFyxX+beA53tMuhY+7PuVYwUdnoiKhchmJa8tjG/9qnW432C23fKRGMynAy
	 XK6c1GUeM7tdCf4807/qTb0dGfScsB4NA175pxzkjN3WAShcZiBjfOg0m3C7YvBuwEaJz
	 YH+AcssFmqVZ4TwfyHQRnZ0LQbxAH8A7HYsTI6gtx+cYeNX2CB3oIovHS2kWcZYUmIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267705;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=G19LUzmVhYcNNrNvOwSy27dyr8ebdmZmLn0VylhTPVg=;
	b=eqgcX++whGrRsjdwuaOb+X/aBblTbP3dC6imalRK5+kWoEtsTvrBaDDIdUB/YQqjFHaD
	 O+Hr1TAmjsAiVUXn5hZ0qo0Z8WArr/iLUSFuFkgsgUIVX4vuxlnxbGTMFA60fIpc250C9
	 X23FC/8xVzdg0t/GoHCPS/yKSPOQj3hLonh/evEKbEZ3Ju1nIvdP65i/w3BmggfYOTfb5
	 Ai79NtsrCIQYpWblGf/pkDi9l0OPo3j+Di7FxI/FZco6rFOWZmJjHv0oyXr5rg8YkH8ws
	 RCBCtYg60n81gvWwp8D9D9FMBD7PiVR1bwm9Ye2mX/QVeKNB9lvusYVfFYU7q4K6lmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FS4qWmJL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iLK9Nwn8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FS4qWmJL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iLK9Nwn8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE8606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CDE8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FS4qWmJL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iLK9Nwn8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FS4qWmJL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iLK9Nwn8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8117B1F8B4;
	Thu, 29 Oct 2026 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G19LUzmVhYcNNrNvOwSy27dyr8ebdmZmLn0VylhTPVg=;
	b=FS4qWmJLRRi7LtrQBQD0vmMhGNL5WIDv23Hc7kF/6RzPHZXyyEUtZneiTd76mVS58hTO7D
	zw7pJ+WBwqN8gKs9HO729O2AZ0tNmtl5wN2xqq3Nv+yxS6F6TcsM8xF6/5GJTazu3aEPVY
	8KNjy5+MEQ0X+MDUsADJfDbC4lnHGqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G19LUzmVhYcNNrNvOwSy27dyr8ebdmZmLn0VylhTPVg=;
	b=iLK9Nwn8LKTmWj1IZ0W3b1+qih+JnVXkflB0muo6Szsr2JlayacRMgVY2VOXTG0wvj7wZj
	OmM2bR+FPODkD5DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FS4qWmJL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iLK9Nwn8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G19LUzmVhYcNNrNvOwSy27dyr8ebdmZmLn0VylhTPVg=;
	b=FS4qWmJLRRi7LtrQBQD0vmMhGNL5WIDv23Hc7kF/6RzPHZXyyEUtZneiTd76mVS58hTO7D
	zw7pJ+WBwqN8gKs9HO729O2AZ0tNmtl5wN2xqq3Nv+yxS6F6TcsM8xF6/5GJTazu3aEPVY
	8KNjy5+MEQ0X+MDUsADJfDbC4lnHGqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G19LUzmVhYcNNrNvOwSy27dyr8ebdmZmLn0VylhTPVg=;
	b=iLK9Nwn8LKTmWj1IZ0W3b1+qih+JnVXkflB0muo6Szsr2JlayacRMgVY2VOXTG0wvj7wZj
	OmM2bR+FPODkD5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ACC41342D;
	Thu, 29 Oct 2026 09:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LaA3BvYX42pgIAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:55:02 +0000
Message-ID: <411b96d6-36bf-47a1-8601-b4db1fced442@suse.de>
Date: Thu, 29 Oct 2026 10:55:01 +0100
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
Subject: Re: [PATCH 65/98] nvmet-auth: take only AUTH_Negotiate for a
 negotiation
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-66-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-66-axboe@kernel.dk>
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,nvidia.com:email,grimberg.me:email,kernel.dk:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 8117B1F8B4

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_execute_auth_send() hands a common-type message to
> nvmet_auth_negotiate() if its ID is AUTH_Negotiate or matches the step
> the queue is in. The second case is wrong: the only other common-type
> message a host sends is AUTH_Failure2, and no queue waits in that step.
> A host can name the step on purpose though, and its message is then
> treated as a new AUTH_Negotiate without the work that goes with a new
> transaction, like reloading the keys on the admin queue.
> 
> Fail every other common-type message, as AUTH_Failure2 already is.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index a559fec3aa65..5ab943256f38 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -350,8 +350,9 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   			}
>   			req->sq->dhchap_step =
>   				NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
> -		} else if (data->auth_id != req->sq->dhchap_step)
> +		} else {
>   			goto done_failure1;
> +		}
>   		/* Validate negotiation parameters */
>   		dhchap_status = nvmet_auth_negotiate(req, d, tl);
>   		if (dhchap_status == 0)

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
