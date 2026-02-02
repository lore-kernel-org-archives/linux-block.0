Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCC357A34
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073463; cv=none; b=imkqKsKsrUsyUY7RrOrBrmmSUBKV/dHwS+9kqYSnZPbSWnTdD+JZBA7A7xccehrNqOnrhKk41wghqcnc5isp2J79uh/a4YHrRdQ/mcps803fL20AhnygfwtqEFcBt+RyY7j/jAVwPXB3/Nah04koN0v3DE40nHdQGBxD9IomF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073463; c=relaxed/simple;
	bh=/eC0SbxoOzs1uMdCa+apkaBL32JGCIj4ZQ1vTC2b/OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UploamQGGRlPJxt1ZOCgfWEoShJE+SJF0xD0RMjByQfhk5+1jun3QzPJe9oomC2zvk6Y4UR6CIb9n71fCSJ5v9tEvdlPgfdxgC7wxe//6tJVebsYgPqsMPeCYg0ttNm6VRLzLqmMxuHbpMAS1GnowWY2vP6XtUc5AyOELzsys+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H1UH/2ug; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2bNntK2w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H1UH/2ug; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2bNntK2w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H1UH/2ug";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2bNntK2w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H1UH/2ug";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2bNntK2w"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 095D95BCC3;
	Mon,  2 Feb 2026 23:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770073460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZnyzJvDh2K7GboMq6ymrmhlKymfJHNNeq1Y7oHWe2M=;
	b=H1UH/2ug7SA9K5kuDQfDDJz90LB6F372j2nOleUAR7eDDs3RqhtjIje3LATR9JfFTaQU2X
	owbMkQlfJAWvNF7T4KyoOMysNIKHJlKmPxLWbVGMIaNOrY+clxBq+HgefCfAOCM9WF+QRh
	XdpgtydOo28TaUIujUDCq82U5AkoAKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770073460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZnyzJvDh2K7GboMq6ymrmhlKymfJHNNeq1Y7oHWe2M=;
	b=2bNntK2wSSkqMA76yxE+hYolvqqdxzoKsdoRkZswhuHpYCophMLrQZwy6vxLWFeAw7tNUC
	+KHFseyuoIh96jDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770073460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZnyzJvDh2K7GboMq6ymrmhlKymfJHNNeq1Y7oHWe2M=;
	b=H1UH/2ug7SA9K5kuDQfDDJz90LB6F372j2nOleUAR7eDDs3RqhtjIje3LATR9JfFTaQU2X
	owbMkQlfJAWvNF7T4KyoOMysNIKHJlKmPxLWbVGMIaNOrY+clxBq+HgefCfAOCM9WF+QRh
	XdpgtydOo28TaUIujUDCq82U5AkoAKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770073460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZnyzJvDh2K7GboMq6ymrmhlKymfJHNNeq1Y7oHWe2M=;
	b=2bNntK2wSSkqMA76yxE+hYolvqqdxzoKsdoRkZswhuHpYCophMLrQZwy6vxLWFeAw7tNUC
	+KHFseyuoIh96jDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FC7A3EA62;
	Mon,  2 Feb 2026 23:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xaxyF3ItgWkGVgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Feb 2026 23:04:18 +0000
Message-ID: <2594023b-b1a5-4752-bb4b-73a4fce4ef5d@suse.de>
Date: Tue, 3 Feb 2026 00:04:16 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Damien Le Moal <dlemoal@kernel.org>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <7ec5f552-197f-48be-9898-9cc4233783fc@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7ec5f552-197f-48be-9898-9cc4233783fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/2/26 02:46, Damien Le Moal wrote:
> On 2/2/26 02:06, Hannes Reinecke wrote:
>> Hi all,
>>
>> We are currently working on implementing cross-controller resets for
>> NVMe, which requires to send a command to the target which then should
>> terminate all commands on a given controller.
>> While we could easily terminate the controller, the specification
>> also requires us to terminate all outstanding commands.
>> Which then recurses into my all-time favourite topic on how to
>> abort outstanding commands from the fs/bio layer.
>>
>> However, here we don't have to dissect/match to individual commands,
>> but rather have to abort everything, which seems rather easier.s
>>
>> So I would like to fathom whether such a thing is feasible/reasonable
>> (I think so, obviously, and can think of several other use-cases, too,
>> qemu springs to mind here ...) and discuss possible implementations
>> (set 'req->deadline' to zero for all pending commands?).
>> Or maybe we can do such a thing already and I'm just not aware of it...
> 
> Hmmm... Command timeouts ? E.g. if a controller is slow to respond (send
> completions), the block layer timeout timer may trigger, which will call into
> the low level device driver to force a reset. But before the reset actually
> happens, completions may actually come back, and we do handle that race
> correctly, well at least for scsi/ata.
> 
> Your scenario sound very similar to this: once you reset the controller,
> whatever was pending will be silent and can be aborted or retried. So it does
> sound like that should not be too difficult, no ? Generalize the timeout
> processing or do something similar ?
> 
The good thing is we don't even need to generalize anything. It should
should be sufficient to walk the inflight requests and set
'rq->deadline' to 'jiffies'. General idea here is to just _initiate_
command termination with this, one then still has to wait for all
commands to complete, but at least now there is a reasonable chance
that this will happen quickly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
