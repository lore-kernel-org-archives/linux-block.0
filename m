Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4186241C98;
	Mon, 17 Mar 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222123; cv=none; b=NZXa7OzHI39N4EOy+uylV/f8asVvz6Pm4wzwLcWZfKSYOnT7OcCC97G9lAmLElGasiB+u6ysaDDGajOB+fKml6q/w1Jczy4iwB2J19BXzAkaS9EYOCw0iG+msHKiPQdTRPSFHu8YNBa70eWks/fHeGQ3bcoUWqvx2hSWjEBONPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222123; c=relaxed/simple;
	bh=Yt3WgbrVQo8duGBSP1Jia0wgkU05qIskxVJQhvJpiV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQspIFHMqRqDn6SdiqFMlXnks1bXVqWPYS7PlhkR/mFasvqfxPuP1fSMY9xwD3HcOFJZq3AlGkGi1ZasyHu0TMYTmky31yXK/wFoVofzhPD23+h2wcF7Q/v7iNyjCsVgRqs7+4L4exrkirt8A6NMrfG32mZqOcp6BXQd8D+omBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=JRXO7sqL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wjKm4YMp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JRXO7sqL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wjKm4YMp"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F14CD1140098;
	Mon, 17 Mar 2025 10:35:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 17 Mar 2025 10:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742222119;
	 x=1742308519; bh=2YSB9jrUO3YWPRHJXtZJF6w39S1fmkOod2mob/5TWPA=; b=
	JRXO7sqLMoiym1IS/rElHi5heyyAdPhFUdkMfejJE+e7/ZI1zIMkWE9I6SWcSev7
	udrth6sTL5KjMqpwlP7F1nPF0sBdrnfjwmqDbiPRGy8WAr1QjJ+3CEBckwr91GsE
	3jtubLvlds+blpu7ZjOEojwQlHizgUx3m3YXKQ0RlSKWcgYA3l7hglJsuIoniRNZ
	sfYVMkZIi0IumCQK8nHVbZbuwiWgbNGlbUASIlDJrl/0mhhVXBQXZ7JigcO7QxCJ
	t18mZRZbBVyMwFO0c68878iN/ui2DikKiTjJ8+Xm6juP2+m9sFla9oT4WmZGpFrO
	bGCzROiaaZbzqaaMK6nCxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742222119; x=
	1742308519; bh=2YSB9jrUO3YWPRHJXtZJF6w39S1fmkOod2mob/5TWPA=; b=w
	jKm4YMpNXWUmpNt36OtTm92YSomhtqbQoxFc3H08aXn9aPUBHJH0edyYGRFMznm1
	bUlwJ+v3BP7hdqD298P97WbvbDob0ntbW+9y9tLuX7CllupDgKh8g/lhcHXJgtb4
	GLRE+UmFOvEhNHMOe5FnowGw8S39oAcgI0OjiNIkdCc/V1LBJmH+p7f8Cy3cWuBc
	F4sqf1+3BxP13kBT9HqIhZkfnONAeZgibdG9RI2nsV6OCqt2FknccCycwnn8m5c5
	J0zO+lNNqLjSpePoxoIEUyAtfqRomnle53Lzpl4bG8Bm+xomgtviZ6lPFapdb9X7
	0NXvZ640OTV7r1z5XoEZQ==
X-ME-Sender: <xms:JzPYZ6t029xOpdkopxRg73Jt_RADru25mk86WG2_1ZTVjfqioAh5zQ>
    <xme:JzPYZ_dq3FN-qFWNIqGCJAXu4IfN4otAoV-V-KTGVcHtZWSbxI6k6Zw9yBnsDwmzv
    2OifyBFtoQ9Gw>
X-ME-Received: <xmr:JzPYZ1zNB4J5UB9ZyxJf7uzS012kj-Dmvw0F0Srr690Tg_t6lbMUtNnnxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tddunecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeffveeivedvkeejiedvteeggfeihfejtefghfeltdelledtueeg
    heduvddvjeevhfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgt
    ohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepmhgrtghosegrnh
    gurhhoihgurdgtohhmpdhrtghpthhtohephhhisegrlhihshhsrgdrihhspdhrtghpthht
    ohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhope
    hlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JzPYZ1OEhr29cuNzu3OSg5YOzlewpUdp4kYwpaNI2gtFjQHCubIRKA>
    <xmx:JzPYZ6-t8L-c8z_Dloch3rNmEym9Vl0jZ-lP7hreJf_EJ-vUTsr1fQ>
    <xmx:JzPYZ9XJv1XAUp9rYRpGJFLQcdZqLqCNJN4RJhjveGTouAlAz-eW6A>
    <xmx:JzPYZzff9wr73gR5j0Q77sS3MMOBTh4E8AD-q4ecbtmJaZrg89wE1w>
    <xmx:JzPYZ6NncXCqcBum0CCdJVxmXRiH0dvxGNXkFnbMsPqRaQuikOXFRrUq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 10:35:18 -0400 (EDT)
Date: Mon, 17 Mar 2025 15:33:55 +0100
From: Greg KH <greg@kroah.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>,
	Alyssa Ross <hi@alyssa.is>, John Ogness <john.ogness@linutronix.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] loop: Properly send KOBJ_CHANGED uevent for disk device
Message-ID: <2025031759-unlined-candle-1d91@gregkh>
References: <20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de>

On Mon, Mar 17, 2025 at 03:13:25PM +0100, Thomas Weiﬂschuh wrote:
> The wording "uncork" in the code comment indicates that it is expected that
> the suppressed event instances are automatically sent after unsuppressing.
> This is not the case, they are discarded.
> In effect this means that no "changed" events are emitted on the device
> itself by default. On the other hand each discovered partition does trigger
> a "changed" event on the loop device itself. Therefore no event is emitted for
> devices without partitions.
> 
> This leads to udev missing the device creation and prompting workarounds in
> userspace, see the linked util-linux/losetup bug.
> 
> Explicitly emit the events and drop the confusingly worded comments.
> 
> Link: https://github.com/util-linux/util-linux/issues/2434
> Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  drivers/block/loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c05fe27a96b64f1f1ea3868510fdd0c7f4937f55..fbc67ff29e07c15f2e3b3e225a4a37df016fe9de 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -654,8 +654,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  
>  	error = 0;
>  done:
> -	/* enable and uncork uevent now that we are done */
>  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);

Why not just remove the place where the uevent was suppressed to start
with?  It feels by manually sending a change event, you are doing
exactly what the suppress was trying to prevent, which makes me think
this is wrong.

thanks,

greg k-h
