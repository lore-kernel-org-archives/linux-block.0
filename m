Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266403;
	b=YaNqadJ6eK+/W6LkIQ+a/sWQ5jLdpsRdF0Uvv84D7MYmZB84Lye+36Bu9134AmfGhsF+
	 38yoTASJi4bBBoTuPkntnEgnum0LOPDowsA1l8NRL48LskoRsF6NSK7jwOUotCp2YStyv
	 Z5GNVonMKZ7uThYNS74ofz+9pHEJ8Si1KNH/Fminvmc/yVAGKOBplMV/WRi94UmAbV2ea
	 voL+R/Ir4ty390lgdQ3DYCb8/N9Y9ID6oJ39Y1b7gzbGc75Xp91NQ7kFIar+iZsoutJJx
	 OeRs5GZhDvz5qHDRAttoGCQinuF25lHa40hcZJ9BLG4+SH+lemMhYdMZ4ZHFaOXJOkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266403;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=A3eaDltp9ro00kzLkKym+ifXR0l5ELVdXbWq3uIp3Ak=;
	b=GPjjyztbTNsV9NBEB3uB7EdNzKwidtHnKXe0a9MSJ+iGXgltHLSA4UzntppurfS+Qykj
	 hziUP5oD+IBLLRDus0ghq2vt5r1Iu8l96lRrJ7dIFjO+4uMQN1e9RLmKwsRqfBTCHtzni
	 I4JLeeV9tX+H4jhAGskk0Cj8eRigVP7pRpc1MepIbmaBrxh1uK/HOaWwPEu/dXRjD0Grf
	 HgluOj6NVZtLTd67TWCMl/Y+JqBf03D1QhCc/LWxH3jw6fHVUC5g1GBgMvWsPbZ7tDRFZ
	 FbSW/8cZnQdVTH+NkCdBxfYCLefrVXK9+h7Rlg42ZObQQ2Nwa5iH10Hb1NFKMzrPxyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ywprm8+n;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=npjtqavM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nmgiNLzX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="1aGXArv/";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D9606A320
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC5D9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ywprm8+n;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=npjtqavM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nmgiNLzX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1aGXArv/
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0BEE1FB41;
	Thu, 29 Oct 2026 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793266395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3eaDltp9ro00kzLkKym+ifXR0l5ELVdXbWq3uIp3Ak=;
	b=Ywprm8+nLTivOjCkaYZhH4jUZj7sp3bWaPZDdn4i+dCb6/sbv/MebJY7044hiHLx0wcPmL
	bkox9MbmdbC45dSgnbl/1pCwtCexUJLzI92PTrKkUURun1KLrbsJvScavpNJYTlgDr1uYp
	moDXTazJpKyRqKjploJw2lG7LjH6bn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793266395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3eaDltp9ro00kzLkKym+ifXR0l5ELVdXbWq3uIp3Ak=;
	b=npjtqavMk9VEUHOWSx4RWeBQxmesyhWvueXGlZDiGmRlSzVx/S9GUeZSN9Aj+IpA8Fcsku
	dV+muBAPbjkNcSCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nmgiNLzX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1aGXArv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793266394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3eaDltp9ro00kzLkKym+ifXR0l5ELVdXbWq3uIp3Ak=;
	b=nmgiNLzXWagb8qsEkFYMgs3AeBXmU1AjYuioUak7StWTQX/zsxkcV4/4FRx4wTXQPxkmqR
	jOXsetOVHYD6C6OXQ7Sl1cPD3SvMmztF8xmVvez2vfI+zPxAAsKkelb5EF3O6WTP2nQ0QT
	sWe1usi8a9Ple0ByQu1uTDbDXpO4k3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793266394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3eaDltp9ro00kzLkKym+ifXR0l5ELVdXbWq3uIp3Ak=;
	b=1aGXArv/2ahbJcD7epIQwMzYDNltBV7sMYDs5dA09kQUhDWPy0wTi0RsVBVw93qHlADSwH
	sSr0f/YVTgY5tLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68DA813419;
	Thu, 29 Oct 2026 09:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mRaHENoS42pACQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:33:14 +0000
Message-ID: <0b4fc5e1-9b5d-4f7f-bd5d-95566762d243@suse.de>
Date: Thu, 29 Oct 2026 10:33:14 +0100
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
Subject: Re: [PATCH 59/98] nvmet-auth: serialize the commands of a controller
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-60-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-60-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0BEE1FB41
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,nvidia.com:email,suse.de:dkim,suse.de:email,kernel.dk:email,toxicpanda.com:email]
X-Spam-Score: -13.50

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> The host and controller keys, the DH context and the hash of DH-HMAC-CHAP
> live in the controller, and the authentication commands of all its
> queues use them without a lock. A host can send AUTH_Negotiate on the
> admin queue at any time, and nvmet_setup_auth() then frees and reloads
> the keys while another queue computes a response from them:
> 
>    BUG: KASAN: slab-use-after-free in nvme_auth_transform_key+0xa3/0x250
>     nvmet_auth_host_hash+0x10e/0x530
>     nvmet_execute_auth_send+0xa4c/0x1a00
>    Freed by task 194:
>     nvmet_setup_auth+0x166/0x3a0
>     nvmet_execute_auth_send+0x3e7/0x1a00
> 
> Neither queue needs to have authenticated for that.
> 
> Add a controller-wide mutex and hold it for the duration of an
> authentication command, dropping it before the request is completed.
> nvmet_alloc_ctrl() takes it around nvmet_setup_auth() too, as the
> controller is already on the subsystem list by then and an I/O queue
> can connect.
> 
> [axboe: upstream already has the per-queue auth_lock and expiry handling
>   from 53f6efe00cea, so only the controller lock is added here. It nests
>   inside sq->auth_lock.]
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/core.c             | 4 ++++
>   drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++++
>   drivers/nvme/target/nvmet.h            | 1 +
>   3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 8353950f346f..5bd78bb83cf9 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1642,6 +1642,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   	if (!ctrl)
>   		goto out_put_subsystem;
>   	mutex_init(&ctrl->lock);
> +	mutex_init(&ctrl->auth_lock);
>   
>   	ctrl->port = args->port;
>   	ctrl->ops = args->ops;
> @@ -1728,7 +1729,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   
>   	nvmet_start_keep_alive_timer(ctrl);
>   
> +	/* An I/O queue may connect as soon as the controller is on the list. */
> +	mutex_lock(&ctrl->auth_lock);
>   	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
> +	mutex_unlock(&ctrl->auth_lock);
>   	if (dhchap_status) {
>   		pr_err("Failed to setup authentication, dhchap status %u\n",
>   		       dhchap_status);
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 1fe21f2672f1..9779e664b65f 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -269,6 +269,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   	u8 dhchap_status;
>   
>   	mutex_lock(&req->sq->auth_lock);
> +	mutex_lock(&ctrl->auth_lock);
>   
>   	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> @@ -297,6 +298,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   	}
>   	if (unlikely(tl != req->transfer_len)) {
>   		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
> +		mutex_unlock(&ctrl->auth_lock);
>   		mutex_unlock(&req->sq->auth_lock);
>   		nvmet_check_transfer_len(req, tl);
>   		return;
> @@ -442,6 +444,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   		nvmet_ctrl_fatal_error(ctrl);
>   
>   complete:
> +	mutex_unlock(&ctrl->auth_lock);
>   	mutex_unlock(&req->sq->auth_lock);
>   	nvmet_req_complete(req, status);
>   }
> @@ -562,6 +565,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   	u16 status = 0;
>   
>   	mutex_lock(&req->sq->auth_lock);
> +	mutex_lock(&ctrl->auth_lock);
>   
>   	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> @@ -590,6 +594,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   	}
>   	if (unlikely(al != req->transfer_len)) {
>   		pr_debug("%s: transfer length mismatch (%u)\n", __func__, al);
> +		mutex_unlock(&ctrl->auth_lock);
>   		mutex_unlock(&req->sq->auth_lock);
>   		nvmet_check_transfer_len(req, al);
>   		return;
> @@ -650,6 +655,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   		nvmet_auth_sq_free(req->sq);
>   		nvmet_ctrl_fatal_error(ctrl);
>   	}
> +	mutex_unlock(&ctrl->auth_lock);
>   	mutex_unlock(&req->sq->auth_lock);
>   	nvmet_req_complete(req, status);
>   }
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 9cec19e6f485..f6a9f2e1c0ed 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -307,6 +307,7 @@ struct nvmet_ctrl {
>   	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
>   	bool			pi_support;
>   	bool			concat;
> +	struct mutex		auth_lock; /* one AUTH command at a time */
>   #ifdef CONFIG_NVME_TARGET_AUTH
>   	struct nvme_dhchap_key	*host_key;
>   	struct nvme_dhchap_key	*ctrl_key;

Hmm. Not particularly happy with this.
In the end, it renders sq->auth_lock pretty much pointless (the only
place where it remains on its own is in nvmet_auth_expiry_work() ).
And it would trigger if a authentication reset while another 
authentication (eg on the I/O queues) is still ongoing.
With this patch we would switch the authentication variables
in the middle of the authentication protocol run for the I/O
queue, most likely causing that authentication to fail.

We should rather fail ongoing authentications whenever we
call nvmet_auth_setup().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
