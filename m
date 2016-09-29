Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 1/3] block: invalidate the page cache when issuing
 BLKZEROOUT.
To: "Darrick J. Wong" <darrick.wong@oracle.com>, <axboe@kernel.dk>,
	<akpm@linux-foundation.org>
References: <147510957066.8940.13803086684642725401.stgit@birch.djwong.org>
 <147510957761.8940.14476876584539116975.stgit@birch.djwong.org>
CC: <linux-block@vger.kernel.org>, <tytso@mit.edu>,
	<martin.petersen@oracle.com>, <snitzer@redhat.com>,
	<linux-api@vger.kernel.org>, <bfoster@redhat.com>, <xfs@oss.sgi.com>,
	<hch@infradead.org>, <dm-devel@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <58a6bc29-42d5-92f2-30bf-89168faa8eb0@sandisk.com>
Date: Wed, 28 Sep 2016 18:16:13 -0700
MIME-Version: 1.0
In-Reply-To: <147510957761.8940.14476876584539116975.stgit@birch.djwong.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 09/28/16 17:39, Darrick J. Wong wrote:
> Invalidate the page cache (as a regular O_DIRECT write would do) to avoid
> returning stale cache contents at a later time.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
