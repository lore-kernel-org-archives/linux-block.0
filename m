Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE17E574
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623258; cv=none; b=IiiwF9SVHO5bD7982YP1fXWwyFS2QOkMIQXCtEtzuDYTwi749vgSUqgi998NvlM94JGB+jupVn35TKfwajyClF6BFYPa9bDUA+5hX0ocR27ilG4BbFePO5sleAhJxhUvPDItHduPrITg+Vo0I5eiovFL86kppScKQxZ0o1LF87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623258; c=relaxed/simple;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUWtZugZ0pMQmRcTEi2Xpuo1MWwSOCzW5Ayp5GD0+S3ht3JqUy3snMkd6ONADg21btaUoEkoG3LNNu/CMhp7vUCPlv7AU7e/rQ1XhIMqs6HzPoIaa4LBPNEdOvGajCK8oU+V0wSuFcKnpzMYFcH+uSWDNwBXX73Q1yaqcCoyarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=odRIbWln; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTlBiOMJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=odRIbWln; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTlBiOMJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="odRIbWln";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTlBiOMJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="odRIbWln";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTlBiOMJ"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 590EF6793D;
	Tue,  5 Mar 2024 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709623254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=odRIbWln/YWyT6IC+esj97wAnzsxP2WPxrg631DqcVHs4fFA6YB6LgqcUjp9XSNzM/fulx
	XxWNUyLy0dHY3hEVhy5fGr+QBEmm3hL8aaI+sGXazfKvLdCQV2EWFV6TWLELOsTE6s0zBK
	ovm3acAY/E9Qe6yH3eP+XHxYIZJze2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709623254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=hTlBiOMJ0qMlvicOHLJ+8hev66oJ4UbDWVL1Ah3evEwZ80VjGC1cOlapz/4G6KwJpEu/5o
	ZHaVXtHGi5G/JvDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709623254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=odRIbWln/YWyT6IC+esj97wAnzsxP2WPxrg631DqcVHs4fFA6YB6LgqcUjp9XSNzM/fulx
	XxWNUyLy0dHY3hEVhy5fGr+QBEmm3hL8aaI+sGXazfKvLdCQV2EWFV6TWLELOsTE6s0zBK
	ovm3acAY/E9Qe6yH3eP+XHxYIZJze2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709623254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=hTlBiOMJ0qMlvicOHLJ+8hev66oJ4UbDWVL1Ah3evEwZ80VjGC1cOlapz/4G6KwJpEu/5o
	ZHaVXtHGi5G/JvDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 37F8A13466;
	Tue,  5 Mar 2024 07:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qx/6DNbH5mW+SQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 07:20:54 +0000
Date: Tue, 5 Mar 2024 08:20:54 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Re: [PATCH blktests v2 0/2] make nvme/048 checks more robust
Message-ID: <24jc4uupde6hl75agcdqbjhjeivqmzx2ejohsx3luaearmlasr@ayd64zsnee7n>
References: <20240304134826.31965-1-dwagner@suse.de>
 <6ijuychwshzssoorymvko2b2aycmu5x5oc6zi6j2yzubsegkac@qlg4hs7ii7kp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ijuychwshzssoorymvko2b2aycmu5x5oc6zi6j2yzubsegkac@qlg4hs7ii7kp>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=odRIbWln;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hTlBiOMJ
X-Spamd-Result: default: False [-1.09 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
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
	 BAYES_HAM(-1.28)[89.93%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 590EF6793D
X-Spam-Level: 
X-Spam-Score: -1.09
X-Spam-Flag: NO

On Tue, Mar 05, 2024 at 01:29:18AM +0000, Shinichiro Kawasaki wrote:
> Of note is that I removed the left if block in nvmf_check_queue_count(), which I
> believe unnecessary.

This was also what I did. But somehow I managed to send out the wrong
version. Thanks for fixing it!
