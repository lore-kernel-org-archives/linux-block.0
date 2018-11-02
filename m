Return-Path: <axboe@kernel.dk>
Subject: Re: recent issues with heavy delete's causing soft lockups
To: Thomas Fjellstrom <thomas@fjellstrom.ca>
Cc: linux-block@vger.kernel.org
References: <2800911.LnhMzhikfW@natasha>
 <BE7DD8B0-3D16-4AAC-9B49-E809EA30A0B6@kernel.dk> <5281881.2vk5iP2XJf@natasha>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <baa9f4e4-34e2-1112-5d01-ce86c1b51005@kernel.dk>
Date: Fri, 2 Nov 2018 14:37:08 -0600
MIME-Version: 1.0
In-Reply-To: <5281881.2vk5iP2XJf@natasha>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/2/18 2:32 PM, Thomas Fjellstrom wrote:
> On Saturday, October 27, 2018 1:20:10 PM MDT Jens Axboe wrote:
>> On Oct 27, 2018, at 12:40 PM, Thomas Fjellstrom <thomas@fjellstrom.ca> 
> [snip]
>>
>> Can you try 4.19? A patch went in since 4.18 that fixes a starvation issue
>> around requeue conditions, which SATA is the one to most often hit.
>>
>> Jens
> 
> I just had to do a clean, and I have the mq kernel options I mentioned in my 
> previous mail enabled. (mq should be disabled) and it appears to still be 
> causing issues. current io scheduler appears to be cfq, and it took that "make 
> clean" about 4 minutes, a lot of that time was spent with plasma, intelij, and 
> chrome all starved of IO. 
> 
> I did switch to a terminal and checked iostat -d 1, and it showed very little 
> actual io for the time I was looking at it.
> 
> I have no idea what's going on.

If you're using cfq, then it's not using mq at all. Maybe do something ala:

# perf record -ag -- sleep 10

while the slowdown is happening and then do perf report -g --no-children and
see if that yields anything interesting. Sounds like time is being spent
elsewhere and you aren't actually waiting on IO.

-- 
Jens Axboe
