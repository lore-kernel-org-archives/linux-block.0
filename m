Return-Path: <klimov.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56FC7098.1050503@kernel.dk>
References: <1452822371-4967-1-git-send-email-klimov.linux@gmail.com>
 <x49r3h2ag8y.fsf@segfault.boston.devel.redhat.com> <CALW4P++6YkPidw33i5x1zMoC4VvZ6uJT2=E4EZD_WHztsRZxGQ@mail.gmail.com>
 <56FC7098.1050503@kernel.dk>
From: Alexey Klimov <klimov.linux@gmail.com>
Date: Tue, 27 Sep 2016 01:13:45 +0100
Message-ID: <CALW4P+JmFGm5BR3OEUQjC9zJs+tjwrEAV_O0WL3W8yo5yBFmEw@mail.gmail.com>
Subject: Re: [PATCH] elevator: remove second argument in elevator_init()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 31, 2016 at 1:34 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 03/30/2016 05:31 PM, Alexey Klimov wrote:
>>
>> Hi all,
>>
>> On Wed, Jan 27, 2016 at 9:01 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
>>>
>>> Alexey Klimov <klimov.linux@gmail.com> writes:
>>>
>>>> Last user of elevator_init() with non-NULL name as second argument
>>>> that supposed to be s390 dasd driver has gone few releases ago.
>>>> Drivers rely on elevator_change(), elevator_switch() and friends
>>>> for example. Right now elevator_init() is always called as
>>>> elevator_init(q, NULL).
>>>>
>>>> Patch removes passing of second name argument and its usage.
>>>>
>>>> While we're at it fix following if-check after removed lines. We know
>>>> that elevator_type e is initialized by NULL and need to check only
>>>> chosen_elevator.
>>>>
>>>> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
>>>
>>>
>>> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>>
>>
>>
>> what is the status of this patch? Is it that wrong and are there some
>> concerns or do I need to resend it?
>
>
> It looks fine, I'll pick it up for 4.7.
>
> --
> Jens Axboe


So, I guess this one was lost: I can't find it in the tree.
Looks like the easiest way will be to rebase (and check that it's
still fine) and resend. Right?

Best regards,
Alexey.
