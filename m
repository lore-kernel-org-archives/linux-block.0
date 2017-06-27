Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 9/9] nvme: add support for streams and directives
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com, linux-nvme@lists.infradead.org
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
 <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
 <20170627141115.GA2541@infradead.org>
 <ba468c95-40e0-41e7-0eb5-f5b4b70d3e3e@kernel.dk>
 <20170627144405.GA4605@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cd3cc640-5eb2-aeaf-a3a9-904436faae77@kernel.dk>
Date: Tue, 27 Jun 2017 08:46:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170627144405.GA4605@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 08:44 AM, Christoph Hellwig wrote:
> On Tue, Jun 27, 2017 at 08:16:49AM -0600, Jens Axboe wrote:
>> But we have to handle it, not doing so would be fragile. So our
>> options are:
>>
>> 1) Keep the stream_mappings[] array. It's simple, and it'll work
>>    for any number of streams.
>>
>> 2) Kill stream_mappings[] and just do the MOD again.
> 
> 3) print a message and tell streams aren't supported on this device.

Is that your nvme preference - if less than 4 streams, just ignore it?
Would seem a shame to lose out with 2 streams, I can think of several
hot/cold scenarios that would probably work fine with that. But at the
same time, not a big deal to me, if you prefer just turning it off
for < 4 streams, that's fine with me.

-- 
Jens Axboe
