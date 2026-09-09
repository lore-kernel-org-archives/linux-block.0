Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECE4A99A2
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943931; cv=none; b=evJdKaBJ/Vt5LxbM/vADi6qRtCtFylT+truHqf8G2p9vfMQHk9ygBUdQOod7g0dYpzXgqTuIfjPz30JKxGx/6knGdL1WbiJjgBZn+V95lT3W1FJytah3LM+nIz8RE523DBQd76NIAjZVOMrYQgCMkDS89j8nNXAgUL7qbQwL2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943931; c=relaxed/simple;
	bh=99dVN8GNKhcdE+n8BI2qiM/TXXMkD4sJVHWmjQjQPlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQRyiScG7E6vXlpGGSOLx5MH3ZmKEw7OGGNZDi/+ZfNa3MgPgLhPuv5CM2fxmPP8mh9QuUho5swiNOPw2ptwJQo5Zd3fXXatvCfRKQdZKQs3S10VFLZY02m/OSv+V17ZxXmtavtX+jlPwnaUshggPdoJ5vxVQ8q/9ZeZ/oiLbbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ba5iYQub; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aTG8barI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=heLuJ1GB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yidL8bc+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ba5iYQub";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aTG8barI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="heLuJ1GB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yidL8bc+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8EB621AA7;
	Wed,  9 Sep 2026 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788943921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku4YXSvFBCnIKycvyUjXu7vCZTKqtFh3RAqCbMbgWfc=;
	b=ba5iYQubpGhR1RHAg2p91N7JMXoue+cNjFADrRHS+NcrjKL3ISLgzEKD+cryxh5hCVPyRE
	sYXpST9ktDWz+JRCeEw9qFsvlm+qlBzuTGS+izTUWCh5BS955M8QLFSve82pznYntCgmOh
	VnHuE4eYnreNns1mO4ahQhvG4f3ph8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788943921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku4YXSvFBCnIKycvyUjXu7vCZTKqtFh3RAqCbMbgWfc=;
	b=aTG8barIICPtemaxM+7IbB5i1cUHKrdKOwYAQsC/6Ajtntc1YZjbN1qs/ehjKJe9vWfkT6
	d4GAj2H447cjzNCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=heLuJ1GB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yidL8bc+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788943916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku4YXSvFBCnIKycvyUjXu7vCZTKqtFh3RAqCbMbgWfc=;
	b=heLuJ1GBHgEVPMNr+lw329L579+BFHbcpwRdhKlYO8DX3luB0F9Sf76UG4Mg/egBjpzaut
	cdg/9tBu8juI/qUW6RlvKnHTsf/HDicIUChx71bIVpyJa17fPo94UNs1Op6PTI6nvFS+zR
	tMK7aOvF8WpV4G4kIhuON9oXOoy+a90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788943916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku4YXSvFBCnIKycvyUjXu7vCZTKqtFh3RAqCbMbgWfc=;
	b=yidL8bc+DCu992AocbVkINOsjTY6wDqHbicE9XY4v/DsvInpHVPiShpY+ucNHJQnjyKDIz
	n2ecQ+X+pbUTRlCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEDB81347F;
	Wed,  9 Sep 2026 08:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6C7wLSweoWo7SwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Sep 2026 08:51:56 +0000
Message-ID: <82b50cc6-45b2-4344-9c25-afeb34e01728@suse.de>
Date: Wed, 9 Sep 2026 10:51:56 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] block: improve capacity handling during zone
 revalidation
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
 <20260908085745.1082697-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260908085745.1082697-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: E8EB621AA7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/8/26 10:57 AM, Damien Le Moal wrote:
> While executing blk_revalidate_disk_zones(), a disk capacity is looked at
> using get_capacity() several times: on entry to
> blk_revalidate_disk_zones(), when allocating zone revalidation arguments
> in disk_revalidate_zone_resources(), while validating zones in
> blk_revalidate_zone_cb() and one last time at the end of
> blk_revalidate_disk_zones() to check that all zones have been inspected.
> 
> Since this is all done while passthrough commands can be issued, it is
> possible that a capacity change operation (e.g. the removal of a storage
> element on a SCSI or SATA disk) is concurrently executed, potentially
> resulting in an inconsistent or conflicting revalidation with potentially
> out-of-bound accesses to the zone condition array.
> 
> Prevent issues by using get_capacity() once on entry to
> blk_revalidate_disk_zones(), remembering this capacity as a field of
> struct blk_revalidate_zone_args and using that field while revalidating
> zones. A final second call to get_capacity() is done at the end of
> blk_revalidate_disk_zones() to ensure that the disk capacity has not
> changed, thus revalidating the capacity (and number of zones) itself.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
