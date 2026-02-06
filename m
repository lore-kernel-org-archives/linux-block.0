Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646A1096F
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336505; cv=none; b=sK4gSKuVQWWzIKYetvjLoDtF6Opx7ScjHGo6yS/J16kxBwgBIaV1X1MifciWaLEkwL4MmkToFmwuZeGx89HleTKOSF3XCK5N2Pe3A8xcf3aa/ySqPaDzpOWmO0IXaCkyyZjBu+avfdnYqrpxmMtPV/93iTHPb9MQlM6xm4xlOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336505; c=relaxed/simple;
	bh=Ar0ghAe3HHI/FpUT9DurknG7SCsv2kFPuFerf/OnPOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTHAsUHqko3QrPNvGtAzy4L7iOVnZ8daLbtvk+67xA7rNGP1HZs4XIojDz1R7g1px4x1pV5WO8fKH2XihaWa6kZjBpgb2yqbqogGmy10FnLpwZowuxpHJkyA8xa3XGJhtGTCTl7NW1n3A7vBridE1C6haFy7cQdButB+8ZJ1PU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rXaEm/P1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bewjOHxg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rXaEm/P1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bewjOHxg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXaEm/P1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bewjOHxg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXaEm/P1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bewjOHxg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F3903E6C2;
	Fri,  6 Feb 2026 00:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amFMskT0Goxa3dbwFWOouMPmr4TcQrv4pDnHulcPRVY=;
	b=rXaEm/P10xZdk0K+oIxTv4pGECv4U5DlnkWvXSxCGmsnnJp6G8anvb6QrOxlqhR7M+vqmN
	DXmUN1r4zHRsgas+NGTSudBuYt32d/6ySh3VaDTemlAR2rS6qDdenL8EmY3QKauO2o0QOO
	qe5ikEkBppATjgKgtMB+3LaIC0cN7dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amFMskT0Goxa3dbwFWOouMPmr4TcQrv4pDnHulcPRVY=;
	b=bewjOHxgOM/kdtFt61HAk+/kJhVETu9KIshJtnzm0MhcUTBTs6T15MOzBjffZScSOlg+DV
	ShYArZMkjJ7UUeCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rXaEm/P1";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bewjOHxg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amFMskT0Goxa3dbwFWOouMPmr4TcQrv4pDnHulcPRVY=;
	b=rXaEm/P10xZdk0K+oIxTv4pGECv4U5DlnkWvXSxCGmsnnJp6G8anvb6QrOxlqhR7M+vqmN
	DXmUN1r4zHRsgas+NGTSudBuYt32d/6ySh3VaDTemlAR2rS6qDdenL8EmY3QKauO2o0QOO
	qe5ikEkBppATjgKgtMB+3LaIC0cN7dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amFMskT0Goxa3dbwFWOouMPmr4TcQrv4pDnHulcPRVY=;
	b=bewjOHxgOM/kdtFt61HAk+/kJhVETu9KIshJtnzm0MhcUTBTs6T15MOzBjffZScSOlg+DV
	ShYArZMkjJ7UUeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A0DA3EA63;
	Fri,  6 Feb 2026 00:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5m7JA/UwhWnNPwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Feb 2026 00:08:21 +0000
Message-ID: <2ab48f41-3130-45d7-a7df-5da48e1a8f2d@suse.de>
Date: Fri, 6 Feb 2026 01:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] sed-opal: add IOC_OPAL_REACTIVATE_LSP.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gmazyland@gmail.com, jonathan.derrick@linux.dev, gjoyce@ibm.com
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260205150935.238137-5-okozina@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260205150935.238137-5-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,ibm.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 2F3903E6C2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 2/5/26 16:09, Ondrej Kozina wrote:
> This adds the 'Reactivate' method as described in the
> "TCG Storage Opal SSC Feature Set: Single User Mode"
> document (ch. 3.1.1.1).
> 
> The method enables switching an already active SED OPAL2 device,
> with appropriate firmware support for Single User Mode (SUM),
> to or from SUM.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h            |  1 +
>   block/sed-opal.c              | 99 +++++++++++++++++++++++++++++++++++
>   include/linux/sed-opal.h      |  1 +
>   include/uapi/linux/sed-opal.h | 14 +++++
>   4 files changed, 115 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
