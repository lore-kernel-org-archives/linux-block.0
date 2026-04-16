Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77521DA60D
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320178; cv=none; b=jbZW/ktsMxKeeuEBLsIA+F53zYdG3x3GsVJCTvEMwCpVKFCWSquPj/kbEAQ31LChd6b5emgu+KY3msVpAtqdJnPQXa6PyD9FOPWuF6CkkI3FXGcL9vbd5SE3VoA9tKySBlslz5Gnpu4IOaRYnd2TM5Mu4UyrkbksiSb/L7nXq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320178; c=relaxed/simple;
	bh=UWMoArUK2EnVelx7DdIZpUVFJLKVibiVK81zirIWkeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhyedH6tKYddBAi6HvILdsW8kuD9uaicGoVTs7AcvXbwqcVZCBONSfDbrXOPN8TmCuILJkQEOtb6OEsYlMFyksmYt51jBaSaStyjgnRpsiKiVh3tFfsbRCTpipAL8hStklQBjUDqaVEgr7ltgcLOd5YqGyTVfiyo1djfyvcsNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uh1JFQAW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ds5S99fO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uh1JFQAW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ds5S99fO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uh1JFQAW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ds5S99fO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uh1JFQAW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ds5S99fO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF6585BD23;
	Thu, 16 Apr 2026 06:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776320175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf3Qca5Ycm9l2bpz9W6+zkdVpYag1La217tkow0nwA=;
	b=Uh1JFQAWCnJBUZGTTHr/LUGNjZpaFZ47lz+RKiot/Gbz3qr3/PqdmgVkJBjAbbHNF5KqKi
	pd+y1TlTpl24B2UNvUTtJFdK+dvfyPvJM+Ifn05kH8Q2FLb2XgMp5wgtNZj7u8WdERb9TP
	GWXf37JUrujNbAdzLJ4u6frwU2Cq6Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776320175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf3Qca5Ycm9l2bpz9W6+zkdVpYag1La217tkow0nwA=;
	b=ds5S99fOy6hbqvPIa9lnLWOL9YoIP7SaUgiNldocVI0bOzGEeUsIn2uXDF2zvr6zqrsT6L
	pZCxwL/NO+P5tlDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uh1JFQAW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ds5S99fO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776320175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf3Qca5Ycm9l2bpz9W6+zkdVpYag1La217tkow0nwA=;
	b=Uh1JFQAWCnJBUZGTTHr/LUGNjZpaFZ47lz+RKiot/Gbz3qr3/PqdmgVkJBjAbbHNF5KqKi
	pd+y1TlTpl24B2UNvUTtJFdK+dvfyPvJM+Ifn05kH8Q2FLb2XgMp5wgtNZj7u8WdERb9TP
	GWXf37JUrujNbAdzLJ4u6frwU2Cq6Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776320175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf3Qca5Ycm9l2bpz9W6+zkdVpYag1La217tkow0nwA=;
	b=ds5S99fOy6hbqvPIa9lnLWOL9YoIP7SaUgiNldocVI0bOzGEeUsIn2uXDF2zvr6zqrsT6L
	pZCxwL/NO+P5tlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 807DB4BDF6;
	Thu, 16 Apr 2026 06:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qArQHK5+4Gn2KAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 16 Apr 2026 06:16:14 +0000
Message-ID: <959f800d-b92e-406e-a174-680fb09c884e@suse.de>
Date: Thu, 16 Apr 2026 08:16:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing new
 ones
To: alistair23@gmail.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, yi.zhang@redhat.com, mlombard@arkamax.eu,
 linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
References: <20260415230250.2783414-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260415230250.2783414-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com,kernel.org,lists.infradead.org,vger.kernel.org,redhat.com,arkamax.eu];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:server fail];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: CF6585BD23
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

On 4/16/26 01:02, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Previously after the host sends a REPLACETLSPSK we freed the TLS keys as
> part of calling nvmet_auth_sq_free() on success. A recent change ensured
> we don't free the keys, allowing REPLACETLSPSK to work.
> 
> But that fix results in a kernel memory leak when running
> 
> ```
> nvme_trtype=loop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045 nvme/051 nvme/052
> echo scan > /sys/kernel/debug/kmemleak
> cat /sys/kernel/debug/kmemleak
> ```
> 
> We can't free the keys on a successful DHCHAP operation, otherwise the
> next REPLACETLSPSK will fail, so instead let's free them before we
> replace them as part of nvmet_auth_challenge().
> 
> This ensures that REPLACETLSPSK works, while also avoiding any memory
> leaks.
> 
> Fixes: 2e6eb6b277f59 ("nvmet-tcp: Don't free SQ on authentication success")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index b9ab80c7a6941..58185184478a4 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -412,6 +412,13 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
>   	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
>   	int data_size = sizeof(*d) + hash_len;
>   
> +	/*
> +	 * If replacing the keys then we have previous successful keys
> +	 * that might be leaked, so we need to free them here.
> +	 */
> +	if (req->sq->dhchap_c1)
> +		nvmet_auth_sq_free(req->sq);
> +
>   	if (ctrl->dh_tfm)
>   		data_size += ctrl->dh_keysize;
>   	if (al < data_size) {
I am not sure.
The authentication variables should be freed as soon as the 
authentication completes; the session key is ephemeral and
should not be stored longer than necessary and will _never_
be used again once authentication completes.
The TLS key, OTOH, is used throughout the session and needs
to be present while the session is active
As such, both sets have vastly different lifetimes, and
I would argue that this

void nvmet_auth_sq_free(struct nvmet_sq *sq)
{
	cancel_delayed_work(&sq->auth_expired_work);
#ifdef CONFIG_NVME_TARGET_TCP_TLS
	sq->tls_key = NULL;
#endif
	kfree(sq->dhchap_c1);
	sq->dhchap_c1 = NULL;

is actually wrong as we should not modify 'tls_key' here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
