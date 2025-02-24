Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8021D3F2
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386487; cv=none; b=BucRS6KZbPTwTCm2Ihyywj9k6fhsx1ppRQU8wZ1rkj1Zd5jVlnMA/nTOCSO2jRzsR1duoMsn3BdBYcX0ESR4kD//JPY5Zqyt+S5VOLO+NICb4Agb8+9CMPPeZIFpfOUNbMmwE3gUHDCtfygNifommvE4y4u2PIM72TwiLVGV8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386487; c=relaxed/simple;
	bh=A+5Y/m2+jiPK5T4teDsilQyQLUtR1KAW34QkIVoImZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeSrvX6xTSUMAfaw0YaLXFA5Ld7O/2+NqozF1lw0T7kbKuNu6WLyDg8P7PjbvJhHoyw5YePvGkfnuZtFNibjm6kXh58xuHNETX6DwzNGMiviwpPOD31ba6w6xTk5alrDMBuyfnyZfLxB0XEevmOMaSHdirJab/njKZbo0awrO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=giGYXgLe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tBy7cUIF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=giGYXgLe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tBy7cUIF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="giGYXgLe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tBy7cUIF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="giGYXgLe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tBy7cUIF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04AB521179;
	Mon, 24 Feb 2025 08:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9etipGH8eNuomhBm5+BI8+sTlj+1x/z7gaT5JIUby1c=;
	b=giGYXgLexQxHmYXG7kHFKbM3ozEojotmUgoV1l/2vzm8XLLRwL/2n1GEaJuNYkZW2kYpK3
	L1p9n/lcNXxUdNVfpQZzqUi1iojUZbpYtnVXl3XeS0P72PPr9/MLHRfptUmjOSv9C4yger
	+6WlJe6ykKtddXm0BpAecATNHCVXlTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9etipGH8eNuomhBm5+BI8+sTlj+1x/z7gaT5JIUby1c=;
	b=tBy7cUIFQXZqLTBhAaF0wjVs55OBUckX3XU6AZwsm+H70AzyfEtEcDFvpmRA+Msqq3r6lw
	rGq1N3uMsaCCftCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9etipGH8eNuomhBm5+BI8+sTlj+1x/z7gaT5JIUby1c=;
	b=giGYXgLexQxHmYXG7kHFKbM3ozEojotmUgoV1l/2vzm8XLLRwL/2n1GEaJuNYkZW2kYpK3
	L1p9n/lcNXxUdNVfpQZzqUi1iojUZbpYtnVXl3XeS0P72PPr9/MLHRfptUmjOSv9C4yger
	+6WlJe6ykKtddXm0BpAecATNHCVXlTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9etipGH8eNuomhBm5+BI8+sTlj+1x/z7gaT5JIUby1c=;
	b=tBy7cUIFQXZqLTBhAaF0wjVs55OBUckX3XU6AZwsm+H70AzyfEtEcDFvpmRA+Msqq3r6lw
	rGq1N3uMsaCCftCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B87D813332;
	Mon, 24 Feb 2025 08:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oZtSK7MwvGfsVQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Feb 2025 08:41:23 +0000
Message-ID: <6084e145-0347-4dd5-83c7-2704a846896d@suse.de>
Date: Mon, 24 Feb 2025 09:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
To: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
 axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <20250218084622.GA11405@lst.de>
 <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
 <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/21/25 15:02, Nilay Shroff wrote:
> 
> Hi Christoph, Ming and others,
> 
> On 2/18/25 4:56 PM, Nilay Shroff wrote:
>>
>>
>> On 2/18/25 2:16 PM, Christoph Hellwig wrote:
>>> On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
>>>> There're few sysfs attributes in block layer which don't really need
>>>> acquiring q->sysfs_lock while accessing it. The reason being, writing
>>>> a value to such attributes are either atomic or could be easily
>>>> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
>>>> are inherently protected with sysfs/kernfs internal locking.
>>>>
>>>> So this change help segregate all existing sysfs attributes for which
>>>> we could avoid acquiring q->sysfs_lock. We group all such attributes,
>>>> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
>>>> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store
>>>> method (show_nolock/store_nolock) is assigned to attributes using these
>>>> new macros. The show_nolock/store_nolock run without holding q->sysfs_
>>>> lock.
>>>
>>> Can you add the analys why they don't need sysfs_lock to this commit
>>> message please?
>> Sure will do it in next patchset.
>>>
>>> With that:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>
> I think we discussed about all attributes which don't require locking,
> however there's one which I was looking at "nr_zones" which we haven't
> discussed. This is read-only attribute and currently protected with
> q->sysfs_lock.
> 
> Write to this attribute (nr_zones) mostly happens in the driver probe
> method (except nvme) before disk is added and outside of q->sysfs_lock
> or any other lock. But in case of nvme it could be updated from disk
> scan.
> nvme_validate_ns
>    -> nvme_update_ns_info_block
>      -> blk_revalidate_disk_zones
>        -> disk_update_zone_resources
> 
> The update to disk->nr_zones is done outside of queue freeze or any
> other lock today. So do you agree if we could use READ_ONCE/WRITE_ONCE
> to protect this attribute and remove q->sysfs_lock? I think, it'd be
> great if we could agree upon this one before I send the next patchset.
> 
READ_ONCE should be fine here. 'nr_zones' is unlikely to change, and
if that is updated we've done a full disk revalidation including a read
of all zones. So not a critical operation, and nothing which needs to be
protected.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
