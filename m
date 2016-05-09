Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH BUGFIX] block: add missing group association in bio_split
References: <1462567512-3007-1-git-send-email-paolo.valente@linaro.org>
	<x49bn4f71qi.fsf@segfault.boston.devel.redhat.com>
Date: Mon, 09 May 2016 10:35:58 -0400
In-Reply-To: <x49bn4f71qi.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
	message of "Mon, 09 May 2016 10:19:33 -0400")
Message-ID: <x4937pr70z5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jeff Moyer <jmoyer@redhat.com> writes:

> Paolo Valente <paolo.valente@linaro.org> writes:
>
>> @@ -1811,6 +1811,11 @@ struct bio *bio_split(struct bio *bio, int sectors,
>>  
>>  	bio_advance(bio, split->bi_iter.bi_size);
>>  
>> +#ifdef CONFIG_BLK_CGROUP
>> +	if (bio->bi_css)
>> +		bio_associate_blkcg(split, bio->bi_css);
>> +#endif
>> +
>>  	return split;
>>  }
>>  EXPORT_SYMBOL(bio_split);
>
> Get rid of the #ifdefery.  This should be just:
>
> bio_associate_blkcg(split, bio->bi_css);

Gah, I see that the bi_css member is only present for CONFIG_BLK_CGROUP.
I guess we'll have to live with the ifdef.

-Jeff
