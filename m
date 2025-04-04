Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC12E62C9;
	Fri,  4 Apr 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758331; cv=none; b=p9NFoO9Istav8Ow2aeqZajZbtAvIIh4XA3I/ltlb4dy8OPGkm4qU9R0oTO6QxufRLkdWdk+WORbZqHOmnnvt7BCF+1EeczTff8GLt8X242FLwxMLcnH1Dw8UFhp7ZD6VyP7/8uEAComPTgzPIbnYq2ZF1DbGSu++5GE7ZSvOO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758331; c=relaxed/simple;
	bh=fyTaIY2BAO+p0MeQne6Bh2DNeG94rOH1KBRGOAsHeP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxIEYfEmiFqw/hqIHeSnII0l4IHZ/RU+vns6CJsus//6OtFahACZbaASCCcuPHH6Y2UgHR5p5mA/cMRuIHdWQ0EoYH2NLKN2EicHhjpxHocrL6IPeRHwL+DrdOI9wUY2KxN1fldrUZ9yuNggqOsFGuwi2UB6miakZyItK+PGkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqyAhQ/g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=peDUtEPX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqyAhQ/g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="peDUtEPX"
Date: Fri, 4 Apr 2025 11:18:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743758328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HK96lOWlxWav3ybrlzdl8oaeYhZkEROOiVP73gtJrns=;
	b=DqyAhQ/gvauAWV2/pAW7UO7rWPJmsn1Bdx4NMG2T+UrCxNvKsYnsykUKuVUghDa9R9Z0Dv
	WlWTEldjf/eBtSpRT5uj9mZHyrk3a+3x68WgrjhakRkgoUCQer6CtuhLx35dWtwHwzrIy3
	wTEo4kw6l6+MBeM4bYZnQA85K9lHoBmgJtxpuCfl3zY9SO+Z0Nrm+20gn/3LdP593AcU4s
	rIrIZqAvpIvot3GUfHUY9oFSpbuNf1WX1ljNXRgfhIyR38kbc0EFvbcBgjvWuRmRqvKvzL
	u5WzIggStRCi7Fqqn49N2v8oTB2gZ0ykUQsKLF3iIPVDVRAwkVB9YiSt4otPLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743758328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HK96lOWlxWav3ybrlzdl8oaeYhZkEROOiVP73gtJrns=;
	b=peDUtEPXoLxXOhq/ZzXqU/BktoR+SFIkIEzSvR93y8GEEI/ADjudEBjOud5GEQcmGNK2sS
	DVlLzkgC3jd+YvCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>, 
	Alyssa Ross <hi@alyssa.is>, John Ogness <john.ogness@linutronix.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] loop: Properly send KOBJ_CHANGED uevent for disk device
Message-ID: <20250404105216-0392cf08-c351-4c68-9080-eddb4a2c4201@linutronix.de>
References: <20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de>
 <2025031759-unlined-candle-1d91@gregkh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025031759-unlined-candle-1d91@gregkh>

+ Christoph who added the uevent suppression originally

On Mon, Mar 17, 2025 at 03:33:55PM +0100, Greg KH wrote:
> On Mon, Mar 17, 2025 at 03:13:25PM +0100, Thomas Weiﬂschuh wrote:
> > The wording "uncork" in the code comment indicates that it is expected that
> > the suppressed event instances are automatically sent after unsuppressing.
> > This is not the case, they are discarded.
> > In effect this means that no "changed" events are emitted on the device
> > itself by default. On the other hand each discovered partition does trigger
> > a "changed" event on the loop device itself. Therefore no event is emitted for
> > devices without partitions.
> > 
> > This leads to udev missing the device creation and prompting workarounds in
> > userspace, see the linked util-linux/losetup bug.
> > 
> > Explicitly emit the events and drop the confusingly worded comments.
> > 
> > Link: https://github.com/util-linux/util-linux/issues/2434
> > Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  drivers/block/loop.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index c05fe27a96b64f1f1ea3868510fdd0c7f4937f55..fbc67ff29e07c15f2e3b3e225a4a37df016fe9de 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -654,8 +654,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
> >  
> >  	error = 0;
> >  done:
> > -	/* enable and uncork uevent now that we are done */
> >  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> > +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
> 
> Why not just remove the place where the uevent was suppressed to start
> with?  It feels by manually sending a change event, you are doing
> exactly what the suppress was trying to prevent, which makes me think
> this is wrong.

The suppression was intentionally added in
commit 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
to "make sure userspace reacting to the change event will see the new device
state by generating the event only when the device is setup".
The device is completely setup after loop_configure() and
*I think* the same is true for loop_change_fd().
This commit would also be the correct target for Fixes:.


Thomas
