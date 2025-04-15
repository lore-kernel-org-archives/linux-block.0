Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD505194C86
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703424; cv=none; b=VJ7WrY4+pvCw6Lswi9lAoe0jEEvLwDvmc+/R6chxHnkSXjsu9Q0q/TNihgbyMDpFBXRJU/Gt9lJVfMcwYLIgpKPAFTBxne+Py2sK47Gh6zhYUjqkZc/86tbSOy0opsyl8bJq1ehlIMXeI61Dxl8tUPwKFk6GWGxW6sXZfS9T/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703424; c=relaxed/simple;
	bh=jLQOzGeD50XBt7TwjKXcuQt6/jBUP9o/wWq7/DmnwYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GS7dD62aqREz4TCbWh0cdk+Ibl2cLEBZiFt26Nf3G+Nko2M6r5S+jZGpoWUiDv3EiyeoBlUqvaEo0fFuS5G1+CA3lQsxG0XB6RIS6SxAcl6vuLWyxxukoiWxwaZ6JTtJcdkS7gZq+JX/tSRxjx3JgHWYbvbtywegRQ2y94T8sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nvgumNWd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E3NFk2Oa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nvgumNWd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E3NFk2Oa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nvgumNWd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E3NFk2Oa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nvgumNWd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E3NFk2Oa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5C631F38A;
	Tue, 15 Apr 2025 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744703420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=nvgumNWdlS9bpY0i7qwTNS4qOVAyRbx6q57FYS3t7wFKyWfaaLYXM6NVU9PvJEfZjgC1vc
	uRH/PTz5VyVn2Q0Ad9jjq/vHfBDTwo9bHQbuH/T4G46VoHaANjkrgJuT3oJ6gXTAHe0sX+
	kipdWfGdwWUlI47/bDnC36tuyzV7xJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744703420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=E3NFk2Oa5xaLL3TaGoiz99ibS3ZyZB2M8MGV75Q/4PuLHhV79ptI1KBmdHvk5FMl7QvJ5Q
	M2hrFeVf+jsPoMCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nvgumNWd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E3NFk2Oa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744703420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=nvgumNWdlS9bpY0i7qwTNS4qOVAyRbx6q57FYS3t7wFKyWfaaLYXM6NVU9PvJEfZjgC1vc
	uRH/PTz5VyVn2Q0Ad9jjq/vHfBDTwo9bHQbuH/T4G46VoHaANjkrgJuT3oJ6gXTAHe0sX+
	kipdWfGdwWUlI47/bDnC36tuyzV7xJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744703420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=E3NFk2Oa5xaLL3TaGoiz99ibS3ZyZB2M8MGV75Q/4PuLHhV79ptI1KBmdHvk5FMl7QvJ5Q
	M2hrFeVf+jsPoMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AC0A139A1;
	Tue, 15 Apr 2025 07:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yufdH7wP/mcUNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 15 Apr 2025 07:50:20 +0000
Message-ID: <4c3eb3f4-6e19-401b-a110-cae405512ed4@suse.de>
Date: Tue, 15 Apr 2025 09:50:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 00/10] nvme: test cases for TLS support
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
 <nab6xnd63ose5yqawp5q3nwrgcfi654zveat6iiccci75ob67r@mkfarprb4aeg>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <nab6xnd63ose5yqawp5q3nwrgcfi654zveat6iiccci75ob67r@mkfarprb4aeg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5C631F38A
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/15/25 09:47, Shinichiro Kawasaki wrote:
> On Apr 02, 2025 / 16:08, Shin'ichiro Kawasaki wrote:
>> Hannes created two testcases and shared them as the GitHub PR 158 [1]. Quote:
>>
>>   "This pull request adds two new testcases for nvme TLS support, one for 'plain'
>>    TLS with TLS PSKs, and the other one for testing 'secure concatenation' where
>>    TLS is started after DH-HMAC-CHAP authentication."
>>
>> The testcases were missing a few requirement checks. They also modified
>> systemctl service status after test case runs. To address these problems, I took
>> the liberty to add some more patches and modified the testcases. Here I post the
>> modified patch series for wider review.
>>
>> The first five patches are preparation patches to add several helper functions
>> for requirement checks and systemctl support. The last five patches are
>> originally created by Hannes to add the new testcases nvme/060 and nvme/061.
>>
>> I ran the two test cases using the kernel v6.14 with the patch series titled
>> "[PATCHv15 00/10] nvme: implement secure concatenation" [2]. I observed nvme/060
>> passed, but nvme/061 failed. FYI, I share the failure logs [3]. Actions to fix
>> the failure will be appreciated.
> 
> FYI, I applied this series. Of note is that the two new test cases were
> renumbered from nvme/060 & 061 to nvme/062 & 063 to avoid the number conflict.
> 
>> P.S. Hannes, please check the Copyright year of the second test case nvme/061.
>>       It is 2022, but I guess you meant 2024 or 2025.
> 
> I still suspect that Hannes intended the copyright year 2024 or 2025, but keep
> it 2022 unless Hannes requests change for it.

Weelll ... 2022 is actually correct, for that's when I wrote the
original test for TLS. It really took its time getting upstream ...

Thanks for doing this! Much appreciated!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
