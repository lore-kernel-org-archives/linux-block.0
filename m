Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478522CBF9
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562387; cv=none; b=mNAWEpvM/T1P25LnuwAKMXu3LI3CwvFGuM/zBYhdz2CfewavNfKfaIFnr1A70hTbkYJ/YMF69Wf7knDrlxTJI8hGbuKcdsHT9vRpG5P22aomNRiiWts+W7CO+KX9zdn8KGAwXTssVKKhkhjzB9vUiT/N1LBJ1XbiOvBuBnYQG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562387; c=relaxed/simple;
	bh=3W0PsPG5cYrkJB3TzI7oAEJ9tlMrcxDDShjnimiDYoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M06amT/aX/GXTQggAgolEoJWzp4Umbw95nVo+pl9fw32mq9r/C8MJDWrt0E6kdI4Bl8ltIvqEr2rkABKa1r9h0J3RNvYawI3OvhO+8nUnh1y1V6H1Sgw0fKw4VGHJtIJpL3acl8UE1r1QxDTXoRtszEsuN9IZr4o0AkLzTRRQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tJ57+Buj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YaS7BkpV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tJ57+Buj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YaS7BkpV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tJ57+Buj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YaS7BkpV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tJ57+Buj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YaS7BkpV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4061C1F38D;
	Fri, 25 Apr 2025 06:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLgKfCbCVqikub0xsQ6YzyN1X5Po1F5mNq/DanEZdYo=;
	b=tJ57+BujWKRE97a/MZXooL0scEH33wVaP0bmJAwganLGFzYKZUibAcwLb6UqW17jAaqs5T
	/9yUNoHyTthSiLmKo99fJyigS2aZ8/LHn5c5faxU99IfWZEGi2HxSQ0eJPKBW3nzAwVA65
	hqXVB5zsf2TkCC4mE3hxMn2zBwu/xaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLgKfCbCVqikub0xsQ6YzyN1X5Po1F5mNq/DanEZdYo=;
	b=YaS7BkpVaCEJq2KPTxI9CYECWtOiZIqSMcc0o6MnkY32SsCWhrvDjNeuME7OGNl/epYYFT
	XrR7WgC5fCVEWrAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLgKfCbCVqikub0xsQ6YzyN1X5Po1F5mNq/DanEZdYo=;
	b=tJ57+BujWKRE97a/MZXooL0scEH33wVaP0bmJAwganLGFzYKZUibAcwLb6UqW17jAaqs5T
	/9yUNoHyTthSiLmKo99fJyigS2aZ8/LHn5c5faxU99IfWZEGi2HxSQ0eJPKBW3nzAwVA65
	hqXVB5zsf2TkCC4mE3hxMn2zBwu/xaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLgKfCbCVqikub0xsQ6YzyN1X5Po1F5mNq/DanEZdYo=;
	b=YaS7BkpVaCEJq2KPTxI9CYECWtOiZIqSMcc0o6MnkY32SsCWhrvDjNeuME7OGNl/epYYFT
	XrR7WgC5fCVEWrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D02DC13A80;
	Fri, 25 Apr 2025 06:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COLgMA4rC2ijXgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:26:22 +0000
Message-ID: <2db989db-4849-46a9-9bad-0b67d85d1650@suse.de>
Date: Fri, 25 Apr 2025 08:26:22 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] isolation: introduce io_queue isolcpus type
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, storagedev@microchip.com,
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-6-9a53a870ca1f@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424-isolcpus-io-queues-v6-6-9a53a870ca1f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/24/25 20:19, Daniel Wagner wrote:
> Multiqueue drivers spreading IO queues on all CPUs for optimal
> performance. The drivers are not aware of the CPU isolated requirement
> and will spread all queues ignoring the isolcpus configuration.
> 
> Introduce a new isolcpus mask which allows the user to define on which
> CPUs IO queues should be placed. This is similar to the managed_irq but
> for drivers which do not use the managed IRQ infrastructure.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   include/linux/sched/isolation.h | 1 +
>   kernel/sched/isolation.c        | 7 +++++++
>   2 files changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
