Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca
Subject: Re: [PATCHSET v2] Add support for write life time hints
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
Date: Wed, 14 Jun 2017 11:45:56 -0400
In-Reply-To: <1497412919-19400-1-git-send-email-axboe@kernel.dk> (Jens Axboe's
	message of "Tue, 13 Jun 2017 22:01:49 -0600")
Message-ID: <yq160fyvah7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> A new iteration of this patchset, previously known as write streams.
> As before, this patchset aims at enabling applications split up
> writes into separate streams, based on the perceived life time
> of the data written. This is useful for a variety of reasons:
>
> - With NVMe 1.3 compliant devices, the device can expose multiple
>   streams. Separating data written into streams based on life time
>   can drastically reduce the write amplification. This helps device
>   endurance, and increases performance. Testing just performed
>   internally at Facebook with these patches showed up to a 25%
>   reduction in NAND writes in a RocksDB setup.
>
> - Software caching solutions can make more intelligent decisions
>   on how and where to place data.
>
> Contrary to previous patches, we're not exposing numeric stream values
> anymore.  I've previously advocated for just doing a set of hints that
> makes sense instead. See the coverage from the LSFMM summit this year:

I am all for having these write hints. But one request I would like to
make is that we just make them flags and abolish all notions of the term
"streams" from block for this particular use case (since it is more
hinty than streamy).

There are devices coming where a proper stream ID is prerequisite to
separate data streams for other reasons than bucketing based on data
lifetime. So my preference would be that we make the lifetime hints be
flags in block. That does not preclude using Streams Directives to
implement them in the NVMe NAND flash case. But it does not cause
conflicts with the use cases that need "proper" stream IDs for QoS or
colocation avoidance purposes in SCSI.

-- 
Martin K. Petersen	Oracle Linux Engineering
