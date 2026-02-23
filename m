Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D9361DCE
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848482; cv=none; b=rlSPGDkEpZ2KVk/8rHd9AMgMozYHRvytQLv+KUwAJ6XoxBhMcXLOEINv0imvz7VZVbow6jytrkkJuQordmNF6Y0sJvMQdXFhUmz6SN9c+nIqtyURqsgouQIv64/D1UM6hoPa6BAQFjLLHE73Kk7e+IeRVpVHmnXChaLOQlFLC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848482; c=relaxed/simple;
	bh=hUTKqS4suNvpGQGK7NnVPR54skEJcXyQGQ493zhHnkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTIhTPN3MmMNYycOMatwHWkjLvs69lZ4Qsesg0y96b7qq/bGOvi4GKd4drblWSKcnNyS7JcVh3uhAeL44rHBrcjpdA9WMXaSXV0oD7jiRNE8YNuEQw1o8S46Tl0GwFXgg3UZ2l8RDwxdDvI4vCB+MuUBZ4cyG2s7mYKiIX3A+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IUce53La; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RODavTs7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IUce53La; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RODavTs7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IUce53La";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RODavTs7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IUce53La";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RODavTs7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5D973EC6D;
	Mon, 23 Feb 2026 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLj5WOCUUHt5H83rXTGvISzWiL/bYxgS1tn8mmw33pI=;
	b=IUce53LavKh9AfKkTrf70FeiY+R3y8ERjgTwOQZDvFyPVwWWGziffLppUas5nMtheVh1Ke
	+dkjg+ZrvR+NMuRdxsFSVY3HiAbzEGLILMp1xQiRXnYW31P0LCX+CMuTo4PrgTFEIAhgoY
	IVLRUw+eVdpB/6djQzw8D9RjlxeGpt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLj5WOCUUHt5H83rXTGvISzWiL/bYxgS1tn8mmw33pI=;
	b=RODavTs7vWrOXvgo4By9fv0n2GRHW4YM9z4mnf5mVitMiK4MII6WU61uWQMxpwXZHW4qiF
	En/jGisLcE+utsAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLj5WOCUUHt5H83rXTGvISzWiL/bYxgS1tn8mmw33pI=;
	b=IUce53LavKh9AfKkTrf70FeiY+R3y8ERjgTwOQZDvFyPVwWWGziffLppUas5nMtheVh1Ke
	+dkjg+ZrvR+NMuRdxsFSVY3HiAbzEGLILMp1xQiRXnYW31P0LCX+CMuTo4PrgTFEIAhgoY
	IVLRUw+eVdpB/6djQzw8D9RjlxeGpt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLj5WOCUUHt5H83rXTGvISzWiL/bYxgS1tn8mmw33pI=;
	b=RODavTs7vWrOXvgo4By9fv0n2GRHW4YM9z4mnf5mVitMiK4MII6WU61uWQMxpwXZHW4qiF
	En/jGisLcE+utsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE6F03EA68;
	Mon, 23 Feb 2026 12:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +8gPLh9DnGnEUQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:07:59 +0000
Message-ID: <0e6561ea-d575-400b-a62e-712b43d104b6@suse.de>
Date: Mon, 23 Feb 2026 13:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] Documentation: ABI: stable: document the
 zoned_qd1_writes attribute
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-9-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/21/26 01:44, Damien Le Moal wrote:
> Update the documentation file Documentation/ABI/stable/sysfs-block to
> describe the zoned_qd1_writes sysfs queue attribute file.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   Documentation/ABI/stable/sysfs-block | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
