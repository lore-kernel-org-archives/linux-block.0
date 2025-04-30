Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8151DE8B4
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993753; cv=none; b=n0WqugAHcPvtncqNsBvnHTTj2b7PLpnNuQ5NSA0PWeMULVgMMN7fgtW7ebxV5NhjQwv4/eFlcQ9fSR9NcZFytCCtgS5t3lGoqVUxATJEcx7Fc1TOt1y3sZVMzQEZZUjUznzTH14b0UeLlnk8J5VLuB/xpnRmzEX3iX6JCYExiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993753; c=relaxed/simple;
	bh=MIelxwoPNtUu65o6IG9mLVcva8jKrC/4XCfu/3w8S+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3yLzIyGClZD+/ZhoBnKZxhHg1nSD6+RQiZA2n4SRhTlWIkP9O/KnQCSx0cBSS1/5FVjBWn2kmxaQg5/wq5pFFLXzfe91MOwTPxa4P2VVxz5giiZsQ6oLhC3+Ve/xeURVI8Q2eLzAIbfF0xS/utrwfe/h0OATyzYNy8SAmsfjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QymnbevQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gwwRhMEo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QymnbevQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gwwRhMEo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QymnbevQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gwwRhMEo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QymnbevQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gwwRhMEo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 925081F7BF;
	Wed, 30 Apr 2025 06:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irhE4GoSoyttlHlwkZMPGnm+xLFJnSNP+l0P4MKE/uI=;
	b=QymnbevQaFpVd/lb4onzQNXRwkPw1Ba23FVAewfvkp4rY0O17/hsvty3cLJ/lgvlutZfPi
	L+ePrf4R1ATw+W6ucf4wg3Ewsv5ou3Wwz5WmZHDe4Cc5XnErsY5RvndiiJdFOkqp+uV4NQ
	Vwg71ib7uPsbzq3hRgUosn7u+9dgXwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irhE4GoSoyttlHlwkZMPGnm+xLFJnSNP+l0P4MKE/uI=;
	b=gwwRhMEo3XIoXPtTwBzvWqamxd8ETDL9RXM2pP+xw0lwBGbfwkdTZ51fnfJeW3t8TZ6pBA
	QMrltd9KBg10MbAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irhE4GoSoyttlHlwkZMPGnm+xLFJnSNP+l0P4MKE/uI=;
	b=QymnbevQaFpVd/lb4onzQNXRwkPw1Ba23FVAewfvkp4rY0O17/hsvty3cLJ/lgvlutZfPi
	L+ePrf4R1ATw+W6ucf4wg3Ewsv5ou3Wwz5WmZHDe4Cc5XnErsY5RvndiiJdFOkqp+uV4NQ
	Vwg71ib7uPsbzq3hRgUosn7u+9dgXwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irhE4GoSoyttlHlwkZMPGnm+xLFJnSNP+l0P4MKE/uI=;
	b=gwwRhMEo3XIoXPtTwBzvWqamxd8ETDL9RXM2pP+xw0lwBGbfwkdTZ51fnfJeW3t8TZ6pBA
	QMrltd9KBg10MbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7F6139E7;
	Wed, 30 Apr 2025 06:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dpToDQ3AEWgrZgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:15:41 +0000
Message-ID: <78da45dc-d716-4b8e-8fd1-d2e023ac60a9@suse.de>
Date: Wed, 30 Apr 2025 08:15:40 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 11/24] block: move blk_queue_registered() check into
 elv_iosched_store()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-12-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250430043529.1950194-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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

On 4/30/25 06:35, Ming Lei wrote:
> Move blk_queue_registered() check into elv_iosched_store() and prepare
> for using elevator_change() for covering any kind of elevator change in
> adding/deleting disk and updating nr_hw_queue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
