Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260187;
	b=MU63jUOtXMeInBXqEnGUewrjavwd5Oj5OaSArdbzRLMf92pUgVz1NYegYL0MwBzmlLh7
	 aEOpAjYiu5vNQg1wgh+5zydGMHp03mhgn95VDVG8LfZ+QW02SBLp4D0iX+TFweHcs9hVd
	 kP+/JoN00AQwk8I/WE2JDpuejTSfkn0HK1zyo9z1mSbnF8McvShQKmTSHZ531MptXjS7Y
	 az7GprObRT1FLtOMDjnbfFH0DoRqxlFyYhzVzFeELXyV9i9108mkxfj0cLL9v+RPzw3p2
	 y+RCvBXoFQbIm4D6J8Ii/u2bKj2QPjuxK9waTIVdZjL0y+XhkX1zglpkf1kdIgyrLjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260187;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=2Sklk1qiYFNNSBSDGtd0ZucPc6bm4vsA1VKYM668LVw=;
	b=DmoA23K17pxmVNqD9yTFc/RQklymYQU2onel0Qxzm1fbfsKXQ8Pc+ZnInNnfFgd7YY0h
	 U2TbEQBqnKh2c4KRJ5Yggx9b1y4YZ4fRWuSivmq9QPmnsWSYyrQB12g6PZ0TbD6+UzG0/
	 3JwdjH7/HZyHGPB9DyeW3CxhPVv0kKauBSE6GBTTwYHEPCjwktfwj6h6QSveJxCLV6He3
	 T7F9naWTVjbG3gEBOmRIuuNOMkhslyi9N0eJhn1HS2S+rpTwCJaA/+DkhR4FE6bXUDGni
	 UL3bdHOUuWHZKiRcxdLA8b+Y7fuKeYLq3vrNnoDRlrjPIEipW9zHnduE3F9Su+MPTVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bB+HsgHL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dtpwajp0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bB+HsgHL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dtpwajp0;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DF606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 07:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 979DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bB+HsgHL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dtpwajp0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bB+HsgHL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dtpwajp0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C863D1FAAB;
	Thu, 29 Oct 2026 07:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793260184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Sklk1qiYFNNSBSDGtd0ZucPc6bm4vsA1VKYM668LVw=;
	b=bB+HsgHLfbNGQKSvBDaN0yw8D6Mw30OrgelMqJyfFVVLgPCcs3K00lXUOEUyWAZPd2j6fw
	vU/6RCN13P8keK+u4AC1KOWPkxCdhhiWi588A3inqgVBjRYgiH4fQS0SCMxpo8uMaDsLid
	YTQit58rUArpFjA5OGzfaleRFDvuCiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793260184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Sklk1qiYFNNSBSDGtd0ZucPc6bm4vsA1VKYM668LVw=;
	b=dtpwajp032jhgVElq/rXkSJeJFQHG1XL2Gw32bbw41r5I3C0ZQcsZrtgf9gzhgOHzESL1j
	ObeXtcLdtPqQHODQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793260184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Sklk1qiYFNNSBSDGtd0ZucPc6bm4vsA1VKYM668LVw=;
	b=bB+HsgHLfbNGQKSvBDaN0yw8D6Mw30OrgelMqJyfFVVLgPCcs3K00lXUOEUyWAZPd2j6fw
	vU/6RCN13P8keK+u4AC1KOWPkxCdhhiWi588A3inqgVBjRYgiH4fQS0SCMxpo8uMaDsLid
	YTQit58rUArpFjA5OGzfaleRFDvuCiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793260184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Sklk1qiYFNNSBSDGtd0ZucPc6bm4vsA1VKYM668LVw=;
	b=dtpwajp032jhgVElq/rXkSJeJFQHG1XL2Gw32bbw41r5I3C0ZQcsZrtgf9gzhgOHzESL1j
	ObeXtcLdtPqQHODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8325C13419;
	Thu, 29 Oct 2026 07:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l99pFpj64mrhHQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 07:49:44 +0000
Message-ID: <6f651be7-8f3d-43cb-8457-0bbde67607fa@suse.de>
Date: Thu, 29 Oct 2026 08:49:40 +0100
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
Subject: Re: [PATCH 54/98] nvme-tcp: start error recovery after a TLS
 KeyUpdate
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-55-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-55-axboe@kernel.dk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,grimberg.me:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/28/26 5:41 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Once the controller sends a KeyUpdate, kTLS fails every receive with
> -EKEYEXPIRED until a new key is installed, and nobody on the host side
> does that. nvme_tcp_io_work() returns on the error and the queue is dead
> until a command or the keep-alive times out.
> 
> The connection is unusable at that point, say so and start error
> recovery right away.
> 
> Fixes: 0471b1093e3a ("tls: block decryption when a rekey is pending")
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/tcp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 87ecee0665c7..64f563686938 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1516,6 +1516,14 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	if (consumed == -EINVAL && nvme_tcp_queue_tls(queue) &&
>   	    queue->rd_enabled)
>   		consumed = nvme_tcp_recv_tls_ctrl(queue);
> +	if (consumed == -EKEYEXPIRED && queue->rd_enabled) {
> +		/* Nobody is going to install the new key */
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d: TLS KeyUpdate is not supported\n",
> +			nvme_tcp_queue_id(queue));
> +		queue->rd_enabled = false;
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +	}
>   	return consumed == -EAGAIN ? 0 : consumed;
>   }
>   

Already been reported 
(https://lore.kernel.org/linux-nvme/20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com/).
Please drop.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
