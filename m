Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475618C91D
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430016; cv=none; b=OTL8n3DYYFOlPgpdr9t0zFniuNVTfi4dffgZ9AWyqVihPPf7caarnRKc5bL2Fa6FqS8ezC6yLtF7ZZsr10smP+bLVt/42XnJH80d7/1k4oNKARFdPVmciNlSW1oaz/wA+cf5EXTg+wkmo+MMmJo+AEQ47I6yEwktKmXkzhMHZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430016; c=relaxed/simple;
	bh=ud1anLOOLNG2VP/XYZpJ8TNu4KFwnbv32Rm8vxaTyOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6YLOsw/rYcp5bFqyQuOFAljSiKaVgDfUsbuw9nimsDTR6Vwq+zRBjud0YbqF0xi7VJXAA5GMsrA93DR9+Zaebc+0VDBm1qClOyfXS7TLzY8nj1mWrtPu4Gq1OpWNUve4nGzS6Zhl7wTHo6dGM+kxdL6CuI5A2jAjdgz8rbCiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xGNjPpyK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zWfheIxd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xGNjPpyK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zWfheIxd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xGNjPpyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zWfheIxd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xGNjPpyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zWfheIxd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0520821A76;
	Wed, 31 Jul 2024 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722430004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1KUF7B1GVDWVuiQ3nC3saB72D6UOFJs35Qg2kxMV/w=;
	b=xGNjPpyK8n0dFhYuffBi0f2PBpn5jjj188lfna9xNpmQ3MTdHreVF+A3QOoXCOY5J6/Uo6
	FEoKxhrcIVrJgUGW7JIUHhl19AcTB3Jw+jE9yeowXeFPuvCwM3cHyI2+nBSDktr2XleVLY
	eoE/I0pZHa3u5GeYPTK5WdR2sMhDrMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722430004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1KUF7B1GVDWVuiQ3nC3saB72D6UOFJs35Qg2kxMV/w=;
	b=zWfheIxduwPdI0EfStKC6fYKQtPNPoCHQeGQ6BdE4+BOQqVO/KqcIZmOoBXPrOZS9g6V7y
	ATNn9R2DNJvoWADw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722430004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1KUF7B1GVDWVuiQ3nC3saB72D6UOFJs35Qg2kxMV/w=;
	b=xGNjPpyK8n0dFhYuffBi0f2PBpn5jjj188lfna9xNpmQ3MTdHreVF+A3QOoXCOY5J6/Uo6
	FEoKxhrcIVrJgUGW7JIUHhl19AcTB3Jw+jE9yeowXeFPuvCwM3cHyI2+nBSDktr2XleVLY
	eoE/I0pZHa3u5GeYPTK5WdR2sMhDrMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722430004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1KUF7B1GVDWVuiQ3nC3saB72D6UOFJs35Qg2kxMV/w=;
	b=zWfheIxduwPdI0EfStKC6fYKQtPNPoCHQeGQ6BdE4+BOQqVO/KqcIZmOoBXPrOZS9g6V7y
	ATNn9R2DNJvoWADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6F2713297;
	Wed, 31 Jul 2024 12:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AhAeODMyqmZ1VAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 31 Jul 2024 12:46:43 +0000
Date: Wed, 31 Jul 2024 14:46:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
Message-ID: <ZqoyDjCpaXPaU1uN@yuki>
References: <20240731111804.1161524-1-nilay@linux.ibm.com>
 <ZqoelLy4Wp33YAGD@yuki>
 <yuz6jvqbsctjhm47fpftvfpgea3x4sbji6kdmk47e5s6hz63ig@gvbiphrvl7wk>
 <914eec96-eb46-4cf1-9cbd-0e1f98059d1b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <914eec96-eb46-4cf1-9cbd-0e1f98059d1b@linux.ibm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.60

Hi!
> > According to www.kernel.org, the 6.9 stable branch is already EOL. Is it planned
> > to backport the kernel fix to other longterm branches?
> I just checked this commit 5f75e081ab5c ("loop: Disable fallocate() zero and discard
> if not supported") hasn't been backported to any of the longterm stable kernel yet.
> However I don't know if there's any plan to backport it on longterm stable kernel.

The patch will not apply into older branches since the in kernel API did
change, so I suppose that nobody will invest into rewriting the patch
since it's mostly cosmetic.

> Maybe, Cyril should know about it? 
> 
> If not planned for backport on longterm stable kernel then we may consider the
> proposed changes in loop/011 as-is.

That's strange, I got an email shortly after the patch got into
mailinine about the backport:

Subject: Patch "loop: Disable fallocate() zero and discard if not supported" has been added to the 6.9-stable tree
Reply-To: stable@vger.kernel.org

This is a note to let you know that I've just added the patch titled

    loop: Disable fallocate() zero and discard if not supported

to the 6.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     loop-disable-fallocate-zero-and-discard-if-not-suppo.patch
and it can be found in the queue-6.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit 6718aa792b7d297ece53024a138ea679e8153ea6
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Thu Jun 13 18:38:17 2024 +0200

    loop: Disable fallocate() zero and discard if not supported


-- 
Cyril Hrubis
chrubis@suse.cz
