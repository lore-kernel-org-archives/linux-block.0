Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBA4A0154;
	Wed,  2 Sep 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358418; cv=none; b=H7SJ8XcjqvLBR136UttXf3slR2Qk7eAewD6BmRFGrluNUZlk4MMYhbvCdZyvKKwEwNlKe84XdreI9XPJ2qkOwQgBTaIcCGeYGNB0l65SSA8CwuurjXtH+jF/NWHw+F/bblMkPTO5MhmrrEQuyr5bmXRNWCZc1e9O74piXLQzPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358418; c=relaxed/simple;
	bh=NHtdNaDKh+5XxrxX7v9drlmVMwNdXRr6HEeMmqq48Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbq4HMCDiUySQvnm6WYXuIYv3En5WlzE2pLJIygoqduiYwc5gO0KsrNyZuLHI9XSm/A/GnInQ3PaUhvSdG0tcL6uV3ypNWOsxE5b/PvS4I2saGOxQ5UTZ5L2ffo0hiWV1375EnMKJs9OLwEylEQhzeiqZYATjO2PWYKxl/cGBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HMc4hAKm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6G1A98Wh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HwOHQTTa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hIGXKIq8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HMc4hAKm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6G1A98Wh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HwOHQTTa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hIGXKIq8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 895FE1F7D2;
	Wed,  2 Sep 2026 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788358410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tec4cGpeOp8thNu/8lIkhabAPNNp/8C0542EKjQVIW4=;
	b=HMc4hAKmZy45gOxl+HvTr2DIoaqHN3PPpXfxAqo9UefyiL+qgwTY4aANEtBI6QLNGOxzXw
	kIhzivKjlIs1pYt9GSfuEdEtPh3WyP0C8e39mfqHIZjWE0MCJPI11Lh6K4F1Yxv56ft7Wn
	sZAej0Ybg7WGMvBJK78Q5PofehYCsxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788358410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tec4cGpeOp8thNu/8lIkhabAPNNp/8C0542EKjQVIW4=;
	b=6G1A98WhKNq/f3Z0s9r9OV1OfZENIVGUllpwdYAk67B3F4pFB8bb/WM0xgwGCNAxnzKpeI
	/cmP1vesXQI7XeBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788358406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tec4cGpeOp8thNu/8lIkhabAPNNp/8C0542EKjQVIW4=;
	b=HwOHQTTaaShtyIGhggTJe+HvgyBSXEm1oEzY2hnUPYbNkPdvix1lXNdcx6jIrHrOjOARQ4
	8Ie5Pf81wpNTQ8v0dIk7nMH/JQ26QkbNBXrq8l3fBomKMWslVbFERiPW2Gd2iOIe1wwSGk
	bd4Q1dx/qO8kiPq9EDjzHdBrD0Eeoeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788358406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tec4cGpeOp8thNu/8lIkhabAPNNp/8C0542EKjQVIW4=;
	b=hIGXKIq8FaXnin2eUQV9zc13gSs9aWDEe6VnjdLoYCVRek2rQ84pAzUQkFushQJbaEocMa
	aF6gutBtyZkH+fCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B9C713736;
	Wed,  2 Sep 2026 14:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 34fVDQYvmGpXBgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Sep 2026 14:13:26 +0000
Message-ID: <aaa82acf-2d8d-4e93-b248-a8fdec2be1c8@suse.de>
Date: Wed, 2 Sep 2026 16:13:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 John Garry <john.g.garry@oracle.com>, Christian Brauner
 <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,columbia.edu:email]

On 8/28/26 3:49 PM, Tal Zussman wrote:
> bio_iov_iter_align_down() drops trailing bvecs with unpin_user_page(),
> but a bvec built by iov_iter_extract_bvecs() can span several pages of
> one folio, each with its own pin. All but the first pin leak.
> 
> The partially trimmed bvec has the same problem. Shrinking bv_len does
> not release the pins for the pages cut off by the trim, and
> __bio_release_pages() only unpins the pages bv_len still covers at
> completion.
> 
> Both issues occur only with a logical block size above PAGE_SIZE and a
> large folio backing the user buffer. On a device with a 64K logical
> block size, an O_DIRECT pwritev() from a hugetlb mapping that ends 16K
> past a block boundary leaks one huge page per call, whether the
> remainder is its own bvec or the tail of a larger one.
> 
> Unpin all pages of a dropped bvec with unpin_user_folio(), as
> __bio_release_pages() does, and unpin the pages trimmed off the last
> bvec as well.
> 
> Fixes: 20a0e6276edb ("block: align the bio after building it")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/bio.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
