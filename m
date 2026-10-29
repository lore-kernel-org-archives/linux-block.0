Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259517;
	b=Oh5AEEQFQFTiOfLs9HKyHa9vH2AscqQ9KsJMZGKvc/ZV/YEo3GI2p1SWkdDYXoM89Pap
	 L9FcL/iWnKCXiLg7eu9jpZiUIzhARSmTxDKjpgFDLT5lP7///TKzjm7SYb6wYabUTjXAb
	 lhjwAe0CpIJtrMf/gg7KFxPZC24VPrTr1b6hrlVbyy+oHUxiUXhIyGuY11HE2x7lcdqmk
	 V+jccdOMp1urSyGI4pVHaCIVPB5X98+mP8gmTu4a310BaA3n/AcvRvLRB4AB8kDtV5B74
	 z+aaYf0I43ppDZyoH6qmUomKSSKW+54W2GDpNtnTK3pxvDAzN4PUsdYj4aze9QUte6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259517;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=e3frSo3K/Jd1hv8KRpaPeuDUFMDu6v7jRO6OAQZ6Aec=;
	b=zCiIavHdIzUgIejXZEF7wnYI2/pWYA+RMH7Jnt2sAH+dEKJfC4mwu410kQHVR87LwXOn
	 BKh/r9xPiblyEvNg+bN+xJmKZQ5qXJGs5iFI0yKe1vEx0SUNcdlKObyT4GDFg1CATY02l
	 EYstDnvJPn2Vc7WY8/kBGNY7qFYPvmsg9dk8+90uSBZhnnYXktPIZ8f100KgkrPLJTJOf
	 nuIHacpznuhPXIgz1pFS2Mr8Y5FX5dW6dNeJZ+c1Kr/Jxg2jGAkQNyQnpTs4JWop/6kMD
	 9cKbewGZFHIS/Bdi3GI/5VA632+3dgwBJa4RNS0oLTpw6fck1BF8cYD1eAfWxmHwHjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xYHEPqr3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d4KbX1F6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y2KUup2e;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=foeQCOgU;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9E606A323
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 07:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68F9E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xYHEPqr3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d4KbX1F6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y2KUup2e;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=foeQCOgU
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EC3C1F800;
	Thu, 29 Oct 2026 07:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793259509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3frSo3K/Jd1hv8KRpaPeuDUFMDu6v7jRO6OAQZ6Aec=;
	b=xYHEPqr3WNy/01A4spavlAdPKn4WCPGHo35JE7mARDbggLLfjyH+Wc3czSUJ0Z1Rb5c679
	DUt0uDqv3Ui+Nj+YanafJ8vVMXoLijYXT2m3pb173HUs5VBOTF0knaeHyDS6U9q1kb+xC+
	H3W+HhtkCBUN06k/3yiytH2Sj2UOhf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793259509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3frSo3K/Jd1hv8KRpaPeuDUFMDu6v7jRO6OAQZ6Aec=;
	b=d4KbX1F6364favyZPHiJC4/MqTwyXMl0kElka86nQWeVmfmNLRIv97fGHIjxnf1Ukckaan
	QuF6u5h35A6XRXAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y2KUup2e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=foeQCOgU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793259507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3frSo3K/Jd1hv8KRpaPeuDUFMDu6v7jRO6OAQZ6Aec=;
	b=y2KUup2eGvSKcw/C/s2vfKtDXolUP6khRDGrgwDWjfhlq2Lk4PI1JPXs7pVaT1jZ8ssWKe
	j06mpnoAVkmrMGGmpEmPp31CG19Znmk/GOlj01xXWNEpK1vyo5sdNSdBiC00q1Q2GIY+Jy
	x1RL2F4Bd1pI1eDMy/8yHMLmCo9Fe94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793259507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3frSo3K/Jd1hv8KRpaPeuDUFMDu6v7jRO6OAQZ6Aec=;
	b=foeQCOgUMfyJ3lDT6AOUhCma1xuIZ5m3L48RKHJM19PY/KfJx1IK/UWA9DHNTRT2/hu3lc
	Bm1mv8YWk1iN42CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5632113419;
	Thu, 29 Oct 2026 07:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ES4+C/P34mo/EAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 07:38:27 +0000
Message-ID: <54b9aa09-43a5-459a-b99b-1212c7fe94f8@suse.de>
Date: Thu, 29 Oct 2026 08:38:18 +0100
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
Subject: Re: [PATCH 49/98] nvmet-tcp: ask for the TLS record type on every
 receive
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-50-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-50-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,kernel.dk:email,suse.de:email,suse.de:dkim,toxicpanda.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,grimberg.me:email,nvidia.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 9EC3C1F800

On 10/28/26 5:41 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_tcp_alloc_cmd() points recv_msg.msg_control at recv_cbuf once.
> The first receive that stores a record type there advances msg_control
> and leaves msg_controllen at 0 for the lifetime of the command. From
> then on nvmet_tcp_try_recv_data() sees the record type of that first
> receive: if it was an alert, all later data is dropped as alerts and the
> queue stalls, if it was data, a later alert can't be reported and
> tls_sw_recvmsg() fails with -EIO.
> 
> Set up the control buffer before each receive, like the other receive
> paths do.
> 
> Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/tcp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a0d942c34d3a..261672ab5c1f 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1286,6 +1286,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   	int len, ret;
>   
>   	while (msg_data_left(&cmd->recv_msg)) {
> +		if (queue->tls_pskid) {
> +			/* The last receive has used it up */
> +			cmd->recv_msg.msg_control = cmd->recv_cbuf;
> +			cmd->recv_msg.msg_controllen = sizeof(cmd->recv_cbuf);
> +		}
>   		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>   			cmd->recv_msg.msg_flags);
>   		if (len <= 0)

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
