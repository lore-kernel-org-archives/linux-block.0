Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611680;
	b=zMdJdkppIHwPMEw5Zrn4qxnbs1hS+Cylh1WxVMkH6tnH8xAKWdNPYA3Hcw5t0ZiczPV4
	 b5BKE5/ASmWr8fvzpIV4EzyzovUNVgLzvPjhRs+DqM0RZMQUDSTTfqMf3TycPlgxLXIBJ
	 /ZTT3Svi3eV0xgEpFaVlUrGMApi7Yi3Rwk8jQCD3j6N7EUCcpTuszhyQjVuLF++XnFGp/
	 1IrW30ejP2YeUE3u+Ht/2X3XSCNoz8fgghMOmWPPErYoScIXnpJAE3rcWVopr80o9koII
	 lexke7ImXl8flRpAcy6z3/05MCmROPP0qpIddkL2d05qMR8VYL0HtfQyk6aIyIYt4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611680;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=0PQKLGQmo+qOMofVV7qp7DPCSriBILDh+6LNhfqBAIw=;
	b=pD8EhQdcWi9Aec1bbKbh+XbMBEHMLbjeHW3CxvA7PmLYWTwSHz13FdjqYuumMWlxB+fs
	 NMZwu8i9vsAuCnmiVkjDmtkDvBlGgpzJjiTxozHDLxznm/EzBt+nZRjdtvE8bDtDs0pYg
	 z2CelRDlIw8QfevFKvQUamPz7xs5eIWH0d+yFmKh2fkf4mwl+TW1Bf2cayavLdotTEHxJ
	 aq0eHwOoSJM+uAIx2VPyCUuFOqlyclmbFWyNfeyNSPZ4vTwJfOGHGi9hQLt9mfjFeVab2
	 Wh+wMZ4OpBNBai7sS+M8KhVPfdzHgxO9SPLGCfBqwEgioAlGTr15KF4G9ZxbPc7NieA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TOHyMzn8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nc+ShyS8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TOHyMzn8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nc+ShyS8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8D606A324;
	Mon,  2 Nov 2026 09:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C8D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TOHyMzn8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nc+ShyS8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TOHyMzn8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nc+ShyS8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1B0F1FC04;
	Mon,  2 Nov 2026 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793611677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PQKLGQmo+qOMofVV7qp7DPCSriBILDh+6LNhfqBAIw=;
	b=TOHyMzn8TmnrQU5tgAov+GA/1VvxIofBLUysJDzXJLZ7dDBBtRU4p+fBwnzOBL+89et0TT
	0gDTVta89xkNBBXjq7RuWef6ckFQaorza4wGuCUMQpAZDbCdkNhNqWmOJTCROumzr0R5Gq
	ErOrT3bNXu295v7i/Hdubidx0V+nh80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793611677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PQKLGQmo+qOMofVV7qp7DPCSriBILDh+6LNhfqBAIw=;
	b=Nc+ShyS8OT/gboDsTJBpxd4fKggLIczzAgvz1QPnqBHV5PcsY3V2R2AEeWHHPvfa3XShGa
	jxha6ck8FwPWl6Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TOHyMzn8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nc+ShyS8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793611677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PQKLGQmo+qOMofVV7qp7DPCSriBILDh+6LNhfqBAIw=;
	b=TOHyMzn8TmnrQU5tgAov+GA/1VvxIofBLUysJDzXJLZ7dDBBtRU4p+fBwnzOBL+89et0TT
	0gDTVta89xkNBBXjq7RuWef6ckFQaorza4wGuCUMQpAZDbCdkNhNqWmOJTCROumzr0R5Gq
	ErOrT3bNXu295v7i/Hdubidx0V+nh80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793611677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PQKLGQmo+qOMofVV7qp7DPCSriBILDh+6LNhfqBAIw=;
	b=Nc+ShyS8OT/gboDsTJBpxd4fKggLIczzAgvz1QPnqBHV5PcsY3V2R2AEeWHHPvfa3XShGa
	jxha6ck8FwPWl6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60936134B3;
	Mon,  2 Nov 2026 09:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CpyODp1X6Gp8cQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Nov 2026 09:27:57 +0000
Message-ID: <1c55b616-d1c5-4929-a4ac-43695ca4f87b@suse.de>
Date: Mon, 2 Nov 2026 10:27:56 +0100
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
Subject: Re: [PATCH 1/2] nvme: remove namespaces in parallel
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
 Nilay Shroff <nilay@linux.ibm.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
 <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com>
 <6e9e6f78-4bd7-46f0-bf57-5c227a65a69e@suse.de>
 <20261102080041.1269654-1-odys.yuan@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261102080041.1269654-1-odys.yuan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B1B0F1FC04
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org,vger.kernel.org,gmail.com,linux.ibm.com,wdc.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.00

On 11/2/26 9:00 AM, Qiliang Yuan wrote:
> On Mon, 2 Nov 2026 08:26:57 +0100, Hannes Reinecke wrote:
>> On 11/2/26 7:14 AM, Qiliang Yuan wrote:
>>> nvme_remove_namespaces() removes the namespaces of a controller one
>>> after another. Each removal waits for RCU grace periods in
>>> del_gendisk() for the namespace and for its multipath head, about
>>> 20 ms in all.
>>>
>> But that isn't changed by calling async_schedule_domain, isn't it?
> 
> Right, each removal still waits about 20 ms. What changes is that the
> waits overlap. A grace period is system-wide, so removals that wait at
> the same time are released by the same grace periods instead of each
> needing its own. Disconnect time over tcp, from the table in the
> patch:
> 
So state that in the patch description.
That'll make it easier for people to understand.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
