Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5815ADBD
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961772; cv=none; b=KV6sE/5xGNjro6+nCiB6jEv0RBe0ZQqbrjIfXkyDl74zV2tceaW65gUPinlUjMkbbgPogMTyRzKRFZsSrmaNNfEZMTVRXu26aIRgOHrnFEBBWH4p3MIYWDPE3RWAZPxPijc1jRdBYBfIM9B9qc00uHgiD8YixSZm2+XHiEDGNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961772; c=relaxed/simple;
	bh=1ElmhQ+uIWCkDkhQDs7ddN3AVb0ZDeVHt4ROvwFSJ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4cYTMsYgJ/9eFU6U8+v3YyRPReV94GciS0nT8+JUzYo4p3Y3DYy34JEKC3HEN4fU0Zg8m5Ez2knhFGzo1GgyKH/FzqHaRx09FT/tQ0ioyfgHlAvJfstVTT5Qp0NzYuaWL6C1b17b7HKHvMe3S8O3mrZtbF8utUa/o9hc29kkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oJCaTZyN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4DxDEY4w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oJCaTZyN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4DxDEY4w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oJCaTZyN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4DxDEY4w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oJCaTZyN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4DxDEY4w"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBB843F290;
	Wed, 24 Apr 2024 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=oJCaTZyNOdotqXkKeRmbSJHay+nxTBULh9URIyOyn/IB9g0H2zB448DZg8mpkPko1OuWQS
	Hqdm4otskDlRR0/3ynQC4qxzbZsofIFHoxM2hQHNHoa3KCOdline398ehH1vGXyoL+Zwyb
	Yx2RxesFckHBRPT5IdvVMff+JGgk2c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=4DxDEY4w6zinoUMafkLD1z4MhwLvYrujEqYDLF+XidWvbPikO99wl2v65mskkzff9vXe7e
	3AwRmBTk/nCRdtAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=oJCaTZyNOdotqXkKeRmbSJHay+nxTBULh9URIyOyn/IB9g0H2zB448DZg8mpkPko1OuWQS
	Hqdm4otskDlRR0/3ynQC4qxzbZsofIFHoxM2hQHNHoa3KCOdline398ehH1vGXyoL+Zwyb
	Yx2RxesFckHBRPT5IdvVMff+JGgk2c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcpT/vytrf890n1gAXnicwP1sw7mmYjErBiGRedM+s=;
	b=4DxDEY4w6zinoUMafkLD1z4MhwLvYrujEqYDLF+XidWvbPikO99wl2v65mskkzff9vXe7e
	3AwRmBTk/nCRdtAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3BF1393C;
	Wed, 24 Apr 2024 12:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3LW9Kij7KGYAbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:29:28 +0000
Date: Wed, 24 Apr 2024 14:29:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 13/15] nvme/{rc,010,017,031,034,035}: rename
 nvme_img_size to NVME_IMG_SIZE
Message-ID: <rebzjpljyehrqst2ulhb2mler6gr2rjgzqmap6hqd2aeqscgf7@v7a2g2kx7iu4>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-14-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-14-shinichiro.kawasaki@wdc.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]

On Wed, Apr 24, 2024 at 04:59:53PM +0900, Shin'ichiro Kawasaki wrote:
> To follow uppercase letter guide of environment variables, rename
> nvme_img_size to NVME_IMG_SIZE.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
