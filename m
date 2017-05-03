Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Playing with BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170503091628.GB292@x4>
Date: Wed, 3 May 2017 11:24:03 +0200
Cc: Sedat Dilek <sedat.dilek@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 linux-block@vger.kernel.org
Message-Id: <886609A4-9996-410F-8BB4-65B23866B31D@linaro.org>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com> <20170502080044.GA292@x4> <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com> <20170502121605.GA294@x4> <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com> <20170503091628.GB292@x4>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 03 mag 2017, alle ore 11:16, Markus Trippelsdorf =
<markus@trippelsdorf.de> ha scritto:
>=20
> On 2017.05.03 at 10:00 +0200, Sedat Dilek wrote:
>> On Tue, May 2, 2017 at 2:16 PM, Markus Trippelsdorf
>> <markus@trippelsdorf.de> wrote:
>>> On 2017.05.02 at 14:07 +0200, Sedat Dilek wrote:
>>>> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
>>>> <markus@trippelsdorf.de> wrote:
>>>>> On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>>>>>> Hi,
>>>>>>=20
>>>>>> I want to play with BFQ.
>>>>>>=20
>>>>>> My base is block-next as of 28-Apr-2017.
>>>> [...]
>>>>>> Not sure if the attached patches make sense (right now).
>>>>>=20
>>>>> No, it doesn't make sense at all.
>>>>=20
>>>> Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 =
patches do :-).
>>>=20
>>> BFQ started as a conventional scheduler. But because mq is the way =
of
>>> the future it was ported before it was accepted into mainline.
>>>=20
>>=20
>> I am still playing and want to do my own experiences with BFQ.
>>=20
>> Not sure if FIO is a good testcase-tool here.
>>=20
>> So if MQ is the way why isn't the Kconfig called =
CONFIG_MQ_IOSCHED_BFQ
>> according to CONFIG_MQ_IOSCHED_DEADLINE?
>=20
> Good point. The current naming is confusing.
>=20
> Also:
> # cat /sys/block/sda/queue/scheduler
> mq-deadline [kyber] bfq none
>=20
> These should all be prefixed with mq-.
>=20

The logic here, as proposed by Jens, is not to add the mq tag when
there is no risk of ambiguity (such as between deadline and
mq-deadline). I'm open to any sensible choice.

Thanks,
Paolo

> --=20
> Markus
