Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8A471252
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099579; cv=none; b=PyQntRdGDVayt4ZbfA4A/0190ZWzMRYHL1s0/uJR5wD2XvpVpmpy1ZL7CDY4sXBLshIMW+J15MMc+TpKKJGf8E0eWdI8fm3/VM67f5r2vaIy0wiQDe3gVI+UgXq4f6Zk5ajmVDY7+7aZApISg7er0+AzikbsPfs3vtbxQDsNLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099579; c=relaxed/simple;
	bh=f6Adjjf1kjOTkfAPuwiYDWHda7DX9XswFtEdlRNrlp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEyXBhHzANfCOI618ZPjDGx5RuhQCSrOvx1fOdhDc0DUVwPwsMbbBrSKAu0wJ+5GdNDLNfJ9CeArzZuKJahFcpXNjoCv1MynNbtZy8Oqv+LD+lNz2E01xeo7PSp6byF9nILwJ7XnoSLK9vEnjT8fEQNGh0if9CzCOHs2ZW5Oo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZpwWLxfY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3uX2c3Oi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WUiT4nsK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WN4yhr9b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZpwWLxfY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3uX2c3Oi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WUiT4nsK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WN4yhr9b"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0C033E06;
	Fri,  7 Aug 2026 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786099571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddh/60r6dXEzZocG9IJ4DwkQY/r9mhHUKNF/ygHT81s=;
	b=ZpwWLxfYXA73KHh/MBzp+p7hSHmpjlu85KMVYVwDVJ5G8p5VQNDjQOQv6YWRCDlxRSUlnr
	N+uJKDeqZCEgI9MwgfCcn2KaYclefcNjSUnA41M9K3bnOpTBXzTJCPY/jy4Za5pIgmMvY9
	HSnlAaQgRIQlOZxr6F5COtkYRfM99L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786099571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddh/60r6dXEzZocG9IJ4DwkQY/r9mhHUKNF/ygHT81s=;
	b=3uX2c3OiJBTGPj5+kSL3GGKqPQK/S7fK29jtpi3GFfHuJVjvz031mJz5aHeLk/CgwahGYa
	GiqnfjXczzMLf7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786099566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddh/60r6dXEzZocG9IJ4DwkQY/r9mhHUKNF/ygHT81s=;
	b=WUiT4nsKfYSD0HcfWO/rw2SHZGPo3lYLcEbVaga4fuRXu2CVEb35Lz7e+F2G1P7nF2PGjP
	RPSheSjW6grdErgN1yYKVCe87VPQ0hByKsYfnW+CZ5poCroUoQFaomw4uYu9CaxxXOwb9w
	GveELdMZRIgiFOnTcr1hbYMHr5XSb30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786099566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddh/60r6dXEzZocG9IJ4DwkQY/r9mhHUKNF/ygHT81s=;
	b=WN4yhr9bueyRCEU9GksL0ymmcLuPs9lRir8007OsYbKtPmklxOBIMLbG8XARMvv6qVk14P
	brqknJEI4ej2cRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D85BB779B6;
	Fri,  7 Aug 2026 10:46:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VhHwM263dWr9VQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 10:46:06 +0000
Message-ID: <d6b95a4a-6cbc-46ac-8e7e-12ef8588447c@suse.de>
Date: Fri, 7 Aug 2026 12:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] block: always treat offline and read-only zones
 as dead
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-10-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> Since any write BIO targeting an offline or a read-only zone will fail,
> there is no point in keeping zone write plugs for these zones.
> So for any offline or read-only zone, the zone write plug should always
> be treated as dead.
> 
> Do this by modifying disk_check_zone_wplug_dead() to always mark read-only
> and offline zones as dead to force a removal of the zone write plug from
> the disk hash table on BIO submission. blk_zone_wplug_prepare_bio() is
> also modified to have the same checks to immediately fail a write BIO
> targeting a read-only or offline zone. With these two changes, any newly
> issued or unplugged write BIO targeting a read-only or offline zone is
> immediately failed.
> 
> Finally, disk_zone_wplug_sync_state() is modified to add a call to
> disk_mark_zone_wplug_dead() for the zone write plug of any read-only or
> offline zone found during zone revalidation or a report zones.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 113 +++++++++++++++++++++++++---------------------
>   1 file changed, 61 insertions(+), 52 deletions(-)
> 
Makes one feeling sorry for filesystems having to deal with this ..

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
