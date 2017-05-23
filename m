Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAPDyKFoBOqcb9pYnb1Wsv+YPOhKLuRVsPxr1QCGetNLn=6y78A@mail.gmail.com>
References: <20170519133732.27470-1-linus.walleij@linaro.org>
 <20170519133732.27470-6-linus.walleij@linaro.org> <CAPDyKFqzjv-C1SWh9_QD+LsHCMeg=R8nSeNgBsbPJ725PSMmDg@mail.gmail.com>
 <CACRpkdb9yRHiaK7qWarPFdLe3ODeQG9Hh8hG7uB6cb=9svkcWg@mail.gmail.com>
 <CAK8P3a3zbHstFvcYjeyPwqb3Hvs3gZEWPy2UGraoK2WmHy1JrQ@mail.gmail.com> <CAPDyKFoBOqcb9pYnb1Wsv+YPOhKLuRVsPxr1QCGetNLn=6y78A@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 May 2017 13:29:00 +0200
Message-ID: <CAK8P3a0c4Lhf7RkZJNdn4AX9gF=Y9g0XPnBD+c-=SQnsd=4WHA@mail.gmail.com>
Subject: Re: [PATCH 5/6] mmc: debugfs: Move card status retrieveal into the
 block layer
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 23, 2017 at 1:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>>> +#if IS_ENABLED(CONFIG_MMC_BLOCK)
>>>>
>>>> What wrong with a regular ifdefs stubs? Why do you need IS_ENABLED()?
>>>
>>> This is because the entire block layer can be compiled as a
>>> module.
>>
>> The block layer cannot be a module, but the MMC layer can.
>>
>>> I'm all for making CONFIG_MMC_BLOCK into a bool... but
>>> don't know how people (Intel laptops) feel about that extra
>>> code in their kernel at all times.
>>
>> I think CONFIG_MMC should remain tristate. However, we could
>> consider making CONFIG_MMC_BLOCK a 'bool' symbol and
>> linking it into the mmc-core module when enabled.
>
> That is a good idea, no matter what. We should do the same thing for
> CONFIG_MMC_TEST. There are really no need to have to separate modules,
> one is more than enough.

I think for the test module it conceptually makes more sense to
be separate, though I can see that this requires to be careful
with the debugfs file lifetime rules.

>>>> It seems like the life cycle of the card debugfs node is now being
>>>> controlled as when the mmc block device driver has been successfully
>>>> probed. We need to deal with that somehow.
>>>
>>> Only for these two files but yes.
>>>
>>> ext_csd is a bit dubious as it is only available on storage devices
>>> (eMMC) that can not be SD, SDIO or combo cards, and we could make
>>> it only appear if using the block layer.
>>>
>>> The card status however we need to keep if people want it.
>>>
>>> We *COULD* consider just thrashing these debugfs files. It is not
>>> technically ABI and I wonder who is actually using them.
>>
>> I think the ext_csd is extremely useful on storage devices to have
>> exposed to user space in some form. There is a comment saying
>> that we don't store it in RAM at the moment as it is rarely used,
>> but we could change that, as it's only 512 bytes per eMMC device
>> and there is rarely more than one of them. IIRC, the ext_csd is
>> entirely readonly and doesn't change during runtime, so we
>> gain nothing by issuing the commands every time someone reads
>> the debugfs file.
>
> First, we have mmc utils (going via mmc ioctl), which purpose are
> exactly for these cases. As a matter of fact it does a better job,
> since it even present the data in a more human readable format.
>
> Second, ext csd gets updated very often to control/change some
> behavior of the device. You must be mixing this up with some of the
> other card registers.

Ok, it's been a while since I looked at the details, thanks for the
clarification.

     Arnd
