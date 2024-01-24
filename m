Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB0FC11
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077280; cv=none; b=mbCzUlwUC01tyWnc5hxam3arSYcDJzN1E1//f4Fx2ki/pfELHObMKMaPYc7VFE8p8kFY4mMaKL3tBeAQS7ZmN3Hg29xqiXww1XEoYlbplTgux86IAUbeXI8hSDy8CeZWWSRixGhjzNK6e/6PFrkTfNu7OkvAYbGzQv0vzDyrMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077280; c=relaxed/simple;
	bh=L8dZhjvPYjoAOCMTKvPYEq2JDam1F5vhXHGnUhCuDSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kov3LLvdenefTUbF/PG1EjxPtPg2ZZIAlnKQRGfvdxdC4b9PKYeuFWHHKKds04ox7Sm5SkqzhensoHwfPal1DmQhlsXZjQS8jtxjVeAaKhPK/Z9g+FKv4ku2ecXewKv3IS/8Yqf55VUA0Li8JtIwa8u9BmORxdWxEawtZ3Z9X84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qO6tMkW7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5VAiIp1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qO6tMkW7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5VAiIp1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qO6tMkW7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5VAiIp1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qO6tMkW7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5VAiIp1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B60E21F7DA;
	Wed, 24 Jan 2024 06:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5fq4imHydp97gTe2Jr7kTN1f5RYnxULwDwDFQNlEr8=;
	b=qO6tMkW7oYH/NFDmbggRYWahrjZy5leE3ineQMEQeKsZnpzJ2t5Gl1cYSRkasxpUDsrpt3
	60ukVIo+PWR5hMVn+8iynzTeR6AiVZd3GXJinfC3mw2xlJ1QbF7JcMyGGDMNwjGuWLcppF
	9jddWZfUwb6+OTEj9juCJHAGeNNQRJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5fq4imHydp97gTe2Jr7kTN1f5RYnxULwDwDFQNlEr8=;
	b=s5VAiIp1iY5QXniw+jI4Vz9HhAR9Qkp7R3xu+TG4ZwKppCKrAHbF4LkVjKsEl78Fp0yQTn
	S8iHIXCkl+oCnmDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5fq4imHydp97gTe2Jr7kTN1f5RYnxULwDwDFQNlEr8=;
	b=qO6tMkW7oYH/NFDmbggRYWahrjZy5leE3ineQMEQeKsZnpzJ2t5Gl1cYSRkasxpUDsrpt3
	60ukVIo+PWR5hMVn+8iynzTeR6AiVZd3GXJinfC3mw2xlJ1QbF7JcMyGGDMNwjGuWLcppF
	9jddWZfUwb6+OTEj9juCJHAGeNNQRJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5fq4imHydp97gTe2Jr7kTN1f5RYnxULwDwDFQNlEr8=;
	b=s5VAiIp1iY5QXniw+jI4Vz9HhAR9Qkp7R3xu+TG4ZwKppCKrAHbF4LkVjKsEl78Fp0yQTn
	S8iHIXCkl+oCnmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34C801333E;
	Wed, 24 Jan 2024 06:21:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vn/XClyssGWZSQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:21:16 +0000
Message-ID: <286d369d-4f69-401a-9c9c-78f21575dad8@suse.de>
Date: Wed, 24 Jan 2024 07:21:15 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-13-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qO6tMkW7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s5VAiIp1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.16)[88.79%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.16
X-Rspamd-Queue-Id: B60E21F7DA
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Call virtblk_read_limits and most of virtblk_probe_zoned_device before
> allocating the gendisk and thus request_queue and make them read into
> a queue_limits structure instead.  Pass this initialized queue_limits
> to blk_mq_alloc_disk to set the queue up with the right parameters
> from the start and only leave a few final touches for zoned devices
> to be done just before adding the disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/virtio_blk.c | 130 ++++++++++++++++++-------------------
>   1 file changed, 64 insertions(+), 66 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

