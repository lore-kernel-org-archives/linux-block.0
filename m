Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BB145351
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048203; cv=none; b=Eoq1ujparVy23aqBgOswNdAtet3eCXhC/8caihAnlUs9e9p3YTZOmoYcOs5ep4hBxC+XRmd1OjPHh08tU5bLfk/XY/6dhJs6mVaSMbkJ/rSU333ANflux+cKXtLIyPPIUXE+m/DsX/4tbMFSVkWU18wcrB5wEn6yFWNG3CYiWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048203; c=relaxed/simple;
	bh=5uF36SkL6j3rjU+v75xcUHnjNsRFkrV5u2gpq2J7cJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnaO/+4f1Y5oD7qgk/idSpTNzfaw+IdHbvwLzZWODsSDrpTJcBRjWamNIzGVJTQIQ8xtGJirhzqUQTpI2wHpcVGU/WTDbRcURE474fJ2rNmQ2TEYOY9VbZQvMAjXV/QdMvzkUhNEDTMiKJ5SGrOQQG5Mlxkfj1bJVGCq8zAXfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68ff93c5a15so22413726d6.1
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 07:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048200; x=1709653000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2sGMg+51MVkfuFuHYE8WK5guxAx9KsEPslVkAQ6ODY=;
        b=MS5S5H7r2T7i8++z69fhqNItjSn8QTJ209sGfTLss5YQo9TO70KzmgMRQAAlXJMfus
         xgrhbIu8MJ4y7p4getrchhVb0QTeJ2hEiR1ilKtpIdMXo3hktknE2rIwmyNABFNnfRJD
         zpvt+orJkNopNL0JWoSRKLm9WWIpvBFz0M3Gp9B8T/mIHsN1IDdESaQnQUzozJb/gLf8
         n1AZ2pk5PSU/0nNZRQGQMgO/JLCt8wvBCNNp7dwYeDsQSKiEf8jQ40O8IxXvhcIWagc4
         G4kBc0/qLmSbP+zIuecrPiGsV6fPIkcv6fv9WA0D+019bTgDV3kGy9mxn+HSfVrUDw0/
         wpfg==
X-Forwarded-Encrypted: i=1; AJvYcCW+mdFFq6z8nQXCXtDzhEcKrh63ZGUVy83oAC/zEuYARRrZWl2vhayRF11+biyXHAWJQGi90os2c1ER+KPKqbHO6RGNA2X23H2+x8k=
X-Gm-Message-State: AOJu0YyJIaEjm3ZUsSC+M4PB6eIY3XJKQCL9Y9l1H/AFATX3Gog75OTZ
	pqJmRg5SqORi9yCEPUPJeHMqwlkhF+8P5u9zsGunamJlaf5wQq3sjao6/w6WOQ==
X-Google-Smtp-Source: AGHT+IHefBd/DYeC9kDGOWZX34cDpyMowKjJqRD0RsTiq7qAUMMzIzL+c6tRbAmqftYr+t9pPcOiRw==
X-Received: by 2002:a0c:f00f:0:b0:68f:6df2:3b60 with SMTP id z15-20020a0cf00f000000b0068f6df23b60mr2351854qvk.20.1709048200270;
        Tue, 27 Feb 2024 07:36:40 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id og17-20020a056214429100b0068fe3170b0esm4259658qvb.11.2024.02.27.07.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:36:39 -0800 (PST)
Date: Tue, 27 Feb 2024 10:36:37 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, lvm-devel@lists.linux.dev
Subject: Re: atomic queue limit updates for stackable devices
Message-ID: <Zd4BhQ66dC_d7Mn0@redhat.com>
References: <20240223161247.3998821-1-hch@lst.de>
 <ZdjXsm9jwQlKpM87@redhat.com>
 <ZdjYJrKCLBF8Gw8D@redhat.com>
 <20240227151016.GC14335@lst.de>
 <Zd38193LQCpF3-D0@redhat.com>
 <20240227151734.GA14628@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227151734.GA14628@lst.de>

On Tue, Feb 27 2024 at 10:17P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Feb 27, 2024 at 10:16:39AM -0500, Mike Snitzer wrote:
> > That's the mainline issue a bunch of MD (and dm-raid) oriented
> > engineers are working hard to fix, they've been discussing on
> > linux-raid (with many iterations of proposed patches).
> > 
> > It regressed due to 6.8 MD changes (maybe earlier).
> 
> 
> Do you know if there is a way to skip specific tests to get a useful
> baseline value (and to complete the run?)

I only know to sprinkle 'skip' code around to explicitly force the
test to get skipped (e.g. in test/shell/, adding 'skip' at the top of
each test as needed).

But I've cc'd the lvm-devel mailing list in case there is an easier
way.
