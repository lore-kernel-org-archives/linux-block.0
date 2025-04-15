Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A7210F49
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734795; cv=none; b=lIYQgn4/w8+yUMAsD0rEv/lw6Bth/KHmBs/IzvdMJy+AE4XCqqPBUuxIkcFyyw9raB1hQMX5DDUM9Jgu56tupJdPLrxuN5rzTbWGBtPNk3ASJw1e8S4ZaU/mHxjmX5q8TCuVuxTEqu6NGFEUcPYJ/FIM3MNuWl1G+B7zuFZxIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734795; c=relaxed/simple;
	bh=NcKZdTFgPpAHYhGg6icLRMkDea4aMWpVJTFpfQLtglw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAvAwbewF0RfJoh0QeFJGRFrBfWxbwjiz8HLlxA/Rq+AwMoHCqF16y7b+AIbzvduYisRMkvQlTcMdCjF2bkgdxd/fmgTB3QZuBPtKRhWaFgKTBAEQyypLh8Z3LDckf+FEohXir7J7TBQKRD/Rsy+NXPW/JqZcPkfyzfcWi5udks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pN8pQGqt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtg/nwUi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pN8pQGqt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtg/nwUi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pN8pQGqt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtg/nwUi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pN8pQGqt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtg/nwUi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DB252119B;
	Tue, 15 Apr 2025 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744734792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vyQVkPMPIFV0Bio9cYTBDXUryYhBLLO3CPZt9suiTo=;
	b=pN8pQGqti/nDIZNtUA6L8XbiSeliWpDMicYH+APatsRTSxmOQfWtFCCB5ekCBe5K/EiZmR
	phQ6JLnPtme+qP7ymYe0e7W454XM6Fo0YBESL+vUJsZ4vBFcy1Riy9rZ872hySwF63RvCI
	xhqQ7pzW05z9SO9XUIXZjvo0qFaI4RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744734792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vyQVkPMPIFV0Bio9cYTBDXUryYhBLLO3CPZt9suiTo=;
	b=dtg/nwUisXdJxhEmgI1AVlEGYK93r0NVQ/k+1E62FSLW6M+koTe0nQ9WIGMjOTKw4MdSi8
	K/LpplUL3xBKWMBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pN8pQGqt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dtg/nwUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744734792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vyQVkPMPIFV0Bio9cYTBDXUryYhBLLO3CPZt9suiTo=;
	b=pN8pQGqti/nDIZNtUA6L8XbiSeliWpDMicYH+APatsRTSxmOQfWtFCCB5ekCBe5K/EiZmR
	phQ6JLnPtme+qP7ymYe0e7W454XM6Fo0YBESL+vUJsZ4vBFcy1Riy9rZ872hySwF63RvCI
	xhqQ7pzW05z9SO9XUIXZjvo0qFaI4RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744734792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vyQVkPMPIFV0Bio9cYTBDXUryYhBLLO3CPZt9suiTo=;
	b=dtg/nwUisXdJxhEmgI1AVlEGYK93r0NVQ/k+1E62FSLW6M+koTe0nQ9WIGMjOTKw4MdSi8
	K/LpplUL3xBKWMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72BF2137A5;
	Tue, 15 Apr 2025 16:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LzsCHEiK/mekYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 16:33:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A3B0A0947; Tue, 15 Apr 2025 18:33:08 +0200 (CEST)
Date: Tue, 15 Apr 2025 18:33:08 +0200
From: Jan Kara <jack@suse.cz>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Martijn Coenen <maco@android.com>, Alyssa Ross <hi@alyssa.is>, Christoph Hellwig <hch@lst.de>, 
	Greg KH <greg@kroah.com>, John Ogness <john.ogness@linutronix.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] loop: properly send KOBJ_CHANGED uevent for disk
 device
Message-ID: <fzi7oikkjqedbhfi57c2rc6z3icvwra3uoqk5pgz7rmiqczfcj@w33zdcy6d3ax>
References: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
 <tbypgsknfpqyx3xbrpz7jlpthlybcdxhr7b3oz4vq5u6izwdqp@q3wo6zpqicp7>
 <20250415130006-9a17e592-fc7a-4150-bc7c-e0c6d8da4b72@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415130006-9a17e592-fc7a-4150-bc7c-e0c6d8da4b72@linutronix.de>
X-Rspamd-Queue-Id: 7DB252119B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 13:07:48, Thomas Weiﬂschuh wrote:
> On Tue, Apr 15, 2025 at 12:24:55PM +0200, Jan Kara wrote:
> > On Tue 15-04-25 10:51:47, Thomas Weiﬂschuh wrote:
> > > The original commit message and the wording "uncork" in the code comment
> > > indicate that it is expected that the suppressed event instances are
> > > automatically sent after unsuppressing.
> > > This is not the case, instead they are discarded.
> > > In effect this means that no "changed" events are emitted on the device
> > > itself by default.
> > > While each discovered partition does trigger a changed event on the
> > > device, devices without partitions don't have any event emitted.
> > > 
> > > This makes udev miss the device creation and prompted workarounds in
> > > userspace. See the linked util-linux/losetup bug.
> > > 
> > > Explicitly emit the events and drop the confusingly worded comments.
> > > 
> > > Link: https://github.com/util-linux/util-linux/issues/2434
> > > Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > Thanks for the fix! When reading the code, I'm a bit curious: What is
> > actually generating events for partitions with loop_change_fd() call?
> > Because there loop_reread_partitions() still happens with uevents
> > supressed... I suspect event supressing there should be shorter.
> 
> Makes sense.
> For loop_configure() this was fixed in
> commit bb430b694226 ("loop: LOOP_CONFIGURE: send uevents for partitions").
> I guess we need the same for loop_change_fd().
> 
> I'm not entirely sure on how to order the commits or if they should be
> folded together.
> My current preference is to first have the current patch under discussion and
> then the fix for loop_change_fd().

Yeah, whatever. I was asking mainly to make sure my understanding of the
current code is correct :). With this one feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
