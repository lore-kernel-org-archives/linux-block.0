Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/11] block: add support for carrying stream information
 in a bio
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-2-git-send-email-axboe@kernel.dk>
 <20170614203759.GA14953@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5691b9ed-8dec-2e4e-b92a-90e5f487554e@kernel.dk>
Date: Wed, 14 Jun 2017 14:44:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170614203759.GA14953@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 02:37 PM, Christoph Hellwig wrote:
> Btw, I think these could also easily map to DSM field in the NVMe
> write command, except that these unfortunately mix in read information
> as well.

But that's the problem, they are read/write mixed flags. I'd much
rather keep them separate. If some application finds it useful
to specify read access patterns, we should have separate flags for
those imho.

-- 
Jens Axboe
