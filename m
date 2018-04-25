Return-Path: <alan.christopher.jenkins@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180424224604.GA28295@vader>
References: <20180417151000.9931-1-alan.christopher.jenkins@gmail.com>
 <20180417152136.16546-1-alan.christopher.jenkins@gmail.com> <20180424224604.GA28295@vader>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Date: Wed, 25 Apr 2018 09:46:00 +0100
Message-ID: <CANmMgnG=Gs0A_7_NAJLdDMFqYVzWxORe5akv+Aoeq-MeV=8QMw@mail.gmail.com>
Subject: Re: [PATCH v4] blktests: regression test "block: do not use
 interruptible wait anywhere"
To: Omar Sandoval <osandov@osandov.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 24/04/2018, Omar Sandoval <osandov@osandov.com> wrote:
> On Tue, Apr 17, 2018 at 04:21:36PM +0100, Alan Jenkins wrote:
>> > Without this fix, I get an IO error in this test:
>> >
>> > # dd if=/dev/sda of=/dev/null iflag=direct & \
>> >   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>> >   echo mem > /sys/power/state ; \
>> >   sleep 5; killall dd  # stop after 5 seconds
>>
>> linux-block specifically asked for a test derived from this reproducer.
>> They didn't come up with any suggestion for testing the code more
>> directly
>> (and robustly).  So this test uses system suspend, automated with
>> pm_test.
>>
>> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
>
> Hi, Alan, thanks for the test. I was able to come up with a
> deterministic reproducer which runs in a few seconds, added here:
> https://github.com/osandov/blktests/blob/master/tests/block/016.
On 24/04/2018, Omar Sandoval <osandov@osandov.com> wrote:
> On Tue, Apr 17, 2018 at 04:21:36PM +0100, Alan Jenkins wrote:
>> > Without this fix, I get an IO error in this test:
>> >
>> > # dd if=/dev/sda of=/dev/null iflag=direct & \
>> >   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>> >   echo mem > /sys/power/state ; \
>> >   sleep 5; killall dd  # stop after 5 seconds
>>
>> linux-block specifically asked for a test derived from this reproducer.
>> They didn't come up with any suggestion for testing the code more
>> directly
>> (and robustly).  So this test uses system suspend, automated with
>> pm_test.
>>
>> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
>
> Hi, Alan, thanks for the test. I was able to come up with a
> deterministic reproducer which runs in a few seconds, added here:
> https://github.com/osandov/blktests/blob/master/tests/block/016.

Thanks for the update, you may consider this reviewed.

It answers my concern and makes it look so easy.  I will console
myself that at least I had the right question :-).

Regards
Alan
