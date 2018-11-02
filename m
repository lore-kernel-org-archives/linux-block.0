Return-Path: <thomas@fjellstrom.ca>
From: Thomas Fjellstrom <thomas@fjellstrom.ca>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: recent issues with heavy delete's causing soft lockups
Date: Fri, 02 Nov 2018 14:32:34 -0600
Message-ID: <5281881.2vk5iP2XJf@natasha>
In-Reply-To: <BE7DD8B0-3D16-4AAC-9B49-E809EA30A0B6@kernel.dk>
References: <2800911.LnhMzhikfW@natasha> <BE7DD8B0-3D16-4AAC-9B49-E809EA30A0B6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Saturday, October 27, 2018 1:20:10 PM MDT Jens Axboe wrote:
> On Oct 27, 2018, at 12:40 PM, Thomas Fjellstrom <thomas@fjellstrom.ca> 
[snip]
> 
> Can you try 4.19? A patch went in since 4.18 that fixes a starvation issue
> around requeue conditions, which SATA is the one to most often hit.
> 
> Jens

I just had to do a clean, and I have the mq kernel options I mentioned in my 
previous mail enabled. (mq should be disabled) and it appears to still be 
causing issues. current io scheduler appears to be cfq, and it took that "make 
clean" about 4 minutes, a lot of that time was spent with plasma, intelij, and 
chrome all starved of IO. 

I did switch to a terminal and checked iostat -d 1, and it showed very little 
actual io for the time I was looking at it.

I have no idea what's going on.

-- 
Thomas Fjellstrom
thomas@fjellstrom.ca
