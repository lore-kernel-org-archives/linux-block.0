Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
To: Adam Manzanares <Adam.Manzanares@wdc.com>, Hannes Reinecke <hare@suse.de>
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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5f21f241-0ae0-ed7a-6935-3ef6e65d0950@kernel.dk>
Date: Thu, 14 Jun 2018 14:47:39 -0600
MIME-Version: 1.0
In-Reply-To: <53893c29-febc-14ff-314d-818ac79aa559@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/14/18 2:41 PM, Adam Manzanares wrote:
> 
> 
> On 6/14/18 1:37 PM, Jens Axboe wrote:
>> On 6/14/18 2:32 PM, Adam Manzanares wrote:
>>>
>>>
>>> On 6/14/18 9:09 AM, Hannes Reinecke wrote:
>>>> On Thu, 14 Jun 2018 09:33:35 -0600
>>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>> On 6/14/18 9:29 AM, Hannes Reinecke wrote:
>>>>>> On Thu, 14 Jun 2018 08:47:33 -0600
>>>>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>     
>>>>>>> On 6/14/18 7:38 AM, Hannes Reinecke wrote:
>>>>>>>> For performance reasons we should be able to allocate all memory
>>>>>>>> from a given NUMA node, so this patch adds a new parameter
>>>>>>>> 'rd_numa_node' to allow the user to specify the NUMA node id.
>>>>>>>> When restricing fio to use the same NUMA node I'm seeing a
>>>>>>>> performance boost of more than 200%.
>>>>>>>
>>>>>>> Looks fine to me. One comment.
>>>>>>>    
>>>>>>>> @@ -342,6 +343,10 @@ static int max_part = 1;
>>>>>>>>    module_param(max_part, int, 0444);
>>>>>>>>    MODULE_PARM_DESC(max_part, "Num Minors to reserve between
>>>>>>>> devices");
>>>>>>>> +static int rd_numa_node = NUMA_NO_NODE;
>>>>>>>> +module_param(rd_numa_node, int, 0444);
>>>>>>>> +MODULE_PARM_DESC(rd_numa_node, "NUMA node number to allocate RAM
>>>>>>>> disk on.");
>>>>>>>
>>>>>>> This could feasibly be 0644, as there would be nothing wrong with
>>>>>>> altering this at runtime.
>>>>>>>    
>>>>>>
>>>>>> While we could it would not change the allocation of _existing_ ram
>>>>>> devices, making behaviour rather unpredictable.
>>>>>> Hence I did decide against it (and yes, I actually thought about
>>>>>> it).
>>>>>>
>>>>>> But if you insist ...
>>>>>
>>>>> Right, it would just change new allocations. Probably not a common use
>>>>> case, but there's really nothing that prevents it from being feasible.
>>>>>
>>>>> Next question - what does the memory allocator do if we run out of
>>>>> memory on the given node? Should we punt to a different node if that
>>>>> happens? Slower, but functional, seems preferable to not being able
>>>>> to get memory.
>>>>>
>>>>
>>>> Hmm. That I haven't considered; yes, that really sounds like an idea.
>>>> Will be sending an updated patch.
>>>
>>> Will numactl ... modprobe brd ... solve this problem?
>>
>> It won't, pages are allocated as needed.
>>
> 
> Then how about a numactl ... dd /dev/ram ... after the modprobe.

Yes of course, or you could do that for every application that ends
up in the path of the doing IO to it. The point of the option is to
just make it explicit, and not have to either NUMA pin each task,
or prefill all possible pages.

-- 
Jens Axboe
