Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475163;
	b=Vkgp6O4y9MyVztkwCY1tbVtzWcF/Y8IpfZkOfclW9xcJzh3nW3MpWR4Q+PVE+/KZpk+J
	 LIk/Stg6k1jZv2g8J9hz2PHqzO7bJ3RG+2KLrQMKOHBjag0l+YnU69HByTCwktKUMmJTm
	 V7igkuIOGLNR/vnshuvC+Z8mznwoWKPLMaeUUMfrAOpg1llx/lmTjp0wvjXagpzNk7xPr
	 6zWHjIwL0b8Z0pupAzm+ceLlZUTkcs5ZuWrglguAq5LgmTBSJ1Zv+8bwizoWNkzHxZK33
	 muLhH4NGNpO2suQjVurh5xzE+LJvDquQLbKATM9XTZXd7t+D7GPwdT3jBADzVv0JUdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475163;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=UKYUnUDB4HS82v4Ki6+e7UnU9jzrpBlJr7WcUw9RCEVrGILlSuZzVrlawBY4Wgg58PdJ
	 /qM+x/AI53rdC4IBbOAzKYrKE3O4/NvtUw1yli/fm74QcscM6wNgB1tm6pFMzGTLx2W4B
	 ad7zmgLzJem1FlGRwNbdvlrACcOsMs66M2TGRAhxla+y47rwbFtv7gRu+pBgp3lHx3tKO
	 KkJnVhm6PUb7Q/aW5ERsqJa9BBkEW2QXRYyJP7x+YrLu+jqYPz3CrT/ZMRxRKDPjUUtUi
	 J84flDaCVM/bLV10anJ+WRRkK+jqWvRuttRzhDrN4RSPS6FKnXcGZKatGn8Pm2mNo7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cMrpVW3h;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YVADMuNF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cMrpVW3h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YVADMuNF;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC3606A31C
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 09:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36BC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cMrpVW3h;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YVADMuNF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cMrpVW3h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YVADMuNF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C72B21CA4;
	Thu, 12 Nov 2026 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=cMrpVW3hg/K3dYZ3kwvxt5uoM6LWDEixdnkjEosMKBhCF5eUx3Jblmd2oBkLo6gSi++LS4
	DYeHrGl4quKc0U8y4kv3TEorHpyAAza1+xLoBcSbTR953t6T1CRxS419GdzSzdjVUG9b8y
	NePlsNB0ghJVj4F5mK4MDrnNXVhhuRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=YVADMuNFmoFfyl9EJYMlJdJ03wGKRVLX13OaggLAb+KCbOrjxPve0NYqwRY/7z8zYu8r8Q
	vxvy8QNpI//Kx+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=cMrpVW3hg/K3dYZ3kwvxt5uoM6LWDEixdnkjEosMKBhCF5eUx3Jblmd2oBkLo6gSi++LS4
	DYeHrGl4quKc0U8y4kv3TEorHpyAAza1+xLoBcSbTR953t6T1CRxS419GdzSzdjVUG9b8y
	NePlsNB0ghJVj4F5mK4MDrnNXVhhuRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=YVADMuNFmoFfyl9EJYMlJdJ03wGKRVLX13OaggLAb+KCbOrjxPve0NYqwRY/7z8zYu8r8Q
	vxvy8QNpI//Kx+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34560134A0;
	Thu, 12 Nov 2026 09:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tk11BpmE9Wo3ewAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Nov 2026 09:19:21 +0000
Date: Thu, 12 Nov 2026 10:19:16 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 00/10] nvme: make NVME_TARGET_CONTROL work with
 remote targets
Message-ID: <4352fde1-faca-41da-bac0-9106a4e5b1c9@flourine.local>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
 <avREkjfeJjzFg-0x@shinmob>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avREkjfeJjzFg-0x@shinmob>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Nov 11, 2026 at 07:36:31PM +0900, Shin'ichiro Kawasaki wrote:
> Daniel, thank you for the series. I walked through the patches and all look
> valuable. I applied first six patches. I made minor comments on the two patches
> out of the left four patches. Please see if they make sense for you.

Thanks, yes sure, I'll update the remaining patches.
