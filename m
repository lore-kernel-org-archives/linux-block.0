Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE91273F9
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501074; cv=none; b=CE9pPtuwLNywOuku59mvZi3hQiGZbMTfQoEbCeTQrZ90Y77Sx3OvLPBxB7aSuhpIPZ/DyauKYAWV8ACl0duO+0qn+bucg8g7PLDKuCz/V/LGQxCTJQ4kurTPSJctXVuyiAQRSW1MsJIF6ttCV/D+rX1XmlmAOMnv+fUGYNSxkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501074; c=relaxed/simple;
	bh=UkV2shAiJ5EHg9ZBlg/CPeHWbWX6pCc+uk6Ej55E/F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWMgOy0wYMG8sbZxlpKPPd55gEo8+bYTpneCzWiwgrFy09W2JR8F2LlkmhC2hTXcvXcjEB5hweeul7xVe04VaMKPqilKGxMTcMUcy+pVheOUlbjyG7JfUIHJQDjyH5q5JV4HDkLm+vf0uJ0wvVj4fRVjNqF6nUSpxboPwctvVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h5gq9O5b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CEtx7bJ6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V7yKBsAw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JBVTCLS6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h5gq9O5b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CEtx7bJ6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V7yKBsAw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JBVTCLS6"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED70E1FB45;
	Wed, 21 Feb 2024 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=h5gq9O5bTVnLpAceRrP5rg47UegDl3Zgddg+Tvgh99FrxoGcMWsTRdWzRdu7hiiDNLGmN6
	MiCASgElC+YJDFg56G3t8fV3mwBPktbl/+NsKCdUNDMxgIEaOUIrZ5f2nqlPExzcRFqcJc
	NT9jSMRrQuX/vTj2AdmnhjYFJrYiZyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=CEtx7bJ6UUcyY5cKfjsS6CW9/cYo813lAsXauFE9jNGV+XAwZOL+03BrszrzkVT2P+K+tS
	Wlck+jBUvYW3CwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=V7yKBsAwPex/8AHmLXUtdYkGceqJ1FTrVyBIHc8CVfdAw7sVoudZD2Hly1NpmcqX6iB7cC
	PnfDwrk2yXnS1H993VC0MSFmoPhEURM6FskwLtgfj7e6jPy9BgwvYhaQYOsRYutypcQmA1
	7RdD/mTJqKWzIj54bP5F+7OJ1Ru4EII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=JBVTCLS60cWqjYp+F6fXV2EN9XH4ssTbAxjmjhEMT9JCc/q5ivpKdOFqV02OXvrBu0T8aa
	fr7iXy4+ayWK6dDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D997D13A25;
	Wed, 21 Feb 2024 07:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id C3l5M0io1WXZbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 07:37:44 +0000
Date: Wed, 21 Feb 2024 08:37:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: Re: [PATCH blktests v0] nvme/029: reserve hugepages for lager
 allocations
Message-ID: <eo2iqix7vzrjgjs6bhx44s3rxblxorc4za62rrzaw5hqb5xqlh@uad7uc4lx35z>
References: <20240220081327.2678-1-dwagner@suse.de>
 <6xxslyeuaetammpqcsekkmzmuz5vmtscrhczi6inwoj2ne52se@mh2zrp6kxgiv>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6xxslyeuaetammpqcsekkmzmuz5vmtscrhczi6inwoj2ne52se@mh2zrp6kxgiv>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V7yKBsAw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JBVTCLS6
X-Spamd-Result: default: False [-0.69 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.88)[85.78%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.69
X-Rspamd-Queue-Id: ED70E1FB45
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, Feb 21, 2024 at 06:22:29AM +0000, Shinichiro Kawasaki wrote:
> I found this changes makes the test case fail when the kernel does not have
> CONFIG_HUGETLBFS. Without the config, /proc/sys/vm/nr_hugepages does not
> exist.
> 
> When CONFIG_HUGETLBFS is not defined, should we skip this test case?

Obviously, we should aim for really solid test cases. Though it is not
guaranteed that the test will pass even with CONFIG_HUGETLBS enabled. I
suspect we would need to make some more preparation steps that the
allocation has a high change to pass. Though I haven't really looked
into what the necessary steps would be. The sysfs exposes a few more
knobs to play with.

> If this is
> the case, we can add "_have_kernel_option HUGETLBFS" in requires(). If not, we
> should check existence of /proc/sys/vm/nr_hugepages before touching it, like:
> 
>        if [[ -r /proc/sys/vm/nr_hugepages &&
>                      "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then

Sure, I'll add this and also fix the typos in the commit message.

> 
> Also I suggest to add in-line comment to help understanding why nr_hugepages
> sysfs needs change. Something like,
> 
> # nvme-cli may fail to allocate linear memory for rather large IO buffers.
> # Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
> # from HugeTLB pool.

Ok.
