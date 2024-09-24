Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676A5A79B
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160568; cv=none; b=sSoVGmIzcYvqWiwv0IqYNpKLZXdh12n57JfUT5QfNfp7VxK2mb1xNS1p3UeB4U2TYinzd1h/49UMX71EAXGwAXhOayITgeIDD4pRannoPRzffFrcSXGx9MeBnzLy23BjyuKYe1/vt9qN2dFCpEg6Sti2iw/n93u8fG73gK3f1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160568; c=relaxed/simple;
	bh=bWxwDga/3/ZPpSwVkbi9CRNIEgUdfLBW6bSk/2l9/4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SktC+KwsY7UoTPa4R/HpsXc/2M5V8ArKgfs2KeHnSQ1ev4uKDKTd/0ozLZxaw95MP69z0FWZrOmS0iBfXMmiPitU8NxbTufr+e4YA366TaFYYDhjVZ1BrJyGIIUAz1KjDXH3jEuJmDMHfLdT6QCoLRAKepphSvIbm4KVGLbzlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=URaDdTjv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L7LnQn4g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=URaDdTjv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L7LnQn4g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="URaDdTjv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L7LnQn4g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="URaDdTjv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L7LnQn4g"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1342421B1B;
	Tue, 24 Sep 2024 06:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727160565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+HTSuGE6TRWU07fT3tUoleSR00bIryOgymqfCqcAFE=;
	b=URaDdTjvIe2hQ+QGU9Czziopqoq/lKiYzfRKXSwHnu+/eGiqd/mB0uLhgrx3ASYF7RWRn0
	VrC98icBcOdbhxzrIYPajCE8X/Zkg8imdjh5U+rbgZ6TgyG+XdqTJV33Dm7j5codJ+SmFr
	K0l0zIj9iKJc+v06OiKT3yq+FvPt5Mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727160565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+HTSuGE6TRWU07fT3tUoleSR00bIryOgymqfCqcAFE=;
	b=L7LnQn4g7zqWcz1IPT7XDwwKchrqdC5Hzd9ekzsuMd9YXo0qZs7r3/qszF/nmMfm5t0GK7
	1mV8tpH3eKGl+pBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=URaDdTjv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L7LnQn4g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727160565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+HTSuGE6TRWU07fT3tUoleSR00bIryOgymqfCqcAFE=;
	b=URaDdTjvIe2hQ+QGU9Czziopqoq/lKiYzfRKXSwHnu+/eGiqd/mB0uLhgrx3ASYF7RWRn0
	VrC98icBcOdbhxzrIYPajCE8X/Zkg8imdjh5U+rbgZ6TgyG+XdqTJV33Dm7j5codJ+SmFr
	K0l0zIj9iKJc+v06OiKT3yq+FvPt5Mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727160565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+HTSuGE6TRWU07fT3tUoleSR00bIryOgymqfCqcAFE=;
	b=L7LnQn4g7zqWcz1IPT7XDwwKchrqdC5Hzd9ekzsuMd9YXo0qZs7r3/qszF/nmMfm5t0GK7
	1mV8tpH3eKGl+pBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F9F01386E;
	Tue, 24 Sep 2024 06:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6jgBPRg8mYBWQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Sep 2024 06:49:24 +0000
Message-ID: <7d355b78-fe13-4cb2-82f0-95795f61db36@suse.de>
Date: Tue, 24 Sep 2024 08:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
References: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
 <CAHj4cs8YGgmemMZDXmt7yHa+Xq3EiEvRWOJGEQTDjqGB2rAogw@mail.gmail.com>
 <5ce3b803-275d-4be3-a9bc-87d06a8f5033@suse.de>
 <jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1342421B1B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 9/24/24 08:38, Shinichiro Kawasaki wrote:
> On Sep 23, 2024 / 08:31, Hannes Reinecke wrote:
> [...]
>> How utterly curious.
>> This mentioned patch moves some sysfs attributes to a different location in
>> the code. The stacktrace you've posted indicates that we're creating a
>> controller while the previous one is still present in sysfs, ie that the
>> lifetime of the controller has changed.
>> I find it difficult to understand how the cited path could have changed
>> the lifetime of the controller object, but will continue to check.
> 
> I tried to recreate the failure, and observed a very similar but different
> symptom. Kernel reported the KASAN BUG global-out-of-bounds, in
> create_files() [3]. I confirmed that this symptom is triggered with the commit
> 1e48b34c9bc7.
> 
[ .. ]
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index eb345551d6fe..b68a9e5f1ea3 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] = {
>   	&dev_attr_tls_key.attr,
>   	&dev_attr_tls_configured_key.attr,
>   	&dev_attr_tls_keyring.attr,
> +	NULL,
>   };
>   
>   static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,

Oh, indeed. That'll be the correct fix.

Care to send an official patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

