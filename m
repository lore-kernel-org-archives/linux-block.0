Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 1 Mar 2017 16:11:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/12] fs: add a F_IOINFO fcntl
Message-ID: <20170301151108.GG12248@lst.de>
References: <20170228145737.19016-1-hch@lst.de> <20170228145737.19016-6-hch@lst.de> <20170228165139.GI5297@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228165139.GI5297@birch.djwong.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 28, 2017 at 08:51:39AM -0800, Darrick J. Wong wrote:
> Hm... is fio_alignment is specified in units of bytes?

Yes.

> If so, then
> shouldn't this be a __u32 so that we can handle some weird future device
> that wants, say, 1MB alignment for its atomic IO?

That would be pretty useless.  Anything bigger than sector / block
size would not really be usable for typical applications.

> Though, now that I look at the XFS ioinfo patch, I guess fio_alignment
> is set only for O_DIRECT files?

Yes.

> So it's really the required alignment
> for directio operations.

For buffered I/O we can write at byte granularity and still use the
atomic commits, but for direct I/O we can only COW at block size
granularity.
