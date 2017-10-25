Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/2] block: cope with WRITE ZEROES failing in
 blkdev_issue_zeroout()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.com>, linux-block <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>
References: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
 <CAOi1vP_-ycXO4hkedPmrdiZcUZchQzNE2gh-3Oq_F25Euv=ncQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f117c9f6-47cc-93a2-b340-4a79fa0da5b5@kernel.dk>
Date: Wed, 25 Oct 2017 11:28:55 -0700
MIME-Version: 1.0
In-Reply-To: <CAOi1vP_-ycXO4hkedPmrdiZcUZchQzNE2gh-3Oq_F25Euv=ncQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/2017 11:27 PM, Ilya Dryomov wrote:
> On Mon, Oct 16, 2017 at 3:59 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> Hi Christoph, Martin,
>>
>> blkdev_issue_zeroout() now checks for any error.  This required a minor
>> refactor, so I dropped the stable tag, Jens can add it back if needed.
>>
>> v2 -> v3:
>> - another code flow change in blkdev_issue_zeroout() suggested by
>>   Christoph -- no functional changes
>>
>> v1 -> v2:
>> - changed code flow in blkdev_issue_zeroout() according to Christoph's
>>   suggestion
>> - this required adding additional checks to blkdev_issue_zeroout() and
>>   __blkdev_issue_zero_pages(), the latter is no longer void
>>
>> Previous version at
>>
>>   https://marc.info/?l=linux-block&m=150712940922089&w=2
>>
>> Thanks,
>>
>>                 Ilya
>>
>>
>> Ilya Dryomov (2):
>>   block: factor out __blkdev_issue_zero_pages()
>>   block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
>>
>>  block/blk-lib.c | 108 +++++++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 72 insertions(+), 36 deletions(-)
> 
> Jens, can you pick these up?  Technically this is a user-visible
> regression (Fixes tag in 2/2), but we are late in the cycle so I'm not
> sure what is the right thing to do here.

It wasn't introduced in this cycle, so there's little point in trying
to rush it for 4.14. I have applied it for 4.15, thanks.

-- 
Jens Axboe
