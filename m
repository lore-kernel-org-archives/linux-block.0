Subject: Re: [PATCH] lightnvm: assume 64-bit lba numbers
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>,
 Arnd Bergmann <arnd@arndb.de>, Matias Bjorling <mb@lightnvm.io>
References: <20170419173931.3902058-1-arnd@arndb.de>
 <0c7f0894-4817-09c4-93b9-8158bbc6a562@cnexlabs.com>
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <b6ea0f56-c4cf-fab9-5e67-eb2c292bd9f3@fb.com>
Date: Wed, 19 Apr 2017 12:08:03 -0600
MIME-Version: 1.0
In-Reply-To: <0c7f0894-4817-09c4-93b9-8158bbc6a562@cnexlabs.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/19/2017 12:04 PM, Matias Bj�rling wrote:
> On 04/19/2017 07:39 PM, Arnd Bergmann wrote:
>> The driver uses both u64 and sector_t to refer to offsets, and assigns between the
>> two. This causes one harmless warning when sector_t is 32-bit:
>>
>> drivers/lightnvm/pblk-rb.c: In function 'pblk_rb_write_entry_gc':
>> include/linux/lightnvm.h:215:20: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>> drivers/lightnvm/pblk-rb.c:324:22: note: in expansion of macro 'ADDR_EMPTY'
>>
>> As the driver is already doing this inconsistently, changing the type
>> won't make it worse and is an easy way to avoid the warning.
>>
>> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/lightnvm/pblk.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index c82120ce3be5..11ed7d83f572 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -119,7 +119,7 @@ struct pblk_w_ctx {
>>  	struct bio_list bios;		/* Original bios - used for completion
>>  					 * in REQ_FUA, REQ_FLUSH case
>>  					 */
>> -	sector_t lba;			/* Logic addr. associated with entry */
>> +	u64 lba;			/* Logic addr. associated with entry */
>>  	struct ppa_addr ppa;		/* Physic addr. associated with entry */
>>  	int flags;			/* Write context flags */
>>  };
>>
> 
> Thanks Arnd. Jens, could you pick this up? Thank you

Done, thanks Arnd.

-- 
Jens Axboe
