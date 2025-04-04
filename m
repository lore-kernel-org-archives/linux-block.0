Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F719EED2
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761743; cv=none; b=LqjI8K1NwH8VDnOVGu/GcZlGr4CWLdbxO6XCLYJctx+8DAQLtBq4BthatDwzEtAzm/sBaqItOSfdbM0txA7tJmKoenorj7rFZsbnhpN9D4+MEglfIVZUe752oH/V9BZproBkH72CJXcmPeNJuCdkzP7ajgVUYYLkL2gQA/pyXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761743; c=relaxed/simple;
	bh=iCNj5QWfJai/8GRQoEf6/TRyea3aTP7koU09cZRdtSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnEsirymJ5xnkKukzIEXSlkrXJ82msSh1ZiFWLyVtdLxRDwR8BQjxyB0s8iMgsirBWC78H6LL54GYhm7RWKUm+icCQ2906HNZWw4PG/HyQ8Sxf6xdswCxqUo+hE6LFNsLWs81UFv+YjRIAKtbl5A1e/xPtwEPvfgGDrZdrkw8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dePZjWkg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sr1VKemX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dePZjWkg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sr1VKemX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dePZjWkg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sr1VKemX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dePZjWkg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sr1VKemX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1513E1F385;
	Fri,  4 Apr 2025 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743761734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6zI6BG7qAbxqQR1y/+GzOdnQsNhRO6AHm1JYpaUKj8=;
	b=dePZjWkglX5UND1stFSJTAWtmWkwIdSJvsZmbqL4hMH6EJY2uNcMx6Prdr4twKad/TJ1r3
	6oANa1dV/45YsRWiTiSSPSRaTiJ5QKBTX3PjVCQVIzCQfbfN1kc+oz4m75Yf9yNxQ2x8tM
	iht2dTOQ5f2vjmMhx/aNAJ/xbO9bXF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743761734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6zI6BG7qAbxqQR1y/+GzOdnQsNhRO6AHm1JYpaUKj8=;
	b=sr1VKemXWKFfptTYMYZkOu4uwE2pwjBEaxHABqOEZcwyzmO3R3gD4YujVj3xfiQyNs8TZ2
	sUWtXbaSTGqdOkAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dePZjWkg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sr1VKemX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743761734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6zI6BG7qAbxqQR1y/+GzOdnQsNhRO6AHm1JYpaUKj8=;
	b=dePZjWkglX5UND1stFSJTAWtmWkwIdSJvsZmbqL4hMH6EJY2uNcMx6Prdr4twKad/TJ1r3
	6oANa1dV/45YsRWiTiSSPSRaTiJ5QKBTX3PjVCQVIzCQfbfN1kc+oz4m75Yf9yNxQ2x8tM
	iht2dTOQ5f2vjmMhx/aNAJ/xbO9bXF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743761734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6zI6BG7qAbxqQR1y/+GzOdnQsNhRO6AHm1JYpaUKj8=;
	b=sr1VKemXWKFfptTYMYZkOu4uwE2pwjBEaxHABqOEZcwyzmO3R3gD4YujVj3xfiQyNs8TZ2
	sUWtXbaSTGqdOkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9D2F1364F;
	Fri,  4 Apr 2025 10:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pJ13NkWx72eHHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 04 Apr 2025 10:15:33 +0000
Date: Fri, 4 Apr 2025 12:15:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Message-ID: <f3ef9d0d-ea02-4181-9aa9-ab265ac6b9b2@flourine.local>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
 <eusczvub2jnb5dw26t52tpmsidd6fwehfbfqgaparsrmhxdasd@xwwxeqaxh7h5>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eusczvub2jnb5dw26t52tpmsidd6fwehfbfqgaparsrmhxdasd@xwwxeqaxh7h5>
X-Rspamd-Queue-Id: 1513E1F385
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 04, 2025 at 08:08:31AM +0000, Shinichiro Kawasaki wrote:
> On Mar 18, 2025 / 11:39, Daniel Wagner wrote:
> > Newer kernel support to reset the target via the debugfs. Add a new test
> > case which exercises this interface.
> 
> I find the kernel commit 649fd41420a8 ("nvmet: add debugfs support") enables
> this test. Looking at the kernel commit, I fount this test case depends on the
> kernel config NVME_TARGET_DEBUGFS. So let's add,
> 
>  _have_kernel_option NVME_TARGET_DEBUGFS
> 
> in requires().

Ah yes, this works for this test case!

> > +requires() {
> > +	_nvme_requires
> > +	_have_loop
> > +	_have_fio
> 
> I don't find fio command in this test case. Do I miss it?

No, it's a left over from the development phase.

> > +nvmf_wait_for_state() {
> > +	local def_state_timeout=5
> > +	local subsys_name="$1"
> > +	local state="$2"
> > +	local timeout="${3:-$def_state_timeout}"
> > +	local nvmedev
> > +	local state_file
> > +	local start_time
> > +	local end_time
> > +
> > +	nvmedev=$(_find_nvme_dev "${subsys_name}")
> > +	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
> > +
> > +	start_time=$(date +%s)
> > +	while ! grep -q "${state}" "${state_file}"; do
> > +		sleep 1
> > +		end_time=$(date +%s)
> > +		if (( end_time - start_time > timeout )); then
> > +			echo "expected state \"${state}\" not " \
> > +				"reached within ${timeout} seconds"
> > +			return 1
> > +		fi
> > +	done
> > +
> > +	return 0
> > +}
> 
> Is this function used in this test case?

Oops, another leftover.
