Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09E2C234A
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905097; cv=none; b=Mu846rsZZ0boB2JE0nf9ZXJ+JlXXsJxKGdJFzN0USWKqKmtLwO8C5UR0FsF7NSuBPvOKV3M6rFJDxgXDdnjLNixEv3woUgG+tjtRv7ZHKH+Yv/k7L7ZkThF8mO7BsIUOwHvSE0+1JTkPvvO8Gk0FhJOBXQ6ENUMgUpDglYTFYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905097; c=relaxed/simple;
	bh=Wzn1tdHzQcwTY5kFUVVe+4YRkzlDLgvY6peKEC7YzMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQTJQrF2ySx3Ah7PIdy62cUYp7se1Zoy/BO2Fyy0PS/kXSPb7NqSB6CsmGWB1mJbNdEoJTbjIHYONFlbzqtH79aMoLGKMd6BXkdd0kDifADviokpSbdHh30Fm7nufCdRUuOZydzjwl6TCPMXEV0BYguFZ6hxZUZi1fbfq3nYjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nsV+DOAr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MhciHWmR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nsV+DOAr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MhciHWmR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nsV+DOAr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhciHWmR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nsV+DOAr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhciHWmR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C10315BD9D;
	Thu, 12 Feb 2026 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770905093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKJTOc4DCKcVt97eSUYwsdXPHlctfDjOKbxXJio/VLw=;
	b=nsV+DOArbPWgyPC5cKauKnye5s8wcAZVwAFd/V6byvv+nsCDw7lyh71Ar881n2DkJfRzow
	fvqGJYKSPxc1WI85ZCWxanJ5s2M2BProaOfklQNks/hrHfDrJtsl7FrFG1KQicCWqTtfnw
	MeNIpUgUR8gNxET/sDzdSOkQHH9ZiMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770905093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKJTOc4DCKcVt97eSUYwsdXPHlctfDjOKbxXJio/VLw=;
	b=MhciHWmR/GT2DNyeVmsRnm44mVbu5evUIUTEWJzPJxf6ZZEX8TnbiUmmvuHT/t6LVk38EK
	DLN4JoNZqWAeeLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770905093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKJTOc4DCKcVt97eSUYwsdXPHlctfDjOKbxXJio/VLw=;
	b=nsV+DOArbPWgyPC5cKauKnye5s8wcAZVwAFd/V6byvv+nsCDw7lyh71Ar881n2DkJfRzow
	fvqGJYKSPxc1WI85ZCWxanJ5s2M2BProaOfklQNks/hrHfDrJtsl7FrFG1KQicCWqTtfnw
	MeNIpUgUR8gNxET/sDzdSOkQHH9ZiMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770905093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKJTOc4DCKcVt97eSUYwsdXPHlctfDjOKbxXJio/VLw=;
	b=MhciHWmR/GT2DNyeVmsRnm44mVbu5evUIUTEWJzPJxf6ZZEX8TnbiUmmvuHT/t6LVk38EK
	DLN4JoNZqWAeeLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D9EE3EA62;
	Thu, 12 Feb 2026 14:04:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k/DRJQXejWm2RwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Feb 2026 14:04:53 +0000
Message-ID: <e63cd486-cdf0-4c90-85a5-b2f15699e96d@suse.de>
Date: Thu, 12 Feb 2026 15:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ublk invert part scan bit logic
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <aY3KpLbAOchXxXyi@fedora> <dfc5a8d3-45d3-4fe2-aa0b-b9571b5fb883@kernel.dk>
 <aY3PYGblTx748m4q@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aY3PYGblTx748m4q@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO

On 2/12/26 14:02, Ming Lei wrote:
> On Thu, Feb 12, 2026 at 05:48:40AM -0700, Jens Axboe wrote:
>> On 2/12/26 5:42 AM, Ming Lei wrote:
>>> On Thu, Feb 12, 2026 at 04:05:27AM -0700, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> For ublk, there's this logic in in ublk_ctrl_start_dev():
>>>>
>>>> /* Skip partition scan if disabled by user */
>>>> if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
>>>> 	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>>>> } else {
>>>> 	/* Schedule async partition scan for trusted daemons */
>>>> 	if (!ub->unprivileged_daemons)
>>>> 		schedule_work(&ub->partition_scan_work);
>>>> }
>>>>
>>>> where the
>>>>
>>>> clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>>>>
>>>> seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
>>>> UBLK_F_NO_AUTO_PART_SCAN is set? Added in:
>>>>
>>>> 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
>>>
>>> Yeah, the interface is designed in this way: partition scan is not
>>> done during add disk, and allowed since then on. The selftest code
>>> is written in same way too.
>>>
>>> If GD_SUPPRESS_PART_SCAN isn't cleared, userspace can't probe partitions
>>> any more.
>>>
>>> However, if you think the interface isn't good, we still can change it
>>> before 7.0 release.
>>
>> What I mean is, if UBLK_F_NO_AUTO_PART_SCAN is set, should we not
>> either leave the disk->state alone, or _set_ GD_SUPPRESS_PART_SCAN?
> 
> UBLK_F_NO_AUTO_PART_SCAN means partition scanning isn't done automatically
> from add_disk(), but it still allow userspace to send ioctl(BLKRRPART) for
> probing partition since disk is added.
> 
> If GD_SUPPRESS_PART_SCAN is set, ioctl(BLKRRPART) can't succeed any more.
> 
>> I might be confused here, but the current implementation doesn't
>> make much sense to me! If it is correct, then a comment to that
>> effect would be good imho.
> 
> I admit it is a little confusing, will send a patch to document this
> behavior if no one objects the UAPI.
> 
Is there a specific reason to continue to allow BLKRRPART if the
UBLK_F_NO_AUTO_PART_SCAN is set? Wouldn't is be better to have a
simple 'UBLK_F_NO_PART_SCAN', which directly maps to GD_SUPPRESS_PART_SCAN?
Would we lose something substantial in that case?

I actually would _like_ to be able to suppress partition scan
completely for ublk devices...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
