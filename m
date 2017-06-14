Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-5-git-send-email-axboe@kernel.dk>
 <20170614202657.GB7022@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <06421290-d3dd-cf96-2f6f-930dbe296c09@kernel.dk>
Date: Wed, 14 Jun 2017 14:37:42 -0600
MIME-Version: 1.0
In-Reply-To: <20170614202657.GB7022@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 02:26 PM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2017 at 01:05:27PM -0600, Jens Axboe wrote:
>> Add four flags for the pwritev2(2) system call, allowing an application
>> to give the kernel a hint about what on-media life times can be
>> expected from a given write.
>>
>> The intent is for these values to be relative to each other, no
>> absolute meaning should be attached to these flag names.
>>
>> Define IOCB flags to carry this information over, and finally
>> transform them into the block defined stream values.
> 
> Note that we also have the RWF_NOWAIT flag pending, with which this
> would clash.  Maybe move it to the end of the space.

That's a trivial thing to resolve. Whomever goes last can resolve
that. I can put them at the end if you feel strongly about it, I
personally don't really care.

-- 
Jens Axboe
