Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <15C3004B-B176-434B-A7E7-2DCD898C49D6@linaro.org>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4> <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
 <20170502121605.GA294@x4> <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com>
 <D3002E96-EDB4-42FA-85F9-3B1E42EAB4DC@linaro.org> <CA+icZUURp65W36S+qcFO5Uwg+wBJS4N2Dw8z42S9BktfYjOFrg@mail.gmail.com>
 <46E25DBE-D153-4517-B6F7-5C32424E1332@linaro.org> <CA+icZUXxnq2MAhZcmQ=x_tzvBeCWHyQETenM7h2Ug19rYj6CNw@mail.gmail.com>
 <15C3004B-B176-434B-A7E7-2DCD898C49D6@linaro.org>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 16 May 2017 15:38:40 +0200
Message-ID: <CA+icZUVionDoiynHpT3i9Lz0UYS0oeU4VZSjCMX3e+PC=u-f_Q@mail.gmail.com>
Subject: Re: Playing with BFQ
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

[...]

>>>> What about those two (Kconfig) patches which is in your current
>>>> bfq-4.11.y patchset.
>>>>
>>>
>>> I'm not sure I fully understand the purpose of the two patches you
>>> propose (in your following emails).  The first patch seems to move BFQ
>>> config options to a different position in Kconfig.iosched, but the
>>> position of those items should be irrelevant.  Am I missing something?
>>> The second patch seems to have to do with configuration bits of bfq
>>> for blk, yet such a bfq version is not available in mainline.
>>>
>>> In any case, for possible new submissions, you should inline your
>>> patches.  For complete instructions on submitting patches, have a look
>>> at Documentation/process/submitting-patches
>>>
>>
>> All my testings was done with your patchset against Linux v4.11.y.
>> You have the same kconfig/kbuild stuff in your 0001 patch [1], so :-)?
>> What you have in 0001 is missing in Linux v4.12-rc1.
>> Not sure if this is intended.
>
> 4.12-rc1 contains bfq for blk-mq, while the patch you mention is for
> bfq for blk (never accepted in mainline).  Maybe you could get a
> clearer idea by having a look at the commits that add bfq (for blk-mq)
> in 4.12-rc1.
>

I recall, Markus pointed me to that difference between the BFQ implementations.
For testing purposes: You want people to test BFQ in Linux v4.12?

- Sedat -

> Hope this helps,
> Paolo
>
>> I will re-submit and add a "4.12" in the subject-line when I am at home.
>>
>> - Sedat -
>>
>> [1] http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.11.0-v8r11/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r11-4.11..patch
>
