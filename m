Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <20170502121605.GA294@x4>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4> <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
 <20170502121605.GA294@x4>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 3 May 2017 10:00:07 +0200
Message-ID: <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com>
Subject: Re: Playing with BFQ
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, May 2, 2017 at 2:16 PM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> On 2017.05.02 at 14:07 +0200, Sedat Dilek wrote:
>> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
>> <markus@trippelsdorf.de> wrote:
>> > On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>> >> Hi,
>> >>
>> >> I want to play with BFQ.
>> >>
>> >> My base is block-next as of 28-Apr-2017.
>> [...]
>> >> Not sure if the attached patches make sense (right now).
>> >
>> > No, it doesn't make sense at all.
>>
>> Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 patches do :-).
>
> BFQ started as a conventional scheduler. But because mq is the way of
> the future it was ported before it was accepted into mainline.
>

I am still playing and want to do my own experiences with BFQ.

Not sure if FIO is a good testcase-tool here.

So if MQ is the way why isn't the Kconfig called CONFIG_MQ_IOSCHED_BFQ
according to CONFIG_MQ_IOSCHED_DEADLINE?

As we are talking about "*Storage* I/O schedulers" which of the MQ
Kconfig make sense when using MQ_DEADLINE and (MQ_)BFQ?

# egrep -i 'bfq|deadline|_mq|mq_|_mq_' /boot/config-4.11.0-1-bfq-amd64
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_BFQ=y
CONFIG_DEFAULT_IOSCHED="bfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_NET_SCH_MQPRIO is not set
CONFIG_SCSI_MQ_DEFAULT=y
# CONFIG_DM_MQ_DEFAULT is not set

Thanks.

- sed@ -
