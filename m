Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
 linux-block <linux-block@vger.kernel.org>, NeilBrown <neilb@suse.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
 <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
 <20180604182017.GA1351649@devbig577.frc2.facebook.com>
 <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f35436ab-bdac-5277-d0d2-b8432c620aff@kernel.dk>
Date: Mon, 4 Jun 2018 12:25:54 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/4/18 12:22 PM, Linus Torvalds wrote:
> On Mon, Jun 4, 2018 at 11:20 AM Tejun Heo <tj@kernel.org> wrote:
>>
>>
>> Looking at the code, the fundamental problem seems to be that it's
>> weaving different parts of sync and async paths.  I don't understand
>> why it'd punt the destructin of mddev but destroy biosets
>> synchronously.  Can't it do sth like the following?
> 
> Yeah, that looks like the right thing to do.
> 
> Jens/Kent?

I agree with Tejun, we already discussed this offline.

-- 
Jens Axboe
