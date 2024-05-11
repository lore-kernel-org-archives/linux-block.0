Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FE535B7
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715419100; cv=none; b=ouEiHhvl/z7BZJqbg9XCp55KpgC6ljG/UcFDmElLW0pdw5EpwcbJDbK30uOFUDv3mcsjJywYYfwGzTj7jHYVEqy1/CKxVYk7VyspsTK6rVigswAj81NAAkQwbTCOZeALYFhp+5Cger9BzOfK1T1eVZVkPOo6f/7fcbwEtMUlX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715419100; c=relaxed/simple;
	bh=W85xc42DhAhiK9a7HhX+UU31g3iZ+nmM7L28mcptZxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4/g2vBmqspgoCdZfYmlwotjG3vgcbFL62CkWtTlTNeBRa3uCtGEtcafIXUfBkhlR2MQ/G9goliTu2lstyOmqQ+rK7/S+h9zGCuSz19Lor5E++hkl4WkZ5jYuFZayZ2PawczpZid9xo0Q5f+KJtoRBEu06rD84cgcD77anMUmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EE8nJRUH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UE9IhezG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EcyRrowv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TtqKQV1j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EE8nJRUH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UE9IhezG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EcyRrowv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TtqKQV1j"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD40120B2B;
	Sat, 11 May 2024 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715419096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=EE8nJRUHWzmXvM+kRNQo4qbE0yukQ+qYm4P4iXEMxMt/NriKeY0poOoO4Xg2Z/r1VECGQx
	UWtiC/6ECyLaNtGW31i2Y799Bjh261qw5aDdFdY0eMyQAdswX2Y+UQs8HTRGG8Yz2jhhyI
	OWuTMKuSdRNwOuWhC7q84akG0hBfoE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715419096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=UE9IhezG09VQlSTJLXqhmQlNuW4H8h3fXqyDJD64Y0OtJC8Nrt5SJxHwuFD5LPwTDfzRK8
	kxwqp1XScitQPABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715419095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=EcyRrowvPGwfnPtA/N2Xlb62mksRtiwmQCbhf1kTMG9NDyjn3UFeukqVbDPDTNR3M5M8uc
	YDPa9+yXf9rVjlMW/II8fTkVRBVNYcgJhBm29axi3NnQ9Qvriycq83v8KPKvBqkRsTg6BY
	ETVbPwsqsW9emidKOb5mkevZAJuVX6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715419095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=TtqKQV1jWBMu76WYdOZXdI8c691Z4/D74XHekMJzaQ9/LMsrDVoR+ahbXNvACVMfq8N4rf
	PfCENq/wXdyxnpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EEED13A3E;
	Sat, 11 May 2024 09:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vzAzFNc3P2Y2KAAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 11 May 2024 09:18:15 +0000
Message-ID: <05bf499a-17a4-4438-a919-50da666fa289@suse.de>
Date: Sat, 11 May 2024 11:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block/bdev: enable large folio support for large
 logical block sizes
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-5-hare@kernel.org>
 <Zj6hHAVWSev-xe4R@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zj6hHAVWSev-xe4R@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 5/11/24 00:35, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:05PM +0200, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Call mapping_set_folio_min_order() when modifying the logical block
>> size to ensure folios are allocated with the correct size.
> 
> This makes me nervous.  It lets the pagecache allocate folios larger
> than min_order (all the way up to PMD_ORDER).  Filesystems may not
> cope well with seeing tail pages.
> 
> I'd _like_ to be able to do this.  But I think for now we need to
> call mapping_set_folio_order_range(mapping, order, order);
> 
(Misrouted reply to the previous mail; airports make me jumpy ...)

The whole point is that these devices cannot support smaller 
allocations. We might restrict ourselves to min_order == max_order,
but we should be focussing on getting min_order working first ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

