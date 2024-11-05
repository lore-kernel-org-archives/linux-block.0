Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8F18BC37
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790136; cv=none; b=J4SkSUSJDKuXy6SsfSSK5kM035aZqgtAcdzYcITr3DjKcvA4cE2zStLDOLwo6pIjmhwSWEjPuEsURsqxH4Mv6SOza4QsZyYAMbEJ8liFy7VWPkcBcbmHjLSmbO+JfL9zA5dWYcAAjDwqodXu25X2QQYS8DhYwxDYKFxqfuNqWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790136; c=relaxed/simple;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfbeDzzYtQoNOjWQsox3/znL09UoiBaZRKMkbBMd6JUYeRQH4ApAivRE9gqOsaJ2J2PDuWJQQ1QgSNoAHT0yHZO+Mtfk6A2sn7CMjaaR26mZSh3u5zgIkEYZ+0HTJmVbEg2PV1z5X7QqdM/TUsRKJ8muXUy2QHdxqNMGApnUjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=opbRgfzV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uYBfBKMv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=opbRgfzV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uYBfBKMv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="opbRgfzV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uYBfBKMv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="opbRgfzV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uYBfBKMv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4400321C6A;
	Tue,  5 Nov 2024 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730790132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=opbRgfzV6ucM6dwFefmfBBKyULd56MFAPu1ATr2KgEAYOV2+VMCqnjxtOlcZhpTJ2kT04k
	KEJLPtdZ6CydWlGSaWAzkvurkc1R5A0d9olGx/JVhzKArqzy2+9p4bBh1IgDDMFg0Gw+li
	o6WZpJL88bhU9SOvsfK5xOFN2ANfb9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730790132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=uYBfBKMvzrWodH8DdlC+K3//UFpp8Sc2CyeNngv3nGL7njClGh4XdE0zH7OT9MKZJxxLEL
	ZTiHlnM4pd7pANBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=opbRgfzV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uYBfBKMv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730790132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=opbRgfzV6ucM6dwFefmfBBKyULd56MFAPu1ATr2KgEAYOV2+VMCqnjxtOlcZhpTJ2kT04k
	KEJLPtdZ6CydWlGSaWAzkvurkc1R5A0d9olGx/JVhzKArqzy2+9p4bBh1IgDDMFg0Gw+li
	o6WZpJL88bhU9SOvsfK5xOFN2ANfb9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730790132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOEmQGtvtAi5sYm+dwO88HC7TGfFTmH0eIuXhHiviQ4=;
	b=uYBfBKMvzrWodH8DdlC+K3//UFpp8Sc2CyeNngv3nGL7njClGh4XdE0zH7OT9MKZJxxLEL
	ZTiHlnM4pd7pANBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BF8D1394A;
	Tue,  5 Nov 2024 07:02:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f+CIBfTCKWdKEgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 05 Nov 2024 07:02:12 +0000
Date: Tue, 5 Nov 2024 08:02:11 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kanie@linux.alibaba.com, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH] nvme: test nvmet-wq sysfs interface
Message-ID: <5d603860-33be-42a2-86c9-a10c224c813d@flourine.local>
References: <20241104192907.21358-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104192907.21358-1-kch@nvidia.com>
X-Rspamd-Queue-Id: 4400321C6A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Mon, Nov 04, 2024 at 11:29:07AM GMT, Chaitanya Kulkarni wrote:
> +# Test nvmet-wq cpumask sysfs attribute with NVMe-oF and fio workload

What do you want to test here? What's the objective? I don't see any
block layer related parts or do I miss something?
