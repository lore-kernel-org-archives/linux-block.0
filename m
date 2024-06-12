Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320618132B
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207780; cv=none; b=bxOq3shMh2+KUBUKjhPY+6UZcO49p4OvKC1Qbau7lnQpgfi/+4EPhrFRAR8IQS4jfAzn0rdjuYCetUDc8+3CJcIcDYlu4+NSHkoittgKb/S4jv2SaQ+yJwKHhse5jzdko5gT2YJFjzqMSbLNvuQmjCVVZEAyhqmGTcCxJp7vuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207780; c=relaxed/simple;
	bh=WxiyGuZAC7bj+QrxGa2lDi15MZrXhgJnJEV+bRK2uiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivfq1tzb3PZTGLYlt/JAA0X0mNoDHDtB2d7HFG5AtIa9TN6IhBJkMfZDEFzKkyscUZ3JcHjXkt8Jccr3ZTo5+/a5vyjBgAhw7WTgsFncbr/lu92slTWLHW0Xp9AEI2hsiMVNLRLGfolTr/drudJE5flsyZD+mwK0DHLHlRfDZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=V7cG6Ag/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="V7cG6Ag/"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b09072c9d9so5946d6.1
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718207778; x=1718812578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0JAgWI6yypeQvJHtBsLjxy9EsiTAtsBZFfQkPH4VMNc=;
        b=V7cG6Ag/z6iCUMnCyee02CpPpVNNKq0aFi2gbS3Dd7usN46ko1fDHLZJlYgCyUyzgM
         PkWsxqJiUKaH93GKZqh+J6Tx9GmEzvjLAPs83YmL2Gkt9gUBj/Q88Lr7e+uzv1URoIzD
         VKiz75cG3gC5YRvgiukyfUkbgvM5OnMGUnJzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718207778; x=1718812578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JAgWI6yypeQvJHtBsLjxy9EsiTAtsBZFfQkPH4VMNc=;
        b=ABEmjC3VbQRmfoq8h7Pw3ezKXYFImgOj+6/u+fhPVix6GAuGTxKAfaYHWbjfmjGIgo
         +jmnhAb66tQkCP7AfiWb7rd+H2n9mSwEBTe68JFW8rBxOu9w3+iL+5hUDDu/RcHxCaS/
         tN9PY26C5X0GoZ91zxwgN62r4sGcZ27499XVZ0OO2ta1oHdSNhtXFa4Di1qo98Tqqm9c
         tepIePwdfKPNPqQoTM4UQClHZP0gT8PoJBKePuPCUQLtQ/M9BPHRIYwADJJCIuFZTyhH
         Np58kRv4EXJOqK8PfdIacNLSzzZtq6kFMdi6MQZz1Es6uSg6qFGUM/UCdXpEPXXlO6Y6
         ojDg==
X-Forwarded-Encrypted: i=1; AJvYcCUgl08mMEpTE5SY83DxlJiLYTqtF8xW59HMbAv9a2g4EDRp1uKHE5Z8kWw17jEKh1h4b7wo5mE6jshKNSHjxKqMsbAE3VwCf17M4i8=
X-Gm-Message-State: AOJu0YzetiZBk3CrofNXCY8r7iI9Nwt1caVp4Ab6lULoL1SLvOVxAi3n
	vo63/N3VuXhHOmZopK3AvY5/mO65RQCM3VGXt6UvKOC6A2vC3a6xcC54HC/Y6EQ=
X-Google-Smtp-Source: AGHT+IH3vJ/Cfk8LzYoeLv9cXT/SgN6Pt3X56xC7VVYFazmjn8i4deMSmAqg4iM25NKqjeo5TBvU1g==
X-Received: by 2002:a05:6214:2a47:b0:6b0:7365:dde0 with SMTP id 6a1803df08f44-6b2a33de160mr1306776d6.18.1718207777691;
        Wed, 12 Jun 2024 08:56:17 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0884337e9sm22877866d6.16.2024.06.12.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:56:17 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:56:15 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/26] xen-blkfront: don't disable cache flushes when
 they fail
Message-ID: <ZmnFH17bTV2Ot_iR@macbook>
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-11-hch@lst.de>
 <ZmlVziizbaboaBSn@macbook>
 <20240612150030.GA29188@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612150030.GA29188@lst.de>

On Wed, Jun 12, 2024 at 05:00:30PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 12, 2024 at 10:01:18AM +0200, Roger Pau Monné wrote:
> > On Tue, Jun 11, 2024 at 07:19:10AM +0200, Christoph Hellwig wrote:
> > > blkfront always had a robust negotiation protocol for detecting a write
> > > cache.  Stop simply disabling cache flushes when they fail as that is
> > > a grave error.
> > 
> > It's my understanding the current code attempts to cover up for the
> > lack of guarantees the feature itself provides:
> 
> > So even when the feature is exposed, the backend might return
> > EOPNOTSUPP for the flush/barrier operations.
> 
> How is this supposed to work?  I mean in the worst case we could
> just immediately complete the flush requests in the driver, but
> we're really lying to any upper layer.

Right.  AFAICT advertising "feature-barrier" and/or
"feature-flush-cache" could be done based on whether blkback
understand those commands, not on whether the underlying storage
supports the equivalent of them.

Worst case we can print a warning message once about the underlying
storage failing to complete flush/barrier requests, and that data
integrity might not be guaranteed going forward, and not propagate the
error to the upper layer?

What would be the consequence of propagating a flush error to the
upper layers?

> > Such failure is tied on whether the underlying blkback storage
> > supports REQ_OP_WRITE with REQ_PREFLUSH operation.  blkback will
> > expose "feature-barrier" and/or "feature-flush-cache" without knowing
> > whether the underlying backend supports those operations, hence the
> > weird fallback in blkfront.
> 
> If we are just talking about the Linux blkback driver (I know there
> probably are a few other implementations) it won't every do that.
> I see it has code to do so, but the Linux block layer doesn't
> allow the flush operation to randomly fail if it was previously
> advertised.  Note that even blkfront conforms to this as it fixes
> up the return value when it gets this notsupp error to ok.

Yes, I'm afraid it's impossible to know what the multiple incarnations
of all the scattered blkback implementations possibly do (FreeBSD,
NetBSD, QEMU and blktap at least I know of).

> > Overall blkback should ensure that REQ_PREFLUSH is supported before
> > exposing "feature-barrier" or "feature-flush-cache", as then the
> > exposed features would really match what the underlying backend
> > supports (rather than the commands blkback knows about).
> 
> Yes.  The in-tree xen-blkback does that, but even without that the
> Linux block layer actually makes sure flushes sent by upper layers
> always succeed even when not supported.

Given the description of the feature in the blkif header, I'm afraid
we cannot guarantee that seeing the feature exposed implies barrier or
flush support, since the request could fail at any time (or even from
the start of the disk attachment) and it would still sadly be a correct
implementation given the description of the options.

Thanks, Roger.
