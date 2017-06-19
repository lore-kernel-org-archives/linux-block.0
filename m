Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/11] fs: add support for an inode to carry write hint
 related data
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-2-git-send-email-axboe@kernel.dk>
 <20170619062617.GB2311@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5a75b032-e4d7-2463-10dc-094ab9b01751@kernel.dk>
Date: Mon, 19 Jun 2017 08:55:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170619062617.GB2311@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 12:26 AM, Christoph Hellwig wrote:
>> +/*
>> + * Write life time hint values.
>> + */
>> +enum rw_hint {
>> +	WRITE_LIFE_NONE = 0,
>> +	WRITE_LIFE_SHORT,
>> +	WRITE_LIFE_MEDIUM,
>> +	WRITE_LIFE_LONG,
>> +	WRITE_LIFE_EXTREME,
>> +};
>> +
>> +#define RW_HINT_MASK		0x7	/* 3 bits */
> 
> FYI, exposing enums in a uapi is always a bit problematic, due to
> different ABI rules.  It might be better to make these explicit defines
> at least for the uapi.
> 
> Btw, I think it might make sense to merge this with patch 5.

OK, I'll change the uapi to be defines.

-- 
Jens Axboe
