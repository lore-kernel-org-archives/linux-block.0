Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267626;
	b=itTIlT4J41Mda2hKn1OK7Zd+VPZ8rJqDEMdZ40qCfFO7jUYQOnYXcegR1qNs9Bzroe4o
	 hlTZGDSzMLiJge5se8HSFQbkoD+Wu4qYnakh43VyhmZ9KXEnEY9eiZUwk+psBZAdBghot
	 9f364QLHyBbZHZM3rGcBgrrjY2mtwodsqFnm5kxspk/Tgac3z124cxKGP8wASVl3GW6WU
	 9QfnNNJmJ5sQ/ekrS6cSalej7ylABDGHSNcS9rALXCF0whvxifKA9HjzST1J0Fhvbenda
	 0YiU7WHqXmRJs8Bi1r21HdMXsEsWE1crOLPJ4nToNxO1k3TmDKjOXb9cLVg1oo+bZMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267626;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=PLffGP/ekaNKwWvJQk8X1fdGv8EC5DMYcbmF+Guj7BU=;
	b=hoF3t18F8iVLMmroEeZmS8VYtZ+GZo4qNqD0wocP2zUgGYFt1L9YYR9u4t8hEaNonOuU
	 Sqyt4hFYplKSTnJgbDhDh+5RY7xnQBLI+ZUGQ3W5v1zkfkb6MhY8cr/+pHhhlWahrphZl
	 aINcsD3GChYRKVP+2eSS4bq/G9e4OwlPzO5rNaCEXGQwuwePhuJxW6PED9Zm3Ofq48EU8
	 9RydBtoWbGXyZuxzK2c97ncbXqS8YAnnRzdCHy1QZnb3y6kc9CkFvclNi6vvnwU7vcO9k
	 O+src18a5ggZI5/NEXycijh7nb5BnFrUfPBrcVNXm79iev0XUO7bUUQqW58rPpTX0KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OEMKAAfD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aFj2MZgf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OEMKAAfD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aFj2MZgf;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A5606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F6A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OEMKAAfD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aFj2MZgf;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OEMKAAfD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aFj2MZgf
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9978D1F8B4;
	Thu, 29 Oct 2026 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLffGP/ekaNKwWvJQk8X1fdGv8EC5DMYcbmF+Guj7BU=;
	b=OEMKAAfDbvqVKZaIibinjLz618oGjFOgbIzzPC7tYHmfREDrCkuc/bh3VMRZtnN5w2vmyl
	kuM3FbA3NkGEaJJtugLFsmLsZjDIkaVnOsHLak1KERp6VsFxXU4EE5I7C6CfoaoLATDu8A
	edKDzNbB4Q7BLyhgv8ibKCq28XPTQBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLffGP/ekaNKwWvJQk8X1fdGv8EC5DMYcbmF+Guj7BU=;
	b=aFj2MZgfksq4z9XR1zAW/CfyfF3UFQ+2dLY2z4FPv0ADiDoB0cXHf+uZm+9c+/C+zFBNvc
	TFZ9j//7TZ121SCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OEMKAAfD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aFj2MZgf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLffGP/ekaNKwWvJQk8X1fdGv8EC5DMYcbmF+Guj7BU=;
	b=OEMKAAfDbvqVKZaIibinjLz618oGjFOgbIzzPC7tYHmfREDrCkuc/bh3VMRZtnN5w2vmyl
	kuM3FbA3NkGEaJJtugLFsmLsZjDIkaVnOsHLak1KERp6VsFxXU4EE5I7C6CfoaoLATDu8A
	edKDzNbB4Q7BLyhgv8ibKCq28XPTQBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLffGP/ekaNKwWvJQk8X1fdGv8EC5DMYcbmF+Guj7BU=;
	b=aFj2MZgfksq4z9XR1zAW/CfyfF3UFQ+2dLY2z4FPv0ADiDoB0cXHf+uZm+9c+/C+zFBNvc
	TFZ9j//7TZ121SCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6650913419;
	Thu, 29 Oct 2026 09:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sypNEKcX42rPHgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:53:43 +0000
Message-ID: <3b2bd6eb-12dc-4d1e-9df2-6b03af225042@suse.de>
Date: Thu, 29 Oct 2026 10:53:43 +0100
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
Subject: Re: [PATCH 64/98] nvmet-auth: keep the old keys if the new ones fail
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-65-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-65-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9978D1F8B4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,nvidia.com:email,kernel.dk:email,lst.de:email,grimberg.me:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> AUTH_Negotiate on the admin queue has nvmet_setup_auth() reload the
> host's keys, and it frees the old host key first. If decoding the new
> secret fails, or an allocation does, the controller is left without a
> host key, which means no authentication at all: nvmet_check_auth_status()
> passes everything and I/O queue Connects no longer ask for it. configfs
> accepts any string starting with "DHHC-1:" and a digit, so one typo
> while changing a secret opens the namespaces to any connected admin
> queue.
> 
> Decode the new keys first and only then replace the old ones.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/auth.c | 69 ++++++++++++++++----------------------
>   1 file changed, 28 insertions(+), 41 deletions(-)
> 
That discussion again. I give in.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
