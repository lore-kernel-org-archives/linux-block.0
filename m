Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A17383C77
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436044; cv=none; b=oPCcdb4rv/biVjAZnbRWeuyYofAbpYNQe6BHrmT5pTJkaH3/fwop/b6VDrW++4YsEQCioFojzeh9eMGdSPs1SoLSgDLI2nekypNMw/oRPMMbUuqKlSDwheSRDuFM33V5EbcWUNg8Vu/KAtCNglqsIjud73lQf83RydA1Ys/LSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436044; c=relaxed/simple;
	bh=iFPYuE9g0LHaAQiUOno1EXvlejLQcXb+lbCfHqepVbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tIyUawhEQn7/Fdjx7q5UaT8FmUfmTBXzURLG8ObSDTJlckn/ykdbVPNQ2Bk8Tj1lHtCu85aJvoltnGwD5YOT5qgd6S4uCT/4kUvM0YuHT0w25LbgkcNXHpsXY0k6RGFuZSQ3zZvo0+zIoBNxB5fD7XZTHHLmjWYr4A/jhdSLOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XOsoRcJ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=izgpo244; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A5wNukl/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VnF0a/UP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XOsoRcJ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="izgpo244";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A5wNukl/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VnF0a/UP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04F383F92C;
	Mon,  2 Mar 2026 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGeL8v0p78l8EwCfuKInqU2idD4c103bSy/B3Rn4c4A=;
	b=XOsoRcJ0DlzT7PWbGDus1vqn2b9yqQs8ijoxZKvXWk19H/ZrTsHbmEOBqLYTZkZoOa3YTx
	kzxUr/PGBf6lgyX2u1x1kkAwFJdAKTnQe9XEggCVkpHARL/iyPx/T/64FfqpoBIxlg1QrX
	tP0KffCH+d54oRi6iXIbndY6yXRUSo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGeL8v0p78l8EwCfuKInqU2idD4c103bSy/B3Rn4c4A=;
	b=izgpo244Ln6KN8vDli/trnYCaHbKRM/IlnSrw6b4SaWTmOsnBF8KgRsjd5lPoYyy1WKfGb
	vN+Xq4nb2BSfVuDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGeL8v0p78l8EwCfuKInqU2idD4c103bSy/B3Rn4c4A=;
	b=A5wNukl/iVFKU2URzIDGWbU9Zv2vLUiB/iwSQeI5K3BfZ7YQoxJiPKYGXMvXB3hfjWYbeK
	uanZEd6g8rhgMNgu3E55klVUsR4+a27mqsyuc3/xxPmOZ/1ysoGi7f2/Etk9O+2zZMKyCT
	uKZt/XmPozSoLdOWUPOxNF8Sv9DwGKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGeL8v0p78l8EwCfuKInqU2idD4c103bSy/B3Rn4c4A=;
	b=VnF0a/UPoWLQRRsXNyMIfSNHBrlnnAoPJr47jbilFOUgceAGVKcIl66TojcqtmBXW9ME5D
	Rxi7IlMZpBNoL3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D17783EA69;
	Mon,  2 Mar 2026 07:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k6obMUc6pWkDawAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 07:20:39 +0000
Message-ID: <de495466-93aa-427f-8655-7dd0dc643bb7@suse.de>
Date: Mon, 2 Mar 2026 08:20:39 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] block: fix zone write plug removal
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260227014951.2327711-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 2/27/26 02:49, Damien Le Moal wrote:
> Commit 7b295187287e ("block: Do not remove zone write plugs still in
> use") modified disk_should_remove_zone_wplug() to add a check on the
> reference count of a zone write plug to prevent removing zone write
> plugs from a disk hash table when the plugs are still being referenced
> by BIOs or requests in-flight. However, this check does not take into
> account that a BIO completion may happen right after its submission by
> a zone write plug BIO work, and before the zone write plug BIO work
> releases the zone write plug reference count. This situation leads to
> disk_should_remove_zone_wplug() returning false as in this case the zone
> write plug reference count is at least equal to 3. If the BIO that
> completes in such manner transitioned the zone to the FULL condition,
> the zone write plug for the FULL zone will remain in the disk hash
> table.
> 
> Furthermore, relying on a particular value of a zone write plug
> reference count to set the BLK_ZONE_WPLUG_UNHASHED flag is fragile as
> reading the atomic reference count and doing a comparison with some
> value is not overall atomic at all.
> 
> Address these issues by reworking the reference counting of zone write
> plugs so that removing plugs from a disk hash table can be done
> directly from disk_put_zone_wplug() when the last reference on a plug
> is dropped.
> 
> To do so, replace the function disk_remove_zone_wplug() with
> disk_mark_zone_wplug_dead(). This new function sets the zone write plug
> flag BLK_ZONE_WPLUG_DEAD (which replaces BLK_ZONE_WPLUG_UNHASHED) and
> drops the initial reference on the zone write plug taken when the plug
> was added to the disk hash table. This function is called either for
> zones that are empty or full, or directly in the case of a forced plug
> removal (e.g. when the disk hash table is being destroyed on disk
> removal). With this change, disk_should_remove_zone_wplug() is also
> removed.
> 
> disk_put_zone_wplug() is modified to call the function
> disk_free_zone_wplug() to remove a zone write plug from a disk hash
> table and free the plug structure (with a call_rcu()), when the last
> reference on a zone write plug is dropped. disk_free_zone_wplug()
> always checks that the BLK_ZONE_WPLUG_DEAD flag is set.
> 
> In order to avoid having multiple zone write plugs for the same zone in
> the disk hash table, disk_get_and_lock_zone_wplug() checked for the
> BLK_ZONE_WPLUG_UNHASHED flag. This check is removed and a check for
> the new BLK_ZONE_WPLUG_DEAD flag is added to
> blk_zone_wplug_handle_write(). With this change, we continue preventing
> adding multiple zone write plugs for the same zone and at the same time
> re-inforce checks on the user behavior by failing new incoming write
> BIOs targeting a zone that is marked as dead. This case can happen only
> if the user erroneously issues write BIOs to zones that are full, or to
> zones that are currently being reset or finished.
> 
> Fixes: 7b295187287e ("block: Do not remove zone write plugs still in use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 151 +++++++++++++++++-----------------------------
>   1 file changed, 57 insertions(+), 94 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
