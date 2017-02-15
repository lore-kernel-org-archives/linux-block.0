Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: support for multi-range discard requests V3
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20170208134650.5380-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4e254502-6beb-6fc5-1905-d86ed5c7f74a@grimberg.me>
Date: Wed, 15 Feb 2017 12:43:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170208134650.5380-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Hi all,
>
> this series adds support for merging discontiguous discard bios into a
> single request if the driver supports it.  This reduces the number of
> discards sent to the device by about a factor of 5-6 for typical
> workloads on NVMe, and for slower devices that use I/O scheduling
> the number will probably be even bigger but I've not implemented
> that support yet.
>
> Changes since V2:
>   - really fix nr of NVMe ranges to 256
>   - free range on error
>
> Changes since V1:
>   - hardcoded max ranges for NVMe to 255
>   - minor cleanups

Oops, reviewed v1 before noticing this one...
