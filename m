Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB201A4B2D
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425017; cv=none; b=fsDYpwfHveJ0/IkVa93XzXXZ9oiY/BdwCYFVBJOnBdpSq9anam4JwZC9wGYE16sfw7GWLOzxFWJk/rZW3x0BaTQF/OcnXHBjnY6BY9hTP5WQV8A+riWBaaW+oKHy8OdODgp/ariW6edaPSJ+8keVidu4irXbG02WkrlVLtM2tfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425017; c=relaxed/simple;
	bh=uS4cB8oVRhHCEOYdN2Ftg4rKoK3YK/GnPg7DKo8DtfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU7+wnxXA1PkpRFD2US/Tj0zFCJ7ZEYrIhovWQJIpnvL6zaARrb8Vh0iHUsN195OEP5VIL2vxbUY14+3iKHcHNDCnzOFfbZ6qiHezsTyJOlKBRlI8/GF2Yh8wcAjyUMxwoIcVaEqHWVs8iMVr4u43/EuAdW08LFucnuLWxTuaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VQgvv9d9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O+xX7idY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VQgvv9d9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O+xX7idY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VQgvv9d9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O+xX7idY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VQgvv9d9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O+xX7idY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4D7821A23;
	Wed, 31 Jul 2024 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722425013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/I6Mg3fQwNPd8qN6jTldl5MRgug6mnq91+Bt+0QaoQ=;
	b=VQgvv9d9vPf+RWxxBzovhYfqgVL8f9sWI5AqJdyGyzJwoStgeto8M7sLWtaVaMxEwad55I
	c4N2dByt3g6cgdH0m+Q0K8VqaCEdxm2j5WDFAJzmdtspGKWlcAFX+eMbJvCqskh2/rB4ab
	TTHb7zGBHdbpeBw4iOEz0s6VIOa6VeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722425013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/I6Mg3fQwNPd8qN6jTldl5MRgug6mnq91+Bt+0QaoQ=;
	b=O+xX7idY+NsBkOb1HuktMx6ACJsV8un7L9eCMp2KWPS7TS1p1jmKWOt5XRhoSM/kJmJuy7
	2VCdzHX1eUuXj9Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VQgvv9d9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O+xX7idY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722425013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/I6Mg3fQwNPd8qN6jTldl5MRgug6mnq91+Bt+0QaoQ=;
	b=VQgvv9d9vPf+RWxxBzovhYfqgVL8f9sWI5AqJdyGyzJwoStgeto8M7sLWtaVaMxEwad55I
	c4N2dByt3g6cgdH0m+Q0K8VqaCEdxm2j5WDFAJzmdtspGKWlcAFX+eMbJvCqskh2/rB4ab
	TTHb7zGBHdbpeBw4iOEz0s6VIOa6VeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722425013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/I6Mg3fQwNPd8qN6jTldl5MRgug6mnq91+Bt+0QaoQ=;
	b=O+xX7idY+NsBkOb1HuktMx6ACJsV8un7L9eCMp2KWPS7TS1p1jmKWOt5XRhoSM/kJmJuy7
	2VCdzHX1eUuXj9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94BF91368F;
	Wed, 31 Jul 2024 11:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8EZYI7UeqmY7PAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 31 Jul 2024 11:23:33 +0000
Date: Wed, 31 Jul 2024 13:23:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
Message-ID: <ZqoelLy4Wp33YAGD@yuki>
References: <20240731111804.1161524-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731111804.1161524-1-nilay@linux.ibm.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A4D7821A23
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

Hi!
> The loop/011 is regression test for kernel commit 5f75e081ab5c ("loop: 
> Disable fallocate() zero and discard if not supported") which requires 
> minimum kernel version 6.10. So running this test on kernel version
> older than v6.10 would FAIL. This patch ensures that we skip running 
> loop/011 if kernel version is older than v6.10.

The patch has been backported to 6.9 stable as well.

> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  tests/loop/011 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/loop/011 b/tests/loop/011
> index 35eb39b..b674dd7 100755
> --- a/tests/loop/011
> +++ b/tests/loop/011
> @@ -9,6 +9,7 @@
>  DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
>  
>  requires() {
> +	_have_kver 6 10
>  	_have_program mkfs.ext2
>  }
>  
> -- 
> 2.45.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz
