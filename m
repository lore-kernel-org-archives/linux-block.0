Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267772;
	b=RtwGvNAfuIgc88goq19/ux6KuodHIUEQdN61339E4TuE9ar3d5+eLieOZSXZI4Qtf5cn
	 CDavG3j0v5tY3s95Fyd23ti1/D8O0Nt/zhdn5KQsfN3RIA7RgVGbDkIvGQyz9lr8N0lM9
	 gtbdhkQyUi8Fm/Vc6ulbwo6I/o3fbl7MWlZvuCdaamXj0qzEbo/OOrx+PZTrzSr1iSYcy
	 kyh5BQuUwX8goBLNXvQv6GY0bJdzl9jgJ4Acq5fmGYrnLFq7eSLX/FnkPx4qhvcYl1tmJ
	 veZj6lxQZzF9j3hEyOifLfIwKwaL3ea4KKzy7WRa9KCdIznWY7KdST1V0l13prk5CDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267772;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=2krgP6xNFdgW4kePFRwwk2gluKvyTYl8JVGr1lFY0yQ=;
	b=RWW+aZvFMQC5EehifSY/Egb0jLoaDJFKG6PASCJTjqfp8009p6SPKRC4sAX3b0A7JvB3
	 bMoRgfmXOgOTw83VVTvbWtxrETR7VbStNDlycKiOiGTbh9ZbvkE4hVoLEuhWaoEMBTxHd
	 UpchC/qtDzO/CDo7cdQYsZjm73XeSxQ6Cu/WMgrW7dhJVlJBU3uPeFS+vktYaZ6hoJ45f
	 zhzbciAyrUbl0ziH6iN4iVmMwDcdKV+4vcxVrPFwSHy5BCkr4RPW91JCc2PnwlpWYy5y4
	 Td5B9MzDLtSVmrzloYAZYZy+q1tVvKDLIkX2HeM+StY0wg61pXnu0PJRsUh4ugHE/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="OdeamV/f";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uY7GFNCC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L0luIT48;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IkScYBio;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0E606A329
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A0E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OdeamV/f;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uY7GFNCC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L0luIT48;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IkScYBio
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DEB31F8B4;
	Thu, 29 Oct 2026 09:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2krgP6xNFdgW4kePFRwwk2gluKvyTYl8JVGr1lFY0yQ=;
	b=OdeamV/fySi9RZYHKYOs6N0tTZyAFoXMIB9QKK39PlEqQToiYvisBnBgo9MGfbuMFy2el/
	JZRgKl7N+KOaAcaz0I+IauYbaFf75/oYMwApU4WY/PCPV4JxHQwZaWWD+cc8Se/mx11ux3
	5lVV/6U2HZgnxNRlQ/NgdSdw0tFcwWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2krgP6xNFdgW4kePFRwwk2gluKvyTYl8JVGr1lFY0yQ=;
	b=uY7GFNCCeAxte3QDiTpTAb4humlcMffM6pNtvOgPqQUay7qJROevEe5iisI2kXnfZAG66+
	TRvBUQHKMUb+OjAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2krgP6xNFdgW4kePFRwwk2gluKvyTYl8JVGr1lFY0yQ=;
	b=L0luIT48i+ho4SVJh1sTLTdlawkYD5hWqG63wca5TvKSIgRwqHJjHT/JnQBZdVH8MiadQe
	Z7j+4LsKcHVlrz8mF5cWbxa2Jsm4oGWczRC1l9KzfrFRk3HXO13gbbJfJbG17wU4rpt/wR
	DqDkhxkCJQbNdZwP1wK7RNEcj/qmCwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2krgP6xNFdgW4kePFRwwk2gluKvyTYl8JVGr1lFY0yQ=;
	b=IkScYBioSQxLOwJXJyj36B5xoEL8MtYpB/vaiVg6VnbseMKBS04IsAZbfRxg/gVODta7mN
	Ipczl1s4zDtX4oCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B33B13419;
	Thu, 29 Oct 2026 09:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vlm/DTcY42pRIQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:56:07 +0000
Message-ID: <86af69f3-2fd6-4a37-b89f-24e94c44a450@suse.de>
Date: Thu, 29 Oct 2026 10:56:06 +0100
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
Subject: Re: [PATCH 66/98] nvmet-auth: free the old data on a new
 AUTH_Negotiate
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-67-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-67-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,toxicpanda.com:email,grimberg.me:email,imap1.dmz-prg2.suse.org:helo,kernel.dk:email,suse.de:email,nvidia.com:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A host may restart the negotiation at any step. The challenge and the
> session key of the abandoned transaction stay in the queue, and
> nvmet_auth_challenge() and nvmet_auth_ctrl_sesskey() overwrite the
> pointers with new allocations, leaking one or two hash-sized buffers per
> round for anyone who can reach the port. The controller challenge stays
> too, and if the new transaction brings none but asks for the
> controller's response, the old one is hashed with the new hash length:
> 
>    BUG: KASAN: slab-out-of-bounds in nvmet_auth_ctrl_hash+0x2d5/0x4b0
> 
> Free the old transaction's data when a new one begins.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 5ab943256f38..665c56d29d07 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -336,6 +336,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   			/* Restart negotiation */
>   			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
>   				 __func__, ctrl->cntlid, req->sq->qid);
> +			nvmet_auth_sq_free(req->sq);
>   			if (!req->sq->qid) {
>   				dhchap_status = nvmet_setup_auth(ctrl, req->sq,
>   								 true);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
