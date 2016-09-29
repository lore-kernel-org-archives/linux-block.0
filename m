Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0068.outbound.protection.outlook.com ([104.47.40.68]:2661
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754821AbcI2PsR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 11:48:17 -0400
Subject: Re: [PATCH] blkcg: Unlock blkcg_pol_mutex once if cpd == NULL
To: Tejun Heo <tj@kernel.org>
References: <db0c6205-9ca2-d80e-26fc-6cff0d84d73c@sandisk.com>
 <20160929100352.GC24034@mtj.duckdns.org>
CC: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <f068d439-4769-5fb5-f64a-0eed54bfe576@sandisk.com>
Date: Thu, 29 Sep 2016 08:32:26 -0700
MIME-Version: 1.0
In-Reply-To: <20160929100352.GC24034@mtj.duckdns.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/29/2016 03:03 AM, Tejun Heo wrote:
> Hello,
>
> On Mon, Sep 26, 2016 at 03:36:25PM -0700, Bart Van Assche wrote:
>> Unlocking a mutex twice is wrong. Hence modify blkcg_policy_register()
>> such that blkcg_pol_mutex is unlocked once if cpd == NULL. This patch
>> avoids that smatch reports the following error:
>>
>> block/blk-cgroup.c:1378: blkcg_policy_register() error: double unlock 'mutex:&blkcg_pol_mutex'
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  block/blk-cgroup.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index dd38e5c..cdbca1c 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1327,8 +1327,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
>>  	for (i = 0; i < BLKCG_MAX_POLS; i++)
>>  		if (!blkcg_policy[i])
>>  			break;
>> -	if (i >= BLKCG_MAX_POLS)
>> +	if (i >= BLKCG_MAX_POLS) {
>> +		mutex_unlock(&blkcg_pol_mutex);
>>  		goto err_unlock;
>> +	}
>
> Wouldn't it be better to drop explicit mutx_unlock(&blkcg_pol_mutex)
> on "if (!cpd)"?

Agreed. I will rework this patch accordingly. Thanks for the feedback.

Bart.
