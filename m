Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C8748A
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394925; cv=none; b=CPQjm1ua3Mk6zGfIFjxYrXDQkQnVyUkopmo2qVG/G4yMUR+5BoGdlydMhNWVEoqFB1mmFQ1qCegqiLq1KrZZ1VYnINoGuvy12rlrX9rdEeyXugIaFvEhLOgp6KBfN1RbHR9W0rbc5p+XtIk8aRwW3PjAYk7XnjW1SbluPKvffs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394925; c=relaxed/simple;
	bh=dj6Mw+BdRH2AgIz2RAfVbqjEUazeSDKO3KZ6cIPTpyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/W2rhmRJeIzGPJ+oQ1zGY7POl4zSfggmsJsyAg/YZ/2mygTDOW2vILM2gDmAwAqGfyeLkfm0ypVQANOEhc/7LQQvh+i6ooU2RhR6qCGqd60Cs6DzC/P8i7LegyaaiEaeQPXJ9qIeDDftqj+cOfIe/5Qn1QZwitomI2SXNqBs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=abCQLT79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1MBJiYtE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=abCQLT79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1MBJiYtE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="abCQLT79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1MBJiYtE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="abCQLT79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1MBJiYtE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4385722542;
	Fri, 23 Aug 2024 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724394922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=abCQLT79xELVRR16inkZwX8welhqvEj+BmaFbYs6KLSTQhK7SjAj5VDSVaax6xSRmwu1nZ
	gsTbipucZ1dfsPjv+3voUFr7W577qt8Tim2Br3+UrQ6zxIkO4ymlX07sUgjoMhXbUXbyaW
	vT+de0xlowOR7div09LtyNTqPC4Qekg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724394922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=1MBJiYtE5v5WJBnLCpuqTY78QPJmPLiwttA/9faY9tDJoJjxsZXRLLV/8xBTSuAS1CfErn
	vmo5i4rvL/UrYoCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724394922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=abCQLT79xELVRR16inkZwX8welhqvEj+BmaFbYs6KLSTQhK7SjAj5VDSVaax6xSRmwu1nZ
	gsTbipucZ1dfsPjv+3voUFr7W577qt8Tim2Br3+UrQ6zxIkO4ymlX07sUgjoMhXbUXbyaW
	vT+de0xlowOR7div09LtyNTqPC4Qekg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724394922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=1MBJiYtE5v5WJBnLCpuqTY78QPJmPLiwttA/9faY9tDJoJjxsZXRLLV/8xBTSuAS1CfErn
	vmo5i4rvL/UrYoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26C091333E;
	Fri, 23 Aug 2024 06:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JQwLB6otyGaqaAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 06:35:22 +0000
Date: Fri, 23 Aug 2024 08:35:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath
 devices
Message-ID: <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822193814.106111-1-mwilck@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, Aug 22, 2024 at 09:38:12PM GMT, Martin Wilck wrote:
> +_require_test_dev_is_nvme_no_mpath() {
> +	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
> +		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
> +		return 1
> +	fi
> +	return 0
> +}

Just a nit: what about _require_test_dev_is_native_multipath?
