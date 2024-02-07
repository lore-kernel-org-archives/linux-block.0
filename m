Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580E20319
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293997; cv=none; b=twnpA+TwPyx6YZR/BlDUYeHt1uzgx1rcV9Krh7cVOABCWblRkzd7UCy/MfULkvfyWgn69GZ1SRPBetrp0S6oIwBhwYXtrGWJ/pm0LeJp5XSOynAuYjWNE4a31IHxeYddtdWh7g624xqKfgRQTwC5Rmh6XMqTwEWLuGAdR1T2LRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293997; c=relaxed/simple;
	bh=gqfJ175z/DNOnqOb4ZJkRUR2jHupp3/Tf1663NQC3sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwtSGPHhY3YKjo82m6h3/l4fwRZh0OoSe9QZDckDrU48KPh37XRKvQ++fHavH7PUkEqqkeLg+8EbooWhGSlseIXPagPjxKaJrA+3mwd7NWfUUXys+MmnZhNhNBLTgFXRv2fz5k4LuUtRE+Xmz6L0TIL0GjhNC17QyglEmbm+EPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=izgKoDsj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sFc1cyLX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=izgKoDsj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sFc1cyLX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="izgKoDsj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sFc1cyLX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="izgKoDsj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sFc1cyLX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 496FD1FBAF;
	Wed,  7 Feb 2024 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707293994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HswcgD+wF+zsYPW9Tr0zNAl//DMHo/KNPL/L085dsGw=;
	b=izgKoDsjz7VZ0Us5vxfjTnNTz5eIMxiy5LUrJSAtNl/vtdAcRJEHRbYgWW6x9E3q8P6PFL
	Y5DxP9JJzWR9sgpb83vTNbQyo9GjMJqJ5s/e8h9mRsPyrf+OjfjOgJ59l2tzg6CGgoj2TW
	bCY9jNb/0Jh9Nj2ZvZSgTvUy9grr6M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707293994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HswcgD+wF+zsYPW9Tr0zNAl//DMHo/KNPL/L085dsGw=;
	b=sFc1cyLXrCfG5H2Bm4BEhr7BSBpxYQukJ0XZtSSOpCXw0mjIJ3pbSi/seqnq+YZ/YjZOe6
	WYh8LzA2jRxud3BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707293994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HswcgD+wF+zsYPW9Tr0zNAl//DMHo/KNPL/L085dsGw=;
	b=izgKoDsjz7VZ0Us5vxfjTnNTz5eIMxiy5LUrJSAtNl/vtdAcRJEHRbYgWW6x9E3q8P6PFL
	Y5DxP9JJzWR9sgpb83vTNbQyo9GjMJqJ5s/e8h9mRsPyrf+OjfjOgJ59l2tzg6CGgoj2TW
	bCY9jNb/0Jh9Nj2ZvZSgTvUy9grr6M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707293994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HswcgD+wF+zsYPW9Tr0zNAl//DMHo/KNPL/L085dsGw=;
	b=sFc1cyLXrCfG5H2Bm4BEhr7BSBpxYQukJ0XZtSSOpCXw0mjIJ3pbSi/seqnq+YZ/YjZOe6
	WYh8LzA2jRxud3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3746E13931;
	Wed,  7 Feb 2024 08:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mNgSDCo9w2WSPQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 07 Feb 2024 08:19:54 +0000
Date: Wed, 7 Feb 2024 09:19:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v1 2/5] nvme/rc: filter out errors from cat when
 reading files
Message-ID: <v3vntta4ddcecc5oobzq47hy6o5lgsfjxhuxkrakzkmjltxf3j@b56sgoqrory4>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-3-dwagner@suse.de>
 <3bac2a80-fb9d-4e79-a2a3-2ecac14812ef@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bac2a80-fb9d-4e79-a2a3-2ecac14812ef@nvidia.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=izgKoDsj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sFc1cyLX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.71 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.70)[93.13%]
X-Spam-Score: -4.71
X-Rspamd-Queue-Id: 496FD1FBAF
X-Spam-Flag: NO

On Tue, Feb 06, 2024 at 11:07:06PM +0000, Chaitanya Kulkarni wrote:
> >   	for dev in /sys/class/nvme/nvme*; do
> >   		dev="$(basename "$dev")"
> > -		transport="$(cat "/sys/class/nvme/${dev}/transport")"
> > +		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
> 
> do we have to do anything if there is in error ?

In this case transport will be '' and not match with '${nvme_trtype}'.
So we already handle this properly.

> >   		if [[ "$transport" == "${nvme_trtype}" ]]; then
> >   			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
> >   			_nvme_disconnect_ctrl "${dev}"
> > @@ -840,7 +840,7 @@ _find_nvme_dev() {
> >   	for dev in /sys/class/nvme/nvme*; do
> >   		[ -e "$dev" ] || continue
> >   		dev="$(basename "$dev")"
> > -		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
> > +		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
