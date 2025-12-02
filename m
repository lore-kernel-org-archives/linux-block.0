Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE328CF6F
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670031; cv=none; b=TavdU83T5wSM0LwAvyl0mirmbpE6ExXQ0Jjxt3E4ScQsLAy8QNHALUx4eA1DuWsLLNc7eAiX8cTE6xrUgPOnZBwlqLUvTYpUSwTBQsrXzPyZAhMYeQk64xeuEF3Urb4Zek8MaOLdAqrkYnHm48+JjcrP8WqAybYSaFej3AW6Fjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670031; c=relaxed/simple;
	bh=D9hK6+alUGiHPuK5szo5jhFNIugok8q4d/OF6vO/d5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5MpU4oqmx9BIqHXd4C0kD48h8jlvUmV98fMIrV3/wbG0CGAaYt8QKgBTLNWz5085SeWzJvewFRuAsNoTAqh8asM4ctFH45uZpOr2bEC9GEfbS6J6ppzp1yPkxTGUE0BrYa7+c/8+DAawoGoi0NVqhLklUisQ1JnQu4Gv4AHHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMh+VjBE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jf33t27h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMh+VjBE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jf33t27h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMh+VjBE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jf33t27h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMh+VjBE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jf33t27h"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADD0E5BD10;
	Tue,  2 Dec 2025 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764670026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+O7GcXkNiD+d56/fCYcZxMq0g4Dvf48J9PDE9ibk08=;
	b=EMh+VjBE3bA4wP9+OnDt5CS0gGxVGHLHbw7rW8siO3u+O9vH6r+GvARPLLc1CmCCF7NVFj
	hP4Jr6lHN1RCioz2UupZWOQSLp1hm3zZqGMcKmORfPAgi1p1CtobhykI8fDxroTSNVYfru
	Lzxdjp0foxf9er+BDyRezbUlNkZOR8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764670026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+O7GcXkNiD+d56/fCYcZxMq0g4Dvf48J9PDE9ibk08=;
	b=Jf33t27h5LYvbqy5eJfyK6wuW9C7ruVwYq7e4HvUBkZ0imtzJMzJ2LfqCv5kQh00IzQfoe
	tADoTmMuirvctsCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764670026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+O7GcXkNiD+d56/fCYcZxMq0g4Dvf48J9PDE9ibk08=;
	b=EMh+VjBE3bA4wP9+OnDt5CS0gGxVGHLHbw7rW8siO3u+O9vH6r+GvARPLLc1CmCCF7NVFj
	hP4Jr6lHN1RCioz2UupZWOQSLp1hm3zZqGMcKmORfPAgi1p1CtobhykI8fDxroTSNVYfru
	Lzxdjp0foxf9er+BDyRezbUlNkZOR8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764670026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+O7GcXkNiD+d56/fCYcZxMq0g4Dvf48J9PDE9ibk08=;
	b=Jf33t27h5LYvbqy5eJfyK6wuW9C7ruVwYq7e4HvUBkZ0imtzJMzJ2LfqCv5kQh00IzQfoe
	tADoTmMuirvctsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E7BB3EA63;
	Tue,  2 Dec 2025 10:07:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ypKrJkq6LmlMBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Dec 2025 10:07:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EABBA09DA; Tue,  2 Dec 2025 11:07:06 +0100 (CET)
Date: Tue, 2 Dec 2025 11:07:06 +0100
From: Jan Kara <jack@suse.cz>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jack@suse.cz, cascardo@igalia.com, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop: don't change loop device under exclusive opener in
 loop_set_status
Message-ID: <i5xuxe6prso72euxxo4jludbb5fb2juh2ofbgf32ts7aruyesc@na6btym6jats>
References: <20251114144204.2402336-2-rpthibeault@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114144204.2402336-2-rpthibeault@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[3ee481e21fd75e14c397];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	URIBL_BLOCKED(0.00)[syzkaller.appspot.com:url,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,suse.com:email]

On Fri 14-11-25 09:42:05, Raphael Pinsonneault-Thibeault wrote:
> loop_set_status() is allowed to change the loop device while there
> are other openers of the device, even exclusive ones.
> 
> In this case, it causes a KASAN: slab-out-of-bounds Read in
> ext4_search_dir(), since when looking for an entry in an inlined
> directory, e_value_offs is changed underneath the filesystem by
> loop_set_status().
> 
> Fix the problem by forbidding loop_set_status() from modifying the loop
> device while there are exclusive openers of the device. This is similar
> to the fix in loop_configure() by commit 33ec3e53e7b1 ("loop: Don't
> change loop device under exclusive opener") alongside commit ecbe6bc0003b
> ("block: use bd_prepare_to_claim directly in the loop driver").
> 
> Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
> Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>

This patch looks mostly good to me. Just one comment:

> -loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> +loop_set_status(struct loop_device *lo, blk_mode_t mode,
> +		struct block_device *bdev, const struct loop_info64 *info)
>  {
>  	int err;
>  	bool partscan = false;
>  	bool size_changed = false;
>  	unsigned int memflags;
>  
> +	/*
> +	 * If we don't hold exclusive handle for the device, upgrade to it
> +	 * here to avoid changing device under exclusive owner.
> +	 */
> +	if (!(mode & BLK_OPEN_EXCL)) {
> +		err = bd_prepare_to_claim(bdev, loop_set_status, NULL);
> +		if (err)
> +			goto out_reread_partitions;
> +	}
> +

So now any LOOP_SET_STATUS call will fail for device that is already
exclusively open. There are some operations (like modifying the AUTOCLEAR
flag or loop device name) that are safe even for a device with a mounted
filesystem. I wouldn't probably bother with that now but I wanted to note
that there may be valid uses of LOOP_SET_STATUS even for an exclusively
open loop device and if there are users of that out there we might need to
refine this a bit. Anyway for now feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


>  	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
>  		return err;
> @@ -1270,6 +1281,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	}
>  out_unlock:
>  	mutex_unlock(&lo->lo_mutex);
> +	if (!(mode & BLK_OPEN_EXCL))
> +		bd_abort_claiming(bdev, loop_set_status);
> +out_reread_partitions:
>  	if (partscan)
>  		loop_reread_partitions(lo);
>  
> @@ -1349,7 +1363,9 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
>  }
>  
>  static int
> -loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
> +loop_set_status_old(struct loop_device *lo, blk_mode_t mode,
> +		    struct block_device *bdev,
> +		    const struct loop_info __user *arg)
>  {
>  	struct loop_info info;
>  	struct loop_info64 info64;
> @@ -1357,17 +1373,19 @@ loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
>  	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
>  		return -EFAULT;
>  	loop_info64_from_old(&info, &info64);
> -	return loop_set_status(lo, &info64);
> +	return loop_set_status(lo, mode, bdev, &info64);
>  }
>  
>  static int
> -loop_set_status64(struct loop_device *lo, const struct loop_info64 __user *arg)
> +loop_set_status64(struct loop_device *lo, blk_mode_t mode,
> +		  struct block_device *bdev,
> +		  const struct loop_info64 __user *arg)
>  {
>  	struct loop_info64 info64;
>  
>  	if (copy_from_user(&info64, arg, sizeof (struct loop_info64)))
>  		return -EFAULT;
> -	return loop_set_status(lo, &info64);
> +	return loop_set_status(lo, mode, bdev, &info64);
>  }
>  
>  static int
> @@ -1546,14 +1564,14 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
>  	case LOOP_SET_STATUS:
>  		err = -EPERM;
>  		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
> -			err = loop_set_status_old(lo, argp);
> +			err = loop_set_status_old(lo, mode, bdev, argp);
>  		break;
>  	case LOOP_GET_STATUS:
>  		return loop_get_status_old(lo, argp);
>  	case LOOP_SET_STATUS64:
>  		err = -EPERM;
>  		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
> -			err = loop_set_status64(lo, argp);
> +			err = loop_set_status64(lo, mode, bdev, argp);
>  		break;
>  	case LOOP_GET_STATUS64:
>  		return loop_get_status64(lo, argp);
> @@ -1647,8 +1665,9 @@ loop_info64_to_compat(const struct loop_info64 *info64,
>  }
>  
>  static int
> -loop_set_status_compat(struct loop_device *lo,
> -		       const struct compat_loop_info __user *arg)
> +loop_set_status_compat(struct loop_device *lo, blk_mode_t mode,
> +		    struct block_device *bdev,
> +		    const struct compat_loop_info __user *arg)
>  {
>  	struct loop_info64 info64;
>  	int ret;
> @@ -1656,7 +1675,7 @@ loop_set_status_compat(struct loop_device *lo,
>  	ret = loop_info64_from_compat(arg, &info64);
>  	if (ret < 0)
>  		return ret;
> -	return loop_set_status(lo, &info64);
> +	return loop_set_status(lo, mode, bdev, &info64);
>  }
>  
>  static int
> @@ -1682,7 +1701,7 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>  
>  	switch(cmd) {
>  	case LOOP_SET_STATUS:
> -		err = loop_set_status_compat(lo,
> +		err = loop_set_status_compat(lo, mode, bdev,
>  			     (const struct compat_loop_info __user *)arg);
>  		break;
>  	case LOOP_GET_STATUS:
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
