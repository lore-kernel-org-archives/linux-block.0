Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738A6D1C1
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459877; cv=none; b=SBmZjr+EoX1GaX6kb7GS18ZWynhNZFiu3PK4po1fAzb/rj6PYjc4b7SSFpkWn4DsG689BnBpqVaCqf3bnEwzTlXRCTWa4KAq50hsK2m5hQUrX0dhUEkmesXVfBxsOdZXZOiQRlNe3HI2oeJr4kXg1elb0OMN0CADA8fJdtc+1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459877; c=relaxed/simple;
	bh=FH4eUvD2rwUQeY8duKr3XaKHPjRF6ZYHyhwNl+wRr/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4dcPfyJOPJ1IEqgZsir4zXnrEZcwIKO4pVtp24Q5GMXI6Ace/msfP+z0yGCdCoytQ3cBBHHdV6Djcd5a0jiFp47qcAiph5io81HF3WFomUxc1iqCZjCbs1MVApR5a0uj6JfaasopZ0YfaskP1rj6K/FF87GesxMc/oOyLIuB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D9wowxCt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=29/a4FmC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OIbzs23q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+SgQgsv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D9wowxCt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="29/a4FmC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OIbzs23q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+SgQgsv"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D2A437C27;
	Tue, 26 Mar 2024 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711459873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dFr8iJxMUYqru3uZQDse7qwWHdgWBXjw3NaPv84aw0=;
	b=D9wowxCt+66zSHZpNEijyGwUIoYSiSUGeQlydmYOVp8o+qWKnY774rCguA+AZ6D5NP2wNR
	M+UTOntMTgGUte7GSof00zaAmae+zezRHeWY/gs7mtJRjydW3G8bVqM3r4JI1nUqmCh8Op
	92QEJVMqzTUfdlt84SVCOJa9NbVxdL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711459873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dFr8iJxMUYqru3uZQDse7qwWHdgWBXjw3NaPv84aw0=;
	b=29/a4FmC5BrgXYP5zgdHHxxGq1+lWxkJc7EQ6IdLwdOBWfGICloUVatBDSRtUHz+NmQf8p
	GrfA5oH3MAoOUgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711459872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dFr8iJxMUYqru3uZQDse7qwWHdgWBXjw3NaPv84aw0=;
	b=OIbzs23qJQcrE9jvQC/MU4h1iXElD4omGaC5UWjQolVmhpZrwaTygFL4Z2uWhy3P6Igcs6
	GXFNbUwvaxdMGpFTau8olelbqCe+UH0lrCJqx3GkURguSOf605fychV8VTr23NVCWjLxhF
	IqL5a8cwSa4Ywnu+aEsL6QGPILyACpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711459872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dFr8iJxMUYqru3uZQDse7qwWHdgWBXjw3NaPv84aw0=;
	b=F+SgQgsvzEXLU4Y/q/uwHLo7BdN70be70Iatrt18HVPW4Oyjl2P4xIUXKrQbIYESqAmZQR
	5nOhQeBAtwayJ+BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8B413587;
	Tue, 26 Mar 2024 13:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AwYOFyDOAmYYOwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 13:31:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0380AA0812; Tue, 26 Mar 2024 14:31:07 +0100 (CET)
Date: Tue, 26 Mar 2024 14:31:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240326133107.bnjx2rjf5l6yijgz@quack3>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <20240326125715.i23eo6sh5223tdmc@quack3>
 <20240326-eidesstattlich-abwahl-ddfb1c75c05e@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-eidesstattlich-abwahl-ddfb1c75c05e@brauner>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 26-03-24 14:17:20, Christian Brauner wrote:
> On Tue, Mar 26, 2024 at 01:57:15PM +0100, Jan Kara wrote:
> > On Sat 23-03-24 17:11:19, Christian Brauner wrote:
> > > Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> > > default this option is set. When it is set the long-standing behavior
> > > of being able to write to mounted block devices is enabled.
> > > 
> > > But in order to guard against unintended corruption by writing to the
> > > block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> > > off. In that case it isn't possible to write to mounted block devices
> > > anymore.
> > > 
> > > A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> > > which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> > > bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> > > the mode was passed around. Since we managed to get rid of the bdev
> > > handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> > > on whether the file was opened writable and writes to that block device
> > > are blocked. That logic doesn't work because we do allow
> > > BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> > > 
> > > So fix the detection logic. Use O_EXCL as an indicator that
> > > BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> > > for pidfds where O_EXCL means that this is a pidfd that refers to a
> > > thread. For userspace open paths O_EXCL will never be retained but for
> > > internal opens where we open files that are never installed into a file
> > > descriptor table this is fine.
> > > 
> > > Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
> > > directly be raised by userspace. It is implicitly raised during
> > > mounting.
> > > 
> > > Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> > > unset.
> > > 
> > > Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> > > Reported-by: Matthew Wilcox <willy@infradead.org>
> > > Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > The fix looks correct but admittedly it looks a bit hacky. I'd prefer
> > storing the needed information in some other flag, preferably one that does
> > not already have a special meaning with block devices. But FMODE_ space is
> > exhausted and don't see another easy solution. So I guess:
> 
> Admittedly, it's not pretty but we're abusing O_EXCL already for block
> devices. We do have FMODE_* available. We could add
> FMODE_WRITE_RESTRICTED because we have two bits left.

Yeah, I'm mostly afraid that a few years down the road someone comes and
adds code thinking that file->f_flags & O_EXCL means this is exclusive bdev
open. Which will be kind of natural assumption but subtly wrong... So to
make the code more robust, I'd prefer burning a fmode flag for this rather
than abusing O_EXCL.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
