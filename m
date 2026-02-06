Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3E8F48
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336342; cv=none; b=nF4w28vu3tCEVI6a6WSLnoZxJGVhsDAHyJy8BGG0dDpc6Nk/0HW39EwWvKkgx3weJwGoO6VAFFkiIAJ8XJewepzuLZxqgvU+fiwfBJbz8HqRjilfeiCCb6Wq0ro48JtXbIhQgMnXJ3PQKFMl6TS/KX7QSIdTrQLIEwqdJvJhThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336342; c=relaxed/simple;
	bh=7iKERP1Lv2gROot2wb/2KOfxcBH15nu9m/6SZSGHIvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TE+Mw3jQh8j/sft/jO1CVzFP5zK5qMch2p+elVaLsXtN1cBfjzSQN4yMgbZECci0n7stPHBcLBZkXrKRXb8k3sRW5NKXKl85hrlzhfAV4ymAP/k8gYRazrgGo6QnJ/5l6KTixCjzGf/kuww9ywtR8VX1R2urxTDmbICq6Mw7kRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yHnLtC6t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IRuZWME7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pm+AD9eE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=txzG34M/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yHnLtC6t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IRuZWME7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pm+AD9eE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="txzG34M/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 537A63E6C2;
	Fri,  6 Feb 2026 00:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ld0EhONF8Dzw4zh+qRWWNu6TTmralfQ24lkcj2BPgNs=;
	b=yHnLtC6tF2TFQwQ4x+FngBj69pP5kpZQ6VfEgj1MtJ8BRY7pWXnC5mRy0VmbvNm2NyWb32
	ynoLzO5JNybYbtfJw7ExbioI5ZuOBT959tePOgCiX8qjI8NUOB94PsKpwgFtbyYpXypYut
	z7t1Xld8/pJUEBWCLqNFUsskvt3IgEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ld0EhONF8Dzw4zh+qRWWNu6TTmralfQ24lkcj2BPgNs=;
	b=IRuZWME7RjRqB3ZZyuPHnEuFl2MPAs7t3akFOoBnEoBtmkpFzre8b3hoaZTaFCW2JQfHp8
	QFAzhwSDOx6AbZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ld0EhONF8Dzw4zh+qRWWNu6TTmralfQ24lkcj2BPgNs=;
	b=Pm+AD9eEMejOTU/4sHNE6dh4v0C3GIP0/Xo17qBEsyLNKC0OQ9vo3PC8IV8/kMrI2jRMRe
	yxZjVqZnotRRQ4xsweoIbkM1Sci7nvFyZH9jEivLqkdlsFY3H6U3e4GHX0EQj4DzUW9G6j
	moJXFoWp4E02rySsJUhpK8D5F+LQZ7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ld0EhONF8Dzw4zh+qRWWNu6TTmralfQ24lkcj2BPgNs=;
	b=txzG34M/QETSFI7dCp3zuX2A+GuxuIRZAXzlJeY/tR68jrG0856m5GI6IiB3UA4w0tF+Uj
	feschoJC1fUfehAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 680AB3EA63;
	Fri,  6 Feb 2026 00:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ag34BlEwhWnoFAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Feb 2026 00:05:37 +0000
Message-ID: <203249e6-e540-45aa-bcb0-1a4ff3979ef2@suse.de>
Date: Fri, 6 Feb 2026 01:05:34 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] sed-opal: add RangeStartRangeLengthPolicy
 parameter.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gmazyland@gmail.com, jonathan.derrick@linux.dev, gjoyce@ibm.com
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260205150935.238137-3-okozina@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260205150935.238137-3-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,ibm.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/5/26 16:09, Ondrej Kozina wrote:
> As desribed in ch. 3.1.1.1.1.2 of TCG Storage Opal SSC Feature Set:
> Single User Mode document.
> 
> To be used later in Reactivate method implementation and in function
> for retrieving SUM device status.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index 3dfba3de7be1..b9877eacfe91 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -225,6 +225,7 @@ enum opal_lockingstate {
>   
>   enum opal_parameter {
>   	OPAL_SUM_SET_LIST = 0x060000,
> +	OPAL_SUM_RANGE_POLICY = 0x060001,
>   };
>   
>   enum opal_revertlsp {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
