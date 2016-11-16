Subject: Re: [PATCHSET v3] block: IO polling improvements
To: Stephen Bates <sbates@raithlin.com>
References: <1478927487-12998-1-git-send-email-axboe@fb.com>
 <e25d7e34cde7a478b1593555bc980236.squirrel@webmail.raithlin.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, hch@infradead.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <096cd79c-6b89-30dc-db0d-f771546a554d@fb.com>
Date: Wed, 16 Nov 2016 13:59:24 -0700
MIME-Version: 1.0
In-Reply-To: <e25d7e34cde7a478b1593555bc980236.squirrel@webmail.raithlin.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/16/2016 10:31 AM, Stephen Bates wrote:
> On Fri, November 11, 2016 11:11 pm, Jens Axboe wrote:
>> Respun on top of for-4.10/block, dropping patches that have been
>> merged. This patchset adds Christoph's simplified sync O_DIRECT bdev access
>> mode, and implements a more efficient IO polling on top of it. For more
>> details, see the v2 posting here:
>>
>> http://www.mail-archive.com/linux-block@vger.kernel.org/msg02079.html
>>
>>
>> Changes since v2:
>>
>>
>> - Adapt to blk stat changes
>> - Make it explicit that only blk-mq supports polling
>> - Fix a bug in the hrtimer code, switching to absolute mode if we
>> have to loop around (thanks Omar).
>>
>
> Hi Jens
>
> I applied this series cleanly on top of 2868f13c303e147 in your
> for-4.10/block branch. I tested using a simple fio wrapper script [1] on a
> low-latency NVMe SSD [2]. Here are some results:
>
> io_poll  io_poll_delay  threads  latency  CPU/threads
>
> 0        N/A            1        17.0     47%
> 1        -1             1        13.8     100%
> 1        0              1        14.6     73%
> 1        10             1        17.0     56%
>
> 0        N/A            8        18.7     47%
> 1        -1             8        14.4     100%
> 1        0              8        15.7     73%
> 1        10             8        19.0     56%
>
> The io_poll_delay option 0 is definitely a nice compromise between no
> polling and 100% polling. The result for io_poll_delay=10us is interesting
> as it implies there might be some mismatch between that value and the
> completion time. However I think that is something we can improve on over
> time and I don't see it as a reason to not get this series upstream.
>
> For the series:
>
> Tested-By: Stephen Bates <sbates@raithlin.com>
> Reviewed-By: Stephen Bates <sbates@raithlin.com>

Thanks for testing, Stephen, I'll add your tested/reviewed-by tags. As
to the specific setting of the time, it might just be that it's a poor
choice of value. We'll need some time to setup the delay, and if we end
up being late, then we'll make things worse. But I agree, we can look
into that going forward. I've got some more ideas on how to improve the
timing in general, so we can both get closer to -1 and get better
efficiency as well.

-- 
Jens Axboe
