Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4820E03F
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945223; cv=none; b=pnf8gB5hZHDHi4LQ5Jp116Dh0JZuMxfuLE2wrxSQE9BqE4e+/B5YuuVcs3Bro/4bjkG22ydL6CHMcvoWYVXGnj6ZRe1T0JRqef46MLChPoFe+dgRuZu8WaMqd7PsADydTU/MnNY+gaXxn7tJoKwbcs8gr7F/PbyH+XzTnT7sxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945223; c=relaxed/simple;
	bh=tgup9VNBNdGFqYSqNA8rL8+56aHEUGSWubWYW2HO1Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T6rph1YKJITjMKizwbYiSVNu/pbelp25dxWHwH18sPqaWa0ztzqjZCoOVubepgrxdU7r9TbPBnDxxzpXgBhLfgRYJ3X5Cr9CERhH07aMeTfd0Gwr46g/OKaGb+B55gvb92ZOAyYgX/kf07eZ5k+sbWO/PvzrEq9gtoHI3asngmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0/oieiGY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=99ppe5GZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rIkAsbwT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo3lxgse; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0/oieiGY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="99ppe5GZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rIkAsbwT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo3lxgse"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB5893E71F;
	Tue, 24 Feb 2026 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771945220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTXWEqEQAmy1uzzHKHrg6jdTAa8TwbdMChrBk0w7aEs=;
	b=0/oieiGYaa0iU+V1aRK4U8H4cWK95VC5KztIFA0j0FGwURtqNX9E+m9WPz945tATPjY0GP
	LdKiT4V+n00ESaBugLOzBnxjbfY+0zzsXuGX0uHbukG4+hAbCYtaWUoT5+QzztZD1467+w
	anTJAo8La7plkWb2oIs9xVf7JPJDNSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771945220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTXWEqEQAmy1uzzHKHrg6jdTAa8TwbdMChrBk0w7aEs=;
	b=99ppe5GZ/HCBSB88qPiRBc9q5iHco1uUrqujNXAfZla/x9Gw94RQWT1Zr45qPMQK6rzIWQ
	nr1LmFt9s1YYanCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771945217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTXWEqEQAmy1uzzHKHrg6jdTAa8TwbdMChrBk0w7aEs=;
	b=rIkAsbwTvMW90Dj1kUE17RFJ1VJ1CXN4Y7uJ0KEsRMMZHmUUJeBl7/mwb3dKPcyQWR7HSK
	xJ9I3KdEKXLsqMKai9fs5HuomQtbeTtXchZAm2EQ3quFBrOqBxEhgTiN6otpWtErTun1wX
	BLlw9U+VJ7KkFlr2DYIJ4fLY7/qpfZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771945217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTXWEqEQAmy1uzzHKHrg6jdTAa8TwbdMChrBk0w7aEs=;
	b=Qo3lxgseAzuDuJwpmwSoheSGQCiYH4/Y5E5FtBHF8hwXKwrnGc+j7z4oOvUc6Gwv9YSEg7
	4APBsv6o4AZ+BtBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB6F63EA68;
	Tue, 24 Feb 2026 15:00:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UC1JKQG9nWldbQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Feb 2026 15:00:17 +0000
Message-ID: <f52cc220-5a31-473d-b255-3320be90766e@suse.de>
Date: Tue, 24 Feb 2026 16:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-5-dlemoal@kernel.org>
 <43213df9-9233-4d5a-8b56-77894052db67@suse.de>
 <1ce157d7-31fe-4a32-8acf-ed337dc1a52f@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1ce157d7-31fe-4a32-8acf-ed337dc1a52f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/24/26 03:03, Damien Le Moal wrote:
> On 2/23/26 8:59 PM, Hannes Reinecke wrote:
>> On 2/21/26 01:44, Damien Le Moal wrote:
>>> The function disk_zone_wplug_schedule_bio_work() always takes a
>>> reference on the zone write plug of the BIO work being scheduled. This
>>> ensure that the zone write plug cannot be freed while the BIO work is
>>> being scheduled but has not run yet. However, this unconditional
>>> reference taking is fragile since the reference taken is realized by the
>>> BIO work blk_zone_wplug_bio_work() function, which implies that there
>>> always must be a 1:1 relation between the work being scheduled and the
>>> work running.
>>>
>>> Make this less fragile by taking the reference on the BIO work if and
>>> only if the BIO work has not been already scheduled.
>>>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>    block/blk-zoned.c | 12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index c5c91f927a71..4b388ae1acaa 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -1205,13 +1205,15 @@ static void disk_zone_wplug_schedule_bio_work(struct
>>> gendisk *disk,
>>>        lockdep_assert_held(&zwplug->lock);
>>>          /*
>>> -     * Take a reference on the zone write plug and schedule the submission
>>> -     * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
>>> -     * reference we take here.
>>> +     * Schedule the submission of the next plugged BIO. If the zone write
>>> +     * plug BIO work is not already scheduled, take a reference on the zone
>>> +     * write plug to ensure that it does not go away while the work is being
>>> +     * scheduled but has not run yet. blk_zone_wplug_bio_work() will release
>>> +     * the reference we take here.
>>>         */
>>>        WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
>>> -    refcount_inc(&zwplug->ref);
>>> -    queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
>>> +    if (queue_work(disk->zone_wplugs_wq, &zwplug->bio_work))
>>> +        refcount_inc(&zwplug->ref);
>>>    }
>>>      static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
>>
>> Urgh. Don't.
>> There is a race condition; 'bio_work' might be scheduled directly and
>> complete before 'refcount_inc()' is called.
>> You have to invert the statement by keeping the 'refcount_inc()'
>> before calling 'queue_work()', and then drop the reference again
>> if queue_work failed.
>> Ugly, I know.
> 
> As Bart pointed out, since this is done with the zone write plug spinlock held
> and the work takes that lock first when it runs, there is no chance that the
> refcount gets bad. That is indeed not super clear though, so I will imrove the
> comment to describe that.
> 
But then we deadlock.
If a lock is held when calling queue_work() and the workqueue function
is calling spin_lock() on the _same_ lock _and_ we are scheduled on
the _same_ CPU (remember single-core systems ?) we deadlock.
Don't.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
