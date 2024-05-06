Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94E153579
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007165; cv=none; b=sTG5aRGGEAKLpeBlvz5eVmEIcwLgHI/Fk8rd9uvqIzhBqi8mMdgGcE4j54wq8jIszkanUiORAlMPvSq8GOkHFFNL+c2NLMPqF8eA+INdZAGe/vuly5pvraOI3Qcux4lmQ3lx+IW+d4ESs+Kvuma9+f/bvBRwm4GQXsMfrj/bJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007165; c=relaxed/simple;
	bh=2vnluGhQlJXYmJhSuneWaYfmj+L6L5/RY8KvMZJH/aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgxg7ZE1izhsIZPqctScqdu4DFY8+BotW3G2q6umRq7hyaCtBS3toAvswTWjtZQn5GRxCnf79JP8R9jAJUtjC8JW9/GRQddtbbc8bLGHrK4t283I+WxtbF7vw9QM7hcJ4m5WO0zQ2e6uwdEBVQiG5g8oSi+X/rm11D3pc7Dp3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d2HAdc+m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZOmKbKIO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d2HAdc+m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZOmKbKIO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d2HAdc+m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZOmKbKIO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d2HAdc+m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZOmKbKIO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57FDC5FECA;
	Mon,  6 May 2024 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715007162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1pQ7U3qrTYsItgBsWxKkw9J+rTSle0buaN5rJJq5zY=;
	b=d2HAdc+mrPztMrjgrb6LCa205aglyqr17ERTQAlm3YwryDRheM4TiBF1osv95xfJ4rqwjA
	ChwBEp2j5jsi+FJDAq60L38vJE1X+5dxBU4TauaL29RHYeJ8fUqSnH1Ci97HPa2SlJP0Tt
	s5saU3MndizIt8xyIvdJ2almBMs9xjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715007162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1pQ7U3qrTYsItgBsWxKkw9J+rTSle0buaN5rJJq5zY=;
	b=ZOmKbKIOeFlssS8n8eOzTFLpcVrpf5BwXPEJD4OlRca32og+pJBtSqasuVYGxzHW8D6WxA
	7DAex/OXYh1ex+DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715007162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1pQ7U3qrTYsItgBsWxKkw9J+rTSle0buaN5rJJq5zY=;
	b=d2HAdc+mrPztMrjgrb6LCa205aglyqr17ERTQAlm3YwryDRheM4TiBF1osv95xfJ4rqwjA
	ChwBEp2j5jsi+FJDAq60L38vJE1X+5dxBU4TauaL29RHYeJ8fUqSnH1Ci97HPa2SlJP0Tt
	s5saU3MndizIt8xyIvdJ2almBMs9xjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715007162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1pQ7U3qrTYsItgBsWxKkw9J+rTSle0buaN5rJJq5zY=;
	b=ZOmKbKIOeFlssS8n8eOzTFLpcVrpf5BwXPEJD4OlRca32og+pJBtSqasuVYGxzHW8D6WxA
	7DAex/OXYh1ex+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45EC81386E;
	Mon,  6 May 2024 14:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dnugD7ruOGYyeAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 May 2024 14:52:42 +0000
Date: Mon, 6 May 2024 16:52:41 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v4 10/17] nvme/rc: introduce NVMET_BLKDEV_TYPES
Message-ID: <fespaqhpxqb566avgk7pdiknvlak733cqjx2flyk5tkor67uyj@htp47t452pit>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
 <20240504081448.1107562-11-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240504081448.1107562-11-shinichiro.kawasaki@wdc.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:email]

On Sat, May 04, 2024 at 05:14:41PM GMT, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group do the exact same test for two
> blkdev types: device type and file type. Except for this difference, the
> test cases are pure duplication. It is desired to avoid the duplication.
> When the duplication is avoided, it is required to control which
> condition to run the test.
>     
> To avoid the duplication and also to allow the blkdev type control,
> introduce a new configuration parameter NVMET_BLKDEV_TYPES. This
> parameter specifies which blkdev type to setup for the tests. It can
> take one of the blkdev types. Or it can take both types, which is the
> default. When both types are specified, the test cases are repeated
> twice to cover the types.
>     
> Also add the helper function _set_nvmet_blkdev_type(). It sets up
> nvmet_blkdev_type variable for each test case run from
> NVMET_BLKDEV_TYPES.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
