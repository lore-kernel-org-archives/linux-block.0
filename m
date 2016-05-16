Return-Path: <prvs=4944c44b96=axboe@fb.com>
Subject: Re: [PATCH 1/1] block: Use per-cpu partition in_flight counters.
To: Michael Callahan <coder.callahan@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <tc260ulmupc.fsf@vmbox.dyndns.org> <57325E37.6090309@kernel.dk>
 <CADm5WxMq=2yhvg44=-kDCWs09+t6UqE2TgQdpaSVYs5qyfVvyA@mail.gmail.com>
CC: Michael Callahan <michaelcallahan@fb.com>, <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <573A38F8.7070804@fb.com>
Date: Mon, 16 May 2016 15:17:44 -0600
MIME-Version: 1.0
In-Reply-To: <CADm5WxMq=2yhvg44=-kDCWs09+t6UqE2TgQdpaSVYs5qyfVvyA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/16/2016 02:06 PM, Michael Callahan wrote:
> I don't feel strongly about pursuing this one.  I could not measure a
> difference either way.

That answers that, then :-)

> This mailing list appears to be for patch submissions.  Where are the
> requests for review and discussion of half baked ideas happening?

The list serves both purposes. If you're just tossing something out 
there, prefixing the submission with RFC (request for comment) could 
help. Otherwise people assume it's a full patch submission, something 
that you are ready to land in mainline.

-- 
Jens Axboe
