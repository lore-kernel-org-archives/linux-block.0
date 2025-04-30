Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF91D7989
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993700; cv=none; b=ddGPnNO2MGbN1jZAxCh8COvh5U849jQEDx27f1J2O8qthSrf//V7tVhHbE70MkQaUcp+KykxUlr5ExdsW6BAYWs3HwzvkhOmyOurOlfYZVX/u7xuRHAEZ5yPL96hHWiUco+QbIOiwL7sJQYaLWz1d5uLHw4g7BcVZukhm4UqVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993700; c=relaxed/simple;
	bh=9H+/tPQ8Zt4SWardJKvg9zAtU8xfcQdnWuN7sf6WXBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRlTuaiafGGOTKP3kXZiIH2aDkaCoJoP+Ss0SIzPy3c8It6P3+YOIF7qFntvuo6S1ygBmi5paJazysf5LoDCv041lBmBFNhUDAeXYnIg/CjkSw+/uiCBAWCqAw4RArzMDxG6B5kEutWoMhvWl7wiIBiSNZC8gNw5SfroK562Ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ID0p7hDI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6kOTQoRt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ID0p7hDI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6kOTQoRt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ID0p7hDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6kOTQoRt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ID0p7hDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6kOTQoRt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D09C421259;
	Wed, 30 Apr 2025 06:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8Svp3aV+R7yFmarak1vozvnIdU26T5HeckrCQsjT18=;
	b=ID0p7hDIZXfThe6ydxLbGbdcSOA71iEXvGhbJqHOrY0ZcS6qKWvVQ7ZxQr+w/czblHjLUV
	Ns0Zuoe+3MaBop3VmZdBUC/3dagXU4ViLp3aiVb4Y20tsKxAFvFYHnGPYJ3Zb2/BwZMK/Z
	pASHNIh7iC2Gn0G7FQ6+YFhw6kCvLxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8Svp3aV+R7yFmarak1vozvnIdU26T5HeckrCQsjT18=;
	b=6kOTQoRtj4up05RqREJhpKEKhilJdlv+k1AnoZohxjc38BrwLXhD8ItiBhHcbLQVW6WOWI
	9Z16B6M0aW8AG1Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8Svp3aV+R7yFmarak1vozvnIdU26T5HeckrCQsjT18=;
	b=ID0p7hDIZXfThe6ydxLbGbdcSOA71iEXvGhbJqHOrY0ZcS6qKWvVQ7ZxQr+w/czblHjLUV
	Ns0Zuoe+3MaBop3VmZdBUC/3dagXU4ViLp3aiVb4Y20tsKxAFvFYHnGPYJ3Zb2/BwZMK/Z
	pASHNIh7iC2Gn0G7FQ6+YFhw6kCvLxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8Svp3aV+R7yFmarak1vozvnIdU26T5HeckrCQsjT18=;
	b=6kOTQoRtj4up05RqREJhpKEKhilJdlv+k1AnoZohxjc38BrwLXhD8ItiBhHcbLQVW6WOWI
	9Z16B6M0aW8AG1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70ED4139E7;
	Wed, 30 Apr 2025 06:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PNi0GeC/EWjkZQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:14:56 +0000
Message-ID: <7c44a675-bb27-4b55-b840-ae3ba3ba56d3@suse.de>
Date: Wed, 30 Apr 2025 08:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/24] block: fold elevator_disable into
 elevator_switch
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-11-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250430043529.1950194-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/30/25 06:35, Ming Lei wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This removes duplicate code, and keeps the callers tidy.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 61 ++++++++++++++++++------------------------------
>   1 file changed, 23 insertions(+), 38 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
