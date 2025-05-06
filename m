Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850108F66
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529758; cv=none; b=fqxn8FlT3bbHlqR5UxfpKI5vQhffLfIlQ3fCYJQSmQRxjlcngrfdZRdnIfGJcrXBTMq6uMV+TYkDHA2LzqLZUqutd3LuxBR7Y6L4Bz0zgp8hmB3GgpOhYJZNemydn5ZU7sd1NKKI5+PxQGqLaqqZL8U/ahCoLKqHyW+JbGr4Eu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529758; c=relaxed/simple;
	bh=A2JgRp6XbAjvxFJNoEzNAU4QNnJXkuyI2SO7RCC8ii8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScmRoMqvp6GkNy+F76ZgXR44tkrXaOIBt6vtqzPeIfUui8MG0dwE7TTPh6zmXrfUeucHs7Xu0wgR74B9VWZGplxSzgF66wp7f60MRVMJ4UjFZUtzIIOUVCvvXPV+LNbbB5vaoXo6dU1/gPFsQ1TVCePUYqtysTnmljC8miFd7xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iOExpqwo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WFuh2sC+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q4MGRVId; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2OdLInaI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iOExpqwo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WFuh2sC+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q4MGRVId";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2OdLInaI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5ED3211A7;
	Tue,  6 May 2025 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746529754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcv1FhfOhCwRVjfge5eeTxumKTkawmjfTGEBWPZU3ak=;
	b=iOExpqwohJRb+Dn5x7y9kjEOCGtkTmLMvNkXFXUu4v8+q2gj807fMIEYDjSQZf634EDFmK
	otNR+Kmg3E86cLIgZOhpeRcmDxDST0dieQeDZtl94bo/CZuhtvutPNQwZw3XhuhGDxByhL
	mEfCw59Hip8ZL3Ts7NdEWYcGEo9gJcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746529754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcv1FhfOhCwRVjfge5eeTxumKTkawmjfTGEBWPZU3ak=;
	b=WFuh2sC+m14FU9eGIht/dTrj4KyumIhfMXvHroiHWfRwK3fGQp+TfbcAtGBGmNbnREFRWv
	BHRBUNH5pPYsKUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746529753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcv1FhfOhCwRVjfge5eeTxumKTkawmjfTGEBWPZU3ak=;
	b=q4MGRVId/z4cC3u6XCYBxs7eEesglFVs3u/wjOeFtEM4+yCvmSL32E0DwM1lL2Y3PuJj85
	o73JF5h/ErkZwRS+MfzQ+NMJunfnXbZKR6yH6/AOUMxcj8cowHgYhnmDNmL9psJJvqTpJC
	gOV0CyulmYzJepL89hcmJLRdXMgjCiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746529753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcv1FhfOhCwRVjfge5eeTxumKTkawmjfTGEBWPZU3ak=;
	b=2OdLInaIINxK2MJsoICl+HrSO8LSBCPemV9rtK8pMAnaaxNuDjhn+l+P2gUdAm0csdGchF
	9o1GBupMQMOJXoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7792D137CF;
	Tue,  6 May 2025 11:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y8CfG9ntGWieEAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 May 2025 11:09:13 +0000
Message-ID: <d6278d6e-9e9b-4f62-830e-b09d7ecedeaf@suse.de>
Date: Tue, 6 May 2025 13:09:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 19/25] block: fail to show/store elevator sysfs
 attribute if elevator is dying
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
 <20250505141805.2751237-20-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250505141805.2751237-20-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 5/5/25 16:17, Ming Lei wrote:
> Prepare for moving elv_register[unregister]_queue out of elevator_lock
> & queue freezing, so we may have to call elv_unregister_queue() after
> elevator ->exit() is called, then there is small window for user to
> call into ->show()/store(), and user-after-free can be caused.
> 
> Fail to show/store elevator sysfs attribute if elevator is dying by
> adding one new flag of ELEVATOR_FLAG_DYNG, which is protected by
> elevator ->sysfs_lock.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sched.c |  1 +
>   block/elevator.c     | 10 ++++++----
>   block/elevator.h     |  1 +
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
