Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7A19D8BE
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301875; cv=none; b=mr/8Z4M1GYqe7LmgjgaXrZUOyNikgg/h9d5QaW+SsSyDJ8Kh0fPqyZhxpyyx3mbyyGav8gPSfI9FAXEVBK01owhE50vyyXqGok+X8wlNJGJPDE98nlfxA7o+5Zuz9b32oLDD1cUCMuE5HMmtoDRfdtmqmV7JDiuVQE5uchC2lew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301875; c=relaxed/simple;
	bh=6Jqdo/Ul73c8Ot6n+tLg9Y5Lt5wFFgr3ID+cn7iBeV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laKecHH0FDzmStk1gd+Pu328thvPpHkHvD6PPK+lkytz81Lcbo1JSH7njmNG6QUrbuSyjnuGO/KOdnG0dKCl5poR4tca25zXLn5vPBJH/tPMmsZ5bwoFJ8iKBcTtp6btoC8DItmWK6CXqdAqOwtA9B3u2fQetRAH8If/gxgT5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tKp4/bON; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=of+yuF+r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tKp4/bON; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=of+yuF+r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tKp4/bON";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="of+yuF+r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tKp4/bON";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="of+yuF+r"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D52B1F7C1;
	Tue, 22 Apr 2025 06:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Alc1pi9ABiv4jqDLzLJmsbybW1cFPIFcsfRZ4IAJn4=;
	b=tKp4/bONbU2t4Ba5M7O/SmMspkprlCjm6xKSyepO815HvADxXONTITNoqnW4l/GqRD0itO
	obVPQZzbLutHvjrqpeySrdDjEwAfuiS3rypD0mrZzv66PKYb4Xi6XaB0fN8a4Yi9WxW4u4
	uCltldkO7labyDl6H8/31WyFt7KGt8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Alc1pi9ABiv4jqDLzLJmsbybW1cFPIFcsfRZ4IAJn4=;
	b=of+yuF+rKKGgKv++FmM2HNnpzLTpYp+GwRDLLmv0Atsk6i4JH1IUcrlrHGkg/RU7Row0x0
	dKI/K2fCMnI4YSCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tKp4/bON";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=of+yuF+r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Alc1pi9ABiv4jqDLzLJmsbybW1cFPIFcsfRZ4IAJn4=;
	b=tKp4/bONbU2t4Ba5M7O/SmMspkprlCjm6xKSyepO815HvADxXONTITNoqnW4l/GqRD0itO
	obVPQZzbLutHvjrqpeySrdDjEwAfuiS3rypD0mrZzv66PKYb4Xi6XaB0fN8a4Yi9WxW4u4
	uCltldkO7labyDl6H8/31WyFt7KGt8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Alc1pi9ABiv4jqDLzLJmsbybW1cFPIFcsfRZ4IAJn4=;
	b=of+yuF+rKKGgKv++FmM2HNnpzLTpYp+GwRDLLmv0Atsk6i4JH1IUcrlrHGkg/RU7Row0x0
	dKI/K2fCMnI4YSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9844139D5;
	Tue, 22 Apr 2025 06:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zJ4qN28xB2h+IgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:04:31 +0000
Message-ID: <a0bc923f-8fb7-473b-9651-9456d78a08e3@suse.de>
Date: Tue, 22 Apr 2025 08:04:31 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/20] block: add two helpers for
 registering/un-registering sched debugfs
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-5-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250418163708.442085-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D52B1F7C1
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/18/25 18:36, Ming Lei wrote:
> Add blk_mq_sched_reg_debugfs()/blk_mq_sched_unreg_debugfs() to clean up
> sched init/exit code a bit.
> 
> Register & unregister debugfs for sched & sched_hctx order is changed a
> bit, but it is safe because sched & sched_hctx is guaranteed to be ready
> when exporting via debugfs.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sched.c | 45 +++++++++++++++++++++++++++++---------------
>   1 file changed, 30 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
