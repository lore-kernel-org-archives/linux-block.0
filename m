Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A855A0E1
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445555; cv=none; b=rBNMj0XnySnziIIs6RmdqVQwAWkStYDTiiZ0cMphlyaA/wJm+/cdYvgqeC35jqvgn/Yho+b3wH7ikn10aMpAXpI3S16jNr5v0uV5a7xK1EdF8wFSf80C5qRv/FdG8Va7kygqns+yKKrR5sPyv7/lIZSnS4D3bS/JYbQcHvQclOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445555; c=relaxed/simple;
	bh=iCENdr69u5D/wlND+exyoXR2MRMPNpwI8IEP2COlDMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1wO5stlLE7A4BWut0jiEv+x6mIidy7mBoYCr0Qoc6EtoaS1ouXEqc0YAPQK+ctDgRXqbpip8itk+F/drL1w5DWYQ3cDtrVsvCmXSAvQktvK/A7GkitF/XnO7PhudUlchBCzMkD6s6BHr7ZnuvEPWh3H20296eMCqfVRQLf6fAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/BF39b4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/goQ2ldy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/BF39b4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/goQ2ldy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/BF39b4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/goQ2ldy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/BF39b4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/goQ2ldy"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F293534C;
	Tue, 26 Mar 2024 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711445026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=y/BF39b4shPQzjxBaQrzQHx+rKCH6AnrIcfKPrO7DrYVYw2WzPyHknHeswYbagtqKGHvLK
	9AvMx6AqwhFYSVNr7gYFdOwlvntuH3L5wLnWZsGSHHBdF/R+NCuPiHdJND20i0kmaYWggm
	JkDjfyOwRg2GYSg1awv9RkAFsj3X8h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711445026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=/goQ2ldyNdTbi8SQPwvawbsg1gnrqzxgeJj6jDNzoSzb/Qm9+ReTcFKTH16SVOyux/oYyT
	E01cE2xT+XYSKfDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711445026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=y/BF39b4shPQzjxBaQrzQHx+rKCH6AnrIcfKPrO7DrYVYw2WzPyHknHeswYbagtqKGHvLK
	9AvMx6AqwhFYSVNr7gYFdOwlvntuH3L5wLnWZsGSHHBdF/R+NCuPiHdJND20i0kmaYWggm
	JkDjfyOwRg2GYSg1awv9RkAFsj3X8h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711445026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=/goQ2ldyNdTbi8SQPwvawbsg1gnrqzxgeJj6jDNzoSzb/Qm9+ReTcFKTH16SVOyux/oYyT
	E01cE2xT+XYSKfDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 15D4813587;
	Tue, 26 Mar 2024 09:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ed8ABCKUAmZtBAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 09:23:46 +0000
Date: Tue, 26 Mar 2024 10:23:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 02/18] nvme/rc: silence fcloop cleanup
 failures
Message-ID: <y7n4krsyu2trzaiv3kjyesuvu7g7vonc2akcjv3swl7inyxpeu@ooe7ubijthib>
References: <20240322135015.14712-1-dwagner@suse.de>
 <20240322135015.14712-3-dwagner@suse.de>
 <nc33lqabldktsxsdrmnjrpdagp2vnqid3vr5u4r2xwf6cuhjmv@cgvtqfzcrxds>
 <bl3civ2dzinzrmlb5mg4lpkutwfb7d6sx5a6qtiequj2x44vvm@d72cun3ezvkq>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bl3civ2dzinzrmlb5mg4lpkutwfb7d6sx5a6qtiequj2x44vvm@d72cun3ezvkq>
X-Spam-Score: -2.22
X-Spamd-Result: default: False [-2.22 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.42)[91.06%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Tue, Mar 26, 2024 at 08:39:18AM +0000, Shinichiro Kawasaki wrote:
> On Mar 25, 2024 / 19:27, Daniel Wagner wrote:
 >   (echo "foo" > file) 2>/dev/null
> >   {echo "foo" > file} 2>/dev/null
> > 
> > I suppose we want to keep it simple and just add the brackets around the echos.
> 
> Both has pros and cons: added brackets are simpler, while file existence check
> is more readable, IMO. I think either way is fine.

I see, so let's go with the existence check, I also find it simpler to
read (understand).
