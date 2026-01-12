Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25B3328E4
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203582; cv=none; b=aMUTh4NgTZ3ATGT6J+eIVY2yE83acMK5Hxp44Mc3QmcpT3HqGnDhapgB9SjtLTHkxyGHGJX6c6b32dAu6qJvCT5eLP05zL0xB07hQrVi9ZWU/9Hg7S6jPkZzQICQQyNbgKSVYZ5F87o5BlahurxKtx+cCb0A2j6Goc3Tp4Rrnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203582; c=relaxed/simple;
	bh=kG1zOgwwA24d//HERlgA4p3Ats9coTouEvLFSPGCm/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C9knsliV8l91aQLTkmdyiy4430aobPPFKVdHmcVmu0n6wQs0EeZQ5Y7HVuOkrsevxU6QK9uIr+gN/nWpBpunvSdyblGP1olAcal3NX2+kV2MLHNrxR8PaEn5G7cWD9zEZyPBIC0DxGe0NZ/2cSCsm3f+5dgtNOIocWeuEK8cyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yI/35/eo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mrBvTQDY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yI/35/eo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mrBvTQDY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yI/35/eo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mrBvTQDY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yI/35/eo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mrBvTQDY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A73EB336FD;
	Mon, 12 Jan 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9EeH6NlplMa190l6hJs9HHFh3aEvWZRQtbTN7QC5QY=;
	b=yI/35/eooTdyzbk3iOhSxXnbVu8XEJVL6NBFMiaIYVboqsk7HWhS0rkRgxAEidWUcPm7BL
	4GPpTXBzMI62l+L32Vic++MWmvhEC6mCCCZGt3haE6YSP7QTVMi01UknJ+Xprg1dNlaT59
	5wao2NZ4foxMcxa9PdvR51XLz5ITRLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9EeH6NlplMa190l6hJs9HHFh3aEvWZRQtbTN7QC5QY=;
	b=mrBvTQDYF3L5boq4wPmvYolPjEcKFtRVmubghqJ2ZgIi9KPHsEiLL8HWJOxmbENs41V0sR
	5iy3Sr6Mh6LJRADQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="yI/35/eo";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mrBvTQDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9EeH6NlplMa190l6hJs9HHFh3aEvWZRQtbTN7QC5QY=;
	b=yI/35/eooTdyzbk3iOhSxXnbVu8XEJVL6NBFMiaIYVboqsk7HWhS0rkRgxAEidWUcPm7BL
	4GPpTXBzMI62l+L32Vic++MWmvhEC6mCCCZGt3haE6YSP7QTVMi01UknJ+Xprg1dNlaT59
	5wao2NZ4foxMcxa9PdvR51XLz5ITRLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9EeH6NlplMa190l6hJs9HHFh3aEvWZRQtbTN7QC5QY=;
	b=mrBvTQDYF3L5boq4wPmvYolPjEcKFtRVmubghqJ2ZgIi9KPHsEiLL8HWJOxmbENs41V0sR
	5iy3Sr6Mh6LJRADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 628AF3EA63;
	Mon, 12 Jan 2026 07:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lLJ6FjqlZGnzTwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:39:38 +0000
Message-ID: <d0a1a079-4150-4ed4-8d09-6a85d564349d@suse.de>
Date: Mon, 12 Jan 2026 08:39:37 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] blk-mq-debugfs: factor out a helper to register
 debugfs for all rq_qos
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-4-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-4-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: A73EB336FD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/9/26 07:52, Yu Kuai wrote:
> There is already a helper blk_mq_debugfs_register_rqos() to register
> one rqos, however this helper is called synchronously when the rqos is
> created with queue frozen.
> 
> Prepare to fix possible deadlock to create blk-mq debugfs entries while
> queue is still frozen.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>   block/blk-mq-debugfs.c | 23 +++++++++++++++--------
>   block/blk-mq-debugfs.h |  5 +++++
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
