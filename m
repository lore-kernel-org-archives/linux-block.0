Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 02/11] block: add definition for support data write life
 times
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-3-git-send-email-axboe@kernel.dk>
 <44670077-46FF-44C0-85DD-CA52BE2EB2E6@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7082c8f9-115b-5121-199f-facd0f4dea69@kernel.dk>
Date: Tue, 13 Jun 2017 14:10:09 -0600
MIME-Version: 1.0
In-Reply-To: <44670077-46FF-44C0-85DD-CA52BE2EB2E6@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 01:07 PM, Andreas Dilger wrote:
> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>> include/linux/blk_types.h | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 1940876a7fa7..16c4e657807f 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -314,6 +314,19 @@ struct blk_rq_stat {
>> 	u64 batch;
>> };
>>
>> +/*
>> + * Data life time definitions for writes. These are relative within a
>> + * given device, no absolute meaning is attached to them.
>> + */
>> +enum {
>> +	WRITE_LIFE_UNKNOWN	= 0,
>> +	WRITE_LIFE_SHORT,
>> +	WRITE_LIFE_MEDIUM,
>> +	WRITE_LIFE_LONG,
>> +	WRITE_LIFE_EXTREME,
>> +	WRITE_LIFE_NR,
>> +};
> 
> With the exception of these enums, there is actually enough space in the
> various structures to pass at least a 4-bit stream ID through the whole
> stack (actually, a full 32-bit stream ID, except for the debugfs stats).
> 
> I'm not necessarily against having some pre-defined meanings for these
> values, but with a few trivial changes to the code it would be possible
> to make this functionality much more flexible.

One thing I'm envisioning, down the line, is to have sets of streams. We
have the four streams, should be good enough for any app. But for multiple
apps, it becomes more difficult. So we could essentially shift the stream
ID up and share this space, and also utilize more streams on the back end
for that. For software caching solution, they can already factor in the
application, but for hardware devices, we could make use of that.

So I don't think there's anything wrong with the current approach. The
whole point was not to over-complicate or over-engineer this.

-- 
Jens Axboe
