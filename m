Return-Path: <chuhu.ncepu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel> <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
 <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
 <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk> <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
From: Chunyu Hu <chuhu.ncepu@gmail.com>
Date: Fri, 8 Jun 2018 14:12:34 +0800
Message-ID: <CABATaM6575m0g3B4_tuEfh3-14hZUuEV4=32zfZ+7jr+mJnz9Q@mail.gmail.com>
Subject: Re: Block IO issue in kernel-v4.17
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Li Wang <liwang@redhat.com>,
	Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com, snitzer@redhat.com,
	linux-block@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 7 June 2018 at 23:41, Jens Axboe <axboe@kernel.dk> wrote:
> On 6/7/18 8:46 AM, Jens Axboe wrote:
>> On 6/7/18 12:33 AM, Chunyu Hu wrote:
>>> kasan reported a user-after-free. I'm using a kvm machine, it panic
>>> during boot. I'm using the latest linux tree. which contains below.
>>>
>>> commit d377535405686f735b90a8ad4ba269484cd7c96e
>>> Author: Kent Overstreet <kent.overstreet@gmail.com>
>>> Date:   Tue Jun 5 05:26:33 2018 -0400
>>>
>>>     dm: Use kzalloc for all structs with embedded biosets/mempools
>>
>> Can you try with the below? Li Wang, would be great if you could too.
>
> Please try this one instead.

My kvm machine boot successfully with this and works fine under pressure.
Thanks for the fix.
