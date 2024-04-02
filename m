Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5017F7D9
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063850; cv=none; b=Xof/BfKI46Bxo6THDggIB1Fc9hL2sQq63x3iWgQ+F5/7kjsalQq4WI9yHIiSJj8G+6MOxZDjteaRl6QGsu0bX3B7KtljvEji+P7RJ3T0zdPHzEx/k0R/NpUTtm3CFsXC1a+XrVPOgKtjdcoJNNup2lGW5eeNiMQqA2GJCQJ+pgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063850; c=relaxed/simple;
	bh=gU7RSku9ugKvYv+cx4eEIpxy74kppbAUFDXOS3l8bjI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aMJNTvGh+h45xysIws+GsBp3kJ2QU+3qz/40iUsjymqzzN1siqa4AMHBm/dp3IH0OJ+QuHM/i3ZIwhlYwgqa7lZ5Jklb0peCOVfA28s8GF8+k1yxNyfGIQNgF3TWrmZTqrPyfIYUqmmzhIg+xt7iVSuwCRkbIXbA51s8NWw/SkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cpDRzQyt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=duvnUd70; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cpDRzQyt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="duvnUd70"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38E5A5BD81;
	Tue,  2 Apr 2024 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712063847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R9GTArm8kRN76r2cTxKySda5qsFDVYUnqyYSvXtki1s=;
	b=cpDRzQyt//fIvf5enYFyeEbMvVT+pRtqMQIRnKZ4a1eeA1Ac9BTbg+kAHugnf/FtLYQF4M
	MFvxJhJn2iYYZL6Uwz54kx09mHD1HFE7ydbVSwDK6MXDcso2VmDJyHmEhcdVFz2pKMo6me
	+CUq4suWRIZHLY1k1PbUBF0LcnaOQoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712063847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R9GTArm8kRN76r2cTxKySda5qsFDVYUnqyYSvXtki1s=;
	b=duvnUd70H/iy9Cnl0LTnn1wm6pRtIlWFvXT0pjgNZbGJdWo+/3KGRrOJwsE0CheF5gHpZz
	juGhc1IGhGRUi5Ag==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 24EFE13357;
	Tue,  2 Apr 2024 13:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0upMB2cFDGYTUQAAn2gu4w
	(envelope-from <hare@suse.de>); Tue, 02 Apr 2024 13:17:27 +0000
Message-ID: <0cba8c5d-f014-4e48-9a6f-7724cf939c5c@suse.de>
Date: Tue, 2 Apr 2024 15:17:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Subject: Oddities in brd queue limits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.30 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.01)[51.28%];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -0.30
X-Spam-Level: 
X-Spam-Flag: NO

Hi Christoph,

brd ends up with the following queue limits:

optimal_io_size: 0
minimum_io_size: 4096
hw_sector_size: 512
physical_block_size: 4096

which I find particularly odd; how can the minimum I/O size be _larger_ 
than the hw_sector_size? Wouldn't that imply that we can only send I/O
in units of physical block size, rendering the hw_sector_size pretty 
much pointless?

Or what is the idea here?

Btw, I would have expected brd to set 'optimal_io_size' to 4k, and
minimum_io_size to 512 bytes. Which would've been an alternative fix.

Cheers,

Hannes
