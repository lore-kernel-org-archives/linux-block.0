Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA32F52
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961997; cv=none; b=od2ES92wRYEtR63o4qZgy/nbW+kE2B+Z5lF3hfhPZmlDsfA7qoPbKzL+rCNF6krK8ezrbL028Qwz8mu5XqlRVKE28CovZnEeq5AsUn8cPclrPecZng2LO77O39BCinFMZD/H5Dbjit7tM2/W93ScUWrhN4gURjBBxbmhH0RqYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961997; c=relaxed/simple;
	bh=g+6s3OjerdwWdx/cbGlhpcmCUJkNXKycegcTcdtft4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHodNfWa3dcwYXYteRGW5ON2udDOGvkESrPSAoFfDgni8Gz+TqxiTG4KRTkC3NNa1t9DuJkQVvs6QC+M/66VLr4YgkpWQzjzaG2QDdwc2Xi6upzwedU/F1FMBjKLkVwpoSTi5qw2rtSmu29sudCni7uUB1+hUEnzYtsDoKvUrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JM+oj8kA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FFTXCVWt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JM+oj8kA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FFTXCVWt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JM+oj8kA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FFTXCVWt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JM+oj8kA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FFTXCVWt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C62766D87;
	Wed, 24 Apr 2024 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=JM+oj8kA2V3G95bx+S4i/QcQifsngg7DjkuNvDTwJrap+AAiV0C94cL3ox1w44sB+Rtivj
	XYW/v9clKXhAQ2GtLeEczrRm3wqmT/lRuIzmcnWgQ2vYa28LSmVIyqOKQMl4ZscTYjRZTu
	ZyG0wU/0OuS1P7hoTgWvFwKMnjSqKtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=FFTXCVWthE4JWGw8RZSbK7lJzlgm060dxvs/sOPRM3q/LXc5Dy593Nz57yabID4wHsmASl
	7CDlRCH5u6E0z/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=JM+oj8kA2V3G95bx+S4i/QcQifsngg7DjkuNvDTwJrap+AAiV0C94cL3ox1w44sB+Rtivj
	XYW/v9clKXhAQ2GtLeEczrRm3wqmT/lRuIzmcnWgQ2vYa28LSmVIyqOKQMl4ZscTYjRZTu
	ZyG0wU/0OuS1P7hoTgWvFwKMnjSqKtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSu2WIroNaqViDCfEfNhyd5e6UMGcjb/EgwDzXHjJqg=;
	b=FFTXCVWthE4JWGw8RZSbK7lJzlgm060dxvs/sOPRM3q/LXc5Dy593Nz57yabID4wHsmASl
	7CDlRCH5u6E0z/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FAB11393C;
	Wed, 24 Apr 2024 12:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UOneDgr8KGZkcAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:33:14 +0000
Date: Wed, 24 Apr 2024 14:33:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 15/15]
 nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE
Message-ID: <fmleopq3aey644hrnnlvlrwajqwapsq6wetl2vecrt6wq7kb6t@eclzulglhelh>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-16-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-16-shinichiro.kawasaki@wdc.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed, Apr 24, 2024 at 04:59:55PM +0900, Shin'ichiro Kawasaki wrote:
> To follow uppercase letter guide of environment variables, rename
> use_rxe to USE_RXE.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

>  	{
> -	if [ -z "$use_rxe" ]; then
> +	if [ -z "$USE_RXE" ]; then

Maybe use the opportunity to use switch to "${USE_RXE}" form of the
variable access when you are touching these lines?
