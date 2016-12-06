Subject: Re: [PATCHSET/RFC v2] Make legacy IO schedulers work with blk-mq
To: Paolo Valente <paolo.valente@linaro.org>
References: <1480962426-15767-1-git-send-email-axboe@fb.com>
 <EC2ECF84-10DC-4A9C-8951-D87607C492F0@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <84313e6b-c0c8-8713-2ad6-b4c3ff52e011@fb.com>
Date: Tue, 6 Dec 2016 08:29:53 -0700
MIME-Version: 1.0
In-Reply-To: <EC2ECF84-10DC-4A9C-8951-D87607C492F0@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/06/2016 03:01 AM, Paolo Valente wrote:
> 
>> Il giorno 05 dic 2016, alle ore 19:26, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> Version 2 of the hack/patchset, that enables blk-mq to use the legacy
>> IO schedulers with single queue devices. Original posting is here:
>>
>> https://marc.info/?l=linux-block&m=148073493203664&w=2
>>
>> You can also found this version in the following git branch:
>>
>> git://git.kernel.dk/linux-block blk-mq-legacy-sched.2
>>
>> and new developments/fixes will happen in the 'blk-mq-legacy-sched'
>> branch.
>>
> 
> Hi Jens,
> while running some tests, the system hung after a while.
> 
> If I'm not mistaken, the above branches contain a (modified) 4.9-rc1.
> Maybe instability follows from that?  I have tried a rebase, but
> resulting conflicts are non-trivial (for me) to solve.
> 
> Meanwhile, if you deem it useful, I can provide you with the oops
> message, as I catch it.

Please do. I run my testing with master pulled in, but I can rebase the
branch to include that.

> As a secondary issue, iostat always reports 0 MB/s for both reads and
> writes, while tps are non null.

Looks like only the inflight stuff worked, but the completion bytes. Let
me fix that up. Done.

OK, pull from:

git://git.kernel.dk/linux-block blk-mq-legacy-sched

and you'll get the latest and greatest, and merged to 4.9-rc8 as well.

-- 
Jens Axboe
