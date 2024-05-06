Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F5153811
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007229; cv=none; b=NgGyABpTcagU7r9MYg9J+QNMKrjGbTzb9qe3yKXq+CFMoZgrRIWdMiYdNDWGS3RwaUHKvkA3L5TjoerYZDJ9wgwRCxNu5dEJbEO98mvYgXSa4Z+B97vduSHG++fuS5Xc7+R32g0M+sjXWxtv0Q4ZLXVi3xdlRezx/cfmxqgSlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007229; c=relaxed/simple;
	bh=4xhiRsR1NNNmdoTcVck+4rYFhP53qEgtys+LxAMtHxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r30HeikxFqCfbCvJ1d6teojAQFzi+HKz8t7u5kZ6Hb3XgKmxBLyAKQqtKsI5o2WVv+aS268j0OzGz/eZoph+BwX3BvSNvvTYiLnLogCgHKejAFxeKfMHD4PW8f1H3GpSstw3+2CcZy/XQze6xcqUeneklgdCRPmABj1sh1PH3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mwdIUNQb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AFhhLSeP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mwdIUNQb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AFhhLSeP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mwdIUNQb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AFhhLSeP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mwdIUNQb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AFhhLSeP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB24E384ED;
	Mon,  6 May 2024 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715007225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecf3WfV3yIlat76MlETOxhUVrJEyehioYmjnnDXAGiA=;
	b=mwdIUNQboFWK7HsvEVh7RBrUrIUmC74wWN2ybYZ+l6QP1zJauWrZiJvNQd40So3VRzciud
	uUFu020Rtl0+G+v4xDTx1nhCHx95qpIc2gAAMYp9iNh3qWT501AWMw9qLISZNadvG4fcFM
	Gx0nntoFOk7D/vytB+LaVlUsVqh32Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715007225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecf3WfV3yIlat76MlETOxhUVrJEyehioYmjnnDXAGiA=;
	b=AFhhLSePHb2VA5D9wDK8ejYu3U4q5qG5EUMC8it4tlOTPmDNprujCQ2IKL892IeDnEGYGO
	w8uFfVAO7PbamaDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mwdIUNQb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AFhhLSeP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715007225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecf3WfV3yIlat76MlETOxhUVrJEyehioYmjnnDXAGiA=;
	b=mwdIUNQboFWK7HsvEVh7RBrUrIUmC74wWN2ybYZ+l6QP1zJauWrZiJvNQd40So3VRzciud
	uUFu020Rtl0+G+v4xDTx1nhCHx95qpIc2gAAMYp9iNh3qWT501AWMw9qLISZNadvG4fcFM
	Gx0nntoFOk7D/vytB+LaVlUsVqh32Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715007225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecf3WfV3yIlat76MlETOxhUVrJEyehioYmjnnDXAGiA=;
	b=AFhhLSePHb2VA5D9wDK8ejYu3U4q5qG5EUMC8it4tlOTPmDNprujCQ2IKL892IeDnEGYGO
	w8uFfVAO7PbamaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A98211386E;
	Mon,  6 May 2024 14:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EoTxJ/nuOGaReAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 May 2024 14:53:45 +0000
Date: Mon, 6 May 2024 16:53:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v4 12/17] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
Message-ID: <q7vwr3r7z75cymkgtrx5bshbt332gvpaxc4boc7fe6y2aes37e@ptzfola4wily>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
 <20240504081448.1107562-13-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504081448.1107562-13-shinichiro.kawasaki@wdc.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BB24E384ED
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Sat, May 04, 2024 at 05:14:43PM GMT, Shin'ichiro Kawasaki wrote:
> Enable repeated test runs for the listed test cases for
> NVMET_BLKDEV_TYPES. The default values of NVMET_BLKDEV_TYPES is
> "device file". With this default set up, each of the listed test cases
> are run twice. The second runs of the test cases for 'file' blkdev type
> do exact same test as other test cases nvme/007, 009, 011, 013, 015, 020
> and 024.
> 
> The test cases already support the repetition for NVMET_TRTYPES. Modify
> the set_conditions() hooks to call both NVMET_BLKDEV_TYPES and
> NVMET_TRTYPES using _set_combined_conditions(). When NVMET_BLKDEV_TYPES
> and NVMET_TRTYPES are set as follows, the test cases are repeated
> 2 x 3 = 6 times each.
> 
>       NVMET_BLKDEV_TYPES="device file"
>       NVMET_TRTYPES="loop rdma tcp"
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
