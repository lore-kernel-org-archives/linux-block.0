Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268829;
	b=4CgmQnN/ZOZlZD1dRE+Zl3F8LjBJD9VPwRFHmN6eJvKnBJrcWcnMKIZPcGr3Ovrwk/Gg
	 YLw8WLwgWERQsh9yg827mLP1UmQulBcnmjSpzFUU+64eIBB4rJ+RSg/Xfj4FH1cjMEa7E
	 p1skzlT6bp09BDWVeZk+PcfG18BG4NVi0SltAKPv4wv+swglecDTQxoVxOJZvf9NBhZLp
	 NZRIyEwa/4nl2M8MYNHOQc7Kiz9Dq6vxKBHgBIRl0+jrZU5xjvQWaKYEQMtjonj9lMFGo
	 hHbjSLRinDyYuqCpTowhAOMUC58ZbAXCQq14YKR18j9yt2Daboprk6SmWLNSkzAbJ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268829;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=jswrBbc4wIA3i0ccj7BaoOE+8U8fJZ5OdkyS4uF+c50=;
	b=b7QhkSz5WLLrEBVRky19bQr0m0prCi1D9/mLigkOp356501HRcbbalsfRn4JYb0H2S4j
	 kPSbhehz9ootwqfWi5wtWSUbyYhDAc6By884htBztyTY15mOnvIEAusR7A35UvgmbT+4J
	 YNmk5LxC/pwr3xEaBEJC6fKlYWyH2RsHH6oGYfe9Kv7PhHfsizOdunLs6Pcuwbl5J3pLx
	 0oxUDQeXhKaE7rQXldRK0T3TCEGJc2ROhGwKmZe4iwtFatMMYwcrh0m5NG/28HSutIcu+
	 ijIHt0XvQAtvn19fIrZ4endE0KbSgSubCdt7gC5KQPc7IDE7iowgeb/crhbaVZBPDvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ob2MzoKX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ED7zuweE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ob2MzoKX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ED7zuweE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99A606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E99A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ob2MzoKX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ED7zuweE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ob2MzoKX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ED7zuweE
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C76C22165;
	Thu, 29 Oct 2026 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jswrBbc4wIA3i0ccj7BaoOE+8U8fJZ5OdkyS4uF+c50=;
	b=Ob2MzoKX1tvcAnduZLdfuEr/XQ7N1V5do5g7KpVHzgxzimBzlwy5NjymyoNvAfcCE2N0Re
	RSwoWtghcEdTBfpZbMKBlNILhMwj/p+99HCYf+lkLRCm5/1AtmG3nzfTGSTp8+gGp3h1C4
	lPo0SLFRpgjbPjojAWpTMJ7h2rrrwqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jswrBbc4wIA3i0ccj7BaoOE+8U8fJZ5OdkyS4uF+c50=;
	b=ED7zuweEoQN2MX0+KycTEroScljniU7wwSiIHLWLIJ0EZB36D8TsYbNl+Qg/c1ktOz2piR
	9Mklv4CIftp8ciAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ob2MzoKX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ED7zuweE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jswrBbc4wIA3i0ccj7BaoOE+8U8fJZ5OdkyS4uF+c50=;
	b=Ob2MzoKX1tvcAnduZLdfuEr/XQ7N1V5do5g7KpVHzgxzimBzlwy5NjymyoNvAfcCE2N0Re
	RSwoWtghcEdTBfpZbMKBlNILhMwj/p+99HCYf+lkLRCm5/1AtmG3nzfTGSTp8+gGp3h1C4
	lPo0SLFRpgjbPjojAWpTMJ7h2rrrwqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jswrBbc4wIA3i0ccj7BaoOE+8U8fJZ5OdkyS4uF+c50=;
	b=ED7zuweEoQN2MX0+KycTEroScljniU7wwSiIHLWLIJ0EZB36D8TsYbNl+Qg/c1ktOz2piR
	9Mklv4CIftp8ciAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5427313419;
	Thu, 29 Oct 2026 10:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GvoNDFoc42q4MwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:13:46 +0000
Message-ID: <e9049b98-413c-41a6-933e-eea51fdfda18@suse.de>
Date: Thu, 29 Oct 2026 11:13:45 +0100
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
Subject: Re: [PATCH 98/98] nvmet: don't clear sq->ctrl for a Connect with
 sqsize 0
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-99-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-99-axboe@kernel.dk>
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
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,grimberg.me:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,nvidia.com:email,suse.de:email,suse.de:dkim,kernel.dk:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 8C76C22165

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Chris Mason <mason@kernel.org>
> 
> nvmet_install_queue() checks sqsize first and jumps to err on zero,
> where sq->ctrl is set to NULL. Since commit b71df12605ca the cmpxchg()
> that sets sq->ctrl comes after the checks, so err now undoes a bind
> that this call never made. Over RDMA a host can send two Connects
> together and the second is parsed before the first executes, so a
> second Connect with sqsize 0 clears the sq->ctrl the first one set.
> The reference it held is never dropped and the controller leaks, with
> its cntlid, until reboot. The discovery subsystem lets any host do
> that, 20 connections leak around 10 controllers. A pending AER on such
> a queue hangs nvmet_sq_destroy() forever, and a queue can keep its
> "authenticated" mark across a rebind.
> 
> Return the status directly, as the two checks after it do, so err is
> only reached after this call's cmpxchg() succeeded.
> 
> Fixes: b71df12605ca ("nvmet: avoid duplicate qid in connect cmd")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 089e3082c388..5614849edece 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -186,8 +186,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   		pr_warn("queue size zero!\n");
>   		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
>   		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
> -		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
> -		goto err;
> +		return NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
>   	}
>   
>   	if (ctrl->sqs[qid] != NULL) {

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
