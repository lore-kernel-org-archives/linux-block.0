Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318F33C9
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890240; cv=none; b=ouVCc+uD3K6nJf08Jy7UhygzdpSXtLqgEXItyr4R49DTojba9P64oPWQMr2b7pFyIMgA/Auuw7lhkSDm9dAkmFtes3eB4MMJIaxG+116OyqdV2EKFgVwRQq1qXdYsSEV0Yxya+vwRKfBawCLDtvvsSWITTEZzuZa8pHeQbmQ+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890240; c=relaxed/simple;
	bh=0MOATUJ5CyydvErPPoMlcbQM6zkwV1BC28Nez5mQ6rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeUG3hlJhtfCYUeJBUg3lfwY0ZZkMkcc/DDCwuil57eilj5iwevNKn+TSaBu6ybyNl1YEg2zncbe1+9wdBiJ5hhcdxtvMEmJZczGnaEn5KtQ9Dv3fo0fva6Fs2drkjd0+tZ3gjs7OVZJtojmqxAAol9CPN0u4NPmFNDO/dsd4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wjgH7MnV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lS5c24f3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wjgH7MnV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lS5c24f3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wjgH7MnV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lS5c24f3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wjgH7MnV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lS5c24f3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A95961FE70;
	Mon, 14 Oct 2024 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728890235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=wjgH7MnVvT67UWcN/GtBg43sRN1yCkbEKnqA7xCFTvrV3kWGNcCBSoNdqV5+3QaZ6kA9rw
	vhcqrQu95YPXyGyB1Y0dkFs2ezISkItZW0dTD2kvSu0QPbFJt/YcVHhnAmeiB89p7MnQ5f
	VwAxckHWyOSr1FKUNVcyzKkNgyDTKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728890235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=lS5c24f3EFA1nSLdg/EDEn9SNBdM8c1Gr+Azm4zFN0FEw0ASAPFA28/Tuw/pOSQ+bPygcY
	54e41h96UQ5prxDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728890235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=wjgH7MnVvT67UWcN/GtBg43sRN1yCkbEKnqA7xCFTvrV3kWGNcCBSoNdqV5+3QaZ6kA9rw
	vhcqrQu95YPXyGyB1Y0dkFs2ezISkItZW0dTD2kvSu0QPbFJt/YcVHhnAmeiB89p7MnQ5f
	VwAxckHWyOSr1FKUNVcyzKkNgyDTKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728890235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=lS5c24f3EFA1nSLdg/EDEn9SNBdM8c1Gr+Azm4zFN0FEw0ASAPFA28/Tuw/pOSQ+bPygcY
	54e41h96UQ5prxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BDD213A42;
	Mon, 14 Oct 2024 07:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VbPLH3vFDGd6WgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 07:17:15 +0000
Date: Mon, 14 Oct 2024 09:17:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v3 1/2] nvme/{md/001,rc,002,016,017,030,052}:
 introduce --resv_enable argument
Message-ID: <2c78529c-2893-4891-9768-715e316caddc@flourine.local>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-2-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012111157.44368-2-kanie@linux.alibaba.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On Sat, Oct 12, 2024 at 07:11:56PM GMT, Guixin Liu wrote:
> Add an optional argument --resv_enable to _nvmet_target_setup() and
> propagate it to _create_nvmet_subsystem() and _create_nvmet_ns().
> 
> One can call functions with --resv_enable to enable reservation
> feature on a specific namespace.
> 
> And also make _create_nvmet_ns and _create_nvmet_subsystem to parse
> for arguments, this makes these functions more flexible to use.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
