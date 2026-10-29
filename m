Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269402;
	b=c4ys2vZVZr1m7ZMIC5bktDnZgr8dUKq9hTTWJe91EMIrV9xXTM39vEDWb+OHF5w+yjIL
	 e35UmvP0YK3wa5x1MrL4PaHxNYFjohiJGc/AVYW6HGqHVxzzcWXLeY0mWjgBEmZQxCP0W
	 IeZyE+QsCxjvYRMrK8e0hYl55AS2xrak5yxPCAVztY8JqYQTLKp4MVvMZ3/lNu4emjZ9A
	 Dq93UuILye/utKpH0zxgeNUBJUyaKwrQQAPwz0Kp4cLmT3ajpPhpUPxLW87Qv5r7JcPzA
	 7tXlkFPUifilbEiFb07QvVhdZ8hYyhWQchdKIJfgk01o/eOrRABz+QhZ7I3q5V/3YPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269402;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=4oOAVQTBj6utkzjann+tOiO3EmFjtntrTrVPqFRJhkw=;
	b=tt3iwzZcS23ZTypHDafURK41fOx490wKwjPQyijP0izcWkQrl5A1oU2Wfno9XrWFFmth
	 thSC8QOwbCzi7XPvr39y2mDb2i2zXfChV181i1pMbJCXRmTbsuZTpmO3oZMuFw/DXBX3i
	 g7bnZ9xo3KnaR53EO/O+TeqCCU+KkHLnQ0Cj7/YjExW5wzO3KQJVQ0mI1PEKmLb0NbFRc
	 E81LzlMWeRdSo+vpxrAK7WuvgAi3Sa7Db5l8Ve3Zaur8M+bTOFa3OSd8CCJ4q+/gd2lgY
	 T83LRqi/mkOXQDuR4os3XDZhJGTPI+2r5SZaWCwLTmOyTWUJk7Ec0w69Y1fLKStMlIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="Fcd/4Von";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="LCR9xEx/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uOYK+u4b;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aXQaq2wa;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C803606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C803606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Fcd/4Von;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LCR9xEx/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uOYK+u4b;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aXQaq2wa
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D29521E3B;
	Thu, 29 Oct 2026 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793269399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oOAVQTBj6utkzjann+tOiO3EmFjtntrTrVPqFRJhkw=;
	b=Fcd/4VoneDVlKiyvtgTPpmIQeYcdwOoDUcmKfVXYcyjwECjkbPU/pHsJRFPgS1JDDDE5MK
	4/jZbNTibCv6kZ6el4KZfU3BVTXtbtEG6ukTRi5iNxfFX2gS78PlzbHAVzDHub5kELc798
	T0Lu+iYgaBvYHfLfT4yAivp4X9/W5qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793269399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oOAVQTBj6utkzjann+tOiO3EmFjtntrTrVPqFRJhkw=;
	b=LCR9xEx/0isOW9+7WQG3RVEwg4r0rALxb7bK/RJTeIB9wBevNZzRGXuvHKJNtWdCM0JgC7
	NRybutQXggnoPGAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793269398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oOAVQTBj6utkzjann+tOiO3EmFjtntrTrVPqFRJhkw=;
	b=uOYK+u4bFZwZc65bhIZTcvQu+dyv9NYzkBt1wPrVXnOIg5h//6HIqYOcY/TellQIzR6jrN
	Nb+AT52as6miq+ZUUGtH+AYJrugEZlkHCCLhoPm2NqMEXhbe1ZQhUQnmLNmkVM7lc8F3Uk
	z06w8jvkwnSyDKSBJHTR2gauTWaPZuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793269398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oOAVQTBj6utkzjann+tOiO3EmFjtntrTrVPqFRJhkw=;
	b=aXQaq2waO3CQkOXcuJWSkW0gHo1s2ih3vWGqleKnOC4Ft22TqSIugyuQDTOmIIUlm+XBjQ
	KHJ89lHkVs8VFADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71661342D;
	Thu, 29 Oct 2026 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eoQZJ5Ue42oUPQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:23:17 +0000
Message-ID: <cb7fe8ed-6cbe-4cff-b35f-b688eeecd577@suse.de>
Date: Thu, 29 Oct 2026 11:23:17 +0100
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
Subject: Re: [PATCH 69/98] nvmet: confine fatal errors of unauthenticated
 queues
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-70-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-70-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,toxicpanda.com:email,nvidia.com:email,lst.de:email,kernel.dk:email,imap1.dmz-prg2.suse.org:helo,grimberg.me:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> The Connect of an I/O queue names its controller by NQNs and cntlid and
> needs no secret, DH-HMAC-CHAP comes after it. But a fatal error on any
> queue, a failed authentication or a transport error like an unknown PDU
> type, takes the whole controller down. So anyone who can reach the port
> and knows the NQNs can attach a queue to an authenticated host's
> controller and kick that host out, repeatedly.
> 
> Add a ->disconnect_queue() transport op and, for an I/O queue that
> hasn't passed the authentication asked of it, disconnect just that
> queue. Transports without the op (fc, loop) take the controller down as
> before. A queue that had authenticated and fails to do so again is the
> host's own, there the controller goes down as before too.
> 
> [axboe: resolved against the per-queue auth_lock and expiry work that
>   is upstream now]
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/auth.c             |  9 ++++++---
>   drivers/nvme/target/core.c             | 16 ++++++++++++++++
>   drivers/nvme/target/fabrics-cmd-auth.c | 20 ++++++++++++++++----
>   drivers/nvme/target/nvmet.h            |  7 +++++++
>   drivers/nvme/target/rdma.c             |  9 ++++++++-
>   drivers/nvme/target/tcp.c              | 11 ++++++++++-
>   6 files changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 5809ce32a2e4..335cf8f3f79e 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -261,10 +261,8 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
>   #endif
>   }
>   
> -bool nvmet_check_auth_status(struct nvmet_req *req)
> +bool nvmet_sq_auth_status(struct nvmet_sq *sq)
>   {
> -	struct nvmet_sq *sq = req->sq;
> -
>   	if (!sq->ctrl->host_key || sq->authenticated)
>   		return true;
>   
> @@ -272,6 +270,11 @@ bool nvmet_check_auth_status(struct nvmet_req *req)
>   	return sq->qid && nvmet_queue_tls_keyid(sq);
>   }
>   
> +bool nvmet_check_auth_status(struct nvmet_req *req)
> +{
> +	return nvmet_sq_auth_status(req->sq);
> +}
> +
>   int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   			 unsigned int shash_len)
>   {
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index d01f8abed66c..eea67fba6f92 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1828,6 +1828,22 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
>   
> +/*
> + * A fatal error on one queue.  The Connect command of an I/O queue needs no
> + * secret, so until the queue has authenticated it may be anybody's: do not
> + * let it take down the controller of the host whose NQN it has named.
> + */
> +void nvmet_sq_fatal_error(struct nvmet_sq *sq)
> +{
> +	struct nvmet_ctrl *ctrl = sq->ctrl;
> +
> +	if (sq->qid && ctrl->ops->disconnect_queue && !nvmet_sq_auth_status(sq))
> +		ctrl->ops->disconnect_queue(sq);
> +	else
> +		nvmet_ctrl_fatal_error(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvmet_sq_fatal_error);
> +
>   ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
>   		char *traddr, size_t traddr_len)
>   {
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 8c48140eb542..cb6be285b3c4 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -33,6 +33,14 @@ static void nvmet_auth_expired_work(struct work_struct *work)
>   	mutex_unlock(&sq->auth_lock);
>   }
>   
> +static void nvmet_auth_fatal_error(struct nvmet_sq *sq, bool passed)
> +{
> +	if (passed)
> +		nvmet_ctrl_fatal_error(sq->ctrl);
> +	else
> +		nvmet_sq_fatal_error(sq);
> +}
> +
>   void nvmet_auth_sq_init(struct nvmet_sq *sq)
>   {
>   	/* Initialize in-band authentication */
> @@ -253,11 +261,13 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   	void *d;
>   	u32 tl;
>   	u16 status = 0;
> +	bool passed;
>   	u8 dhchap_status;
>   
>   	mutex_lock(&req->sq->auth_lock);
>   	mutex_lock(&ctrl->auth_lock);
> -
> +	/* A queue that fails to authenticate again is no stranger's. */
> +	passed = nvmet_sq_auth_status(req->sq);
>   	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   		req->error_loc =
> @@ -430,7 +440,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   	/* Final states, clear up variables */
>   	nvmet_auth_sq_free(req->sq);
>   	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
> -		nvmet_ctrl_fatal_error(ctrl);
> +		nvmet_auth_fatal_error(req->sq, passed);
>   
>   complete:
>   	mutex_unlock(&ctrl->auth_lock);
> @@ -551,10 +561,12 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   	void *d;
>   	u32 al;
>   	u16 status = 0;
> +	bool passed;
>   
>   	mutex_lock(&req->sq->auth_lock);
>   	mutex_lock(&ctrl->auth_lock);
> -
> +	/* A queue that fails to authenticate again is no stranger's. */
> +	passed = nvmet_sq_auth_status(req->sq);
>   	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   		req->error_loc =
> @@ -641,7 +653,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   		nvmet_auth_sq_free(req->sq);
>   	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
>   		nvmet_auth_sq_free(req->sq);
> -		nvmet_ctrl_fatal_error(ctrl);
> +		nvmet_auth_fatal_error(req->sq, passed);
>   	}
>   	mutex_unlock(&ctrl->auth_lock);
>   	mutex_unlock(&req->sq->auth_lock);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index cc7fface77de..e354a71514ae 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -441,6 +441,7 @@ struct nvmet_fabrics_ops {
>   	int (*add_port)(struct nvmet_port *port);
>   	void (*remove_port)(struct nvmet_port *port);
>   	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
> +	void (*disconnect_queue)(struct nvmet_sq *sq);
>   	void (*disc_traddr)(struct nvmet_req *req,
>   			struct nvmet_port *port, char *traddr);
>   	ssize_t (*host_traddr)(struct nvmet_ctrl *ctrl,
> @@ -622,6 +623,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq);
>   int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq);
>   
>   void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
> +void nvmet_sq_fatal_error(struct nvmet_sq *sq);
>   
>   void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
>   
> @@ -989,6 +991,7 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
>   void nvmet_auth_sq_free(struct nvmet_sq *sq);
>   void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
>   int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
> +bool nvmet_sq_auth_status(struct nvmet_sq *sq);
>   bool nvmet_check_auth_status(struct nvmet_req *req);
>   int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   			 unsigned int hash_len);
> @@ -1015,6 +1018,10 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
>   static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
>   static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
>   static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
> +static inline bool nvmet_sq_auth_status(struct nvmet_sq *sq)
> +{
> +	return true;
> +}
>   static inline bool nvmet_check_auth_status(struct nvmet_req *req)
>   {
>   	return true;
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index ffa1e172c259..c4b848f84465 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -687,7 +687,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
>   static void nvmet_rdma_error_comp(struct nvmet_rdma_queue *queue)
>   {
>   	if (queue->nvme_sq.ctrl) {
> -		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
> +		nvmet_sq_fatal_error(&queue->nvme_sq);
>   	} else {
>   		/*
>   		 * we didn't setup the controller yet in case
> @@ -1848,6 +1848,12 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
>   	return ret;
>   }
>   
> +static void nvmet_rdma_disconnect_queue(struct nvmet_sq *sq)
> +{
> +	nvmet_rdma_queue_disconnect(container_of(sq, struct nvmet_rdma_queue,
> +						 nvme_sq));
> +}
> +
>   static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
>   {
>   	struct nvmet_rdma_queue *queue, *n;
> @@ -2078,6 +2084,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
>   	.remove_port		= nvmet_rdma_remove_port,
>   	.queue_response		= nvmet_rdma_queue_response,
>   	.delete_ctrl		= nvmet_rdma_delete_ctrl,
> +	.disconnect_queue	= nvmet_rdma_disconnect_queue,
>   	.disc_traddr		= nvmet_rdma_disc_port_addr,
>   	.host_traddr		= nvmet_rdma_host_port_addr,
>   	.get_mdts		= nvmet_rdma_get_mdts,
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a2a5f39d2bb7..c8f0c52a1b95 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -412,7 +412,7 @@ static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
>   	if (status == -EPIPE || status == -ECONNRESET || !queue->nvme_sq.ctrl)
>   		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	else
> -		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
> +		nvmet_sq_fatal_error(&queue->nvme_sq);
>   }
>   
>   static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
> @@ -2223,6 +2223,14 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
>   	kfree(port);
>   }
>   
> +static void nvmet_tcp_disconnect_queue(struct nvmet_sq *sq)
> +{
> +	struct nvmet_tcp_queue *queue =
> +		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
> +
> +	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> +}
> +
>   static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl)
>   {
>   	struct nvmet_tcp_queue *queue;
> @@ -2300,6 +2308,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   	.remove_port		= nvmet_tcp_remove_port,
>   	.queue_response		= nvmet_tcp_queue_response,
>   	.delete_ctrl		= nvmet_tcp_delete_ctrl,
> +	.disconnect_queue	= nvmet_tcp_disconnect_queue,
>   	.install_queue		= nvmet_tcp_install_queue,
>   	.disc_traddr		= nvmet_tcp_disc_port_addr,
>   	.host_traddr		= nvmet_tcp_host_port_addr,

No reason why we shouldn't to this for FC.
I'll update the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
