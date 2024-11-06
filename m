Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24721DF24E
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895212; cv=none; b=BfInhE2SWRe9/O/nGOvy546pjnJDw4waF3WxAy4fbp8lJCJDV+uhHehg2LSU64gkiKpcfeR1UesZx/ar2o0iLTxb/w53R+MvkEBdW8k2lxlzHxPCrYckmwObBu0UyzRKyjLO9Xib9Y0MWTccONNQvIfev9evoyjoLfntfpYaW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895212; c=relaxed/simple;
	bh=QCzMudaqCFQBsXTX183m66jNueombJexDowIONuXSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEKGFYCPzrCJtoCXhXNbrWF4oDzNmmEv2/SdzeOGwlCRvIODn6UCyeM02j7UhdJSlUeYPDUoZSBTU4xovzPXp8lOsOURBSxo1D43/EgXRPN7c9L9A7ab+mCTKdij1wLGZXalBNqJ+HwbwYIK5HPA/cNnnWRfLMLbbqG/P5WJbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wnmf3blw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F0jFHq5a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wnmf3blw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F0jFHq5a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wnmf3blw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F0jFHq5a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wnmf3blw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F0jFHq5a"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03A5A21D0E;
	Wed,  6 Nov 2024 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730895209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EPCGJmmRz6nsod0tevdIbpKFk1pNnTSHCOl1Coo2yJo=;
	b=wnmf3blwWP3iMULlcDKfIoi3bmXZJ7M8iSX77Wv37poZC4+FcPz2NK0DwYGUzTM0ohdfaA
	aoz2nagyIGtDK5XaKMcw8pbVfZXpT93GP3xkUpJes+GCroTAmuhsr1gOTHrcxJ8gXWVbP0
	wU5vj9g5J6Xl1ONIYYjIx222Pgi1LIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730895209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EPCGJmmRz6nsod0tevdIbpKFk1pNnTSHCOl1Coo2yJo=;
	b=F0jFHq5aDHcLOIq3rUObgrEk24ZAx0t4G7oMw9DfosrmwOzjAxC6n2Xu6alM6S5Japnnz5
	1LjdzhvLwIzBD+Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wnmf3blw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F0jFHq5a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730895209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EPCGJmmRz6nsod0tevdIbpKFk1pNnTSHCOl1Coo2yJo=;
	b=wnmf3blwWP3iMULlcDKfIoi3bmXZJ7M8iSX77Wv37poZC4+FcPz2NK0DwYGUzTM0ohdfaA
	aoz2nagyIGtDK5XaKMcw8pbVfZXpT93GP3xkUpJes+GCroTAmuhsr1gOTHrcxJ8gXWVbP0
	wU5vj9g5J6Xl1ONIYYjIx222Pgi1LIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730895209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EPCGJmmRz6nsod0tevdIbpKFk1pNnTSHCOl1Coo2yJo=;
	b=F0jFHq5aDHcLOIq3rUObgrEk24ZAx0t4G7oMw9DfosrmwOzjAxC6n2Xu6alM6S5Japnnz5
	1LjdzhvLwIzBD+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCCA6137C4;
	Wed,  6 Nov 2024 12:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8WaQM2hdK2ctCgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 06 Nov 2024 12:13:28 +0000
Date: Wed, 6 Nov 2024 13:13:28 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme: test nvmet-wq sysfs interface
Message-ID: <ed4782f6-8fb1-464c-afd2-e03c51030768@flourine.local>
References: <20241104192907.21358-1-kch@nvidia.com>
 <5d603860-33be-42a2-86c9-a10c224c813d@flourine.local>
 <bd5ea038-42ab-433a-943f-d385ccd96770@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5ea038-42ab-433a-943f-d385ccd96770@nvidia.com>
X-Rspamd-Queue-Id: 03A5A21D0E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, Nov 06, 2024 at 03:46:26AM GMT, Chaitanya Kulkarni wrote:
> On 11/4/24 23:02, Daniel Wagner wrote:
> > On Mon, Nov 04, 2024 at 11:29:07AM GMT, Chaitanya Kulkarni wrote:
> >> +# Test nvmet-wq cpumask sysfs attribute with NVMe-oF and fio workload 
> > What do you want to test here? What's the objective? I don't see any 
> > block layer related parts or do I miss something? 
> 
> For NVMeOF target we have exported nvmet-wq to userspace with
> recent patch. This behavior is new and I don't think there is any test
> exists that runs the fio workload while changing the CPUMASK randomly
> to ensure the stability for nvmet-wq when application is using the block
> layer. Hence we need the test for latest patch we have added to the
> 6.13.

Though this is not a performance measurement just a functional testing if
the scheduler works. I don't think we should add such tests
because it will add to the overall runtime for little benefit. I am
pretty sure there already tests (e.g. kunit) which do more elaborate
scheduler tests.
