Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH BUGFIX] block: add missing group association in bio_split
To: Jeff Moyer <jmoyer@redhat.com>
References: <1462567512-3007-1-git-send-email-paolo.valente@linaro.org>
 <x49bn4f71qi.fsf@segfault.boston.devel.redhat.com>
 <x4937pr70z5.fsf@segfault.boston.devel.redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 stable@vger.kernel.org
From: Paolo <paolo.valente@linaro.org>
Message-ID: <5730A108.1000703@linaro.org>
Date: Mon, 9 May 2016 16:39:04 +0200
MIME-Version: 1.0
In-Reply-To: <x4937pr70z5.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-ID: <linux-block@vger.kernel.org>

Il 09/05/2016 16:35, Jeff Moyer ha scritto:
> Jeff Moyer <jmoyer@redhat.com> writes:
>
>> Paolo Valente <paolo.valente@linaro.org> writes:
>>
>>> @@ -1811,6 +1811,11 @@ struct bio *bio_split(struct bio *bio, int sectors,
>>>
>>>   	bio_advance(bio, split->bi_iter.bi_size);
>>>
>>> +#ifdef CONFIG_BLK_CGROUP
>>> +	if (bio->bi_css)
>>> +		bio_associate_blkcg(split, bio->bi_css);
>>> +#endif
>>> +
>>>   	return split;
>>>   }
>>>   EXPORT_SYMBOL(bio_split);
>>
>> Get rid of the #ifdefery.  This should be just:
>>
>> bio_associate_blkcg(split, bio->bi_css);
>
> Gah, I see that the bi_css member is only present for CONFIG_BLK_CGROUP.
> I guess we'll have to live with the ifdef.
>

We have already tried to remove it, but it seems it would require other 
major changes.

Thanks,
Paolo

> -Jeff
>
