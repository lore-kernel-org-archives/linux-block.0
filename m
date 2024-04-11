Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566517C6A
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860919; cv=none; b=oOjGVOTkpl+0kLBgGPVcwcSkPJiWVP5tAKT4y5pagdM96vbg7YG3oG1dC9orj6/zBH9xLi/5itwqn9sgYo68MjxTlFnO1r0HMhma8ugSnf7p1ukBfnJ5PAbbrRUqgCYNEzqsKSE/zehDECXHB+lE1Ohu4y/7iW7sKu+zm9HsnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860919; c=relaxed/simple;
	bh=MPBVeDkS8JSSeZluNl5KBM2I+calVjOIvBr31tjv2c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUdSYlQ9IFj4ueoZf5f3r2Nt2Rp6+FxMVx09HO5qDU3nLcLa88Ecfv5eTEYpufe6Jb9xuAdGa0FfmXwUY+99ItuMyNpWfZvehKzE452jV3zBdA2ZLu/dL4oOR4HoVCG7YLZhRsdpc9Wi0b84WPo1Puoi88irxm3qEmDnDLI6v6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KX6LE7Kr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jpoCZPlx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KX6LE7Kr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jpoCZPlx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KX6LE7Kr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jpoCZPlx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KX6LE7Kr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jpoCZPlx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A0775D3A1;
	Thu, 11 Apr 2024 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712860914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=KX6LE7Kr42MPPdCo/oKoU6ca66MlrlRjO3c9YKZ+q0QMUxpYWBiWnsEHB6XK+nNa7cVZsc
	CHgWwsoglmez044kbC94ZHUuxcMaR8tiAkurCqjlpP090ZSupwrnPf21ay3K+AnAS2RxdW
	lW1/rceYjqrz4Zi6FQuTPJhznIN4TS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712860914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=jpoCZPlx1/UPBfzQKlT7QllgURAlWXhuUCHJ156NF4dIAKOvkix0Q1OSttnRDMBhT+GCiS
	nEAtkNTenbW5PoCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712860914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=KX6LE7Kr42MPPdCo/oKoU6ca66MlrlRjO3c9YKZ+q0QMUxpYWBiWnsEHB6XK+nNa7cVZsc
	CHgWwsoglmez044kbC94ZHUuxcMaR8tiAkurCqjlpP090ZSupwrnPf21ay3K+AnAS2RxdW
	lW1/rceYjqrz4Zi6FQuTPJhznIN4TS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712860914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=jpoCZPlx1/UPBfzQKlT7QllgURAlWXhuUCHJ156NF4dIAKOvkix0Q1OSttnRDMBhT+GCiS
	nEAtkNTenbW5PoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671081368B;
	Thu, 11 Apr 2024 18:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9iOxF/IuGGY8GgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 11 Apr 2024 18:41:54 +0000
Date: Thu, 11 Apr 2024 20:41:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Message-ID: <ccnazevlqz6dybzhe6asib3rtlz62ynv24jc22q3cgsf666b4e@6sd6youpsrrb>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-2.70)[98.67%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -3.50
X-Spam-Flag: NO

On Thu, Apr 11, 2024 at 08:12:22PM +0900, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group can be run under various nvme
> target transport types. The configuration parameter nvme_trtype
> specifies the transport to use. But this configuration method has two
> drawbacks. Firstly, the blktests check script needs to be invoked
> multiple times to cover multiple transport types. Secondly, the test
> cases irrelevant to the transport types are executed exactly same
> conditions in the multiple blktests runs.
> 
> To avoid the drawbacks, introduce new configuration parameter
> NVMET_TR_TYPES. This is an array, and multiple transport types can
> be set like:
> 
>     NVMET_TR_TYPES=(loop tcp)
> 
> Also introduce _nvmet_set_nvme_trtype() which can be called from the
> set_conditions() hook of the transport type dependent test cases.
> Blktests will repeat the test case as many as the number of elements in
> NVMET_TR_TYPES, and set nvme_trtype for each test case run.

I suggest to keep the naming of the variable consistent, e.g.
NVMET_TRTYPES.
