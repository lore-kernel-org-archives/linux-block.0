Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/1] partitions/msdos: FreeBSD UFS2 file systems are
 not recognized
To: Richard <richard@aaazen.com>, Christoph Hellwig <hch@lst.de>,
 linux-block <linux-block@vger.kernel.org>
Cc: Andries Brouwer <aeb@cwi.nl>
References: <alpine.LNX.2.20.1705211222100.7469@thursday.test>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3bf6f7a5-66ff-5deb-85cf-6589176cdb09@kernel.dk>
Date: Tue, 23 May 2017 09:16:22 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.1705211222100.7469@thursday.test>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/21/2017 01:27 PM, Richard wrote:
> The code in block/partitions/msdos.c recognizes FreeBSD, OpenBSD
> and NetBSD partitions and does a reasonable job picking out OpenBSD
> and NetBSD UFS subpartitions.
> 
> But for FreeBSD the subpartitions are always "bad".
> 
>     Kernel: <bsd:bad subpartition - ignored
> 
> Though all 3 of these BSD systems use UFS as a file system, only
> FreeBSD uses relative start addresses in the subpartition
> declarations.
> 
> The following patch fixes this for FreeBSD partitions and leaves
> the code for OpenBSD and NetBSD intact:

Applied, thanks.

-- 
Jens Axboe
