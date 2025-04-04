Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB610E9
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761816; cv=none; b=OJECP3BcW4NUMSWw8/Didy1AQNELN9lpqVLkxkpwE4bX2JUU/uMrmY2YNYiai4AhyicmOwAirRNm2BVklxBzxjK4F6e7Y3c2y/CtIjffkI9l2iO5XfX2fXSQ6qIJqNLoF6iIgRum2y0teD7Kt+t7gwHxi/mov1J1OIqqmdXNzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761816; c=relaxed/simple;
	bh=aQdX7jET/bVKk6QCQaMQyPIjlbCtl9kwn4AVBDqx/C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfcFg919oqR4IoaLjhE+3aKzB0Jf36VMKCYA0HaQvDwf5A6M7nU6Boq5uB94x6XifHndh+LbmmanyFDSBUIgBl2Bq2GZX1c3NcbPFps0v39l8YYHPo2VdQj/4NcW9EFs8ciGyPB1sTJIg1caSWq8pl1kN+nd4C70MYSl9peXtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SRVK0QFG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rnF/vIhx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SRVK0QFG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rnF/vIhx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SRVK0QFG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rnF/vIhx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SRVK0QFG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rnF/vIhx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 094C01F385;
	Fri,  4 Apr 2025 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743761813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oorFk50+mlMHbseeVdZ3A+lq9IqE26MdaIdKtbHJgqM=;
	b=SRVK0QFGrt2w9fNFro/WZcN9unWCTz4OCAqF/Iz/fXPxAdI7tg4cDsQSiUPnnJkJ9CFyrQ
	OixdMcRDBxNDC6v3DSO2NS6m9I4PKiQIE2wFuhcKDo5aaZsrl1ijoooOsAgEh8moqx9T+F
	0jMLDYK+faPLF12JH6sqRekdg7xEf2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743761813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oorFk50+mlMHbseeVdZ3A+lq9IqE26MdaIdKtbHJgqM=;
	b=rnF/vIhxTZFHLaZGYFsA34CsjcbqenactCzKiYpUu/kdWN6of6bvaylLktvbjKyt2j+orM
	dIsICaxPhAcKoiBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743761813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oorFk50+mlMHbseeVdZ3A+lq9IqE26MdaIdKtbHJgqM=;
	b=SRVK0QFGrt2w9fNFro/WZcN9unWCTz4OCAqF/Iz/fXPxAdI7tg4cDsQSiUPnnJkJ9CFyrQ
	OixdMcRDBxNDC6v3DSO2NS6m9I4PKiQIE2wFuhcKDo5aaZsrl1ijoooOsAgEh8moqx9T+F
	0jMLDYK+faPLF12JH6sqRekdg7xEf2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743761813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oorFk50+mlMHbseeVdZ3A+lq9IqE26MdaIdKtbHJgqM=;
	b=rnF/vIhxTZFHLaZGYFsA34CsjcbqenactCzKiYpUu/kdWN6of6bvaylLktvbjKyt2j+orM
	dIsICaxPhAcKoiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E387E1364F;
	Fri,  4 Apr 2025 10:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lc8hNZSx72cMHgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 04 Apr 2025 10:16:52 +0000
Date: Fri, 4 Apr 2025 12:16:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] nvme/061: add test teardown and setup
 fabrics target during I/O
Message-ID: <4d83d1c8-027a-4fe3-ab5b-2736ef3bae29@flourine.local>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-3-01e01142cf2b@kernel.org>
 <hwhnca7bznamhw7xqdjcxp3tt2b2ssgnvtigv7kbj5eg6k7kxh@pbakdqqb6k5i>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hwhnca7bznamhw7xqdjcxp3tt2b2ssgnvtigv7kbj5eg6k7kxh@pbakdqqb6k5i>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 04, 2025 at 08:22:47AM +0000, Shinichiro Kawasaki wrote:
> On Mar 18, 2025 / 11:39, Daniel Wagner wrote:
> > Add a new test case which forcefully removes the target and setup it
> > again.
> 
> This test case has a few shellcheck warnings.
> 
> tests/nvme/061:63:3: warning: connect_args appears unused. Verify use (or export if used externally). [SC2034]
> tests/nvme/061:84:22: note: Double quote to prevent globbing and word splitting. [SC2086]
> tests/nvme/061:89:22: note: Double quote to prevent globbing and word splitting. [SC2086]
> 
> When I ran the test case on my test system, I observed it failed. Is it
> expected?

Yes, this should be fixed with my fcloop work eventually.

Thanks for the review!
