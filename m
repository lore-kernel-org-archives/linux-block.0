Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB113215070;
	Thu,  9 Jan 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413245; cv=none; b=U5HweTZsFp030nonmkbKGRRHP4Q05TYRATwqyJ9qVHi9x3xrFZHhe2DsJptUaTWaAujoWOagWHz2eB/4/85RG56h/JyuLjr6aIKaBD+hybm3+UhEvCW7KM51AwNxoEp0SORJqrzr0Gt59NTltKdxD9Nf5EZ4oIk4H9A5lxfF570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413245; c=relaxed/simple;
	bh=bsE2ARbB9o5Z8AwLBX/oR8vjX/TErnLDFW0BNy80BNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGJpRWRHw9LNurdnvyLmi09KArkXaTOS7dvYK2DJlTNiItQXqFZJtLUy6pGYpyOnLVZhr3+yFq4rCtghzJzj9nEXvv/iQBMRz+EAr5YZq5rG57S7eQxLCxvsg1Dd9wgBZo3NcrxCoyizjH7lLzeRFSY/Qf2Z1R5TF1xRpNTi/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUdnUaAI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z2DO1vtL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jUu6r9e6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKiNcefD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUdnUaAI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z2DO1vtL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jUu6r9e6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKiNcefD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE1D721125;
	Thu,  9 Jan 2025 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736413242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68sfub95AD56Ep7sRFsCEl5huT8KaqwruYypSyY9W9s=;
	b=XUdnUaAIl7mOWDHA48WqY0q1g9mHfrfk/7NlIngFY6dPI+9TQkMl+GwXhvFw0qfTK6UoF0
	Gpq31h9ZF952w30qNzwE98NlMUDzMGt0pIcpSgUcBSkrl2/E0EM0tRA9qK95iY6e/JJ1TP
	xBlv8LHQZoZIsryAt8ROZlpSO+pXnVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736413242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68sfub95AD56Ep7sRFsCEl5huT8KaqwruYypSyY9W9s=;
	b=z2DO1vtLtkdIdwXfKpB66gKAEP78UaONA4PMKmgSSKrM/pLPQFZfzV2osi2UJdlWpHqu2+
	5LEzHuVaUcaWolDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jUu6r9e6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PKiNcefD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736413241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68sfub95AD56Ep7sRFsCEl5huT8KaqwruYypSyY9W9s=;
	b=jUu6r9e6AXmf01C3JFWyAd3Q8NOBBl/Zud+5/ByHQhEhZMEgVnBMwWHzT/FuPtul2+0Ahz
	F20vvlto7fOigdR0QUCZ3kTUCRKJg8qyvHIqgtCwFUTkbkOCBFT3Ha16oE4DkWjCUpbKan
	oqcYDLIBBTDQ0NfY4RiQVHwsFXcJjOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736413241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68sfub95AD56Ep7sRFsCEl5huT8KaqwruYypSyY9W9s=;
	b=PKiNcefDTKCL7LE1Dfj9Y4zAt5+1MWjGVsIg0V7uF3jGgCi4GX/HxiQOUEq8JvdRGgrJq+
	7HUWA/6b+J9xgwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E289A139AB;
	Thu,  9 Jan 2025 09:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WBpJNzmQf2fAcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Jan 2025 09:00:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5462BA0887; Thu,  9 Jan 2025 09:50:51 +0100 (CET)
Date: Thu, 9 Jan 2025 09:50:51 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()
Message-ID: <syxzk4eauh3zzs37y6eirzlblp5lin6wyrpanw2mleliyj6cnr@2y3a7hrnet2o>
References: <20250108084148.1549973-1-yukuai1@huaweicloud.com>
 <odhd37amhss2kfhniix2jzy4crg4fb2d7u6qdwplevyiegb6rm@f4fqrg4vebls>
 <db7c26e0-c6b3-c4cf-afa9-557b2841cb69@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db7c26e0-c6b3-c4cf-afa9-557b2841cb69@huaweicloud.com>
X-Rspamd-Queue-Id: EE1D721125
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 09-01-25 09:32:08, Yu Kuai wrote:
> Hi,
> 
> 在 2025/01/08 22:42, Jan Kara 写道:
> > 
> > 
> > >   			 */
> > >   			if (bfqq_process_refs(waker_bfqq) == 1)
> > >   				return NULL;
> > > -			break;
> > > +
> > > +			return waker_bfqq;
> > 
> > So how do you know bfqq_process_refs(waker_bfqq) is not 0 in this case?
> 
> Because in this case, waker_bfqq is in the merge chain of bfqq, and bfqq
> is obtained frm the current process, which means waker_bfqq should have
> at least one process reference that is from current thread.

Ah, right. Thanks for explanation. The except for the typo the patch looks
good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

(although I can see Jens has already picked up the patch so probably this
is immaterial).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
