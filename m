Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607602C026C
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994358; cv=none; b=C+jBvqB9qOIrofsJD9WZsmuhZxKKO/I5ALltROzbsKhoIc/0OqRHcuWjSjasE9weMQo7POUebnrrOnb51vmSF42Y0mRRuLhS7crx3ISWcaqaLqxM+s0j9nN3d9j3uh1hPqouKYGaphXcnr43PZ0IrQmLKePLd7I/TDCS+I8oEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994358; c=relaxed/simple;
	bh=g2Dtdu31Q6EjuqTdgqME8+k/2Xk2pS2KiMakBfq8Nrs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=AM+YpXMKRuiDFtjolq70CUu6oiMpfu3mC3V7Wa/uaT8l3MKxBlCPI5Q0svNp/8puKSbIjdjlr36vynt9DcDXHvXgdRlrKF+geIVz/jrY6a6B0ihoRVAQIIk9mMw7t5gCquQ6ayI8cRfbWO+QUiDxkDTZ6E3LKeS5YwHqGnQASMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TCwSnJWP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDm0R6OU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TCwSnJWP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDm0R6OU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TCwSnJWP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDm0R6OU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TCwSnJWP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDm0R6OU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EF2C6A94A;
	Tue,  9 Jun 2026 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780994355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYTSEUpyRHXi6AWFKYm6EqChmTlEFt8HMvlLwS3A0Eg=;
	b=TCwSnJWPvMkkV4k++fy0KkUy0ftecyvbHp+HnOC0Wt/rfgnV8cRy8I9Vk3dGW+yvMJFs/r
	q8xZyFyJQ4eERg8uSeZyzGlvkGykBVvgrjcyoIs+3d2K0LmJi/z4GIEsq6DnYlUU1qXZtJ
	Ju2PX4R1/DwG4WAvMquDGQ/nG9OCLgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780994355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYTSEUpyRHXi6AWFKYm6EqChmTlEFt8HMvlLwS3A0Eg=;
	b=JDm0R6OUBiKsd4FWsmYnwKzIpyX+Xgl8dPrxf7pRIKHVKVB1HlZ+LDS439CeqkW+xzjK7V
	Jzw/FyjpwxAN3cBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780994355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYTSEUpyRHXi6AWFKYm6EqChmTlEFt8HMvlLwS3A0Eg=;
	b=TCwSnJWPvMkkV4k++fy0KkUy0ftecyvbHp+HnOC0Wt/rfgnV8cRy8I9Vk3dGW+yvMJFs/r
	q8xZyFyJQ4eERg8uSeZyzGlvkGykBVvgrjcyoIs+3d2K0LmJi/z4GIEsq6DnYlUU1qXZtJ
	Ju2PX4R1/DwG4WAvMquDGQ/nG9OCLgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780994355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYTSEUpyRHXi6AWFKYm6EqChmTlEFt8HMvlLwS3A0Eg=;
	b=JDm0R6OUBiKsd4FWsmYnwKzIpyX+Xgl8dPrxf7pRIKHVKVB1HlZ+LDS439CeqkW+xzjK7V
	Jzw/FyjpwxAN3cBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671E0779A7;
	Tue,  9 Jun 2026 08:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tV6GFzPRJ2qCbQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 08:39:15 +0000
Content-Type: multipart/mixed; boundary="------------wt00tw0FsDqgDAYD0X0A5sJf"
Message-ID: <1225376d-dc29-44a1-add6-0cb14926a538@suse.de>
Date: Tue, 9 Jun 2026 10:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
To: Christoph Hellwig <hch@infradead.org>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <aifAm1rRKF75HVeM@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aifAm1rRKF75HVeM@infradead.org>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

This is a multi-part message in MIME format.
--------------wt00tw0FsDqgDAYD0X0A5sJf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/26 09:28, Christoph Hellwig wrote:
> Hannes,
> 
> can you share your results on the mailing list?
> 
I sure can.

We have run a simple testcase with on fio job on an LBS-enabled device, 
and another job permanently allocating and deallocating arrays of pages
of various array lengths.

We then took snapshots of /proc/buddyinfo to track memory pressure
over time.

Results are visualized in the attach plot.

With 4k block sizes we have seen a high number of 0- and 1- order pages,
and then the expected decline towards higher orders.

With 8k and 16k block sizes a noticeable 'bump' in free pages was 
developing in 2- and 3- order pages, which we think is down to 
compaction trying to merge pages together.
The number of 0- order pages increased slightly, but only half of the
maximum number of pages in the 'bump'.

With 32k block sizes the picture changed completely; the 'bump'
vanished, and there was only pronounces spike with 0-order pages
(about four times the size of the spike with 4k block sizes).

This led me to assume that compaction broke down at 32k block sizes;
this assumption was confirmed by Vlastimil Babka who pointed out that
there is a maximum order to which page compaction is attempted:

include/linux/mmzone.h:
/*
  * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
  * costly to service.  That is between allocation orders which should
  * coalesce naturally under reasonable reclaim pressure and those which
  * will not.
  */
#define PAGE_ALLOC_COSTLY_ORDER 3

and it's main usage is 'order > PAGE_ALLOC_COSTLY_ORDER'.
Which ties in directly with what we're seeing.

It will probably make sense to align the maximum block size which we
currently support (ie 64k) with this value to ensure that compaction
works with larger block sizes. Or maybe even the other way round;
tie the maximum block size which we support to PAGE_ALLOC_COSTLY_ORDER.
But that would mean to restrict the blocksize to 16k, whereas xfs
works happily with 32k. So we might want to raise PAGE_ALLOC_COSTLY_ORDER.

Question is, though, how could we measure the impact?
This particular value has been in since 2007 (commit 5ad333eb66ff1 
'lumpy reclaim V4'), and it might well be that the original
reasoning doesn't apply anymore.

At the same time, this value is tied to a _LOT_ of things
(not to mention the page allocator itself), so increasing it
to '4' has an extremely high chance of impacting mm performance.

I'll probably run mmtests and see what I get.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
--------------wt00tw0FsDqgDAYD0X0A5sJf
Content-Type: image/png; name="fragmentation.png"
Content-Disposition: attachment; filename="fragmentation.png"
Content-Transfer-Encoding: base64

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
siQAAAAASUVORK5CYII=

--------------wt00tw0FsDqgDAYD0X0A5sJf--
