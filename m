Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60033240235;
	Tue, 14 Jan 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736839274; cv=none; b=hRIbnb/D2CrsgIhyJ5ot2D9To8oRyWoOqBuT+ff5HJHpXYF5cz7JmaXoQbezhCHaRckT0W2zqn7YGHlMdtHHFXHuViWyD58bRMYsedqSVcC10f+b7ZiLz3OopfTFet81Pucz87E2k3dweUp9SiOIHT9+dBBijK8wayaD7XAH5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736839274; c=relaxed/simple;
	bh=fgZx1/X61tOWOxwz3mnp2UPbgjNiT0iHg9QuZupp3Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7Qk1ZR+trdwfxktnlI+GKdi11cucKmU+QfYBrclSw2Scd6NVXOJetWiz15ZVV8G988eBPhWYdhq+Gog5EiB32gZkAokY+fBUOjK7XR7xC8fSqIk22U8MsucyYe6H9DjPWzEzs7nkkPuDtXm+Li+BeQChf1oP13vWuV4TlmTDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G0vhf5us; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEHAp20T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G0vhf5us; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEHAp20T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G0vhf5us";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEHAp20T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G0vhf5us";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEHAp20T"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1ABE21167;
	Tue, 14 Jan 2025 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736839264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8BbQhpkPK4RecbS8C1NA2fPySOY4nrXYalGoknSOjs=;
	b=G0vhf5us2LseCZHFwPevt2yBaRuE+KLEzUIaqwJraEKuq3VPLgM1KRGdlHl2E0BpCdLfun
	0KghLc5dmyRK2aW2ydSfWZ9HPorCii6lnFrL3CFEm6Vh1XIZ+G8vOEEWh1H7MUHwdduNmx
	8hU8dGG2qxVbKXfqMRcHM/xD1m/Tnyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736839264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8BbQhpkPK4RecbS8C1NA2fPySOY4nrXYalGoknSOjs=;
	b=nEHAp20TKBCOsEBpdVWjsOdLmQyJEQzDkJEF2uDK3uwaU5B0xdAeUroKfINYSE/p6Ur7D4
	pC720H6X9XpMt3Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G0vhf5us;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nEHAp20T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736839264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8BbQhpkPK4RecbS8C1NA2fPySOY4nrXYalGoknSOjs=;
	b=G0vhf5us2LseCZHFwPevt2yBaRuE+KLEzUIaqwJraEKuq3VPLgM1KRGdlHl2E0BpCdLfun
	0KghLc5dmyRK2aW2ydSfWZ9HPorCii6lnFrL3CFEm6Vh1XIZ+G8vOEEWh1H7MUHwdduNmx
	8hU8dGG2qxVbKXfqMRcHM/xD1m/Tnyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736839264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8BbQhpkPK4RecbS8C1NA2fPySOY4nrXYalGoknSOjs=;
	b=nEHAp20TKBCOsEBpdVWjsOdLmQyJEQzDkJEF2uDK3uwaU5B0xdAeUroKfINYSE/p6Ur7D4
	pC720H6X9XpMt3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 813CC139CB;
	Tue, 14 Jan 2025 07:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9KvhHWAQhmd/UAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 14 Jan 2025 07:21:04 +0000
Message-ID: <abd5921f-a37f-4736-b1b4-920a5c108f71@suse.de>
Date: Tue, 14 Jan 2025 08:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: no show partitions if partno corrupted
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67841058.050a0220.216c54.0034.GAE@google.com>
 <tencent_E820E9DAED3ACC3079BA6F3C2E896FA4950A@qq.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <tencent_E820E9DAED3ACC3079BA6F3C2E896FA4950A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1ABE21167
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[fcee6b76cf2e261c51a4];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[qq.com,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 1/14/25 03:28, Edward Adam Davis wrote:
> syzbot reported a global-out-of-bounds in number. [1]
> 
> Corrupted partno causes out-of-bounds access when accessing the hex_asc_upper
> array.
> 
> To avoid this issue, skip partitions with partno greater than DISK_MAX_PARTS.
> 
> [1]
> BUG: KASAN: global-out-of-bounds in number+0x3be/0xf40 lib/vsprintf.c:494
> Read of size 1 at addr ffffffff8c5fc971 by task syz-executor351/5832
> 
> CPU: 0 UID: 0 PID: 5832 Comm: syz-executor351 Not tainted 6.13.0-rc6-next-20250107-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:489
>   kasan_report+0x143/0x180 mm/kasan/report.c:602
>   number+0x3be/0xf40 lib/vsprintf.c:494
>   pointer+0x764/0x1210 lib/vsprintf.c:2484
>   vsnprintf+0x75a/0x1220 lib/vsprintf.c:2846
>   seq_vprintf fs/seq_file.c:391 [inline]
>   seq_printf+0x172/0x270 fs/seq_file.c:406
>   show_partition+0x29f/0x3f0 block/genhd.c:905
>   seq_read_iter+0x969/0xd70 fs/seq_file.c:272
>   proc_reg_read_iter+0x1c2/0x290 fs/proc/inode.c:299
>   copy_splice_read+0x63a/0xb40 fs/splice.c:365
>   do_splice_read fs/splice.c:985 [inline]
>   splice_direct_to_actor+0x4af/0xc80 fs/splice.c:1089
>   do_splice_direct_actor fs/splice.c:1207 [inline]
>   do_splice_direct+0x289/0x3e0 fs/splice.c:1233
>   do_sendfile+0x564/0x8a0 fs/read_write.c:1363
>   __do_sys_sendfile64 fs/read_write.c:1424 [inline]
>   __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Reported-by: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fcee6b76cf2e261c51a4
> Tested-by: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   block/genhd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 9130e163e191..8d539a4a3b37 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -890,7 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
>   
>   	rcu_read_lock();
>   	xa_for_each(&sgp->part_tbl, idx, part) {
> -		if (!bdev_nr_sectors(part))
> +		int partno = bdev_partno(part);
> +
> +		if (!bdev_nr_sectors(part) || partno >= DISK_MAX_PARTS)
>   			continue;
>   		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
>   			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
Maybe a warning is in order; when we are hitting this issue it means
that linux has a limitation on causing it to ignore the (otherwise 
valid) partition entry.

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
