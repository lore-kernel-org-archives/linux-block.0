Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3A14B956
	for <linux-block@vger.kernel.org>; Fri, 24 Jan 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721821; cv=none; b=iVJ7dWVCcjipOh9/15WzbP7e0rLnE9xY9du3bIrqW114Vyae5pxhvZTL2nALLCv7seWo0NtDlOyqyTEZUX2HtpblEi3p3gEwINdglej6vyogS6K0vrVGtClFpWoAck2bdJEoAMCmM3Oqfyc2At/fFMonkJH6pz4ANOvUgT7Crnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721821; c=relaxed/simple;
	bh=BWLDB83ZsNBSD402q8IGfk6yFapbcEhMtxmSrOhULKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9sU5brK8mrMIpYBRz0iYlWnlPn9/rVBAAxhh+UW72uNCO4kdZy7myCAmaqt98JoDRf6ap/mRhCTwuVJH/hkFYmr3UcDQvDUwrJbZ9laC4yIBlaVrIGc+liPxTTEhTJIS7Got8qoVLqIOV4zVr89XA8w390zJwg+w2UQpEP5AKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKAUKjps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKAUKjps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737721818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPI1trEADuU0nU3nyfaHFF8YcmRm1MGf4Uo6CEP1r4o=;
	b=HKAUKjpsnNpSsDUf0GgeDO61XO6mFZjqpTK1IbL4CXBvqjoIz0T6nWAo4p69Kq4cWXrHe4
	3Q5A299EYa0G40/1Z/OS1Ic6HLN301ab/nmtPvuvPn2jbOQaOC7hhuVlrbh310MmHHHn++
	xNM6XOBBskGEdaxGtnf3+0jMqAoPqcA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-9Jdd-fPDOa6N5TSH8ZcaSQ-1; Fri,
 24 Jan 2025 07:30:15 -0500
X-MC-Unique: 9Jdd-fPDOa6N5TSH8ZcaSQ-1
X-Mimecast-MFC-AGG-ID: 9Jdd-fPDOa6N5TSH8ZcaSQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C5D4195608F;
	Fri, 24 Jan 2025 12:30:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AAB619560A7;
	Fri, 24 Jan 2025 12:30:08 +0000 (UTC)
Date: Fri, 24 Jan 2025 20:30:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <Z5OHy76X2F9H6EWP@fedora>
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <Z33jJV6x1RnOLXvm@fedora>
 <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de>
 <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora>
 <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jan 24, 2025 at 06:30:19PM +0900, Damien Le Moal wrote:
> On 1/10/25 21:34, Ming Lei wrote:
> >> It is easy to extend rublk/zoned in this way with io_uring io emulation, :-)
> > 
> > Here it is:
> > 
> > https://github.com/ublk-org/rublk/commits/file-backed-zoned/
> > 
> > Top two commits implement the feature by command line `--path $zdir`:
> > 
> > 	[rublk]# git diff --stat=80 HEAD^^...
> > 	 src/zoned.rs   | 397 +++++++++++++++++++++++++++++++++++++++++++++++----------
> > 	 tests/basic.rs |  49 ++++---
> > 	 2 files changed, 363 insertions(+), 83 deletions(-)
> > 
> > It takes 280 new LoC:
> > 
> >     - support both ram-back and file-back
> >     - completely async io_uring IO emulation for zoned read/write IO
> >     - include selftest code for running mkfs.btrfs/mount/read & write IO/umount
> 
> Hi Ming,
> 
> My apologies for the late reply. Conference travel kept me busy.
> Thank you for doing this. I gave it a try and measured the performance for some
> write workloads (using current Linus tree which includes the block PR for 6.14).
> The zloop results shown here are with a slightly tweaked version (not posted)
> that changes to using a work item per command instead of having a single work
> for all commands.
> 
> 1 queue:
> ========
>                               +-------------------+-------------------+
>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
>  +----------------------------+-------------------+-------------------+
>  | QD=1,    4K rnd wr, 1 job  | 11.7k / 47.8 MB/s | 15.8k / 53.0 MB/s |
>  | QD=32,   4K rnd wr, 8 jobs | 63.4k / 260 MB/s  | 101k / 413 MB/s   |

I can't reproduce the above two, actually not observe obvious difference
between rublk/zoned and zloop in my test VM.

Maybe rublk works at debug mode, which reduces perf by half usually.
And you need to add device via 'cargo run -r -- add zoned' for using
release mode.

Actually there is just single io_uring_enter() running in each ublk queue
pthread, perf should be similar with kernel IO handling, and the main extra
load is from the single syscall kernel/user context switch and IO data copy,
and data copy effect can be neglected in small io size usually(< 64KB).

>  | QD=32, 128K rnd wr, 1 job  | 5008 / 656 MB/s   | 5993 / 786 MB/s   |
>  | QD=32, 128K seq wr, 1 job  | 2636 / 346 MB/s   | 5393 / 707 MB/s   |

ublk 128K BS may be a little slower since there is one extra copy.

>  +----------------------------+-------------------+-------------------+
> 
> 8 queues:
> =========
>                               +-------------------+-------------------+
>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
>  +----------------------------+-------------------+-------------------+
>  | QD=1,    4K rnd wr, 1 job  | 9699 / 39.7 MB/s  | 16.7k / 68.6 MB/s |
>  | QD=32,   4K rnd wr, 8 jobs | 58.2k / 238 MB/s  | 108k / 444 MB/s   |
>  | QD=32, 128K rnd wr, 1 job  | 4160 / 545 MB/s   | 5715 / 749 MB/s   |
>  | QD=32, 128K seq wr, 1 job  | 3274 / 429 MB/s   | 5934 / 778 MB/s   |
>  +----------------------------+-------------------+-------------------+
> 
> As you can see, zloop is generally much faster. This shows the best results from
> several runs as performance variation from one run to another can be significant
> (for both ublk and zloop).
> 
> But as mentioned before, since this is intended to be a test tool for file
> systems, performance is not the primary goal here (though the higher the better
> as that shortens test times). Simplicity is. And as Ted also stated, introducing
> a ublk and rust dependency in xfstests is far from ideal.

Simplicity need to be observed from multiple dimensions, 300 vs. 1500 LoC has
shown something already, IMO.


Thanks,
Ming

