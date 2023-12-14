Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5F4CE1C
	for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOnKHaOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40C1C433C7;
	Thu, 14 Dec 2023 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574573;
	bh=qxlQtgc8WWiE15hT1ePlsBJhjOihSGL7iK+ugUPBjG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOnKHaOcUXofGGmRR0Vwe5loB1kWDOP+QMOHQSkjCuWU8XzYuIn6aJRsqDTRDNZsV
	 bVWmQwWn7WNN7dHplI6CiX8JSsgKzXVrB3JVmqioyqYjKD5vuQRlVXVv/zGUJEuavG
	 hxmIsAGFDfc0C11zTOsvkxmaStPtX0cv2eTIqdmsCuPWpmFi+01xZRZ2KsEerTN3uo
	 Xl2QBvewigAfiaZO5/CcLDIzI5k/SMetsfhmUvOg7IgiMKe5ep5aGpBQR0I0MfvNMe
	 EPX8Jwu0vLH/xr6MBrpMkulTg4XvParkHKTSEtkKoz+/NIxFlssJ1DAQYACHj70bBe
	 N6ocQLjwJv94g==
Date: Thu, 14 Dec 2023 09:22:51 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <ZXs563M66THrUw50@google.com>
References: <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
 <20231212182613.GA1216@lst.de>
 <ZXiual-UkUY4OWY2@google.com>
 <20231213155606.GA8748@lst.de>
 <ZXnevBo4eIZEXbhK@google.com>
 <20231214085729.GA9099@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214085729.GA9099@lst.de>

On 12/14, Christoph Hellwig wrote:
> On Wed, Dec 13, 2023 at 08:41:32AM -0800, Jaegeuk Kim wrote:
> > I don't have any
> > concern to keep the same ioprio on writes, since handheld devices are mostly
> > sensitive to reads. So, if you have other use-cases using zoned writes which
> > require different ioprio on writes, I think you can suggest a knob to control
> > it by users.
> 
> Get out of your little handheld world.  In Linux we need a generally usable
> I/O stack, and any feature exposed by the kernel and will be used quite
> differently than you imagine.
> 
> Just like people will add reordering to the I/O stack that's not there
> right now (in addition to the ones your testing doesn't hit).  That
> doensn't mean we should avoid them - you genereally get better performance
> by not reordering without a good reason (like thotting), but especially
> in error handling paths or resource constrained environment they will
> hapen all over.  We've had this whole discussion with the I/O barriers
> that did not work for exactly the same reasons.
> 
> > 
> > > 
> > > > it is essential to place the data per file to get better bandwidth. And for
> > > > NAND-based storage, filesystem is the right place to deal with the more efficient
> > > > garbage collecion based on the known data locations.
> > > 
> > > And that works perfectly fine match for zone append.
> > 
> > How that works, if the device gives random LBAs back to the adjacent data in
> > a file? And, how to make the LBAs into the sequential ones back?
> 
> Why would your device pick random LBAs?  If you send a zone append to
> zone it will be written at the write pointer, which is absolutely not
> random.  All I/O written in a single write is going to be sequential,
> so just like for all other devices doing large sequential writes is
> important.  Multiple writes can get reordered, but if you havily hit
> the same zone you'd get the same effect in the file system allocator
> too.

How can you guarantee the device does not give any random LBAs? What'd
be the selling point of zone append to end users? Are you sure this can
give the better write trhought forever? Have you considered how to
implement this in device side such as FTL mapping overhead and garbage
collection leading to tail latencies?

My takeaway on the two approaches would be:
                  zone_append        zone_write
		  -----------        ----------
LBA               from FTL           from filesystem
FTL mapping       Page-map           Zone-map
SRAM/DRAM needs   Large              Small
FTL GC            Required           Not required
Tail latencies    Exist              Not exisit
GC Efficience     Worse              Better
Longevity         As-is              Longer
Discard cmd       Required           Not required
Block complexity  Small              Large
Failure cases     Less exist         Exist
Fsck              Don't know         F2FS-TOOLS support
Filesystem        BTRFS support(?)   F2FS support

Given this, I took zone_write, especially for mobile devices, since we can
recover the unaligned writes in the corner cases by fsck. And, most benefit
would be getting rid of FTL mapping overhead which improves random read IOPs
significantly due to the lack of SRAM in low-end storages. And, longer lifetime
by mitigating garbage collection overhead is more important in mobile world.

If there's any flag or knob that we can set, IMO, that'd be enough.

> 
> > Sorry, I needed to stop reading here, as you're totally biased. This is not
> > the case in JEDEC, as Bart spent multiple years to synchronize the technical
> > benefitcs that we've seen across UFS vendors as well as OEMs.
> 
> *lol*  There is no more fucked up corporate pressure standard committee
> than the storage standards in JEDEC.  That's why not one actually takes
> them seriously.
