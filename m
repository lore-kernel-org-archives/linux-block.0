Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A838C413
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773731935; cv=none; b=rm2xneZyy87JT2EaYObsAelsnnEEU0Zi6TNxMrpjJ6H1sWCYcOknD2oMp/oAG6Q51TJChZhFI5+u/USG+PKZSncPW9xbscEvaC3pFM4m90EcOOMhJwavy4lUQe4cp1lyresVSsXAJvFgxruF7corE9AOQRZCd95P45mkAazW88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773731935; c=relaxed/simple;
	bh=4Zw6h1iwe04NvL497iJ6GgsTyO9zRIQQQwoY6nVK/TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWqgqlDSMIi0hPg3MLTclIERI+laXiQKG3cXjkfm1NOQG5nmLm/R4tEsjiaf07MtMaWHHIFc1b+KhvWEU5bMoUgkETAlZj5wMfbJBPKKJeCC+8CBxL8mQLqCFAXBW8/FoIZ0lAZRrY2H36lm3oZpSuP5ks4THjTLmKuumbSuQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VmRFt23U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eJWv/yMd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F6IYd8Y6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DqTVbojB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VmRFt23U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eJWv/yMd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F6IYd8Y6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DqTVbojB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BB505BD70;
	Tue, 17 Mar 2026 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773731932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uNOQFwqg7/UNEqHxIWFJVIAKTLewkZHGv7J5mOuCUk=;
	b=VmRFt23UAb2m3mJV3U0DXCRfBYMzI09slyn/wdV619CilbIAkeTljpMeF3oG2qzfSoEVZM
	RXWxD08j5TLZyca493LccaaRTs/uQRvZFCbUexaUnpCdOCwNdUyD76MQxW1X3aCwmdGCmX
	UEoREUmJQjZFE0RN609kI1hBQ7+XkVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773731932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uNOQFwqg7/UNEqHxIWFJVIAKTLewkZHGv7J5mOuCUk=;
	b=eJWv/yMdeum5FycDO/Pf+ed5pMkE2hg3DF4DAuwoxHmJ/YLWk5eNGL+CIiLbezL0HHSJFC
	KjXP9iojenBYgtAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773731931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uNOQFwqg7/UNEqHxIWFJVIAKTLewkZHGv7J5mOuCUk=;
	b=F6IYd8Y6oGwqyaBfOEm+DINlpchNGIcptnsZa71XDRVAby+x2x7QUDQlPDdFHZSK2Syd+U
	dUGp0VqEc68RKGCGMpEB1g9cbdHTC88KGwMXXallUkdRtOHcGOVXtjQ4oWFntCU1OQ3Ckw
	pfF/mBvpzpAoviVYkaxYzBM9zvo95qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773731931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uNOQFwqg7/UNEqHxIWFJVIAKTLewkZHGv7J5mOuCUk=;
	b=DqTVbojBA6SuVoASzIyljyuSuDtduRxSYmrOd8y6I9usUgkUcMyiUbSAMMZn5F8NBHJ9Wg
	8P/hbDLzjytnpzBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 605494273B;
	Tue, 17 Mar 2026 07:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id prlIFloAuWlXGwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Mar 2026 07:18:50 +0000
Message-ID: <7a4dfa82-41af-401f-aa92-5bd19fe6f654@suse.de>
Date: Tue, 17 Mar 2026 08:18:49 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC][RESEND] Status of Rust in the block subsystem
To: Keith Busch <kbusch@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Daniel Gomez <da.gomez@samsung.com>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Jan Kara <jack@suse.cz>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 John Pittman <jpittman@redhat.com>, John Stultz <jstultz@google.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Niklas Cassel <cassel@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Oliver Mangold <oliver.mangold@pm.me>,
 Pankaj Raghav <kernel@pankajraghav.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Theodore Tso <tytso@mit.edu>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 gost.dev@samsung.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <878qcpbux5.fsf@kernel.org>
 <87ikb2mrib.fsf@t14s.mail-host-address-is-not-set>
 <abiXkTSpZ8CWbJVx@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <abiXkTSpZ8CWbJVx@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lst.de,grimberg.me,lists.linux-foundation.org,vger.kernel.org,acm.org,nvidia.com,kernel.org,samsung.com,wdc.com,suse.cz,redhat.com,google.com,oracle.com,pm.me,pankajraghav.com,mit.edu,gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLhytspa9b8ghbrab87o1fjg5u)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 3/17/26 00:51, Keith Busch wrote:
> On Wed, Mar 11, 2026 at 02:21:00PM +0100, Andreas Hindborg wrote:
>> As this topic was not selected for discussion at LSF, and I did not
>> receive an invitation for LSF this year, I propose that we discuss these
>> two topics on list.
>>
>> I do believe that these topics need to be discussed, and I would very
>> much appreciate your input.
> 
> I can sympathise the difficulty of maintaining external modules.
> 
> In terms of this being a reference driver, that implies some future
> hardware driver may leverage this for its development. Is there anything
> in mind at this point for production? If so, maybe that use case should
> take the lead. But either way, I think rust-nvme upstream inclusion
> would invite confusion. Once it's upstream, it's no longer a reference
> when distros and users turn it on.
> 
I wholeheartedly agree.

While I do see the original appeal to have a rust-nvme driver, having
one will just lead to confusion on all sides, especially for distros.
(Why is it there? should it be preferred to the original one? Do we
have to support both of them? Are there features missing in either
of these drivers?)
In general we are trying hard to avoid duplication in the linux kernel,
especially on the driver side. We constantly have to fight^Wargue
with driver vendors why duplicating existing drivers to support new
hardware is a bad idea, so we really should not start now just because
the driver is written in another language.
(That really might be giving vendors bad ideas :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
