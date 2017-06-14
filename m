Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/11] block: add helpers for setting/checking stream
 validity
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-6-git-send-email-axboe@kernel.dk>
 <20170614202857.GC7022@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <64193609-980e-9b55-fe8a-18edbaea61fe@kernel.dk>
Date: Wed, 14 Jun 2017 14:39:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170614202857.GC7022@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 02:28 PM, Christoph Hellwig wrote:
>> +static const unsigned int rwf_write_to_opf_flag[] = {
>> +	0, REQ_WRITE_SHORT, REQ_WRITE_MEDIUM, REQ_WRITE_LONG, REQ_WRITE_EXTREME
>> +};
> 
> 
> 
>> +
>> +/*
>> + * 'stream_flags' is one of RWF_WRITE_LIFE_* values
>> + */
>> +void bio_set_streamid(struct bio *bio, unsigned int rwf_flags)
>> +{
>> +	if (WARN_ON_ONCE(rwf_flags >= ARRAY_SIZE(rwf_write_to_opf_flag)))
>> +		return;
>> +
>> +	bio->bi_opf |= rwf_write_to_opf_flag[rwf_flags];
>> +}
>> +EXPORT_SYMBOL_GPL(bio_set_streamid);
> 
> I'd move the bio->bi_opf assignment outş for a call like:
> 
> 	bio->bi_opf |= bio_op_write_bucket(flags);
> 
> and preferably move the flags masking / shifting into the helper as
> well.

OK, I can do that.

>> +static inline bool blk_stream_valid(unsigned int opf)
>> +{
>> +	return (opf & REQ_WRITE_LIFE_MASK) != 0;
>> +}
> 
> Replace the stream name here with lifetime or similar as well?

Yeah, I thought about that after sending v3 out. I should do that
everywhere.

-- 
Jens Axboe
