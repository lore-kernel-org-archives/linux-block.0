Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A878200BF
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294313; cv=none; b=YRSoOapmESEAN1fk2U5NjqrC65BtejyLSvEvmvkBg+QYLenJgdDgNqWaC67jOg4crDRzqk7EUYARB6d5VK52QPfmc73wlBmtD77a0QxSZ7Mv7S6tWylu2TJJUyabms9KYTxbZBwA5xsxMRoJTAIEd21kCsXtko0tK1jfAt5qQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294313; c=relaxed/simple;
	bh=HAkiF6Yl4Vv1/N8TGXnjK0Xz6vqWAH6Vy5zIPjWTjbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgl4+mx+AUn8aHE6eKJ8zSnukxFCcemEwx+vD2xdnlabEqVdU0z4PTQXTA1q167VL3U6+FH8oeN9hbxRG8QntweP/yKg99Dyv4ZIQw6I02nuIq3A91ZpTGocs0v/Fk/F1Nmid3ZskU6uE9pFBODADdKvOejkIiywlwze/CQvFdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O/x1RJgJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=giheMYgM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O/x1RJgJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=giheMYgM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O/x1RJgJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="giheMYgM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O/x1RJgJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="giheMYgM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E8E21FBAF;
	Wed,  7 Feb 2024 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707294310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5Y2LhTQoLbscu8wbWKjqLbggHKRAE/YNfdB2oRPj94=;
	b=O/x1RJgJiFxOZ5iSk02CS3LqtZl5H5WsJKGb8Fa5eH2OeHYxNd6ecBqNuIsrNy6Uk6X9/T
	5OSwmQzS5UOaIfhnMTk2UP1DZkzWpvGmOCokeccxhnP71jprzboZ0h0ORHWC7jpBE2Y7ca
	BZI2xw7g5WLfkdTcTesYKPMn6YKc0ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707294310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5Y2LhTQoLbscu8wbWKjqLbggHKRAE/YNfdB2oRPj94=;
	b=giheMYgM2BXFIu+DaI7x7KfaXq2kVvexeQVZIgkwa+uDBDwPULKfbZ7teRSrhrDsws1HFJ
	rtCAPr6okhYiZmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707294310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5Y2LhTQoLbscu8wbWKjqLbggHKRAE/YNfdB2oRPj94=;
	b=O/x1RJgJiFxOZ5iSk02CS3LqtZl5H5WsJKGb8Fa5eH2OeHYxNd6ecBqNuIsrNy6Uk6X9/T
	5OSwmQzS5UOaIfhnMTk2UP1DZkzWpvGmOCokeccxhnP71jprzboZ0h0ORHWC7jpBE2Y7ca
	BZI2xw7g5WLfkdTcTesYKPMn6YKc0ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707294310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5Y2LhTQoLbscu8wbWKjqLbggHKRAE/YNfdB2oRPj94=;
	b=giheMYgM2BXFIu+DaI7x7KfaXq2kVvexeQVZIgkwa+uDBDwPULKfbZ7teRSrhrDsws1HFJ
	rtCAPr6okhYiZmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59C3013931;
	Wed,  7 Feb 2024 08:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xxVyFGY+w2XYPgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 07 Feb 2024 08:25:10 +0000
Date: Wed, 7 Feb 2024 09:25:09 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v1 4/5] nvme/rc: do not issue errors when
 disconnecting when using fc transport
Message-ID: <sboifwxqhu5baaw3v2npimmi3qff6zttpkrcfojjku46rpwfjw@dbdxebaedgvc>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-5-dwagner@suse.de>
 <ebaf06b3-f667-4b70-9751-5c2597c7fcd3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebaf06b3-f667-4b70-9751-5c2597c7fcd3@nvidia.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O/x1RJgJ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=giheMYgM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	 BAYES_HAM(-1.20)[89.16%]
X-Spam-Score: -2.21
X-Rspamd-Queue-Id: 6E8E21FBAF
X-Spam-Flag: NO

On Tue, Feb 06, 2024 at 11:09:56PM +0000, Chaitanya Kulkarni wrote:
> > -			_nvme_disconnect_ctrl "${dev}"
> > +			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
> 
> will this only happen for discovery controller or non-discovery
> controllers also ?

The global cleanup code disconnects all controllers. Another option
would be that we ditch the global cleanup code because every test is
already removing all resources it creates. This would also make blktests
play a bit nicer. But this is how it is currently done for all
transport.
