Return-Path: <axboe@kernel.dk>
Subject: Re: BFQ/Kyber as default I/O scheduler?
To: Sitsofe Wheeler <sitsofe@gmail.com>, linux-block@vger.kernel.org
Cc: Paolo Valente <paolo.valente@linaro.org>
References: <CALjAwxgAijfiqHpiQQGY9MmqzFyU+pP2Q2UwwbsPg5u4N0Uzjw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e3e148f3-672d-d383-76db-ef976e3335a9@kernel.dk>
Date: Tue, 3 Apr 2018 08:21:59 -0600
MIME-Version: 1.0
In-Reply-To: <CALjAwxgAijfiqHpiQQGY9MmqzFyU+pP2Q2UwwbsPg5u4N0Uzjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/3/18 6:08 AM, Sitsofe Wheeler wrote:
> Hi,
> 
> Is there any particular reason the new(ish) BFQ and Kyber I/O
> schedulers have not been added to the "Default I/O scheduler" choices
> in block/Kconfig.iosched ? Is it because they are multiqueue only?

Yes, the default scheduler selection only applies to !mq schedulers.
If you search the git log for "Architected-by" you can see why,
there's some mailing archive goodness on the topic from the same
time, too.


-- 
Jens Axboe
