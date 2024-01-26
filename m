Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CFB657
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253291; cv=none; b=asfNnUR9ja89td5iTRvv5/4CPvInXAAPXjffKhjKPcIf0SofOx5kfI3AqaqVN5F5JlnO8E92JAo0yOJeyvmuB1W3NVTeKQPqINCeDvVWPyR8Q1sOp2WQcN1kUDoRha/t/RIMKeEmcYruAPy2ZRFRNe8td9gdRqmQhJ1+DWTqAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253291; c=relaxed/simple;
	bh=7X2NGQ1wwgSHJCHQdht8/l9kVYA2StD3+iMNEVqpnXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T86v2m+0igqJyxuUx9w4Oj7uaxxMB0LE/5u+0tTc3Y3wnylKCtjJR4l2Oh0T6vlSH13tsFGmcLcT18NnyToAd5l7T6SxuzfTHbLMoWjmCd3dsAI+VooIJIAHyNLc67x7RxKgDD4fq9YivnqlKnAoPfPADQahqqfn9hjJ+7Qy3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pjU12WX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZP6hzGx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vZ6ZRMlf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jd1ss7pz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pjU12WX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZP6hzGx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vZ6ZRMlf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jd1ss7pz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF65221E81;
	Fri, 26 Jan 2024 07:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706252722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqQcoPr6KBTCHu4iVWfjMisxo4tOmhcU5Qb8Ek4OJTY=;
	b=pjU12WX6oEe2cL5PQu0mAXnlmh2wtLT7eb8L2qvA9w8NGju36H+zDnq0j0ICEJwbIVCj86
	Su9rqssIHTKB4/uc2OE80GO2TpvqBK9d1VofXf/RdVbeejQSixM7JwvChNuRyyzJDRc173
	mg1TmA4kVY5TAbhczxXyfCiXc/qmcCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706252722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqQcoPr6KBTCHu4iVWfjMisxo4tOmhcU5Qb8Ek4OJTY=;
	b=XZP6hzGxZQV7AJPIONiJMYBAJcYhQvP5XKaN0CwCgA31QadCysMmxDIChnoO9ZK0xnkoyy
	R3BT96axzHayLzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706252721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqQcoPr6KBTCHu4iVWfjMisxo4tOmhcU5Qb8Ek4OJTY=;
	b=vZ6ZRMlfpvrefIl+hkJr94FQnmUNAen5Qz2rEYITN4/qAZvBTzMK91lBpqp80iAxCP2xhq
	J4VcR9kE1pw+3zupERWL+GfCMQl0bbo0lHbM/XjwOKYQZHuZimj9q59c4Vl6PJ7DD2TjOt
	6xhKlrY2ygi13Kgw6wRIgniYG2AQ3AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706252721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqQcoPr6KBTCHu4iVWfjMisxo4tOmhcU5Qb8Ek4OJTY=;
	b=jd1ss7pz0WLHlOA/DbGX+TtjY2H3nst+dDcjfPS0ghrk9oLMuZfKG7p0Qv4s/SrC325QFp
	TGM8YUUAd8866ODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9F65134C3;
	Fri, 26 Jan 2024 07:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 08y5J7FZs2WWXwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 26 Jan 2024 07:05:21 +0000
Message-ID: <84dce2ee-5d71-47a4-b114-3ca69b3c31fb@suse.de>
Date: Fri, 26 Jan 2024 08:05:21 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: Always split BIOs to respect queue limits
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20240126005032.1985245-1-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240126005032.1985245-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vZ6ZRMlf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jd1ss7pz
X-Spamd-Result: default: False [-1.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 BAYES_HAM(-1.42)[91.08%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CF65221E81
X-Spam-Level: 
X-Spam-Score: -1.72
X-Spam-Flag: NO

On 1/26/24 01:50, Damien Le Moal wrote:
> The function null_submit_bio() used for null_blk devices configured
> with a BIO-based queue never splits BIOs according to the queue limits
> set with the various module and configfs parameters that the user can
> specify.
> 
> Add a call to bio_split_to_limits() to correctly handle large
> BIOs that need splitting. Doing so also fixes issues with zoned devices
> as a large BIO may cross over a zone boundary, which breaks null_blk
> zone emulation.
> 
That feels so wrong. Why would we need to apply queue limits to a bio?
(Yes, I know why. We still shouldn't be doing it.)

Maybe indeed time to kill the bio-based path.

But until that happens:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

