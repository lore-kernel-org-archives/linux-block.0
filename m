Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9033DED1
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770335110; cv=none; b=DqgcrnspchXEcIb/ULasD/8j/D2Y6LTHcooo0vNsf/Picte96X2sepnOF8VCd/klMPLAsoBHAoUdR92nJTei3xA0RbnpBoPFImK+v69bHxTcrWDWksyh45BCjWAmjpwKM2SWx+WIWEKOre8mZzG77bNkmC8xwTT5/5gqWYTekrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770335110; c=relaxed/simple;
	bh=fBnsy1kGKa/odHzaXCescGgvBoM8eKHe01kwQ1ZK/H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTZB2ug5Q91wh8TlpfuPpnxKdVBX15cZusN+ZczvOGE9YHOug3j/Ov6HvmZ7W+XEdzU7kAzHleWpJ8UA5aoz0QMGzlkY9YHDL+oDltDwObE9cW0EdV5h2ZKQCDYDjDdkdUDGNJ4BP/UuzYTQWMlReIFIglWtjdlM44QUpWHfaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yU/vuh2Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ILWp0nu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yU/vuh2Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ILWp0nu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yU/vuh2Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ILWp0nu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yU/vuh2Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ILWp0nu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4225C5BCC1;
	Thu,  5 Feb 2026 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770335108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=802vReqt8yZcj8j6qixegbPvBbFXMUAdtUa7RGT5jTY=;
	b=yU/vuh2Q77hOLlz2JQTdL6x1ivob32DbSfseMNE2T+inP66CXr1S1e+Ffl2J2Nteao8eGE
	Hw3sYQ7TvzMMqMMSLdsWeC7cU6onJuN/Nz6AXLvyKG8/NnLxqOjZCI4lTzduh2Dvg13Blf
	NB0Mi3NPIAEVNLVqoDMCDdbiaJN8DMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770335108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=802vReqt8yZcj8j6qixegbPvBbFXMUAdtUa7RGT5jTY=;
	b=4ILWp0nuz+0MDajZnhzJJ6nZrbQnYT5C2hYZ+CUMmkSn4MIEcFcbM1ttLiAPUj+8mFMU4V
	52Mc/oneywf3dlCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="yU/vuh2Q";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4ILWp0nu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770335108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=802vReqt8yZcj8j6qixegbPvBbFXMUAdtUa7RGT5jTY=;
	b=yU/vuh2Q77hOLlz2JQTdL6x1ivob32DbSfseMNE2T+inP66CXr1S1e+Ffl2J2Nteao8eGE
	Hw3sYQ7TvzMMqMMSLdsWeC7cU6onJuN/Nz6AXLvyKG8/NnLxqOjZCI4lTzduh2Dvg13Blf
	NB0Mi3NPIAEVNLVqoDMCDdbiaJN8DMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770335108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=802vReqt8yZcj8j6qixegbPvBbFXMUAdtUa7RGT5jTY=;
	b=4ILWp0nuz+0MDajZnhzJJ6nZrbQnYT5C2hYZ+CUMmkSn4MIEcFcbM1ttLiAPUj+8mFMU4V
	52Mc/oneywf3dlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFBA83EA63;
	Thu,  5 Feb 2026 23:45:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8kuiIIErhWnTSwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 05 Feb 2026 23:45:05 +0000
Message-ID: <dcc9dfc7-fda0-4d25-80ab-48a722c984bf@suse.de>
Date: Fri, 6 Feb 2026 00:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] bsg: initialize request and reply payloads in
 bsg_prepare_job
To: Jens Axboe <axboe@kernel.dk>, jonghwi.rha@samsung.com
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?=
 <jt1217.kim@samsung.com>, =?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
References: <8c7399bf-76b3-4902-b257-b85c95543f6f@kernel.dk>
 <20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd@epcms2p4>
 <CGME20260130091020epcms2p2d85af8781639a17ab517208feb270dbd@epcms2p2>
 <20260205053219epcms2p20a936a2fa681d19d3386fd480c283447@epcms2p2>
 <f8e86beb-5025-4d33-9ee4-0b9e8155c345@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f8e86beb-5025-4d33-9ee4-0b9e8155c345@kernel.dk>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4225C5BCC1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 2/5/26 14:42, Jens Axboe wrote:
> On 2/4/26 10:32 PM, ??? wrote:
>> bsg: initialize request and reply payloads in bsg_prepare_job
>>
>> struct bsg_job payloads contain fields that are only populated by
>> certain commands, such as sg_list pointers.
>>
>> Because struct bsg_job is allocated with kmalloc(), memory may be
>> reused across requests. If a command does not populate all payload
>> fields, stale state from a previous job may remain and later be
>> misinterpreted during cleanup, potentially leading to use-after-free
>> or double-free issues.
>>
>> Initialize both request and reply payloads at the beginning of job
>> preparation to ensure a clean state for all commands.
>>
>> Signed-off-by: Jonghwi Rha <jonghwi.rha@samsung.com>
>>
>> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
>> index 32da4a4429ce..0fbf8e311c03 100644
>> --- a/block/bsg-lib.c
>> +++ b/block/bsg-lib.c
>> @@ -234,6 +234,12 @@ static bool bsg_prepare_job(struct device *dev, struct request *req)
>>          struct bsg_job *job = blk_mq_rq_to_pdu(req);
>>          int ret;
>>
>> +       /* Clear stale SG state since bsg_job is reused as a request PDU */
>> +       job->request_payload.sg_list = NULL;
>> +       job->request_payload.sg_cnt = 0;
>> +       job->reply_payload.sg_list = NULL;
>> +       job->reply_payload.sg_cnt = 0;
>> +
>>          job->timeout = req->timeout;
>>
>>          if (req->bio) {
> 
> The patch is white-space damaged, tabs are spaces. But I can fix that
> up. Do we just want to do a memset(job, 0, sizeof(*job)) here to avoid
> any oddities like this in the future?
> 

That might indeed be better.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
