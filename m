Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CC8287A
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712484; cv=none; b=WN5IWvJHVYfQ+QPrsg4Wx6AgzGqeLVWo19WvP5SYUYhyNKoP5i05dVCsHMEsu35EvLQKgfx9wKjZgtzCBe5RGoaPqwBic2pPFIVachfbjvAucPzAQmWIxUt68s1RGwYtjkYopajdspb1GLEKiIYeX0XiQ5Gw9AU0R17unn5CWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712484; c=relaxed/simple;
	bh=f6yyGH1WoHArzvC9xai4G8OYm8/8U5+icJbU7uXjNEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2vXL1j/IWCtuc/Il8vHmL6JVVc19nioPttfOkY9cGXfIzmL0GKUCwlW9knkuTjdnZGwTUWQ922AzqjoUT4lJoW4zd8ud9qnJBq0wyIHbtzep0NCCjaiUpd1/3zyPasrCL+9Pelj/1GMtUmwf2ntIZPvhj6/cloLQnsuRa1Lihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=egvH5lum; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H9jueoTr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=egvH5lum; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H9jueoTr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="egvH5lum";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H9jueoTr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="egvH5lum";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H9jueoTr"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6741FB87;
	Wed, 31 Jan 2024 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706712480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=egvH5lumvyz/EZrnAIc2c7g10yN4UxRvV/PGcwKqGuojwTVOgb2xhttra+7xVvq/OqcyRK
	20x3/M8mPMbP9WQGEbx35Kulbq/qXAQJal9jF3QAX6WByWQd8YF8U0SwJYbUvqOMzLnpVK
	WS0dpAVf3QPKP13FnXXzis/Z7raDevo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706712480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=H9jueoTrzcaPLPuT+a1O2/kKn4UT6jZ1/Pqb5NACW27CiPKeu1S5aajo6fQllHhHwmasO5
	6M63d5uvEBdj8kDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706712480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=egvH5lumvyz/EZrnAIc2c7g10yN4UxRvV/PGcwKqGuojwTVOgb2xhttra+7xVvq/OqcyRK
	20x3/M8mPMbP9WQGEbx35Kulbq/qXAQJal9jF3QAX6WByWQd8YF8U0SwJYbUvqOMzLnpVK
	WS0dpAVf3QPKP13FnXXzis/Z7raDevo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706712480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=H9jueoTrzcaPLPuT+a1O2/kKn4UT6jZ1/Pqb5NACW27CiPKeu1S5aajo6fQllHhHwmasO5
	6M63d5uvEBdj8kDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE5F132FA;
	Wed, 31 Jan 2024 14:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OwfNHKBdumUXcwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 14:48:00 +0000
Date: Wed, 31 Jan 2024 15:47:59 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, 
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Re: [PATCH V2 1/2] nvme/{rc,002,016,017,030,031}: introduce
 --resv_enable argument
Message-ID: <igsovxyv4y4lajn6chnmnszm5iwzl3qta33ornjzhx4ghchbte@xdjafxxjwhgx>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
 <20240117081742.93941-2-kanie@linux.alibaba.com>
 <mn2kvkfr72tp7j5pcudkqzrp4yory24mwuqxby3zy7rjdhm5oe@2prxhce7mmgd>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mn2kvkfr72tp7j5pcudkqzrp4yory24mwuqxby3zy7rjdhm5oe@2prxhce7mmgd>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=egvH5lum;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H9jueoTr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.99 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	 BAYES_HAM(-2.48)[97.64%]
X-Spam-Score: -6.99
X-Rspamd-Queue-Id: 8E6741FB87
X-Spam-Flag: NO

On Tue, Jan 23, 2024 at 10:54:07AM +0000, Shinichiro Kawasaki wrote:
> On Jan 17, 2024 / 16:17, Guixin Liu wrote:
> > Add an optional argument --resv_enable to _nvmet_target_setup() and
> > propagate it to _create_nvmet_subsystem() and _create_nvmet_ns().
> > 
> > One can call functions with --resv_enable to enable reservation
> > feature on a specific namespace.
> > 
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> 
> Thanks, looks good to me.
> 
> Daniel, could you take a look in this patch? I think it is consistent with your
> work on _nvme_connect_subsys() and _nvmet_target_setup() in the past.

It teaches _create_nvmet_ns and _create_nvmet_subsystem to parse for
arguments as we have for the function you named. This makes these
function a bit more flexible to use. Looks good to me. Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>
