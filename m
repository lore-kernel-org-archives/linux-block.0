Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F91F4C96
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676258; cv=none; b=h9eSqpm7+jswYTekkr+KQDNx/sZqthV7EudIt9v9KfOMyLLFuwlJS2KIgrZKE8y8DFH5vE3FVFdlWP2VlhIuwbTLG+g3utK746k+EeSqpa68Y/MWcUsmFFWi3eT0022lXz/WhlPR1bPEJAKiOu4iyKgP6/G3FkdZ92bYhrptUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676258; c=relaxed/simple;
	bh=IiG6GOizI2cPjF6uYxMtN1anttuQC9GTwGiRXRKL+6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fY9xMb15SPkbAcug9mYn4weuTdBdqTRdklqkZkEJAYsfSUC/RvY9xIluTg103yovCi3vPrFsPefQ3QWlsypeMErSzDZiaVLHZLD3p7KCdWTQdeNvpgW/p8eQ1FzeRnhTZsbz5iSeh7dXc+g2bxszikGWzkZqHaZgBlrhNblP9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u7K1mgLc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TwOTWzRJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U6QdZhou; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=etHgcreL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u7K1mgLc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TwOTWzRJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U6QdZhou";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="etHgcreL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D86D1F394;
	Tue, 11 Mar 2025 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741676249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1do7IXGEo6iQ6jN6FJHXmAwttRU/AZFODq7/L+TmzU=;
	b=u7K1mgLcFT96k01RIfSJiwWoY0ZPVAivFB+QrKeqHiiqr6nqfTJ6r+rKKsmykgftw1XSAv
	PHCoev+p9guyB9BLhgKOc8pR7WCgvio8EK5ZfpLyVkjyd2aO6R9/MxLAVcEKAdFxbgar+o
	VR13BHltYx4ZzZ9UUqUYB2ZrCxNxj9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741676249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1do7IXGEo6iQ6jN6FJHXmAwttRU/AZFODq7/L+TmzU=;
	b=TwOTWzRJx5IGbkO1VAtaNcGj6+beOc6unBWWjkeTEEbKkRPzx+8RoPv1rUHS8biSnsqMHD
	x3NUSVRStbfCUfAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741676248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1do7IXGEo6iQ6jN6FJHXmAwttRU/AZFODq7/L+TmzU=;
	b=U6QdZhouQEAOc8bicu67IM7oK5yH4Jk9/1kL6Y9riyH+UqK1C1IIxsmR9docwe6ung0pTX
	AZsCZSu1JRrsKBPHZtPl49yFFsziI13FovFrhSSGXA52MfUmnkC3RJibLjJTgmu8aA01kh
	/KBBhNEIxDbkxZyhbWeH6xuXwFR1TW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741676248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1do7IXGEo6iQ6jN6FJHXmAwttRU/AZFODq7/L+TmzU=;
	b=etHgcreLrKAUzyeYmzH8uaCrpUqCys9rPuF2+gSM8WkQwxkKZleSav1/wxI7rfYuoN0EZb
	aczvODa8gbqhpRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB6A132CB;
	Tue, 11 Mar 2025 06:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5SIRINfez2fDQgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Mar 2025 06:57:27 +0000
Message-ID: <16de123b-abe8-4f6d-8b4a-ec9541eca249@suse.de>
Date: Tue, 11 Mar 2025 07:57:27 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sven Peter <sven@svenpeter.dev>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
 <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/11/25 03:41, Shin'ichiro Kawasaki wrote:
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") modified the evaluation criteria for the third argument,
> 'ioerror', in the blk_mq_add_to_batch() function. Initially, the
> function had checked if 'ioerror' equals zero. Following the commit, it
> started checking for negative error values, with the presumption that
> such values, for instance -EIO, would be passed in.
> 
> However, blk_mq_add_to_batch() callers do not pass negative error
> values. Instead, they pass status codes defined in various ways:
> 
> - NVMe PCI and Apple drivers pass NVMe status code
> - virtio_blk driver passes the virtblk request header status byte
> - null_blk driver passes blk_status_t
> 
> These codes are either zero or positive, therefore the revised check
> fails to function as intended. Specifically, with the NVMe PCI driver,
> this modification led to the failure of the blktests test case nvme/039.
> In this test scenario, errors are artificially injected to the NVMe
> driver, resulting in positive NVMe status codes passed to
> blk_mq_add_to_batch(), which unexpectedly processes the failed I/O in a
> batch. Hence the failure.
> 
> To correct the ioerror check within blk_mq_add_to_batch(), make all
> callers to uniformly pass the argument as blk_status_t. Modify the
> callers to translate their specific status codes into blk_status_t. For
> this translation, export the helper function nvme_error_status(). Adjust
> blk_mq_add_to_batch() to translate blk_status_t back into the error
> number for the appropriate check.
> 
> Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/block/null_blk/main.c | 2 +-
>   drivers/block/virtio_blk.c    | 5 +++--
>   drivers/nvme/host/apple.c     | 3 ++-
>   drivers/nvme/host/core.c      | 3 ++-
>   drivers/nvme/host/nvme.h      | 1 +
>   drivers/nvme/host/pci.c       | 5 +++--
>   include/linux/blk-mq.h        | 5 +++--
>   7 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index d94ef37480bd..31f23f6a8ed0 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1549,7 +1549,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   		cmd = blk_mq_rq_to_pdu(req);
>   		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
>   						blk_rq_sectors(req));
> -		if (!blk_mq_add_to_batch(req, iob, (__force int) cmd->error,
> +		if (!blk_mq_add_to_batch(req, iob, cmd->error,
>   					blk_mq_end_request_batch))
>   			blk_mq_end_request(req, cmd->error);
>   		nr++;
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6a61ec35f426..74f73cb8becd 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1207,11 +1207,12 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   
>   	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
>   		struct request *req = blk_mq_rq_from_pdu(vbr);
> +		u8 status = virtblk_vbr_status(vbr);
>   
>   		found++;
>   		if (!blk_mq_complete_request_remote(req) &&
> -		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
> -						virtblk_complete_batch))
> +		    !blk_mq_add_to_batch(req, iob, virtblk_result(status),
> +					 virtblk_complete_batch))
>   			virtblk_request_done(req);
>   	}
>   
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index a060f69558e7..ae859f772485 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -599,7 +599,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
>   	}
>   
>   	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
> -	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
> +	    !blk_mq_add_to_batch(req, iob,
> +				 nvme_error_status(nvme_req(req)->status),
>   				 apple_nvme_complete_batch))
>   		apple_nvme_complete_rq(req);
>   }
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8359d0aa0e44..725f2052bcb2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -274,7 +274,7 @@ void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
>   	nvme_put_ctrl(ctrl);
>   }
>   
> -static blk_status_t nvme_error_status(u16 status)
> +blk_status_t nvme_error_status(u16 status)
>   {
>   	switch (status & NVME_SCT_SC_MASK) {
>   	case NVME_SC_SUCCESS:
> @@ -315,6 +315,7 @@ static blk_status_t nvme_error_status(u16 status)
>   		return BLK_STS_IOERR;
>   	}
>   }
> +EXPORT_SYMBOL_GPL(nvme_error_status);
>   
>   static void nvme_retry_req(struct request *req)
>   {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 7be92d07430e..4e166da4aa81 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -904,6 +904,7 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
>   int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
> +blk_status_t nvme_error_status(u16 status);
>   void nvme_queue_scan(struct nvme_ctrl *ctrl);
>   int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
>   		void *log, size_t size, u64 offset);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 640590b21728..873564efc346 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1130,8 +1130,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
>   
>   	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>   	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
> -	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
> -					nvme_pci_complete_batch))
> +	    !blk_mq_add_to_batch(req, iob,
> +				 nvme_error_status(nvme_req(req)->status),
> +				 nvme_pci_complete_batch))
>   		nvme_pci_complete_rq(req);
>   }
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 71f4f0cc3dac..9ba479a52ce7 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -857,7 +857,8 @@ static inline bool blk_mq_is_reserved_rq(struct request *rq)
>    * ->end_io handler.
>    */
>   static inline bool blk_mq_add_to_batch(struct request *req,
> -				       struct io_comp_batch *iob, int ioerror,
> +				       struct io_comp_batch *iob,
> +				       blk_status_t status,
>   				       void (*complete)(struct io_comp_batch *))
>   {
>   	/*
> @@ -874,7 +875,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
>   	if (!blk_rq_is_passthrough(req)) {
>   		if (req->end_io)
>   			return false;
> -		if (ioerror < 0)
> +		if (blk_status_to_errno(status) < 0)
>   			return false;
>   	}
>   
That feels a bit odd; errno will always be negative, so we really are 
just checking if it's non-zero. Maybe it's better to use a 'bool' value
here, that would avoid all the rather pointless casting, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
