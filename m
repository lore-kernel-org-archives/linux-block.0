Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDF3A7F55
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486340; cv=none; b=d+p9ghR8iJViUFIvP8UwifZCaWqprZTdsOe57gh8nyPgSwD+1/ALVpPzctKt55SLkFToXa4lW0+YZVk1uAkHlK64AR2/D63MQa+Mi4FcqiL64Q14xg/gvKuJz2KzhxATdueLCTGYg9I+iyPz72TzCcdv2Yc3xzM2XpMPSI46khQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486340; c=relaxed/simple;
	bh=V0QzLzo5VptIU+9iagsNj5XyIoAFzPDOVnW5LmdhDYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYXVjmVjd6PxYjQafDHwsUjRkJ4lvaJgbXG5OdMfxZSxUWdTNa5mcz8nlBYEtH2h/2ZC/G2VEsuGHIk6ZItGQAtWfDnw0hFr9cF9I91+BQD9epBDpvVhJIeyu/vQiFwZSbssC25jTzVNJmZwqZwN0YMdzr3GpF9iSLAVHeWT9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I8syAKHp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mtTh+RFl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I8syAKHp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mtTh+RFl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I8syAKHp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mtTh+RFl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I8syAKHp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mtTh+RFl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44FC161637;
	Mon, 11 May 2026 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778486329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7N+0gD7ABurVoXOgnVj3I44DXkfZj5tHlnBBguScLsg=;
	b=I8syAKHpUEfOkIjha27Mc8sVB0+LonQJu0ZzWPxlXzTQF58wYTJv4+NVLekQ9rU7CGBY6a
	zhm6thygrD93fsaDBhhI07zCOC8ftHMTnETeb5VAGVQImRGx55hurfL9/tKjgohqpRRlP2
	owspR95TUQVHPME3E6HjGG6/LZcScW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778486329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7N+0gD7ABurVoXOgnVj3I44DXkfZj5tHlnBBguScLsg=;
	b=mtTh+RFlsKVEdSP55T4/WJ/SO+8SUCdS8lI20uTFk5j/qIcywcYfzYuG2+JB+0I9SQlt6v
	5ssdnYC8i6n8H7AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I8syAKHp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mtTh+RFl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778486329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7N+0gD7ABurVoXOgnVj3I44DXkfZj5tHlnBBguScLsg=;
	b=I8syAKHpUEfOkIjha27Mc8sVB0+LonQJu0ZzWPxlXzTQF58wYTJv4+NVLekQ9rU7CGBY6a
	zhm6thygrD93fsaDBhhI07zCOC8ftHMTnETeb5VAGVQImRGx55hurfL9/tKjgohqpRRlP2
	owspR95TUQVHPME3E6HjGG6/LZcScW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778486329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7N+0gD7ABurVoXOgnVj3I44DXkfZj5tHlnBBguScLsg=;
	b=mtTh+RFlsKVEdSP55T4/WJ/SO+8SUCdS8lI20uTFk5j/qIcywcYfzYuG2+JB+0I9SQlt6v
	5ssdnYC8i6n8H7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32898593A9;
	Mon, 11 May 2026 07:58:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QeCzCjmMAWoiUgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 May 2026 07:58:49 +0000
Date: Mon, 11 May 2026 09:58:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] blktrace/001: Skip test when kernel lockdown is
 enabled
Message-ID: <953e383a-b9ce-4ef6-a471-5d91aa7eda88@flourine.local>
References: <20260424141143.64528-1-disgoel@linux.ibm.com>
 <afIGq_uV-l9_98Px@shinmob>
 <f3617b18-526e-4006-a692-b704925de24b@linux.ibm.com>
 <440d1e82-e54f-4709-829b-24d8fb16246e@flourine.local>
 <1621bb15-b425-42d8-9ced-b3886dce1060@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621bb15-b425-42d8-9ced-b3886dce1060@linux.ibm.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,flourine.local:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 44FC161637
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

Hi Disha,

On Mon, May 11, 2026 at 01:16:03PM +0530, Disha Goel wrote:
> Thank you for pointing me to the SUSE lockdown patches. After analysing
> them, I found that the second patch (lockdown-fix-kernel-lockdown-
> enforcement-issue-when-secure.patch) is causing the issue.
> 
> This patch fixes bsc#1237521 by directly calling lockdown hooks, but it
> appears to be too restrictive - it blocks blktrace from accessing
> debugfs even though upstream kernel 7.1+ allows this with lockdown
> enabled.

Right, so it's a downstream problem as expected.

> The patch works around a timing issue but has the side effect of
> blocking legitimate debugging tools. Is this intentional, or should
> debugging tools like blktrace be allowed even with lockdown enabled?

I am not really involved into this part of our downstream kernel and
don't know why these patches didn't make it upstream :)

Would you mind to you create a SUSE bugzilla issue and we can figure out
a solution there?

Thanks a lot!
Daniel
