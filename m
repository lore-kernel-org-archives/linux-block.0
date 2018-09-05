Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: don't warn when calling fsync on read-only block
 devices
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Zdenek Kabelac <zkabelac@redhat.com>,
 WGH <wgh@torlan.ru>, linux-block@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>
References: <alpine.LRH.2.02.1808221217030.30929@file01.intranet.prod.int.rdu2.redhat.com>
 <222ce989-dbb9-b994-a97f-4dce04f5bc69@kernel.dk>
 <alpine.LRH.2.02.1809031725530.27063@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d0a42d2c-a6a0-701e-c142-001f570c4d19@kernel.dk>
Date: Wed, 5 Sep 2018 16:14:13 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1809031725530.27063@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/3/18 4:05 PM, Mikulas Patocka wrote:
> 
> 
> On Wed, 22 Aug 2018, Jens Axboe wrote:
> 
>> On 8/22/18 10:23 AM, Mikulas Patocka wrote:
>>> It is possible to call fsync on a read-only handle (for example, fsck.ext2 
>>> does it when doing read-only check), and this call results in kernel 
>>> warning. This bug was introduced by the commit 721c7fc701c7 "block: fail 
>>> op_is_write() requests to read-only partitions".
>>
>> Similar patch is already queued up, it'll go into Linus's tree before
>> -rc1.
>>
>> -- 
>> Jens Axboe
> 
> I think you mean the patch b089cfd95d32638335c551651a8e00fd2c4edb0b, but 
> it doesn't work.
> 
> The first problem is that bio_op returns the opcode, but op_is_flush 
> expects flags as its parameter. bio_op strips off the flags, and so the 
> condition op_is_flush is never true and the warning is not shut off.
> 
> Anoher problem is that the flags REQ_FUA and REQ_PREFLUSH may be 
> superimposed on regular write bio and in that case the warning should be 
> triggered. We want to shut the warning off only if bio_sectors is zero 
> (i.e. if the flush request is not superimposed on regular write).

Thanks for fixing that up, that was somewhat of a disaster. Applied.

-- 
Jens Axboe
