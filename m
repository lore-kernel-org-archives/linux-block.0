Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3F55884;
	Fri, 28 Jun 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555869; cv=none; b=fA/+X9GmILcwjXRi6Krgb2Wy2XD04etUTbYsEAXv4NKpcT4FJ6JMaLRGf2MgEROUGvldtRMyNzhykOryDlwiT0WchssyEkYqm//qiK89aSD/4hZYs3IB7F5Uvj03v8gqCgv4QYcqFzgaJaxWtOwcKH+yrVKVIR+sfAICwMEm1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555869; c=relaxed/simple;
	bh=yIuecMcxJ3b71lkfkRwQNEsUaLYyEXAMF9+YS6Q1zn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nN3AeavJaEAfGl4NQQUMtLUE4CzZ9Giyoal6nuwNCLbjJYL0+qU4SqRzG/LE+QUQJPKFEBcbLSOwRQU7Iv022Ov94JdmQGUGKVUTQgmmNk10/MMnRQRiqHE7YviSRTre+/DUPyLjCHB5F9VH9JjK08jtXKXxDODyVgrfcrsS3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zkzPujRh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zXeuMtyV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zkzPujRh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zXeuMtyV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zkzPujRh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zXeuMtyV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zkzPujRh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zXeuMtyV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52FC821AB0;
	Fri, 28 Jun 2024 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719555866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWN8Q2SrQwfjkzvNeU5UzOIRMUu82fyEIFy20TbSmqQ=;
	b=zkzPujRhkmZEs0/gU1nRDUV95ze1us5yWgsQ4qRypRHnRyo64AphuW4ei4H03g3RKRPLm/
	+rowwkcf6owFWHVQkx9JGVwgaeLdtl4J19M/tgufOaYRrGFB+Y6EVNwU/RpbKj0rtDwSmS
	lUhWTWWzBqrBLvq3w3uuHeUGnNyioi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719555866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWN8Q2SrQwfjkzvNeU5UzOIRMUu82fyEIFy20TbSmqQ=;
	b=zXeuMtyVc2CsGFe9ef9WnU4lBshwJ3FVRKAaY128rz3htxrxHlTNXsBDU9OuqmvmLcWi+J
	5E9OaYBUsWLprrCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719555866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWN8Q2SrQwfjkzvNeU5UzOIRMUu82fyEIFy20TbSmqQ=;
	b=zkzPujRhkmZEs0/gU1nRDUV95ze1us5yWgsQ4qRypRHnRyo64AphuW4ei4H03g3RKRPLm/
	+rowwkcf6owFWHVQkx9JGVwgaeLdtl4J19M/tgufOaYRrGFB+Y6EVNwU/RpbKj0rtDwSmS
	lUhWTWWzBqrBLvq3w3uuHeUGnNyioi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719555866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWN8Q2SrQwfjkzvNeU5UzOIRMUu82fyEIFy20TbSmqQ=;
	b=zXeuMtyVc2CsGFe9ef9WnU4lBshwJ3FVRKAaY128rz3htxrxHlTNXsBDU9OuqmvmLcWi+J
	5E9OaYBUsWLprrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 644191373E;
	Fri, 28 Jun 2024 06:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AIY8FRlXfmZ4ewAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Jun 2024 06:24:25 +0000
Message-ID: <312cbbb2-9427-4925-b885-96222b25cf82@suse.de>
Date: Fri, 28 Jun 2024 08:24:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme-pci: limit queue count to housekeeping CPUs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,suse.de,parallelwireless.com,gmail.com,redhat.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]

On 6/27/24 16:10, Daniel Wagner wrote:
> When isolcpus is used, the nvme-pci driver should only allocated queues
> for the housekeeping CPUs. Use the blk_mq_num_possible_queues helper
> which returns the correct number of queues for all configurations.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/pci.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

