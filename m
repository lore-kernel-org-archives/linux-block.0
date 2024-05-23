Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037C125A9
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479049; cv=none; b=E7eRHzS44lPj7vzYZ9HKGERaC7PHdSyM+jis8/gt/DpXwiLYfX3kcpqOi2bqjsU7gzc0yVe4MO31T4lhS/e7TI57bg29pdqjDUCtm2o+Pn4xMzgq3xaJ1wO+VmpZ+nha0DP8PHDu5Dx/sGnGa2cHGzuF/Ist1j5jYSDlPUFm3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479049; c=relaxed/simple;
	bh=4LtWob32ApnyIrD+FaH4hfwXtzM201Hrt3v3539JzEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUSVmW9PpSd/kfhnFYbc8MyPeONop9rtd8v1aqMklyvQTqGjZI3XmuqDOEePNeAc5uIF9O+kyefn88FqP4rQb5c6qBBgQk0D9z0ybfKJutA/7sjAAHdq+y+EzlQ6NWktNa3GMd96ve1+n9uoetz51HmuChCGUnB09vUUiO071dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0ef6bee72so3694571a34.0
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 08:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479047; x=1717083847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDtPboZQrdlM7tLf8sMngY5uN4PsBPqcCfAsHLauzDY=;
        b=woVcD9qD7sKWX5+6TZ0mXYiaz9emkRu3usr+Qr/WRbhvbleZnb7QFMIIO41hZLBI8u
         OF0HzYrRr+RUqPR0NDK/6WPtM0am4nBsdsj2d7gdEkR1mTENtn04cH8MPN/EkboC8BmM
         A7LU2I2BV9SqZfOx95g0p1FkNzIHehalzddgJyaUOC1CcMmGyx69MJDMVgNe9dXSVhkN
         pqBnafeF9sjtckqwxLcewmmKtotTPYI1WzIjS6SSZzZg+8zk87JSx6FXux9glt5egUO2
         aVWM5mL5MtC+T73sTSIhqgyN/9scTdiBy4rYkpJmB3DCbTDw6o9NAsMXF3jfbwNGqTNF
         Idmw==
X-Forwarded-Encrypted: i=1; AJvYcCUPDQuLVSebhfg4WXjP10wGeY7zkAPthTVYBhxzRGeUjKJ7zCIXz9aijtdykbjbweBt9oECrAQekiJb8oWjXYojw993dIMRKTUr1FY=
X-Gm-Message-State: AOJu0Yzkk44PVYFT7SvVPYjIFxfF0ktzhpti2Z0cg+Fu/4VdTHeDxHMX
	8Fyy5WD4Th+LXwxBb0ROj9F2GgNySs3ncnf+vdJSCjKasG26NUtUHBKU05aZ88s=
X-Google-Smtp-Source: AGHT+IF89a4FCVi+vzxPLNIcYSlNqsZYXkww3riTOzVp68ENvWzScmBcSrnNCqznAR19rFiVx8LUog==
X-Received: by 2002:a05:6870:171d:b0:23c:471:a5d2 with SMTP id 586e51a60fabf-24c68bc6df0mr5838197fac.30.1716479047071;
        Thu, 23 May 2024 08:44:07 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e12f41a0asm148653281cf.48.2024.05.23.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:44:06 -0700 (PDT)
Date: Thu, 23 May 2024 11:44:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>
Subject: Re: dm: retain stacked max_sectors when setting queue_limits
Message-ID: <Zk9kRYgwhu49c8YY@kernel.org>
References: <20240522025117.75568-1-snitzer@kernel.org>
 <20240522142458.GB7502@lst.de>
 <Zk4h-6f2M0XmraJV@kernel.org>
 <20240523082731.GA3010@lst.de>
 <Zk9OyGTESlHXu6Wa@kernel.org>
 <20240523144938.GA30227@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523144938.GA30227@lst.de>

On Thu, May 23, 2024 at 04:49:38PM +0200, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 10:12:24AM -0400, Mike Snitzer wrote:
> > Not sure what is sketchy about the max_sectors == 0 check, the large
> > comment block explains that check quite well.  We want to avoid EIO
> > for unsupported operations (otherwise we'll get spurious path failures
> > in the context of dm-multipath).  Could be we can remove this check
> > after an audit of how LLD handle servicing IO for unsupported
> > operations -- so best to work through it during a devel cycle.
> 
> Think of what happens if you create a dm device, and then reduce
> max_sectors using sysfs on the lower device after the dm device
> was created: you'll trivially trigger this check.
> 
> > Not sure why scsi_debug based testing with mptest isn't triggering it
> > for you. Are you seeing these limits for the underlying scsi_debug
> > devices?
> > 
> > ./max_hw_sectors_kb:2147483647
> > ./max_sectors_kb:512
> 
> root@testvm:~/mptest# cat /sys/block/sdc/queue/max_hw_sectors_kb 
> 2147483647
> 
> root@testvm:~/mptest# cat /sys/block/sdd/queue/max_sectors_kb 
> 512
> 
> root@testvm:~/mptest# cat /sys/block/dm-0/queue/max_hw_sectors_kb 
> 2147483647
> 
> root@testvm:~/mptest# cat /sys/block/dm-0/queue/max_sectors_kb 
> 1280
> 
> so they don't match, but for some reason bigger bios never get built.

Weird... I'm running in a VMware guest but I don't see why that'd make
a difference on larger IOs being formed (given it is virtual
scsi_debug devices).

In any case, we know I can reproduce with this scsi_debug-based mptest
test and Marco has verified my fix resolves the issue on his FC
multipath testbed.

But I've just floated a patch to elevate the fix to block core (based
on Ming's suggestion):
https://patchwork.kernel.org/project/dm-devel/patch/Zk9i7V2GRoHxBPRu@kernel.org/

Let me know, thanks.
