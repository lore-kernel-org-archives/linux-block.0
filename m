Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Playing with BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com>
Date: Wed, 3 May 2017 11:21:47 +0200
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
 Jens Axboe <axboe@kernel.dk>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 linux-block@vger.kernel.org
Message-Id: <D3002E96-EDB4-42FA-85F9-3B1E42EAB4DC@linaro.org>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com> <20170502080044.GA292@x4> <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com> <20170502121605.GA294@x4> <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com>
To: sedat.dilek@gmail.com
List-ID: <linux-block@vger.kernel.org>


> Il giorno 03 mag 2017, alle ore 10:00, Sedat Dilek =
<sedat.dilek@gmail.com> ha scritto:
>=20
> On Tue, May 2, 2017 at 2:16 PM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
>> On 2017.05.02 at 14:07 +0200, Sedat Dilek wrote:
>>> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
>>> <markus@trippelsdorf.de> wrote:
>>>> On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>>>>> Hi,
>>>>>=20
>>>>> I want to play with BFQ.
>>>>>=20
>>>>> My base is block-next as of 28-Apr-2017.
>>> [...]
>>>>> Not sure if the attached patches make sense (right now).
>>>>=20
>>>> No, it doesn't make sense at all.
>>>=20
>>> Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 patches =
do :-).
>>=20
>> BFQ started as a conventional scheduler. But because mq is the way of
>> the future it was ported before it was accepted into mainline.
>>=20
>=20
> I am still playing and want to do my own experiences with BFQ.
>=20
> Not sure if FIO is a good testcase-tool here.
>=20

If you want to perform a thorough benchmarking of also responsiveness
and latency for time-sensitive applications (such as video playing)
then you may want to use S [1].  It's rather rustic, do ask if you
encounter any difficulty.

[1] https://github.com/Algodev-github/S

> So if MQ is the way why isn't the Kconfig called CONFIG_MQ_IOSCHED_BFQ
> according to CONFIG_MQ_IOSCHED_DEADLINE?
>=20
> As we are talking about "*Storage* I/O schedulers" which of the MQ
> Kconfig make sense when using MQ_DEADLINE and (MQ_)BFQ?
>=20
> # egrep -i 'bfq|deadline|_mq|mq_|_mq_' /boot/config-4.11.0-1-bfq-amd64
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> CONFIG_BLK_WBT_MQ=3Dy
> CONFIG_BLK_MQ_PCI=3Dy
> CONFIG_BLK_MQ_VIRTIO=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_BFQ=3Dy
> CONFIG_BFQ_GROUP_IOSCHED=3Dy
> # CONFIG_DEFAULT_DEADLINE is not set
> CONFIG_DEFAULT_BFQ=3Dy
> CONFIG_DEFAULT_IOSCHED=3D"bfq"
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> # CONFIG_NET_SCH_MQPRIO is not set
> CONFIG_SCSI_MQ_DEFAULT=3Dy
> # CONFIG_DM_MQ_DEFAULT is not set
>=20

The config for BFQ seems correct.  For the others, it depends on what
scheduler you want.  If useful for you, the other two MQ- schedulers
are mq-deadline and cyber.

Thanks,
Paolo

> Thanks.
>=20
> - sed@ -
