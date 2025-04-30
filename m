Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06719C54F
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993804; cv=none; b=cyDwEvgnzOU1AvAtI8sOPXOBBM2s0lqQHK6vnhqcVJFFbVxQZFPLw547ZTEZoSoRq9DW87ojoqRVoH1r7Ux6Ll8HOvcgVt3QOU1UlN6A48dOHE9V1u+fgQ6k7rFpo9CUJKRrVDY4nF8t8t3Hy4kM/Ll+srRn8DRmYqm0Wlf2jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993804; c=relaxed/simple;
	bh=QaYkeFadDlnJqyEq+iTrG5P9rh0/SO2hgahcx5VjeJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0/+AqcnxiBw655finpkbBmKZ45QZU8M3hm1oatNfhIGAMHrk7T9GAeDreJLzNnwQZ7jhA4NHYG0wngCEU7wKkHpq2GcmDDl2WApZsfsq7faQcM82Xlg624SpghZ4W8NOupYx4OcQZkQRNFUzPP8TGSVtx822w+xm63iv38nQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sEE84JEw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=20YdFOXR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sEE84JEw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=20YdFOXR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sEE84JEw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="20YdFOXR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sEE84JEw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="20YdFOXR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06D2D2124C;
	Wed, 30 Apr 2025 06:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADJT+cFDfpinmrKcRIfP+LIAz7VZ0Dghh3Gy26r+Q/I=;
	b=sEE84JEw8A31+39poly3ypIhe2nBhjYzR1GFoKNmeE6B570cB+wgQ3cP7oKaksftbPHgdm
	FNxLttvjoHHVive253d0qnAkB8tJbo65+je5+MrqlBIa05x/g2e+LMdXNQF3Keb4YwDskX
	syIxr6NG8TJfExBqE6e0hWyQXI7WATE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADJT+cFDfpinmrKcRIfP+LIAz7VZ0Dghh3Gy26r+Q/I=;
	b=20YdFOXRjkDIVgi+3tCcKCZnyOchenSTx7++7r1Y2/ZzEywyleHib/tf5+KOwgg3UYCNrS
	saUz5DXyFE4oANAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADJT+cFDfpinmrKcRIfP+LIAz7VZ0Dghh3Gy26r+Q/I=;
	b=sEE84JEw8A31+39poly3ypIhe2nBhjYzR1GFoKNmeE6B570cB+wgQ3cP7oKaksftbPHgdm
	FNxLttvjoHHVive253d0qnAkB8tJbo65+je5+MrqlBIa05x/g2e+LMdXNQF3Keb4YwDskX
	syIxr6NG8TJfExBqE6e0hWyQXI7WATE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADJT+cFDfpinmrKcRIfP+LIAz7VZ0Dghh3Gy26r+Q/I=;
	b=20YdFOXRjkDIVgi+3tCcKCZnyOchenSTx7++7r1Y2/ZzEywyleHib/tf5+KOwgg3UYCNrS
	saUz5DXyFE4oANAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACF53139E7;
	Wed, 30 Apr 2025 06:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s/lqKEjAEWiDZgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:16:40 +0000
Message-ID: <4d868554-c69a-4bbd-9cca-a9c850ee09fe@suse.de>
Date: Wed, 30 Apr 2025 08:16:40 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 17/24] block: remove elevator queue's type check in
 elv_attr_show/store()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-18-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250430043529.1950194-18-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/30/25 06:35, Ming Lei wrote:
> elevatore queue's type is assigned since its allocation, and never
> get cleared until it is released.
> 
> So its ->type is always not NULL, remove the unnecessary check.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
