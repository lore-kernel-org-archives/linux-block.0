Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A753E1E
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015086; cv=none; b=IuREUF3x8DEZoudOen2tN3bxW8V5KN7CUjWdM5q1SUtxrEMtOzOlEgHJePCY6Qttrl9FhvQXiGpTUDYiNQxKXhZBrDGKp5Zp6vGlHmkI9AaLCd2RQ5GhqrZlgRSVAUzBq2Ge0oA7prwzZuXsa+/vBqsWC9nWxO6iwe3m44j7nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015086; c=relaxed/simple;
	bh=+n2bIgJRZwjjdDUMuUqy1Y2ivcC6mQmXvABFF9n4HCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaGlDVMK63+rLvVf/kQSYWpQKzWLpaCgyR4JmHgK5wTwJySE7lTvaK/QxAUGF5eB9cgeZ5moQXWD05fUEC/qdm/mfN8LIP0APaa2gvQ6NzGkOTqm2tRdqkkH55vb4wbrG+EbMXVnUKzZL1LX9Td8VG8pxrSPfhAtUF7jGZxhEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Au7yFlj6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=En4CiItG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WEIOh6kb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b9xdAsyn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Au7yFlj6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="En4CiItG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WEIOh6kb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b9xdAsyn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CE415CBE2;
	Thu, 21 Mar 2024 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711015077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=Au7yFlj6X2n+OfsH4QiXbS14DXvR0z2//Co4GF77oPuzqATELDaFNhvh2i/dqBP7UUzxJm
	Qb/LSkEdvtTvwBnP7866pTMkIlNRDu1mI7nqZvv27gfBRVo69lR7wdKOvIlmHwGcEE3vk9
	7z0rgAybrW/xOSFhyfKOJhFXo2jYl7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711015077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=En4CiItGik1PzdoFvepvKRS/cIS1areDieP4orovD7qkso9B1ge/TlJ2Svj1F8+judi3mc
	zfNtvTwSM2j9mkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711015075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=WEIOh6kbCulTh4Hrwqu3v+50c2dPz9dAUkXT5ms2/h/87FyFz1T8aZ49Y396wR09NIZ7qK
	mx8M2zM1uisYyHDSUr3wDEbaNHSfueCTFTrjB4PEykFMoh1X03VX+iz4e7HETkwCl8s9nm
	X2ZHt/VK5SUV5igwtU7ai2G5t551xTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711015075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=b9xdAsynyOPBRFdffHExQ11SHpTy+9Eyz3nnef8ktbhHZmteUPCCAFzKwXXUniZIHY4+hq
	iIlV86Sv+GdvHWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3867413976;
	Thu, 21 Mar 2024 09:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XLJVDKME/GWDEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:57:55 +0000
Date: Thu, 21 Mar 2024 10:57:54 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 02/18] nvme/rc: silence fcloop cleanup
 failures
Message-ID: <ltt4ymu4sioby5tzlhg25lbspevul3p4vp6jj37tjawjuc5bw6@pmxzeozgzn2e>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-3-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321094727.6503-3-dwagner@suse.de>
X-Spam-Score: -0.81
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[48.37%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Thu, Mar 21, 2024 at 10:47:11AM +0100, Daniel Wagner wrote:
> When the ctl file is missing we are logging
> 
>   tests/nvme/rc: line 265: /sys/class/fcloop/ctl/del_target_port: No such file or directory
>   tests/nvme/rc: line 257: /sys/class/fcloop/ctl/del_local_port: No such file or directory
>   tests/nvme/rc: line 249: /sys/class/fcloop/ctl/del_remote_port: No such file or directory
> 
> because the first redirect operator fails. Thus first check if the ctl
> file exists.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 78d84af72e73..53fa54e64cb2 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -234,7 +234,10 @@ _nvme_fcloop_del_rport() {
>  	local remote_wwpn="$4"
>  	local loopctl=/sys/class/fcloop/ctl
>  
> -	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port 2> /dev/null
> +	if [[ ! -f "${loopctrl}" ]]; then

This should be ${loopctl}, obviously. Same for the other changes.
