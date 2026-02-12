Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8CE33F37E
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908821; cv=none; b=FaDaSYb+I34M+6PEMzeBYLUXLUjs86VO/kvLFkKajuE7/Wdmm/6dyIqRoFIpu7EgWePAcH4AcIjHB+2Nifi+3iHInwoS+HhfsKh+L6abpw8TvAoTTcRxUgDtvrjoSrlsGbwOQchxOoKJ9vZ/i5k6sKHwI1O8fkL3QHlBhxqEK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908821; c=relaxed/simple;
	bh=gxa18cIC8NmuiSuzXDMx3kLKx/EuXErcXX55GfbQ7eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL6ZT1ZWXj05ZTYWlmCLWF/3JZYd9u/BCb9Vjz2Z+3aftmsiEViu+miX2oRXm+ftQY9h1t+8mH9/J2GE7VyNoLeME0qcmN4+FJZU4D0+rcRPPpZhPQdVWEAW3ed9k1bU78Z1zDdMD6Xw4ZdRnfc8DDxZe556gSLwqz8Nt4bm6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OHl3GKaG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/J3BsuNT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OHl3GKaG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/J3BsuNT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OHl3GKaG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/J3BsuNT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OHl3GKaG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/J3BsuNT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 913075BDAB;
	Thu, 12 Feb 2026 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770908818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6o0vnm+5wjCmunKruzybaqFhSsTIhJQC8Z8TJ1nXc4=;
	b=OHl3GKaGePlgH8rQvagEoBQk7OHuKQc1Pitv1RxL3proRKykyrgM1Vp6paJ74WKEWGREef
	yRT4/xB5h8XCKaAXvKZ4yxDIqc15EgPexJhj5w8DsUemZn1M/7qL5azrOzudFjHt+rnP6L
	2o9PFv8lTVqdbDnkkHLMr6EHaoE25yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770908818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6o0vnm+5wjCmunKruzybaqFhSsTIhJQC8Z8TJ1nXc4=;
	b=/J3BsuNTNOu8+l9Gumb3Mpw1/Gg6g5SUORoeDYPOnyraoyzVDRcaycl2njMX3C7/HnBQZR
	LPFA0ohik6oTvODQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OHl3GKaG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/J3BsuNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770908818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6o0vnm+5wjCmunKruzybaqFhSsTIhJQC8Z8TJ1nXc4=;
	b=OHl3GKaGePlgH8rQvagEoBQk7OHuKQc1Pitv1RxL3proRKykyrgM1Vp6paJ74WKEWGREef
	yRT4/xB5h8XCKaAXvKZ4yxDIqc15EgPexJhj5w8DsUemZn1M/7qL5azrOzudFjHt+rnP6L
	2o9PFv8lTVqdbDnkkHLMr6EHaoE25yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770908818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6o0vnm+5wjCmunKruzybaqFhSsTIhJQC8Z8TJ1nXc4=;
	b=/J3BsuNTNOu8+l9Gumb3Mpw1/Gg6g5SUORoeDYPOnyraoyzVDRcaycl2njMX3C7/HnBQZR
	LPFA0ohik6oTvODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 782643EA62;
	Thu, 12 Feb 2026 15:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WRziHJLsjWlaHwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Feb 2026 15:06:58 +0000
Message-ID: <8f63c5d8-6a71-42e0-a0eb-3621cd625f0c@suse.de>
Date: Thu, 12 Feb 2026 16:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ublk invert part scan bit logic
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <aY3KpLbAOchXxXyi@fedora> <dfc5a8d3-45d3-4fe2-aa0b-b9571b5fb883@kernel.dk>
 <aY3PYGblTx748m4q@fedora> <e63cd486-cdf0-4c90-85a5-b2f15699e96d@suse.de>
 <aY3iLwf8G3jKUIbw@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aY3iLwf8G3jKUIbw@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 913075BDAB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 2/12/26 15:22, Ming Lei wrote:
> On Thu, Feb 12, 2026 at 03:04:53PM +0100, Hannes Reinecke wrote:
>> On 2/12/26 14:02, Ming Lei wrote:
>>> On Thu, Feb 12, 2026 at 05:48:40AM -0700, Jens Axboe wrote:
[ .. ]
>>>> I might be confused here, but the current implementation doesn't
>>>> make much sense to me! If it is correct, then a comment to that
>>>> effect would be good imho.
>>>
>>> I admit it is a little confusing, will send a patch to document this
>>> behavior if no one objects the UAPI.
>>>
>> Is there a specific reason to continue to allow BLKRRPART if the
>> UBLK_F_NO_AUTO_PART_SCAN is set? Wouldn't is be better to have a
> 
> No, I just want to allow future ioctl(BLKRRPART).
> 
>> simple 'UBLK_F_NO_PART_SCAN', which directly maps to GD_SUPPRESS_PART_SCAN?
>> Would we lose something substantial in that case?
> 
> If there is, we may add new feature flag for it.
> 
>>
>> I actually would _like_ to be able to suppress partition scan
>> completely for ublk devices...
> 
> Fine, we can change UBLK_F_NO_AUTO_PART_SCAN to align with GD_SUPPRESS_PART_SCAN.
> 
yes, please. That would make the code easier to understand and we 
wouldn't need to have any 'special' handling (or documentation)
here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
