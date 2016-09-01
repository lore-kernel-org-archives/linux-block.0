Return-Path: <prvs=8052912808=axboe@fb.com>
Subject: Re: [PATCH 2/8] writeback: add wbc_to_write_flags()
To: Omar Sandoval <osandov@osandov.com>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
 <1472663151-18560-3-git-send-email-axboe@fb.com>
 <20160831233258.GA24440@vader>
CC: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <774d1195-4a43-5395-14df-981336296720@fb.com>
Date: Wed, 31 Aug 2016 21:54:14 -0600
MIME-Version: 1.0
In-Reply-To: <20160831233258.GA24440@vader>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/31/2016 05:32 PM, Omar Sandoval wrote:
> On Wed, Aug 31, 2016 at 11:05:45AM -0600, Jens Axboe wrote:
>> Add wbc_to_write_flags(), which returns the write modifier flags to use,
>> based on a struct writeback_control. No functional changes in this
>> patch, but it prepares us for factoring other wbc fields for write type.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>
> [snip]
>
>> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
>> index fc1e16c25a29..e1fc25172397 100644
>> --- a/include/linux/writeback.h
>> +++ b/include/linux/writeback.h
>> @@ -100,6 +100,14 @@ struct writeback_control {
>>  #endif
>>  };
>>
>> +static inline int wbc_to_write_flags(struct writeback_control *wbc)
>> +{
>> +	if (wbc->sync_mode == WB_SYNC_ALL)
>> +		return WRITE_SYNC;
>> +
>> +	return WRITE;
>
> I think this should be `return 0;` after the op/flags split. WRITE == 1,
> so this would get interpreted as REQ_FAILFAST_DEV in bi_opf.

Good catch, thanks! Fixed up.

-- 
Jens Axboe
