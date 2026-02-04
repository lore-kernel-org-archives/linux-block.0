Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DC2566F7
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170135; cv=none; b=arm4aaSKR5+PdQav/4CmBkC+rGa7ouUt4Xa77W3cr+jiDl+IVDJ3zUZKlGypYbeN6SZEhGLj7q18WRuez9NmKYUnKKG22mtzTFiaeT1ZprWueOr0oHdrAIGQtUd4IzgdqFvY1amVKxTkulMpicgSWRIbViNkrFrhAyhFGLArgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170135; c=relaxed/simple;
	bh=aIYjyVN3ZKgwFbxPzhsuJpsi121USkO4Tv79NTo4M5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikTPsit1Iw/Vatp69BRzy7GBP7J6s63spAHfV98BQwJe5arWCR1lWJXshQRdOScVQLB7ksu5egdbMaIdAAnFxcoVSJxkrhnXwvEsspJeLxEd/mMYGb1Hqy85MswrtF+WOPSUENotaTeJqgPMFjkLP4pP6Sve4H57URWXQej7Rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DRSwWnzV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HpS+Einh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DRSwWnzV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HpS+Einh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DRSwWnzV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HpS+Einh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DRSwWnzV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HpS+Einh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 306655BCC7;
	Wed,  4 Feb 2026 01:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMj1N2gsrZ1CCpoAqiaSGN3uLMahB54rPi7ihwwwGwo=;
	b=DRSwWnzVGmuSg2zLRiMrevHDMh6owEZZRw9hP66wbL13MDy/TOOhglmt2HwuRuRV0SgHqC
	PRrMVA8Y1XQLQcsD5Hvjocg9DEFtcjwlIwVe25XKxX1VfY/ci32Dm2KyvUqm29oCo8ug1N
	rQ0dvmCWZGvwPbcIRJx8zWB1pstr+dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMj1N2gsrZ1CCpoAqiaSGN3uLMahB54rPi7ihwwwGwo=;
	b=HpS+Einh8iqOTp1Snp0XFjiOjNnJ5f8zGdRLxam3Pn2RI+U1bf7S+Mn1WbZBW82Tf7Av3L
	8ghYLUL6YOWfPTCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMj1N2gsrZ1CCpoAqiaSGN3uLMahB54rPi7ihwwwGwo=;
	b=DRSwWnzVGmuSg2zLRiMrevHDMh6owEZZRw9hP66wbL13MDy/TOOhglmt2HwuRuRV0SgHqC
	PRrMVA8Y1XQLQcsD5Hvjocg9DEFtcjwlIwVe25XKxX1VfY/ci32Dm2KyvUqm29oCo8ug1N
	rQ0dvmCWZGvwPbcIRJx8zWB1pstr+dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMj1N2gsrZ1CCpoAqiaSGN3uLMahB54rPi7ihwwwGwo=;
	b=HpS+Einh8iqOTp1Snp0XFjiOjNnJ5f8zGdRLxam3Pn2RI+U1bf7S+Mn1WbZBW82Tf7Av3L
	8ghYLUL6YOWfPTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A16D93EA63;
	Wed,  4 Feb 2026 01:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xbriFhGngmmWPwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:55:29 +0000
Message-ID: <36526eda-00a7-4993-9adf-601eb0b3462b@suse.de>
Date: Wed, 4 Feb 2026 02:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] kyber: covert to use request_queue->async_depth
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
Cc: bvanassche@acm.org
References: <20260203081952.732210-1-yukuai@fnnas.com>
 <20260203081952.732210-6-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203081952.732210-6-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.963];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

On 2/3/26 09:19, Yu Kuai wrote:
> Instead of the internal async_depth, remove kqd->async_depth and related
> helpers.
> 
> Noted elevator attribute async_depth is now removed, queue attribute
> with the same name is used instead.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/kyber-iosched.c | 33 +++++----------------------------
>   1 file changed, 5 insertions(+), 28 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
