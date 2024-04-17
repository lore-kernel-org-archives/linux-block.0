Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E48524BC
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337308; cv=none; b=HQonDEFk0AmzRmhXlL2Z/UXualxb+bU3LQTRRSFSF8U6XbXWqMnBZs/6cDph/hBHfB78RR7wrN1UBVSmpJM4Q5fQZbv7fAT2j9YU+BxgLgUscvPfcpyxJeHZ3F5sNQwuSx30J1Fylc7rV1BstkUUeHSkHTK8M1zgJkKilTSMaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337308; c=relaxed/simple;
	bh=Xiab43kCAgAU4r306YrPDP7WzbXhfdmbyaMBW/qturg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7jzMONwo+eP6uiTvFPayYWQDnXMB66hwwF178XMvBIHArYfle6yeLKOF26GClcrLSH3kzDujU17pvczlODKB/5EcJ9sLsYYzlAH5U3vWsxdIXvD1LozbmGq9ZbmryPXZgGF1RmJkKR1lMeC7XxV0GARKuL58HIrThrqxdwqez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z7MpAtEa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UIwVVata; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z7MpAtEa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UIwVVata; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z7MpAtEa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UIwVVata";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z7MpAtEa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UIwVVata"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4675720467;
	Wed, 17 Apr 2024 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713337301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=723+iop/jpMlbqP404QRDp8M6ornsQdj+lpTCspHE0I=;
	b=Z7MpAtEaBQPrW4LXVJtv/XRD6qze5zv8rQNLDVZp3YpdDC2duRz/OKz8/cJk4uyVIBRQLQ
	CdXyvl7J0Xk/pLfEaYpxqcG2NuEL3cdZMSrf1AtO8ndjPTQgOGqZUJ24G9eEA6UzkyGANN
	32QzgmYFKSYZehuY6jFpZay0bnBcOa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713337301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=723+iop/jpMlbqP404QRDp8M6ornsQdj+lpTCspHE0I=;
	b=UIwVVatayKjJ7Z0+/jpuwu4sH0WhBtwx1I+ZiVKBVvrtvl6H4e5HYLpgT+n/coSC8TCH9o
	QS4xo4o0F3SvEeAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z7MpAtEa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UIwVVata
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713337301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=723+iop/jpMlbqP404QRDp8M6ornsQdj+lpTCspHE0I=;
	b=Z7MpAtEaBQPrW4LXVJtv/XRD6qze5zv8rQNLDVZp3YpdDC2duRz/OKz8/cJk4uyVIBRQLQ
	CdXyvl7J0Xk/pLfEaYpxqcG2NuEL3cdZMSrf1AtO8ndjPTQgOGqZUJ24G9eEA6UzkyGANN
	32QzgmYFKSYZehuY6jFpZay0bnBcOa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713337301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=723+iop/jpMlbqP404QRDp8M6ornsQdj+lpTCspHE0I=;
	b=UIwVVatayKjJ7Z0+/jpuwu4sH0WhBtwx1I+ZiVKBVvrtvl6H4e5HYLpgT+n/coSC8TCH9o
	QS4xo4o0F3SvEeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34F8813957;
	Wed, 17 Apr 2024 07:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RjuCC9VzH2YfIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Apr 2024 07:01:41 +0000
Date: Wed, 17 Apr 2024 09:01:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v2 00/11] support test case repeat by different
 conditions
Message-ID: <undnwuhrsdoawhnmfwyata5ukod275hl762qckiohxq4d6a3aj@nbmci2nialjm>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4675720467
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]

On Tue, Apr 16, 2024 at 07:31:56PM +0900, Shin'ichiro Kawasaki wrote:
> In the recent discussion for nvme test group [1], two pain points were mentioned
> regarding the test case runs.
> 
> 1) Several test cases in nvme test group do exactly the same test except the
>    NVME transport backend set up condition difference (device vs. file). This
>    results in duplicate test script codes. It is desired to unify the test cases
>    and run them repeatedly with the different conditions.
> 
> 2) NVME transport types can be specified with nvme_trtype parameter so that the
>    same tests can be run for various transport types. However, some test cases
>    do not depend on the transport types. They are repeated in multiple runs for
>    the various transport types under the exact same conditions. It is desired to
>    repeat the test cases only when such repetition is required.
> 
> [1] https://lore.kernel.org/linux-block/w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72/
> 
> One idea to address these pain points is to add the test repeat feature to the
> nvme test group. However, Daniel questioned if the feature could be implemented
> in the blktests framework. Actually, a similar feature has already been
> implemented to repeat some test cases for non-zoned block devices and zoned
> block devices. However, this feature is implemented only for the zoned and non-
> zoned device conditions. It can not fulfill the desires for nvme test group.
> 
> This series proposes to generalize the feature in the blktests framework to
> repeat the test cases with different conditions. Introduce a new function
> set_conditions() that each test case can define and instruct the framework to
> repeat the test case. The first four patches introduce the feature and apply it
> to the repetition for non-zoned and zoned block devices. The following seven
> patches apply the feature to nvme test group so that the test cases can be
> repeated for NVME transport types and backend types in the ideal way. Two of the
> seven patches are reused from the work by Daniel. The all patches are listed in
> the order that does not lose the test coverage with the default set up.
> 
> This series introduces new config parameters NVMET_TRTYPES and
> NVMET_BLKDEV_TYPES, which can take multiple values with space separators. When
> they are defined in the config file as follows,
> 
>   NVMET_TRTYPES="loop rdma tcp"
>   NVMET_BLKDEV_TYPES="device file"
> 
> the test cases which depend on these parameters are repeated 3 x 2 = 6 times.
> For example, nvme/006 is repeated as follows.
> 
> nvme/006 (nvmet bd=device tr=loop) (create an NVMeOF target) [passed]
>     runtime  0.148s  ...  0.165s
> nvme/006 (nvmet bd=device tr=rdma) (create an NVMeOF target) [passed]
>     runtime  0.273s  ...  0.235s
> nvme/006 (nvmet bd=device tr=tcp) (create an NVMeOF target)  [passed]
>     runtime  0.162s  ...  0.164s
> nvme/006 (nvmet bd=file tr=loop) (create an NVMeOF target)   [passed]
>     runtime  0.138s  ...  0.134s
> nvme/006 (nvmet bd=file tr=rdma) (create an NVMeOF target)   [passed]
>     runtime  0.216s  ...  0.201s
> nvme/006 (nvmet bd=file tr=tcp) (create an NVMeOF target)    [passed]
>     runtime  0.154s  ...  0.146s

Looks all good to me. I also run the nvme part of blktests. The
framework works fine but as expected we have a bunch of new errors
reported because of the additional test coverage this change brings.
Thanks a lot for your work!

Reviewed-by: Daniel Wagner <dwagner@suse.de>
