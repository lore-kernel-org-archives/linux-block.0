Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdb9yRHiaK7qWarPFdLe3ODeQG9Hh8hG7uB6cb=9svkcWg@mail.gmail.com>
References: <20170519133732.27470-1-linus.walleij@linaro.org>
 <20170519133732.27470-6-linus.walleij@linaro.org> <CAPDyKFqzjv-C1SWh9_QD+LsHCMeg=R8nSeNgBsbPJ725PSMmDg@mail.gmail.com>
 <CACRpkdb9yRHiaK7qWarPFdLe3ODeQG9Hh8hG7uB6cb=9svkcWg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 May 2017 13:04:47 +0200
Message-ID: <CAPDyKFo4HXDSv6P=8xFpFETSW1i1Lg05fYGxKTv8WJyWFOCDcg@mail.gmail.com>
Subject: Re: [PATCH 5/6] mmc: debugfs: Move card status retrieveal into the
 block layer
To: Linus Walleij <linus.walleij@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

[...]

>> Seems like a bit of re-factoring/cleanup could help here as
>> preparation step. I just posted a patch [1] cleaning up how the mmc
>> block layer fetches the card's status.
>>
>> Perhaps that could at least simplify a bit for $subject patch,
>> especially since it also makes mmc_send_status() being exported.
>
> OK if you merge your stuff I can iterate my patches on top,
> no problem.

Done!

>
>>> +#if IS_ENABLED(CONFIG_MMC_BLOCK)
>>
>> What wrong with a regular ifdefs stubs? Why do you need IS_ENABLED()?
>
> This is because the entire block layer can be compiled as a
> module.
>
> In that case CONFIG_MMC_BLOCK contains 'm' instead of 'y'
> which confusingly does not evaluate to true in the preprocessor
> (it assumes it is a misspelled 'n' I guess).
>
> And then the autobuilders wreak havoc.
>
> And that is why the IS_ENABLED() defines exist in the first
> place IIUC.

Thanks for explanation! It makes more sense to me now!

>
> I'm all for making CONFIG_MMC_BLOCK into a bool... but
> don't know how people (Intel laptops) feel about that extra
> code in their kernel at all times.
>
>>>  void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
>>
>> I don't get what mmc_blk_issue_rq() has to do with this change? Could
>> you please explain?
>
> If we start doing stubs we should stub everything IMO, but if you
> prefer I can make that a separate patch. Seems a bit overdone
> though.
>
>> Hmm, this thing seems a bit upside-down.
>>
>> Currently it's possible to build the mmc block device driver as a
>> module. In cases like this, accessing the card debugs node to request
>> the card's status, would trigger a call to mmc_blk_card_status_get().
>> How would that work when the mmc block device driver isn't loaded and
>> probed?
>
> Module symbol resolution and driver loading is always necessary,
> it is no different for e.g. a wifi driver using the 802.11 library.
> It is definately possible to shoot oneself in the foot, but I think
> udev & friends usually load things in the right order?

My my point is that *if* the card debugfs nodes shows up to the user -
they should work (no matter if the mmc block device has been probed or
not).

Can we guarantee that, is this approach?

>
>> It seems like the life cycle of the card debugfs node is now being
>> controlled as when the mmc block device driver has been successfully
>> probed. We need to deal with that somehow.
>
> Only for these two files but yes.
>
> ext_csd is a bit dubious as it is only available on storage devices
> (eMMC) that can not be SD, SDIO or combo cards, and we could make
> it only appear if using the block layer.

Yes, that's a nice option.

>
> The card status however we need to keep if people want it.

Again, this is for debug purpose. I don't see an issue moving also
this one within CONFIG_MMC_BLOCK.

>
> We *COULD* consider just thrashing these debugfs files. It is not
> technically ABI and I wonder who is actually using them.

Right.

According to Avri, apparently some userspace tools measuring
performance. I would be interested to know a bit more about those
tools.

Kind regards
Uffe
