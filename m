Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108A8BEF
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395580; cv=none; b=kaRjWfHmx/2WmgRMeieW4OewN3u+chAs9AJwZlH83GoskOShTNQgve38A9d/Gxt4qUJlkwgr0YKEBQmFATyuS9xBTXfD0Fw1P1cR0dSInNKO2roZZ/o8AeIrfSlJSDT1nB3RWUdrfC2JQbo92LBg+ie+uzRlkbpmLDnVRWfa/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395580; c=relaxed/simple;
	bh=ZYbmtwJAEMsyP9L7lHP7sGnTKVk0zfaEIRm+M+/m33U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQw31y0NiYHkoEAjPSVDap6Ti361rD2i/65Sa0oSurDeca0kCUBQ4HMOGIbns/G5U5Sw1pRuWx2eBXeIn5s/pi7Zg+qH2eC8gJwWH5F0ACVhjmEk1fZktS4B1c3DCZJNRzYSwOHsh966y7x3AhABB9Xfli5sJYIRs+xawy9tKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wC0whvHg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v/huvvyF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wC0whvHg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v/huvvyF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wC0whvHg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v/huvvyF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wC0whvHg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v/huvvyF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D8C2202D4;
	Fri, 23 Aug 2024 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=wC0whvHgA85IyszC1Axtzu+HSOOnSNuA6uPPYCFFNqWVRDH8yfv3LbySgkLfsFnLvUsS0/
	U0PSxezBrc/MapGzsDCaA052K/Y3wP1o63ttIWkKPYTFbVqoTJMJUcjc+qBKxVdDazi7BC
	ZNTjPFwzdodcEm7wa+gXT4MnxclGyE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=v/huvvyFzMVL0csnraERH8JEnSGzCtG/KJK+KhRN7pzqokt0lLK963KAAgiLEin5aI+TrM
	h0+PwzoD8YcUW8DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wC0whvHg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="v/huvvyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=wC0whvHgA85IyszC1Axtzu+HSOOnSNuA6uPPYCFFNqWVRDH8yfv3LbySgkLfsFnLvUsS0/
	U0PSxezBrc/MapGzsDCaA052K/Y3wP1o63ttIWkKPYTFbVqoTJMJUcjc+qBKxVdDazi7BC
	ZNTjPFwzdodcEm7wa+gXT4MnxclGyE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnTMPnFUmVk5sJ6YFirqIg/tDNnRDD7NtEPmuaWoY0=;
	b=v/huvvyFzMVL0csnraERH8JEnSGzCtG/KJK+KhRN7pzqokt0lLK963KAAgiLEin5aI+TrM
	h0+PwzoD8YcUW8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA011333E;
	Fri, 23 Aug 2024 06:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xv6ZBDgwyGZ+awAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 06:46:16 +0000
Date: Fri, 23 Aug 2024 08:46:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 2/3] blktests: nvme/032: skip on non-PCI devices
Message-ID: <fc4b1c7d-e948-49f7-880e-7e591566c79d@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
 <20240822193814.106111-2-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822193814.106111-2-mwilck@suse.com>
X-Rspamd-Queue-Id: 4D8C2202D4
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Aug 22, 2024 at 09:38:13PM GMT, Martin Wilck wrote:
> nvme/032 is a PCI-specific test.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
