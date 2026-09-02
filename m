Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1943B05B9;
	Wed,  2 Sep 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353574; cv=none; b=q43UUDGVQhUKf35o8i0Y9zbYsWxzuOr3lOAaCRuZQtsfdFj/t5b6YJxpUSZDvuCcL9wU1vs+TpG+QZLdVOOvGXlOcRsbcs1AcfTlwYaBMw36lu7ofuK3Z5u3hVaiWTITqDbyWodSr/6zgwsiyVGbRizlvqD5LQsUl5FodBc0HAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353574; c=relaxed/simple;
	bh=iNY2PsrjJ41qPmKkJcbwjcamy3MPcWd9C3cQZ8uQQgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAJZj0xGDAHaadYwaJ8zKc8vHRbYuhPeM9T9A7Cd+igtHzm0m+NW8hdA0JNnaud/I+kagA2SYLczIcCGAHDPMIwpX/RARh5XV8EQT+3IGta0JRuZmp/MZz+XHjYgTRo+E14okFpv/qpiS7wsf/Zdc/C8OmU/rXnnEKkPY3QMOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZnrE2wjp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wms9o4Iy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qGTP0gxP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p82kxfQc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZnrE2wjp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wms9o4Iy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qGTP0gxP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p82kxfQc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B230321CCC;
	Wed,  2 Sep 2026 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788353566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P967ebjBPN7pzqwkyb0E3k3uYf3DEa4qKX5H/x03Qfc=;
	b=ZnrE2wjpDIlYDUDUWfQ1oFuv/7v/HEY95TYUB4b7IhZn7TaQ19IawybCpwhmRGXXqqDRS1
	qm83kOlLeMqyETKNLyStpiCtNDPlGwwHT20YnaOn8ta/H/m89InPpNHf5A9VPk4Sr1YVI6
	Xej2/PtgND6bSVM53ttOSHpAqDF5GIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788353566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P967ebjBPN7pzqwkyb0E3k3uYf3DEa4qKX5H/x03Qfc=;
	b=Wms9o4Iy1ZQQuiU4FQUOnmkP6qbD+M6upjFQ3vwH9DuFZLFEgOdIWZga0bi0Kl9IJNEduo
	QvOE38G7XQ5vKEBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788353562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P967ebjBPN7pzqwkyb0E3k3uYf3DEa4qKX5H/x03Qfc=;
	b=qGTP0gxPD9C+aeR5UFgqlEiyH2S4KIFOAu334db750ZQeke1+c2KrYdHxTynk7VQU5b/dV
	JsTC5z/EfV9BcUIifxw929BXI5t00vpJp3wP1tOY+sY0rGhn32y0IfiweCr27bktsOE+MY
	5UwS/h0NLhaJKS+WG3+XvV48RWee0Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788353562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P967ebjBPN7pzqwkyb0E3k3uYf3DEa4qKX5H/x03Qfc=;
	b=p82kxfQcA7b4WvyxKPl+lGUt9MhzhP/LyQ2yq8UVoP2QGNncXXoXnJ5xxyUl0wiGvXQHTu
	ULEqeRMRPzjQOwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74F66136E6;
	Wed,  2 Sep 2026 12:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wcYhHBocmGoYNAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Sep 2026 12:52:42 +0000
Message-ID: <fbae8643-ae15-4406-8afa-d9701b1f3e39@suse.de>
Date: Wed, 2 Sep 2026 14:52:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] block: take i_rwsem for the splice read path
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 John Garry <john.g.garry@oracle.com>, Christian Brauner
 <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-3-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260828-blkdev-fixes-v2-3-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,columbia.edu:email]
X-Spam-Flag: NO

On 8/28/26 3:49 PM, Tal Zussman wrote:
> def_blk_fops wires ->splice_read directly to filemap_splice_read(),
> which allocates folios based on mapping_min_folio_order() without any
> lock against set_blocksize(). A splice from a block device can race
> set_blocksize() raising the minimum folio order and insert a folio that
> is too small for the mapping. blkdev_read_iter() wraps filemap_read()
> in inode_lock_shared() for this reason, but the splice path was missed.
> 
> Splicing from a block device while toggling the block size between 512
> bytes and 64K with BLKBSZSET hits this within seconds on a
> CONFIG_DEBUG_VM kernel:
> 
>    page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
>    kernel BUG at mm/filemap.c:858!
>    Oops: invalid opcode: 0000 [#1] SMP NOPTI
>    RIP: 0010:__filemap_add_folio+0x51c/0x570
>    Call Trace:
>     filemap_add_folio+0x64/0x140
>     page_cache_ra_order+0x1dd/0x3d0
>     filemap_get_pages+0x153/0x760
>     filemap_splice_read+0x13f/0x300
>     splice_file_to_pipe+0xc0/0xd0
>     do_splice+0x6a8/0x890
>     __do_splice+0xb0/0x210
>     __x64_sys_splice+0x80/0x100
>     do_syscall_64+0x10e/0x520
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Take inode_lock_shared() around filemap_splice_read(), like the read
> path does.
> 
> Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/fops.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
