Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C317C79
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469308; cv=none; b=qcZZdLS7sSs5dI7PCZPEe0PzTuE1zi7bJzQtNa6FJEoXeNFXGx6/D6uqeq9Cl5M0Y8RrbKkkOe7myggtrIoDyNmbp4BxLBunRuAQOt1osuTKkS+YDUBeU3JIeB9TKqO/2JzYvxYOzNCGC60pCOnTT1gj2N5fPMf5+iutywz3tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469308; c=relaxed/simple;
	bh=2TUEjYrQ8jz8z356LB4sv341uc2+taBZHkN2MVR0dA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkZLXNlhxpD+phEs2422MIPjSTpu4lSZUYANMbmgMFijQnP1nR2cCC3plUJo3W898P0JqReDL//HzXqTKhvqvIc4FqJtfRcQB0P2pRALI/oeNMF9eleC2zE87wJdsBGBbcvKKcxbbNaVjTsPoAOMmsbOdC4MbflJga+Mvz/tpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2ZMEhnlz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5NaYXeNF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dN4rVANj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ItNamBf0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2ZMEhnlz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5NaYXeNF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dN4rVANj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ItNamBf0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67B931F44F;
	Tue, 25 Feb 2025 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A14kkmBmV1IncW5PfeEO1da/0JnhgxpPDgcELvNBf2Y=;
	b=2ZMEhnlz1fO+uJ+C6R2uX5r+Y//fiX9IuieigM8OuoewzRiBxlNqg0mQx62gcVs0rhHzON
	O2bGTS2IOL/FUVN903JCADVb3lAVcrHtORQNxaK2GsaYzSTJH33d+V7R14RZqsHf2HRmgf
	oqYjjVpyyUPrNMRWoNT9njQh+s/xiag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A14kkmBmV1IncW5PfeEO1da/0JnhgxpPDgcELvNBf2Y=;
	b=5NaYXeNF+AeyIV6LwRisk2jPZbr4QCSiC5I4LOZdbIuqe1DSGk4t1VBnvt1hhSahm4i7+m
	rP+d7WdhQd4oTaCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dN4rVANj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ItNamBf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A14kkmBmV1IncW5PfeEO1da/0JnhgxpPDgcELvNBf2Y=;
	b=dN4rVANjPG3+k68SNaeuMKXpgD74e3FXraLuuvudJNUMrwKPwPX3VO0FmGrCa6gPGpLj2W
	QWY/XU5MNX1W0lx5AYRSlc2H6f8+vBRvBo0zqErrnAG9EFy52yf66Y6DNGOCVJ1GS7W+cb
	I0AwSesO2kHLex1qfi8FCPbxmNRVvDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A14kkmBmV1IncW5PfeEO1da/0JnhgxpPDgcELvNBf2Y=;
	b=ItNamBf066Y2Eoq6RCvb8b6asm7H7dgokokFVrOCnuCszzGxySGqKADiS8hEAokDEH8XI3
	YotfYily/jEFxJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23AF513332;
	Tue, 25 Feb 2025 07:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qqoGBzh0vWeXbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Feb 2025 07:41:44 +0000
Message-ID: <9cda7f51-96b6-4723-acaa-7631bffde196@suse.de>
Date: Tue, 25 Feb 2025 08:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/7] block: move q->sysfs_lock and queue-freeze under
 show/store method
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250224133102.1240146-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67B931F44F
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 14:30, Nilay Shroff wrote:
> In preparation to further simplify and group sysfs attributes which
> don't require locking or require some form of locking other than q->
> limits_lock, move acquire/release of q->sysfs_lock and queue freeze/
> unfreeze under each attributes' respective show/store method.
> 
> While we are at it, also remove ->load_module() as it's used to load
> the module before queue is freezed. Now as we moved queue-freeze under
> ->store(), we could load module directly from the attributes' store
> method before we actually start freezing the queue. Currently, the
> ->load_module() is only used by "scheduler" attribute, so we now load
> the relevant elevator module before we start freezing the queue in
> elv_iosched_store().
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-sysfs.c | 210 +++++++++++++++++++++++++++++++---------------
>   block/elevator.c  |  20 ++++-
>   2 files changed, 162 insertions(+), 68 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
