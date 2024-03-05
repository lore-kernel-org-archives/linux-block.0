Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55895B5A1
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636925; cv=none; b=ZMVrDZnOeU3O+hzRNgbo55PsjNI/m7M4pxDoy9MpJ2O0t6is1HjllJ4l7TEG+iYdacyjEyiBowOH3iPmH6Q2k9W4HZtDnYWeh4kVDs/ZalLKEChe2yon2yUz5/u2UveI5hMHZycU2a4k6DChfe6w434fQjMX8+1myKVFhzNG2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636925; c=relaxed/simple;
	bh=gkD5k6kLV7j2wUchwpbJ1adHlnTAvHTUKoBHSGmz3pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWBLkpzwLeX40iADDN5x5sACRjZcZA8ToaHAN66FMa02I1uGKtRUbLhRi4Yx5Me9VkCZDCajTaBiJmx7aZ9CayZRftBWbBeBt3KYDBf4J1t4eTG0pT9XCJuVCZLXNa6D/+hNhmftjiIqnBLdW1vdMw7k9KskRWI5jAFyDSbJK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yRktqfpg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SMmC2/i8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yRktqfpg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SMmC2/i8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yRktqfpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SMmC2/i8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yRktqfpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SMmC2/i8"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 180136AD6B;
	Tue,  5 Mar 2024 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709636921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=yRktqfpgK1h45zxk5p2QiMYUPNgvGIFtbAQj2U1FXbMkhkjOGbbidK2ugRAJF4QSroTVZk
	OnE1zuqyHxmJNmWLqFDVxQLuxRzHq9xzSbeAJOmlsil5hbGnX51zCxYuatvRtL953h2iJB
	A8PiEnXvQJS/HanUWsXGrAnvUzs8Qsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709636921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=SMmC2/i8dDCmLj25Sit7+PHD3WFmzJS5XBmo6GE6jd0bFrG8DH50n8mrTV5+JLfV/Crifv
	RO3bbYvR4Z3ujfBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709636921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=yRktqfpgK1h45zxk5p2QiMYUPNgvGIFtbAQj2U1FXbMkhkjOGbbidK2ugRAJF4QSroTVZk
	OnE1zuqyHxmJNmWLqFDVxQLuxRzHq9xzSbeAJOmlsil5hbGnX51zCxYuatvRtL953h2iJB
	A8PiEnXvQJS/HanUWsXGrAnvUzs8Qsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709636921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=SMmC2/i8dDCmLj25Sit7+PHD3WFmzJS5XBmo6GE6jd0bFrG8DH50n8mrTV5+JLfV/Crifv
	RO3bbYvR4Z3ujfBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0146013466;
	Tue,  5 Mar 2024 11:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id o1rkOjj95mVLDQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 11:08:40 +0000
Date: Tue, 5 Mar 2024 12:08:40 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 2/2] nvme/048: add reconnect after ctrl key
 change
Message-ID: <3aeichb4fe6idz4zbdqunfp2kj72af64an6j3xvjdfka7fkx52@3shgtvvlaw4i>
References: <20240304161303.19681-1-dwagner@suse.de>
 <20240304161303.19681-3-dwagner@suse.de>
 <hidg7tztvsyak5kjlrvglwyd5kb4kaaqfwbztxcf7vzpmsv5rc@knbau5ucdigs>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hidg7tztvsyak5kjlrvglwyd5kb4kaaqfwbztxcf7vzpmsv5rc@knbau5ucdigs>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yRktqfpg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="SMmC2/i8"
X-Spamd-Result: default: False [-2.82 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.01)[87.25%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 180136AD6B
X-Spam-Level: 
X-Spam-Score: -2.82
X-Spam-Flag: NO

On Tue, Mar 05, 2024 at 09:38:41AM +0000, Shinichiro Kawasaki wrote:
> On Mar 04, 2024 / 17:13, Daniel Wagner wrote:
> > The re-authentication is a soft state, meaning unless the host has to
> > reconnect a key change on the target side is not observed. Extend the
> > current test with a forced reconnect after a key change. This
> > exercises the DNR handling code of the host.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> This looks a good improvement of the test case. I have two comments:
> 
> - The commit title says nvme/048, but it should be nvme/045.

Indeed :)

> - The helper functions nvmf_wait_for_state() and set_nvmet_attr_qid_max()
>   are exactly same as those in nvme/048, aren't they?
>   Probably, it's the better to move them to nvme/rc, as a preparation patch.

I forgot that we already had those two helpers. Sure, will do.
