Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B9331A5B
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203695; cv=none; b=juQaL7Zw31Am5X/Fpw7kxvD/NMNpK/VRtAjtBVnBIUIazOkG3+PL7lJJeHuSMRtXWMH0btqke8K/cZR44OwBbuzuHpSAnUkbkfR2DAoTfrVMDlykM5/3RmwRV3R75IdSm2FxtS4oIOSRWhx0S4toDQ8fIRlAfIp4Z47h5ylkFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203695; c=relaxed/simple;
	bh=F7bZVdln7ghIlpX/n7av+lOdLmp/rKcedFtZJ4NMiqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kRYNbmiGYE9MUcLfNopD9GFDA5igG6mleFi1kNVjirWqCFY0jDDftg6TvzzMwKm8OaCK11XqxZaiJlwMVXgw4zpI3NctpRe0y7fkx7n+z4YwQrrxhQtasgYlD/OclL1Kv5jkMoYcwuEOLxbXyEpka8EM0kGnWbfTdFhWgTPafr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TE8Fmvl3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xsLahvp4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TE8Fmvl3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xsLahvp4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TE8Fmvl3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xsLahvp4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TE8Fmvl3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xsLahvp4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 713B4336FD;
	Mon, 12 Jan 2026 07:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roYSRg40t+kla4AX9r6yfgRPO9zl89+8tYzuKeC5Nkc=;
	b=TE8Fmvl3lZ7xEMf/W5A+LVOAQu/YDgmoqVGWvY7fadjqbp25X0f1s2M2nRQEAXaCsS7SuF
	kn6JLrMrfvqkotxfCBXhLDsjRtrohj/z4+U9nVmK287b+q0xwR9PUM4NeUVpYIIKuIlvFr
	aehXfpLCMpI6dULrlkX3oqsy/Qml1hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roYSRg40t+kla4AX9r6yfgRPO9zl89+8tYzuKeC5Nkc=;
	b=xsLahvp4gcSF+cFmgKVXOjyaI2oMOoCnwNk8/n9TC5AngUY82YsT57fEjP7WNhOrnUD2TC
	aM4Iehc2cp1HsgCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roYSRg40t+kla4AX9r6yfgRPO9zl89+8tYzuKeC5Nkc=;
	b=TE8Fmvl3lZ7xEMf/W5A+LVOAQu/YDgmoqVGWvY7fadjqbp25X0f1s2M2nRQEAXaCsS7SuF
	kn6JLrMrfvqkotxfCBXhLDsjRtrohj/z4+U9nVmK287b+q0xwR9PUM4NeUVpYIIKuIlvFr
	aehXfpLCMpI6dULrlkX3oqsy/Qml1hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roYSRg40t+kla4AX9r6yfgRPO9zl89+8tYzuKeC5Nkc=;
	b=xsLahvp4gcSF+cFmgKVXOjyaI2oMOoCnwNk8/n9TC5AngUY82YsT57fEjP7WNhOrnUD2TC
	aM4Iehc2cp1HsgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 390E23EA63;
	Mon, 12 Jan 2026 07:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KrlcDKylZGmtUQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:41:32 +0000
Message-ID: <c5577df5-1854-402c-a95d-69b61803eb73@suse.de>
Date: Mon, 12 Jan 2026 08:41:31 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] blk-mq-debugfs: remove
 blk_mq_debugfs_unregister_rqos()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-7-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-7-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,fnnas.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 1/9/26 07:52, Yu Kuai wrote:
> Because this helper is only used by iocost and iolatency, while they
> don't have debugfs entries.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 10 ----------
>   block/blk-mq-debugfs.h |  4 ----
>   block/blk-rq-qos.c     |  4 ----
>   3 files changed, 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
