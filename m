Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576BC153812
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006999; cv=none; b=DY8lI+BejdPxzr2jJTJFdceGEoBDNa4wdp/xDpJtaNWo6xDWnBFfeV3ZXwpDRH0w9nkzbRnGZ1zAQyt6Baj8F4/TevkA2NLRjxVISxK4IagdevgFEqYGo9mVv7Lv5Zcsv2KOrlTeayN6twU6V22nRd41dbO7UAs0lsyCpSEpcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006999; c=relaxed/simple;
	bh=f0WeVCUQ8SZrb5JWS/yoXIBvN3q1TOMiL45BadnN9nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn5yyg3iqGmjIEXoalMVXQMuay2utPo96Fc0fUjRFZuJdiKXCGeM+m0t7dsf94xgAMxfyGzTymWhmhO/etBavOcSzm6fu21ZN3Wp6iOn98y9xejaXrICwGfY5owr8e32kV5dJvOLFHVJ+eVOZ5GPD+VZ+lZ9uY9irr4rIAO4+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SL5+udpj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/W7JZHcY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SL5+udpj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/W7JZHcY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SL5+udpj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/W7JZHcY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SL5+udpj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/W7JZHcY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63EDD5FEBE;
	Mon,  6 May 2024 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=SL5+udpjAXfMhNXeLhVnbhlWtJbY41f2Rtyi+B9qPyIOUpXBecpcz44F5lvBq8y9/VOC8Y
	3fMePvzZVKA0p461qHRPFuO8hc/3ChMURl21WzUqMfC+8F0p88wPZ0DraN/6lwpwZMOqik
	TQiJsIcont9+X0USreafxRtqn35NDIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=/W7JZHcYxw7uJb9JbJ3m5gpLMCDqvWIAZbey+ge58rukWQlcdn2HpGf8XbKA9+XJGjY5ry
	1fCvAbkohZONJxAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SL5+udpj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/W7JZHcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=SL5+udpjAXfMhNXeLhVnbhlWtJbY41f2Rtyi+B9qPyIOUpXBecpcz44F5lvBq8y9/VOC8Y
	3fMePvzZVKA0p461qHRPFuO8hc/3ChMURl21WzUqMfC+8F0p88wPZ0DraN/6lwpwZMOqik
	TQiJsIcont9+X0USreafxRtqn35NDIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=336FFaNHx/3TCllaOeROXkCMakCFaGBzqPqFJK97brQ=;
	b=/W7JZHcYxw7uJb9JbJ3m5gpLMCDqvWIAZbey+ge58rukWQlcdn2HpGf8XbKA9+XJGjY5ry
	1fCvAbkohZONJxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50B971386E;
	Mon,  6 May 2024 14:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ic/EhTuOGY/dwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 May 2024 14:49:56 +0000
Date: Mon, 6 May 2024 16:49:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v4 06/17] meta/{018,019}: add test cases to
 check _set_combined_conditions
Message-ID: <gfnazciuedsmphy5ccyad2vcmr64o34rc3zl7bqtjuigbmzrk7@epqq75bpw2bi>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
 <20240504081448.1107562-7-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504081448.1107562-7-shinichiro.kawasaki@wdc.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 63EDD5FEBE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Sat, May 04, 2024 at 05:14:37PM GMT, Shin'ichiro Kawasaki wrote:
> Add test cases to confirm that the helper _set_combined_conditions is
> working. meta/018 combines two hooks, and meta/019 combines three hooks.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
