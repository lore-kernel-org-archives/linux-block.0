Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FB2DA76F
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592724; cv=none; b=VcXw4Ju/FikI92Ns6eLCRsKkCFAS8cBKC+zj1pkymawgGIaKM8ScqpfCBWEP8hUFyO+cEACQwoPphnII9qXyD8yaQNryM37en9IJQbFi8tcaQU+Clfnzje9z9BBCe0EuptipRTDlyjdc+EkCS2DbdWkfP+pjznD8dakbNuI1Eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592724; c=relaxed/simple;
	bh=HPhXohUXMX3bLp0fiuXQAO1Ec8vBG53c/gH1VBgkQCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxt6D3QdM52YXeosiTbvv15feF4a/Ibd1LaQE+F/YFJNc5Qei+XqgtTaE6kUK02KXSNpCZb8VGBJqH6YHyNFXkGh32TO5J0cAf4hpE1pHcKT9uFgug0RGM84HPqRR1TsJsoVb6JgM39xc9Uywx6uSbZ0/k4Z0FpgQRh4v+hbFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+sy+yda; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0R3DQwj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ejm3FPg1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfEu9VYf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+sy+yda";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0R3DQwj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ejm3FPg1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfEu9VYf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09D725BE24;
	Mon,  1 Dec 2025 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764592719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BfaEsrvD1JMtEXJhTZyAxeHU0dIRAcHJ6hrnWXs9eQ=;
	b=K+sy+ydaFjmj0u6reXFx3JQvxeSzNMWNgRjHueHUlMBjiP4j4+eX6NMP0YkkVTNv+LCX/e
	wPEA7C2Fjw/PEVB4/oKmKaQ6uWsxaDYDzh7QN9PG7L09C1lNCbBNr3QpAXovHHkz1Ibpti
	mz4f2xZgYr8LIktWb54le20y/2cbdCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764592719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BfaEsrvD1JMtEXJhTZyAxeHU0dIRAcHJ6hrnWXs9eQ=;
	b=a0R3DQwj9JL8AbHcQhVBJz2jaw1rd3IV8VUdvCDiACvA/C8TNFiyxIQQ2jDLIIOqiuF3mo
	h68NbQA5UNhghTDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ejm3FPg1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MfEu9VYf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764592718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BfaEsrvD1JMtEXJhTZyAxeHU0dIRAcHJ6hrnWXs9eQ=;
	b=ejm3FPg1EXXFCvEIZfJEaNW6ddxpu9Uqj3EZpVGDtyFeT5YBIly73XNKvVK2TsT+RM+Smb
	ZAxqpDiT2Hxte621D1G9aABy7wrlqyClwJ8hCW9w8gvAbbviWyKaUuid3942o6uHX4G4VD
	Ses7dmCNeHNVtsOLEanEfZkN+95YXBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764592718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BfaEsrvD1JMtEXJhTZyAxeHU0dIRAcHJ6hrnWXs9eQ=;
	b=MfEu9VYfPtVIN3CnTktwZT8GRU28FkaqozQtL2P5KVqhkyvGdwyq+KG3l0J07fnYPSmb/+
	zUm/VIDWWiLwc0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEB493EA63;
	Mon,  1 Dec 2025 12:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hvNXNk2MLWm1BwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Dec 2025 12:38:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 354D3A09A3; Mon,  1 Dec 2025 13:38:37 +0100 (CET)
Date: Mon, 1 Dec 2025 13:38:37 +0100
From: Jan Kara <jack@suse.cz>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>, 
	axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jack@suse.cz, cascardo@igalia.com, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com, 
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH] loop: don't change loop device under exclusive opener in
 loop_set_status
Message-ID: <zoc2xguhdvjkon36d67usvf2wpufcreiti22sjgekhbhtkvdkp@iezwglvxdw4t>
References: <20251114144204.2402336-2-rpthibeault@gmail.com>
 <93a1773e-e30a-469d-bc8f-029773112401@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a1773e-e30a-469d-bc8f-029773112401@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 09D725BE24
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[3ee481e21fd75e14c397];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org,suse.cz,igalia.com,lists.linux.dev,linuxfoundation.org,syzkaller.appspotmail.com,xiaomi.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Tue 18-11-25 15:10:20, Yongpeng Yang wrote:
> On 11/14/25 22:42, Raphael Pinsonneault-Thibeault wrote:
> > loop_set_status() is allowed to change the loop device while there
> > are other openers of the device, even exclusive ones.
> > 
> > In this case, it causes a KASAN: slab-out-of-bounds Read in
> > ext4_search_dir(), since when looking for an entry in an inlined
> > directory, e_value_offs is changed underneath the filesystem by
> > loop_set_status().
> > 
> > Fix the problem by forbidding loop_set_status() from modifying the loop
> > device while there are exclusive openers of the device. This is similar
> > to the fix in loop_configure() by commit 33ec3e53e7b1 ("loop: Don't
> > change loop device under exclusive opener") alongside commit ecbe6bc0003b
> > ("block: use bd_prepare_to_claim directly in the loop driver").
> > 
> > Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
> > Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> > Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
> > ---
> > ML thread for previous, misguided patch idea:
> > https://lore.kernel.org/all/20251112185712.2031993-2-rpthibeault@gmail.com/t/
> > 
> >   drivers/block/loop.c | 41 ++++++++++++++++++++++++++++++-----------
> >   1 file changed, 30 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 053a086d547e..756ee682e767 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1222,13 +1222,24 @@ static int loop_clr_fd(struct loop_device *lo)
> >   }
> >   static int
> > -loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> > +loop_set_status(struct loop_device *lo, blk_mode_t mode,
> > +		struct block_device *bdev, const struct loop_info64 *info)
> >   {
> >   	int err;
> >   	bool partscan = false;
> >   	bool size_changed = false;
> >   	unsigned int memflags;
> > +	/*
> > +	 * If we don't hold exclusive handle for the device, upgrade to it
> > +	 * here to avoid changing device under exclusive owner.
> > +	 */
> > +	if (!(mode & BLK_OPEN_EXCL)) {
> > +		err = bd_prepare_to_claim(bdev, loop_set_status, NULL);
> > +		if (err)
> > +			goto out_reread_partitions;
> > +	}
> > +
> 
> +	if (mode & BLK_OPEN_EXCL) {
> +               struct block_device *whole = bdev_whole(bdev);
> +
> +               BUG_ON(whole->bd_claiming == NULL);
> +       }
> 
> I add the above code and do the following test:
> # losetup -f data.1g
> # echo "0 `blockdev --getsz /dev/loop0` linear /dev/loop0 0" | dmsetup
> create my-linear
> # ./ioctl-test /dev/mapper/my-linear // trigger BUG_ON, ioctl-test.c is
> in attachment.
> 
> The root causes of BUG_ON:
> 1. When creating 'my-linear' device, the mode for opening /dev/loop0
> does not include the BLK_OPEN_EXCL flag.
> table_load
>  - dm_table_create // get_mode() never assign BLK_OPEN_EXCL to {struct
> dm_table *t}->mode
>  - populate_table
>   - dm_table_add_target
>    - linear_ctr
>     - dm_get_device // mode = {struct dm_table *t}->mode, never open
> loop0 with BLK_OPEN_EXCL mode.

BLK_OPEN_EXCL is added by bdev_open() whenever it is called with non-NULL
holder. And DM code (open_table_device()) calls bdev_file_open_by_dev() with
_dm_claim_ptr as the holder. So all opens from DM should be exclusive ones.
The question obviously is what is broken in this that your reproducer still
works...

								Honza

> 2. When 'my-linear' device is opened with the O_EXCL flag, and an ioctl
> is issued to it. The dm_blk_ioctl function calls bdev->bd_disk->fops-
> > ioctl(bdev, mode, cmd, arg), which passes the mode with BLK_OPEN_EXCL
> flag to lo_ioctl.
> 
> 3. loop0 was not opened by dm_get_device() in BLK_OPEN_EXCL mode. As a
> result, whole->bd_claiming is NULL.
> 
> Thus, the BLK_OPEN_EXCL flag in the mode passed to lo_ioctl doesn't
> guarantee the loop device was opened with BLK_OPEN_EXCL.
> 
> How about use per-device rw_semaphore instead of 'bd_prepare_to_claim/
> bd_abort_claiming'?
> 
> Yongpeng,
> 
> >   	err = mutex_lock_killable(&lo->lo_mutex);
> >   	if (err)
> >   		return err;
> > @@ -1270,6 +1281,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> >   	}
> >   out_unlock:
> >   	mutex_unlock(&lo->lo_mutex);
> > +	if (!(mode & BLK_OPEN_EXCL))
> > +		bd_abort_claiming(bdev, loop_set_status);
> > +out_reread_partitions:
> >   	if (partscan)
> >   		loop_reread_partitions(lo);
> > @@ -1349,7 +1363,9 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
> >   }
> >   static int
> > -loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
> > +loop_set_status_old(struct loop_device *lo, blk_mode_t mode,
> > +		    struct block_device *bdev,
> > +		    const struct loop_info __user *arg)
> >   {
> >   	struct loop_info info;
> >   	struct loop_info64 info64;
> > @@ -1357,17 +1373,19 @@ loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
> >   	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
> >   		return -EFAULT;
> >   	loop_info64_from_old(&info, &info64);
> > -	return loop_set_status(lo, &info64);
> > +	return loop_set_status(lo, mode, bdev, &info64);
> >   }
> >   static int
> > -loop_set_status64(struct loop_device *lo, const struct loop_info64 __user *arg)
> > +loop_set_status64(struct loop_device *lo, blk_mode_t mode,
> > +		  struct block_device *bdev,
> > +		  const struct loop_info64 __user *arg)
> >   {
> >   	struct loop_info64 info64;
> >   	if (copy_from_user(&info64, arg, sizeof (struct loop_info64)))
> >   		return -EFAULT;
> > -	return loop_set_status(lo, &info64);
> > +	return loop_set_status(lo, mode, bdev, &info64);
> >   }
> >   static int
> > @@ -1546,14 +1564,14 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
> >   	case LOOP_SET_STATUS:
> >   		err = -EPERM;
> >   		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
> > -			err = loop_set_status_old(lo, argp);
> > +			err = loop_set_status_old(lo, mode, bdev, argp);
> >   		break;
> >   	case LOOP_GET_STATUS:
> >   		return loop_get_status_old(lo, argp);
> >   	case LOOP_SET_STATUS64:
> >   		err = -EPERM;
> >   		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
> > -			err = loop_set_status64(lo, argp);
> > +			err = loop_set_status64(lo, mode, bdev, argp);
> >   		break;
> >   	case LOOP_GET_STATUS64:
> >   		return loop_get_status64(lo, argp);
> > @@ -1647,8 +1665,9 @@ loop_info64_to_compat(const struct loop_info64 *info64,
> >   }
> >   static int
> > -loop_set_status_compat(struct loop_device *lo,
> > -		       const struct compat_loop_info __user *arg)
> > +loop_set_status_compat(struct loop_device *lo, blk_mode_t mode,
> > +		    struct block_device *bdev,
> > +		    const struct compat_loop_info __user *arg)
> >   {
> >   	struct loop_info64 info64;
> >   	int ret;
> > @@ -1656,7 +1675,7 @@ loop_set_status_compat(struct loop_device *lo,
> >   	ret = loop_info64_from_compat(arg, &info64);
> >   	if (ret < 0)
> >   		return ret;
> > -	return loop_set_status(lo, &info64);
> > +	return loop_set_status(lo, mode, bdev, &info64);
> >   }
> >   static int
> > @@ -1682,7 +1701,7 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
> >   	switch(cmd) {
> >   	case LOOP_SET_STATUS:
> > -		err = loop_set_status_compat(lo,
> > +		err = loop_set_status_compat(lo, mode, bdev,
> >   			     (const struct compat_loop_info __user *)arg);
> >   		break;
> >   	case LOOP_GET_STATUS:


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
