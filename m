Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] elevator: remove second argument in elevator_init()
To: Alexey Klimov <klimov.linux@gmail.com>, linux-block@vger.kernel.org
References: <1452822371-4967-1-git-send-email-klimov.linux@gmail.com>
 <x49r3h2ag8y.fsf@segfault.boston.devel.redhat.com>
 <CALW4P++6YkPidw33i5x1zMoC4VvZ6uJT2=E4EZD_WHztsRZxGQ@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeff Moyer <jmoyer@redhat.com>, Yury Norov <yury.norov@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <56FC7098.1050503@kernel.dk>
Date: Wed, 30 Mar 2016 18:34:32 -0600
MIME-Version: 1.0
In-Reply-To: <CALW4P++6YkPidw33i5x1zMoC4VvZ6uJT2=E4EZD_WHztsRZxGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 03/30/2016 05:31 PM, Alexey Klimov wrote:
> Hi all,
>
> On Wed, Jan 27, 2016 at 9:01 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
>> Alexey Klimov <klimov.linux@gmail.com> writes:
>>
>>> Last user of elevator_init() with non-NULL name as second argument
>>> that supposed to be s390 dasd driver has gone few releases ago.
>>> Drivers rely on elevator_change(), elevator_switch() and friends
>>> for example. Right now elevator_init() is always called as
>>> elevator_init(q, NULL).
>>>
>>> Patch removes passing of second name argument and its usage.
>>>
>>> While we're at it fix following if-check after removed lines. We know
>>> that elevator_type e is initialized by NULL and need to check only
>>> chosen_elevator.
>>>
>>> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
>>
>> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
>
> what is the status of this patch? Is it that wrong and are there some
> concerns or do I need to resend it?

It looks fine, I'll pick it up for 4.7.

-- 
Jens Axboe
