Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693004;
	b=ulIMP/EQ9421Hy66wRxd2By4my/TYpHlAk7sNqD4SeNFlopOPBZikM61oBiGtUUxp8hT
	 HcfF5av2pI8ptrugjf9rhYPOpH9IgniOOnNiR+358f0czOyQG63KVvXnua5Ix2dACgHh7
	 ifOVljEx/Bq+57vJipw+tTwSTpFw0etNKoPmI6zgZeFPmaJvse0tCfaZuyAZrtV171x14
	 yuQVScQ+3BBWCUpWh9blM5rBUGrfPYmsWU2stulUsNdMbHS7Z/jzHdQ0rMGK7l3JHX1hx
	 /LGxn7fCti2coLFEJ+t6XPJp7FgGhZq7EYE0rt+72RZ7d+Nnf8eh/2VKRogSTKFyCvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693004;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=WXXZdtfXKLM3zYE0qG9EJihyMbjCoUyvjBI3IiYPtjE=;
	b=YMr6hCRpDqHEZ8BhGp/o8r094VfH0ekrQP2pav3ca/VmmmD/sE/rSs3ILcjmVw54r9UI
	 xcNE+8YyTpDygEpDWY8C3S/H9EHuqM7I6Ve1POrzFH3iCsuELOZ5uUtybY60bQIHWUtjC
	 NWTPfCu9hm9eR9AlW+wU/0ruTrgUZiS3gRzJRdOZ1VGTYe6z14YZrQNM5k7fDflL8DiXG
	 bjViw+NIF47/BExhvPN2MDz9Z9w05MN+aPCJ3ik8lEWf7S+4X5h95jiVPSj4o/lfYaD2Y
	 3ciUMFNf6yHgsgFpEJHj0ulnjUuA0zVaLUXaLW8ZQlNDXzQOLj3tLraDazxlWJWT13Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KrNh25BV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lDeIZ5aP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KrNh25BV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lDeIZ5aP;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688B606A323;
	Thu, 26 Nov 2026 11:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9688B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KrNh25BV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lDeIZ5aP;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KrNh25BV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lDeIZ5aP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D04DF223E5;
	Thu, 26 Nov 2026 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795693001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXXZdtfXKLM3zYE0qG9EJihyMbjCoUyvjBI3IiYPtjE=;
	b=KrNh25BVC2/OYPvpReolTZb5rac9a7ixkcRpJgsakyctIYmY8FB9/Vs095h+ahZbB0GdxN
	rFq1npRLL4t3h3d5fEtDA3Xfpo2jD7sgVJqHjQX43ndqnx1mbIRElhHjY1JxiwbcvsKWi9
	NRweTstgQcYPiLdEF9q1+R7OSKvtqRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795693001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXXZdtfXKLM3zYE0qG9EJihyMbjCoUyvjBI3IiYPtjE=;
	b=lDeIZ5aPYmEBynilgJWe+CqP5UKEI2XdNd68R402BpY8aHkY1qsA//qpz1mAJV92XKru4O
	4Zf+JqhJbYPj/uDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795693001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXXZdtfXKLM3zYE0qG9EJihyMbjCoUyvjBI3IiYPtjE=;
	b=KrNh25BVC2/OYPvpReolTZb5rac9a7ixkcRpJgsakyctIYmY8FB9/Vs095h+ahZbB0GdxN
	rFq1npRLL4t3h3d5fEtDA3Xfpo2jD7sgVJqHjQX43ndqnx1mbIRElhHjY1JxiwbcvsKWi9
	NRweTstgQcYPiLdEF9q1+R7OSKvtqRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795693001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXXZdtfXKLM3zYE0qG9EJihyMbjCoUyvjBI3IiYPtjE=;
	b=lDeIZ5aPYmEBynilgJWe+CqP5UKEI2XdNd68R402BpY8aHkY1qsA//qpz1mAJV92XKru4O
	4Zf+JqhJbYPj/uDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A77BB134C3;
	Thu, 26 Nov 2026 11:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xH+xIMkZCGspbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Nov 2026 11:36:41 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 3989A27DED; Thu, 26 Nov 2026 12:36:37 +0100 (CET)
Date: Thu, 26 Nov 2026 12:36:37 +0100
From: Jan Kara <jack@suse.cz>
To: =?utf-8?B?5p2o6L2255SE?= <yangyizhen3198@phytium.com.cn>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] block: long udev open waits during cache teardown
Message-ID: <hvxissqup3n5tti6as2csdducwz6ywju4awgfozdwjimoplmst@shps625lugoq>
References: <20261117105107.14236-1-yangyizhen3198@phytium.com.cn>
 <20261120-hassliebe-arena-kaufvertrag-3ac58fd0483a@brauner>
 <4effe3b8.6085.1a217879319.Coremail.yangyizhen3198@phytium.com.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4effe3b8.6085.1a217879319.Coremail.yangyizhen3198@phytium.com.cn>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 26-11-26 19:04:50, 杨轶甄 wrote:
> Hi Christian,
> 
> > If that still reproduces on mainline it's a question
> > about the bdev release locking.
> 
> I reproduced the long udev open wait on upstream Linux v6.6 and on
> Linux v7.0.14. On both kernels, udev blocked while trying to open the
> device as mkfs.ntfs was closing it after a full format.
> 
> Thanks for pointing out the impact on other openers. I agree that a
> udev probe closing its own file could trigger writeback and evict
> cache that another opener is still using. I'll drop the __fput()
> proposal.
> 
> I'd like to understand the locking requirements in the block device
> last-close path. In particular, why does kill_bdev() need to complete
> while open_mutex is held? What state and ordering requirements does
> the lock protect during this cleanup?

The page cache cleanup in kill_bdev() needs to complete before we allow new
openers to open the device and open_mutex serializes that. If the cleanup
would race, we could destroy data the new opener has written to the page
cache of the device. 

> I'm asking because the device mapping can still contain a large
> amount of clean page cache after the early sync. In my tests on the
> vendor 6.6 kernel, about 805 GiB remained at final teardown, and
> the truncate took roughly seven minutes while udev was waiting.
> Could the release path be changed to reduce the time open_mutex is
> held while preserving those requirements?

Perhaps. We currently do:

        if (atomic_read(&bdev->bd_openers) == 1)
                sync_blockdev(bdev);

in bdev_release(). We could enhance it to:

        if (atomic_read(&bdev->bd_openers) == 1) {
                sync_blockdev(bdev);
		/* Still the only opener after the writeback? */
        	if (atomic_read(&bdev->bd_openers) == 1)
			invalidate_mapping_pages(bdev->bd_mapping, 0, -1);
	}

This is safe to run without open_mutex and should get rid of 99.9% of pages
before we take open_mutex and do a reliable cleanup. Feel free to submit a
patch with this change describing your motivation.

> > And mkfs can just fsync() and POSIX_FADV_DONTNEED the device itself
> > before it closes it.
> 
> I've submitted a patch to the ntfs-3g project that calls fsync()
> and then posix_fadvise(..., POSIX_FADV_DONTNEED) in userspace
> before closing the device.

Good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
