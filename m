Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264288;
	b=k8+gV0PwDUzWBuOigcdEnePnjHPUX2qwrOYmuakXZ71g7+1eKKatnHINIFWv4yVdcSkZ
	 kxh4+vxteMr7kd7IZbQO2Nkr2V8vlmGNIyPE+SSKQjHS98xEagtd815xR800s9XKrXnXn
	 nzEIxSV0dEy7x5GT0cfakELvCVog+MF/elvEHsn6avfK20hnShZKx0b4ntHBxGkcyGwyW
	 XaHX0Id9GuTVzg9QZsx6+W+1CQgLr3MvHHoVPH0qIGdLoyJMWbkL1eQ1sTlV4If4OxFEM
	 MS28KIEbRGSsMI4wFogSpMfByHCthCmZYJMwKDK5IJcXxlrRfJtiZz3/TZH0c5GmjJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264288;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=RgC2R66jfw+lgFc8ruIURA93xAUuOwGu3ULASn+zPa8=;
	b=MoohFtJy6IgdS/3qTFNRnl3JIUwQovMDID/x1qH0eVlL3QlluQu0jCw7ikZepwhhKSdb
	 TpI1w/OJAdABFuyfiP9w0+iqizvACxdkCTaJclKUrduUbm5++bqDloA4IBUwph3M4q/rl
	 r70ezgYrFVzS/6mwpxF0sa1oVZyWmKX5xfXDWCy9xUpNJdohsg/p9cSOaVcxUnQf14p3J
	 xbBbB6p4BHxaOmCikCw/KrCWD974x1dfxuCrQVdOhq6hZcCtFydFTGMH22FqNRAa34RPJ
	 jNlsX+mUdfDRiPVGl+RpNZDP8roGLE/U7DSuAADHdPgOE0KHT7GarnjndMVQXhQAnhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDoaiLDO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z1aY6onN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDoaiLDO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z1aY6onN;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD28606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 08:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD28606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDoaiLDO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z1aY6onN;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDoaiLDO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z1aY6onN
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6EF51FAAC;
	Thu, 29 Oct 2026 08:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793264285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgC2R66jfw+lgFc8ruIURA93xAUuOwGu3ULASn+zPa8=;
	b=MDoaiLDO0nYiptpr37TUJeZdvN7h/HyhzGUV7nfXCG4IyfzfuacDtJi4iNP5vJPruSOte0
	h8V5TErNgYGhQhbyPu9JXG7DNk7IjQ2RPg4g9y33gH944x3TzEeTQ7lu9Nudv/FgGkhRrm
	V3iT/YQ2/zWlo6AoLzFNiokBWcxwTJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793264285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgC2R66jfw+lgFc8ruIURA93xAUuOwGu3ULASn+zPa8=;
	b=Z1aY6onNbc1iCjRhKlye3O+lLRdauJu/uNcFJNnvZ1zKIge/WpO+g3SnArKGzWO1xihWgb
	U8WDILOCesiC+MCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793264285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgC2R66jfw+lgFc8ruIURA93xAUuOwGu3ULASn+zPa8=;
	b=MDoaiLDO0nYiptpr37TUJeZdvN7h/HyhzGUV7nfXCG4IyfzfuacDtJi4iNP5vJPruSOte0
	h8V5TErNgYGhQhbyPu9JXG7DNk7IjQ2RPg4g9y33gH944x3TzEeTQ7lu9Nudv/FgGkhRrm
	V3iT/YQ2/zWlo6AoLzFNiokBWcxwTJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793264285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgC2R66jfw+lgFc8ruIURA93xAUuOwGu3ULASn+zPa8=;
	b=Z1aY6onNbc1iCjRhKlye3O+lLRdauJu/uNcFJNnvZ1zKIge/WpO+g3SnArKGzWO1xihWgb
	U8WDILOCesiC+MCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7520D1339F;
	Thu, 29 Oct 2026 08:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D9OKFJ0K42oRZAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 08:58:05 +0000
Message-ID: <b42a092f-4e8b-49d7-8582-670155795855@suse.de>
Date: Thu, 29 Oct 2026 09:58:05 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 48/98] nvmet-tcp: rewind the iterator after non-data
 records
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-49-axboe@kernel.dk>
 <20261028195731.1591331-6-bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028195731.1591331-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29

On 10/28/26 8:57 PM, Bart Van Assche wrote:
> On 10/28/26 09:41, Jens Axboe wrote:
>>   	case TLS_RECORD_TYPE_ALERT:
>> +		iov_iter_revert(&msg->msg_iter, len);
>>   		tls_alert_recv(queue->sock->sk, msg, &level, &description);
> ...
>>   		if (queue->tls_pskid) {
>>   			ret = nvmet_tcp_tls_record_ok(cmd->queue,
>> -					&cmd->recv_msg, cmd->recv_cbuf);
>> +					&cmd->recv_msg, cmd->recv_cbuf, len);
> 
> Rewinding msg_iter fixes the iterator advance, but TLS_RECORD_TYPE_ALERT
> is still broken in two ways here:
> 
> 1. In nvmet_tcp_try_recv_data(), cmd->recv_msg.msg_iter is an ITER_BVEC
>     initialized with iov_iter_bvec(), whereas tls_alert_recv()
>     (net/handshake/alert.c) unconditionally reads union member
>     msg->msg_iter.kvec->iov_base. For an ITER_BVEC, iov->iov_base aliases
>     bvec->bv_page (struct page *), so tls_alert_recv() reads the first
>     two bytes of struct page instead of the received alert payload and
>     silently ignores fatal alerts when byte 0 != TLS_ALERT_LEVEL_FATAL.
>     (Also, up to 2 bytes of the command's SG page were overwritten before
>     iov_iter_revert().)
> 
> 2. If queue->left == 1 when a 2-byte TLS alert arrives, sock_recvmsg()
>     returns len == 1, and tls_alert_recv() reads data[0] and data[1]
>     without checking len >= 2.
> 
> tls_alert_recv() either needs to handle non-kvec iterators and len < 2
> properly, or nvmet-tcp should treat any TLS alert record during live
> PDU/data transfer as fatal without calling tls_alert_recv() on
> cmd->recv_msg.
> 
There is a larger rework under way for handling TLS alerts, so we
should defer this until the rework is merged.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
