Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-5-git-send-email-axboe@kernel.dk>
 <20170619062706.GC2311@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b04642e6-4ecc-f2e8-8184-6fff302d3d0b@kernel.dk>
Date: Mon, 19 Jun 2017 08:56:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170619062706.GC2311@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 12:27 AM, Christoph Hellwig wrote:
> On Sat, Jun 17, 2017 at 01:59:47PM -0600, Jens Axboe wrote:
>> Add four flags for the pwritev2(2) system call, allowing an application
>> to give the kernel a hint about what on-media life times can be
>> expected from a given write.
>>
>> The intent is for these values to be relative to each other, no
>> absolute meaning should be attached to these flag names.
>>
>> Set aside 3 bits in the iocb flags structure to carry this information
>> over from the pwritev2 RWF_WRITE_LIFE_* flags.
> 
> What is the strong use case for the per-I/O flags?  I'd much rather
> stick to fcntl only for now if we can.

Fine, I guess I should just have dusted off the 2 year old patchset,
as that was _exactly_ what that did.

-- 
Jens Axboe
