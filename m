Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <20170502080044.GA292@x4>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 2 May 2017 14:07:11 +0200
Message-ID: <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
Subject: Re: Playing with BFQ
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>> Hi,
>>
>> I want to play with BFQ.
>>
>> My base is block-next as of 28-Apr-2017.
[...]
>> Not sure if the attached patches make sense (right now).
>
> No, it doesn't make sense at all.

Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 patches do :-).

- Sedat -

[1] http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.11.0-v8r11/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r11-4.11..patch
[2] http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.11.0-v8r11/0002-block-introduce-the-BFQ-v7r11-I-O-sched-for-4.11.0.patch
[3] http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.11.0-v8r11/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r11-for.patch
[4] http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.11.0-v8r11/0004-blk-bfq-turn-BFQ-v7r11-for-4.11.0-into-BFQ-v8r11-for.patch
