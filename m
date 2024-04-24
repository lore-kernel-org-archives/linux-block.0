Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5372F52
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961836; cv=none; b=bTrNSxTLiMs94x6lHv1+Lls+Oye4vRuaRvyooca4+OVQjfJUV9BAssqmxoBHTCWz/rM6jdCcaHxyIZpZgYxZ4viJyWTlCvCiU7NQJvrKHTxqYk+1HulWq9/f9dcNBINHI5/e/+4p/DgzwZco8MkH5JhEk001WyVup6kI6qYgJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961836; c=relaxed/simple;
	bh=NjjrT5x1rZLiUc9scMxS7oIou5vn9sBXo1vsJhpodxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpyWGw3MIQBkGZuet7yWucbuXggE2QdPBJu8LRXoBedJ3KveYciQEa6BmQz9g1vQCBi3jk8DSUB/eIJO2Xuu0yTso71TCbq+OSTCbah82sZDqS5lDbe0+lHq1Q1zJpIEUpw/w4WSdYMJuRJESAK1DuD3YPhgchaqat3eCZe++i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pc0Fwl6L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LmdV69A+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pc0Fwl6L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LmdV69A+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pc0Fwl6L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LmdV69A+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pc0Fwl6L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LmdV69A+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AC6966D87;
	Wed, 24 Apr 2024 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=Pc0Fwl6Lep2XdJoc49lu+ig2pAMvoGP/DVU46ALoSVV8GRxgtSDbHgonyhTseL1uI1yhZx
	5zNTOvjZ2pqgfLbVTzzw9+AzTquIqt03n0lpOmxjTRW0gY4HTTZFwrrgIVe830mwtYIqqZ
	k8Nxy5P8fNoBSmZZSdHGidMH6hCBeGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=LmdV69A+KtCqCqscvp//9CCKmiEAoMgcntcI9QHqo5jTzD5sr9RQ8qbcC5Z4A+CEnbuZkI
	1xYvJJbT2XvUkbAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Pc0Fwl6L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LmdV69A+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=Pc0Fwl6Lep2XdJoc49lu+ig2pAMvoGP/DVU46ALoSVV8GRxgtSDbHgonyhTseL1uI1yhZx
	5zNTOvjZ2pqgfLbVTzzw9+AzTquIqt03n0lpOmxjTRW0gY4HTTZFwrrgIVe830mwtYIqqZ
	k8Nxy5P8fNoBSmZZSdHGidMH6hCBeGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Puqtj1n4xO6momR1+NGyVJ2loesQ7WnPW5GUvesu8=;
	b=LmdV69A+KtCqCqscvp//9CCKmiEAoMgcntcI9QHqo5jTzD5sr9RQ8qbcC5Z4A+CEnbuZkI
	1xYvJJbT2XvUkbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DFDD1393C;
	Wed, 24 Apr 2024 12:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7mO8HWn7KGaJbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:30:33 +0000
Date: Wed, 24 Apr 2024 14:30:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 14/15] nvme/{rc,016,017}: rename
 nvme_num_iter to NVME_NUM_ITER
Message-ID: <ljpi2xof7o6n43x5shi3expzvxs3jpryeddxe3ure7yzaud366@rfoom5xvdsjo>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-15-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-15-shinichiro.kawasaki@wdc.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8AC6966D87
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.01

On Wed, Apr 24, 2024 at 04:59:54PM +0900, Shin'ichiro Kawasaki wrote:
> To follow uppercase letter guide of environment variables, rename
> nvme_num_iter to NVME_NUM_ITER.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
