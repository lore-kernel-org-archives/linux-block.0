Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2251BC35
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391232; cv=none; b=JkjslRUdfNx1lm5p3W3vRcqs7KUFdot/ZFkzIoU6s+AHGJvAfNGmS7uC3l+0ZbZGuLbqYgCaUoYgN62vAGh3/GPQschisYY1GQB9JlbcnkGOwAm6arVViuviOEDGimALZjMz3ixw8Gsy78UHYyIFQfEzbM52oIcjjyoS/6AcvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391232; c=relaxed/simple;
	bh=efJ+AbF7sm/k/pvPMahIshSf+sINLeJ2JOc1uXT/bhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4l0kxwMeI8uDFMux+mJfwy4ge49TWONSXg6QPMUOYcHN3QXZz74sU4cuaxJarfvynlNBnt/gYPmheI+DPRQBVUocjYpdzOFqyDi4oB1Hj3quARMNRzTtxkyOElFMqentCDg2Fuu3PL2KvkGMOF21wNi0TuXND77s606Qi4KPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+WvP89L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NSptp7O4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+WvP89L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NSptp7O4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+WvP89L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NSptp7O4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+WvP89L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NSptp7O4"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FA575CA34;
	Mon, 25 Mar 2024 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711391227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6x5iHCvkblvaZVNYtuLrxE1FcS4yECs/2o6kk/23uk=;
	b=c+WvP89LfcmCMarUx/KmtIAfRTKsOZRHqy4j1B8eCQED605NJ4e3hZbEYgHo6fttcXMq+R
	9NeTZf/WFmVvdJnbLCHmAOXNkIrg0wCIBdrbzX6nOx1Lc4ufMNrxVV3sXxq88oeg7Wv4RA
	8RS0X3CWJPKzdh0jbtTjNv5c/25rTIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711391227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6x5iHCvkblvaZVNYtuLrxE1FcS4yECs/2o6kk/23uk=;
	b=NSptp7O42h8KqpWWusEEry/s7odbefUgkywvIx8hQzqm+FNQU3fR7oWHqfv7kK7LZ2p3Fx
	i18jlBkno2zIGsBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711391227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6x5iHCvkblvaZVNYtuLrxE1FcS4yECs/2o6kk/23uk=;
	b=c+WvP89LfcmCMarUx/KmtIAfRTKsOZRHqy4j1B8eCQED605NJ4e3hZbEYgHo6fttcXMq+R
	9NeTZf/WFmVvdJnbLCHmAOXNkIrg0wCIBdrbzX6nOx1Lc4ufMNrxVV3sXxq88oeg7Wv4RA
	8RS0X3CWJPKzdh0jbtTjNv5c/25rTIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711391227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6x5iHCvkblvaZVNYtuLrxE1FcS4yECs/2o6kk/23uk=;
	b=NSptp7O42h8KqpWWusEEry/s7odbefUgkywvIx8hQzqm+FNQU3fR7oWHqfv7kK7LZ2p3Fx
	i18jlBkno2zIGsBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4988013A71;
	Mon, 25 Mar 2024 18:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nEpGEfvBAWaNXgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 25 Mar 2024 18:27:07 +0000
Date: Mon, 25 Mar 2024 19:27:06 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 02/18] nvme/rc: silence fcloop cleanup
 failures
Message-ID: <nc33lqabldktsxsdrmnjrpdagp2vnqid3vr5u4r2xwf6cuhjmv@cgvtqfzcrxds>
References: <20240322135015.14712-1-dwagner@suse.de>
 <20240322135015.14712-3-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322135015.14712-3-dwagner@suse.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c+WvP89L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NSptp7O4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: 5FA575CA34
X-Spam-Flag: NO

On Fri, Mar 22, 2024 at 02:49:59PM +0100, Daniel Wagner wrote:
> When the ctl file is missing we are logging
> 
>   tests/nvme/rc: line 265: /sys/class/fcloop/ctl/del_target_port: No such file or directory
>   tests/nvme/rc: line 257: /sys/class/fcloop/ctl/del_local_port: No such file or directory
>   tests/nvme/rc: line 249: /sys/class/fcloop/ctl/del_remote_port: No such file or directory
> 
> because the first redirect operator fails. Also it's not possible to
> redirect the 'echo' error to /dev/null, because it's a builtin command
> which escapes the stderr redirect operator (why?).
> 
> Anyway, the simplest way to catch this error is to first check if the
> control file exists before attempting to write to it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 78d84af72e73..865c8c351159 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -234,7 +234,10 @@ _nvme_fcloop_del_rport() {
>  	local remote_wwpn="$4"
>  	local loopctl=/sys/class/fcloop/ctl
>  
> -	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port 2> /dev/null
> +	if [[ ! -f "${loopctl}/del_remote_port" ]]; then
> +		return
> +	fi
> +	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > "${loopctl}/del_remote_port"

BTW, I was told why the redirect doesn't work. The reason is that the
'No such file or directly' is issued by the shell and not 'echo' because
'echo' is a builtin command. Thus the right way to catch is to do

  (echo "foo" > file) 2>/dev/null
  {echo "foo" > file} 2>/dev/null

I suppose we want to keep it simple and just add the brackets around the echos.
