Return-Path: <rgoldwyn@suse.de>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
To: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Andreas Dilger <adilger@dilger.ca>, Goldwyn Rodrigues
 <rgoldwyn@suse.com>, Andi Kleen <ak@linux.intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 darrick.wong@oracle.com
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
 <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
 <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
 <C6C37388-622C-451D-B14D-953EBE580995@dilger.ca>
 <175784d7-70e7-3be1-47f0-ae67ab37e921@kernel.dk>
 <2b11e24d-d09c-f7c4-db6d-6ecc1ce40719@suse.de>
 <38e72c8a-c178-7930-3858-83d860e568a2@kernel.dk>
 <20180123063549.GA1583@bombadil.infradead.org>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <44793882-fd2b-190e-eda6-22d7054c4677@suse.de>
Date: Thu, 25 Jan 2018 12:01:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180123063549.GA1583@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 01/23/2018 12:35 AM, Matthew Wilcox wrote:
> On Mon, Jan 22, 2018 at 08:28:54PM -0700, Jens Axboe wrote:
>> On 1/22/18 8:18 PM, Goldwyn Rodrigues wrote:
>>>> that their application was "already broken". I'd hate for a kernel
>>>> upgrade to break them.
>>>>
>>>> I do wish we could make the change, and maybe we can. But it probably
>>>> needs some safe guard proc entry to toggle the behavior, something we
>>>> can drop in a few years when we're confident it won't break real
>>>> applications.
>>>
>>> Assuming we call it /proc/sys/fs/dio_short_writes(better names/paths?),
>>> should it be enabled or disabled by default?
>>
>> I'd enable it by default, if not, you are never going to be able to
>> remove it because you'll have no confidence that anyone actually flipped
>> the switch and ran with it enabled. The point of having it there and on
>> by default would be that if something does break, people have the option
>> of turning it off and restoring the previous behavior, without having to
>> change the kernel.
> 
> I think it's an opt-in prctl that's something like PRCTL_SHORT_WRITES_ALLOWED.
> 

I cannot decide where to stick this bit in the task_struct.
current->flags/PF_* does not seem right. Don't want to start a new
fs_flags field. Suggestions?

-- 
Goldwyn
