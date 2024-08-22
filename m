Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838581E50B
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338175; cv=none; b=IDdb0WnlUOSvUtvtzqLevtjImFD2mZzK9smsz0/Vqv1s0kmpsZkwLq0/UYpk65qaNTZnRewHu5QRqOi90yUi531WV+zHDb4lDO57TytdbjGCiFRQepCPkosbqXvYTTkXf9n8Y4P9NuZqlGsqpsi6apPx2LvFOpCRAcFo/bc6VCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338175; c=relaxed/simple;
	bh=f2iyRKBKKaX3JFIDpuapadQ+ukMVRp0JzXMMZ90raes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSmC+32qqp7Z3Jvo32tjjSI49Q0EQXj7U+sJSfyt794W/er34XTRX/EEAJPvaQEhkwiQ0Q34OgJjS0TxFVC9AfCJUPbusZUbSYas4Q1bfevkFDxko2lXFG0fujjwGTbKGKrr7eVaI/PqZw2wYirovAJE1z0vqiQ+LKnMRIMLs6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wBb7pi+N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CFB4b2/R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wBb7pi+N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CFB4b2/R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wBb7pi+N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CFB4b2/R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wBb7pi+N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CFB4b2/R"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0DA8201E9;
	Thu, 22 Aug 2024 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724338165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggKtqnZNjeL9zT8SsU2lZV98oyuVdbTKR0ok42C3gN8=;
	b=wBb7pi+NPQO9/T4tAZZKPIJqZAKGy/idqNt116VWPYyJn1PjU4cINHEjrhoG6+CqFyJ+PP
	nfr6knDEbj8kozWZyAdtYnWlYcBtui0P/bfWhr3DRktf1RDZJYzQ7qhl0UzOaxw1qCNqQM
	oWFw0KO7LATSg4OpLZwPE+OtZjK+RjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724338165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggKtqnZNjeL9zT8SsU2lZV98oyuVdbTKR0ok42C3gN8=;
	b=CFB4b2/RhtB0yMQk67zu4DOURhUb5u9ILnNiWC9Q/IRuz0ajAvigy0+vd82QgCPNx1RDWo
	ja8vHbcPRaX/sHDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wBb7pi+N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="CFB4b2/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724338165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggKtqnZNjeL9zT8SsU2lZV98oyuVdbTKR0ok42C3gN8=;
	b=wBb7pi+NPQO9/T4tAZZKPIJqZAKGy/idqNt116VWPYyJn1PjU4cINHEjrhoG6+CqFyJ+PP
	nfr6knDEbj8kozWZyAdtYnWlYcBtui0P/bfWhr3DRktf1RDZJYzQ7qhl0UzOaxw1qCNqQM
	oWFw0KO7LATSg4OpLZwPE+OtZjK+RjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724338165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggKtqnZNjeL9zT8SsU2lZV98oyuVdbTKR0ok42C3gN8=;
	b=CFB4b2/RhtB0yMQk67zu4DOURhUb5u9ILnNiWC9Q/IRuz0ajAvigy0+vd82QgCPNx1RDWo
	ja8vHbcPRaX/sHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7635139D3;
	Thu, 22 Aug 2024 14:49:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L71/KvVPx2YJaAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 22 Aug 2024 14:49:25 +0000
Date: Thu, 22 Aug 2024 16:49:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Message-ID: <a9a79fc9-6c0b-4a35-afea-85f34e9889bf@flourine.local>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
 <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
 <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
 <wf32ec6ug34nxuqjxrls5uaxkvhtsdi4yp2obf5rbxfviwlqzt@7joov5mngfed>
 <12fa9b5b-8a8b-42a6-9430-94661bfbdd21@linux.ibm.com>
 <wpapwfrmpkwxdqahiwvp5y6l53z2xuidc2qyloolzfundec3p6@vsuen2jtxot2>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wpapwfrmpkwxdqahiwvp5y6l53z2xuidc2qyloolzfundec3p6@vsuen2jtxot2>
X-Rspamd-Queue-Id: D0DA8201E9
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Thu, Aug 22, 2024 at 11:59:35AM GMT, Shinichiro Kawasaki wrote:
> I can agree with this point: it is odd to suppress errors only for the namespace
> removal case. I did so to catch other potential errors that _find_nvme_ns() may
> return in the future for the namespace creation case. But still this way misses
> other potential errors for the namespace removal case. Maybe I was overthinking.
> Let's simplify the test with just doing
> 
>    ns=$(_find_nvme_ns "${uuid}" 2>/dev/null)
> 
> as you suggest. Still the test case can detect the kernel regression, and I
> think it's good enough. Will reflect this to v2.

Not sure if this is relevant, but I'd like to see that we return error
codes so that the caller can actually decide to ignore the failure or
not.
