Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267147;
	b=wvAmCB9yBCV+QSpN9mskOEA7FJ4C7PQMwECgM7amppmV+VtEnmdacdf5pQaj2Oe6rm88
	 AvvvMAl3Lq0/d7YaT9VMsWaKIXC7/N85VC9qgukY1K1rLVIXenVOuNUc8SbM9zT5vjaGQ
	 bFKhePO0ZD5g41spSRcZocxLVZsxbrnZWaygOSEeF30K60fbvydhUFNLSSNvwWoZFHCEP
	 FPHWAWnmqU84V8368MkMRv+EuYFVAtVrw0+Jd6lE1WOaUqBra39l9nEEJosLHMX20b7kF
	 CNeJwUWPcQNp1ETXoaN1e+F+R2u4uDUyQlhk1UxpIDYihxfm0h5ckwBzPAQ113fxH/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267147;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=WKKx52pKQb/xonnDlM3YzDHvR0vsoonEj6I5BZisKzI=;
	b=GBDCflIJyrX5j05YFiGiy458aZvUnCqfHsMbqIV1Hx9hdaj0nQPIxRs7qe2lOjVCFEXY
	 fTWERiJZZX9B7UXcwg/8FqgvRfyws8XZb7WMl8ulsZx8eK0nysZdOYhRYH7D4W4vKwEpg
	 Vuu/V2Ul+tu8w9noLJPg7FSHox/VEEG+2EKLr1rkW/DhrZ7lJUGp+XRmycZ5aTuV8Ijb4
	 nwJTfQDV1RVDqVfvIqOz7LeHF6GJL8LYa7S+H/j2Jze1WJbvl94Hv1gOVYs/QjHRtIze/
	 w63SvU6aLCmIDKlVoQfDAtyQC3bRVf+JCjQj4bRdTf/fnGUaW4iIHfJ5tV/MmBm1jXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="jF/q/Tfh";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Vj1lgYYx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="jF/q/Tfh";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Vj1lgYYx;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA6606A323
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73EA6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jF/q/Tfh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Vj1lgYYx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jF/q/Tfh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Vj1lgYYx
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73D921FB0E;
	Thu, 29 Oct 2026 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKKx52pKQb/xonnDlM3YzDHvR0vsoonEj6I5BZisKzI=;
	b=jF/q/TfherXVpgytXhcULEb5QB3+VU1CWEmDcFrjolQWNqCzjoQ0ycidUB1u0/2dD54f6n
	0S9W+tBI0vH0tTF365opyOYbfVCD208nmXgpVMWc4TghvbVNhrVXNkZhLWh5Z73BV7aJ7B
	Mr+WpfA2prjiljFuDfyUK99RUVurZKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKKx52pKQb/xonnDlM3YzDHvR0vsoonEj6I5BZisKzI=;
	b=Vj1lgYYxcH+3bZjtPRkkBxfIx22IegLToZKCMw4GcVhdefpYI53gciSQYjk0gvefPHN8qW
	MwSfxj3BGO+dw+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKKx52pKQb/xonnDlM3YzDHvR0vsoonEj6I5BZisKzI=;
	b=jF/q/TfherXVpgytXhcULEb5QB3+VU1CWEmDcFrjolQWNqCzjoQ0ycidUB1u0/2dD54f6n
	0S9W+tBI0vH0tTF365opyOYbfVCD208nmXgpVMWc4TghvbVNhrVXNkZhLWh5Z73BV7aJ7B
	Mr+WpfA2prjiljFuDfyUK99RUVurZKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKKx52pKQb/xonnDlM3YzDHvR0vsoonEj6I5BZisKzI=;
	b=Vj1lgYYxcH+3bZjtPRkkBxfIx22IegLToZKCMw4GcVhdefpYI53gciSQYjk0gvefPHN8qW
	MwSfxj3BGO+dw+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EDBE13419;
	Thu, 29 Oct 2026 09:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GbUaBsgV42rjFgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:45:44 +0000
Message-ID: <8bc4ad79-e387-42dc-9cf5-066615178119@suse.de>
Date: Thu, 29 Oct 2026 10:45:43 +0100
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
Subject: Re: [PATCH 63/98] nvmet-auth: refuse a reply without a DH value
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-64-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-64-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,nvidia.com:email,imap1.dmz-prg2.suse.org:helo,kernel.dk:email,suse.de:email,lst.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> With a DH group configured, nvmet_auth_host_hash() augments the
> challenge with the queue's session key, but nvmet_auth_reply() only
> computes that key if the DH-HMAC-CHAP_Reply carries a DH value. Without
> one, whatever the queue holds is used: nothing on the first transaction,
> so the DH exchange is skipped, and after nvmet_auth_sq_free() a NULL
> pointer with the hash length still set:
> 
>    BUG: KASAN: null-ptr-deref in __hmac_sha256_preparekey+0xa5/0x250
>     nvme_auth_hmac+0xb7/0x160
>     nvmet_auth_host_hash+0x2a5/0x530
> 
> Refuse such a reply, as the host refuses a challenge without a DH value,
> and clear the length along with the pointer.
> 
> Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/auth.c             | 1 +
>   drivers/nvme/target/fabrics-cmd-auth.c | 3 +++
>   2 files changed, 4 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
