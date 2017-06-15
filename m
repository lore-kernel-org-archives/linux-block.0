Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 03/11] fs: add support for an inode to carry stream
 related data
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-4-git-send-email-axboe@kernel.dk>
 <20170615081733.GC10599@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d3437d23-7ec8-4dcc-9a76-cafbe22c8619@kernel.dk>
Date: Thu, 15 Jun 2017 08:22:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170615081733.GC10599@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/15/2017 02:17 AM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2017 at 09:45:04PM -0600, Jens Axboe wrote:
>> No functional changes in this patch, just in preparation for
>> allowing applications to pass in hints about data life times
>> for writes.
>>
>> Pack the i_write_hint field into a 2-byte hole, so we don't grow
>> the size of the inode.
> 
> A u8 should be plenty.  But talking about the representation -
> your write lifetime hints are a 5 option enum basically.  I wonder
> if we really should encode it as flags, or if we should have an
> enum (which could be packed into a 3-bit bitfield) and then pass
> it down the stack in that form instead of changing the representation
> N times.

If we keep the RWF_WRITE_LIFE_* flags, then yes, I think we should
unify the RWF_WRITE_LIFE_*, IOCB_WRITE_LIFE_*, and REQ_WRITE_LIFE_*
flags into a specific type.


-- 
Jens Axboe
