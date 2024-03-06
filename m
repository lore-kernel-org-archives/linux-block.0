Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8405C5F8
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717799; cv=none; b=GIhcKmzFlC8cQoIQ3V5+vmCuoeqGzli+QIpbP9U9svHktQfz4Qm/ymgVDA1eD/yf1VuflF1jfYYSocy3IfirK8ZoW2KAPW5NaIwLe3UimLxR+mCDNCd5AajjVMyRwugBNSsniKgpweO8aLR6ri6l5oqrKmkOU9WCKtVWM5aPoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717799; c=relaxed/simple;
	bh=BUMfKz6JkYPupyr18XLzLsqIRrGfRz5u/CJu0ahUT14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM5aOGoc0/1nVn1qwE5g0Twj41h7zrKlV3ILeU5gCcRnusiaJeiDACKOSjOWyLj86G5i4CKPQIt60iWhu6fnA1q8+WH6BWzO9dodCZt79QH6XKHk5D25YWwpbsuvYxXj4ejtgLKQax1ry67lda8EqTB00dtGk4U/b152ksti93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cYwlMk8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jatOgBnI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cYwlMk8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jatOgBnI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cYwlMk8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jatOgBnI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cYwlMk8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jatOgBnI"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FDC73EF5B;
	Wed,  6 Mar 2024 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709717790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLms4auAU45PX1X3XPBSWFef66gtdpKqJoNdZubfYDE=;
	b=cYwlMk8xsl1gu327VtdWWsgXsr05QBBdYvYn6j9gxqSWqmgM+8+RAXEfjM6Gjz4c/6IvYG
	c5tA8Zvp8rj2Y7gT+xYRcBrzMvj+WZOaBnxRAq+4dV7zmRqkTKEjGxoCrXUnlRIxZCztR+
	7mvjZ+J9x+lf2dShiubKB1iWP4MP2DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709717790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLms4auAU45PX1X3XPBSWFef66gtdpKqJoNdZubfYDE=;
	b=jatOgBnI7zimlt9WI27NEmicsiL/2FdwOEOniFwaHClw4yCP0PLItQPNs+xMd2WbNT31qb
	pz6rMgX9Avo+A6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709717790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLms4auAU45PX1X3XPBSWFef66gtdpKqJoNdZubfYDE=;
	b=cYwlMk8xsl1gu327VtdWWsgXsr05QBBdYvYn6j9gxqSWqmgM+8+RAXEfjM6Gjz4c/6IvYG
	c5tA8Zvp8rj2Y7gT+xYRcBrzMvj+WZOaBnxRAq+4dV7zmRqkTKEjGxoCrXUnlRIxZCztR+
	7mvjZ+J9x+lf2dShiubKB1iWP4MP2DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709717790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLms4auAU45PX1X3XPBSWFef66gtdpKqJoNdZubfYDE=;
	b=jatOgBnI7zimlt9WI27NEmicsiL/2FdwOEOniFwaHClw4yCP0PLItQPNs+xMd2WbNT31qb
	pz6rMgX9Avo+A6Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DEEF13A79;
	Wed,  6 Mar 2024 09:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tVpkGR456GUcJwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 06 Mar 2024 09:36:30 +0000
Date: Wed, 6 Mar 2024 10:36:29 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with
 invalid key
Message-ID: <aaak4yvzeewwhaepcrqk35et6qxkicg3jxvwijavbujisse2h4@36dsv5gl6id4>
References: <20240304161303.19681-1-dwagner@suse.de>
 <2ya2o6s6lyiezbjoqbr33oiae2l65e2nrc75g3c47maisbifyv@4kpdmolhkiwx>
 <p5xkwz6i2lfy2a65pbpq3en6wh57y75qcoz3y3eio3ze5b7cm3@zgfn5so4yuig>
 <bax2kpeovgvf63rrtycsgpbi7wmvjhpmcbfcpoznldkowczom4@czjddqccdsba>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bax2kpeovgvf63rrtycsgpbi7wmvjhpmcbfcpoznldkowczom4@czjddqccdsba>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cYwlMk8x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jatOgBnI
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.01
X-Rspamd-Queue-Id: 7FDC73EF5B
X-Spam-Flag: NO

On Wed, Mar 06, 2024 at 08:44:48AM +0000, Shinichiro Kawasaki wrote:
 > > sudo ./check nvme/045
> > > nvme/045 (Test re-authentication)                            [failed]
> > >     runtime  8.069s  ...  7.639s
> > >     --- tests/nvme/045.out      2024-03-05 18:09:07.267668493 +0900
> > >     +++ /home/shin/Blktests/blktests/results/nodev/nvme/045.out.bad     2024-03-05 18:10:07.735494384 +0900
> > >     @@ -9,5 +9,6 @@
> > >      Change hash to hmac(sha512)
> > >      Re-authenticate with changed hash
> > >      Renew host key on the controller and force reconnect
> > >     -disconnected 0 controller(s)
> > >     +controller "nvme1" not deleted within 5 seconds
> > >     +disconnected 1 controller(s)
> > >      Test complete
> > 
> > That means the host either successfully reconnected or never
> > disconnected. We have another test case just for the disconnect test
> > (number of queue changes), so if this test passes, it must be the
> > former... Shouldn't really happen, this would mean the auth code has bug.
> 
> The test case nvme/048 passes, so this looks a bug.

I'll try to recreate it.

> > If you have these patches applied, the test should pass. But we might
> > have still some more stuff to unify between the transports. The nvme/045
> > test passes in my setup. Though I have seen runs which were hang for
> > some reason. Haven't figured out yet what's happening there. But I
> > haven't seen failures.
> 
> Still with the fix of the double-free, I observe the nvme/045 failure for rdma,
> tcp and fc transports. I wonder where the difference between your system and
> mine comes from.
> 
> FYI, here I share the kernel messages for rdma transport. It shows that
> nvme_rdma_reconnect_or_remove() was called repeatedly and it tried to reconnect.
> The status argument is -111 or 880, so I think the recon flag is always true
> and no effect. I'm interested in the status values in your environment.

Do you have these patches applied:

https://lore.kernel.org/linux-nvme/20240305080005.3638-1-dwagner@suse.de/

?

> [   59.117607] run blktests nvme/045 at 2024-03-06 17:05:55
> [   59.198629] (null): rxe_set_mtu: Set mtu to 1024
> [   59.211185] PCLMULQDQ-NI instructions are not detected.
> [   59.362952] infiniband ens3_rxe: set active
> [   59.363765] infiniband ens3_rxe: added ens3
> [   59.540499] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [   59.560541] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
> [   59.688866] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
> [   59.701114] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
> [   59.702195] nvme nvme1: qid 0: controller authenticated
> [   59.703310] nvme nvme1: qid 0: authenticated
> [   59.707478] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> [   59.709883] nvme nvme1: creating 4 I/O queues.
> [   59.745087] nvme nvme1: mapped 4/0/0 default/read/poll queues.
> [   59.786869] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [   59.999761] nvme nvme1: re-authenticating controller
> [   60.010902] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
> [   60.011640] nvme nvme1: qid 0: controller authenticated
> [   60.025652] nvme nvme1: re-authenticating controller
> [   60.035349] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
> [   60.036375] nvme nvme1: qid 0: controller authenticated
> [   60.050449] nvme nvme1: re-authenticating controller
> [   60.060757] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
> [   60.061460] nvme nvme1: qid 0: controller authenticated
> [   62.662430] nvme nvme1: re-authenticating controller
> [   62.859510] nvme nvme1: qid 0: authenticated with hash hmac(sha512) dhgroup ffdhe8192
> [   62.860502] nvme nvme1: qid 0: controller authenticated
> [   63.029182] nvme nvme1: re-authenticating controller
> [   63.192844] nvme nvme1: qid 0: authenticated with hash hmac(sha512) dhgroup ffdhe8192
> [   63.193900] nvme nvme1: qid 0: controller authenticated
> [   63.608561] nvme nvme1: starting error recovery
> [   63.653699] nvme nvme1: Reconnecting in 1 seconds...
> [   64.712627] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
> [   64.868896] nvmet: ctrl 1 qid 0 host response mismatch
> [   64.870065] nvmet: ctrl 1 qid 0 failure1 (1)
> [   64.871152] nvmet: ctrl 1 fatal error occurred!
> [   64.871519] nvme nvme1: qid 0: authentication failed
> [   64.874330] nvme nvme1: failed to connect queue: 0 ret=-111
> [   64.878612] nvme nvme1: Failed reconnect attempt 1
> [   64.880472] nvme nvme1: Reconnecting in 1 seconds...

This looks like the DNR bit is not considered in the reconnect_or_delete
function.
