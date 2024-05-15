Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1A2746D
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715776184; cv=none; b=pOsyjuto5MOKnsEKA6htk7BiyWDwZODQPnekag7xYinOaeeS1qA8aRqeqMLFK/OnXl6NoRf+rdpFicnKB48MeA3lUj3GSFT3o0ZjVKlKhxRbf6c3FEmzdek0QwMihJxxF0nEVceVJh+gtWVpaHC+j6nZo0JIWKdAnKARktCTvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715776184; c=relaxed/simple;
	bh=hMnZE97sz4PNs81g+gtn7E1KW3J5yoESQxuNxonDQtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqfAiboMyRzTGPqPMvOLxNHeYLZpo28qpyb5sLEuhQwLnM11BxiitlcUi7Ff8WrziiveCHCBpoqyRds6qf5MvZenbDi6dAzbkloHao+sCUNQ8TPrmUzPz5+bgeIeNY9D2XAYdSPTLGDPWAQ16kWXKn45GUDoldrZHw0mU8myOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vLKRXGBW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=InnTaBpf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vLKRXGBW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=InnTaBpf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vLKRXGBW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="InnTaBpf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vLKRXGBW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="InnTaBpf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 655E133B2D;
	Wed, 15 May 2024 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715776180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDxEiP0s8PAkBQnw+i+lCRapnsgB0MGINhLy/UYjPf4=;
	b=vLKRXGBWQkMjYm33bQkkhmHzzTeWJ1FVz9N0uY2VjHsw9WDU0Phm6O4xhV8f7rUA+2VZar
	Oawax2JU/yNjgILiXz/949YgBUx9qGnfbBaLHjFcXcf/xnMRKnbTbvc8iidEDuYP5mpXUO
	OiQUMAiNemYkIw8tRyPZ83V1DAn1iuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715776180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDxEiP0s8PAkBQnw+i+lCRapnsgB0MGINhLy/UYjPf4=;
	b=InnTaBpfQJqkeXFimaar0BE4CbrxWBPzTAG1J05gpJ52BVj4WZMsu2n2zxQxapqlZWRMyX
	wT2Ftar1jue9YMCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715776180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDxEiP0s8PAkBQnw+i+lCRapnsgB0MGINhLy/UYjPf4=;
	b=vLKRXGBWQkMjYm33bQkkhmHzzTeWJ1FVz9N0uY2VjHsw9WDU0Phm6O4xhV8f7rUA+2VZar
	Oawax2JU/yNjgILiXz/949YgBUx9qGnfbBaLHjFcXcf/xnMRKnbTbvc8iidEDuYP5mpXUO
	OiQUMAiNemYkIw8tRyPZ83V1DAn1iuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715776180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDxEiP0s8PAkBQnw+i+lCRapnsgB0MGINhLy/UYjPf4=;
	b=InnTaBpfQJqkeXFimaar0BE4CbrxWBPzTAG1J05gpJ52BVj4WZMsu2n2zxQxapqlZWRMyX
	wT2Ftar1jue9YMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 810F8139B3;
	Wed, 15 May 2024 12:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LigJFbKqRGYAWQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 15 May 2024 12:29:38 +0000
Message-ID: <b0ac6dc3-8c15-4cd4-86f6-47273aa7d417@suse.de>
Date: Wed, 15 May 2024 14:29:32 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] blk-merge: split bio by max_segment_size, not
 PAGE_SIZE
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240514173900.62207-1-hare@kernel.org>
 <20240514173900.62207-4-hare@kernel.org>
 <258db2c1-6c08-467d-a365-6b623c208c85@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <258db2c1-6c08-467d-a365-6b623c208c85@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On 5/15/24 02:20, John Garry wrote:
> On 14/05/2024 11:38, Hannes Reinecke wrote:
>> Bvecs can be larger than a page, and the block layer handles
>> this just fine. So do not split by PAGE_SIZE but rather by
>> the max_segment_size if that happens to be larger.
> Can you check scsi_debug for this series? I took this series only up to 
> this change, and got:
> 
>      Startin[    1.736470] ------------[ cut here ]------------
> g Load [    1.737777] WARNING: CPU: 0 PID: 52 at block/blk-merge.c:581 
> __blk_rq_map_sg+0x46a/0x480
> Kernel Module fu[    1.738862] Modules linked in:
> se...[    1.739370] CPU: 0 PID: 52 Comm: kworker/0:1H Not tainted 
> 6.9.0-00002-g4eaa50af9312-dirty #2416
> 
> [    1.740474] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [    1.741809] Workqueue: kblockd blk_mq_run_work_fn
> [    1.742379] RIP: 0010:__blk_rq_map_sg+0x46a/0x480
> [    1.742939] Code: 17 fe ff ff 44 89 58 0c 48 8b 01 e9 ec fc ff ff 43 
> 8d 3c 06 48 8b 14 24 81 ff 00 10 00 00 0f 86 af fc ff ff e9 02 f0
> [    1.743015] systemd[1]: File System Check on Root Device was skipped 
> because of a failed condition check (ConditionPathIsReadWrite=!/.
> [    1.745122] RSP: 0018:ff37636e4032bb90 EFLAGS: 00010212
> [    1.746419] systemd[1]: systemd-journald.service: unit configures an 
> IP firewall, but the local system does not support BPF/cgroup fi.
> [    1.746891] RAX: 000000000000001c RBX: 00000000000001b0 RCX: 
> ff28e6d8b0950a00
> [    1.747903] systemd[1]: (This warning is only shown for the first 
> unit using IP firewalling.)
> [    1.748549] RDX: ff7662becb4ac482 RSI: 0000000000001000 RDI: 
> 00000000fffffffd
> [    1.749688] systemd[1]: Starting Journal Service...
> [    1.749895] RBP: ff7662becb4abf80 R08: 0000000000000000 R09: 
> ff28e6d880fadd40
> [    1.750965] R10: ff7662becb4ac480 R11: 0000000000000000 R12: 
> 0000000000000000
> [    1.750966] R13: 0000000000000002 R14: 0000000000001000 R15: 
> ff7662becb4ac480
> [    1.750970] FS:  0000000000000000(0000) GS:ff28e6da75c00000(0000) 
> knlGS:0000000000000000
> [    1.750972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.750973] CR2: 00007f7407f19000 CR3: 0000000100f24002 CR4: 
> 0000000000771ef0
> [    1.750974] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [    1.750975] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [    1.750976] PKRU: 55555554
> [    1.750977] Call Trace:
> [    1.750984]  <TASK>
> [    1.750986]  ? __warn+0x7e/0x130
> [    1.750992]  ? __blk_rq_map_sg+0x46a/0x480
> [    1.750994]  ? report_bug+0x18e/0x1a0
> [    1.750999]  ? handle_bug+0x3d/0x70
> [    1.751003]  ? exc_invalid_op+0x18/0x70
> [    1.751006]  ? asm_exc_invalid_op+0x1a/0x20
> [    1.751009]  ? __blk_rq_map_sg+0x46a/0x480
> [    1.751012]  scsi_alloc_sgtables+0xb7/0x3f0
> [    1.751019]  sd_init_command+0x177/0x9d0
> [    1.751023]  scsi_queue_rq+0x7c1/0xae0
> [    1.751027]  blk_mq_dispatch_rq_list+0x2bc/0x7c0
> [    1.751031]  __blk_mq_sched_dispatch_requests+0x409/0x5c0
> [    1.751035]  blk_mq_sched_dispatch_requests+0x2c/0x60
> [    1.751037]  blk_mq_run_work_fn+0x5f/0x70
> [    1.751039]  process_one_work+0x149/0x360
> 
> I suspect that you would need to also change the PAGE_SIZE check in 
> __blk_bios_map_sg() also. However, I am not confident that the change 
> below is ok to begin with...
> 
> BTW, scsi_debug does use an insane max_segment_size of -1
> 
Can you try with this patch?

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 570573d7a34f..5da63180069e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,7 +278,10 @@ struct bio *bio_split_rw(struct bio *bio, const 
struct queue_limits *lim,
         struct bio_vec bv, bvprv, *bvprvp = NULL;
         struct bvec_iter iter;
         unsigned nsegs = 0, bytes = 0;
-       unsigned bv_seg_lim = max(PAGE_SIZE, lim->max_segment_size);
+       unsigned bv_seg_lim = PAGE_SIZE;
+
+       if (lim->max_segment_size < UINT_MAX)
+               bv_seg_lim = lim->max_segment_size;

         bio_for_each_bvec(bv, bio, iter) {
                 /*

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

