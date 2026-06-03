Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4B37D125
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451200; cv=none; b=byoNWt0Uhzkaqzlzr3Y+8EQiYiYwRbidqukZUb1+cn3wMlBr80BbTy1Qm0Me4OGE+8U/48VwX0wjNotA9tmImxrtlVEAQrsHr3gopW2FiAZBPS0qoPqPP5KAipNxcdGz1Zvv/dz9qps+9Y+6ZUR4pbWuh/cqJ6tqgO42ZhCepkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451200; c=relaxed/simple;
	bh=3ulVXFv9c/nNbuQQNMh/IsHoDdXVDmON7EAnD0WXXT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGrs1KA1MHAoZPNXye3PmG9sJq+/nAyhcCuL+UqhZMr2rvPz+/M7zQUAKaEMgJ6cQag70OzoUgs2ny4/g6WBqoWO+pnA1FzGl4r1ErnQw8tW5/OnqHvGjzQHZ9583IRijANfo5tdJKpic/H8r0XKzDNWZO0eumKMKNuRH3z0zG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BKzc4xNM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q1QPiCW9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GBRAIgb8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z1DgQ/vj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BKzc4xNM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q1QPiCW9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GBRAIgb8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z1DgQ/vj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 886D76A81D;
	Wed,  3 Jun 2026 01:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hA5g9G78oXhsk08XzDJ+rdECFV5E2j3+Dtwxio+XLQ=;
	b=BKzc4xNM8f2SL7DgdKKCfhLMcENDUtNMDzuZIW/diGIjeQ7i4bFCkNtzi3e/ATX0pQEoVf
	J9nAIvEtA/NMVcuSp4kp8nkZDkUr/WvpNBW/3ih/alqhGo3Nox3qIen5TZ5zvz8N4DFvVS
	plX6gXyAQCg/vMFm1YnbgMvdqOv6z04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hA5g9G78oXhsk08XzDJ+rdECFV5E2j3+Dtwxio+XLQ=;
	b=q1QPiCW9yr6s44K/I4TE5OIt5x+37aDKU0JaJ3/+W0m78hedLLLAekEYxM5xex+769NZbu
	NUKV+fmLBgTNI0BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hA5g9G78oXhsk08XzDJ+rdECFV5E2j3+Dtwxio+XLQ=;
	b=GBRAIgb8QPNy4J7wMhbJa5osMwasIRDCyzqQ9agXX1Ut1DtV5hXJmUtL6xv8MmghbhdOe1
	QtmwAI8Sz8eIWqCkbRgG8VsnIguXkcRKaBf66PUsIQLfau3UESP7g+IeeieS7KgOH3vimz
	tBeAUE/aqL8FvU5EhqTI7hXE5Zxj4R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hA5g9G78oXhsk08XzDJ+rdECFV5E2j3+Dtwxio+XLQ=;
	b=z1DgQ/vj37JFwJvKuNsBbySwbKP/6XAtu50IoSDcwsudgSkFN86330r5kaWx8TwITwTy4f
	4tTgdJPGSFo7eSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B40E9779A7;
	Wed,  3 Jun 2026 01:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7j7GH3qHH2qZawAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jun 2026 01:46:34 +0000
Message-ID: <a5513b0e-61e1-4859-a7e0-3e7d2149a705@suse.de>
Date: Wed, 3 Jun 2026 03:46:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/14] block/blk-iocost: Combine two error paths in
 ioc_qos_write()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
References: <cover.1780419600.git.bvanassche@acm.org>
 <fe85b8a3117486e3d1fe40b16d7c9621a070499a.1780419600.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <fe85b8a3117486e3d1fe40b16d7c9621a070499a.1780419600.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,acm.org:email,imap1.dmz-prg2.suse.org:helo,lst.de:email]
X-Spam-Level: 

On 6/2/26 19:07, Bart Van Assche wrote:
> Reduce code duplication by combining two error paths. No functionality
> has been changed.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-iocost.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
