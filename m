Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24061F12EF
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313933; cv=none; b=AGnAPPmE3DZTHLLA2EciyvMv2yq6AUoRn2J1XxQBs8IXHUjqQJm1T9TBGYqR4G8jdqmKboku1OJ1ZLIfqeu7WNAaBm51fqXREZJ9Xox8/qe6V0iPFdUBDWl0aGNrVXtxc3XnHUqJ7/YCyqbsvDNNE1gwL74w6mFJboEdpriR0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313933; c=relaxed/simple;
	bh=noSy8nyYuA/iOybFyhqnZQUYfWsDK+zzt9MtWrPV6x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHdnz1Zm684ElRrHqgARmGpSBsEk1C8Ww+dyPQjnKocBifkIwhJEh/gAkvtZoFYpXuxn9pxe1AM6S/yJKoOMOPCvaTJjMh829Qz6nfKJUop7H5sPi9gXXRpp2lAyeCJAdUErwqH8TUPQ00f7RsekzvEevpglIolE4hsjgXTcCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bIrof7d0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j4OqqM7i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lf/xVd/+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZcZxVRti; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bIrof7d0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j4OqqM7i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lf/xVd/+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZcZxVRti"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E97E7211F8;
	Tue, 22 Apr 2025 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745313930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trLuRxffAN9asqVYHPTEIhB97LilXQ1JCVPLr1N5+ns=;
	b=bIrof7d081YXPC55sO/0wVuOBuCwzmyxK5AWp0yqLqmNn9V4fE9zKEDeIqstZiekb+IDzk
	IDiFBdJqKx+4PoCGody+WNVmxpNg3uyGCjoZB9haBi7Ekn9cO63XylmSOK4LcfG35WcPwe
	s43ufkhlsHX9J9KGTpwv0xRSm5260rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745313930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trLuRxffAN9asqVYHPTEIhB97LilXQ1JCVPLr1N5+ns=;
	b=j4OqqM7iMQs/ngkLOxMDAQpms9xv4LOgm4BRa4ZN8AwTuClbpvzifulLNCkgcs0u3901gg
	0PU5Ng2CDBzbFHCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Lf/xVd/+";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZcZxVRti
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745313929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trLuRxffAN9asqVYHPTEIhB97LilXQ1JCVPLr1N5+ns=;
	b=Lf/xVd/+7tijPmbg95JxQQJYTFO9PJ4yvKUw+32Z6jm+3bPILiIv2F5Bkw4iFyi4trjUP5
	YAYV0I5Bil3JLkG3W56Uis8CwsqPmJLrfklXxjc8VAfAgJkuw/03kG/Pj41gxaOCgJVTDM
	vljcAbjgcRPFur07i4f5gK8VnCmTkxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745313929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trLuRxffAN9asqVYHPTEIhB97LilXQ1JCVPLr1N5+ns=;
	b=ZcZxVRti/cSCfRmQ3L8iF0w5luGkf/X2BxORwutqqS65MlQkkdRkBElEqW4nh8brbDqjy7
	VfnxkOYFKbmPiZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D944B139D5;
	Tue, 22 Apr 2025 09:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NDmnNIlgB2h3YgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 09:25:29 +0000
Message-ID: <65884bf8-b39b-4b73-8afb-7e97244539b5@suse.de>
Date: Tue, 22 Apr 2025 11:25:29 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] brd: use bvec_kmap_local in brd_do_bvec
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-4-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250421072641.1311040-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E97E7211F8
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/21/25 09:26, Christoph Hellwig wrote:
> Use the proper helper to kmap a bvec in brd_do_bvec instead of directly
> accessing the bvec fields and use the deprecated kmap_atomic API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
