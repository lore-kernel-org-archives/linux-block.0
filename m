Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45B17984
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396587; cv=none; b=c+wfazN3ew8DCzB0Z72yeA8uclmglXvazmYZjYqfcWYMd1f/4RpDcLPuca9LC5FzxzPzmIvxAUrG1nejE5vbfn9/NZB3VeMb9Wqe9RRglqFDlIp1Xwd6i8a5u25BEtMM+1b93RNw/AABiWmWSPQVW3a8WtvIIQBA+M5ZzGnLy+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396587; c=relaxed/simple;
	bh=2n0EUc9W7vyHBYSAYPKeTML1rnRv6kmuf9lvY9N92Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unvmI7wyzI4VuhbD1HhAuDmfShR8jyxK+VQFHu4Kw0UYEUxuheRs0EnVwfg36A5Bb+Sk0De2yM0w5qRvrE45nOVM67rOsZMRwRL+3IPk9pexSwikUQ3+kIhwlPOHa6fT3Pn5xcEujl+V7IVUJ5n0AlC08YoqFj8qxMBwbF71TOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oPVBnHl2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ZzzLyiM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b6Npn9hJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1O7tC5HP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oPVBnHl2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ZzzLyiM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b6Npn9hJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1O7tC5HP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF42121E7D;
	Fri, 23 Aug 2024 07:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724396582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMay1/QtkkGYYKu3OlZND+NeJp5eXTB/e2pj+fLdOc=;
	b=oPVBnHl2lQ1vsQ0/PV+nV/e1gCLlSsoRxWHpj5MXdO1EWtdH3lkfLo5/f8KXKjkCMeJXZA
	VwV3FXcvbxlYimkGA1Nk1IFvxBMPUj2wJflPIVRM4s7kh7DcKhJtTCVpjZG3gDcQ5i65CN
	8v+RQ53DZsGFeaXvFztG449LdIjZFhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724396582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMay1/QtkkGYYKu3OlZND+NeJp5eXTB/e2pj+fLdOc=;
	b=4ZzzLyiMt+4BLqTiJ2Cd4Mz1K0RtvPfP1ac69a1Yj5TVz+Ua0EqzTBp92W+/cU/TYWdg1O
	XLzq86LUgGdfGABA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b6Npn9hJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1O7tC5HP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724396581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMay1/QtkkGYYKu3OlZND+NeJp5eXTB/e2pj+fLdOc=;
	b=b6Npn9hJvSl8cpklCy4YZK2lShMhmGquvQg1DZ9rj2vfgtBX3XrOx8t0jtwIzNtTE9EhJA
	M8JuF6fP11YDHeGvRMSMAqN6WigyWEZGuvLKcZ1bKKg4esV0yHjbnpD33RlkqxqUeKiIbY
	kftVfYfJn4uDjBWzrQtz6JpCsEj4hWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724396581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVMay1/QtkkGYYKu3OlZND+NeJp5eXTB/e2pj+fLdOc=;
	b=1O7tC5HPNMRoPbeCPoEDMyKntZcNKCKNBOVLl4FzNSjY8PaemxDTjGoN2X/o73kGeybiUA
	o8IPuYMJWTRIaKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F57D1333E;
	Fri, 23 Aug 2024 07:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VGFiJCU0yGZ6cAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 07:03:01 +0000
Date: Fri, 23 Aug 2024 09:03:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
Message-ID: <496211ed-9706-4d37-bc17-1b0207b6e780@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
 <20240822193814.106111-3-mwilck@suse.com>
 <9e199fd0-5767-4a63-930a-b08e89e4e354@flourine.local>
 <746c53383557efde6bfa09e2bd848b553f88ff3a.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746c53383557efde6bfa09e2bd848b553f88ff3a.camel@suse.com>
X-Rspamd-Queue-Id: BF42121E7D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, Aug 23, 2024 at 08:50:04AM GMT, Martin Wilck wrote:
> On Fri, 2024-08-23 at 08:45 +0200, Daniel Wagner wrote:
> > On Thu, Aug 22, 2024 at 09:38:14PM GMT, Martin Wilck wrote:
> > > Add a test that repeatedly rescans nvme controllers while doing IO
> > > on an nvme namespace connected to these controllers. The purpose
> > > of the test is to make sure that no I/O errors or data corruption
> > > occurs because of the rescan operations.
> > 
> > Could you elaborate why this tests is added? Does it test for a
> > regression, are there any patches for this? Or is it more let's
> > ensure
> > this actually works?
> 
> The rationale was to test the kernel patch that I submitted yesterday: 
> https://lore.kernel.org/linux-nvme/9de89e5a-04fc-4684-8514-b86884643a5d@suse.de/T/#t

I figured this out later too :) Just going chronology through the
inbox.
