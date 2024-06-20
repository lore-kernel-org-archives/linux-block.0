Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252E40858
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866533; cv=none; b=Wdsg5idwTciUxJJpuUSoJ/infDxgA8N147nAWK8ZK1/RVnlhLLHDm2vznaNXCzjlS1r15MjKg0pRHJJhnITccR9+eYS0zGke4cHFPHRwDvV2pNexl55SOIUbTT2rRJi8TrSRJjsY7JtJcY+bgeVMamlPW4iIAWJmh2xs35ohXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866533; c=relaxed/simple;
	bh=4aZExrd7FFA4YHdZzkf36xGFOiIQc350CT6XNnKeexw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbQWx8PyGKFkweIhCyH34ZQ/zhys40ri80AOvaYiX8Da4lDLmwL/uk45wNdFbOxpg3SDE21QwPi4UcpP92O2YLmIEK97sIRmvjDxj+yM2duwwIzbPtFIn6yiJX3tEy2EyMnU/iK3HOF0TQ+YrvYYHpaogGNR9TC+c0rCSIECz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ketcq9Pl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eiU4Wjoo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ketcq9Pl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eiU4Wjoo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ketcq9Pl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eiU4Wjoo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ketcq9Pl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eiU4Wjoo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64B1221A93;
	Thu, 20 Jun 2024 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718866529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=ketcq9PlipNGFh2ETf6GCaYNQDQyyq6a7UAh4qmsTYY2wx9X/EB22SF7Flw1Hz0FaaOnor
	7vBun0eIipz3mMI/pmOb2QryxUqOec4y1ky7PTb8evBvh0bGMIswhGnuT4RvpoA9sdKtU9
	CtFGaksc5AC2qdpoNrPYDpMQmkNlV+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718866529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=eiU4Wjooj8pGRSET+FvPBMHbKqGGRJWAQLRNKsVP+ucsJS4mAhyoU2DtP0wyutT+WU5RGs
	RRvKyxTOIuGk8pAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718866529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=ketcq9PlipNGFh2ETf6GCaYNQDQyyq6a7UAh4qmsTYY2wx9X/EB22SF7Flw1Hz0FaaOnor
	7vBun0eIipz3mMI/pmOb2QryxUqOec4y1ky7PTb8evBvh0bGMIswhGnuT4RvpoA9sdKtU9
	CtFGaksc5AC2qdpoNrPYDpMQmkNlV+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718866529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=eiU4Wjooj8pGRSET+FvPBMHbKqGGRJWAQLRNKsVP+ucsJS4mAhyoU2DtP0wyutT+WU5RGs
	RRvKyxTOIuGk8pAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4351F1369F;
	Thu, 20 Jun 2024 06:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yC8eEGHSc2bfQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 20 Jun 2024 06:55:29 +0000
Date: Thu, 20 Jun 2024 08:55:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org, 
	sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Message-ID: <iq3w7dbe5bydidn4omoxh7o6vew6w37ovybu67xzvja3kojcp7@hghcwi5egngh>
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
 <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
 <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, Jun 20, 2024 at 12:10:32PM GMT, Nilay Shroff wrote:
> 
> 
> On 6/20/24 12:05, Daniel Wagner wrote:
> > On Wed, Jun 19, 2024 at 10:55:02PM GMT, Nilay Shroff wrote:
> >> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
> >> +		uuid="$(uuidgen -r)"
> > 
> > This adds a new dependency on an external tool. It should be mentioned
> > in the README and added to the list of tools to check for:
> > _check_dependencies(). Alternatively you could skip the test if the tool
> > is not available. Anyway the rest looks good.
> > 
> The "uuidgen" is part of util-linux package and I saw that it's already mentioned
> as one of the required packages for blktest: https://github.com/osandov/blktests

Ah, I just grepped for uuidgen and there is no other user. So all is good.
