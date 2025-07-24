Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2887F9;
	Thu, 24 Jul 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352205; cv=none; b=OCQDjTjVIFuax5MjR5OgsTusGUg1Tnld5jyWejCm2r9I2+7qQMdonYyQBtq4iUTx/Ld36ydhRgiG/Cb/7xF+QBOFr/JpVxLWMA+I0OlBeIPdFnVAdNXB7+wwBYAQal4OIzpKZFKW6zPWxsxWRa8H2Snob/F4tW2usWkoyfdx+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352205; c=relaxed/simple;
	bh=6QJNDpM0NSkICZZvi+OOhGR48b8nkoDYyIe91De/OqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEj+Rj/USbq1oJNflJpTkc09vERs00To3XUXA7L8Igriv5u3gUmo2ebM3quBmJmzmQvYX+XhR/m6gCEDzir5O20SpM5tmJS547AMJLiBE+zqHDMfi/sHoiWS9R/NJLWQ+hkb8l6u8TKwB6ysW8367SM1MHJ/6EO+QvfA6F3xVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0XDZkXz; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0XDZkXz"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so6727801fa.0;
        Thu, 24 Jul 2025 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753352202; x=1753957002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nRXIsxKDx+EHQ+ewmB7GHMOLLLIjUjSDjsF/PUy3dM=;
        b=L0XDZkXzcOA0uHfvsBEVzFqNgtvGNZycAoy2HAC1wzxJJv9leX8oovkiXC+9n4Erho
         AFk0h8CR0kErru0d3uHT7bRPaCHPAQ86N4EjYvLmHeVTDdyFGUDRyQiNeIncLzdQqRsN
         ooEb2JgiONXJLo7z0hJWG7To2dvJOkPigX4SZ7W/hCYKIHy/3PFzNojAOgA4746aSyJg
         0gdsI4ShkaMavsieklbWHvohs9lEcfLGo3xF4vuAtPCmRTMbR1NNC682K0Oq+At17pN5
         eNxjqiFV91YRPBXVOLS0TLcVCvi3o2gvVb684zpgmuZL/lQ0LaiKTHNslSMD5TLPgZp0
         dTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753352202; x=1753957002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nRXIsxKDx+EHQ+ewmB7GHMOLLLIjUjSDjsF/PUy3dM=;
        b=JoQoFIQlYE3dPlYtVhkxD+Q8DVjcCDny8063aTzehhvGJHOR/Snsj/+50r8Hq8+/RO
         Iw38MF02vl/Ef+3RFaqJiiFX6IouSsbV3yT0d6dTSQVkoY12RJiAqO4sMKkom0B/8yZd
         88EGluYCn66niFwGsScT+jpO29coC1xbmCK7Xcm/cRZ7TCADBKACqQ0p8lpMcgUItCXk
         xKUD4AtzR4eZL2Ks03269NyV6TlwpUF/t6yg7HMvq9O7B+9gAfPvXJ6NNkXT1mhugLbd
         jrN538dr88zF2wvADVpi1Ko4JrNJ9YzcV2VkX+FVpwVIcnEu6t72gdkYooUSqRSlsPzw
         fujA==
X-Forwarded-Encrypted: i=1; AJvYcCV/fo6efBVFG7VkVOYKEyQDszeDXEa5wco+kRCMLuTb+y7Ee4XM9lv7k3QlImZm+hTos0rM8hlxv7xaLA==@vger.kernel.org, AJvYcCWMRYard5sQ0N+pKlNndcWAtoV6eMooBfoOupIjRsKgdF4z9dKTFJtAMvkWVo2Wb/39U+/Sh2CEtbZPfM6U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+GpOexH4iIUWMd6v4ddUnJyJLC1Dvmn3uK+/3OUwXHx4T8nd
	rqo5ANoVf6VAZk9BqyjEnOMfL4DpD9l7SBOj81/I86NgiQTmRiyd7WsD
X-Gm-Gg: ASbGncszA6klyszN9lH7YRD8ryFtAFMKpXLArFh3d7PTujhK8d+cz4/pa4Wua/LEpzG
	qCsqukxKqEje/c4uLTpMtxVl6hVdgOoD2jv5pgbNcESNj3t4FrGn3lM4yPZ9RTcfN1KVN6f+Tx1
	CmBoJGJiePMjsau663NHGsF+hPLaMFdqSq3kGlzPIPCUg2fRiB0SRdIHP/5VtbXKr/EmJ/JxHWZ
	kKaXs6qyaIXwe0/6UK8Nq73JJSWyhfj/yg4DOHdpDGk+XLSmbOZp3t6lo2+tZ/5OSY1/mFhqHln
	VjE0FoPkQuWPcTyXSMulnSL9WemgIXwszr0Evzo95FbArpfUCaTvGcOuBO413N7/ktDq6K3aRQW
	oCwcLLfcPWe1Nay9DY/Oh97z87MX7wHmCg9LM5M/uZEzH3Pa/0GinPbtv5SnIDTrNaoNdkIg=
X-Google-Smtp-Source: AGHT+IHbvep+/IiKtqAaTAeoELx3JXG0DMzJS0uGTSEYeNhDWHmOW1AheiIS7ATEPGIR+vi2q9+ChA==
X-Received: by 2002:a2e:a58d:0:b0:331:e667:90e5 with SMTP id 38308e7fff4ca-331e667abd6mr1624001fa.18.1753352201916;
        Thu, 24 Jul 2025 03:16:41 -0700 (PDT)
Received: from localhost (host-95-193-188-192.mobileonline.telia.com. [95.193.188.192])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-331e08e82ffsm2476901fa.51.2025.07.24.03.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:16:41 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:16:40 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Caleb Sander Mateos <csander@purestorage.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <u67ijiie6n2w3crfpuipprrmkocja7bxadlo3sbr47w7hysjgj@rjduhmczwwdz>
References: <20250711084708.2714436-1-arnd@kernel.org>
 <szmagqqo6lx36ozaqd5qf72xnzoi4e23jbfehjli6rfbvhps6w@if2cvmlgvmxv>
 <b6346235-cc66-4ce0-8768-52a1a89fd699@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6346235-cc66-4ce0-8768-52a1a89fd699@app.fastmail.com>

On 2025-07-18 07:56:49 +0200, Arnd Bergmann wrote:
> On Fri, Jul 18, 2025, at 01:37, Klara Modin wrote:
>   
> >> diff --git a/block/ioctl.c b/block/ioctl.c
> >> index 9ad403733e19..af2e22e5533c 100644
> >> --- a/block/ioctl.c
> >> +++ b/block/ioctl.c
> >> @@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
> >>  			       void __user *argp)
> >>  {
> >>  	unsigned int max_sectors;
> >> +	int ret;
> >>  
> >> -	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
> >> -		return blk_get_meta_cap(bdev, cmd, argp);
> >
> >> +	ret = blk_get_meta_cap(bdev, cmd, argp);
> >> +	if (ret != -ENOIOCTLCMD)
> >> +		return ret;
> >
> > This check seems to be incomplete. In the case when BLK_DEV_INTEGRITY is
> > disabled the ioctl can never complete as blk_get_meta_cap will then
> > always return -EOPNOTSUPP. Or should the !BLK_DEV_INTEGRITY stub be
> > changed to return -ENOIOCTLCMD instead?
> 
> Ah, I did miss the stub.
> 
> > It makes e.g. cryptsetup fail in my initramfs. Adding -EOPNOTSUPP to the
> > check fixes it for me:
> >
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index af2e22e5533c..7d5361fd1b7d 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -569,7 +569,7 @@ static int blkdev_common_ioctl(struct block_device 
> > *bdev, blk_mode_t mode,
> >  	int ret;
> > 
> >  	ret = blk_get_meta_cap(bdev, cmd, argp);
> > -	if (ret != -ENOIOCTLCMD)
> > +	if (ret != -EOPNOTSUPP && ret != -ENOIOCTLCMD)
> >  		return ret;
> > 
> >  	switch (cmd) {
> 
> I think returning -ENOIOCTLCMD from the stub makes more sense,
> but I don't know what the motivation for the -EOPNOTSUPP was.
> 
>      Arnd

Should I send a patch changing the stub? At least from reading
Documentation/driver-api/ioctl.rst it seems clear that only -ENOIOCTLCMD
or -ENOTTY is correct when the command number is unknown.

I didn't find any particular reason in 9eb22f7fedfc ("fs: add ioctl to
query metadata and protection info capabilities") for the -EOPNOTSUPP
return.

Regards,
Klara Modin
