Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE4288522
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170086; cv=none; b=etmrA57L3KT2rsaTViNd/Iv6wwbRTm483q7K+IKwO5P2PnN0cfv1FOYzPUvVw11dnxenQPclLv3sHr6m2bAuXmLZwMleTEB3kW7AaEtT5H+7YVwu/Z87Bq0r46vstPUSmKPt/YdpaWivh1VmRv596pn7bSvz2C3pSrJAz8JcXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170086; c=relaxed/simple;
	bh=NLPFJAq9RDDV7RlMq2TKhkq8x9LqAZLW2s8SzHQEcWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgY0y7T700eSZNsu2IWyEiigY/hBl5XpRWe/JwFO+wT4r6ixPyTltEG5rjM4ERe+mf7NQKQ+82GHl9/JvjjSbIzRBPbFnBauGLkprZTUwCorKkZSZedYK69X3VxKS/o+8CDbIiunNyhgKfOwIRfq8eHNmzdYLUQI6NcV22ubufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LhgQP24u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uh9YDwP3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LhgQP24u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uh9YDwP3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LhgQP24u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uh9YDwP3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LhgQP24u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uh9YDwP3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FA073E6D1;
	Wed,  4 Feb 2026 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1ZYjNV2X28rMeAM+PFo3TqTGHBUzQa6SKV+CQkZEOQ=;
	b=LhgQP24ueHurwisRL7JFwM/de9O1ovAMkjuKoGjl6zImQUTev/JploBIt3IGPmCpVtKW3O
	PvpicrwOKuTPOv3c4APzw48PCrlaLWacq5jWIYefnb/wb7gnbkUQby/pWyMJBWON9qI2n7
	FC4bNC5DXRRdx9Zbn5zaBsRsApRMfMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1ZYjNV2X28rMeAM+PFo3TqTGHBUzQa6SKV+CQkZEOQ=;
	b=uh9YDwP3nYTqAJDPV5VDeK48YvEtwRg5eaoB25Ne7Ax9KaY9yHHDZc1pVz8cGDGhPS4nUj
	POJpniJts3rHYPDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LhgQP24u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uh9YDwP3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1ZYjNV2X28rMeAM+PFo3TqTGHBUzQa6SKV+CQkZEOQ=;
	b=LhgQP24ueHurwisRL7JFwM/de9O1ovAMkjuKoGjl6zImQUTev/JploBIt3IGPmCpVtKW3O
	PvpicrwOKuTPOv3c4APzw48PCrlaLWacq5jWIYefnb/wb7gnbkUQby/pWyMJBWON9qI2n7
	FC4bNC5DXRRdx9Zbn5zaBsRsApRMfMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1ZYjNV2X28rMeAM+PFo3TqTGHBUzQa6SKV+CQkZEOQ=;
	b=uh9YDwP3nYTqAJDPV5VDeK48YvEtwRg5eaoB25Ne7Ax9KaY9yHHDZc1pVz8cGDGhPS4nUj
	POJpniJts3rHYPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA5CA3EA63;
	Wed,  4 Feb 2026 01:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nuG6HuCmgmlrMgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:54:40 +0000
Message-ID: <ed53063e-fe45-47b4-8614-481a720f6a69@suse.de>
Date: Wed, 4 Feb 2026 02:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/8] blk-mq: add a new queue sysfs attribute
 async_depth
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
Cc: bvanassche@acm.org
References: <20260203081952.732210-1-yukuai@fnnas.com>
 <20260203081952.732210-5-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203081952.732210-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4FA073E6D1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 2/3/26 09:19, Yu Kuai wrote:
> Add a new field async_depth to request_queue and related APIs, this is
> currently not used, following patches will convert elevators to use
> this instead of internal async_depth.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-core.c       |  1 +
>   block/blk-mq.c         |  6 ++++++
>   block/blk-sysfs.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
>   block/elevator.c       |  1 +
>   include/linux/blkdev.h |  1 +
>   5 files changed, 51 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
