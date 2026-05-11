Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E383A7F66
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485916; cv=none; b=L4RdURP9aLyD4onsZ8EEyxfIqL5rln6qS7Qc7APYT4xtByyh025Nh4wRq356k/OIZvxO1tXBVMrjX08YRI2HXjuY+jPobsFcytVkqsaQFGISH9bv5uRYMe1QhTY8kbjE1reRH0HLBVunEFsXRFxMDiP3BoTqaEZuZMin95XrC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485916; c=relaxed/simple;
	bh=1lBWesgQsCE++eGjjXDMVnouzbmU4HpHsV7ssGhHtUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVmxTJpnyKUytG7yar9xJzXLdWGSMP1JT78KVMpzKls6tRq7IDVyGwNkPRMG8zvZKlREWCfEKLKSnNV7ic+iRpisC2xpBESAj7Ht7ldzT77Ga1IKMQ3PeL50PbuWgeByAF1V1rHJ79MYW1Q3JgWJC4lLAw5oAHGeXHzKZ2t2pNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wVO1hkob; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6sJzvHcO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wVO1hkob; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6sJzvHcO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wVO1hkob";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6sJzvHcO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wVO1hkob";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6sJzvHcO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 249FA6AF8E;
	Mon, 11 May 2026 07:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778485901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gft8k3+acIOU1k6omu/63XFWdq86DjLAVp9FuP7QGac=;
	b=wVO1hkobe6tBFrheTCv3NAvCxaBUesNaLh0ILt1D1uVi8YMPNEGLLFpKEKHlCRb5KE+pDw
	B9o2Ko3S4HzcMkAYG2eGYAM1U9+TaPgS1pMZyDgxXFWSBVKAyxSvENCu3XfY1yZVwiakMm
	uP/HrU6zzysxh9akJWZ93X/WPAp4e5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778485901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gft8k3+acIOU1k6omu/63XFWdq86DjLAVp9FuP7QGac=;
	b=6sJzvHcOVG1in0MTLg7Hh7Xl9nk3N1aTM2KarJmvJ5Un6lgE4TrycOEEl9C0pMQ7L6Lg98
	PabrUZU4CM11AgBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wVO1hkob;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6sJzvHcO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778485901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gft8k3+acIOU1k6omu/63XFWdq86DjLAVp9FuP7QGac=;
	b=wVO1hkobe6tBFrheTCv3NAvCxaBUesNaLh0ILt1D1uVi8YMPNEGLLFpKEKHlCRb5KE+pDw
	B9o2Ko3S4HzcMkAYG2eGYAM1U9+TaPgS1pMZyDgxXFWSBVKAyxSvENCu3XfY1yZVwiakMm
	uP/HrU6zzysxh9akJWZ93X/WPAp4e5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778485901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gft8k3+acIOU1k6omu/63XFWdq86DjLAVp9FuP7QGac=;
	b=6sJzvHcOVG1in0MTLg7Hh7Xl9nk3N1aTM2KarJmvJ5Un6lgE4TrycOEEl9C0pMQ7L6Lg98
	PabrUZU4CM11AgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1164D593A3;
	Mon, 11 May 2026 07:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id flGVAo2KAWqtSgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 May 2026 07:51:41 +0000
Date: Mon, 11 May 2026 09:51:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>, g@fluorine
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v3] nvme/068: add a test for multipath delayed
 removal
Message-ID: <deb7ce22-7369-4685-8009-b9358e0f5a79@flourine.local>
References: <20260430084635.2438048-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430084635.2438048-1-john.g.garry@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,nvidia.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 249FA6AF8E
X-Spam-Level: 

Hi John,

On Thu, Apr 30, 2026 at 08:46:35AM +0000, John Garry wrote:
> For NVMe multipath, the delayed removal feature allows the multipath
> gendisk to remain present when all available paths are gone. The purpose of
> this feature is to ensure that we keep the gendisk for intermittent path
> failures.
> 
> The delayed removal works on a timer - when all paths are gone, a timer is
> kicked off; once the timer expires and no paths have returned, the gendisk
> is removed.
> 
> When all paths are gone and the gendisk is still present, all reads and
> writes to the disk are queued. If a path returns before the timer
> expiration, the timer canceled and the queued IO is submitted;
> otherwise they fail when the timer expires.
> 
> This testcase covers two scenarios in separate parts:
> a. test that IOs submitted after all paths are removed (and do not return)
>    fail
> b. test that IOs submitted between all paths removed and a path
>    returning succeed
> 
> During the period of the timer being active, it must be ensured that the
> nvme-core module is not removed. Otherwise the driver may not be present
> to handle the timeout expiry. The kernel ensures this by taking a
> reference to the module. Ideally, we would try to remove the module during
> this test to prove that this is not possible (and the kernel behaves as
> expected), but that module will probably not be removable anyway due to
> many references. To test this feature, check that the refcount of the
> nvme-core module is incremented when the delayed timer is active.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> 
> @Chaitanya, @Nilay, Please check changes since RB tag granted
> 
> Differences to v2:
> - Stop using sleeps so often (Daniel)

Thanks! Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
