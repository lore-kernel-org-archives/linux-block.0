Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0C15ADAE
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961707; cv=none; b=nCnExlJPEyMY/BDdTgKdlIlgaI5VZgWNnnmpvA6zJ+N//YFbYQpak3pEBh0wycg4Al3vR046ilBTW0yq/1uZpBF43CWhF1eX366UgP7aWQrCY+scGIAFlUVDT7INxKzMB0UPr8ZIq2tZl0NbXjrKHcEwc/ZQDUNNQU00lJ+5CJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961707; c=relaxed/simple;
	bh=N1g4eHh2Y9pcDsnM+lU+AaO698EiEp3WNypvrDBW+yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+cMu2EyFYV9wjE9PJDIV4zCHB5JxYsc34OucSf6LwV3Icbf/PUdz6Uf8vQFBgis+oksELoKcg+4JNkezG5v+/EbE3UuvLnlF+YI1ZVSBDeB3WjEfBVBGl1EaQhi3/4/GB+Cfyu0S8x57U5mhXQdbZvvBEmqxcHadgBNQDLgjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E0fVq+Yg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U6gxe5ax; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E0fVq+Yg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U6gxe5ax; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E0fVq+Yg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U6gxe5ax";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E0fVq+Yg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U6gxe5ax"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9522866D82;
	Wed, 24 Apr 2024 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=E0fVq+Ygse1z/uWjC6iQ+wc32zujLcN/en/s0JUPOnflqhkPjrSPXMHJNrSBfX2zgVv76l
	4V3MqowQyDrZB4KdBCfPMl5/Ra9OjV2vMoagEbLiHjunesXb3IIg2YIjqD4JNYMMA1aQSw
	TPhnbU4RqA1JrpxqNuNcg+UTuAMhPXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=U6gxe5axNlNOLncQv8uWy0F2XEDE3r/1WGKemO8co+HglnyEh2TzkWs71hXsjxRXweEECW
	E00XQSnK33t0J3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=E0fVq+Ygse1z/uWjC6iQ+wc32zujLcN/en/s0JUPOnflqhkPjrSPXMHJNrSBfX2zgVv76l
	4V3MqowQyDrZB4KdBCfPMl5/Ra9OjV2vMoagEbLiHjunesXb3IIg2YIjqD4JNYMMA1aQSw
	TPhnbU4RqA1JrpxqNuNcg+UTuAMhPXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O+eLxdYAF6bkHqp83YpWX0eof1PThwEJfivUOb23Lg=;
	b=U6gxe5axNlNOLncQv8uWy0F2XEDE3r/1WGKemO8co+HglnyEh2TzkWs71hXsjxRXweEECW
	E00XQSnK33t0J3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A54D1393C;
	Wed, 24 Apr 2024 12:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2ke1Ief6KGaibgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:28:23 +0000
Date: Wed, 24 Apr 2024 14:28:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 06/15] nvme/rc: introduce NVMET_TRTYPES
Message-ID: <436qpoiaezdnkm3xdtlcbzy7n5ee4kobhfqsvst27si67a46gh@msehpblovq5d>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-7-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-7-shinichiro.kawasaki@wdc.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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

On Wed, Apr 24, 2024 at 04:59:46PM +0900, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group can be run under various nvme
> target transport types. The configuration parameter nvme_trtype
> specifies the transport to use. But this configuration method has two
> drawbacks. Firstly, the blktests check script needs to be invoked
> multiple times to cover multiple transport types. Secondly, the test
> cases irrelevant to the transport types are executed exactly same
> conditions in the multiple blktests runs.
> 
> To avoid the drawbacks, allow setting multiple transport types. Taking
> this chance, rename the parameter from nvme_trtype to NVMET_TRTYPES to
> follow the uppercase letter naming guide for environment variables.
> NVMET_TRTYPES can take multiple transport types like:
> 
>     NVMET_TRTYPES="loop tcp"
> 
> Introduce _nvmet_set_nvme_trtype() which can be called from the
> set_conditions() hook of the transport type dependent test cases.
> Blktests will repeat the test case as many as the number of elements in
> NVMET_TRTYPES, and set nvme_trtype for each test case run.
> 
> Also introduce _NVMET_TRTYPES_is_valid() to check NVMET_TRTYPES value
> before test run.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
