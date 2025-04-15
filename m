Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218D27FD6E;
	Tue, 15 Apr 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715272; cv=none; b=Jxb804GfZpRc+iTYzh4Ar1C0Et/tjgtm9GgXh73YepYeN+SUSNkMwVkbvZEyZqMFPdrknPt38WtCUYLmF+LUhoc5cvvkDy4v11vukant287S9KonFpgC1+eT/VmG/corjsndJeI7VmYnBrOW07RZs8EY+XB5ouicXkwY+h/vDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715272; c=relaxed/simple;
	bh=ZhDWyiBoqbn/4pS1kO+CcTZDKLs1LhfSidSyyi3cSdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNOLNr2GS4rJe03fjvffQq/Cdx9UuXAtHqa1ocdXv9+0y5B/MCm/gqT3fpiuskipdr2Pr0si/sEmj6e+8Ud2veE/zOx1yL7Q7BXyJM/dF5I4bEIFMmnNXzYbv4Dc/HO76X2CBPnqbbcZMmoeRBZw42EkxurGAuJ2FPP9Fxw2NWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MkniNh7k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Ck18qdt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MkniNh7k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Ck18qdt"
Date: Tue, 15 Apr 2025 13:07:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744715269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0v+po+W1WUGJeAmHKbd+h3u/8o9QYlfYilL5F5o1wg=;
	b=MkniNh7krPVd7332otnOYdkwlc40FizzVQjYKsxf8O1/yPEyxuBppK2iVLEd2bscG8tqCL
	f6gk0Wr7Ah0HyU4uOCxDm9Ex4fuNPim9sG0iuCjh551eNLvUpP78bKofQgyEN5soaEokkI
	x+5q1nnHNlNac2Lktrj45gfXxKeqjXgE2Q/gJNpZ0kOrTpcH++8mRxSW0vXG3NMGWtBMW5
	FKqDmH+Jeb8X/U6xj7/rZlL9E5tZNifKS5ZbGW6rrf+5621sR2Q6xJA1dqqxaFtJpHurNR
	eI9Fm5/IbSD3BYRfBndwJKb6ptravkgpyxa6Gyzl0TKTilS6KowJtG3Q6EaNEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744715269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0v+po+W1WUGJeAmHKbd+h3u/8o9QYlfYilL5F5o1wg=;
	b=9Ck18qdt+iIcIHfr6H5+H271tzyL9d+kq/rYmEuXljvqnf2OZe5E+tXm7mWpit2JpRsemT
	NvEtqHgd9psWudAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>, 
	Alyssa Ross <hi@alyssa.is>, Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>, 
	John Ogness <john.ogness@linutronix.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] loop: properly send KOBJ_CHANGED uevent for disk
 device
Message-ID: <20250415130006-9a17e592-fc7a-4150-bc7c-e0c6d8da4b72@linutronix.de>
References: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
 <tbypgsknfpqyx3xbrpz7jlpthlybcdxhr7b3oz4vq5u6izwdqp@q3wo6zpqicp7>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tbypgsknfpqyx3xbrpz7jlpthlybcdxhr7b3oz4vq5u6izwdqp@q3wo6zpqicp7>

On Tue, Apr 15, 2025 at 12:24:55PM +0200, Jan Kara wrote:
> On Tue 15-04-25 10:51:47, Thomas Weiﬂschuh wrote:
> > The original commit message and the wording "uncork" in the code comment
> > indicate that it is expected that the suppressed event instances are
> > automatically sent after unsuppressing.
> > This is not the case, instead they are discarded.
> > In effect this means that no "changed" events are emitted on the device
> > itself by default.
> > While each discovered partition does trigger a changed event on the
> > device, devices without partitions don't have any event emitted.
> > 
> > This makes udev miss the device creation and prompted workarounds in
> > userspace. See the linked util-linux/losetup bug.
> > 
> > Explicitly emit the events and drop the confusingly worded comments.
> > 
> > Link: https://github.com/util-linux/util-linux/issues/2434
> > Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Thanks for the fix! When reading the code, I'm a bit curious: What is
> actually generating events for partitions with loop_change_fd() call?
> Because there loop_reread_partitions() still happens with uevents
> supressed... I suspect event supressing there should be shorter.

Makes sense.
For loop_configure() this was fixed in
commit bb430b694226 ("loop: LOOP_CONFIGURE: send uevents for partitions").
I guess we need the same for loop_change_fd().

I'm not entirely sure on how to order the commits or if they should be
folded together.
My current preference is to first have the current patch under discussion and
then the fix for loop_change_fd().


Thomas

> > ---
> > Changes in v2:
> > - Use correct Fixes tag
> > - Rework commit message slightly
> > - Rebase onto v6.15-rc1
> > - Link to v1: https://lore.kernel.org/r/20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de
> > ---
> >  drivers/block/loop.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 674527d770dc669e982a2b441af1171559aa427c..09a725710a21171e0adf5888f929ccaf94e98992 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -667,8 +667,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
> >  
> >  	error = 0;
> >  done:
> > -	/* enable and uncork uevent now that we are done */
> >  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> > +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
> >  	return error;
> >  
> >  out_err:
> > @@ -1129,8 +1129,8 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
> >  	if (partscan)
> >  		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
> >  
> > -	/* enable and uncork uevent now that we are done */
> >  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> > +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
> >  
> >  	loop_global_unlock(lo, is_loop);
> >  	if (partscan)
> > 
> > ---
> > base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> > change-id: 20250307-loop-uevent-changed-aa3690f43e03
> > 
> > Best regards,
> > -- 
> > Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
