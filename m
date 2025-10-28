Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAF369991
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691682; cv=none; b=c17/9jawJdNCUHL6Gn4bhU7+om5+JLrDX/BLPGCjrlh23hwWQbTllmnyhFGLA0d4tiyppdxDr6SBHoWcvoNtkEBpjgd1mpPbp9V7n4+BxGmdFm2p4ivoTKd5aRkB5W7wOJUOoYI8FzCwF27byAKJL2d+b3BV+tjIxisIFBcRTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691682; c=relaxed/simple;
	bh=1/WE+xbvc6Dal5pEAP6nQ5I9Rm9+W8PbrmOyYOyQAU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vECH3NiuA5BNFgieWdUtGA3p7TTfzn9W7qdayIHiNpI61XsPgqLrOdskeD0c9HWrYBltGs2rIfqRfrRmFGHNId48jXUzLpOunN40EmT7q181Ub135CzDZkT/+mXIgO4iOR0t2ZPnzMVucI3t4n+eJR/1WncRKK7WDCiVNYiz3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W30sudym; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W30sudym"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290da96b37fso49485ad.1
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761691680; x=1762296480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDTzcXmi62N+bAdKsA9MM3K6VkUn2QF2TaFyCxaOopA=;
        b=W30sudymZZrp4ynjftUHozOz2HuSQFvA/SRpYciZNEHK9RVgbZgYBBZ8W1sK0FSLz3
         GOUTFmW2eBvBklT+YTI0bBWHn+t+3xdwwtZc7j7ORSbELnpUw+uq88Vi1ywFkF+0FrZo
         5WBb/LecWkBKHxMB///Xs+yY6b8a0zx0ORcbhLkaxXB0sao9IE1fnM/EFUwfWcfB8Uwd
         tqTtCTb/h77fdJ+X5DzOw/ZqpIz87V5aPE0ameONgc0T7bP6XxUI3KYVgIQ0IAvt7gv0
         Lt7GJBAtjtB8vI1nvrLUswp7Rm+ey1+6VmxdG+g1AICdR/8x18p5ixQpdcCRYZMlYkZ+
         vtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691680; x=1762296480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTzcXmi62N+bAdKsA9MM3K6VkUn2QF2TaFyCxaOopA=;
        b=VF2d2glYfi+IuV69S9rbs0yGZbDNi8i+nJLNG89C/vvpjpUqZyPpL/w1WSp4XRzArA
         OpN0NWqC2iUxSh5MngJkGqJ7c2vr8z5ht2LfIsSR7LgIyfIo+nLvANUVFx2vbmB5jdfL
         SMWT3j9RomjGLi/OAsHV8VqARaRamRaZP/uyXJDiRSw4Z3Eqatq/HQbbW3MIK0G94fQh
         nmc3HaFDC+u117Zrzw7YlOB3PL+e/9qvougp8WIZNYhSC0sIEcrzlgoX7nF2YlJyooU0
         I1fU2feokpn9NDornfKT+mhv6NnDGeaLzP7RRCktwR2Jy86+yEd6xMv0MvKqxd1NvsS6
         5mFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGRFmWhDhu/VewkD4zH2Q1rf12LpTZwpl2E5PcPdx4gOeLorWCR86ThvddlP2k1TGcGf9Y/m7GQ6qf9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KqCAmJWHz6FWTvO66bEFsJIO/1ILG4We+tCtYgozqo62hC8c
	NwDFyBwyVe3o7eA0lrVI6uDtlP2rIsZn+A7Ql3R9fZWJOOsajOab6/tJbp0TGK0mUcr63qt/w8L
	5/9wcWg==
X-Gm-Gg: ASbGnctLDtq51NL98Hq0NdszKV1TiPuuvgN6XeTg5Kt5W9hFdoJy2Gj8jwc6LGph+9B
	Ilt+suFlWzfmqTZaj7S421VJnnsLCqCMxn9csMkjLPDZ5mJR0KrcuX1aHGqRUr6JbDQ3urifcLD
	CSL+I+KuhfV9CVFQOEG2CuTw44jDT8IYGQBNv0VAZ/wG89i1peteuKqOASXKs3BiU1/xj2Ir401
	0Gh4o5kznkFH7DYfiRLT4CrC931fRKYGazEiSE0E42fyAob/hVK97L2mxqKokBjs4PVm/edLpbD
	5/LyQbOrBwuuxK2BD7D1G9xc+jqewlHSqkg4pwX5684zPof0k5P/DaEbc0GLjYRJAXOqBW2vGqE
	ygX6Bja8MCRoUScJutY580xJAtf/E3JktvdX8d9MpXbohLHbDpM2K96NWl1aOStJn0+ZcSQStJl
	zVRI3QeLhMKlfGPe5r1PuSahPf+IZNi3lD/F9zf7hRUZR6LRfVu14oJNxe7VDWvrbrefb+CxDcW
	NeH9sVIdshltEdxg8E2SF0fehk9fTtZCdo=
X-Google-Smtp-Source: AGHT+IGVgm4/IjLLQT0cmQiv9nPeepYGw4HODw55Q9JYgkuJimkY420lDMBroEQm+to1DoESC9iCmA==
X-Received: by 2002:a17:902:f693:b0:291:6488:5af5 with SMTP id d9443c01a7336-294dffb2cecmr1077105ad.1.1761691679356;
        Tue, 28 Oct 2025 15:47:59 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4287bsm131385965ad.80.2025.10.28.15.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 15:47:58 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:47:53 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aQFIGaA5M4kDrTlw@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hByAKuQ7ycNwM@kbusch-mbp>

On Mon, Oct 27, 2025 at 10:42:47AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 04:25:10PM +0000, Carlos Llamas wrote:
> > Hey Keith, I'be bisected an LTP issue down to this patch. There is a
> > O_DIRECT read test that expects EINVAL for a bad buffer alignment.
> > However, if I understand the patchset correctly, this is intentional
> > move which makes this LTP test obsolete, correct?
> > 
> > The broken test is "test 5" here:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c
> > 
> > ... and this is what I get now:
> >   read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)
> 
> Yes, the changes are intentional. Your test should still see the read
> fail since it looks like its attempting a byte aligned memory offset,
> and most storage controllers don't advertise support for byte aligned
> DMA. So the problem is that you got EIO instead of EINVAL? The block
> layer that finds your misaligned address should have still failed with
> EINVAL, but that check is deferred to pretty low in the stack rather
> than preemptively checked as before. The filesystem may return a generic
> EIO in that case, but not sure. What filesystem was this using?

Cc: Eric Biggers <ebiggers@google.com>

Ok, I did a bit more digging. I'm using f2fs but the problem in this
case is the blk_crypto layer. The OP_READ request goes through
submit_bio() which then calls blk_crypto_bio_prep() and if the bio has
crypto context then it checks for bio_crypt_check_alignment().

This is where the LTP tests fails the alignment. However, the propagated
error goes through "bio->bi_status = BLK_STS_IOERR" which in bio_endio()
get translates to EIO due to blk_status_to_errno().

I've verified this restores the original behavior matching the LTP test,
so I'll write up a patch and send it a bit later.

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 1336cbf5e3bd..a417843e7e4a 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -293,7 +293,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_INVAL;
 		goto fail;
 	}
 
