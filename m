Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBFD1DD88F
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979269; cv=none; b=Wfp6l8nKruZwwViSYrQTJSl51ThIa+lC4BGLK3ZLJgm04AjY/yru3o9/3GV179uRhJ467tUgC2EPhQ2FAQxKAlCjWYIiYYJUUhEmmfB+5WaEQ6J09gXIELGvlmc+O042FV5wzHXxXntDaJj4ZCGqRUl7T2IdejVdl6fEWZhNTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979269; c=relaxed/simple;
	bh=+zMDSGSHEYlOMmSGe9qL0MqO1qKomNIALVJlG/PWvj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5Momck5n7GYRif2qsd1rszf9NacQ19uykk9SoLFbrFg4+m/T3ELUwV+xrn6B9U1CRTcXVxTkK5lPIQDH7kc2ZRxWFL/c1OIBoZADEodhUxHaqKivS/uFn5JE+yZlQMsvA3htOsRAk4270/X5OMhuCFz3Xsy+IIVH0U5cBXYgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAEAjAb4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeUABNZi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAEAjAb4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeUABNZi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAEAjAb4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeUABNZi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAEAjAb4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeUABNZi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E39D21AA7;
	Thu, 31 Jul 2025 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753979266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOz1YRjQmhiiChsmZCkPqkMdW9nlE5JjozIkU6z1GjU=;
	b=gAEAjAb4nSkVOZQXSxGHCMrSIwi7QyCZ92KMSHxeucHm3dc0/UG2Ilki66/Y0ddDzXzA26
	MOy5ioUlDxwUYdBHYjB0KY2hk0wkfaIshIDNZes9ajGAJ/B79dD8p5qhjZsdhsHft+OvHM
	dZBaHkBohYf9MVMhkHTsHfSdaC99e7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753979266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOz1YRjQmhiiChsmZCkPqkMdW9nlE5JjozIkU6z1GjU=;
	b=UeUABNZiyMUWLBb3G8m/ZNHtZx2dHzox6C4YtFG33ItMoTNP0rcj+xKPzHS8HOGDvFmlOv
	PPA+mESu5fK3ijCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gAEAjAb4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UeUABNZi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753979266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOz1YRjQmhiiChsmZCkPqkMdW9nlE5JjozIkU6z1GjU=;
	b=gAEAjAb4nSkVOZQXSxGHCMrSIwi7QyCZ92KMSHxeucHm3dc0/UG2Ilki66/Y0ddDzXzA26
	MOy5ioUlDxwUYdBHYjB0KY2hk0wkfaIshIDNZes9ajGAJ/B79dD8p5qhjZsdhsHft+OvHM
	dZBaHkBohYf9MVMhkHTsHfSdaC99e7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753979266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOz1YRjQmhiiChsmZCkPqkMdW9nlE5JjozIkU6z1GjU=;
	b=UeUABNZiyMUWLBb3G8m/ZNHtZx2dHzox6C4YtFG33ItMoTNP0rcj+xKPzHS8HOGDvFmlOv
	PPA+mESu5fK3ijCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DC2613876;
	Thu, 31 Jul 2025 16:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NiLCDoKZi2jqJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Jul 2025 16:27:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A860A0A02; Thu, 31 Jul 2025 18:27:37 +0200 (CEST)
Date: Thu, 31 Jul 2025 18:27:37 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: yukuai@kernel.org, Jan Kara <jack@suse.cz>, axboe@kernel.dk, 
	akpm@linux-foundation.org, yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, Omar Sandoval <osandov@fb.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
Message-ID: <imit4dkxy55c6a6tfqzaa6hf67nrawedotc3rzltlmmgmf3b3t@nde6h6cy3agw>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
 <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
 <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
 <jr54uomodnzqyw4bu4hcdpllgafkhueyygiiempuudwjy3vir5@d7lv3jsxxqx2>
 <223acbc1-60d4-4687-8eea-5306aa44ae24@kernel.org>
 <c748a3ee-bf33-e13e-d507-984277acbb32@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c748a3ee-bf33-e13e-d507-984277acbb32@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7E39D21AA7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 31-07-25 10:38:58, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/31 2:24, Yu Kuai 写道:
> > hi, Jan!
> > 
> > 在 2025/7/30 21:03, Jan Kara 写道:
> > > I think having two APIs will be even more confusing than the current
> > > state.
> > > But as I wrote I think you can have API to specify shallow depth in total
> > > size and in sbitmap_queue_get_shallow() do:
> > > 
> > > shallow_per_word = (shallow_depth << sb->shift) / sb->depth;
> In order to consider the last word, I think we should use __map_depth()
> here.

Right.

> > > rounding_index = shallow_depth - shallow_per_word * sb->depth;
> And then it's not possible to calculate this rounding index easily. How
> about following, although the reminder handling is not perfect.
> 
>  static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
>                                              int index,
>                                              unsigned int shallow_depth)
>  {
>         unsigned int word_depth = __map_depth(sb, index);
>         unsigned int shallow_word_depth = word_depth * shallow_depth;
>         unsigned reminder = do_div(shallow_word_depth, sb->depth);
> 
>         if (reminder && !(index & 0x1))

Well, why not:
	if (remainder > index)
?

That should accurately distribute the remainder across the remaining words,
shouldn't it?

>                 shallow_word_depth++;
> 
>         return shallow_word_depth;
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
