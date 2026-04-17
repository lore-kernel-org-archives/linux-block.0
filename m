Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F632C957
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404110; cv=none; b=X3rmaPyHLpmrWz2jO8eTwEylHIIh3fvcURrzKMZIMBjFlwDpe1IZBiCMDrsz9wTj+rt2BCvYUMnxkyBhE7M76506yJQMaYvzfO2WSvZZb8pP6aS0rtRcooibLIEmZPrjQ9PoyYhMXS69nyIc9JXLgUktgCwbRH3vurbk2PrCWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404110; c=relaxed/simple;
	bh=LTcb5gJ5zx+09sOu3LyXEYtyqcurFVuPDTyb6Tlz4Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo08nS88z4U3Vt6jSPNuovlb0cG1nB6nft4YmYF2IPsmwAJrZ/gk72jInVWoXkmyyLSLm69xFZ7FghXWuXIA+VoDb0GDITC2aKg+JKYzlxf8O6nc4UCd5x0x7yfX6wrh6SsA0ewpgAR8Ra6kcWOr8YiLJ6OI0arZbFPBsdzlQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=saaCVjsp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0rnlf36F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=saaCVjsp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0rnlf36F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="saaCVjsp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0rnlf36F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="saaCVjsp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0rnlf36F"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EB956A977;
	Fri, 17 Apr 2026 05:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776404107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK7Ebbn3E5XrQfQA5dZs9AyY4fK/9oe7aLDqtF127dE=;
	b=saaCVjspeGPzOl3ZzxNUvqSy+uTMCbpUY0W2Xxu9SDJj3KTDuou97wXxGcM+RH5LUJrvOx
	kTlAGhiI/hstLDLxf9D9NCZgv671APwMno8+sqEjAKLhV3+cEBvcxz5H50ns6GR6bCmbc9
	yQWnW7Bee6gwd1Mky7lQ8x06GDT2xSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776404107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK7Ebbn3E5XrQfQA5dZs9AyY4fK/9oe7aLDqtF127dE=;
	b=0rnlf36FWNY85Xk4U2X20CmpSiM7t+PKmuqn+/88qOnm4iYNxbvd7Q0Eqg5378iNBakTeV
	1yhfOAQFxzRrboBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776404107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK7Ebbn3E5XrQfQA5dZs9AyY4fK/9oe7aLDqtF127dE=;
	b=saaCVjspeGPzOl3ZzxNUvqSy+uTMCbpUY0W2Xxu9SDJj3KTDuou97wXxGcM+RH5LUJrvOx
	kTlAGhiI/hstLDLxf9D9NCZgv671APwMno8+sqEjAKLhV3+cEBvcxz5H50ns6GR6bCmbc9
	yQWnW7Bee6gwd1Mky7lQ8x06GDT2xSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776404107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK7Ebbn3E5XrQfQA5dZs9AyY4fK/9oe7aLDqtF127dE=;
	b=0rnlf36FWNY85Xk4U2X20CmpSiM7t+PKmuqn+/88qOnm4iYNxbvd7Q0Eqg5378iNBakTeV
	1yhfOAQFxzRrboBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EC6B593AE;
	Fri, 17 Apr 2026 05:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yKswFYrG4WlEFAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 17 Apr 2026 05:35:06 +0000
Message-ID: <d2ce48cd-ff59-4ccc-bdc8-690d9b05d4b7@suse.de>
Date: Fri, 17 Apr 2026 07:35:05 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "nvmet-tcp: Don't free SQ on authentication
 success"
To: alistair23@gmail.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, yi.zhang@redhat.com, mlombard@arkamax.eu,
 linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260417004809.2894745-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com,kernel.org,lists.infradead.org,vger.kernel.org,redhat.com,arkamax.eu];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:mid,suse.de:email]
X-Spam-Flag: NO

On 4/17/26 02:48, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In an attempt to fix REPLACETLSPSK we stopped freeing the secrets on
> successful connections. This resulted in memory leaks in the kernel, so
> let's revert the commit. A improved fix is being developed to just avoid
> clearing the tls_key variable.
> 
> This reverts commit 2e6eb6b277f593b98f151ea8eff1beb558bbea3b.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
