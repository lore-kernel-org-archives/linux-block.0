Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C260279
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064064; cv=none; b=hJrNstmICxqb6dy1PUFFOP9XYrqiYsqqFJmK0EiGYUcMxpvMKFsMkMm3qOcpj1RC5rj27xBupNh+/xDHAWqPW5SnKE6IDM06qdNkpKfI8RtOQEtjnplbCO1LctSK3PQnTj0ve1aISes0npn1j2x3BRTEacbZ6wgUlrvLUt01sxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064064; c=relaxed/simple;
	bh=ohZ+zjDYPVRFEw8dw5KiQXxqyMafUXkwL3GLyFyZ1Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQCkIB+aBw4ZTaMqpXNZt7GDzBvvj8DGSOqnRNuFxx5d4iVeii/bIXuglsNHHOOtd4Yl5M1xcS3YOjdc7Vl5NjAN3w/VeqrwWsOT1LFhEMoMEA8k8t8cuDgbA2ESNyuJYWqpTcNQqulI4qKYk79no7pQusXZhr0pOq2hL94kueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S7or8f5x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3t7H1JHF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S7or8f5x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3t7H1JHF"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 280BB5BD88;
	Tue,  2 Apr 2024 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712064061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AHTfCln3NhSN2wZD62KRrSGga59ey6TwEVzkTjExvw=;
	b=S7or8f5x4ICizG/0LoPOE2u4QRxAVKo921AUjXs2Nvs/QvlTMMdVfCm7hwz5QAqz6zC0IT
	wbEfDmyBA+3mAVdp0Q5emDTedJIjvxP61mo+rHCvKdik48U60ZywvFu4dtK7y6BkRqf5sO
	HMDWlaC7OScxI/kGkA4ROxswq4PqUYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712064061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AHTfCln3NhSN2wZD62KRrSGga59ey6TwEVzkTjExvw=;
	b=3t7H1JHFTGsNP/ksS76Kl5OVau1IckqoRZgw5yo5+udk3AhvfHYD/bM+gkDFvPBMozBFIi
	XVq7v7DrftqqxvDw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D2B913357;
	Tue,  2 Apr 2024 13:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JaGpBj0GDGZaUgAAn2gu4w
	(envelope-from <hare@suse.de>); Tue, 02 Apr 2024 13:21:01 +0000
Message-ID: <985db17d-691a-4674-8e2d-962ac9a8af1f@suse.de>
Date: Tue, 2 Apr 2024 15:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oddities in brd queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0cba8c5d-f014-4e48-9a6f-7724cf939c5c@suse.de>
 <20240402131822.GA32081@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240402131822.GA32081@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.29
X-Spam-Level: 
X-Spam-Flag: NO

On 4/2/24 15:18, Christoph Hellwig wrote:
> On Tue, Apr 02, 2024 at 03:17:26PM +0200, Hannes Reinecke wrote:
>> Hi Christoph,
>>
>> brd ends up with the following queue limits:
>>
>> optimal_io_size: 0
>> minimum_io_size: 4096
>> hw_sector_size: 512
>> physical_block_size: 4096
>>
>> which I find particularly odd; how can the minimum I/O size be _larger_
>> than the hw_sector_size? Wouldn't that imply that we can only send I/O
>> in units of physical block size, rendering the hw_sector_size pretty much
>> pointless?
> 
> The minimum_io_size is always larger or equal to hw sector size.
> It really is the minimal efficient I/O size.
> 

So is it a hard limit (as in: we cannot send I/O smaller than that)
or a soft limit (as in: we should not send I/O smaller than that)?

Cheers,

Hannes

