Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3563C
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422169; cv=none; b=eeRClinM6seUyExM45E6x2BmLk7ZPgjelKGKvFDPTf08SrD2Q4nC3zDYsA/vv79N0Ivy/r07iqAIfVh73O5Bo2zGy7uxjA5xClfniH+k3bX2IotM70AaikJyNrlqGhahyPEhkm2olVJ2J1dn5srdZxr3IK9KVQbtcrEASBS9PqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422169; c=relaxed/simple;
	bh=wvaj+0a+8cFHUb9lih4nuUksTiWVMN14NvOaAKuQyIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIBTWZJL27KCq3B/NkaxjZTZD1zrkFdw86Ujjt1aXK4Q9iK8BUYodQFL4fzREc9/JqEYJm4AL1+GzcKvBFuhFJbh/+TLieM+VeObqFYHmAgopGfdcY26TrWrgtHqTLIRXBOW2qGlaGrQlX3p1icCj/peEkV37rGgS1pEV2rejHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vqY5iAsQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5U4VVGsy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vrlQ0SOi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVhUqmhv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vqY5iAsQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5U4VVGsy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vrlQ0SOi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVhUqmhv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E92C85C509;
	Thu, 18 Apr 2024 06:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvaj+0a+8cFHUb9lih4nuUksTiWVMN14NvOaAKuQyIo=;
	b=vqY5iAsQRy1NCHlYvE1JOF+amSKwLGUfbp+LyJeE5Kq6WESwzw0ntfwdUffrHmhURLpK6r
	xW8BfazKp5624N2YWCC+lnefxKcvnh4OFDuSIStsuYJeOOH76SBqZWFVQXNPTBNu7JdYGD
	4QCYfL+x7+9ontMRnUS1HMMt0tbQgoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvaj+0a+8cFHUb9lih4nuUksTiWVMN14NvOaAKuQyIo=;
	b=5U4VVGsyKYLpt5qMPhJE0BVuz+PeWYTKpWaztIvhJnGSfEpWQNQ4r7raT0xGXNpxYvfxyz
	eLUBR2yj/yubgGAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vrlQ0SOi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UVhUqmhv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvaj+0a+8cFHUb9lih4nuUksTiWVMN14NvOaAKuQyIo=;
	b=vrlQ0SOiz7Fo3YVae+X4L7jopRV5SyEMHMmY0Hc9ZRo01oXAtfw8PO46P1Ez1MHmYA1sqX
	cAvGTi3ddpMVqKLQuq/PmaAd01dgsnCJaIWb9eYSI8CHlSNgifSUL5iZ1kbyr4lBIqpA3P
	KYf/JAGnXEND/S0vmjvdZSA1Hy3/j3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvaj+0a+8cFHUb9lih4nuUksTiWVMN14NvOaAKuQyIo=;
	b=UVhUqmhvNXIFBBbL5HlAuX+Ulx6sIgSnBn+Xp7tGA2bVvjDeAN1hwbRIvWnoHO6l9Gmx9+
	IhWPgDvOSU4jfJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6A4213687;
	Thu, 18 Apr 2024 06:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cUz1MlW/IGbRdQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 18 Apr 2024 06:36:05 +0000
Date: Thu, 18 Apr 2024 08:36:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Message-ID: <ar2nwyps3zu2vf3zjw322nfxhua67rh5tdyqfsj6cymvia3zjc@y42szgq6ikvc>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
 <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
 <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
 <epbj4opovczrfrs3o3mdodjs2dtekl4jsxgbwhtnqhq5bjhjnl@54b5mo6wixsk>
 <extncf2en5xoiov5mhnaglwd33nmffx2u2mw3zlnrxuty3zurx@nij7avtahebv>
 <f4b9ca90-3d8e-4782-a54b-b83c01316d29@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4b9ca90-3d8e-4782-a54b-b83c01316d29@nvidia.com>
X-Spam-Flag: NO
X-Spam-Score: -4.98
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E92C85C509
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.98 / 50.00];
	BAYES_HAM(-2.97)[99.86%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]

On Thu, Apr 18, 2024 at 06:12:40AM +0000, Chaitanya Kulkarni wrote:
> agree they should be uppercase not denying that, the only reason I
> asked since existing variables are lowercase, it'd be very confusing
> to have some variables in nvme category with lower case and some
> upper case ...

Same here, so let's fix this and add upper case versions of the existing
variables incl documentation. I suggest we keep the lower case ones
around for awhile (maybe incl a warning?) before we drop the support.

What do you think?
