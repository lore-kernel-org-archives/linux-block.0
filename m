Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97B5A109
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413702; cv=none; b=NVCU9LMFB51LDLqdAkYUBdn67h7IQlK4Ngucc/O5hTMGT2bBmDEhfk552ssi4/TSxERFRdsiw0/1/KKuDj7bpCV42qopedyNFpOnFB/1Sr2Hkpxfkr8biVtuOvyci+KwmI4E723LR4ztOuqpFL16sc/xCUw5RGNEKlsk7cTs2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413702; c=relaxed/simple;
	bh=pZCK32Ad+Jj5p+ydRZXbkdyOlB2YiQmWg+ugocUd7DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WH6F2/a/P1+HPPlHgqGCQOzrbVx/AP+QOiI87elogTfAhuV/O11S39zJcAR+vVlJYtIT/ptNraNOy3CRDw+MY0D6Ch4GZRL7KImUBXLrhXZ+YoAO8QlScTUxOdDrRmumlEqnRyMR6mNgf56u7VAOGWUMxxzNizSue9bY5NIiHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FWsTh75K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3KI7nVW7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m+aAirqa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TybS781w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FWsTh75K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3KI7nVW7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m+aAirqa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TybS781w"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A609421EA9;
	Tue, 20 Feb 2024 07:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBruJVD+GOpEFSXdqIKI51N3DStXDZQK9jub3Am5pWg=;
	b=FWsTh75KwmrdhW6vqsXh6g8CTZphIfhc2jLHNRuaztQlIPb+ZN6lVMBzu8iJW+/u0hHcad
	8uEqJx8vE8uEPfbwhgmezlFe0jScRwz87m8NqOfOVbvq7UGHX1nuuZ1rWdg/4qYUkvrY3V
	9kQeWxcxk0S5hrO8kvu+uNzTWbF43Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBruJVD+GOpEFSXdqIKI51N3DStXDZQK9jub3Am5pWg=;
	b=3KI7nVW76xLmVvffKXPsnlDVoj1qlN4PuQpuVM4/JJXE1zR5qKq7qli87Hq51iwUObBKqF
	zHBdOl9ZD60QBXBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBruJVD+GOpEFSXdqIKI51N3DStXDZQK9jub3Am5pWg=;
	b=m+aAirqazYattpr0nl0wldx1HQGlb64nVqg64lLl23pUruesD+IiggfWTunH+2miPLr5e2
	SV0+1/PzOBQMKMcKwW09eT028Wbi4OvYEYPJ5Umu8suUyob951+Psk88ADPOPiLVf+pMC+
	XU7WwTJcBVkIoiNq4nRwaEPjDtpMwbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBruJVD+GOpEFSXdqIKI51N3DStXDZQK9jub3Am5pWg=;
	b=TybS781wyJhAmjC48mvQ33FaXuWN4UZt9cZDxEnOOQn/9kxE3hT/7UolFzPuDRA+n70lGx
	w0Kx5pMaOiO7xvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDB88134E4;
	Tue, 20 Feb 2024 07:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FTzMwBT1GUpRQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 07:21:36 +0000
Message-ID: <7eb0bf21-a011-4b27-9e3c-e226b6941da8@suse.de>
Date: Tue, 20 Feb 2024 08:21:35 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] null_blk: initialize the tag_set timeout in
 null_init_tag_set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240220053303.3211004-1-hch@lst.de>
 <20240220053303.3211004-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240220053303.3211004-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m+aAirqa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TybS781w
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.35 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.85)[99.36%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,wdc.com:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.35
X-Rspamd-Queue-Id: A609421EA9
X-Spam-Flag: NO

On 2/20/24 06:33, Christoph Hellwig wrote:
> Otherwise it will be reset to the always same value when initializing a
> device using the shared tag_set.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

