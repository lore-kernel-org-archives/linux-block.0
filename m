Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <46E25DBE-D153-4517-B6F7-5C32424E1332@linaro.org>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4> <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
 <20170502121605.GA294@x4> <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com>
 <D3002E96-EDB4-42FA-85F9-3B1E42EAB4DC@linaro.org> <CA+icZUURp65W36S+qcFO5Uwg+wBJS4N2Dw8z42S9BktfYjOFrg@mail.gmail.com>
 <46E25DBE-D153-4517-B6F7-5C32424E1332@linaro.org>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 16 May 2017 15:22:27 +0200
Message-ID: <CA+icZUXxnq2MAhZcmQ=x_tzvBeCWHyQETenM7h2Ug19rYj6CNw@mail.gmail.com>
Subject: Re: Playing with BFQ
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 16, 2017 at 10:45 AM, Paolo Valente
<paolo.valente@linaro.org> wrote:
>
>> Il giorno 13 mag 2017, alle ore 09:50, Sedat Dilek <sedat.dilek@gmail.com> ha scritto:
>>
>> On Wed, May 3, 2017 at 11:21 AM, Paolo Valente <paolo.valente@linaro.org> wrote:
>>>
>>>> Il giorno 03 mag 2017, alle ore 10:00, Sedat Dilek <sedat.dilek@gmail.com> ha scritto:
>>>>
>>>> On Tue, May 2, 2017 at 2:16 PM, Markus Trippelsdorf
>>>> <markus@trippelsdorf.de> wrote:
>>>>> On 2017.05.02 at 14:07 +0200, Sedat Dilek wrote:
>>>>>> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
>>>>>> <markus@trippelsdorf.de> wrote:
>>>>>>> On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I want to play with BFQ.
>>>>>>>>
>>>>>>>> My base is block-next as of 28-Apr-2017.
>>>>>> [...]
>>>>>>>> Not sure if the attached patches make sense (right now).
>>>>>>>
>>>>>>> No, it doesn't make sense at all.
>>>>>>
>>>>>> Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 patches do :-).
>>>>>
>>>>> BFQ started as a conventional scheduler. But because mq is the way of
>>>>> the future it was ported before it was accepted into mainline.
>>>>>
>>>>
>>>> I am still playing and want to do my own experiences with BFQ.
>>>>
>>>> Not sure if FIO is a good testcase-tool here.
>>>>
>>>
>>> If you want to perform a thorough benchmarking of also responsiveness
>>> and latency for time-sensitive applications (such as video playing)
>>> then you may want to use S [1].  It's rather rustic, do ask if you
>>> encounter any difficulty.
>>>
>>> [1] https://github.com/Algodev-github/S
>>>
>>
>> Sorry for the delay.
>
> Don't worry, I'm replying late too ...
>
>> Currently, I am swittching from Ubuntu/precise 12.04 LTS (EOL) back to
>> the Debian world.
>>
>> The responsiveness is really bad when my mlocate cron-job, a git pull
>> on linux.git and firefox runs parallel.
>
> Thanks for reporting this issue.  I have a few considerations and
> requests for information on it.
>
> 1) Two of the three sources of I/O you mention, namely mlocate update
> and git pull, are doing writes.  As I already pointed in a few
> occasions and places, intense write workloads trigger problems that an
> I/O scheduler cannot solve.  In contrast, these problems *can* be
> solved using BFQ.  In particular, I already have a prototype solution,
> but I have't found support yet to turn it into a possible
> production-level solution;  till a few days, ago, when I talked about
> this with Goldwyn Rodrigues (in CC). He seems interested in having a
> look at this solution, and possibly collaborating on it.
>
> 2) A web browser like Firefox can generate extremely varying
> workloads; so, if you mentioned Firefox as one of the sources of I/O
> in your unlucky situation, then it would be important to know what
> Firefox was doing.
>
> 3) Even if BFQ cannot counteract problems occurring above its head, it
> usually improves responsiveness even in heavy-write scenarios.  It
> would then be interesting if you could compare responsiveness with the
> other I/O schedulers (mq-deadline, Kyber) and with none too (make sure
> that the I/O is really the same in all cases).
>

Not willing to test on this dead horse called Ubuntu 12.04.

>
>> This is with Linux v4.11.1-rc1 and BFQ patchset v4.11.0-v8r11.
>>
>> My linux-config is attached.
>>
>>>> So if MQ is the way why isn't the Kconfig called CONFIG_MQ_IOSCHED_BFQ
>>>> according to CONFIG_MQ_IOSCHED_DEADLINE?
>>>>
>>>> As we are talking about "*Storage* I/O schedulers" which of the MQ
>>>> Kconfig make sense when using MQ_DEADLINE and (MQ_)BFQ?
>>>>
>>>> # egrep -i 'bfq|deadline|_mq|mq_|_mq_' /boot/config-4.11.0-1-bfq-amd64
>>>> CONFIG_POSIX_MQUEUE=y
>>>> CONFIG_POSIX_MQUEUE_SYSCTL=y
>>>> CONFIG_BLK_WBT_MQ=y
>>>> CONFIG_BLK_MQ_PCI=y
>>>> CONFIG_BLK_MQ_VIRTIO=y
>>>> CONFIG_IOSCHED_DEADLINE=y
>>>> CONFIG_IOSCHED_BFQ=y
>>>> CONFIG_BFQ_GROUP_IOSCHED=y
>>>> # CONFIG_DEFAULT_DEADLINE is not set
>>>> CONFIG_DEFAULT_BFQ=y
>>>> CONFIG_DEFAULT_IOSCHED="bfq"
>>>> CONFIG_MQ_IOSCHED_DEADLINE=y
>>>> # CONFIG_NET_SCH_MQPRIO is not set
>>>> CONFIG_SCSI_MQ_DEFAULT=y
>>>> # CONFIG_DM_MQ_DEFAULT is not set
>>>>
>>>
>>> The config for BFQ seems correct.  For the others, it depends on what
>>> scheduler you want.  If useful for you, the other two MQ- schedulers
>>> are mq-deadline and cyber.
>>>
>>
>> What about those two (Kconfig) patches which is in your current
>> bfq-4.11.y patchset.
>>
>
> I'm not sure I fully understand the purpose of the two patches you
> propose (in your following emails).  The first patch seems to move BFQ
> config options to a different position in Kconfig.iosched, but the
> position of those items should be irrelevant.  Am I missing something?
> The second patch seems to have to do with configuration bits of bfq
> for blk, yet such a bfq version is not available in mainline.
>
> In any case, for possible new submissions, you should inline your
> patches.  For complete instructions on submitting patches, have a look
> at Documentation/process/submitting-patches
>

All my testings was done with your patchset against Linux v4.11.y.
You have the same kconfig/kbuild stuff in your 0001 patch [1], so :-)?
What you have in 0001 is missing in Linux v4.12-rc1.
Not sure if this is intended.
I will re-submit and add a "4.12" in the subject-line when I am at home.

- Sedat -

[1] http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.11.0-v8r11/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r11-4.11..patch
