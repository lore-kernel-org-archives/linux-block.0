Return-Path: <coder.callahan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <57325E37.6090309@kernel.dk>
References: <tc260ulmupc.fsf@vmbox.dyndns.org>
	<57325E37.6090309@kernel.dk>
Date: Mon, 16 May 2016 14:06:19 -0600
Message-ID: <CADm5WxMq=2yhvg44=-kDCWs09+t6UqE2TgQdpaSVYs5qyfVvyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: Use per-cpu partition in_flight counters.
From: Michael Callahan <coder.callahan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Michael Callahan <michaelcallahan@fb.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

I don't feel strongly about pursuing this one.  I could not measure a
difference either way.

This mailing list appears to be for patch submissions.  Where are the
requests for review and discussion of half baked ideas happening?


On Tue, May 10, 2016 at 4:18 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 05/10/2016 04:09 PM, Michael Callahan wrote:
>>
>> Move the partition in_flight counters from hd_struct to disk_stats so
>> that they become tracked on a per-cpu basis.
>>
>> Sign-off-by: Michael Callahan <michaelcallahan@fb.com>
>
>
> ^^ Signed-off-by
>
>> ---
>>
>> This patch is incomplete as it just comments out use of in_flight in dm.c
>> as
>> that code tracks io statistics in it's own special way.  Any thoughts on
>> how to fix dm.c are welcome.
>
>
> This has been done and rejected before. The problem is that you are now
> having to do a full per cpu loop in part_in_flight(), which is a
> non-starter. Unless you can make that part more clever, than it's not going
> to be a great idea.
>
> Generally, doing patches like this, you should include test results showing
> why this is a good idea. A good commit message is a "why" for the patch.
>
> --
> Jens Axboe
>
