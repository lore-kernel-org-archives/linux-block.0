Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69443B6D9
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447832; cv=none; b=E4hWjOYMZdVPUKUwdji4uI0KLSsCD5YMsF5D9aQHn9Sx2u0RZo4f/EN/cv4BE3V2vz+1aVDfvzOIzQcr6H9dcxVvXnMhGaAcXS2Kv3+TryHbsBahLwjGR8/QGisxC79zBxjR5w2fAUqeJeBlcDn5S53W2GXaWFgZO5Y+NSwmMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447832; c=relaxed/simple;
	bh=iTSZmJ3OglWj6Xx9ywzPOrAWrYdinNQFx031/UMSlls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agl1XB5QsJydnf41tzATQgVdENwsIk1EvMiv/rfpOa22nrX4u2+ZFSqNlgO++JAbV96ghvOLQwmoqAlyD4JfG5w+U4SJKIrONq90MDOpk7LPRZQB3YCmhqB9Y0nEfI/ytx3zu6V1EcLBccclKBqS4e1ZKqBqC2uZoyAnxj4LXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZCCogTdO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ro3qw3Yi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p8/Tsb/K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jzdh05Nw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZCCogTdO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ro3qw3Yi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p8/Tsb/K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jzdh05Nw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA30F3DF2;
	Tue, 11 Aug 2026 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmG5n1Lq4NfCp8b7NfXGwsQoD0/tR+7ahO0MSrMUREk=;
	b=ZCCogTdOLdIuaP3rLppx2iSjiKHxC5gyabWVWbCcECR+8SfNoJI84am2sYnZJW2d93FiPW
	fprFWC4L5+yM/yWbZ5v8Vvd/hdU0gCQwXmGHU6AhPpFJ8WUJNCuNmv0cBicPYZLz9N96ls
	joMe4aX0UQ0SiNvCTIdqBrK2lycXqDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmG5n1Lq4NfCp8b7NfXGwsQoD0/tR+7ahO0MSrMUREk=;
	b=Ro3qw3YikhtJfbxTDJ0OvdM1cIVYiwv6UpQk2i2m+farDEl+etZVJ5wGktUC5GKR/hoJ0l
	bfMBV3FSz8pDZGAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmG5n1Lq4NfCp8b7NfXGwsQoD0/tR+7ahO0MSrMUREk=;
	b=p8/Tsb/KwW7hsgHWVLPN6bxOUXhHD3d247LlnYKxTLVP13f4F0ErigrlDRpHgze/VdTIrL
	cdqgNOov52wHRNxMRI60uEkz8JSvCs9zRvdYsdMxT3MWIRHzAYawiBRDS+M6RlSsUYGdHJ
	JfhgDyYB4svsiF0f1O06ohQmg6csfQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmG5n1Lq4NfCp8b7NfXGwsQoD0/tR+7ahO0MSrMUREk=;
	b=jzdh05Nwm3E+HmYMO+GBpG1qySI/sX0moboafxTLpHTw/OjybdCR7qbubVObs65s68uH7m
	gJ30UhCoLTXJ2PCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 998D3779B2;
	Tue, 11 Aug 2026 11:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FWOxJMwHe2r7cQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:30:20 +0000
Message-ID: <b7b87bb2-d3bd-4575-9c5f-b947088a8edf@suse.de>
Date: Tue, 11 Aug 2026 13:30:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] block: refactor bdev_zone_is_seq()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,acm.org:email,imap1.dmz-prg2.suse.org:helo]

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> Define the helper function disk_zone_is_seq() and use it to refactor
> bdev_zone_is_seq(). disk_zone_is_seq() is also used in
> blk_zone_wplug_handle_write().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 38 +++++++++++++++++++++++++-------------
>   1 file changed, 25 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
