Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261D3A1A2D
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036178; cv=none; b=MJetmQmFGagaLBrEc6DSKBfHlW9fIW7pyvAnrsK6FlOC4NCJrU8V4527BSMWMQWDp0vNrthI7kM6t130B288jGHZKuVWLVAX6Rz6wVK+JtPI//ntvDKK8YrTLMgL3QRWuoR+P0IeswOWlhXuDv9oVlkF1eAY1qQ2RUXqaUSOu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036178; c=relaxed/simple;
	bh=umgZy62eOKAynVRBShNhAHJb93UY6nKG1pADQdn0FH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICJlHxKLy8SRKmScCHEr2gnBOAXLTS4cftkheTZFn1jnGNM9Alkv1uXRYLyc4m9C5VTGPT4SxcKUy0bILh04CbSQo2WJeTctzfCDKRpzmUt4GgbPEFkQHewPNvGRCYPZVbYeFiR6aOAFFfGFqLPnEixHjaqT42pmvQBO30uQZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gX634q3d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wPB5+ZY9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGwgsv5e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=egpf3xr8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gX634q3d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wPB5+ZY9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGwgsv5e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="egpf3xr8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F123C6A920;
	Fri, 29 May 2026 06:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be9ntOBr3w25N2oG95un0gm6DVOoacNpMFFFoAcjZ/s=;
	b=gX634q3du+eagQnU14ETYc+qJQ+9KliKqO1TL4mSabdUUokwvp/N/fcg1FWbVKyJdTaI3K
	f08mXlG+fpEX8f0rLfuEK0wxwRqczNBriphVKYdmtWW57ecVFLWkZ7TIreHoaYuiOoUMJk
	vrFhlcBv6cVmCN7JhI6U8ZA7Cbc7Fsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be9ntOBr3w25N2oG95un0gm6DVOoacNpMFFFoAcjZ/s=;
	b=wPB5+ZY9surtXW3vyciAIcXUFEmE5EvsAsztIw//Cihqjw6121So8ArN3g5fYESeSjaVA5
	XqOKtgszKZ9HpJCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be9ntOBr3w25N2oG95un0gm6DVOoacNpMFFFoAcjZ/s=;
	b=jGwgsv5eRSMXmjDMq7aj4awhqW696Y6Tc0EC5YIKHLDstE7REUNJYNvf+cy30DkbDkHFG0
	1TIdZnW/FLwqJGUBgdbWi1MJ1hb9AkDS01zLQW1cZtuhzrUKuvPqtFjsfaga3hgl1JZSWb
	S6vmky1DkU0rIOW07GaDtKAbubcIV9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be9ntOBr3w25N2oG95un0gm6DVOoacNpMFFFoAcjZ/s=;
	b=egpf3xr8J5V0V61B6Cf6ODlGrRg4fp0RidAXVepyKj4S3Ry3ryh3tu9lmrjbhEkV2Rk2Fh
	lW9LPYIrCylNHaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3F705B1D1;
	Fri, 29 May 2026 06:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N5e8Lk8yGWrMHwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:29:35 +0000
Message-ID: <14786a7f-e0e8-45e1-ac7e-ff5b1dc35e4b@suse.de>
Date: Fri, 29 May 2026 08:29:35 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] block/cgroup: Inline
 blkg_conf_{open,close}_bdev_frozen()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
References: <cover.1779997063.git.bvanassche@acm.org>
 <f7be976e5a79afc88970ea16158d0a64bbf8f25e.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f7be976e5a79afc88970ea16158d0a64bbf8f25e.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/28/26 21:45, Bart Van Assche wrote:
> The blkg_conf_open_bdev_frozen() calling convention is not compatible
> with lock context annotations. Inline both blkg_conf_open_bdev_frozen()
> and blkg_conf_close_bdev_frozen() because these functions only have a
> single caller. This patch prepares for enabling lock context analysis.
> 
> The type of 'memflags' has been changed from unsigned long into unsigned
> int to match the type of current->flags. See also <linux/sched.h>.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-cgroup.c | 46 ----------------------------------------------
>   block/blk-cgroup.h |  4 ----
>   block/blk-iocost.c | 29 +++++++++++++++++++++++------
>   3 files changed, 23 insertions(+), 56 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
