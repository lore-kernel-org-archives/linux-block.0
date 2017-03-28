Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-stat: add a poll_size value to the request_queue
 struct
To: Stephen Bates <sbates@raithlin.com>, Sagi Grimberg <sagi@grimberg.me>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-3-git-send-email-sbates@raithlin.com>
 <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
 <25CE7F43-DD1B-42D6-A891-A3D916BD0877@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "osandov@osandov.com" <osandov@osandov.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <88815dc6-04b2-0915-597d-1e335b6d2ba2@kernel.dk>
Date: Tue, 28 Mar 2017 13:46:52 -0600
MIME-Version: 1.0
In-Reply-To: <25CE7F43-DD1B-42D6-A891-A3D916BD0877@raithlin.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/28/2017 01:38 PM, Stephen  Bates wrote:
>>>
>>>  In order to bucket IO for the polling algorithm we use a sysfs entry
>>>  to set the filter value. It is signed and we will use that as follows:
>>>
>>>   0   : No filtering. All IO are considered in stat generation
>>>   > 0 : Filtering based on IO of exactly this size only.
>>>   < 0 : Filtering based on IO less than or equal to -1 time this value.>
>>
>> I'd say that this is a fairly non-trivial semantic meanning to this...
>>
>> Is there any use for the size exact match filter? If not then
>> I suggest we always make it (<=) in its semantics...
> 
> Thanks for the review Sagi. I�d be OK going with <=0 as the exact
> match would normally be for minimal IO sizes (where <= and = are the
> same thing). I will see what other feedback I get and aim to do a
> respin soon�

No tunables for this, please. There's absolutely no reason why we should
need it.

-- 
Jens Axboe
