Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106F42E8D4
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103526; cv=none; b=UbJlz0TcNYBWinj4U6uujioAi+wcE1bpPlovlysTjpl56h/HpX5YXG+GSu6Q7dIczhThMOTrzB8blMItcX76Ty5sWF2QuM8/at267fJ1/8gmIYOpL9yOk4BSIyetxk/4DTu1QbHP6+ctHDXTcy/UM8BRT2MisquHh+QZjBINfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103526; c=relaxed/simple;
	bh=8KzAMTLpgYZK/S9pLY6i78yDAr/XOR53KgOSE1J9Nqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0fqVNV43v/T9+5Vnn2sGo5KfOay+uYbLjxnPxw8Y3MFffMu93dONm09v3uN9MWn2m67eYFAclW7CKCSWo6AmAtBL3hrwyCH/vXzzxP0TEEGqPZ4eJCgipqoVd+6wEOZLv9uFFuc9gcRIazFmGvAZldsUpXIZkjjN2NDshEPt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XCEbP+2u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=muSZwVOH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iN/nwMQu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q8hI7Hxm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XCEbP+2u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="muSZwVOH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iN/nwMQu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q8hI7Hxm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FA1C3E10;
	Fri,  7 Aug 2026 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786103507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiGUIWhsq8yqJggblqf9IvZha6ZOqr+DsufWSLEBJcQ=;
	b=XCEbP+2udRUuTkWT5UZG6DbuLqejD8KsSZao8RPOykKveqpVc24cd9GzezPUVsrgrSjB68
	6hqYA1kfqjJboFCYI5warES7UlwnuU0i55WjZLi1tntfPCMjaQV2DJ6kQpOb7s/R9QNaEw
	KTrhOS0rUwdMuO/FvEtCYclOwCSp8Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786103507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiGUIWhsq8yqJggblqf9IvZha6ZOqr+DsufWSLEBJcQ=;
	b=muSZwVOHVKS8X4Fvc2ZwxrLV4yDPBdEzz+WtVQ+6kT0slpEvwxgGfV3Kg4swFqBEqSBhgA
	xv3NnQ2LWLeEM4Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="iN/nwMQu";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q8hI7Hxm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786103503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiGUIWhsq8yqJggblqf9IvZha6ZOqr+DsufWSLEBJcQ=;
	b=iN/nwMQu78gA7JJx1OaIVQjnE3E+bL7DUzVzUMPX3fxZOKPtNQdK7FUvom7dnv4mEHalDA
	8EG4jPTaUB67bDgBdK3BcTMQ6njPYZLaVEcwA3ppTw9WNQN6wMOtjzdxKTmH7gFcV0Xovj
	FQaM/SXXmzSDHblkRGviyezMoqVvxD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786103503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiGUIWhsq8yqJggblqf9IvZha6ZOqr+DsufWSLEBJcQ=;
	b=q8hI7HxmnJnQj9U/HgCgls9CQxcuZd2dyKv1aUXVofvShEShIlTY+NMpfwZ83BiJRma8qm
	KqjWtOFsaW6dyrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6542A779B6;
	Fri,  7 Aug 2026 11:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b7QIGM/GdWqSFwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 11:51:43 +0000
Message-ID: <7425b2ed-520a-4908-bdd5-0b76125c3481@suse.de>
Date: Fri, 7 Aug 2026 13:51:43 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] block: simplify disk_zone_set_cond()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-13-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-13-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7FA1C3E10
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> disk_zone_set_cond() is used to set a zone condition afer a reset, a

afer -> after

> finish or a reset all operation. For a single zone reset or finish, we are
> guaranteed that the target zone is a sequential one that is not offline
> nor read-only (otherwise, the operation would have failed). For a reset
> all operation, there is no point in calling this function for offline and
> read-only zones since the condition checks in disk_zone_set_cond() will
> result in nothing being done.
> 
> Simplify all this using disk_zone_is_offline_or_readonly() in
> blk_zone_reset_all_bio_endio() to skip zones that are offline or
> read-only. This change allows simplifying disk_zone_set_cond() by removing
> the zone condition checks. This change is also consistent with the fact
> that conventional zones can now have the offline or read-only condition.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
