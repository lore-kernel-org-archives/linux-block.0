Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:53126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeHVLCE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Aug 2018 07:02:04 -0400
Subject: Re: [PATCH 1/1] bcache: release the lock before stopping the
 writeback thread
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <1534921256-13009-1-git-send-email-shan.hai@oracle.com>
 <923bc64b-844f-7d72-c803-190e7e0565b1@suse.de>
From: Shan Hai <shan.hai@oracle.com>
Message-ID: <5334bbe9-9be4-937b-665d-d6e0a896ae61@oracle.com>
Date: Wed, 22 Aug 2018 15:38:00 +0800
MIME-Version: 1.0
In-Reply-To: <923bc64b-844f-7d72-c803-190e7e0565b1@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly,


On 2018年08月22日 15:29, Coly Li wrote:
> Hi Shan,
>
> On 2018/8/22 3:00 PM, Shan Hai wrote:
>> The writeback thread would exit with a lock held when the cache device is
>> detached via sysfs interface, fix it by releasing the held lock before exiting
>> the thread.
> I will change "the thread" to "the while-loop" when I apply this patch.

That's fine, your change is better.

>> Signed-off-by: Shan Hai <shan.hai@oracle.com>
> Nice catch!
>
> This one should go to stable trees since 4.17 as well. I will CC stable
> maintainers when I submit this one for 4.19.

OK, thanks for the quick response.

Regards
Shan Hai

> Thank you for the fix.
>
> Coly Li
>
>> ---
>>   drivers/md/bcache/writeback.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
>> index 481d4cf..adc583f 100644
>> --- a/drivers/md/bcache/writeback.c
>> +++ b/drivers/md/bcache/writeback.c
>> @@ -679,8 +679,10 @@ static int bch_writeback_thread(void *arg)
>>   			 * data on cache. BCACHE_DEV_DETACHING flag is set in
>>   			 * bch_cached_dev_detach().
>>   			 */
>> -			if (test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags))
>> +			if (test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags)) {
>> +				up_write(&dc->writeback_lock);
>>   				break;
>> +			}
>>   		}
>>   
>>   		up_write(&dc->writeback_lock);
>>
