Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CE4C6C
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336301; cv=none; b=YS27kKtHg4DPUQAaaaG8PnbsZ7B7j/uCG15QmzQe8J+Qai/r388rUi2Ovc2vvxyS1TIK2UBJqWsHnGTPYu1xdXwTlh8x1ZOa15ac32vyxx8fhO4eF39Me8YENKN0OwKC4CTYO5c5dEgCPMaD4dS2dxw8ZCVWQMNApO5n7owLoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336301; c=relaxed/simple;
	bh=mN2lnKFf/tlZnAyItIKJpKx0EkL48ruuTV4nx4kcJrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwwyW6VwH4naN3epJBPGFnfgPhYKJlhs4ZS13lHWySmoJENfyX0WoW7It+hSrKr6xjL7OyPg8CbWXgL/Aa7izmOuDBVb5igm+7aorSYZlBo0TmHfZJoYCHGZKcdq/tnmjcbUhF0CkO6cSSAmLLFv5wANLFPIqqezkmfIr1pgqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JxqoDWre; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IjFgRhdd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JxqoDWre; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IjFgRhdd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JxqoDWre";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IjFgRhdd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JxqoDWre";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IjFgRhdd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30A4C3E6D2;
	Fri,  6 Feb 2026 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70eMmeFTNGBnS60P6nibYis3e+5U5hKtYDZ2ANqbJBo=;
	b=JxqoDWreuV6N8/Jj+qbzoecDffb5tLniFC7VeJw3RNbtZE0HttW/fZqmUCdEEPVUDI/goe
	Ae08o1wjmpQGAuLwqEebaDj7Cdg+fQ9C3F/48hflVjLxOtkKanszS9P9/IzFSjVqyeZ5cy
	Wio3a2PzxVCO98OzFXBTBeMgd+7rdu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70eMmeFTNGBnS60P6nibYis3e+5U5hKtYDZ2ANqbJBo=;
	b=IjFgRhdd4xCbvMun0UB8dHZDkX68P2KPFBEg/mMa9Xi/0pAXJqMut1ivTrjCRDEugPZgCw
	Zw0ksWDm4fWXvtAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JxqoDWre;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IjFgRhdd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70eMmeFTNGBnS60P6nibYis3e+5U5hKtYDZ2ANqbJBo=;
	b=JxqoDWreuV6N8/Jj+qbzoecDffb5tLniFC7VeJw3RNbtZE0HttW/fZqmUCdEEPVUDI/goe
	Ae08o1wjmpQGAuLwqEebaDj7Cdg+fQ9C3F/48hflVjLxOtkKanszS9P9/IzFSjVqyeZ5cy
	Wio3a2PzxVCO98OzFXBTBeMgd+7rdu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70eMmeFTNGBnS60P6nibYis3e+5U5hKtYDZ2ANqbJBo=;
	b=IjFgRhdd4xCbvMun0UB8dHZDkX68P2KPFBEg/mMa9Xi/0pAXJqMut1ivTrjCRDEugPZgCw
	Zw0ksWDm4fWXvtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47B033EA63;
	Fri,  6 Feb 2026 00:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nYTaLSgwhWmkCgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Feb 2026 00:04:56 +0000
Message-ID: <1617c967-a52a-4e80-acfa-e97d0d87ce3c@suse.de>
Date: Fri, 6 Feb 2026 01:04:50 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] sed-opal: add UID of Locking Table.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gmazyland@gmail.com, jonathan.derrick@linux.dev, gjoyce@ibm.com
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260205150935.238137-2-okozina@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260205150935.238137-2-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,ibm.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 30A4C3E6D2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 2/5/26 16:09, Ondrej Kozina wrote:
> As described in ch. 6.3, Table 240 in TCG Storage
> Architecture Core Specification document.
> 
> It's also referenced in TCG Storage Opal SSC Feature Set:
> Single User Mode document, ch. 3.1.1.1 Reactivate method.
> 
> It will be used later in Reactivate method implemetation
> for sed-opal interface.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h | 1 +
>   block/sed-opal.c   | 2 ++
>   2 files changed, 3 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
