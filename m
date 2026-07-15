Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98C353A7F
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118053; cv=none; b=rModulR3v0Riv2cnwWTtat8q+vqLUwGPwkLZkLWe3fP6klb3E81BNzx+ZdcDF+moSHgdetaTxwFeGQ+AFH1cFBn7+7bVRPp/GhyKRu4IZk6Utd37ZzqIbrDTn6NNzB4hgHL8A/0p3IdUaPusFPHrpvE7wuGrFxBUe+lxelZ3F1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118053; c=relaxed/simple;
	bh=ck+1Qemtg0EsT5LFvjN/87xZgLtSEv3ee6bOMqDUWK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMFXeKe9bin22z1puAF8Pw7ouaWl1r7FffRKc0QWcAFKPJcbRTxzkBI4v5gP1aiL3emEwSp+5MRGyEFU8qy87Q2QM8+rkuXzE8JVQSKKP87Slcg40lvxHQ2GrduCZXnrR2GAfJPf1epfZFj6qOZ4gLJjtBdXlSoVgxJIayvshDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tObKmBi4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=91ZvY8fG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tObKmBi4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=91ZvY8fG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tObKmBi4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="91ZvY8fG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tObKmBi4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="91ZvY8fG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 605213E41;
	Wed, 15 Jul 2026 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=tObKmBi4kD240+5jFg1/HvfThYVwFhh37YIRtiSqpSzSpMAKVzRs/zqlqozAI32jj5K/Ca
	iIyV/7tZ5hIaI6NiJLq7e5Q5zf5EY8iT9VXoqqSbMm9EdD1wLKNBTn0NZaITM95hpyXi9c
	cFwuF5M3wV3ewphrz51OPtLgOXvZpyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=91ZvY8fGeNhJYeZ/jTEnRwR8H+qtDA9dJH8VpBwG27SbvenZovIWtFV4RJNJSyBRaXXCB8
	O5tbWCUdIuZbfEBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=tObKmBi4kD240+5jFg1/HvfThYVwFhh37YIRtiSqpSzSpMAKVzRs/zqlqozAI32jj5K/Ca
	iIyV/7tZ5hIaI6NiJLq7e5Q5zf5EY8iT9VXoqqSbMm9EdD1wLKNBTn0NZaITM95hpyXi9c
	cFwuF5M3wV3ewphrz51OPtLgOXvZpyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=91ZvY8fGeNhJYeZ/jTEnRwR8H+qtDA9dJH8VpBwG27SbvenZovIWtFV4RJNJSyBRaXXCB8
	O5tbWCUdIuZbfEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B253779AD;
	Wed, 15 Jul 2026 12:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lnidECJ7V2quTAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jul 2026 12:20:50 +0000
Date: Wed, 15 Jul 2026 14:20:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, hch@lst.de, 
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH blktests] nvme/069: add a test for multipath cdev lifetime
Message-ID: <7f5c5f13-78a1-4d66-bdc4-e2e2260dd949@flourine.local>
References: <20260714094345.3370884-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714094345.3370884-1-john.g.garry@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-Spam-Level: 

On Tue, Jul 14, 2026 at 09:43:45AM +0000, John Garry wrote:
> +	# nvme-delay-ioctl will open the nvme-generic cdev, sleep, and then
> +	# issue an ioctl.
> +	# We tear down the nvme-subsystem in the foreground so we can catch
> +	# if the ioctl triggers a use-after-free KASAN warn.
> +	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
> +	sleep 0.5
> +	_nvme_disconnect_ctrl "${nvmedev}"

The sleep above is to give nvme-delay-ioctl enough time to setup,
right? Would it possible for nvme-delay-ioctl issue some signal (or any
other working sync method) and we just wait for it to show up? IMO sleep
should be avoided if possible.
