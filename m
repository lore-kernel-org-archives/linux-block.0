Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH BUGFIX V2] block: add missing group association in
 bio-cloning functions
To: Jeff Moyer <jmoyer@redhat.com>
References: <20160510204435.GN7110@mtj.duckdns.org>
 <1462914132-4479-1-git-send-email-paolo.valente@linaro.org>
 <x49eg9961hh.fsf@segfault.boston.devel.redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 stable@vger.kernel.org
From: Paolo <paolo.valente@linaro.org>
Message-ID: <57325656.9020808@linaro.org>
Date: Tue, 10 May 2016 23:44:54 +0200
MIME-Version: 1.0
In-Reply-To: <x49eg9961hh.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-ID: <linux-block@vger.kernel.org>

Il 10/05/2016 23:34, Jeff Moyer ha scritto:
> Paolo Valente <paolo.valente@linaro.org> writes:
>
>> diff --git a/block/bio.c b/block/bio.c
>> index 807d25e..e9b136a 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -622,6 +622,8 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
>>   		}
>>   	}
>>
>> +	bio_clone_blkcg_association(b, bio);
>> +
>>   	return b;
>>   }
>>   EXPORT_SYMBOL(bio_clone_fast);
>> @@ -695,6 +697,8 @@ integrity_clone:
>>   		}
>>   	}
>>
>> +	bio_clone_blkcg_association(bio, bio_src);
>> +
>>   	return bio;
>>   }
>>   EXPORT_SYMBOL(bio_clone_bioset);
>> @@ -1811,6 +1815,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
>>
>>   	bio_advance(bio, split->bi_iter.bi_size);
>>
>> +	bio_clone_blkcg_association(split, bio);
>> +
>
> Hi, Paolo,
>
> Did you test this?  bio_split calls bio_clone_bioset or bio_clone_fast,
> so I'd be surprised if you didn't trigger that newly added warning.  :-)

Of course I didn't check the kernel log ...

I hope next version will not introduce more bugs than it will fix.

Thanks,
Paolo
> Please remove the bio_split call site.
>
> Cheers,
> Jeff
>
