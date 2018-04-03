Return-Path: <sitsofe@gmail.com>
MIME-Version: 1.0
In-Reply-To: <e3e148f3-672d-d383-76db-ef976e3335a9@kernel.dk>
References: <CALjAwxgAijfiqHpiQQGY9MmqzFyU+pP2Q2UwwbsPg5u4N0Uzjw@mail.gmail.com>
 <e3e148f3-672d-d383-76db-ef976e3335a9@kernel.dk>
From: Sitsofe Wheeler <sitsofe@gmail.com>
Date: Tue, 3 Apr 2018 16:05:48 +0100
Message-ID: <CALjAwxgAzKNg7LNNEC0b97kOj3xDZXLpm3DVnxWVXT_zdDZQeQ@mail.gmail.com>
Subject: Re: BFQ/Kyber as default I/O scheduler?
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 3 April 2018 at 15:21, Jens Axboe <axboe@kernel.dk> wrote:
> On 4/3/18 6:08 AM, Sitsofe Wheeler wrote:
>>
>> Is there any particular reason the new(ish) BFQ and Kyber I/O
>> schedulers have not been added to the "Default I/O scheduler" choices
>> in block/Kconfig.iosched ? Is it because they are multiqueue only?
>
> Yes, the default scheduler selection only applies to !mq schedulers.
> If you search the git log for "Architected-by" you can see why,
> there's some mailing archive goodness on the topic from the same
> time, too.

For those playing along at home the commit Jens is referring to is
"block: get rid of blk-mq default scheduler choice Kconfig entries"
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b86dd815ff74ab9eda474d1c28428ac0db2c3032
) and the mailing archive thread was
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1338302.html
).

Sigh, OK got it - udev rules for selecting multiqueue I/O schedulers
(at least until the day single queue block layer is ripped out).

(Finishing that thread made me feel like I'd been slapped in the face
by a wet trout and I had nothing to do with it! :-)

-- 
Sitsofe | http://sucs.org/~sits/
