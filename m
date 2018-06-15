Return-Path: <hare@suse.de>
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
To: Adam Manzanares <Adam.Manzanares@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Mel Gorman <mgorman@suse.com>, Hannes Reinecke <hare@suse.com>
References: <20180614133832.110947-1-hare@suse.de>
 <08318d74-d81c-29e5-5350-525df96eaacb@kernel.dk>
 <20180614172954.79965d13@pentland.suse.de>
 <656e4ab7-7c5c-41af-5596-2e155ffb28e4@kernel.dk>
 <20180614180937.591bb361@pentland.suse.de>
 <eca17002-e8dc-1a8b-6cc3-5eaf49031636@wdc.com>
 <bb90d333-fe4d-aa97-6c1c-66fb5b88dd6b@kernel.dk>
 <53893c29-febc-14ff-314d-818ac79aa559@wdc.com>
 <5f21f241-0ae0-ed7a-6935-3ef6e65d0950@kernel.dk>
 <d68c9052-e9bc-8dc4-04dc-964aff29308b@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a1034506-b50a-40f8-eee2-d353448da2fd@suse.de>
Date: Fri, 15 Jun 2018 08:06:04 +0200
MIME-Version: 1.0
In-Reply-To: <d68c9052-e9bc-8dc4-04dc-964aff29308b@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/14/2018 10:53 PM, Adam Manzanares wrote:
[ .. ]
>>>
>>> Then how about a numactl ... dd /dev/ram ... after the modprobe.
>>
>> Yes of course, or you could do that for every application that ends
>> up in the path of the doing IO to it. The point of the option is to
>> just make it explicit, and not have to either NUMA pin each task,
>> or prefill all possible pages.
>>
> 
> Makes sense, I have done some similar benchmarking and had to worry
> about NUMA awareness and the numactl + dd approach seemed to work
> because I wanted to not take a performance hit for page allocation
> during the benchmarking.
> 
> Would anyone be interested in forcing the allocations to occur during
> module initialization?
> 
YES.

Cheers,

Hannes
