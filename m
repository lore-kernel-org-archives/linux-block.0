Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0C34106F
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994968; cv=none; b=OdnLzbr77JzQY1kr13tp1/f/BrposbRNz724HYEsfrqjVRBJpu/lbtAcQKLWD3czio0FpCXtrLrAJY7aG7rrK+ERrgynSXrJIX8lSvk1WhlW45gNeam7kiJRKpyt+hwECXXYFoZPUVPvOvFoAcufnlIqvCnKx3x6xC/V34D+Yrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994968; c=relaxed/simple;
	bh=tYSkd0F3Ch3JF6AUtujuwT6EeUTQkagaVfANESe2U4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFtc57BZaZOtum0TfW0BR1GL690sl7CkAAdYKLRT9sJqQVkXTt3P5wmdua9Lt8YpPDEZJAx194g/W/JP5PUYHoeEroQQNQUGPMbQV/2hLrPQKSZEuSlhWSoX6mEE/6Vig3ckAj4HpblVN06B+q5i8px3pnapwB5vRsY3jLxdAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E66053368B;
	Wed, 21 Jan 2026 11:29:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D65823EA63;
	Wed, 21 Jan 2026 11:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HDGIOpO4cGkoNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 11:29:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C07B7A09E9; Wed, 21 Jan 2026 12:29:19 +0100 (CET)
Date: Wed, 21 Jan 2026 12:29:19 +0100
From: Jan Kara <jack@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: bernd@bsbernd.com, Joanne Koong <joannelkoong@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] flex_proportions: Make fprop_new_period() hardirq safe
Message-ID: <ic7afxqrfrxjwhggezekc56oqmc7vapqxmffvwrd5xmrvjnimo@rhdbmk5hfydb>
References: <20260121091355.14209-2-jack@suse.cz>
 <zftwpsgfwct5bx55usazm6ulnthi4yvnhpaudtmby5tq2zf7zg@wz77c6nlvquv>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zftwpsgfwct5bx55usazm6ulnthi4yvnhpaudtmby5tq2zf7zg@wz77c6nlvquv>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: E66053368B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Wed 21-01-26 10:22:23, Jan Kara wrote:
> On Wed 21-01-26 10:13:56, Jan Kara wrote:
> > Bernd has reported a lockdep splat from flexible proportions code that
> > is essentially complaining about the following race:
> > 
> > <timer fires>
> > run_timer_softirq - we are in softirq context
> >   call_timer_fn
> >     writeout_period
> >       fprop_new_period
> >         write_seqcount_begin(&p->sequence);
> > 
> >         <hardirq is raised>
> >         ...
> >         blk_mq_end_request()
> > 	  blk_update_request()
> > 	    ext4_end_bio()
> > 	      folio_end_writeback()
> > 		__wb_writeout_add()
> > 		  __fprop_add_percpu_max()
> > 		    if (unlikely(max_frac < FPROP_FRAC_BASE)) {
> > 		      fprop_fraction_percpu()
> > 			seq = read_seqcount_begin(&p->sequence);
> > 			  - sees odd sequence so loops indefinitely
> > 
> > Note that a deadlock like this is only possible if the bdi has
> > configured maximum fraction of writeout throughput which is very rare
> > in general but frequent for example for FUSE bdis. To fix this problem
> > we have to make sure write section of the sequence counter is irqsafe.
> > 
> > Reported-by: Bernd Schubert <bernd@bsbernd.com>
> > Link: https://lore.kernel.org/all/9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com/
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Forgot to add some tags:
> 
> CC: stable@vger.kernel.org
> Fixes: a91befde3503 ("lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()")

Drat, now I've noticed I've messed up Andrew's address. I'll send v2. Sorry
for the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
