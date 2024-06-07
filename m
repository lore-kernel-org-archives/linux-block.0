Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F919ADA8;
	Fri,  7 Jun 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772811; cv=none; b=J3kEZ1AtINtgQy1KaBdJO+xr+4l2XV2Dhx6+8G+V42vr2zR89NmvBGLvo4nazmEuY5G77q9q2I75HAlfgmEjO+hka6DkXsWl2t1f/lGswm83CHmA89bX6vHeUYhoG1i1/jVveWWzBSh3YAss8vNo5dDXQwt+VlS5E0h1jWTzm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772811; c=relaxed/simple;
	bh=5q5KeN3nK8kY1P0pg+KQs5FbftLLFK48Ksbvdd3ZAT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S47aYbaClNQeENYJAFaPHCTHhQAIszW83Or1VOeAfwfIciL9aFZFGd063kpUNZPg2FkvA1CEiZU9EIJK7sHOEBRbkT7fpqZWWokbQthx8QDRVMAmfT8KkOmf3KSsrUbzAZQYwtwa0JQrJkLaenKcQtKnCQS5nmdsohu7MxtxDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuzBmzq2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mRfVgsn0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuzBmzq2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mRfVgsn0; dkim=neutral (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNlg/biH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kK7KAn+b; dkim=neutral (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNlg/biH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kK7KAn+b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuzBmzq2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mRfVgsn0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuzBmzq2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mRfVgsn0";
	dkim=neutral (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNlg/biH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kK7KAn+b";
	dkim=neutral (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNlg/biH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kK7KAn+b"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 126A12197B;
	Fri,  7 Jun 2024 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717772807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=ECn9IKY+8fmiPsaMpieYBYYu2CDiL7Pa8kNvznWWzJ8=;
	b=uuzBmzq2JB3Nxay4Y6jCN/LYm+Cj/z9mgHJhhEJifQ/mYZ7oADGstUI7v/zz7OZayTIWua
	jF2IFjTb8yldWH6GuaBP2aWsP7fpTVwiT1TOozevMgx1rts3Ji2CK2tXwxF0HLcRX+h8tf
	2IeYXQfc7/m3lBHRefQTJOeHsUYBYY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717772807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=ECn9IKY+8fmiPsaMpieYBYYu2CDiL7Pa8kNvznWWzJ8=;
	b=mRfVgsn031h1LCcbdEc3JAOGw+3O6cJ9I44ExV1C7YrB+jYtqJCiHDoXIpHL5TQxT+y+Fl
	wegLZQ35vcL+voAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717772807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=ECn9IKY+8fmiPsaMpieYBYYu2CDiL7Pa8kNvznWWzJ8=;
	b=uuzBmzq2JB3Nxay4Y6jCN/LYm+Cj/z9mgHJhhEJifQ/mYZ7oADGstUI7v/zz7OZayTIWua
	jF2IFjTb8yldWH6GuaBP2aWsP7fpTVwiT1TOozevMgx1rts3Ji2CK2tXwxF0HLcRX+h8tf
	2IeYXQfc7/m3lBHRefQTJOeHsUYBYY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717772807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=ECn9IKY+8fmiPsaMpieYBYYu2CDiL7Pa8kNvznWWzJ8=;
	b=mRfVgsn031h1LCcbdEc3JAOGw+3O6cJ9I44ExV1C7YrB+jYtqJCiHDoXIpHL5TQxT+y+Fl
	wegLZQ35vcL+voAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1A0D134C7;
	Fri,  7 Jun 2024 15:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u4VyMQYiY2YsFwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 15:06:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: chrubis@suse.cz,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH] loop: Disable fallocate() zero and discard if not supported
Date: Fri,  7 Jun 2024 17:06:44 +0200
Message-ID: <20240607091555.2504-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607091555.2504-1-chrubis@suse.cz>
References: <20240607091555.2504-1-chrubis@suse.cz>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4571405F8; Fri,  7 Jun 2024 09:16:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256) (No client certificate requested) by smtp-out1.suse.de (Postfix) with ESMTPS id A52CC21991; Fri,  7 Jun 2024 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa; t=1717751785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc: mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding; bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=; b=LNlg/biHGPum4Bc4R1OrKDL9eSYMepFT1pXWpUzrN76bDqQzhgmGdvOlLJOfhgOXX2/27y KBDW+uJ4pIq7ITXlS6f/cAWT3juzQjfWdE+ZQ/82pBhKrb3rV7juQBjzltJ5OcG+VPUL7L iw7EyloetoN347RpdJ84PWDJtsl14rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_ed25519; t=1717751785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc: mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding; bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=; b=kK7KAn+bBIHtsosPc98UNh1lRiQxt05qFsr2PkDnQgCOCxLMKJ7n6lbi+HP97WQYr6MryR d0KwLRox+kHE0dBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa; t=1717751785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc: mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding; bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=; b=LNlg/biHGPum4Bc4R1OrKDL9eSYMepFT1pXWpUzrN76bDqQzhgmGdvOlLJOfhgOXX2/27y KBDW+uJ4pIq7ITXlS6f/cAWT3juzQjfWdE+ZQ/82pBhKrb3rV7juQBjzltJ5OcG+VPUL7L iw7EyloetoN347RpdJ84PWDJtsl14rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_ed25519; t=1717751785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc: mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding; bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=; b=kK7KAn+bBIHtsosPc98UNh1lRiQxt05qFsr2PkDnQgCOCxLMKJ7n6lbi+HP97WQYr6MryR d0KwLRox+kHE0dBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256) (No client certificate requested) by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94AFB13A42; Fri,  7 Jun 2024 09:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167]) by imap1.dmz-prg2.suse.org with ESMTPSA id 6nsrI+nPYmZZHQAAD6G6ig (envelope-from <chrubis@suse.cz>); Fri, 07 Jun 2024 09:16:25 +0000
X-Mailer: git-send-email 2.44.2
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A52CC21991
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.06 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MAILLIST(-0.15)[generic];
	SUSE_ML_WHITELIST_VGER(-0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.06
X-Spam-Flag: NO
Message-ID: <20240607150644.urQJIloH7fATxuxPm0Cm8b8-YbTURCpoz6mvhtQFv70@z>

From: Cyril Hrubis <chrubis@suse.cz>

Hi Cyril, all,


> If fallcate is implemented but zero and discard operations are not
nit: s/fallocate/fallcate/

> supported by the filesystem the backing file is on we continue to fill
> dmesg with errors from the blk_mq_end_request() since each time we call
> fallocate() on the loop device the EOPNOTSUPP error from lo_fallocate()
> ends up propagated into the block layer. In the end syscall succeeds
> since the blkdev_issue_zeroout() falls back to writing zeroes which
> makes the errors even more misleading and confusing.

Thanks for looking into this!

FYI this has been in mainline for some time: mentioned for 4.16.0-rc7 [1], later
in v5.19 [2]. Cc also Dave, who back then suggested to remove the warning as not
being useful for users [3].

> How to reproduce:

> 1. make sure /tmp is mounted as tmpfs
> 2. dd if=/dev/zero of=/tmp/disk.img bs=1M count=100
> 3. losetup /dev/loop0 /tmp/disk.img
> 4. mkfs.ext2 /dev/loop0
> 5. dmesg |tail

> [710690.898214] operation not supported error, dev loop0, sector 204672 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.898279] operation not supported error, dev loop0, sector 522 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.898603] operation not supported error, dev loop0, sector 16906 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.898917] operation not supported error, dev loop0, sector 32774 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.899218] operation not supported error, dev loop0, sector 49674 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.899484] operation not supported error, dev loop0, sector 65542 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.899743] operation not supported error, dev loop0, sector 82442 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.900015] operation not supported error, dev loop0, sector 98310 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.900276] operation not supported error, dev loop0, sector 115210 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.900546] operation not supported error, dev loop0, sector 131078 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0

Kind regards,
Petr

[1] https://lore.kernel.org/all/10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com/
[2] https://lore.kernel.org/all/YvZUfq+3HYwXEncw@pevik/
[3] https://lore.kernel.org/all/20220814224440.GR3600936@dread.disaster.area/

> This patch changes the lo_fallocate() to clear the flags for zero and
> discard operations if we get EOPNOTSUPP from the backing file fallocate
> callback, that way we at least stop spewing errors after the first
> unsuccessful try.

> CC: Jan Kara <jack@suse.cz>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  drivers/block/loop.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 93780f41646b..315c76e3ef4a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -320,6 +320,21 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
>  	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
>  		return -EIO;
> +
> +	if (ret == -EOPNOTSUPP) {
> +		struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
> +
> +		if (mode & FALLOC_FL_ZERO_RANGE)
> +			lim.max_write_zeroes_sectors = 0;
> +
> +		if (mode & FALLOC_FL_PUNCH_HOLE) {
> +			lim.max_hw_discard_sectors = 0;
> +			lim.discard_granularity = 0;
> +		}
> +
> +		queue_limits_commit_update(lo->lo_queue, &lim);
> +	}
> +
>  	return ret;
>  }
