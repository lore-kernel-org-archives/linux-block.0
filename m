Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268722;
	b=gKtANIS1jgCdrPw6uhWu0JMNWF6TXe8mgj5BjQJXbEjdCFfQZhrMPuyxftDELaGgyUAy
	 E6o668/52MygwN8eSY69CO2hlv+EPmR5hEelRsgBRMGe7mCDtFR7fSTJBiphvD26INiSr
	 Kb7RYzWLSvMfeVxdtpyyjV3OF4Q0XFbkaO8MoAsPrU3pm2Qd95IrklAIgKD+jKHs5ke0X
	 k5nC7Ud0V/0UFqpfyBuIo3kcYmMZ8Ajv4E0PhYIklUxFUMIKJBkp9Un0E1Bls5GPaa1ej
	 ESarfN3uYCjQBYE50M/wL1emDouMDT4Uw1NaY4ee8HbBRDtUIweG8sxN50nhw0WSVTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268722;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=YYr7rp0MKE6X3AdaQW2iOo55WBPYNGuuiI3up0Qg35s=;
	b=J+5bGg/xlFysPgkqj0tfBDOxf4DITGA7HP4hhul8lJ6tKPV4d5P0G4A8JzZtyCQTRqtl
	 kpuFqDua/4/8Ohy0J3nE2/n65SevQsvYBod5RWQaC346JEQ3rF2uR1wMKl+M99h+2ZJf7
	 YsUDr5XdpdXFBNCtxyWKcl4DDKhRFp1s9XLqWeq+Clt2W3H8ohX9In8wEe7DDf+Lt23SW
	 rhPNNtdiTvQqLlFfG7XAIIlakYBUAgQdQNTz9Lpy4M8ImZv0SIaQ/pM6YBMQFSuwFl3RV
	 IXcsiKJv9KfkQwRngTvyBi9km+sO2sKlYro73ALXs8YQeWeT1qzaL9gOCReyEXjGQUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gl7WuCph;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+KElWXgF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gl7WuCph;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+KElWXgF;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B5606A32E
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F4B5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gl7WuCph;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+KElWXgF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gl7WuCph;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+KElWXgF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7596A1FCE4;
	Thu, 29 Oct 2026 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYr7rp0MKE6X3AdaQW2iOo55WBPYNGuuiI3up0Qg35s=;
	b=gl7WuCphGlwTdlQczFJImSlWPJwfL3jfS7+/js8pfLbBQCdmOiZBkruVz7B2szGENNGn3l
	MSC/aoo8tCAwT40PPitS1N4n3I7iUP9qs9GyOstDUVnP/QtpvPRBRktfKWbZAV6o5Ts3Ie
	nGFvxrgf6DVoaaxsCCghFW+x2DH9JFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYr7rp0MKE6X3AdaQW2iOo55WBPYNGuuiI3up0Qg35s=;
	b=+KElWXgFwK+Ofq+r+ogZeafjNhzpgpvnC1DahWwMAonj7ppL6Kmn+uGWjjPilVfUCfMhWY
	8pSbtXfHpi3TgqCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYr7rp0MKE6X3AdaQW2iOo55WBPYNGuuiI3up0Qg35s=;
	b=gl7WuCphGlwTdlQczFJImSlWPJwfL3jfS7+/js8pfLbBQCdmOiZBkruVz7B2szGENNGn3l
	MSC/aoo8tCAwT40PPitS1N4n3I7iUP9qs9GyOstDUVnP/QtpvPRBRktfKWbZAV6o5Ts3Ie
	nGFvxrgf6DVoaaxsCCghFW+x2DH9JFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYr7rp0MKE6X3AdaQW2iOo55WBPYNGuuiI3up0Qg35s=;
	b=+KElWXgFwK+Ofq+r+ogZeafjNhzpgpvnC1DahWwMAonj7ppL6Kmn+uGWjjPilVfUCfMhWY
	8pSbtXfHpi3TgqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4090413419;
	Thu, 29 Oct 2026 10:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +bXABvAb42qxMQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:12:00 +0000
Message-ID: <5f81a3f9-88fd-4128-9642-b08d240ddd44@suse.de>
Date: Thu, 29 Oct 2026 11:11:59 +0100
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
Subject: Re: [PATCH 96/98] nvmet: take sq->ref in nvmet_sq_fatal_error()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-97-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-97-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,lst.de:email,grimberg.me:email,suse.de:email,kernel.dk:email]
X-Spam-Score: -13.29

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Chris Mason <mason@kernel.org>
> 
> nvmet_sq_destroy() kills sq->ref, waits for the commands to drop it,
> then puts the controller and clears sq->ctrl. So sq->ctrl may only be
> used while holding sq->ref. nvmet_sq_fatal_error() reads it without,
> and its transport callers hold nothing either: in nvmet-rdma the
> completion handlers run until the QP is drained, which
> nvmet_rdma_release_queue_work() does only after nvmet_sq_destroy(), and
> in nvmet-tcp io_work can run between the two cancels of the release
> work. A short capsule or a failed completion that races the disconnect
> then dereferences a NULL sq->ctrl, or locks ctrl->lock and queues
> fatal_err_work in a freed controller. The host needs nothing but a
> Connect, reproduced over rxe with a sleep added to widen the window.
> 
> Take sq->ref with percpu_ref_tryget_live() around the body. If the ref
> is already dead the queue is going away and the error is dropped, which
> is the mitigation: nothing can tell a call that would have finished in
> time from one that wouldn't. tryget_live after percpu_ref_exit() is
> fine, it sees __PERCPU_REF_DEAD and touches nothing freed, and
> nvmet_req_init() already relies on that. nvmet_auth_fatal_error() runs
> in a command that holds the ref, so it calls the body directly.
> 
> Fixes: 14c862dbb0a0 ("nvmet-rdma: drain the queue-pair just before freeing it")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/core.c             | 21 ++++++++++++++++++++-
>   drivers/nvme/target/fabrics-cmd-auth.c |  3 ++-
>   drivers/nvme/target/nvmet.h            |  1 +
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b78a4d4eb838..19f96f1b7e74 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1833,8 +1833,11 @@ EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
>    * A fatal error on one queue.  The Connect command of an I/O queue needs no
>    * secret, so until the queue has authenticated it may be anybody's: do not
>    * let it take down the controller of the host whose NQN it has named.
> + *
> + * The caller holds sq->ref, as a command that is being executed does: until it
> + * is put, nvmet_sq_destroy() waits, and does not clear sq->ctrl.
>    */
> -void nvmet_sq_fatal_error(struct nvmet_sq *sq)
> +void __nvmet_sq_fatal_error(struct nvmet_sq *sq)
>   {
>   	struct nvmet_ctrl *ctrl = sq->ctrl;
>   
> @@ -1843,6 +1846,22 @@ void nvmet_sq_fatal_error(struct nvmet_sq *sq)
>   	else
>   		nvmet_ctrl_fatal_error(ctrl);
>   }
> +
> +/*
> + * A transport calls this with no reference of its own, concurrently with
> + * nvmet_sq_destroy(), which puts the controller and clears sq->ctrl.  As in
> + * nvmet_req_init(), the call can come after percpu_ref_exit():
> + * percpu_ref_tryget_live() then sees that the ref is dead and touches nothing
> + * that is freed.
> + */
> +void nvmet_sq_fatal_error(struct nvmet_sq *sq)
> +{
> +	if (!percpu_ref_tryget_live(&sq->ref))
> +		return;
> +
> +	__nvmet_sq_fatal_error(sq);
> +	percpu_ref_put(&sq->ref);
> +}
>   EXPORT_SYMBOL_GPL(nvmet_sq_fatal_error);
>   
>   ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index cb6be285b3c4..020a989fe263 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -33,12 +33,13 @@ static void nvmet_auth_expired_work(struct work_struct *work)
>   	mutex_unlock(&sq->auth_lock);
>   }
>   
> +/* Called from a command that is being executed, which holds sq->ref. */
>   static void nvmet_auth_fatal_error(struct nvmet_sq *sq, bool passed)
>   {
>   	if (passed)
>   		nvmet_ctrl_fatal_error(sq->ctrl);
>   	else
> -		nvmet_sq_fatal_error(sq);
> +		__nvmet_sq_fatal_error(sq);
>   }
>   
>   void nvmet_auth_sq_init(struct nvmet_sq *sq)
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 29105e2a7022..3519537705f8 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -631,6 +631,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq);
>   int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq);
>   
>   void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
> +void __nvmet_sq_fatal_error(struct nvmet_sq *sq);
>   void nvmet_sq_fatal_error(struct nvmet_sq *sq);
>   
>   void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
