Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F02277021
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529365; cv=none; b=K3TvrymLEEqe27+Mk2S700wtkAVFAQpVdERoyRAD9PdBh5ze9eVInrV0nnMsdcsgHJRMR6yvDt4PaSKaRtXNIfiseVgAV06l3rt1d2HoeadIpB4tDdGSz7EkgxK4+vyjyeOb8UM0I66zbXMcPDEa/vhBMV+6gM37G8LzTgDcbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529365; c=relaxed/simple;
	bh=7FCW6vQ4U7yRzos9ss0mw5rwx8t1TrET1ek7Nkuo0Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSUtZqta2rJOKZ8NAsG7xJ2xPgzrnpqR46YhuMW3nRoJE1AfoYTSBYfWoTT46H1/aRKYF2RUHd3X9LLIyEAkZfwdr2Y+BP2UOQYiZ5dKw7ytuyG0Bp6qad+MSls/AEtfh+z8EWKtUGiSBf6WoCtMkt7VxM9yy+H+YHLAAEczsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2WjkCrQn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sq+RehYr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2WjkCrQn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sq+RehYr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2WjkCrQn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sq+RehYr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2WjkCrQn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sq+RehYr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCC0221274;
	Tue,  6 May 2025 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746529361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FzRaQG+m4US7EegwgjdKSO5VaqO1brTo3KT3juQL+A=;
	b=2WjkCrQnflqr6Ej+d7nqpX1V+OtMP0QYFATf2MX1zHqW/0ozZ0Dbjpa5a2HFue7KssdN8r
	WnjiyspcQV43RsMUW3nudaLqsPFdmDBO5Aj7Sy9w/2rorvB32kCs2gHdspXcy5GCQ5Xngm
	QatfZrXqnjq9rTxlY2uxhJU79juBsVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746529361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FzRaQG+m4US7EegwgjdKSO5VaqO1brTo3KT3juQL+A=;
	b=Sq+RehYr91UZ2JHY5/9qrdcvYV/OtDadoyVk++LxF66h7nXrp+vzmPTPuH8uMMIW867DT1
	em5AbGR6IzeTqgDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746529361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FzRaQG+m4US7EegwgjdKSO5VaqO1brTo3KT3juQL+A=;
	b=2WjkCrQnflqr6Ej+d7nqpX1V+OtMP0QYFATf2MX1zHqW/0ozZ0Dbjpa5a2HFue7KssdN8r
	WnjiyspcQV43RsMUW3nudaLqsPFdmDBO5Aj7Sy9w/2rorvB32kCs2gHdspXcy5GCQ5Xngm
	QatfZrXqnjq9rTxlY2uxhJU79juBsVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746529361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FzRaQG+m4US7EegwgjdKSO5VaqO1brTo3KT3juQL+A=;
	b=Sq+RehYr91UZ2JHY5/9qrdcvYV/OtDadoyVk++LxF66h7nXrp+vzmPTPuH8uMMIW867DT1
	em5AbGR6IzeTqgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FE2513687;
	Tue,  6 May 2025 11:02:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6DPbIVHsGWivDgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 May 2025 11:02:41 +0000
Message-ID: <788deca2-82fb-471d-bdd2-3f2cabb54ebf@suse.de>
Date: Tue, 6 May 2025 13:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 07/25] block: add helper add_disk_final()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
 <20250505141805.2751237-8-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250505141805.2751237-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 5/5/25 16:17, Ming Lei wrote:
> Add helper add_disk_final() for scanning partitions, announcing disk and
> handling the last thing for adding disk.
> 
> No functional change, and prepare for prevent adding disk from happening
> when updating nr_hw_queues.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/genhd.c | 46 +++++++++++++++++++++++++++-------------------
>   1 file changed, 27 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
