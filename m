Return-Path: <axboe@kernel.dk>
Subject: Re: bug in tag handling in blk-mq?
To: Mike Galbraith <efault@gmx.de>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Oleksandr Natalenko <oleksandr@natalenko.name>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
 <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
 <1525797766.5204.2.camel@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
Date: Tue, 8 May 2018 14:37:52 -0600
MIME-Version: 1.0
In-Reply-To: <1525797766.5204.2.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-block@vger.kernel.org>

On 5/8/18 10:42 AM, Mike Galbraith wrote:
> On Tue, 2018-05-08 at 08:55 -0600, Jens Axboe wrote:
>>
>> All the block debug files are empty...
> 
> Sigh.  Take 2, this time cat debug files, having turned block tracing
> off before doing anything else (so trace bits in dmesg.txt should end
> AT the stall).

OK, that's better. What I see from the traces:

- You have regular IO and some non-fs IO (from scsi_execute()). This mix
  may be key.

- sdd has nothing pending, yet has 6 active waitqueues.

I'm going to see if I can reproduce this. Paolo, what kind of attempts
to reproduce this have you done?

-- 
Jens Axboe
