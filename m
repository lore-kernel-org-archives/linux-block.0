Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 6/6] sbitmap: make sb_for_each_fn() return void
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-7-git-send-email-axboe@kernel.dk>
 <1501876147.2757.30.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5994da31-ce96-86e8-b78f-0276d3be6890@kernel.dk>
Date: Fri, 4 Aug 2017 13:50:00 -0600
MIME-Version: 1.0
In-Reply-To: <1501876147.2757.30.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2017 01:49 PM, Bart Van Assche wrote:
> On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
>> @@ -211,7 +211,7 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb);
>>   */
>>  bool sbitmap_any_bit_clear(const struct sbitmap *sb);
>>  
>> -typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
>> +typedef void (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
>>  
>>  /**
>>   * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
>> @@ -241,9 +241,7 @@ static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
>>  			if (nr >= word->depth)
>>  				break;
>>  
>> -			if (!fn(sb, off + nr, data))
>> -				return;
>> -
>> +			fn(sb, off + nr, data);
>>  			nr++;
>>  		}
>>  	}
> 
> Hello Jens,
> 
> Are you aware that this change will break one of Ming Lei's patches? See
> also https://www.mail-archive.com/linux-block@vger.kernel.org/msg11230.html.

I wasn't, I'll just drop it for now then.

-- 
Jens Axboe
