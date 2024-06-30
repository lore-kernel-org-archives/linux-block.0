Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B730762EF
	for <linux-block@vger.kernel.org>; Sun, 30 Jun 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786913; cv=none; b=Km89xt5jvr/x+OXvRrsplio2RsI6IwbzQ3p8EEhbr0q2QYJyw3gAxfXD95P8dNIWa2hA63C5Zhyhlab4zW0BsLe0Bpe8EkQx73txh3JaSZHQaOoK8ruGmvqKjuEllnlgUagECjNDv2gP+H8Rso9klPhiWP3lZW/IgqmugTsdrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786913; c=relaxed/simple;
	bh=olHEF/CxcDtNg9YfRCOEZ+NCP26E1OcephsrWQxAZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q69DMH9/0s2Vp6v6zhgavNmEh1UluH72ILMX9qXSu4wWaEPK7a34kNYZ7+PqBHQ/7ezirngqXCPPkYlcGB5k//QPbW98pzyl6nSOa2M+OFZ/HWMuFK04TXMKnUFCXVk4JxgoaYP/L9OZsYfTMx8jQ/RWv2YMBJF+2DMx50c0ie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QVxguWV1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QVxguWV1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-72ed1fbc5d9so1553160a12.0
        for <linux-block@vger.kernel.org>; Sun, 30 Jun 2024 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719786911; x=1720391711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tFdvTA2jm9AOGMhPq5Jodplbz8dr8Q0emY1A+Sy4FJc=;
        b=QVxguWV1dKynYSlTpX6nADz8Z5KBLOUIqqFM/zT+9wynF3863vBvA3s/rYcMwbjTcC
         XxQevSKpV3J009WMUUve1Cy4P69G6yUuEQpuyNpTPB++ESHgyvFZP/fwPL2JXIqJ/ip1
         8KR8DdDR+sk3RBq3kvXa877Q3/o0HKmFvXfYEDewIRIsoObnqkKyNxt7Ql1J5O0QhH1q
         dzmrLHvLedRVBWzxImJZYLZTblXFHm6/xMbMyG5NQ3oW8TzZga4QPUfAZxKo7tYpucpL
         1+BMPCh4du0ZA8qhwICoHN/30K1XUVEBBzz9aME2/3r/lDDuf5H4pQL0UaZIDIQRnVWr
         ixow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719786911; x=1720391711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFdvTA2jm9AOGMhPq5Jodplbz8dr8Q0emY1A+Sy4FJc=;
        b=t3orU2gSiyo7wIEpXgSBR+kL632IzKjSQsWo4a39CGr1zcF1UvgUXslX0qM95Y1Old
         O+wjr99DlxrBJcUGysucIYaQwD1koM/qmIoHCfd23vscgXwPGYxqz2ICLoGDkyabyAVd
         5YTlsH3EkQPH11PHSq6qi5Vp2V3fC8chOzr0W0lJwpd3oY9girdIsmLAm7oMww2LS4XY
         GbM4qkCpGDTV+KObnE/tCGJpmMztkn6q4M4p3twDg0LOBTCjCbylA/VA+UtL0D7UqqrQ
         6xvPVhPROXQyr7NERsoZcFzgDgxkobFNV/2yJ5qMR8MQaFvaJG4ldb8sYpE8nNA+86sm
         4vFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz5Hu+OPXBqWQ/TH4P3z5O3XqQLkmoThzcYpd1doPOiLP0ibdG7eW18TCWyZRcfgjwTkfPMtd9A3fLOO6yEookalbxpmoDcZgq4qg=
X-Gm-Message-State: AOJu0YyCEAKzrirzQEj6cqv+I/7sTKG3rRJMeNcEKBR8MfbUfr1VN7je
	90Kzq3JJ1437cMw+GxR/RpPXmhz+g0k7Bo9CkR8/zrmIeeznvkj6e5D5zgd2lA8=
X-Google-Smtp-Source: AGHT+IFhV6inGmU7og/3AUkaqs9u1n6LF9SGxpoTNxGW+Hih2rv0JBQ0f/5vD+1wQ4Kj9hRINXUQNQ==
X-Received: by 2002:a05:6a20:9145:b0:1bd:2710:de5c with SMTP id adf61e73a8af0-1bef610a250mr8119019637.22.1719786911318;
        Sun, 30 Jun 2024 15:35:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708043b710fsm5112841b3a.156.2024.06.30.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 15:35:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sO38W-00HExi-0c;
	Mon, 01 Jul 2024 08:35:08 +1000
Date: Mon, 1 Jul 2024 08:35:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, martin.petersen@oracle.com,
	ebiggers@google.com, p.raghav@samsung.com, hare@suse.de,
	kbusch@kernel.org, neilb@suse.de, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	patches@lists.linux.dev
Subject: Re: [RFC] bdev: use bdev_io_min() for statx DIO min IO
Message-ID: <ZoHdnKjCfDgoTOTD@dread.disaster.area>
References: <20240628212350.3577766-1-mcgrof@kernel.org>
 <Zn-o3jQj4RkJobjS@infradead.org>
 <ZoDP0LgeLV3H1JbB@bombadil.infradead.org>
 <ZoDzC1qlEYTBkLPA@infradead.org>
 <ZoHDRfMomK8hnDXI@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoHDRfMomK8hnDXI@bombadil.infradead.org>

On Sun, Jun 30, 2024 at 01:42:45PM -0700, Luis Chamberlain wrote:
> On Sat, Jun 29, 2024 at 10:54:19PM -0700, Christoph Hellwig wrote:
> > On Sat, Jun 29, 2024 at 08:24:00PM -0700, Luis Chamberlain wrote:
> > > > The minimum_io_size clearly is the minimum I/O size, not the minimal
> > > > nice to have one. 
> > > 
> > > I may have misread the below documentation then, because it seems to
> > > suggest this is a performance parameter, not a real minimum. Do we need
> > > to update it?
> > 
> > queue_limits.min_io is corretly described and a performance hint.
> 
> OK, great!
> 
> > The statx dio_offset_align is actual minimum I/O size and alignment and
> > not in any way related to the performance hint in minimum_io_size.
> 
> Oh, darn, I just read again 825cf206ed510 ("statx: add direct I/O
> alignment information") and the block layer change through commit
> 2d985f8c6b91b ("vfs: support STATX_DIOALIGN on block devices") and
> no where do I see any mention of it being  a min. Should we clarify
> that?

dio_offset_align is an _alignment_ parameter, not a "size"
parameter. In no way does it define either the absolute or "best
performance" minimum IO size - it just defines the minimum valid
alignment for the file offset that the filesystem/device supports.

It is implied that an IO of dio_offset_align bytes in length will be
supported, because that is the minimum length IO that meets the
offset alignment requirements defined by dio_offset_align. 

> And should we add a respective value for performance?

We could, but we already have:

	__u32 stx_blksize;     /* Block size for filesystem I/O */

which is defined as:

	stx_blksize
	      The "preferred" block size for efficient filesystem
	      I/O.  (Writing to a file in smaller chunks may cause
	      an inefficient read-modify-rewrite.)

> I suspect
> userspace will want to work with optimal values, not ones which
> could for instance incur read-modify-write.

Yup, that's the very definition of what stx_blksize should contain.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
