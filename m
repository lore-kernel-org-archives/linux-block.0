Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267852;
	b=QHUa1j65oaBfNUdUkZvqFDoMNSLE0CuXt/AOUoAGjK9CyCstzVr5midr5YLRwdjS4z2M
	 u5s/KzaJ9Bd0YwLn6blUNmcaA//cYHHwUyf4mddtSMh0MzDKrVtK+hHSPTthNxFC1T/YF
	 FJZAlnUyawfba3C7N641l42pf9xQV756oGBZKvPAt4Yx/JXeZ0XOAmqxB3ihND64v/9Ui
	 zHl0Y5z6cURjICXC1rdURNkqN7cOVq7ffyLovFqQ9Kdg/SsVJFrgF9hqUCwjIqoAmg89Z
	 ZYbVqjNVYNh3yxmiwQuhjBQvzB9wJvKaaVOezQfZWWjdSsawcvNfLXplil9fx4xk/Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267852;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=AJHxuucRnmJDC7r0YW5rNn7KQEtD8Qi5SIib1MyiRAk=;
	b=H9ahhBWskj2IaLhcsLc2vjy92zXbcyt7vfzVVB9rwUZdThDROEypHkUW4GfMfWhjZWHK
	 JhMKZfjuSNin+SlR1qgQF93nNk7dCjS/fnV/41gC39Zk3z1D44stkCQq+AyXddGveF+5P
	 44t5L+u22aUIwT9rFqWugbiRSyH4W3RjlQC3h5YOvTanGpCS1oLL1TcPsB79jPtQRpxK4
	 HwlNDp1WtlFwQ2MYaQXz2vvTJLD9NubFxsoRnyS/ilYuMMyU4KIT2knQS8tJECmZSOloP
	 1sqYdFD4K1gyPoheRutiL0tlzBxlZ3/HRqTwQKqwB3BiKl8R2+hcsdjtP/Uoz/vZq0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XM+5Bgn7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="Cv/5Pu2G";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gy5nvDK9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=T4JUpZIQ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD9606A335
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22DD9606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XM+5Bgn7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Cv/5Pu2G;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gy5nvDK9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=T4JUpZIQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BE631FB40;
	Thu, 29 Oct 2026 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJHxuucRnmJDC7r0YW5rNn7KQEtD8Qi5SIib1MyiRAk=;
	b=XM+5Bgn77jIrUKjtH6DG/fU6eit9CPTfVOugj968NNCyigz6dDl+sREaAyY5BgoCjFV7Ps
	bpyD3vgrGjB29j8EtN7jsk6NdkxCW/3C9q2PhdX15zXAY2WCWimhEccbTe7J3ztNhiwXcd
	nI+lG0j9SpKQvRC4/rAvLGbskFiJuy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJHxuucRnmJDC7r0YW5rNn7KQEtD8Qi5SIib1MyiRAk=;
	b=Cv/5Pu2GG3xSqwVxU/A0i/3J3fD4ZbD/beH81N6N1YPAnIpi9CMeFoSo+4Q2VAbBOvh2Q8
	mKl6RwPvRjOzfYBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJHxuucRnmJDC7r0YW5rNn7KQEtD8Qi5SIib1MyiRAk=;
	b=gy5nvDK9ZPGKHi25A1sztbRVf1V+3Lu401/DIWiMWFXh4dJQN9krlwNjR0TZ4lBzB5QBei
	wrJk659cuCEKWrpvzVS+96j17qgOxJ+orsTW9v+bc/QtbwNITGa7/2MHE4RmUxT7lfQbU9
	Cd4B9hv/ryYhC44Pnw1XwYcpbWQVMrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJHxuucRnmJDC7r0YW5rNn7KQEtD8Qi5SIib1MyiRAk=;
	b=T4JUpZIQpkngLahzlTQKETagiEMQWDZNgmM7uoqAKScJ7KFdW5piapNQdOj4PPVW3GlEek
	t9dUNAVV/CzfG4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F033D13419;
	Thu, 29 Oct 2026 09:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZuSBMYgY42pOIgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:57:28 +0000
Message-ID: <3bbb1f9e-76f4-4ed7-b2dc-7f5eb35854e3@suse.de>
Date: Thu, 29 Oct 2026 10:57:28 +0100
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
Subject: Re: [PATCH 67/98] nvmet-auth: fix the check of the offered DH groups
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-68-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-68-axboe@kernel.dk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,toxicpanda.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo,grimberg.me:email,kernel.dk:email,nvidia.com:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_auth_negotiate() matches the first DH group in the host's list
> that is NOT the configured one, and looks for a fallback among those
> that are. So a host offering only groups the target isn't configured
> for passes and gets a challenge for a group it never offered, while a
> host offering only the NULL group is refused by a target configured for
> NULL, since there's no KPP algorithm to fall back to. A fallback can't
> work anyway, the DH context and public key belong to the configured
> group.
> 
> Accept if the configured group is in the list, fail with "DH group
> unusable" otherwise.
> 
> Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 27 +++++---------------------
>   1 file changed, 5 insertions(+), 22 deletions(-)
> 
Yeah, the fallback idea was not great.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
