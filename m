Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUVe40Pr97ZeRCaaiWWqLN-p12HCqPM2cNUPkeRbYsEF8w@mail.gmail.com>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4> <CA+icZUVe40Pr97ZeRCaaiWWqLN-p12HCqPM2cNUPkeRbYsEF8w@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 2 May 2017 11:14:48 +0200
Message-ID: <CA+icZUXQCdXAwtHxnKnpTdjwPP6ehowe82cJRtzPM9jeJgFXDA@mail.gmail.com>
Subject: Re: Playing with BFQ
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, May 2, 2017 at 10:07 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
>> On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>>> Hi,
>>>
>>> I want to play with BFQ.
>>>
>>> My base is block-next as of 28-Apr-2017.
>>>
>>> First I looked through the Kconfigs.
>>> What is a good setting?
>>> Built as module?
>>>
>>> How can I switch the IO-scheduler - real-time?
>>>
>>> Not sure if the attached patches make sense (right now).
>>
>> No, it doesn't make sense at all.
>> BFQ is a mq scheduler. To use it you should enable
>> SCSI_MQ_DEFAULT. And then you can switch schedulers like:
>>
>>  echo "kyber" > /sys/block/sda/queue/scheduler
>>  echo "bfq" > /sys/block/sdb/queue/scheduler
>>
>
> Great, I got these informations before starting a kernel-build.
>
> So, I have now...
>
> $ ./scripts/diffconfig /boot/config-4.11.0-1-iniza-amd64 .config
> -BLK_DEV_HD n
>  SCSI_MQ_DEFAULT n -> y
> +BFQ_GROUP_IOSCHED y
> +BLK_DEV_THROTTLING_LOW n
> +IOSCHED_BFQ y
> +MQ_IOSCHED_KYBER y
>
> Thanks, Markus.
>

This worked...

# cat /sys/block/sda/queue/scheduler
[mq-deadline] kyber bfq none

# echo "bfq" > /sys/block/sda/queue/scheduler

# cat /sys/block/sda/queue/scheduler
mq-deadline kyber [bfq] none

- sed@ -
